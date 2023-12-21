Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE55581AF53
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 08:23:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGDOW-0004Ck-Qn; Thu, 21 Dec 2023 02:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rGDOU-0004Bd-86
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 02:22:58 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1rGDOS-0001mB-96
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 02:22:57 -0500
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8BxbOnN54NlmFYDAA--.16729S3;
 Thu, 21 Dec 2023 15:22:53 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxbb7K54NleFgDAA--.10661S3; 
 Thu, 21 Dec 2023 15:22:52 +0800 (CST)
Subject: Re: [PATCH v2 04/17] hw/loongarch: Add slave cpu boot_code
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, peter.maydell@linaro.org
References: <20231218090059.2678224-1-gaosong@loongson.cn>
 <20231218090059.2678224-5-gaosong@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <d290392c-3531-cba2-bcf8-d85fdd49c85f@loongson.cn>
Date: Thu, 21 Dec 2023 15:22:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20231218090059.2678224-5-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxbb7K54NleFgDAA--.10661S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw43Xr4kZFyUZr43Jw4DWrX_yoW5AF45pF
 W5Xwn0vr95Wry7ZwsxtryUArn8Ga4FkF45K34Sqry0ya1aqwnruw1UAr9rtFWjgrn5Za10
 vFn5Aw13KF4DtagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1
 LvtUUUUU=
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
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/boot.c | 65 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index 4bfe24274a..076e795714 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -14,6 +14,62 @@
>   #include "qemu/error-report.h"
>   #include "sysemu/reset.h"
>   
> +enum {
> +    SLAVE_BOOT,
> +};
> +
> +static const MemMapEntry loader_rommap[] = {
> +    [SLAVE_BOOT] = {0xf100000, 0x10000},
> +};
Address 0xf100000 had better be defined before 0x100000

Regards
Bibo Mao

> +
> +static unsigned int slave_boot_code[] = {
> +                  /* Configure reset ebase.         */
> +    0x0400302c,   /* csrwr      $r12,0xc            */
> +
> +                  /* Disable interrupt.             */
> +    0x0380100c,   /* ori        $r12,$r0,0x4        */
> +    0x04000180,   /* csrxchg    $r0,$r12,0x0        */
> +
> +                  /* Clear mailbox.                 */
> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
> +    0x038081ad,   /* ori        $r13,$r13,0x20      */
> +    0x06481da0,   /* iocsrwr.d  $r0,$r13            */
> +
> +                  /* Enable IPI interrupt.          */
> +    0x1400002c,   /* lu12i.w    $r12,1(0x1)         */
> +    0x0400118c,   /* csrxchg    $r12,$r12,0x4       */
> +    0x02fffc0c,   /* addi.d     $r12,$r0,-1(0xfff)  */
> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
> +    0x038011ad,   /* ori        $r13,$r13,0x4       */
> +    0x064819ac,   /* iocsrwr.w  $r12,$r13           */
> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
> +    0x038081ad,   /* ori        $r13,$r13,0x20      */
> +
> +                  /* Wait for wakeup  <.L11>:       */
> +    0x06488000,   /* idle       0x0                 */
> +    0x03400000,   /* andi       $r0,$r0,0x0         */
> +    0x064809ac,   /* iocsrrd.w  $r12,$r13           */
> +    0x43fff59f,   /* beqz       $r12,-12(0x7ffff4) # 48 <.L11> */
> +
> +                  /* Read and clear IPI interrupt.  */
> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
> +    0x064809ac,   /* iocsrrd.w  $r12,$r13           */
> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
> +    0x038031ad,   /* ori        $r13,$r13,0xc       */
> +    0x064819ac,   /* iocsrwr.w  $r12,$r13           */
> +
> +                  /* Disable  IPI interrupt.        */
> +    0x1400002c,   /* lu12i.w    $r12,1(0x1)         */
> +    0x04001180,   /* csrxchg    $r0,$r12,0x4        */
> +
> +                  /* Read mail buf and jump to specified entry */
> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
> +    0x038081ad,   /* ori        $r13,$r13,0x20      */
> +    0x06480dac,   /* iocsrrd.d  $r12,$r13           */
> +    0x00150181,   /* move       $r1,$r12            */
> +    0x4c000020,   /* jirl       $r0,$r1,0           */
> +};
> +
>   static int init_cmdline(struct loongarch_boot_info *info)
>   {
>       hwaddr cmdline_addr;
> @@ -145,10 +201,17 @@ static void loongarch_direct_kernel_boot(LoongArchMachineState *lams,
>           exit(1);
>       }
>   
> +    rom_add_blob_fixed("slave_boot", slave_boot_code, sizeof(slave_boot_code),
> +                       loader_rommap[SLAVE_BOOT].base);
> +
>       for (i = 0; i < machine->smp.cpus; i++) {
>           lacpu = LOONGARCH_CPU(qemu_get_cpu(i));
>           lacpu->env.load_elf = true;
> -        lacpu->env.elf_address = kernel_addr;
> +        if (i == 0) {
> +            lacpu->env.elf_address = kernel_addr;
> +        } else {
> +            lacpu->env.elf_address = loader_rommap[SLAVE_BOOT].base;
> +        }
>           lacpu->env.boot_info = info;
>       }
>   }
> 


