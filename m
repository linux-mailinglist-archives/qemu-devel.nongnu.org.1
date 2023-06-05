Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5679C721DB4
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 07:58:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q63Db-0003Tr-LZ; Mon, 05 Jun 2023 01:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q63DW-0003Sn-Rb; Mon, 05 Jun 2023 01:57:22 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q63DV-0004pD-2g; Mon, 05 Jun 2023 01:57:22 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-977e7d6945aso37794566b.2; 
 Sun, 04 Jun 2023 22:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685944637; x=1688536637;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3rpjzSXMT2dvQGQ2RUuLgAFBHNREISMKWgEghLmAcg=;
 b=Df6l/Qy1YSSIhtC45vli562eV9oN1XTWUeTYxt3XKys0amvxMWil3M6YTUKVobHpHM
 slpCNNBRzshCHsMMKFE7fWIWZbE8SXcZocaXAaEJzMJV3y/rfxy3kgRripVA4b0RAh8k
 sVFSPmattswElufUqq8woB5PRPcQ2SkFsYWbOmVeUKe4cfz1iSQutQDtNyC+znspAYO0
 /6CFPuljAFMuSICRaWaj8qfItmA5ffc83mG0fjUyh+bdgLxpggI0hPKQA3mEq2pUYny8
 520U3Dc+u5XU7SkCMewyClrZG/XKAJmnk8T44KIrlh+80sjpSJ11MUJe7p2F4C1yh6K2
 aA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685944637; x=1688536637;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e3rpjzSXMT2dvQGQ2RUuLgAFBHNREISMKWgEghLmAcg=;
 b=PLozgDcCz5Jv+VkS8Hf63OJSwUrsAKmCNKQm2IR7qYreZEaQDjAjyKcgkFoAJlIaVn
 UHOeMSnUlxhpzuahVd0NC488OrbgImXi4CYN/p9qW0dGjJdFWEijIortOl2JWNwazupP
 daNKIb12tD6vT8RdUH9DhCe2GTxGCdwbDlKBXqVRRebbQxenLk+U6VOil1v154BiG9W1
 3x0BnaBXDX3n0BQCCD7g8q8FdyXTIflPf0YcIAAHf2K9fQOjL7Ko3oJhOfjRa+3xEBPA
 iV5gKqixVhph3kTLlXH5Dnet0saprxMFnPF39QongR7HJw3VkvHk+P4gAU6lMNU9RQ81
 Ehrw==
X-Gm-Message-State: AC+VfDyPcXyXLdB+vKMgj9MUnc7Itsuf/wMJpkVQTsp/EhPdScSE/H5s
 Vl81jmDDFMd1UnccaaKbrSg=
X-Google-Smtp-Source: ACHHUZ4NViZRgvk+YSQjz4pTmzpLh/g4+N/1YMMa/0FcKTPykVxKQPCqv2XOi6ls8reTK2dgszFDeQ==
X-Received: by 2002:a17:907:9621:b0:973:8c47:2a02 with SMTP id
 gb33-20020a170907962100b009738c472a02mr6845593ejc.38.1685944636781; 
 Sun, 04 Jun 2023 22:57:16 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-089-014-188-226.89.14.pool.telefonica.de.
 [89.14.188.226]) by smtp.gmail.com with ESMTPSA id
 ay12-20020a170906d28c00b00977cc5d6ca3sm1879242ejb.163.2023.06.04.22.57.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jun 2023 22:57:16 -0700 (PDT)
Date: Mon, 05 Jun 2023 05:57:13 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
CC: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster <armbru@redhat.com>, 
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 05/12] hw/ssi: Introduce a ssi_get_cs() helper
In-Reply-To: <36c9bda8-3af2-ebf5-f8b9-599cafea0735@linaro.org>
References: <20230508075859.3326566-1-clg@kaod.org>
 <20230508075859.3326566-6-clg@kaod.org>
 <40c8647d-201e-3ceb-97ca-ec98bdc84e88@linaro.org>
 <0d11b78e-56f7-553a-3e85-0edef9b649ac@linaro.org>
 <523179dd-7842-7f03-14d6-678ed680a017@kaod.org>
 <6bfba08e-ce3e-539b-952d-697c8791fab2@linaro.org>
 <54d781f8-35d0-9e68-c2ec-743dd8f6a88e@kaod.org>
 <36c9bda8-3af2-ebf5-f8b9-599cafea0735@linaro.org>
Message-ID: <467372F8-7DB7-41FB-8BA0-6CF12EC3AC50@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
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



Am 31=2E Mai 2023 07:39:32 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <phil=
md@linaro=2Eorg>:
>On 31/5/23 08:36, C=C3=A9dric Le Goater wrote:
>> On 5/31/23 08:17, Philippe Mathieu-Daud=C3=A9 wrote:
>>> +QOM tinkerers
>>>=20
>>> On 31/5/23 07:59, C=C3=A9dric Le Goater wrote:
>>>> On 5/30/23 23:15, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> On 30/5/23 22:34, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>> On 8/5/23 09:58, C=C3=A9dric Le Goater wrote:
>>>>>>> Simple routine to retrieve a DeviceState object on a SPI bus using=
 its
>>>>>>> address/cs=2E It will be useful for the board to wire the CS lines=
=2E
>>>>>>>=20
>>>>>>> Cc: Alistair Francis <alistair@alistair23=2Eme>
>>>>>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod=2Eorg>
>>>>>>> ---
>>>>>>> =C2=A0 include/hw/ssi/ssi=2Eh |=C2=A0 2 ++
>>>>>>> =C2=A0 hw/ssi/ssi=2Ec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 15 +++++++++++++++
>>>>>>> =C2=A0 2 files changed, 17 insertions(+)
>>>>>>>=20
>>>>>>> diff --git a/include/hw/ssi/ssi=2Eh b/include/hw/ssi/ssi=2Eh
>>>>>>> index ffd3a34ba4=2E=2Ec7beabdb09 100644
>>>>>>> --- a/include/hw/ssi/ssi=2Eh
>>>>>>> +++ b/include/hw/ssi/ssi=2Eh
>>>>>>> @@ -112,4 +112,6 @@ SSIBus *ssi_create_bus(DeviceState *parent, co=
nst char *name);
>>>>>>> =C2=A0 uint32_t ssi_transfer(SSIBus *bus, uint32_t val);
>>>>>>> +DeviceState *ssi_get_cs(SSIBus *bus, int addr);
>>>>>=20
>>>>> Also, this helper should (preferably) return a SSIPeripheral type=2E
>>>>=20
>>>> Well, having a DeviceState is handy for the callers (today) and
>>>> ssi_create_peripheral() returns a DeviceState=2E Let's keep it that
>>>> way=2E
>>>=20
>>> Yes I know it is handy :) I'm not against your patch; besides other
>>> APIs do that=2E I'm wondering about QOM design here=2E Having Foo devi=
ce,
>>> should FOO API return the common qdev abstract type (DeviceState) or
>>> a Foo type? Either ways we keep QOM-casting around, but I still tend
>>> to consider FOO API returning Foo pointer provides some type check
>>> safety, and also provides the API user hints about what is used=2E
>>> Need more coffee=2E
>>=20
>> It is used in two code paths today:
>>=20
>>  =C2=A0=C2=A0=C2=A0=C2=A0=2E=2E=2E
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceState *dev =3D ssi_ge=
t_cs(bmc->soc=2Efmc=2Espi, 0);
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockBackend *fmc0 =3D dev =
? m25p80_get_blk(dev) : NULL;

Looks like m25p80_get_blk() should take a more specific argument as well, =
like Phil suggested already=2E Wouldn't that avoid the QOM cast here?

Best regards,
Bernhard

>>  =C2=A0=C2=A0=C2=A0=C2=A0=2E=2E=2E
>> and
>>  =C2=A0=C2=A0=C2=A0=C2=A0=2E=2E=2E
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceState *dev =3D ssi_ge=
t_cs(s->spi, i);
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dev) {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qem=
u_irq cs_line =3D qdev_get_gpio_in_named(dev, SSI_GPIO_CS, 0);
>>  =C2=A0=C2=A0=C2=A0=C2=A0=2E=2E=2E
>>=20
>>=20
>> Changing the interface is not a radical change, it will add two QOM-cas=
ts=2E
>> I can give it a try in v2=2E
>
>Hold on, lets see what others think first=2E

