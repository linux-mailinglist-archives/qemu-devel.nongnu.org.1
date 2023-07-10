Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E23CC74DD38
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 20:20:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIvUS-0007s5-JU; Mon, 10 Jul 2023 14:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qIvUI-0007ms-90; Mon, 10 Jul 2023 14:19:54 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qIvUG-0001WA-Ep; Mon, 10 Jul 2023 14:19:53 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3128fcd58f3so5278568f8f.1; 
 Mon, 10 Jul 2023 11:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689013190; x=1691605190;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ieSYKIWeiAdkCr9IAmKTcBDQKaK52xCMbV2Ei3zD+7o=;
 b=b2i5xBkEIqeBx2nKMQfV4+MdhBYf/t6d/FC1oHcmCsw9oryj5BywTFTqqSR+GFz6YC
 ttNiiNrKUunWlIcSnOnz/s1qhAPtwRENQpZuuxKKOBCbW4WPR2fDhtikOY0WB1HWevYi
 JjOkersLPd0tlK99G+NYvSJPt097x/EvEcnp1/5En9Xk27FWmDp0gQ2Sswx3Sh8k93mF
 wL5uIHc4gkIx6t/FruIixDgN8n/50A9Dsns4eXN+1V7s5xH63WVgnB3efrLJIoiDgMUF
 DBx8IY8ksWFRXt2sEz1MdFiKhmGtH3GVKpwHfg2bU2BHtGNAbzScPcQSDTFNtJYHbATM
 e/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689013190; x=1691605190;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ieSYKIWeiAdkCr9IAmKTcBDQKaK52xCMbV2Ei3zD+7o=;
 b=XRXtrm43fp+YqoZet0j1EQvu7NBP4hYcpP+q4eSfOY+b8/ZY9UMpdiDVTOOj+3/GS5
 UiFGmXlddewhA6l5Yc5/pJlJh+LlEgnA0U8NfNVlWnrxerfbwNLOfiNgdaprlEXVpu+5
 kxqVkc9m0Yefw3syhcVNuAvO3Tp8gy+t8icTR5uS56fif+ba8iLSV30UAzq2S4sPmbb2
 Q/N7z2aHZ9eY3F5K/7jwLHNCIYS0rgiX6ZP8foIfEnLS6dMrUGJR96C3kaa/9oGB105j
 JofVrCUJlDHNUinRh+xjjX+L71hxR/RyVKA4/VbgJX9zC3ICkhLttx4hAsw+QGhsW/rj
 +ODA==
X-Gm-Message-State: ABy/qLZL8qZ2aPhURSgvpHbdEYsVHRZnnJjDhOpqQhduVq1WXwxX18Ta
 R8M1y84rOKnG4oVW4r6EwuA=
X-Google-Smtp-Source: APBJJlH/lOttY5CgpG8MAj6Xc8y4J/m8D5UJQh/k3kMTzSjTJMtlbmvEy+yW5WJsSAM90l/5gaEiqw==
X-Received: by 2002:a5d:52c3:0:b0:313:eadf:b82d with SMTP id
 r3-20020a5d52c3000000b00313eadfb82dmr11086886wrv.69.1689013190297; 
 Mon, 10 Jul 2023 11:19:50 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-013-218-005.77.13.pool.telefonica.de.
 [77.13.218.5]) by smtp.gmail.com with ESMTPSA id
 e14-20020a5d65ce000000b0031437ec7ec1sm110327wrw.2.2023.07.10.11.19.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 11:19:49 -0700 (PDT)
Date: Mon, 10 Jul 2023 16:01:46 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bin.meng@windriver.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hw/sd/sdhci=3A_Do_not_force_s?=
 =?US-ASCII?Q?dhci=5Fmmio=5F*=5Fops_onto_all_SD_controllers?=
In-Reply-To: <52b5a36a-5744-0ac9-a3f5-0dbd247410ed@linaro.org>
References: <20230709080950.92489-1-shentey@gmail.com>
 <52b5a36a-5744-0ac9-a3f5-0dbd247410ed@linaro.org>
Message-ID: <3F4FCDD8-91B3-4331-A336-EB31E0237625@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



Am 10=2E Juli 2023 10:16:35 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <phi=
lmd@linaro=2Eorg>:
>On 9/7/23 10:09, Bernhard Beschow wrote:
>> Since commit c0a55a0c9da2 "hw/sd/sdhci: Support big endian SD host cont=
roller
>> interfaces" sdhci_common_realize() forces all SD card controllers to us=
e either
>> sdhci_mmio_le_ops or sdhci_mmio_be_ops, depending on the "endianness" p=
roperty=2E
>> However, there are device models which use different MMIO ops: TYPE_IMX=
_USDHC
>> uses usdhc_mmio_ops and TYPE_S3C_SDHCI uses sdhci_s3c_mmio_ops=2E
>>=20
>> Forcing sdhci_mmio_le_ops breaks SD card handling on the "sabrelite" bo=
ard, for
>> example=2E Fix this by defaulting the io_ops to little endian and switc=
h to big
>> endian in sdhci_common_realize() only if there is a matchig big endian =
variant
>> available=2E
>>=20
>> Fixes: c0a55a0c9da2 ("hw/sd/sdhci: Support big endian SD host controlle=
r
>> interfaces")
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   hw/sd/sdhci=2Ec | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/hw/sd/sdhci=2Ec b/hw/sd/sdhci=2Ec
>> index 6811f0f1a8=2E=2E362c2c86aa 100644
>> --- a/hw/sd/sdhci=2Ec
>> +++ b/hw/sd/sdhci=2Ec
>> @@ -1382,6 +1382,8 @@ void sdhci_initfn(SDHCIState *s)
>>         s->insert_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_rais=
e_insertion_irq, s);
>>       s->transfer_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_data=
_transfer, s);
>> +
>> +    s->io_ops =3D &sdhci_mmio_le_ops;
>>   }
>>     void sdhci_uninitfn(SDHCIState *s)
>> @@ -1399,9 +1401,13 @@ void sdhci_common_realize(SDHCIState *s, Error *=
*errp)
>>  =20
>
>What about simply keeping the same code guarded with 'if (!s->io_ops)'?

I chose below approach since it provides an error message when one attempt=
s to set one of the other device models to BE rather than just silently ign=
oring it=2E

Also, I didn't want to make the assumption that `s->io_ops =3D=3D NULL` im=
plied that sdhci_mmio_*_ops is needed=2E That's similar material the bug fi=
xed is made of, so I wanted to prevent that in the first place by being mor=
e explicit=2E

In combination with the new error message the limitations of the current c=
ode become hopefully very apparent now, and at the same time should provide=
 enough hints for adding BE support to the other device models if ever need=
ed=2E

Best regards,
Bernhard

>
>>       switch (s->endianness) {
>>       case DEVICE_LITTLE_ENDIAN:
>> -        s->io_ops =3D &sdhci_mmio_le_ops;
>> +        /* s->io_ops is little endian by default */
>>           break;
>>       case DEVICE_BIG_ENDIAN:
>> +        if (s->io_ops !=3D &sdhci_mmio_le_ops) {
>> +            error_setg(errp, "SD controller doesn't support big endian=
ness");
>> +            return;
>> +        }
>>           s->io_ops =3D &sdhci_mmio_be_ops;
>>           break;
>>       default:
>

