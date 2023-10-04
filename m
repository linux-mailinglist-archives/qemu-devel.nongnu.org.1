Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B2A7B7EEE
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:21:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0s7-0008I9-GZ; Wed, 04 Oct 2023 08:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qo0s4-0008Hk-MZ
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:20:56 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qo0s3-0003FB-5r
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:20:56 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso1905735f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696422053; x=1697026853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/tiynGJ0+5EjrBj0fQ9zh1tkVZJ8qV3OBmxC6Iv+dmw=;
 b=RqArJVAvWY+nvo+cVY2u8Shf5UbJ8pFoMVyaKxTn4CadsgzKGthunGhwesB/y1Gem1
 d7+Q0epXcyrCijK8zinnjdcT43+CG5G/99gfrCVJnKWCeDbnyQ9bg/5x83eWVtbOWXyq
 NQjYh7MijNcqlB0I/UGvup7hIs7lY08/CRCdwDJscRw16uKZINV6QwZOVlm0cCjjuT9k
 Vu2kUnYht3mTnhtX5QGx2CiLYe3PBv/mHFol7yUDmlSXJMJ+t9J8LfHkLt8Smmjhueds
 FqLJChNN4VJ5Z4ERcBW5yMUvxGz+/0cJ7dUdSAzYWEX8/EKagA1TOiagApZv9SxRCXhn
 6rXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696422053; x=1697026853;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/tiynGJ0+5EjrBj0fQ9zh1tkVZJ8qV3OBmxC6Iv+dmw=;
 b=S3jTAbRYx3PawhqGYWf1RnEEvq9Qp4nClaLsj2IHlVAj/+WYgjb8Os+qU1erYKewBq
 0chE/bb9Lmh4eQDLiOF8IS1TwjT7TJykq7sH2X08s2hkI9gNdBkE8e4TlKU/nVkE1BCm
 dUiNtrl+pBVDppJUoLnRALyxrvM+4H8q71O+Ail2D4mk4Dhg+t8FQErVVqN92vtIucN9
 JOpzYu3pIu+R7QnvZwQJ5lO9wJjOb2nU9J9+S+CAVeQ7tIoYveFqOS2kjC1Bd3AoNInp
 jPC3wGLT2IbJ/XgAi2zaCd7rbR6CROeyhVy0VWD0uNS/nBlLzUmBOwbEaQ4ifaAZJSIX
 A+/Q==
X-Gm-Message-State: AOJu0Yzhey/tk0wS5GlzruaWMlvkFC2JP4t7XtAZo3E2bX+b38GZClkL
 +eLmMf/Fv31KUYVUmaKE3urkmw==
X-Google-Smtp-Source: AGHT+IHRljcUOByftX7ye55uQE6vz8M+wyTwe8fQgFB/eJT5qbEImSG9Fflz80BMxqghM5GXbotv9g==
X-Received: by 2002:adf:e7c1:0:b0:323:2f16:66ee with SMTP id
 e1-20020adfe7c1000000b003232f1666eemr1719327wrn.71.1696422053533; 
 Wed, 04 Oct 2023 05:20:53 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q4-20020a5d5744000000b003231a0ca5ebsm3857391wrw.49.2023.10.04.05.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 05:20:53 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 99D3A1FFBB;
 Wed,  4 Oct 2023 13:20:52 +0100 (BST)
References: <20231004120019.93101-1-philmd@linaro.org>
 <20231004120019.93101-14-philmd@linaro.org>
User-agent: mu4e 1.11.21; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Markus Armbruster
 <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 13/16] semihosting/arm-compat: Clean up local
 variable shadowing
Date: Wed, 04 Oct 2023 13:19:13 +0100
In-reply-to: <20231004120019.93101-14-philmd@linaro.org>
Message-ID: <87h6n6h93v.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Fix:
>
>   semihosting/arm-compat-semi.c: In function =E2=80=98do_common_semihosti=
ng=E2=80=99:
>   semihosting/arm-compat-semi.c:379:13: warning: declaration of =E2=80=98=
ret=E2=80=99 shadows a previous local [-Wshadow=3Dlocal]
>     379 |         int ret, err =3D 0;
>         |             ^~~
>   semihosting/arm-compat-semi.c:370:14: note: shadowed declaration is here
>     370 |     uint32_t ret;
>         |              ^~~
>   semihosting/arm-compat-semi.c:682:27: warning: declaration of =E2=80=98=
ret=E2=80=99
> shadows a previous local [-Wshadow=3Dlocal]
>     682 |                 abi_ulong ret;
>         |                           ^~~
>   semihosting/arm-compat-semi.c:370:9: note: shadowed declaration is here
>     370 |     int ret;
>         |         ^~~
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  semihosting/arm-compat-semi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
> index 564fe17f75..0033a1e018 100644
> --- a/semihosting/arm-compat-semi.c
> +++ b/semihosting/arm-compat-semi.c
> @@ -367,7 +367,6 @@ void do_common_semihosting(CPUState *cs)
>      target_ulong ul_ret;
>      char * s;
>      int nr;
> -    uint32_t ret;
>      int64_t elapsed;
>=20=20
>      nr =3D common_semi_arg(cs, 0) & 0xffffffffU;
> @@ -725,6 +724,9 @@ void do_common_semihosting(CPUState *cs)
>=20=20
>      case TARGET_SYS_EXIT:
>      case TARGET_SYS_EXIT_EXTENDED:
> +    {
> +        uint32_t ret;
> +

I suspect this could just as well be an int with an explicit cast for ret =
=3D arg1
because the consumers are all expecting int anyway.

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

