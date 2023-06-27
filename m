Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6AA73FBA6
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:04:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7QD-0008Ad-KX; Tue, 27 Jun 2023 08:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ApJ+=CP=kaod.org=clg@ozlabs.org>)
 id 1qE7QB-00089g-9L; Tue, 27 Jun 2023 08:03:47 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ApJ+=CP=kaod.org=clg@ozlabs.org>)
 id 1qE7Q8-0007j6-Hz; Tue, 27 Jun 2023 08:03:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qr3Jq0cblz4wqV;
 Tue, 27 Jun 2023 22:03:39 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qr3Jj699jz4wZv;
 Tue, 27 Jun 2023 22:03:33 +1000 (AEST)
Message-ID: <ce56f339-461f-0854-cd4e-03ec750d6770@kaod.org>
Date: Tue, 27 Jun 2023 14:03:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/4] target/ppc: Catch invalid real address accesses
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>
References: <20230623081953.290875-1-npiggin@gmail.com>
 <CAFEAcA_Brf-R12t+DKNAoygqgC-qjKJ3Wiz4ULjGHOo8_vPovw@mail.gmail.com>
 <47197a73-b106-47d5-9502-393a6bdc9945@redhat.com>
 <966b3fce-512d-f122-e76e-efded0db9731@kaod.org>
 <cefdeb3f-3442-ede4-3e5d-6a4a99b38293@ilande.co.uk>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <cefdeb3f-3442-ede4-3e5d-6a4a99b38293@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=ApJ+=CP=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.103,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

>> Mac OS 9.2 fails to boot with a popup saying :
>>          Sorry, a system error occured.
>>          "Sound Manager"
>>            address error
>>          To temporarily turn off extensions, restart and
>>          hold down the shift key
>>
>>
>> Darwin and Mac OSX look OK.
> 
> My guess would be that MacOS 9.2 is trying to access the sound chip registers which isn't implemented in QEMU for the moment (I have a separate screamer branch available, but it's not ready for primetime yet). In theory they shouldn't be accessed at all because the sound device isn't present in the OpenBIOS device tree, but this is all fairly old stuff.
> 
> Does implementing the sound registers using a dummy device help at all?

Nope. OS 9 loops earlier (little black/white disk spinning).

Thanks,

C.



  
> 
> 
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index 265c0bbd8d..e55f938da7 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -26,6 +26,7 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
>   #include "qemu/module.h"
> +#include "hw/misc/unimp.h"
>   #include "hw/misc/macio/cuda.h"
>   #include "hw/pci/pci.h"
>   #include "hw/ppc/mac_dbdma.h"
> @@ -94,6 +95,7 @@ static bool macio_common_realize(PCIDevice *d, Error **errp)
>   {
>       MacIOState *s = MACIO(d);
>       SysBusDevice *sbd;
> +    DeviceState *dev;
> 
>       if (!qdev_realize(DEVICE(&s->dbdma), BUS(&s->macio_bus), errp)) {
>           return false;
> @@ -102,6 +104,14 @@ static bool macio_common_realize(PCIDevice *d, Error **errp)
>       memory_region_add_subregion(&s->bar, 0x08000,
>                                   sysbus_mmio_get_region(sbd, 0));
> 
> +    dev = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
> +    qdev_prop_set_string(dev, "name", "screamer");
> +    qdev_prop_set_uint64(dev, "size", 0x1000);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sbd = SYS_BUS_DEVICE(dev);
> +    memory_region_add_subregion(&s->bar, 0x14000,
> +                                sysbus_mmio_get_region(sbd, 0));
> +
>       qdev_prop_set_uint32(DEVICE(&s->escc), "disabled", 0);
>       qdev_prop_set_uint32(DEVICE(&s->escc), "frequency", ESCC_CLOCK);
>       qdev_prop_set_uint32(DEVICE(&s->escc), "it_shift", 4);
> diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
> index 86df2c2b60..1894178a68 100644
> --- a/include/hw/misc/macio/macio.h
> +++ b/include/hw/misc/macio/macio.h
> @@ -109,6 +109,7 @@ struct MacIOState {
>       PMUState pmu;
>       DBDMAState dbdma;
>       ESCCState escc;
> +    MemoryRegion screamer;
>       uint64_t frequency;
>   };
> 
> 
> 
> ATB,
> 
> Mark.


