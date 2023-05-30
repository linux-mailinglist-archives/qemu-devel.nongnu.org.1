Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBF5715CEB
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:20:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xOM-00069C-9J; Tue, 30 May 2023 07:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xO3-000692-Iz
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:19:35 -0400
Received: from mout.kundenserver.de ([217.72.192.73])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xO1-0004Ii-U6
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:19:35 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MbRbr-1qevpl0rJR-00bq9o; Tue, 30 May 2023 13:19:32 +0200
Message-ID: <39fbbb63-0d65-dac1-134d-510b9b3c6944@vivier.eu>
Date: Tue, 30 May 2023 13:19:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 05/30] q800: move ROM memory region to Q800MachineState
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
 <20230524211104.686087-6-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230524211104.686087-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:H14YCVthMeT0hVmNQE2H3pJLl4blryCmuNZO9VXlsJKOfYzequ4
 oKPOa5YIs2w5ehamdYinBg6AQYTEEFH/zLUJBTzrPyJXdblZUd8C2IDjUpyq8eAMQnnxtjD
 MpdqfjqPZLEVjER+EMwxHV+ipJl8d+XXtE5S+4Tbz3v3TBu0K8ZjtdVpaNpwp8uFGhmtk+v
 8M3PfoKxqMTKoprXb5QTA==
UI-OutboundReport: notjunk:1;M01:P0:bY3A4My8N2g=;3y8w76uGhxGxWjzRVw0x3RZLdRb
 /zZTFB/occMyaUi/H6PMPxBe+bRNuZ+xJI53MqFe1XR+3ENnEANnIegZrfmvUVwVimh6t/Pmk
 Q/DC43CxufM0M7yxQe3Kf9u4mLUX6G6PU++hc4fXomEpCmdcPeHMXPZr4E0ZjEaOZHuyTgMNm
 GRok3/n5iVSOig364ueAaEbSPRqvAgw0c1LLX+GOn3JqvuvZOEer55v7TfJRRzmK/YTYrhovB
 GlrinYG3niH0wNz9r+ULdZ/5zyIHL+b0wCz7gAW4b21ZoTh4zgdkVgFfGbx5ZrHHBCOJP2C2B
 CiynYpI4qNfMyNP+MPPTXQQbvsO+Zq5OJlIMwzsJdY/vUJ70HQymReyz9l88b2TcvYQrvUb7o
 FZOPPNKQAuRplqaA0M7Tyr7zwld2vQCe4vp0ZRGYUk0/gGgAvrCzqa2pFkjpGSths5GFCQM4S
 FRBkp2QcsWa4N2uPGG1Y9DX+6eDdJLJyFhXMIFNJBSbHNEBLCRLydSFOOurPNM8ESjw5Qm6Xh
 tccMWklR/oOs4JaO1Su3DLUj+yn42DAJRssEKGwQSdP1fxvy506juKC6HpWvykOLe8pZ37z9r
 grb/yLnKiESGPiFbGD8XGO7uKaM8+dEX1JXDFadrUlYTNREIKLMFfhHYKldxhRc8FrrdstNCZ
 ojAAKAM2d5fg+fNPos2GXAZslsAQbrUJ4qN6M8YI9Q==
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Le 24/05/2023 à 23:10, Mark Cave-Ayland a écrit :
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 13 +++++--------
>   include/hw/m68k/q800.h |  1 +
>   2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index ee6175ceb4..6a000ceb75 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -371,7 +371,6 @@ static void q800_machine_init(MachineState *machine)
>       int bios_size;
>       ram_addr_t initrd_base;
>       int32_t initrd_size;
> -    MemoryRegion *rom;
>       MemoryRegion *io;
>       MemoryRegion *dp8393x_prom = g_new(MemoryRegion, 1);
>       uint8_t *prom;
> @@ -643,11 +642,10 @@ static void q800_machine_init(MachineState *machine)
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
> @@ -689,11 +687,10 @@ static void q800_machine_init(MachineState *machine)
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
> index 5867c3ae33..2f3c720b8d 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -31,6 +31,7 @@ struct Q800MachineState {
>       MachineState parent_obj;
>   
>       M68kCPU *cpu;
> +    MemoryRegion rom;
>   };
>   
>   #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


