Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9F5718B14
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:24:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SLe-000592-1b; Wed, 31 May 2023 16:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SLY-00050o-0d
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:23:04 -0400
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SLW-0000mi-BX
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:23:03 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N7RHv-1q9aCE3rPp-017ig6; Wed, 31 May 2023 22:23:00 +0200
Message-ID: <b05f798a-0d24-c7ea-5940-0a4a0fe66f23@vivier.eu>
Date: Wed, 31 May 2023 22:22:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 06/23] q800: move ROM memory region to Q800MachineState
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-7-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230531125400.288917-7-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3QnM1fDdBFM5AT4J7Od+5/rmdJxgCWAmcpAQey3yreKxPagvuTL
 zZcYI1kCCGtEU8nD+qxZlctDBq/8pReGVmA68PdQFUwCxdJq58Qcei5L7MoMbe9+CAZSUmq
 AI/NhG/53eXMj9UoSViZ+49CMllF/CdL/PxV8+gMr49kh9E/iiC+FVVVlhZefy2xkwp1fXn
 VYrmBh6N7XiZtQWtz/KLg==
UI-OutboundReport: notjunk:1;M01:P0:DZueG62Vb5c=;6GcHNazmrFNBdeqGpmFGEVKjO2E
 6pC1QI6fn6taGF5MJ27yKyo5PNqE6AuNC8Bncqa/Ud6XVtTHgu46D1Q7n52lLd/VH07Bb4JFS
 AsLvc+gTqUpu8V/OiZDnNcuICsBl9hT0r8U3OgyLfUmLEuDaTWDUb0eLlxaCPkJo2RFLTMy48
 8gG4tKHFm+4Zhb8O3IBUwfm9boPs2aFEhuqm9ZSg48y8MuNqtRZXImNsDi4hG7g7zh9QSpuye
 jvwRs2bVhZNpKMqFRAuBZmxdcmUQ8qLtde59mf0MGGyVQoPZghqNPj90BSBkoB0QD0zhSH0bm
 otcgu5rxIFhiJ6vQ1W8RE/ttJdOY/+MNXolukIRthcxnr5efmZGfgT1nO7Bf5gSkOOjCT2RYK
 JfxRaLlM85xECaN0pfx1Nrfo59G1xniikZz3eia2pTGaLnW00+GmnkYfO/HWT1Oi+x75E0SMK
 jjMyYFL+1rC7TPIy4k4b3YoKHTg/u25CepKAGWhpZ1+5GmKZRBGl/OM/4pXUbz4vzDdMPwLjM
 d6ADdKBVsKEQNqYeaZR7QuMrj8jGzjKYNXXYjMrpoq306VejETSQotLoot0TDZr2vQS3IRUBR
 Uf9k4xHZ9ewvb6ggr+cK4D2n+uEbMyl7uGyh8YOfugH3z8PPQDOWl24y2yzWnwwt1sUdR4Z9K
 4ilFF+o7gloXRc5Aol6qrRg2b4lnd8yI8mMkUs+j3w==
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Le 31/05/2023 à 14:53, Mark Cave-Ayland a écrit :
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 13 +++++--------
>   include/hw/m68k/q800.h |  1 +
>   2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index c34b2548ca..3d0a56d9f3 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -372,7 +372,6 @@ static void q800_machine_init(MachineState *machine)
>       int bios_size;
>       ram_addr_t initrd_base;
>       int32_t initrd_size;
> -    MemoryRegion *rom;
>       MemoryRegion *io;
>       MemoryRegion *dp8393x_prom = g_new(MemoryRegion, 1);
>       uint8_t *prom;
> @@ -647,11 +646,10 @@ static void q800_machine_init(MachineState *machine)
>           BOOTINFO1(param_ptr, BI_MAC_VROW, macfb_mode->stride);
>           BOOTINFO1(param_ptr, BI_MAC_SCCBASE, SCC_BASE);
>   
> -        rom = g_malloc(sizeof(*rom));
> -        memory_region_init_ram_ptr(rom, NULL, "m68k_fake_mac.rom",
> +        memory_region_init_ram_ptr(&m->rom, NULL, "m68k_fake_mac.rom",
>                                      sizeof(fake_mac_rom), fake_mac_rom);
> -        memory_region_set_readonly(rom, true);
> -        memory_region_add_subregion(get_system_memory(), MACROM_ADDR, rom);
> +        memory_region_set_readonly(&m->rom, true);
> +        memory_region_add_subregion(get_system_memory(), MACROM_ADDR, &m->rom);
>   
>           if (kernel_cmdline) {
>               BOOTINFOSTR(param_ptr, BI_COMMAND_LINE,
> @@ -693,11 +691,10 @@ static void q800_machine_init(MachineState *machine)
>       } else {
>           uint8_t *ptr;
>           /* allocate and load BIOS */
> -        rom = g_malloc(sizeof(*rom));
> -        memory_region_init_rom(rom, NULL, "m68k_mac.rom", MACROM_SIZE,
> +        memory_region_init_rom(&m->rom, NULL, "m68k_mac.rom", MACROM_SIZE,
>                                  &error_abort);
>           filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> -        memory_region_add_subregion(get_system_memory(), MACROM_ADDR, rom);
> +        memory_region_add_subregion(get_system_memory(), MACROM_ADDR, &m->rom);
>   
>           /* Load MacROM binary */
>           if (filename) {
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index 0f54f1c2cf..3e41f0e297 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -31,6 +31,7 @@ struct Q800MachineState {
>       MachineState parent_obj;
>   
>       M68kCPU cpu;
> +    MemoryRegion rom;
>   };
>   
>   #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


