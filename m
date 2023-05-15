Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8FC703527
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:56:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pybTy-0000Oo-7Y; Mon, 15 May 2023 12:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1pybTv-0000Of-Ej
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:55:31 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1pybTt-0004XW-3V
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:55:31 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-966287b0f72so1987234766b.0
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 09:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1684169727; x=1686761727;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/3FFQj0JjK37McPKLf6h6USHAHVK6REU8xkuSPpXYyw=;
 b=kRMHwc6C+Pzks4qkcxIUqEkYRlvBzrWsDA6jCD4G3BVv2mfJJutk4VoRUwG6imsOp3
 SMxM07WGJ+36H8TdMr8oZ49g6lMkSYdzu4qegREqxGq1Gwy9NmhQ72VIkvXqEgJufw5m
 Uos7bRb7JgdLcnpmIxrEo1V5YNZud1Ewnv7510UUmtIfF5h4JEQugNoi5gz4w7iRiNwo
 Fh8WLQFrW88wdVz50APHXo4A/HAqJrfXt+tI/VhLHToCNG1U2p0XAVKDtN7GXF2VxXUS
 sKGK6I5guS2dcwBCEZA6xY8sT++X7SoJ4bH0/27o3tosCWD4E1A8kJnuqubEPMkOvg17
 4fMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684169727; x=1686761727;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/3FFQj0JjK37McPKLf6h6USHAHVK6REU8xkuSPpXYyw=;
 b=NiWH+xq1veYDAXs07vQTV4sozfgBM8BXWCoU3PQUVr80DT+tC9Vtt+VEvjojwEdigS
 N4uTBE3trpCikoPJ40Ik+Gx2WuFm5YsZSHB+jYXpnKlrFud9iYXWCING2+DB62+lNUck
 teJdOEXsoRynUbYDsRl10T21oqnTlAQxGjwx5KWwi0TnbpDU89zcFUwHdRQYcE5YhxFB
 TmRtHR8q9WHIZcOvKwLaAWPN50mrrt1sh3rzlR0Vo24mj4B8Qh5VKGbG7MchnRwfx/IU
 jNHHtcbSrYSJIayQo28gWOQp9otQzKMZP3h7sPCNH0vyHkebkP41uc+Hcz16+Rj7rweF
 Szow==
X-Gm-Message-State: AC+VfDw/bUmS6FmrsjH8s2B7ulc6Y+BF34fiGTFH98GC4XyYj6Jfeial
 /VBfCYhSBhbNno5rLwi98fWFHbM+TihkEYE8TRBOPA==
X-Google-Smtp-Source: ACHHUZ6UQO5L1R8bysQuWYYM6TZ6IXXJLXvkoJmL2FdCFI7mYj2PxnJeZ0SBwolriMMQtFRiUs6U9/gkHUola9K+qlc=
X-Received: by 2002:a17:907:8691:b0:96a:b504:58ad with SMTP id
 qa17-20020a170907869100b0096ab50458admr9205337ejc.5.1684169727122; Mon, 15
 May 2023 09:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230511084505.13282-1-quintela@redhat.com>
In-Reply-To: <20230511084505.13282-1-quintela@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 15 May 2023 10:55:16 -0600
Message-ID: <CANCZdfpqJ44Tx3GitSnmn+Mq6CEzOcw9BvrE_KxKtAArfMyi5g@mail.gmail.com>
Subject: Re: [PATCH] ARM: Use normal types
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000053b0be05fbbe52eb"
Received-SPF: none client-ip=2a00:1450:4864:20::635;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000053b0be05fbbe52eb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 2:45=E2=80=AFAM Juan Quintela <quintela@redhat.com>=
 wrote:

> This is the only use of u_int32_t in the whole tree.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

I'll queue this version if others don't beat me to it. I plan on merging
that around June 1st.

Warner


> ---
>  bsd-user/arm/target_arch_reg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bsd-user/arm/target_arch_reg.h
> b/bsd-user/arm/target_arch_reg.h
> index 070fa24da1..fe9e6584e6 100644
> --- a/bsd-user/arm/target_arch_reg.h
> +++ b/bsd-user/arm/target_arch_reg.h
> @@ -32,7 +32,7 @@ typedef struct target_reg {
>  typedef struct target_fp_reg {
>      uint32_t        fp_exponent;
>      uint32_t        fp_mantissa_hi;
> -    u_int32_t       fp_mantissa_lo;
> +    uint32_t        fp_mantissa_lo;
>  } target_fp_reg_t;
>
>  typedef struct target_fpreg {
> --
> 2.40.1
>
>

--00000000000053b0be05fbbe52eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 11, 2023 at 2:45=E2=80=AF=
AM Juan Quintela &lt;<a href=3D"mailto:quintela@redhat.com">quintela@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">This is the only use of u_int32_t in the whole tree.<br>
<br>
Signed-off-by: Juan Quintela &lt;<a href=3D"mailto:quintela@redhat.com" tar=
get=3D"_blank">quintela@redhat.com</a>&gt;<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br></blockqu=
ote><div><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@=
bsdimp.com">imp@bsdimp.com</a>&gt;</div><div><br></div><div>I&#39;ll queue =
this version if others don&#39;t beat me to it. I plan on merging that arou=
nd June 1st.</div><div><br></div><div>Warner</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0bsd-user/arm/target_arch_reg.h | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/bsd-user/arm/target_arch_reg.h b/bsd-user/arm/target_arch_reg.=
h<br>
index 070fa24da1..fe9e6584e6 100644<br>
--- a/bsd-user/arm/target_arch_reg.h<br>
+++ b/bsd-user/arm/target_arch_reg.h<br>
@@ -32,7 +32,7 @@ typedef struct target_reg {<br>
=C2=A0typedef struct target_fp_reg {<br>
=C2=A0 =C2=A0 =C2=A0uint32_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 fp_exponent;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 fp_mantissa_hi;<br>
-=C2=A0 =C2=A0 u_int32_t=C2=A0 =C2=A0 =C2=A0 =C2=A0fp_mantissa_lo;<br>
+=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 fp_mantissa_lo;<br>
=C2=A0} target_fp_reg_t;<br>
<br>
=C2=A0typedef struct target_fpreg {<br>
-- <br>
2.40.1<br>
<br>
</blockquote></div></div>

--00000000000053b0be05fbbe52eb--

