Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D478D7778C8
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 14:47:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU54V-0006AS-Cr; Thu, 10 Aug 2023 08:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qU54T-00069m-Ba
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 08:47:21 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qU54Q-0005m5-6c
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 08:47:21 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxfOpP3NRkMawUAA--.17559S3;
 Thu, 10 Aug 2023 20:47:12 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxDCNO3NRkBCZTAA--.58030S3; 
 Thu, 10 Aug 2023 20:47:10 +0800 (CST)
Subject: Re: [PATCH v5 11/11] target/loongarch: Add loongarch32 cpu la132
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn, 
 i.qemu@xen0n.name, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230809083258.1787464-1-c@jia.je>
 <20230809083258.1787464-12-c@jia.je>
From: gaosong <gaosong@loongson.cn>
Message-ID: <4c7e8587-c998-a831-244e-75bc6d75c489@loongson.cn>
Date: Thu, 10 Aug 2023 20:47:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230809083258.1787464-12-c@jia.je>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxDCNO3NRkBCZTAA--.58030S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF4fAF4kAw1rtryfuFy8Zwc_yoW5Wryrpr
 W7Zrs8KrZ7tFZ7C3s3XayUXrn5Zr4xGw12vF4fJrW0939xWr1DXayktFykAFyYyw1rXF40
 vrn5GFy5WFs8JFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
 Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
 xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
 cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
 14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjwZcUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-2.156, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi, Jiajie

ÔÚ 2023/8/9 ÏÂÎç4:26, Jiajie Chen Ð´µÀ:
> Add la132 as a loongarch32 cpu type and allow virt machine to be used
> with la132 instead of la464.
> 
> Due to lack of public documentation of la132, it is currently a
> synthetic loongarch32 cpu model. Details need to be added in the future.
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> ---
>   hw/loongarch/virt.c    |  5 -----
>   target/loongarch/cpu.c | 29 +++++++++++++++++++++++++++++
>   2 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index e19b042ce8..af15bf5aaa 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -798,11 +798,6 @@ static void loongarch_init(MachineState *machine)
>           cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
>       }
>   
> -    if (!strstr(cpu_model, "la464")) {
> -        error_report("LoongArch/TCG needs cpu type la464");
> -        exit(1);
> -    }
> -
>       if (ram_size < 1 * GiB) {
>           error_report("ram_size must be greater than 1G.");
>           exit(1);
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index bd980790f2..dd1cd7d7d2 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -439,6 +439,34 @@ static void loongarch_la464_initfn(Object *obj)
>       env->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
>   }
>   
> +static void loongarch_la132_initfn(Object *obj)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> +    CPULoongArchState *env = &cpu->env;
> +
> +    int i;
> +
> +    for (i = 0; i < 21; i++) {
> +        env->cpucfg[i] = 0x0;
> +    }
> +
> +    cpu->dtb_compatible = "loongarch,Loongson-1C103";
> +
> +    uint32_t data = 0;
> +    data = FIELD_DP32(data, CPUCFG1, ARCH, 1); /* LA32 */
> +    data = FIELD_DP32(data, CPUCFG1, PGMMU, 1);
> +    data = FIELD_DP32(data, CPUCFG1, IOCSR, 1);

I confirmed with Shenjinyang that la32 don't support IOCSR instructions.

Thanks.
Song Gao

> +    data = FIELD_DP32(data, CPUCFG1, PALEN, 0x1f); /* 32 bits */
> +    data = FIELD_DP32(data, CPUCFG1, VALEN, 0x1f); /* 32 bits */
> +    data = FIELD_DP32(data, CPUCFG1, UAL, 1);
> +    data = FIELD_DP32(data, CPUCFG1, RI, 0);
> +    data = FIELD_DP32(data, CPUCFG1, EP, 0);
> +    data = FIELD_DP32(data, CPUCFG1, RPLV, 0);
> +    data = FIELD_DP32(data, CPUCFG1, HP, 1);
> +    data = FIELD_DP32(data, CPUCFG1, IOCSR_BRD, 1);
> +    env->cpucfg[1] = data;
> +}
> +
>   static void loongarch_cpu_list_entry(gpointer data, gpointer user_data)
>   {
>       const char *typename = object_class_get_name(OBJECT_CLASS(data));
> @@ -778,6 +806,7 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
>           .class_init = loongarch32_cpu_class_init,
>       },
>       DEFINE_LOONGARCH_CPU_TYPE("la464", loongarch_la464_initfn),
> +    DEFINE_LOONGARCH32_CPU_TYPE("la132", loongarch_la132_initfn),
>   };
>   
>   DEFINE_TYPES(loongarch_cpu_type_infos)
> 


