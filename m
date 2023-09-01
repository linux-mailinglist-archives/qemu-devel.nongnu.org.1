Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C02790053
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 18:00:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc6ZF-0006dZ-Nr; Fri, 01 Sep 2023 12:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1qc6Z1-00062P-29
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 12:00:03 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1qc6Yy-0000pL-Ak
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 12:00:02 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-99c1f6f3884so261526466b.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 08:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693583998; x=1694188798; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x3Nm17aTfCwkJZeDccSK8FwpD8S4evKrU0hrdJd3aLg=;
 b=friw99jNUfc031tyv0cqHp2d45awWV4d8MI8v86o0R+nscJcKsI7t1hnzJrYf3iqbg
 EoYtokWmReCUBzfImK9sj3WGpkC67HffpeugwYMCmhpjGPLi9TQrSFPpB+8+ZVN6slfp
 f0bd22V+wYjax8yOEl1o9GqaZAxCNYkbx4wpVN6LsDJmkP1wMAtBP+NMr9dBGxIrL6Ap
 1j3pfva7rzMbgsU7MmMyl7eYMJvyuFZDebSmneLrPt0NQDoGr9OaUMbtF+ZxfCqLBFEz
 BB/5bTy6EYB8cyttZWepfpxVw/KilMFL04Wd8tBJixKYU/7qiIdw0Soo/gilU2SPv90z
 0vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693583998; x=1694188798;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x3Nm17aTfCwkJZeDccSK8FwpD8S4evKrU0hrdJd3aLg=;
 b=PwjLUzIDYPiTWAHvdBYb9bghE3BVjeqECRcsNRGiHUMNPYj4fz4Bp2HXGWwa1niIds
 +lCmgEuDt9fNOkE8Oq27r3Z0sGV/Gq8YiKtR8tgRwH7wUDHt6g7l8gl2WFvIa4rxc9nG
 n6CH/Gr+soo5/AlPjmNhg9sAyHnGINWmPLUb4MZicYtKQyJ7MG4oe4Nrk8pgebpQpudW
 XWjaHnwcSI9PWQAPZ9wPOH1iCa2WlyGDy6aPsJei7GU/T3WY3jAScgBkMjNa1vMd+WqQ
 6IwHcpWF10fYI6DSFTnF23fPKbHEGhmtILeWBZy6uKbZwlAgcwdABh+40z74qiO3WTF9
 4jFQ==
X-Gm-Message-State: AOJu0YygcBCp7XEof/bOy/NuIo4/yy7urV5XzVKhRVvPybbBohi0EYxM
 TaIU74LjIyz7O4boAk/iZamaUSY9c7CwlhRjdnbhfOtrNk1wFQ==
X-Google-Smtp-Source: AGHT+IFd/8c0vqvGKFtoucUO77RfBKtw7fDTrLoaTv/+FaaoOJU6htJLlmjOs2+jo0tfD1IyJ5WhoC3aSbu6MB0KKxQ=
X-Received: by 2002:a17:906:10dd:b0:9a5:c9a4:ba1a with SMTP id
 v29-20020a17090610dd00b009a5c9a4ba1amr1983435ejv.59.1693583998028; Fri, 01
 Sep 2023 08:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230823145542.79633-1-philmd@linaro.org>
 <20230823145542.79633-9-philmd@linaro.org>
In-Reply-To: <20230823145542.79633-9-philmd@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri, 1 Sep 2023 17:59:46 +0200
Message-ID: <CAJy5ezrEv6ufN9S6BVvd06CazG_AoU2gfq2=H1Hq6-H4Yd1=6Q@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] target/cris: Fix a typo in gen_swapr()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000998fb706044e405d"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000998fb706044e405d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 4:56=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>

Reviewed-by: Edgar E. Iglesias <edgar@zeroasic.com>


> ---
>  target/cris/translate.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/target/cris/translate.c b/target/cris/translate.c
> index 0b3d724281..42103b5558 100644
> --- a/target/cris/translate.c
> +++ b/target/cris/translate.c
> @@ -411,15 +411,17 @@ static inline void t_gen_swapw(TCGv d, TCGv s)
>      tcg_gen_or_tl(d, d, t);
>  }
>
> -/* Reverse the within each byte.
> -   T0 =3D (((T0 << 7) & 0x80808080) |
> -   ((T0 << 5) & 0x40404040) |
> -   ((T0 << 3) & 0x20202020) |
> -   ((T0 << 1) & 0x10101010) |
> -   ((T0 >> 1) & 0x08080808) |
> -   ((T0 >> 3) & 0x04040404) |
> -   ((T0 >> 5) & 0x02020202) |
> -   ((T0 >> 7) & 0x01010101));
> +/*
> + * Reverse the bits within each byte.
> + *
> + *  T0 =3D ((T0 << 7) & 0x80808080)
> + *     | ((T0 << 5) & 0x40404040)
> + *     | ((T0 << 3) & 0x20202020)
> + *     | ((T0 << 1) & 0x10101010)
> + *     | ((T0 >> 1) & 0x08080808)
> + *     | ((T0 >> 3) & 0x04040404)
> + *     | ((T0 >> 5) & 0x02020202)
> + *     | ((T0 >> 7) & 0x01010101);
>   */
>  static void t_gen_swapr(TCGv d, TCGv s)
>  {
> --
> 2.41.0
>
>

--000000000000998fb706044e405d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, Aug 23, 2023 at 4:56=E2=80=AFPM P=
hilippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@=
linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Signed-off-by: Philippe Mathieu-Daud=
=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@li=
naro.org</a>&gt;<br>
</blockquote><div><br></div><div>Reviewed-by: Edgar E. Iglesias &lt;<a href=
=3D"mailto:edgar@zeroasic.com">edgar@zeroasic.com</a>&gt;<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">---<br>
=C2=A0target/cris/translate.c | 20 +++++++++++---------<br>
=C2=A01 file changed, 11 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/target/cris/translate.c b/target/cris/translate.c<br>
index 0b3d724281..42103b5558 100644<br>
--- a/target/cris/translate.c<br>
+++ b/target/cris/translate.c<br>
@@ -411,15 +411,17 @@ static inline void t_gen_swapw(TCGv d, TCGv s)<br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_or_tl(d, d, t);<br>
=C2=A0}<br>
<br>
-/* Reverse the within each byte.<br>
-=C2=A0 =C2=A0T0 =3D (((T0 &lt;&lt; 7) &amp; 0x80808080) |<br>
-=C2=A0 =C2=A0((T0 &lt;&lt; 5) &amp; 0x40404040) |<br>
-=C2=A0 =C2=A0((T0 &lt;&lt; 3) &amp; 0x20202020) |<br>
-=C2=A0 =C2=A0((T0 &lt;&lt; 1) &amp; 0x10101010) |<br>
-=C2=A0 =C2=A0((T0 &gt;&gt; 1) &amp; 0x08080808) |<br>
-=C2=A0 =C2=A0((T0 &gt;&gt; 3) &amp; 0x04040404) |<br>
-=C2=A0 =C2=A0((T0 &gt;&gt; 5) &amp; 0x02020202) |<br>
-=C2=A0 =C2=A0((T0 &gt;&gt; 7) &amp; 0x01010101));<br>
+/*<br>
+ * Reverse the bits within each byte.<br>
+ *<br>
+ *=C2=A0 T0 =3D ((T0 &lt;&lt; 7) &amp; 0x80808080)<br>
+ *=C2=A0 =C2=A0 =C2=A0| ((T0 &lt;&lt; 5) &amp; 0x40404040)<br>
+ *=C2=A0 =C2=A0 =C2=A0| ((T0 &lt;&lt; 3) &amp; 0x20202020)<br>
+ *=C2=A0 =C2=A0 =C2=A0| ((T0 &lt;&lt; 1) &amp; 0x10101010)<br>
+ *=C2=A0 =C2=A0 =C2=A0| ((T0 &gt;&gt; 1) &amp; 0x08080808)<br>
+ *=C2=A0 =C2=A0 =C2=A0| ((T0 &gt;&gt; 3) &amp; 0x04040404)<br>
+ *=C2=A0 =C2=A0 =C2=A0| ((T0 &gt;&gt; 5) &amp; 0x02020202)<br>
+ *=C2=A0 =C2=A0 =C2=A0| ((T0 &gt;&gt; 7) &amp; 0x01010101);<br>
=C2=A0 */<br>
=C2=A0static void t_gen_swapr(TCGv d, TCGv s)<br>
=C2=A0{<br>
-- <br>
2.41.0<br>
<br>
</blockquote></div></div>

--000000000000998fb706044e405d--

