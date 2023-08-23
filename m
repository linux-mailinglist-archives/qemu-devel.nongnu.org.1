Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4523478546C
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 11:41:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYkLS-0000Du-4P; Wed, 23 Aug 2023 05:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qYkLC-0000Cq-Th; Wed, 23 Aug 2023 05:39:55 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qYkLA-0000CH-K2; Wed, 23 Aug 2023 05:39:54 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-79ddb7fae73so1389073241.3; 
 Wed, 23 Aug 2023 02:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692783590; x=1693388390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3TW8sHLlQfIFnuvPvTy7XQ76IwAXju7cnuNI1015O+A=;
 b=BW/3PlJCNYRK+gbtcilHgRz5yZuMG+DKKRysTmz/wq22tGx4HH1DtzUmX520xL2enF
 a4UHqo3sthTFy6/knr8a6idQXSrtITTqF6pI3EjjFPS1KvPTdyibIhyrDF+UlJUJ9wsK
 /z81pSPn+rwjXJ6bgch/WB1K0q/QKOeLK97KqZMXFX7dmb46mnyoEt3OKIRd50Pm/v+6
 DP/V4FOax+/woAt64dwWOPG52xuNi0FbAV9tYUhrfvdraA6VfhPEaRDREyKHyozmX7Kn
 UhUDk5eqGoa4Srzh9w6OWHh9NUtlLSBgd32JnmeqDSWRNj+WIPW64SwTh00d4eDUZtjd
 cuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692783590; x=1693388390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3TW8sHLlQfIFnuvPvTy7XQ76IwAXju7cnuNI1015O+A=;
 b=ZgSEZmd4e9TTfF34+WR3RNj1YrJ715sFbI5nT+q61m0ipBu3ssyeJC7yp4BgBjDWCr
 6SzV16LswTZbJSdZfOzqGzJZDsR7K98+l41amngjrKJze46al/sEmtPwUMnuy/oUVJ+Y
 D2cGBZuOD53m4j79nJ/hP2VvCRy2yhleKX60b2v1IsLqzggNjUgRcQjgbRxAM8aUKCFG
 Zj9Xba+5kZyFilcEoPPs5UYW+zyxdXjZhuidy856uW//yRoIKFkbHjizBO4ycH6/8A3w
 0OoTCRogVsn1/gelOkBnTI9TE84ibrv21T0jnc4W9VuyHc4IH4Dx42tUdeZGq9NsiUhE
 5gKA==
X-Gm-Message-State: AOJu0YwJgCL7FCYMIGqcg6yhMIQFGRsyRk1GxP3q78iQlKAfG9fZM0co
 LIxeyCZGkQMGvRT7O2g/87xjssqwPHN6t4aFU6w=
X-Google-Smtp-Source: AGHT+IFlrzw+rQhrya4KKH2oM9Soc8IJZkcOcOBuHgt+1s0qwJqb2OM2g2w0z5s2H3/CcX/Rj0WV8DuYp6rlb727e4c=
X-Received: by 2002:a67:de98:0:b0:44d:5435:a3e with SMTP id
 r24-20020a67de98000000b0044d54350a3emr5870235vsk.9.1692783590217; Wed, 23 Aug
 2023 02:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230815195741.8325-1-richard.henderson@linaro.org>
 <20230815195741.8325-6-richard.henderson@linaro.org>
In-Reply-To: <20230815195741.8325-6-richard.henderson@linaro.org>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Wed, 23 Aug 2023 19:39:38 +1000
Message-ID: <CACzsE9rXZdXuEBqcF-fBwmBiMzavCJ7czWufT+tzwf4teNe9uw@mail.gmail.com>
Subject: Re: [PATCH v3 05/14] tcg/ppc: Use ADDPCIS in tcg_out_tb_start
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000956d0a060393e4b1"
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=jniethe5@gmail.com; helo=mail-ua1-x932.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000956d0a060393e4b1
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Aug 2023, 5:57 am Richard Henderson, <
richard.henderson@linaro.org> wrote:

> With ISA v3.0, we can use ADDPCIS instead of BCL+MFLR to load NIP.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/ppc/tcg-target.c.inc | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 19004fa568..36b4f61236 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -362,6 +362,7 @@ static bool tcg_target_const_match(int64_t val,
> TCGType type, int ct)
>  #define CRNAND XO19(225)
>  #define CROR   XO19(449)
>  #define CRNOR  XO19( 33)
> +#define ADDPCIS XO19( 2)
>
>  #define EXTSB  XO31(954)
>  #define EXTSH  XO31(922)
> @@ -854,6 +855,19 @@ static inline void tcg_out_sari64(TCGContext *s,
> TCGReg dst, TCGReg src, int c)
>      tcg_out32(s, SRADI | RA(dst) | RS(src) | SH(c & 0x1f) | ((c >> 4) &
> 2));
>  }
>
> +static void tcg_out_addpcis(TCGContext *s, TCGReg dst, intptr_t imm)
> +{
> +    int d0, d1, d2;
> +
> +    tcg_debug_assert((imm & 0xffff) == 0);
> +    tcg_debug_assert(imm == (int32_t)imm);
> +
>

I think you need imm >>= 16 here.
Without that the next patch in the series crashes.

+    d2 = imm & 1;
> +    d1 = (imm >> 1) & 0x1f;
> +    d0 = (imm >> 6) & 0x3ff;
> +    tcg_out32(s, ADDPCIS | RT(dst) | (d1 << 16) | (d0 << 6) | d2);
> +}
> +
>  static void tcg_out_bswap16(TCGContext *s, TCGReg dst, TCGReg src, int
> flags)
>  {
>      TCGReg tmp = dst == src ? TCG_REG_R0 : dst;
> @@ -2489,9 +2503,14 @@ static void tcg_out_tb_start(TCGContext *s)
>  {
>      /* Load TCG_REG_TB. */
>      if (USE_REG_TB) {
> -        /* bcl 20,31,$+4 (preferred form for getting nia) */
> -        tcg_out32(s, BC | BO_ALWAYS | BI(7, CR_SO) | 0x4 | LK);
> -        tcg_out32(s, MFSPR | RT(TCG_REG_TB) | LR);
> +        if (have_isa_3_00) {
> +            /* lnia REG_TB */
> +            tcg_out_addpcis(s, TCG_REG_TB, 0);
> +        } else {
> +            /* bcl 20,31,$+4 (preferred form for getting nia) */
> +            tcg_out32(s, BC | BO_ALWAYS | BI(7, CR_SO) | 0x4 | LK);
> +            tcg_out32(s, MFSPR | RT(TCG_REG_TB) | LR);
> +        }
>      }
>  }
>
> --
> 2.34.1
>
>

--000000000000956d0a060393e4b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, 16 Aug 2023, 5:57 am Richard Henderson, &lt;<a=
 href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">With ISA v3.0, we ca=
n use ADDPCIS instead of BCL+MFLR to load NIP.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank" rel=3D"noreferrer">richard.henderson@linaro.org=
</a>&gt;<br>
---<br>
=C2=A0tcg/ppc/tcg-target.c.inc | 25 ++++++++++++++++++++++---<br>
=C2=A01 file changed, 22 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc<br>
index 19004fa568..36b4f61236 100644<br>
--- a/tcg/ppc/tcg-target.c.inc<br>
+++ b/tcg/ppc/tcg-target.c.inc<br>
@@ -362,6 +362,7 @@ static bool tcg_target_const_match(int64_t val, TCGType=
 type, int ct)<br>
=C2=A0#define CRNAND XO19(225)<br>
=C2=A0#define CROR=C2=A0 =C2=A0XO19(449)<br>
=C2=A0#define CRNOR=C2=A0 XO19( 33)<br>
+#define ADDPCIS XO19( 2)<br>
<br>
=C2=A0#define EXTSB=C2=A0 XO31(954)<br>
=C2=A0#define EXTSH=C2=A0 XO31(922)<br>
@@ -854,6 +855,19 @@ static inline void tcg_out_sari64(TCGContext *s, TCGRe=
g dst, TCGReg src, int c)<br>
=C2=A0 =C2=A0 =C2=A0tcg_out32(s, SRADI | RA(dst) | RS(src) | SH(c &amp; 0x1=
f) | ((c &gt;&gt; 4) &amp; 2));<br>
=C2=A0}<br>
<br>
+static void tcg_out_addpcis(TCGContext *s, TCGReg dst, intptr_t imm)<br>
+{<br>
+=C2=A0 =C2=A0 int d0, d1, d2;<br>
+<br>
+=C2=A0 =C2=A0 tcg_debug_assert((imm &amp; 0xffff) =3D=3D 0);<br>
+=C2=A0 =C2=A0 tcg_debug_assert(imm =3D=3D (int32_t)imm);<br>
+<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>I think you need imm &gt;&gt;=3D 16 here.</div><div dir=3D"auto">Without t=
hat the next patch in the series crashes.=C2=A0</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">
+=C2=A0 =C2=A0 d2 =3D imm &amp; 1;<br>
+=C2=A0 =C2=A0 d1 =3D (imm &gt;&gt; 1) &amp; 0x1f;<br>
+=C2=A0 =C2=A0 d0 =3D (imm &gt;&gt; 6) &amp; 0x3ff;<br>
+=C2=A0 =C2=A0 tcg_out32(s, ADDPCIS | RT(dst) | (d1 &lt;&lt; 16) | (d0 &lt;=
&lt; 6) | d2);<br>
+}<br>
+<br>
=C2=A0static void tcg_out_bswap16(TCGContext *s, TCGReg dst, TCGReg src, in=
t flags)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0TCGReg tmp =3D dst =3D=3D src ? TCG_REG_R0 : dst;<br>
@@ -2489,9 +2503,14 @@ static void tcg_out_tb_start(TCGContext *s)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0/* Load TCG_REG_TB. */<br>
=C2=A0 =C2=A0 =C2=A0if (USE_REG_TB) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* bcl 20,31,$+4 (preferred form for getting n=
ia) */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_out32(s, BC | BO_ALWAYS | BI(7, CR_SO) | 0=
x4 | LK);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_out32(s, MFSPR | RT(TCG_REG_TB) | LR);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (have_isa_3_00) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* lnia REG_TB */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_out_addpcis(s, TCG_REG_TB, 0=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* bcl 20,31,$+4 (preferred form=
 for getting nia) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_out32(s, BC | BO_ALWAYS | BI=
(7, CR_SO) | 0x4 | LK);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_out32(s, MFSPR | RT(TCG_REG_=
TB) | LR);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div></div>

--000000000000956d0a060393e4b1--

