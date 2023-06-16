Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8E0732885
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 09:12:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA3bq-0001Lu-W6; Fri, 16 Jun 2023 03:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qA3bl-0001Ld-6I
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 03:10:57 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qA3bj-0006hO-7m
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 03:10:56 -0400
Received: from loongson.cn (unknown [10.20.42.57])
 by gateway (Coremail) with SMTP id _____8CxNun8Coxkl+AFAA--.10484S3;
 Fri, 16 Jun 2023 15:10:52 +0800 (CST)
Received: from [10.20.42.57] (unknown [10.20.42.57])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxPMr8Coxk8f0cAA--.7642S3; 
 Fri, 16 Jun 2023 15:10:52 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch: Supplement cpu topology arguments
To: Tianrui Zhao <zhaotianrui@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 philmd@linaro.org, imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 alex.bennee@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn
References: <20230613123251.2471878-1-zhaotianrui@loongson.cn>
From: Song Gao <gaosong@loongson.cn>
Message-ID: <03ef48b0-ad82-467c-fe49-ff3013155317@loongson.cn>
Date: Fri, 16 Jun 2023 15:10:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230613123251.2471878-1-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxPMr8Coxk8f0cAA--.7642S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr1fKry8KFWfZw18Cw4DAwc_yoW8tF13pw
 4DCayqyw43W3s5Zw4DJFy2gFy0yrs7K3WxXas2gFWF93WDK3WrXrW8AFZ0yF47Zwn5JFWq
 vrnYkasY9FWUXrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO
 db8UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.098, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



ÔÚ 2023/6/13 ÏÂÎç8:32, Tianrui Zhao Ð´µÀ:
> Supplement LoongArch cpu topology arguments, including support socket
> and threads per core.
>
> Base-on:
> https://patchew.org/QEMU/20230613122613.2471743-1-zhaotianrui@loongson.cn/
>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> ---
>   hw/loongarch/acpi-build.c | 4 ++++
>   hw/loongarch/virt.c       | 9 ++++++++-
>   2 files changed, 12 insertions(+), 1 deletion(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
> index f526f3abba..0b62c3a2f7 100644
> --- a/hw/loongarch/acpi-build.c
> +++ b/hw/loongarch/acpi-build.c
> @@ -437,6 +437,10 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>       acpi_add_table(table_offsets, tables_blob);
>       build_madt(tables_blob, tables->linker, lams);
>   
> +    acpi_add_table(table_offsets, tables_blob);
> +    build_pptt(tables_blob, tables->linker, machine,
> +               lams->oem_id, lams->oem_table_id);
> +
>       acpi_add_table(table_offsets, tables_blob);
>       build_srat(tables_blob, tables->linker, machine);
>   
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index a2fcbf7643..d3b31e3f71 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -1096,8 +1096,15 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>       for (n = 0; n < ms->possible_cpus->len; n++) {
>           ms->possible_cpus->cpus[n].type = ms->cpu_type;
>           ms->possible_cpus->cpus[n].arch_id = n;
> +
> +        ms->possible_cpus->cpus[n].props.has_socket_id = true;
> +        ms->possible_cpus->cpus[n].props.socket_id  =
> +                                   n / (ms->smp.cores * ms->smp.threads);
>           ms->possible_cpus->cpus[n].props.has_core_id = true;
> -        ms->possible_cpus->cpus[n].props.core_id = n % ms->smp.cores;
> +        ms->possible_cpus->cpus[n].props.core_id =
> +                                   n / ms->smp.threads % ms->smp.cores;
> +        ms->possible_cpus->cpus[n].props.has_thread_id = true;
> +        ms->possible_cpus->cpus[n].props.thread_id = n % ms->smp.threads;
>       }
>       return ms->possible_cpus;
>   }


