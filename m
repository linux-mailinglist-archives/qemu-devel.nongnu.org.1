Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8285181AF50
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 08:21:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGDMM-000343-5d; Thu, 21 Dec 2023 02:20:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rGDMJ-00033V-Hw
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 02:20:43 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1rGDMG-00017k-SX
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 02:20:43 -0500
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8AxZfBA54NlWlYDAA--.16965S3;
 Thu, 21 Dec 2023 15:20:33 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Axnr4954Nl2FcDAA--.10748S3; 
 Thu, 21 Dec 2023 15:20:31 +0800 (CST)
Subject: Re: [PATCH v2 03/17] hw/loongarch: Add init_cmdline
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, peter.maydell@linaro.org
References: <20231218090059.2678224-1-gaosong@loongson.cn>
 <20231218090059.2678224-4-gaosong@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <a00e86e5-38f6-cd89-9fd2-48e3daea675c@loongson.cn>
Date: Thu, 21 Dec 2023 15:20:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20231218090059.2678224-4-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axnr4954Nl2FcDAA--.10748S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJF4rZw1fJF4xCFW3CF48AFc_yoW5CryUpF
 ZxAFn5Gws5JrZrC3sFq3s8Xrn8Zws7Gw4agF1xWryFkF47Kr18ZF18Z39ruF48J3yrKw4F
 vrnYyw4jva1DX3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UN
 vtZUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.41,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 2023/12/18 下午5:00, Song Gao wrote:
> Add init_cmline and set boot_info->a0, a1
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/boot.c         | 21 +++++++++++++++++++++
>   include/hw/loongarch/virt.h |  2 ++
>   target/loongarch/cpu.h      |  2 ++
>   3 files changed, 25 insertions(+)
> 
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index 2be6dfb037..4bfe24274a 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -14,6 +14,20 @@
>   #include "qemu/error-report.h"
>   #include "sysemu/reset.h"
>   
> +static int init_cmdline(struct loongarch_boot_info *info)
> +{
> +    hwaddr cmdline_addr;
> +    cmdline_addr = 0xff00000ULL;
> +
> +    pstrcpy_targphys("cmdline", 0xff00000ULL,
> +                     COMMAND_LINE_SIZE, info->kernel_cmdline);
There are two places using 0xff00000ULL here, it had better be defined 
as macro. Also can address for cmdline be before FDT base 
address(0x100000) rather than strange value 0xff00000 ? -:)

> +
> +    info->a0 = 1;
> +    info->a1 = cmdline_addr;
> +
> +    return 0;
> +}
> +
>   static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
>   {
>       return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
> @@ -63,6 +77,8 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
>           exit(1);
>       }
>   
> +    init_cmdline(info);
> +
>       return kernel_entry;
>   }
>   
> @@ -73,6 +89,10 @@ static void reset_load_elf(void *opaque)
>   
>       cpu_reset(CPU(cpu));
>       if (env->load_elf) {
> +	if (cpu == LOONGARCH_CPU(first_cpu)) {
> +            env->gpr[4] = env->boot_info->a0;
> +            env->gpr[5] = env->boot_info->a1;
> +        }
>           cpu_set_pc(CPU(cpu), env->elf_address);
>       }
>   }
> @@ -129,6 +149,7 @@ static void loongarch_direct_kernel_boot(LoongArchMachineState *lams,
>           lacpu = LOONGARCH_CPU(qemu_get_cpu(i));
>           lacpu->env.load_elf = true;
>           lacpu->env.elf_address = kernel_addr;
> +        lacpu->env.boot_info = info;
>       }
>   }
>   
> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> index e4126dd0e7..d21de2cef4 100644
> --- a/include/hw/loongarch/virt.h
> +++ b/include/hw/loongarch/virt.h
> @@ -31,6 +31,8 @@
>   #define VIRT_GED_MEM_ADDR       (VIRT_GED_EVT_ADDR + ACPI_GED_EVT_SEL_LEN)
>   #define VIRT_GED_REG_ADDR       (VIRT_GED_MEM_ADDR + MEMORY_HOTPLUG_IO_LEN)
>   
> +#define COMMAND_LINE_SIZE       512
The macro COMMAND_LINE_SIZE is already defined in Linux header file, 
maybe standard header file can be used.

/usr/include/asm-generic/setup.h
#define COMMAND_LINE_SIZE      512


Regards
Bibo Mao
> +
>   struct LoongArchMachineState {
>       /*< private >*/
>       MachineState parent_obj;
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 00d1fba597..c7c695138e 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -362,6 +362,8 @@ typedef struct CPUArchState {
>       uint64_t elf_address;
>       /* Store ipistate to access from this struct */
>       DeviceState *ipistate;
> +
> +    struct loongarch_boot_info *boot_info;
>   #endif
>   } CPULoongArchState;
>   
> 


