Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C09A9F14AC
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Dec 2024 19:06:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMA1n-0004Tq-5C; Fri, 13 Dec 2024 13:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tMA1f-0004T9-Ez; Fri, 13 Dec 2024 13:04:31 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tMA1d-0008Gk-Ia; Fri, 13 Dec 2024 13:04:31 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa66e4d1d5aso323946166b.2; 
 Fri, 13 Dec 2024 10:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734113065; x=1734717865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZAdsWK52VAb8fudDg9PRQ5VSPYseUmnxkNdC1pBytY=;
 b=WBqqndd2+iND0uGaDVzWn0GC605mY7rXTkZLpWSTSCKeiN0Oz8F0ip3lLjmfu7eLUY
 /aV5wMmKs4d7TUSLGzTv11jGDBNgLVzcnOdaIDEXKITXFVk3WYbdHpDeKiNeTXWNdhnQ
 37UhbCs/FyEBBgIjTOI90h1irFsK6rDOxnfzNQCin/nGSDB3taZFARMj2gYjmKGWCqI6
 vFNc7kzpABZdTH+Y08gtAAetENpj6uw65OoKunL0fr6u7oAk8pch1h1kaNI1+hroyv7F
 EVCY8g09tax7CYl7Bp5XfI5YtHr+1v50LnYxd2YoaO8SXXBU26d1QA4tqiueayH9Qw8f
 HUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734113065; x=1734717865;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZAdsWK52VAb8fudDg9PRQ5VSPYseUmnxkNdC1pBytY=;
 b=ddq1dlTQJv28HEDQzidtk5uAjsZm5ErVruLdLNqKzJmlrHeUoolLKy/61pP8fbvuJC
 kp8ZTBBehbRW9tvrwix83Ar4IAG5Fh+2wmzCvIKvR+TmarKLLl93shSALfb6ltM/dYLZ
 6A4rWs7xXnwnI5z5lqFA0zrZJmoaHYW/vZOJxqC+9sWfhaFlEfpU6mAVo5/1znZj2/r/
 8wlYyz87gDHlxId+2rokDy1fEpHZIa5KjIEJJ7gYNEId7NJVepf8+rt/aQ7hZk3hXgkP
 bGxmFOHbK/hT5i8LM1v3pa4uWr7wPodKdcDWmVOWzZG88/eBqNPFjPJd5phhGzr17KtP
 LtZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPGvQovcTj0S3ZVMU/NBVMu5ddX+zBo4Lso3zIU0/WcSWCIYQ1nvXj7Mm6VWDBO9Gkg097mdtrr3CRdQ==@nongnu.org,
 AJvYcCVCTyvFYjYsfJR7JLXEE5FGnHK4Bn1KnuBMog8imCUkXCKuZD7wNRc20D872E17vyvf438rp3vbGQ==@nongnu.org
X-Gm-Message-State: AOJu0Yw5AZMcZ4T21BVts4iohzjUPa89HxswRoiS6+X2SHWz5WI1F+dw
 kjv+7TchwC22bPJPbqStR2E6XVQ8SYDgDUWFmGlZHUs5m0NjqjRX
X-Gm-Gg: ASbGncu7t/zlOnO90Q719N26R7dKN+oZ34qB7C12AwdXrv95L+39I/Z47KMsRHaFkNf
 GOGYWDhDXi5dI58T/YW5vvAgqpGcbteLdiHma4wintnv9W/jfonp3vm1dwNyl+sl3J1+1eG5EbG
 yUx+zWQi4F7xrcbXJG702Khvj6RQ6DL0PkF64dU9akYdzdX8Mwwhwaea/W+ODwHuvkR/Qjncboo
 qmomdaBoAkPrHlZy4mmPmK6LJTmdQVskNdGa+HIXwsD4inpGV5BwsVbwIqKcgYYrmQ9SVaKFCwH
 nHTodLVKZOxWtgWNvoJnRKFAdZBYtVY=
X-Google-Smtp-Source: AGHT+IGlisjCBIYC8gakRR2uLfury218/e1D5fgLj1rr8bc3FmZPjjyi+nlzKMK5FZBIoYhpOczexg==
X-Received: by 2002:a17:906:23e1:b0:aa6:96be:2bed with SMTP id
 a640c23a62f3a-aab77ee8ae6mr323074866b.59.1734113064881; 
 Fri, 13 Dec 2024 10:04:24 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-183-249-001.77.183.pool.telefonica.de.
 [77.183.249.1]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa69738cc14sm645753566b.105.2024.12.13.10.04.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 10:04:24 -0800 (PST)
Date: Fri, 13 Dec 2024 17:26:52 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 1/2] hw/ide/ahci: Decouple from PCI
In-Reply-To: <b87473d2-d132-42a4-8ca3-aaace8da7bf9@linaro.org>
References: <20241212110926.23548-1-shentey@gmail.com>
 <20241212110926.23548-2-shentey@gmail.com>
 <b87473d2-d132-42a4-8ca3-aaace8da7bf9@linaro.org>
Message-ID: <F723466D-FB22-485A-936E-1C4AAEEFF05E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



Am 13=2E Dezember 2024 14:41:46 UTC schrieb "Philippe Mathieu-Daud=C3=A9" =
<philmd@linaro=2Eorg>:
>On 12/12/24 12:09, Bernhard Beschow wrote:
>> In some adhoc profiling booting Linux VMs, it's observed that ahci_irq_=
lower()
>> can be a hot path (10000+ triggers until login prompt appears)=2E Even =
though the
>> parent device never changes, this method re-determines whether the pare=
nt device
>> is a PCI device or not using the rather expensive object_dynamic_cast()
>> function=2E Avoid this overhead by pushing the interrupt handling to th=
e parent
>> device, essentially turning AHCIState into an "IP block"=2E
>>=20
>> Note that this change also frees AHCIState from the PCI dependency whic=
h wasn't
>> reflected in Kconfig=2E
>>=20
>> Reported-by: Peter Xu <peterx@redhat=2Ecom>
>> Inspired-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   hw/ide/ahci-internal=2Eh    |  1 -
>>   include/hw/ide/ahci-pci=2Eh |  2 ++
>>   include/hw/ide/ahci=2Eh     |  2 --
>>   hw/ide/ahci=2Ec             | 39 ++++--------------------------------=
---
>>   hw/ide/ich=2Ec              | 19 +++++++++++++++----
>>   5 files changed, 21 insertions(+), 42 deletions(-)
>
>
>>   static void pci_ich9_reset(DeviceState *dev)
>>   {
>>       AHCIPCIState *d =3D ICH9_AHCI(dev);
>> @@ -102,7 +114,9 @@ static void pci_ich9_ahci_init(Object *obj)
>>   {
>>       AHCIPCIState *d =3D ICH9_AHCI(obj);
>>   +    qemu_init_irq(&d->irq, pci_ich9_ahci_update_irq, d, 0);
>>       ahci_init(&d->ahci, DEVICE(obj));
>> +    d->ahci=2Eirq =3D &d->irq;
>
>Pre-existing, but we shouldn't set this directly=2E
>Does the IRQState belong to AHCIState?

AHCIState isn't an Object, and therefore can't have any properties, so we =
can only set it directly=2E In the SysBus devices, d->ahci=2Eirq is treated=
 with sysbus_init_irq(), so needs to stay a pointer=2E

I tried to convert AHCIState into a SysBusDevice in order to access it via=
 these APIs, but that would create migration compatibility problems for the=
 q35 machine which was a rabbit hole I didn't want to get into=2E So I sett=
led on this solution=2E Any better proposals?

Best regards,
Bernhard

>
>>   }
>>     static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
>> @@ -125,8 +139,6 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, E=
rror **errp)
>>       /* XXX Software should program this register */
>>       dev->config[0x90]   =3D 1 << 6; /* Address Map Register - AHCI mo=
de */
>>   -    d->ahci=2Eirq =3D pci_allocate_irq(dev);
>> -
>>       pci_register_bar(dev, ICH9_IDP_BAR, PCI_BASE_ADDRESS_SPACE_IO,
>>                        &d->ahci=2Eidp);
>>       pci_register_bar(dev, ICH9_MEM_BAR, PCI_BASE_ADDRESS_SPACE_MEMORY=
,
>> @@ -161,7 +173,6 @@ static void pci_ich9_uninit(PCIDevice *dev)
>>         msi_uninit(dev);
>>       ahci_uninit(&d->ahci);
>> -    qemu_free_irq(d->ahci=2Eirq);
>>   }
>>     static void ich_ahci_class_init(ObjectClass *klass, void *data)
>

