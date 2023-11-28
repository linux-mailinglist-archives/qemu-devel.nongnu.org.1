Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E58EF7FBA76
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 13:48:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7xUs-0005mK-Iv; Tue, 28 Nov 2023 07:47:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=PHl3=HJ=kaod.org=clg@ozlabs.org>)
 id 1r7xUq-0005m7-NE; Tue, 28 Nov 2023 07:47:24 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=PHl3=HJ=kaod.org=clg@ozlabs.org>)
 id 1r7xUn-00069e-UC; Tue, 28 Nov 2023 07:47:24 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Sfj0356bSz4wc3;
 Tue, 28 Nov 2023 23:47:15 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sfhzz62fKz4xPh;
 Tue, 28 Nov 2023 23:47:11 +1100 (AEDT)
Message-ID: <8df98507-3b2f-426e-ab25-f571f06c769b@kaod.org>
Date: Tue, 28 Nov 2023 13:47:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ppc/amigaone: Allow running AmigaOS without firmware
 image
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, philmd@linaro.org
References: <20231128013253.80524756078@zero.eik.bme.hu>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231128013253.80524756078@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=PHl3=HJ=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 11/28/23 02:32, BALATON Zoltan wrote:
> The machine uses a modified U-Boot under GPL license but the sources
> of it are lost with only a binary available so it cannot be included
> in QEMU. Allow running without the firmware image which can be used
> when calling a boot loader directly and thus simplifying booting
> guests. We need a small routine that AmigaOS calls from ROM which is
> added in this case to allow booting AmigaOS without external firmware
> image.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Since this is 8.2 material :


Fixes: d9656f860a38 ("hw/ppc: Add emulation of AmigaOne XE board")


Thanks,

C.



> ---
> v3: Instead of -bios none do this when no -bios option given, use
> constants for address and rom_add_blob_fixed() to add dummy_fw.
> This makes both code and usage a bit simpler.
> 
>   hw/ppc/amigaone.c | 35 +++++++++++++++++++++++------------
>   1 file changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
> index 992a55e632..ddfa09457a 100644
> --- a/hw/ppc/amigaone.c
> +++ b/hw/ppc/amigaone.c
> @@ -36,10 +36,19 @@
>    * -device VGA,romfile=VGABIOS-lgpl-latest.bin
>    * from http://www.nongnu.org/vgabios/ instead.
>    */
> -#define PROM_FILENAME "u-boot-amigaone.bin"
>   #define PROM_ADDR 0xfff00000
>   #define PROM_SIZE (512 * KiB)
>   
> +/* AmigaOS calls this routine from ROM, use this if no firmware loaded */
> +static const char dummy_fw[] = {
> +    0x38, 0x00, 0x00, 0x08, /* li      r0,8 */
> +    0x7c, 0x09, 0x03, 0xa6, /* mtctr   r0 */
> +    0x54, 0x63, 0xf8, 0x7e, /* srwi    r3,r3,1 */
> +    0x42, 0x00, 0xff, 0xfc, /* bdnz    0x8 */
> +    0x7c, 0x63, 0x18, 0xf8, /* not     r3,r3 */
> +    0x4e, 0x80, 0x00, 0x20, /* blr */
> +};
> +
>   static void amigaone_cpu_reset(void *opaque)
>   {
>       PowerPCCPU *cpu = opaque;
> @@ -60,8 +69,6 @@ static void amigaone_init(MachineState *machine)
>       PowerPCCPU *cpu;
>       CPUPPCState *env;
>       MemoryRegion *rom, *pci_mem, *mr;
> -    const char *fwname = machine->firmware ?: PROM_FILENAME;
> -    char *filename;
>       ssize_t sz;
>       PCIBus *pci_bus;
>       Object *via;
> @@ -94,20 +101,24 @@ static void amigaone_init(MachineState *machine)
>       }
>   
>       /* allocate and load firmware */
> -    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, fwname);
> -    if (filename) {
> -        rom = g_new(MemoryRegion, 1);
> -        memory_region_init_rom(rom, NULL, "rom", PROM_SIZE, &error_fatal);
> -        memory_region_add_subregion(get_system_memory(), PROM_ADDR, rom);
> +    rom = g_new(MemoryRegion, 1);
> +    memory_region_init_rom(rom, NULL, "rom", PROM_SIZE, &error_fatal);
> +    memory_region_add_subregion(get_system_memory(), PROM_ADDR, rom);
> +    if (!machine->firmware) {
> +        rom_add_blob_fixed("dummy-fw", dummy_fw, sizeof(dummy_fw),
> +                           PROM_ADDR + PROM_SIZE - 0x80);
> +    } else {
> +        g_autofree char *filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
> +                                                   machine->firmware);
> +        if (!filename) {
> +            error_report("Could not find firmware '%s'", machine->firmware);
> +            exit(1);
> +        }
>           sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE);
>           if (sz <= 0 || sz > PROM_SIZE) {
>               error_report("Could not load firmware '%s'", filename);
>               exit(1);
>           }
> -        g_free(filename);
> -    } else if (!qtest_enabled()) {
> -        error_report("Could not find firmware '%s'", fwname);
> -        exit(1);
>       }
>   
>       /* Articia S */


