Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCAB755159
	for <lists+qemu-devel@lfdr.de>; Sun, 16 Jul 2023 21:55:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qL7ob-0001Cy-7W; Sun, 16 Jul 2023 15:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qL7oW-0001CV-7l; Sun, 16 Jul 2023 15:53:52 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qL7oU-0007jJ-I0; Sun, 16 Jul 2023 15:53:51 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-51e344efd75so7867344a12.1; 
 Sun, 16 Jul 2023 12:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689537228; x=1692129228;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xYbpB+EOrfahfEu3qcjprjciy1Jgcqgxk8JOVR2o918=;
 b=JxnfgVxwS+Z9wwW3uMWfNi16cPC/YW2y0vMCpaAHQnat23gN1Q9LNqTE6PPVXBDtvc
 tQqOjzefaajxUgekzJFMZKBW9Edc3wtNP2k8YaXZZDEQ+itIwYP+VecAq8w8fnwHkTlF
 ntv8/gTZPuOPKTAvAlVDH4nf4OtNFUzauR5irMBk4cFQCPoNHnF3ynaSopto8gc1Zmko
 mnL7GI9YqSPba3XDjVSf/aJM+mvC/fWiViZh/Kq/C8AfRnHDTUbn5NNiM8hyH06P/ZMY
 ouU0DnbZ8QIvXm/rABuWTMA7AtSnBYd/7ttM7wtFI5tOAhfwTKvLNc87IUdzkV39G+C4
 BmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689537228; x=1692129228;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xYbpB+EOrfahfEu3qcjprjciy1Jgcqgxk8JOVR2o918=;
 b=IPY2vO8gp08Ar073S7HrVBUD+Q+sMbASiUvkngZN1UC3349Ln58sRF2CNc6DNjspTn
 yXyS/oEQ3VLChJw6gEwPhswbOZLd21t5HLv4rvyJO3CziKzxEf7+3YoKN5O9Lh6q2m+1
 +6dWuZg7Avh3omX1CRRLGqlw90gYOKXenHe68B9un1rBPNdqmDPuW/EQCFTvCc8RrieZ
 0QfAumCFIj/MzIlZfsuJYijPK3fiDchaESWK5QVfPwPC6u0M7Q1rbRe/a+H+k0iNTEMz
 eGVuQ39ReobuR55T0dhP0XkX5h1+zQR6uBJzvHVNHYzpi/qcGb5US8BpSWsWmux2MsnK
 0FuQ==
X-Gm-Message-State: ABy/qLY3+l8O8MkPnZmo86drsxcSbP7fD1WwlOysYXswlRdG3nCit+nV
 DU8zA6zocgE5wngAGn2jqI0=
X-Google-Smtp-Source: APBJJlFJU48ORGmj5j3oOLjOls192uu+gKtO9bADs8ORnXMKziMA5ck4hvCED9bnaxT8IJ10xCFCow==
X-Received: by 2002:a05:6402:5206:b0:51e:5e93:6c38 with SMTP id
 s6-20020a056402520600b0051e5e936c38mr8053930edd.21.1689537227877; 
 Sun, 16 Jul 2023 12:53:47 -0700 (PDT)
Received: from [127.0.0.1] ([185.238.219.27]) by smtp.gmail.com with ESMTPSA id
 n20-20020a05640204d400b00521936fadabsm464977edw.89.2023.07.16.12.53.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jul 2023 12:53:47 -0700 (PDT)
Date: Sun, 16 Jul 2023 19:53:37 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bin.meng@windriver.com>, qemu-stable@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hw/sd/sdhci=3A_Do_not_force_s?=
 =?US-ASCII?Q?dhci=5Fmmio=5F*=5Fops_onto_all_SD_controllers?=
In-Reply-To: <3F4FCDD8-91B3-4331-A336-EB31E0237625@gmail.com>
References: <20230709080950.92489-1-shentey@gmail.com>
 <52b5a36a-5744-0ac9-a3f5-0dbd247410ed@linaro.org>
 <3F4FCDD8-91B3-4331-A336-EB31E0237625@gmail.com>
Message-ID: <B5DFB2DD-E01B-42A5-9907-B2988D683F9B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



Am 10=2E Juli 2023 16:01:46 UTC schrieb Bernhard Beschow <shentey@gmail=2E=
com>:
>
>
>Am 10=2E Juli 2023 10:16:35 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <ph=
ilmd@linaro=2Eorg>:
>>On 9/7/23 10:09, Bernhard Beschow wrote:
>>> Since commit c0a55a0c9da2 "hw/sd/sdhci: Support big endian SD host con=
troller
>>> interfaces" sdhci_common_realize() forces all SD card controllers to u=
se either
>>> sdhci_mmio_le_ops or sdhci_mmio_be_ops, depending on the "endianness" =
property=2E
>>> However, there are device models which use different MMIO ops: TYPE_IM=
X_USDHC
>>> uses usdhc_mmio_ops and TYPE_S3C_SDHCI uses sdhci_s3c_mmio_ops=2E
>>>=20
>>> Forcing sdhci_mmio_le_ops breaks SD card handling on the "sabrelite" b=
oard, for
>>> example=2E Fix this by defaulting the io_ops to little endian and swit=
ch to big
>>> endian in sdhci_common_realize() only if there is a matchig big endian=
 variant
>>> available=2E
>>>=20
>>> Fixes: c0a55a0c9da2 ("hw/sd/sdhci: Support big endian SD host controll=
er
>>> interfaces")
>>>=20
>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>> ---
>>>   hw/sd/sdhci=2Ec | 8 +++++++-
>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/hw/sd/sdhci=2Ec b/hw/sd/sdhci=2Ec
>>> index 6811f0f1a8=2E=2E362c2c86aa 100644
>>> --- a/hw/sd/sdhci=2Ec
>>> +++ b/hw/sd/sdhci=2Ec
>>> @@ -1382,6 +1382,8 @@ void sdhci_initfn(SDHCIState *s)
>>>         s->insert_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_rai=
se_insertion_irq, s);
>>>       s->transfer_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_dat=
a_transfer, s);
>>> +
>>> +    s->io_ops =3D &sdhci_mmio_le_ops;
>>>   }
>>>     void sdhci_uninitfn(SDHCIState *s)
>>> @@ -1399,9 +1401,13 @@ void sdhci_common_realize(SDHCIState *s, Error =
**errp)
>>>  =20
>>
>>What about simply keeping the same code guarded with 'if (!s->io_ops)'?
>
>I chose below approach since it provides an error message when one attemp=
ts to set one of the other device models to BE rather than just silently ig=
noring it=2E
>
>Also, I didn't want to make the assumption that `s->io_ops =3D=3D NULL` i=
mplied that sdhci_mmio_*_ops is needed=2E That's similar material the bug f=
ixed is made of, so I wanted to prevent that in the first place by being mo=
re explicit=2E
>
>In combination with the new error message the limitations of the current =
code become hopefully very apparent now, and at the same time should provid=
e enough hints for adding BE support to the other device models if ever nee=
ded=2E
>
>Best regards,
>Bernhard

Ping

+ qemu--stable

>
>>
>>>       switch (s->endianness) {
>>>       case DEVICE_LITTLE_ENDIAN:
>>> -        s->io_ops =3D &sdhci_mmio_le_ops;
>>> +        /* s->io_ops is little endian by default */
>>>           break;
>>>       case DEVICE_BIG_ENDIAN:
>>> +        if (s->io_ops !=3D &sdhci_mmio_le_ops) {
>>> +            error_setg(errp, "SD controller doesn't support big endia=
nness");
>>> +            return;
>>> +        }
>>>           s->io_ops =3D &sdhci_mmio_be_ops;
>>>           break;
>>>       default:
>>

