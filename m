Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 111EF72BB87
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 11:02:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8dR1-0002dL-3R; Mon, 12 Jun 2023 05:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q8dQq-0002aI-RS; Mon, 12 Jun 2023 05:01:48 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q8dQo-0002Hw-S1; Mon, 12 Jun 2023 05:01:48 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51496f57e59so5719957a12.2; 
 Mon, 12 Jun 2023 02:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686560505; x=1689152505;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9BH4fedupL/Xj2nHnp16H8jJ3HEclWLXok4aZ5xpN2s=;
 b=GgWRPfe2pYHXa1+eDRhyy9fQGUCuP6kvzLfIT3NfzavbY+84bodRsYt76s9KYqCare
 o/hDdbAQDQMdh9DMdMj3uzYKcO7W+vEhbVUPN9Nm7GkM+BS46xGuVffsUISa11qu86sr
 bgOOjScddYk5bLmxHeE5zwBafvJaP3Va8vcu1+VDIFET4OiQaHaJwJbfCuD1C89NBpkQ
 DrYqesIUnx5eBi2pLtDyeyxZr/XvreftDCqCU723bqOwcAsIMqYVDFlFkZPejW48ODz1
 Us2850To7BWMA8gnr291LgFRwtDwTFPj3qWOJYf2ZoDfvs71BmWmjf3wb3Luhp31xk3W
 u5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686560505; x=1689152505;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9BH4fedupL/Xj2nHnp16H8jJ3HEclWLXok4aZ5xpN2s=;
 b=Riq0Pdnjq/+Jk5RbRceMpt4Du4TkZDYPzlqCtxoEXOFrkEddWstCiGhbwpf/H3NqJl
 CtymxsglevcByr1QxZSUD37g/ym8d5dUuGIyKvbCtKVuQcVzfiSxvKsPvInmE1oxtjnI
 LVdClhpPYROIBRWt7SdRARMWBaZfRqehxkUN7NSv/9EFXJXEpLCl/aHWGwygBrXI3ai8
 Uqb9S/xEA9rirtzjPCrnlCdj0qP+9cjogxGDg3RFEsp10dMYXSNnuQxF7JdwLtjBqLGC
 XlSov85wssF970SbWYITixKmdgkBiw/v2GtWcKxqj4W7Gr3pSwt8NdOCCpGkl+25MYB0
 ayIA==
X-Gm-Message-State: AC+VfDyjAjnhOL4R7xNwUfWZrkr7vI9J4kRwoFg2+5TD4vr4I5Cw5rQ5
 Z+NBJkbabZaXozKbD1Mb8c4=
X-Google-Smtp-Source: ACHHUZ5vwMNhs2NfeN5PZg3uK19MB2Wqi7UjQtg94U62zkBnRzpLAsdOim1UmOUUjgGFXXfYtVfDVg==
X-Received: by 2002:a17:907:72c7:b0:978:8746:bd75 with SMTP id
 du7-20020a17090772c700b009788746bd75mr8503686ejc.58.1686560505003; 
 Mon, 12 Jun 2023 02:01:45 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 q15-20020a170906940f00b00977eb9957e9sm4919015ejx.128.2023.06.12.02.01.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 02:01:44 -0700 (PDT)
Date: Mon, 12 Jun 2023 09:01:28 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-trivial@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 2/2] hw/char/parallel-isa: Export struct ISAParallelState
In-Reply-To: <229b5f39-2a3e-e47b-5269-9ae2c43492ae@eik.bme.hu>
References: <20230611110008.32638-1-shentey@gmail.com>
 <20230611110008.32638-3-shentey@gmail.com>
 <229b5f39-2a3e-e47b-5269-9ae2c43492ae@eik.bme.hu>
Message-ID: <F47D47A6-B68A-46E7-BF36-C6447AC8E4CD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x534.google.com
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



Am 11=2E Juni 2023 13:15:58 UTC schrieb BALATON Zoltan <balaton@eik=2Ebme=
=2Ehu>:
>On Sun, 11 Jun 2023, Bernhard Beschow wrote:
>> Allows the struct to be embedded directly into device models without ad=
ditional
>> allocation=2E
>>=20
>> Suggested-by: Mark Cave-Ayland <mark=2Ecave-ayland@ilande=2Eco=2Euk>
>
>Patches missing SoB, checkpatch should have cought this=2E

Thanks for catching again=2E Fixed in v2=2E

>
>I don't see any of the machines or device models actually embedding ISAPa=
rallelState or ParallelState so don't know what this patch is trying to ach=
ieve=2E Please post the whole series with the patches that this is a prepar=
ation for so we can se where this leads=2E

No further plans from my side=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>> ---
>> include/hw/char/parallel-isa=2Eh | 46 +++++++++++++++++++++++++++++++++=
+
>> include/hw/char/parallel=2Eh     |  2 --
>> hw/char/parallel-isa=2Ec         |  1 +
>> hw/char/parallel=2Ec             | 12 +--------
>> hw/i386/pc_piix=2Ec              |  2 +-
>> hw/i386/pc_q35=2Ec               |  2 +-
>> hw/isa/isa-superio=2Ec           |  1 +
>> hw/sparc64/sun4u=2Ec             |  2 +-
>> 8 files changed, 52 insertions(+), 16 deletions(-)
>> create mode 100644 include/hw/char/parallel-isa=2Eh
>>=20
>> diff --git a/include/hw/char/parallel-isa=2Eh b/include/hw/char/paralle=
l-isa=2Eh
>> new file mode 100644
>> index 0000000000=2E=2E27bdacf1a3
>> --- /dev/null
>> +++ b/include/hw/char/parallel-isa=2Eh
>> @@ -0,0 +1,46 @@
>> +/*
>> + * QEMU ISA Parallel PORT emulation
>> + *
>> + * Copyright (c) 2003-2005 Fabrice Bellard
>> + * Copyright (c) 2007 Marko Kohtala
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
>> + * of this software and associated documentation files (the "Software"=
), to deal
>> + * in the Software without restriction, including without limitation t=
he rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
>> + * copies of the Software, and to permit persons to whom the Software =
is
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be incl=
uded in
>> + * all copies or substantial portions of the Software=2E
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT=
 SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
>> + * THE SOFTWARE=2E
>> + */
>> +
>> +#ifndef HW_PARALLEL_ISA_H
>> +#define HW_PARALLEL_ISA_H
>> +
>> +#include "parallel=2Eh"
>> +
>> +#include "hw/isa/isa=2Eh"
>> +#include "qom/object=2Eh"
>> +
>> +#define TYPE_ISA_PARALLEL "isa-parallel"
>> +OBJECT_DECLARE_SIMPLE_TYPE(ISAParallelState, ISA_PARALLEL)
>> +
>> +struct ISAParallelState {
>> +    ISADevice parent_obj;
>> +
>> +    uint32_t index;
>> +    uint32_t iobase;
>> +    uint32_t isairq;
>> +    ParallelState state;
>> +};
>> +
>> +#endif /* HW_PARALLEL_ISA_H */
>> diff --git a/include/hw/char/parallel=2Eh b/include/hw/char/parallel=2E=
h
>> index 9f76edca81=2E=2E7b5a309a03 100644
>> --- a/include/hw/char/parallel=2Eh
>> +++ b/include/hw/char/parallel=2Eh
>> @@ -25,8 +25,6 @@ typedef struct ParallelState {
>>     PortioList portio_list;
>> } ParallelState;
>>=20
>> -#define TYPE_ISA_PARALLEL "isa-parallel"
>> -
>> void parallel_hds_isa_init(ISABus *bus, int n);
>>=20
>> bool parallel_mm_init(MemoryRegion *address_space,
>> diff --git a/hw/char/parallel-isa=2Ec b/hw/char/parallel-isa=2Ec
>> index 547ae69304=2E=2Eab0f879998 100644
>> --- a/hw/char/parallel-isa=2Ec
>> +++ b/hw/char/parallel-isa=2Ec
>> @@ -13,6 +13,7 @@
>> #include "sysemu/sysemu=2Eh"
>> #include "hw/isa/isa=2Eh"
>> #include "hw/qdev-properties=2Eh"
>> +#include "hw/char/parallel-isa=2Eh"
>> #include "hw/char/parallel=2Eh"
>> #include "qapi/error=2Eh"
>>=20
>> diff --git a/hw/char/parallel=2Ec b/hw/char/parallel=2Ec
>> index e75fc5019d=2E=2E147c900f0d 100644
>> --- a/hw/char/parallel=2Ec
>> +++ b/hw/char/parallel=2Ec
>> @@ -31,6 +31,7 @@
>> #include "hw/qdev-properties=2Eh"
>> #include "hw/qdev-properties-system=2Eh"
>> #include "migration/vmstate=2Eh"
>> +#include "hw/char/parallel-isa=2Eh"
>> #include "hw/char/parallel=2Eh"
>> #include "sysemu/reset=2Eh"
>> #include "sysemu/sysemu=2Eh"
>> @@ -73,17 +74,6 @@
>>=20
>> #define PARA_CTR_SIGNAL (PARA_CTR_SELECT|PARA_CTR_INIT|PARA_CTR_AUTOLF|=
PARA_CTR_STROBE)
>>=20
>> -OBJECT_DECLARE_SIMPLE_TYPE(ISAParallelState, ISA_PARALLEL)
>> -
>> -struct ISAParallelState {
>> -    ISADevice parent_obj;
>> -
>> -    uint32_t index;
>> -    uint32_t iobase;
>> -    uint32_t isairq;
>> -    ParallelState state;
>> -};
>> -
>> static void parallel_update_irq(ParallelState *s)
>> {
>>     if (s->irq_pending)
>> diff --git a/hw/i386/pc_piix=2Ec b/hw/i386/pc_piix=2Ec
>> index 42af03dbb4=2E=2E44146e6ff5 100644
>> --- a/hw/i386/pc_piix=2Ec
>> +++ b/hw/i386/pc_piix=2Ec
>> @@ -26,7 +26,7 @@
>> #include CONFIG_DEVICES
>>=20
>> #include "qemu/units=2Eh"
>> -#include "hw/char/parallel=2Eh"
>> +#include "hw/char/parallel-isa=2Eh"
>> #include "hw/dma/i8257=2Eh"
>> #include "hw/loader=2Eh"
>> #include "hw/i386/x86=2Eh"
>> diff --git a/hw/i386/pc_q35=2Ec b/hw/i386/pc_q35=2Ec
>> index 6155427e48=2E=2Ea9a59ed42b 100644
>> --- a/hw/i386/pc_q35=2Ec
>> +++ b/hw/i386/pc_q35=2Ec
>> @@ -30,7 +30,7 @@
>>=20
>> #include "qemu/osdep=2Eh"
>> #include "qemu/units=2Eh"
>> -#include "hw/char/parallel=2Eh"
>> +#include "hw/char/parallel-isa=2Eh"
>> #include "hw/loader=2Eh"
>> #include "hw/i2c/smbus_eeprom=2Eh"
>> #include "hw/rtc/mc146818rtc=2Eh"
>> diff --git a/hw/isa/isa-superio=2Ec b/hw/isa/isa-superio=2Ec
>> index 9292ec3bcf=2E=2E7dbfc374da 100644
>> --- a/hw/isa/isa-superio=2Ec
>> +++ b/hw/isa/isa-superio=2Ec
>> @@ -21,6 +21,7 @@
>> #include "hw/isa/superio=2Eh"
>> #include "hw/qdev-properties=2Eh"
>> #include "hw/input/i8042=2Eh"
>> +#include "hw/char/parallel-isa=2Eh"
>> #include "hw/char/serial=2Eh"
>> #include "trace=2Eh"
>>=20
>> diff --git a/hw/sparc64/sun4u=2Ec b/hw/sparc64/sun4u=2Ec
>> index e2858a0331=2E=2E29e9b6cc26 100644
>> --- a/hw/sparc64/sun4u=2Ec
>> +++ b/hw/sparc64/sun4u=2Ec
>> @@ -35,7 +35,7 @@
>> #include "hw/qdev-properties=2Eh"
>> #include "hw/pci-host/sabre=2Eh"
>> #include "hw/char/serial=2Eh"
>> -#include "hw/char/parallel=2Eh"
>> +#include "hw/char/parallel-isa=2Eh"
>> #include "hw/rtc/m48t59=2Eh"
>> #include "migration/vmstate=2Eh"
>> #include "hw/input/i8042=2Eh"
>>=20

