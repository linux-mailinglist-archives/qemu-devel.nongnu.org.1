Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 651ED784E13
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 03:15:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYcRr-0005Hx-P1; Tue, 22 Aug 2023 21:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qYcRo-0005Ha-GK
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 21:14:12 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qYcRl-00084o-9k
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 21:14:12 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxIvBZXeVkvg8bAA--.54507S3;
 Wed, 23 Aug 2023 09:14:03 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxfSNYXeVknNRgAA--.57148S3; 
 Wed, 23 Aug 2023 09:14:01 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: cpu: Implement get_arch_id callback
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20230822122634.1435006-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <39216ec0-25b1-888d-ad91-0499c96e65fe@loongson.cn>
Date: Wed, 23 Aug 2023 09:14:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230822122634.1435006-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxfSNYXeVknNRgAA--.57148S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WrWrGFyDJFy3XF17tr4rtFc_yoW5Jr1Dpr
 ZruF1qka18JrZxJa97Ja45Xr1DXr17Wr42qa1xKryxCFs8Xry8XF1vy3sFvF98uay8GF12
 qF1Fk3W5XF48X3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.767, SPF_HELO_NONE=0.001,
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

ÔÚ 2023/8/22 ÏÂÎç8:26, Bibo Mao Ð´µÀ:
> Implement the callback for getting the architecture-dependent CPU
> ID, the cpu ID is physical id described in ACPI MADT table, this
> will be used for cpu hotplug.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> Change-Id: I53bcfb9f4279e491f33e8b99a9102534ad53409e
> ---

Drop Chang-Id.

Otherwise
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao

>   hw/loongarch/virt.c    | 2 ++
>   target/loongarch/cpu.c | 8 ++++++++
>   target/loongarch/cpu.h | 1 +
>   3 files changed, 11 insertions(+)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index e19b042ce8..6f6b577749 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -815,6 +815,8 @@ static void loongarch_init(MachineState *machine)
>           cpu = cpu_create(machine->cpu_type);
>           cpu->cpu_index = i;
>           machine->possible_cpus->cpus[i].cpu = OBJECT(cpu);
> +        lacpu = LOONGARCH_CPU(cpu);
> +        lacpu->phy_id = machine->possible_cpus->cpus[i].arch_id;
>       }
>       fdt_add_cpu_nodes(lams);
>   
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index ad93ecac92..7be3769672 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -690,6 +690,13 @@ static struct TCGCPUOps loongarch_tcg_ops = {
>   static const struct SysemuCPUOps loongarch_sysemu_ops = {
>       .get_phys_page_debug = loongarch_cpu_get_phys_page_debug,
>   };
> +
> +static int64_t loongarch_cpu_get_arch_id(CPUState *cs)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
> +
> +    return cpu->phy_id;
> +}
>   #endif
>   
>   static gchar *loongarch_gdb_arch_name(CPUState *cs)
> @@ -715,6 +722,7 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
>       cc->set_pc = loongarch_cpu_set_pc;
>       cc->get_pc = loongarch_cpu_get_pc;
>   #ifndef CONFIG_USER_ONLY
> +    cc->get_arch_id = loongarch_cpu_get_arch_id;
>       dc->vmsd = &vmstate_loongarch_cpu;
>       cc->sysemu_ops = &loongarch_sysemu_ops;
>   #endif
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index fa371ca8ba..033081593c 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -371,6 +371,7 @@ struct ArchCPU {
>       CPUNegativeOffsetState neg;
>       CPULoongArchState env;
>       QEMUTimer timer;
> +    uint32_t  phy_id;
>   
>       /* 'compatible' string for this CPU for Linux device trees */
>       const char *dtb_compatible;
> 


