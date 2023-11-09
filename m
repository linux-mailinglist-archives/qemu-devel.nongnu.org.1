Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 154097E6DFE
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 16:48:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r17FP-0002PK-OC; Thu, 09 Nov 2023 10:47:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1r17FK-0002My-FS; Thu, 09 Nov 2023 10:47:06 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1r17F5-0006MK-1x; Thu, 09 Nov 2023 10:47:06 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-53e70b0a218so1635472a12.2; 
 Thu, 09 Nov 2023 07:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699544808; x=1700149608; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E7vJXSBetClD/gOUlPRTJf1R7+Q0EPYGlWm8oFc/t4Q=;
 b=IXl8qbr9h8JnCaAGbwW95r684Dtliu4KCALtlM3iYjcvqAK+vmYSfr9jF3Z0s3uAQb
 cPuqiofn3OaseAf+E471NAZWD7K8bOpHIksC/wl8Ikm5Y+jiPQ2huMoJVb3OnsEfMefX
 ee0OkPYZhFGmxB4wjZVHp4OwnlBvulUYLneaROmbHS1dJJKM8s7KpZ6AoiAcqHXmH3wl
 IpIfmqDCCvmZ5on5fVm61bqfTH2HxoSNXvy21le9x9ivQrUEXCbGKi4YLIGrtVJVpM1g
 KwmckVak6I4wNwRR0b0FMzcSRvsVlMxlfyQDA/lHITF/65OwhvhdLb9HQ6Ct7CXVOKuL
 nFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699544808; x=1700149608;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E7vJXSBetClD/gOUlPRTJf1R7+Q0EPYGlWm8oFc/t4Q=;
 b=Z6XWhnVy5F9t86zAGLLwd9vO7nTeiTaqTTrBJ3OBsV4qsuLswfe4WS1CS0lj+t5EZ4
 WrRWKtHbP+3OBCZ0IMrjlzptsipfP7YR0Hul8vp3HOOZ+28BV150MQWrQe4pUk98BFPu
 fILy6wbwm2Hjm179fGdkMlEKGH7bc/cQP/ATYvtL4IG0vkfwvesAUZVgZaqP5T3zD/4s
 GMYD3kmOjgmZhpVhzILyU50YYEbhwdjlin6j4jHlNrN2EgAJQcHjIdvkN4XB4wqr0AXN
 Hb8rWOmzLOAuT1r27BPuy8Z9g6TTflvSHDc/FRiTf/nckhmLE1mj7KEPJM5hT4famvMv
 IcuQ==
X-Gm-Message-State: AOJu0YxrbNKhe+XcD1082GlJk7k9yL9DwcSaaRal2LhZE6wKPOs3rzbq
 4sHjkv9d2BoI1C3LEMqxcGyyB4Bs8JaJV12FERg=
X-Google-Smtp-Source: AGHT+IGZfWVBeM8Cn7YNpZXKITecEFsKEdMzBICXqVlvmQdx6phTb1nZy25kUwtzj/UM6+NUSDwP5QVmO0SWJHKoEYs=
X-Received: by 2002:a50:8a81:0:b0:53e:1b:15f5 with SMTP id
 j1-20020a508a81000000b0053e001b15f5mr4562023edj.39.1699544807820; 
 Thu, 09 Nov 2023 07:46:47 -0800 (PST)
MIME-Version: 1.0
References: <20231109151917.1925107-1-peter.maydell@linaro.org>
In-Reply-To: <20231109151917.1925107-1-peter.maydell@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 9 Nov 2023 16:46:36 +0100
Message-ID: <CAJy5ezoyaWH0fzdjO-W6tS3RjJtOytr2CVT7uUkwhg=VOUYaEg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: HVC at EL3 should go to EL3, not EL2
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000008cd5400609ba1cd6"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--0000000000008cd5400609ba1cd6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 4:20=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org>
wrote:

> AArch64 permits code at EL3 to use the HVC instruction; however the
> exception we take should go to EL3, not down to EL2 (see the pseudocode
> AArch64.CallHypervisor()). Fix the target EL.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>

Reviewed-by: Edgar E. Iglesias <edgar@zeroasic.com>



> ---
>  target/arm/tcg/translate-a64.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/tcg/translate-a64.c
> b/target/arm/tcg/translate-a64.c
> index 41484d8ae54..a2e49c39f9f 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -2351,6 +2351,8 @@ static bool trans_SVC(DisasContext *s, arg_i *a)
>
>  static bool trans_HVC(DisasContext *s, arg_i *a)
>  {
> +    int target_el =3D s->current_el =3D=3D 3 ? 3 : 2;
> +
>      if (s->current_el =3D=3D 0) {
>          unallocated_encoding(s);
>          return true;
> @@ -2363,7 +2365,7 @@ static bool trans_HVC(DisasContext *s, arg_i *a)
>      gen_helper_pre_hvc(tcg_env);
>      /* Architecture requires ss advance before we do the actual work */
>      gen_ss_advance(s);
> -    gen_exception_insn_el(s, 4, EXCP_HVC, syn_aa64_hvc(a->imm), 2);
> +    gen_exception_insn_el(s, 4, EXCP_HVC, syn_aa64_hvc(a->imm),
> target_el);
>      return true;
>  }
>
> --
> 2.34.1
>
>
>

--0000000000008cd5400609ba1cd6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 9, 2023 at 4:20=E2=80=AFPM Pe=
ter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@l=
inaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">AArch64 permits code at EL3 to use the HVC instruction; however =
the<br>
exception we take should go to EL3, not down to EL2 (see the pseudocode<br>
AArch64.CallHypervisor()). Fix the target EL.<br>
<br>
Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-stable=
@nongnu.org</a><br>
Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org=
" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar@ze=
roasic.com">edgar@zeroasic.com</a>&gt;<br></div><div><br></div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0target/arm/tcg/translate-a64.c | 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.=
c<br>
index 41484d8ae54..a2e49c39f9f 100644<br>
--- a/target/arm/tcg/translate-a64.c<br>
+++ b/target/arm/tcg/translate-a64.c<br>
@@ -2351,6 +2351,8 @@ static bool trans_SVC(DisasContext *s, arg_i *a)<br>
<br>
=C2=A0static bool trans_HVC(DisasContext *s, arg_i *a)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 int target_el =3D s-&gt;current_el =3D=3D 3 ? 3 : 2;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;current_el =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unallocated_encoding(s);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
@@ -2363,7 +2365,7 @@ static bool trans_HVC(DisasContext *s, arg_i *a)<br>
=C2=A0 =C2=A0 =C2=A0gen_helper_pre_hvc(tcg_env);<br>
=C2=A0 =C2=A0 =C2=A0/* Architecture requires ss advance before we do the ac=
tual work */<br>
=C2=A0 =C2=A0 =C2=A0gen_ss_advance(s);<br>
-=C2=A0 =C2=A0 gen_exception_insn_el(s, 4, EXCP_HVC, syn_aa64_hvc(a-&gt;imm=
), 2);<br>
+=C2=A0 =C2=A0 gen_exception_insn_el(s, 4, EXCP_HVC, syn_aa64_hvc(a-&gt;imm=
), target_el);<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div></div>

--0000000000008cd5400609ba1cd6--

