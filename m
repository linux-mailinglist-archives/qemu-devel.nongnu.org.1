Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4815A75EC5B
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 09:20:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNppv-000516-P3; Mon, 24 Jul 2023 03:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qNppe-0004zl-MF; Mon, 24 Jul 2023 03:18:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qNppc-00044D-V6; Mon, 24 Jul 2023 03:18:14 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fc0aecf107so29402275e9.2; 
 Mon, 24 Jul 2023 00:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690183090; x=1690787890;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OJRnUehJ+vY1uAO3qAksKFIVU5QwELYk+PmT+ArIw0s=;
 b=NsMMYDKAxue7Ae5tf8k4kr9rATjZb3S638Zukmj2EV0EiqWBF9SIqVDxFTwVRYGotl
 2g2T5HSfMgGKLISLUy/pgxyrQKMLFObWOYV3mA5GEetEN3BeCX7VMjNJZzEoRUjKERzk
 b8aecd6YCkitZMHyMNQHTREfZaK3lIxzOmDOeJfv7UBvBk/jgN5sGoAhU6lqUndzQ0BI
 LHAo+Fw+r9ZMWUEIetQQjCIbXEjc3ojGQ4Nc1wPUibFob4Nf1yyhIEY9uEDyp4zVNFco
 85RkWvMWjoU9N+h+cSiGFia8weX5BJs6P1X3ApnXEdWAGkgY6PrffRghHdHfftPzHo8T
 Ci1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690183090; x=1690787890;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OJRnUehJ+vY1uAO3qAksKFIVU5QwELYk+PmT+ArIw0s=;
 b=NrNKGl4bAfSTFX7T7h2BEjPeuZErqOcf9eA8ubc5EhmFvVyL4NKv1JFFw/mQF5G1cF
 XZPEJtj7g1rN0fWwwsLYGVfBbiEVfzY2TMOFOWFQsWw9xWtZ7BPiBGl2nYfBYQs91jEq
 07eBgJ1IGBdMUweQKFLTwEZn4JBgFvOV6d4OLUw1SMALhLM/hk6NWD1iA5dHZUiC17uH
 jDy4kudmQKAphGd90npwyvBAOSeiiyCcXeOwTghPicjcN/Pgvj+f8aFMQ/F0yAxwTrAc
 Jih208/veWXzTS7GuUAOQEv3R2z8OxqNfECvEMnZCBbJ1lGmMJDEFf3gj7+o26n2Nd9Q
 IMZA==
X-Gm-Message-State: ABy/qLZBKD/BmrpYMp5R5Oyp5ClcCVY+RiNeHcaJUr9Hj/VA94nwM3uZ
 pUl92S97QSsM0gEWqsrvIc3LMd2j2eQ=
X-Google-Smtp-Source: APBJJlHkugw+SDztNc94+X4q+doI3utOAxSWa9LH2DrfEbGG3GD4EIk4aBX5l48rwkbx3VvKLJvk7w==
X-Received: by 2002:a7b:c40a:0:b0:3fc:5d2:1f47 with SMTP id
 k10-20020a7bc40a000000b003fc05d21f47mr5671970wmi.20.1690183089970; 
 Mon, 24 Jul 2023 00:18:09 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-078-054-170-090.78.54.pool.telefonica.de.
 [78.54.170.90]) by smtp.gmail.com with ESMTPSA id
 k18-20020a5d5252000000b00317046f21f9sm11824292wrc.114.2023.07.24.00.18.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jul 2023 00:18:09 -0700 (PDT)
Date: Mon, 24 Jul 2023 07:18:05 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bin.meng@windriver.com>, qemu-stable@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hw/sd/sdhci=3A_Do_not_force_s?=
 =?US-ASCII?Q?dhci=5Fmmio=5F*=5Fops_onto_all_SD_controllers?=
In-Reply-To: <B5DFB2DD-E01B-42A5-9907-B2988D683F9B@gmail.com>
References: <20230709080950.92489-1-shentey@gmail.com>
 <52b5a36a-5744-0ac9-a3f5-0dbd247410ed@linaro.org>
 <3F4FCDD8-91B3-4331-A336-EB31E0237625@gmail.com>
 <B5DFB2DD-E01B-42A5-9907-B2988D683F9B@gmail.com>
Message-ID: <13C66458-1744-4747-BF2D-72371BC00755@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32b.google.com
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



Am 16=2E Juli 2023 19:53:37 UTC schrieb Bernhard Beschow <shentey@gmail=2E=
com>:
>
>
>Am 10=2E Juli 2023 16:01:46 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>>
>>
>>Am 10=2E Juli 2023 10:16:35 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@linaro=2Eorg>:
>>>On 9/7/23 10:09, Bernhard Beschow wrote:
>>>> Since commit c0a55a0c9da2 "hw/sd/sdhci: Support big endian SD host co=
ntroller
>>>> interfaces" sdhci_common_realize() forces all SD card controllers to =
use either
>>>> sdhci_mmio_le_ops or sdhci_mmio_be_ops, depending on the "endianness"=
 property=2E
>>>> However, there are device models which use different MMIO ops: TYPE_I=
MX_USDHC
>>>> uses usdhc_mmio_ops and TYPE_S3C_SDHCI uses sdhci_s3c_mmio_ops=2E
>>>>=20
>>>> Forcing sdhci_mmio_le_ops breaks SD card handling on the "sabrelite" =
board, for
>>>> example=2E Fix this by defaulting the io_ops to little endian and swi=
tch to big
>>>> endian in sdhci_common_realize() only if there is a matchig big endia=
n variant
>>>> available=2E
>>>>=20
>>>> Fixes: c0a55a0c9da2 ("hw/sd/sdhci: Support big endian SD host control=
ler
>>>> interfaces")
>>>>=20
>>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>>> ---
>>>>   hw/sd/sdhci=2Ec | 8 +++++++-
>>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/hw/sd/sdhci=2Ec b/hw/sd/sdhci=2Ec
>>>> index 6811f0f1a8=2E=2E362c2c86aa 100644
>>>> --- a/hw/sd/sdhci=2Ec
>>>> +++ b/hw/sd/sdhci=2Ec
>>>> @@ -1382,6 +1382,8 @@ void sdhci_initfn(SDHCIState *s)
>>>>         s->insert_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_ra=
ise_insertion_irq, s);
>>>>       s->transfer_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_da=
ta_transfer, s);
>>>> +
>>>> +    s->io_ops =3D &sdhci_mmio_le_ops;
>>>>   }
>>>>     void sdhci_uninitfn(SDHCIState *s)
>>>> @@ -1399,9 +1401,13 @@ void sdhci_common_realize(SDHCIState *s, Error=
 **errp)
>>>>  =20
>>>
>>>What about simply keeping the same code guarded with 'if (!s->io_ops)'?
>>
>>I chose below approach since it provides an error message when one attem=
pts to set one of the other device models to BE rather than just silently i=
gnoring it=2E
>>
>>Also, I didn't want to make the assumption that `s->io_ops =3D=3D NULL` =
implied that sdhci_mmio_*_ops is needed=2E That's similar material the bug =
fixed is made of, so I wanted to prevent that in the first place by being m=
ore explicit=2E
>>
>>In combination with the new error message the limitations of the current=
 code become hopefully very apparent now, and at the same time should provi=
de enough hints for adding BE support to the other device models if ever ne=
eded=2E
>>
>>Best regards,
>>Bernhard
>
>Ping

Ping^2

I would like to have the bug fixed in 8=2E1=2E

Best regards,
Bernhard

>
>+ qemu--stable
>
>>
>>>
>>>>       switch (s->endianness) {
>>>>       case DEVICE_LITTLE_ENDIAN:
>>>> -        s->io_ops =3D &sdhci_mmio_le_ops;
>>>> +        /* s->io_ops is little endian by default */
>>>>           break;
>>>>       case DEVICE_BIG_ENDIAN:
>>>> +        if (s->io_ops !=3D &sdhci_mmio_le_ops) {
>>>> +            error_setg(errp, "SD controller doesn't support big endi=
anness");
>>>> +            return;
>>>> +        }
>>>>           s->io_ops =3D &sdhci_mmio_be_ops;
>>>>           break;
>>>>       default:
>>>

