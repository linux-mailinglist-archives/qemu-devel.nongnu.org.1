Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BA481F8F4
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 15:03:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIqxw-0006zc-1S; Thu, 28 Dec 2023 09:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1rIqxt-0006zK-7A
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 09:02:25 -0500
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1rIqxr-0007PR-Fp
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 09:02:24 -0500
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MIdW7-1rUcX90cNB-00EZvP; Thu, 28 Dec 2023 15:02:18 +0100
Message-ID: <528851f9-0164-4209-bfd8-a9b3c79f978d@vivier.eu>
Date: Thu, 28 Dec 2023 15:02:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] q800: move dp8393x_prom memory region to Q800MachineState
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, huth@tuxfamily.org,
 qemu-devel@nongnu.org
References: <20231227210212.245106-1-mark.cave-ayland@ilande.co.uk>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20231227210212.245106-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FOY1sTLWl24tOmyUtz+zV+ckmq4EHsLsF24qhDxJ7h2lXPWd2YB
 53QSOZLsyOO56xUB9qPOUldcgB3T4fyqBnQDw22w16iJn5raBHIUE6Dcp+BQdpJ7UQZuPfn
 7UV8ZK7V0nSuepKjaNtkAB9aZWN41CMwDD7Ust31T46c28S7+QZlK48ZMzT141XxqAJVI6N
 G2CGZfIwkzClV7FVaTcLA==
UI-OutboundReport: notjunk:1;M01:P0:nQ8hX66uY7M=;Az+zGTLTbjT7G726ir+mqa2EE8G
 jLHlusWGJybf28kSEoq8Q7rY4ELev1pWY/Y840dkYn3P/jYNApnK0/E1X1NZmtvY7U/Q1CNfN
 H29ZdFJyjeZ76O+aJmnhstrPicZ5LAM6IDN3LzJHH4eVNst944alCIJjQFrwVeYArfJfbXEn3
 hRLrlfmgowFzJFyc998RMntg6Nletfjmofbd48s9FOsTIJRT4tIEkk8c+U+wTn54IqtOttXl4
 SO2n0lsWRNGlNvG75kskTORBKsXdzKA9dTpZyoBcl/w/1bJgfMRtTlSFAO98FaA9RFai7qih0
 A/hNuWutStVp+uyiZik5CeeSuVK9R1knYaK9EMej5caCQ3n/IDQXJOxXA8Eg2LtJdEaAFfBiw
 Spo0cb+BnbSksZiK/gmZEKpcV7QrmSZez0PoYIF6ZY0B5xDBKrVdy6BBY8cNuSgSwJa2vMVtF
 7kRUInCpKMMhL2UChLpO4Pw1WVmrVhs+UZpMYO326kAmpV1dr8eGxdXqNx48kDxtJr4CYgtA9
 KUCQXqPOpPR0r46Ln8Xr/NSdAu7D34fq2mGTWMCy5CMla6OgKgA0wyqeJGyFZUZpFh1QEPXi4
 OedTZR/fEP6YJGtquBV4zH5OahpZ3khS8ioGs5Vcx6zOq60yQskX6Lyl75OjPdRmAMahqK5vb
 GrzCCyREW7rLoUb2VvRbe+saC9W9TAjp8kqeaSFB8+yo/tgNMuMiUwMpK9A5ees4stkYMKxJH
 1eKJgjj/R1FgAT67xNt3/qzFlpBIf+vIuTGum2wLSVmSGGYl22fT9nCZA+pLXpQGLixQcpiow
 TkLt4Pr+sZ7HL1PgwuLyWyHW5N461GdNp7/Fw+srv+R1bIN59QgS/bLroT/8RMqtPwgOyfpgT
 HWN/fCTXWAGJaCg==
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Le 27/12/2023 à 22:02, Mark Cave-Ayland a écrit :
> There is no need to dynamically allocate the memory region from the heap.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 7 +++----
>   include/hw/m68k/q800.h | 1 +
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 83d1571d02..b80a3b6d5f 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -253,7 +253,6 @@ static void q800_machine_init(MachineState *machine)
>       int bios_size;
>       ram_addr_t initrd_base;
>       int32_t initrd_size;
> -    MemoryRegion *dp8393x_prom = g_new(MemoryRegion, 1);
>       uint8_t *prom;
>       int i, checksum;
>       MacFbMode *macfb_mode;
> @@ -406,13 +405,13 @@ static void q800_machine_init(MachineState *machine)
>       sysbus_connect_irq(sysbus, 0,
>                          qdev_get_gpio_in(DEVICE(&m->glue), GLUE_IRQ_IN_SONIC));
>   
> -    memory_region_init_rom(dp8393x_prom, NULL, "dp8393x-q800.prom",
> +    memory_region_init_rom(&m->dp8393x_prom, NULL, "dp8393x-q800.prom",
>                              SONIC_PROM_SIZE, &error_fatal);
>       memory_region_add_subregion(get_system_memory(), SONIC_PROM_BASE,
> -                                dp8393x_prom);
> +                                &m->dp8393x_prom);
>   
>       /* Add MAC address with valid checksum to PROM */
> -    prom = memory_region_get_ram_ptr(dp8393x_prom);
> +    prom = memory_region_get_ram_ptr(&m->dp8393x_prom);
>       checksum = 0;
>       for (i = 0; i < 6; i++) {
>           prom[i] = revbit8(nd_table[0].macaddr.a[i]);
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index a9661f65f6..34365c9860 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -55,6 +55,7 @@ struct Q800MachineState {
>       MOS6522Q800VIA1State via1;
>       MOS6522Q800VIA2State via2;
>       dp8393xState dp8393x;
> +    MemoryRegion dp8393x_prom;
>       ESCCState escc;
>       OrIRQState escc_orgate;
>       SysBusESPState esp;

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

