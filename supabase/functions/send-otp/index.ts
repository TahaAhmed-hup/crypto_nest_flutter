import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

const RESEND_API_KEY = Deno.env.get("RESEND_API_KEY")!;
const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;

const jsonHeaders = {
  "Content-Type": "application/json",
};

function generateOtp() {
  return Math.floor(1000 + Math.random() * 9000).toString();
}

serve(async (req: Request) => {
  try {
    let email: string;

    try {
      const body = await req.json();
      email = String(body.email ?? "").trim().toLowerCase();

    } catch {
      return new Response(
        JSON.stringify({ error: "Invalid JSON body" }),
        { status: 400, headers: jsonHeaders }
      );
    }

    if (!email || !email.includes("@")) {
      return new Response(
        JSON.stringify({ error: "Valid email is required" }),
        { status: 400, headers: jsonHeaders }
      );
    }

    const otp = generateOtp();
    const expiresAt = new Date(Date.now() + 2 * 60 * 1000).toISOString();

    const insertRes = await fetch(`${SUPABASE_URL}/rest/v1/email_otps`, {
      method: "POST",
      headers: {
        "apikey": SUPABASE_SERVICE_ROLE_KEY,
        "Authorization": `Bearer ${SUPABASE_SERVICE_ROLE_KEY}`,
        "Content-Type": "application/json",
        "Prefer": "return=minimal",
      },
      body: JSON.stringify({
        email,
        otp,
        expires_at: expiresAt,
        is_used: false,
      }),
    });

    if (!insertRes.ok) {
      const err = await insertRes.text();
      return new Response(
        JSON.stringify({ error: "Failed to save OTP", details: err }),
        { status: 500, headers: jsonHeaders }
      );
    }

    const resendRes = await fetch("https://api.resend.com/emails", {
      method: "POST",
      headers: {
        "Authorization": `Bearer ${RESEND_API_KEY}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        from: "CryptoNest <delivered@resend.dev>",
        to: [email],
        subject: "Your CryptoNest Verification Code",
        html: `
          <div style="font-family: Arial, sans-serif; text-align: center; padding: 40px; background: #000; color: #fff; border-radius: 12px;">
            <h2 style="color: #FFD700;">CryptoNest</h2>
            <p style="font-size: 18px;">Your verification code is</p>
            <h1 style="font-size: 56px; letter-spacing: 16px; color: #FFD700;">${otp}</h1>
            <p style="color: #aaa;">This code expires in 2 minutes.</p>
          </div>
        `,
      }),
    });

    if (!resendRes.ok) {
      const err = await resendRes.json().catch(() => ({}));
      return new Response(
        JSON.stringify({ success: true, otp_for_test: otp, email_error: err }),
        { status: 200, headers: jsonHeaders }
      );
    }

    return new Response(
      JSON.stringify({ success: true }),
      { status: 200, headers: jsonHeaders }
    );

  } catch (e: any) {
    return new Response(
      JSON.stringify({ error: "Server error", message: e.message }),
      { status: 500, headers: jsonHeaders }
    );
  }
});
