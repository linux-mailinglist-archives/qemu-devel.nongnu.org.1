Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFB87BF9AE
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 13:27:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqAtA-0002W1-HM; Tue, 10 Oct 2023 07:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qqAt2-0002Tb-3t
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:26:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qqAsy-0007y1-Ko
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:26:51 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Dx_7vxNCVlo6EwAA--.34329S3;
 Tue, 10 Oct 2023 19:26:41 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx3y_tNCVlsmQeAA--.64388S3; 
 Tue, 10 Oct 2023 19:26:39 +0800 (CST)
Subject: Re: [PATCH v2] hw/loongarch: remove global loaderparams variable
To: =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>, qemu-devel@nongnu.org
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20231010-loongarch-loader-params-v2-1-512cc7959683@t-8ch.de>
From: gaosong <gaosong@loongson.cn>
Message-ID: <04426dc5-62da-5686-3b05-2d0747486eb2@loongson.cn>
Date: Tue, 10 Oct 2023 19:26:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20231010-loongarch-loader-params-v2-1-512cc7959683@t-8ch.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx3y_tNCVlsmQeAA--.64388S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3JF4UAFWxtry8ZFW7CFWrtFc_yoW7Wr4rpF
 W3u3WFqrs3Xrn5Aw17XrWUuFyYyw48Ga1YgFnrXw1ftFWqgry5AF45Ww12vFy2gaykGF1Y
 qFn8Jr42q3ZxJrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.339,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

在 2023/10/10 下午5:49, Thomas Weißschuh 写道:
> Passing the struct around explicitly makes the control-flow more
> obvious.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
> ---
> Changes in v2:
> - Drop initialize loaderparams variable
> - Link to v1: https://lore.kernel.org/qemu-devel/20231009210018.249776-1-thomas@t-8ch.de/
> ---
>   hw/loongarch/virt.c | 50 +++++++++++++++++++++++++++-----------------------
>   1 file changed, 27 insertions(+), 23 deletions(-)
> 
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
SOng Gao

> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 2629128aeda4..88bf0b0e97e1 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -47,6 +47,13 @@
>   #include "qemu/error-report.h"
>   
>   
> +struct loaderparams {
> +    uint64_t ram_size;
> +    const char *kernel_filename;
> +    const char *kernel_cmdline;
> +    const char *initrd_filename;
> +};
> +
>   static void virt_flash_create(LoongArchMachineState *lams)
>   {
>       DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
> @@ -411,24 +418,17 @@ static const MemoryRegionOps loongarch_virt_pm_ops = {
>       }
>   };
>   
> -static struct _loaderparams {
> -    uint64_t ram_size;
> -    const char *kernel_filename;
> -    const char *kernel_cmdline;
> -    const char *initrd_filename;
> -} loaderparams;
> -
>   static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
>   {
>       return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
>   }
>   
> -static int64_t load_kernel_info(void)
> +static int64_t load_kernel_info(const struct loaderparams *loaderparams)
>   {
>       uint64_t kernel_entry, kernel_low, kernel_high;
>       ssize_t kernel_size;
>   
> -    kernel_size = load_elf(loaderparams.kernel_filename, NULL,
> +    kernel_size = load_elf(loaderparams->kernel_filename, NULL,
>                              cpu_loongarch_virt_to_phys, NULL,
>                              &kernel_entry, &kernel_low,
>                              &kernel_high, NULL, 0,
> @@ -436,7 +436,7 @@ static int64_t load_kernel_info(void)
>   
>       if (kernel_size < 0) {
>           error_report("could not load kernel '%s': %s",
> -                     loaderparams.kernel_filename,
> +                     loaderparams->kernel_filename,
>                        load_elf_strerror(kernel_size));
>           exit(1);
>       }
> @@ -728,7 +728,8 @@ static void reset_load_elf(void *opaque)
>       }
>   }
>   
> -static void fw_cfg_add_kernel_info(FWCfgState *fw_cfg)
> +static void fw_cfg_add_kernel_info(const struct loaderparams *loaderparams,
> +                                   FWCfgState *fw_cfg)
>   {
>       /*
>        * Expose the kernel, the command line, and the initrd in fw_cfg.
> @@ -737,36 +738,38 @@ static void fw_cfg_add_kernel_info(FWCfgState *fw_cfg)
>        */
>       load_image_to_fw_cfg(fw_cfg,
>                            FW_CFG_KERNEL_SIZE, FW_CFG_KERNEL_DATA,
> -                         loaderparams.kernel_filename,
> +                         loaderparams->kernel_filename,
>                            false);
>   
> -    if (loaderparams.initrd_filename) {
> +    if (loaderparams->initrd_filename) {
>           load_image_to_fw_cfg(fw_cfg,
>                                FW_CFG_INITRD_SIZE, FW_CFG_INITRD_DATA,
> -                             loaderparams.initrd_filename, false);
> +                             loaderparams->initrd_filename, false);
>       }
>   
> -    if (loaderparams.kernel_cmdline) {
> +    if (loaderparams->kernel_cmdline) {
>           fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE,
> -                       strlen(loaderparams.kernel_cmdline) + 1);
> +                       strlen(loaderparams->kernel_cmdline) + 1);
>           fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA,
> -                          loaderparams.kernel_cmdline);
> +                          loaderparams->kernel_cmdline);
>       }
>   }
>   
> -static void loongarch_firmware_boot(LoongArchMachineState *lams)
> +static void loongarch_firmware_boot(LoongArchMachineState *lams,
> +                                    const struct loaderparams *loaderparams)
>   {
> -    fw_cfg_add_kernel_info(lams->fw_cfg);
> +    fw_cfg_add_kernel_info(loaderparams, lams->fw_cfg);
>   }
>   
> -static void loongarch_direct_kernel_boot(LoongArchMachineState *lams)
> +static void loongarch_direct_kernel_boot(LoongArchMachineState *lams,
> +                                         const struct loaderparams *loaderparams)
>   {
>       MachineState *machine = MACHINE(lams);
>       int64_t kernel_addr = 0;
>       LoongArchCPU *lacpu;
>       int i;
>   
> -    kernel_addr = load_kernel_info();
> +    kernel_addr = load_kernel_info(loaderparams);
>       if (!machine->firmware) {
>           for (i = 0; i < machine->smp.cpus; i++) {
>               lacpu = LOONGARCH_CPU(qemu_get_cpu(i));
> @@ -793,6 +796,7 @@ static void loongarch_init(MachineState *machine)
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>       CPUState *cpu;
>       char *ramName = NULL;
> +    struct loaderparams loaderparams = { };
>   
>       if (!cpu_model) {
>           cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
> @@ -898,9 +902,9 @@ static void loongarch_init(MachineState *machine)
>       /* load the kernel. */
>       if (loaderparams.kernel_filename) {
>           if (lams->bios_loaded) {
> -            loongarch_firmware_boot(lams);
> +            loongarch_firmware_boot(lams, &loaderparams);
>           } else {
> -            loongarch_direct_kernel_boot(lams);
> +            loongarch_direct_kernel_boot(lams, &loaderparams);
>           }
>       }
>       fdt_add_flash_node(lams);
> 
> ---
> base-commit: 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d
> change-id: 20231010-loongarch-loader-params-f0bc0b2cb5ea
> 
> Best regards,
> 


