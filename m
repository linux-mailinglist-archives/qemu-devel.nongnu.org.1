Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 480807D223D
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:28:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUkF-00022q-2m; Sun, 22 Oct 2023 05:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1quUjK-0001Im-3z
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:26:42 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1quUjH-00010I-TN
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:26:41 -0400
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-9c773ac9b15so267744366b.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966797; x=1698571597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8QN/UKBtHCmEFZt1GHAe3CuIWe7G9yUq1p2GuGUi0rI=;
 b=NDNZm6T9N3prjJS83vP3M3YR36X5wTyGZkEGrfPbV98Pr3hmgZPYm/l4OuuAJxJOgQ
 x7wWoZazVjrqGsedAprGTjguP/Xh8iNT9mWkcSrewpM6zeOXMuXkvSziUKFnUQGMjDua
 d7UCW8jXmoyUrSmRuoMdBLPHDp6Mvy/s2zo9cKj7Z8hjHjV+pdPSiUxUFmb27x2+Q9rO
 XEp2Spv6aLMQhSfzZhe9+Rt0/zlkomY5E5JTH4cY4bSVvcUYMB09rygGQwXgosLbCJDQ
 DNUpH3zotiPSOdq+NiFoGXVb4gcHzdKFP4QuT7ZYC0SBERhv5O7xuXXupbja2FFzGwYj
 Lo5w==
X-Gm-Message-State: AOJu0Yw3oQbDriRyeBv4/oLO3qMNiX+bux8WhHTicsv4ambWCupNrrsD
 FVxwUKTgam7HQdXecjqf7WGjX0BG0ck=
X-Google-Smtp-Source: AGHT+IGxADYuDy9uUXuowhdqEPy5we07Y0UoTtEYvymREZqJmO0pxN8+euX3oaD8Tx31JYIScaWlow==
X-Received: by 2002:a17:907:3fa2:b0:9c7:5437:841e with SMTP id
 hr34-20020a1709073fa200b009c75437841emr4309087ejc.11.1697966796978; 
 Sun, 22 Oct 2023 02:26:36 -0700 (PDT)
Received: from fedora (ip-109-43-176-141.web.vodafone.de. [109.43.176.141])
 by smtp.gmail.com with ESMTPSA id
 m2-20020a17090607c200b009c6a4a5ac80sm4743120ejc.169.2023.10.22.02.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:26:36 -0700 (PDT)
Date: Sun, 22 Oct 2023 11:26:35 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 2/6] hw/m68k/mcf5206: Pass CPU using QOM link property
Message-ID: <20231022112635.343baaba@fedora>
In-Reply-To: <20231020150627.56893-3-philmd@linaro.org>
References: <20231020150627.56893-1-philmd@linaro.org>
 <20231020150627.56893-3-philmd@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.218.41; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f41.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am Fri, 20 Oct 2023 17:06:22 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>:

> Avoid the interrupt controller directly access the first cpu
> via the qemu_get_cpu() call. Pass it from the board code.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/m68k/an5206.c  | 2 ++
>  hw/m68k/mcf5206.c | 9 ++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
> index 11ae4c9795..f51c93088f 100644
> --- a/hw/m68k/an5206.c
> +++ b/hw/m68k/an5206.c
> @@ -26,6 +26,8 @@ static void mcf5206_init(MemoryRegion *sysmem, uint32_t=
 base)
>      SysBusDevice *s;
> =20
>      dev =3D qdev_new(TYPE_MCF5206_MBAR);
> +    object_property_set_link(OBJECT(dev), "m68k-cpu",
> +                             OBJECT(first_cpu), &error_abort);
>      s =3D SYS_BUS_DEVICE(dev);
>      sysbus_realize_and_unref(s, &error_fatal);

It might be nicer to pass "cpu" as parameter from an5206_init().

Anyway:
Tested-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>

