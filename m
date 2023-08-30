Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F4978D575
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 13:16:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbJAw-0000XR-5P; Wed, 30 Aug 2023 07:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qbJAq-0000X0-Ai; Wed, 30 Aug 2023 07:15:48 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qbJAn-0004yb-Ut; Wed, 30 Aug 2023 07:15:48 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52a1132b685so7477654a12.1; 
 Wed, 30 Aug 2023 04:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693394142; x=1693998942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1G8P8uTilc6oweDnqBNRT/pEiYH9xb3QPkwT6D9tJYk=;
 b=TnM+0rtxMg5ovkVl7b34qVNRl+X79nlhfgL9aHcMc2JQu4XvPo1njqt1cEnYUVVncz
 +XzmAqYIovXi6G0Q3KHqxG9L0xOyhukfH1cndTcxFzMwkqtMiBO8elF9KGovSPxrCc7Y
 oLZ+sJz2XKrZhU7WRWHRc0rxNkgemEB1VKDpn7qyMZfamCtGjQtz9jPd3Nau1VNOazpQ
 RKQoL5Po4ucGAEGNF0MwcCcKceS1QjtKrXTT7mbyx97Wcmbin1FZCfRfRVw/NXFdXxZX
 nps8SUmSpEl2fWiKwhfxZO4XtuPezIQFh+3U1nBo/wJrjav2R3DVPednO+mN8IJRhskq
 OPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693394142; x=1693998942;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1G8P8uTilc6oweDnqBNRT/pEiYH9xb3QPkwT6D9tJYk=;
 b=MWcGD7bQ60XDGKsiLwTbqCkcQCRA3yr90V0F8ghn366hNRWjvFGVNt3ftyGxl/AuY5
 +tuuKCEOnHseiDnztAFYTAf0jXtMEmu8VOX6YZfExCso3TARWAM6SIGbxExKEnIvOkCL
 i0S/FF13rOR9yKFGqqwfSo9oj7Jk3BY7+5QrCkIVX3sQ59CzPJHYeEo0ooO4GShhmews
 XxcwlF0Krar53JJiiC4yigUuYdYzVdfs3N09z2vuwhGXf/YcOcLwSo017ZlXBpfPY9aE
 MTnvwSn29naY8qkd5W4bpgQ9HNp6Z6Qb1xqcqZHUi00Zj0zlprueMeXg8v0ee9z7wuwb
 N93Q==
X-Gm-Message-State: AOJu0YyY2H/McoLM6kHC07mKODQXuxsZnPuzKpvqhzAdK/CWUkbNe2Hp
 81nVGsQdqe771ggmcEPDsn+/1rpeLAQ=
X-Google-Smtp-Source: AGHT+IGF/jLlc5HguclUz9/ELATLIZ2A5XsD770yjuPsu6iHpeHBCtYr2tAEnvJbnczfRGkjInc9NA==
X-Received: by 2002:a17:907:2cef:b0:9a4:88af:b7b with SMTP id
 hz15-20020a1709072cef00b009a488af0b7bmr1283268ejc.62.1693394142404; 
 Wed, 30 Aug 2023 04:15:42 -0700 (PDT)
Received: from [127.0.0.1] (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 gw15-20020a170906f14f00b009929ab17bdfsm7043143ejb.168.2023.08.30.04.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 04:15:42 -0700 (PDT)
Date: Wed, 30 Aug 2023 11:15:33 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-block@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>
Subject: =?US-ASCII?Q?Re=3A_=5BPULL_01/10=5D_hw/sd/sdhci=3A_Do_not_forc?=
 =?US-ASCII?Q?e_sdhci=5Fmmio=5F*=5Fops_onto_all_SD_controllers?=
In-Reply-To: <20230725145829.37782-2-philmd@linaro.org>
References: <20230725145829.37782-1-philmd@linaro.org>
 <20230725145829.37782-2-philmd@linaro.org>
Message-ID: <EBE60C76-B8C5-4FF0-BF15-0B924E8F0D22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 25=2E Juli 2023 14:58:20 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <phi=
lmd@linaro=2Eorg>:
>From: Bernhard Beschow <shentey@gmail=2Ecom>
>
>Since commit c0a55a0c9da2 "hw/sd/sdhci: Support big endian SD host contro=
ller
>interfaces" sdhci_common_realize() forces all SD card controllers to use =
either
>sdhci_mmio_le_ops or sdhci_mmio_be_ops, depending on the "endianness" pro=
perty=2E
>However, there are device models which use different MMIO ops: TYPE_IMX_U=
SDHC
>uses usdhc_mmio_ops and TYPE_S3C_SDHCI uses sdhci_s3c_mmio_ops=2E
>
>Forcing sdhci_mmio_le_ops breaks SD card handling on the "sabrelite" boar=
d, for
>example=2E Fix this by defaulting the io_ops to little endian and switch =
to big
>endian in sdhci_common_realize() only if there is a matchig big endian va=
riant
>available=2E
>
>Fixes: c0a55a0c9da2 ("hw/sd/sdhci: Support big endian SD host controller
>interfaces")
>
>Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>Tested-by: Guenter Roeck <linux@roeck-us=2Enet>
>Message-Id: <20230709080950=2E92489-1-shentey@gmail=2Ecom>

Ping qemu-stable

AFAIU the regression happens since 8=2E0, thus would be great to have a fi=
x there=2E

Best regards,
Bernhard

>---
> hw/sd/sdhci=2Ec | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>
>diff --git a/hw/sd/sdhci=2Ec b/hw/sd/sdhci=2Ec
>index 6811f0f1a8=2E=2E362c2c86aa 100644
>--- a/hw/sd/sdhci=2Ec
>+++ b/hw/sd/sdhci=2Ec
>@@ -1382,6 +1382,8 @@ void sdhci_initfn(SDHCIState *s)
>=20
>     s->insert_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_raise_ins=
ertion_irq, s);
>     s->transfer_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_data_tr=
ansfer, s);
>+
>+    s->io_ops =3D &sdhci_mmio_le_ops;
> }
>=20
> void sdhci_uninitfn(SDHCIState *s)
>@@ -1399,9 +1401,13 @@ void sdhci_common_realize(SDHCIState *s, Error **e=
rrp)
>=20
>     switch (s->endianness) {
>     case DEVICE_LITTLE_ENDIAN:
>-        s->io_ops =3D &sdhci_mmio_le_ops;
>+        /* s->io_ops is little endian by default */
>         break;
>     case DEVICE_BIG_ENDIAN:
>+        if (s->io_ops !=3D &sdhci_mmio_le_ops) {
>+            error_setg(errp, "SD controller doesn't support big endianne=
ss");
>+            return;
>+        }
>         s->io_ops =3D &sdhci_mmio_be_ops;
>         break;
>     default:

