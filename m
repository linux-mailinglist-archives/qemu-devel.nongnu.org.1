Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EE887B9FF
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Mar 2024 10:05:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkh1I-0008LA-OU; Thu, 14 Mar 2024 05:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rkh1E-0008L0-CG
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 05:04:56 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rkh1A-0004iN-RP
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 05:04:55 -0400
Received: from loongson.cn (unknown [117.67.132.50])
 by gateway (Coremail) with SMTP id _____8CxifCyvfJlGAkZAA--.61032S3;
 Thu, 14 Mar 2024 17:04:50 +0800 (CST)
Received: from [192.168.2.12] (unknown [117.67.132.50])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxDc+wvfJl1t1ZAA--.40024S3; 
 Thu, 14 Mar 2024 17:04:48 +0800 (CST)
Message-ID: <0acbe05d-4625-0772-a4ef-80481d48dd7e@loongson.cn>
Date: Thu, 14 Mar 2024 17:04:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 03/17] hw/loongarch: Add slave cpu boot_code
To: chen huacai <zltjiangshi@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, maobibo@loongson.cn
References: <20240307164835.300412-1-gaosong@loongson.cn>
 <20240307164835.300412-4-gaosong@loongson.cn>
 <CABDp7Vo9ZOrz+4iKtToC+hs_JzptZg2cup+NdDaniV-3Qev+Tw@mail.gmail.com>
From: gaosong <gaosong@loongson.cn>
In-Reply-To: <CABDp7Vo9ZOrz+4iKtToC+hs_JzptZg2cup+NdDaniV-3Qev+Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxDc+wvfJl1t1ZAA--.40024S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGFy5uF1UJF47ur4kZFyrGrX_yoWrGrW7pF
 W5X3Z0vrs5Xry2vwsxtry5Zrs0qa4FgF45JFyftFy0y3Wqqrnru3WDAr929FW2krn5ZF1I
 vF9Yvw1agF4DK3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8r9
 N3UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.763,
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



在 2024/3/14 10:28, chen huacai 写道:
> Song,
> 
> On Fri, Mar 8, 2024 at 12:51 AM Song Gao <gaosong@loongson.cn> wrote:
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> Message-Id: <20240301093839.663947-4-gaosong@loongson.cn>
>> ---
>>   hw/loongarch/boot.c | 70 ++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 69 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
>> index 149deb2e01..e560ac178a 100644
>> --- a/hw/loongarch/boot.c
>> +++ b/hw/loongarch/boot.c
>> @@ -15,6 +15,54 @@
>>   #include "sysemu/reset.h"
>>   #include "sysemu/qtest.h"
>>
>> +static const unsigned int slave_boot_code[] = {
>> +                  /* Configure reset ebase.         */
>> +    0x0400302c,   /* csrwr      $r12,0xc            */
> Use reg-names may be a little better than reg-nums.
> 
Got it.

Thanks.
Song Gao

> Huacai
> 
>> +
>> +                  /* Disable interrupt.             */
>> +    0x0380100c,   /* ori        $r12,$r0,0x4        */
>> +    0x04000180,   /* csrxchg    $r0,$r12,0x0        */
>> +
>> +                  /* Clear mailbox.                 */
>> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
>> +    0x038081ad,   /* ori        $r13,$r13,0x20      */
>> +    0x06481da0,   /* iocsrwr.d  $r0,$r13            */
>> +
>> +                  /* Enable IPI interrupt.          */
>> +    0x1400002c,   /* lu12i.w    $r12,1(0x1)         */
>> +    0x0400118c,   /* csrxchg    $r12,$r12,0x4       */
>> +    0x02fffc0c,   /* addi.d     $r12,$r0,-1(0xfff)  */
>> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
>> +    0x038011ad,   /* ori        $r13,$r13,0x4       */
>> +    0x064819ac,   /* iocsrwr.w  $r12,$r13           */
>> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
>> +    0x038081ad,   /* ori        $r13,$r13,0x20      */
>> +
>> +                  /* Wait for wakeup  <.L11>:       */
>> +    0x06488000,   /* idle       0x0                 */
>> +    0x03400000,   /* andi       $r0,$r0,0x0         */
>> +    0x064809ac,   /* iocsrrd.w  $r12,$r13           */
>> +    0x43fff59f,   /* beqz       $r12,-12(0x7ffff4) # 48 <.L11> */
>> +
>> +                  /* Read and clear IPI interrupt.  */
>> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
>> +    0x064809ac,   /* iocsrrd.w  $r12,$r13           */
>> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
>> +    0x038031ad,   /* ori        $r13,$r13,0xc       */
>> +    0x064819ac,   /* iocsrwr.w  $r12,$r13           */
>> +
>> +                  /* Disable  IPI interrupt.        */
>> +    0x1400002c,   /* lu12i.w    $r12,1(0x1)         */
>> +    0x04001180,   /* csrxchg    $r0,$r12,0x4        */
>> +
>> +                  /* Read mail buf and jump to specified entry */
>> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
>> +    0x038081ad,   /* ori        $r13,$r13,0x20      */
>> +    0x06480dac,   /* iocsrrd.d  $r12,$r13           */
>> +    0x00150181,   /* move       $r1,$r12            */
>> +    0x4c000020,   /* jirl       $r0,$r1,0           */
>> +};
>> +
>>   static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
>>   {
>>       return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
>> @@ -111,8 +159,15 @@ static void loongarch_firmware_boot(LoongArchMachineState *lams,
>>       fw_cfg_add_kernel_info(info, lams->fw_cfg);
>>   }
>>
>> +static void init_boot_rom(struct loongarch_boot_info *info, void *p)
>> +{
>> +    memcpy(p, &slave_boot_code, sizeof(slave_boot_code));
>> +    p += sizeof(slave_boot_code);
>> +}
>> +
>>   static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
>>   {
>> +    void  *p, *bp;
>>       int64_t kernel_addr = 0;
>>       LoongArchCPU *lacpu;
>>       CPUState *cs;
>> @@ -126,11 +181,24 @@ static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
>>           }
>>       }
>>
>> +    /* Load 'boot_rom' at [0 - 1MiB] */
>> +    p = g_malloc0(1 * MiB);
>> +    bp = p;
>> +    init_boot_rom(info, p);
>> +    rom_add_blob_fixed("boot_rom", bp, 1 * MiB, 0);
>> +
>>       CPU_FOREACH(cs) {
>>           lacpu = LOONGARCH_CPU(cs);
>>           lacpu->env.load_elf = true;
>> -        lacpu->env.elf_address = kernel_addr;
>> +        if (cs == first_cpu) {
>> +            lacpu->env.elf_address = kernel_addr;
>> +        } else {
>> +            lacpu->env.elf_address = 0;
>> +        }
>> +        lacpu->env.boot_info = info;
>>       }
>> +
>> +    g_free(bp);
>>   }
>>
>>   void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info)
>> --
>> 2.34.1
>>
>>
> 
> 


