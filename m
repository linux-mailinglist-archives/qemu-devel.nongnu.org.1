Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A5E8CBCE5
	for <lists+qemu-devel@lfdr.de>; Wed, 22 May 2024 10:24:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9hH9-0002fI-0S; Wed, 22 May 2024 04:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s9hGx-0002eN-Bx
 for qemu-devel@nongnu.org; Wed, 22 May 2024 04:24:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s9hGt-0003Ij-ED
 for qemu-devel@nongnu.org; Wed, 22 May 2024 04:24:31 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Bx36+1q01mPZgCAA--.2032S3;
 Wed, 22 May 2024 16:24:22 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxDMezq01mq0wFAA--.15171S3; 
 Wed, 22 May 2024 16:24:21 +0800 (CST)
Subject: Re: [PATCH 2/2] target/loongarch: Add loongson binary translation
 feature
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240521080549.434197-1-maobibo@loongson.cn>
 <20240521080549.434197-3-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <d9475c27-a699-6967-a4e3-8b8978a15e7b@loongson.cn>
Date: Wed, 22 May 2024 16:24:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240521080549.434197-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxDMezq01mq0wFAA--.15171S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWw4UGrW8Wr1UGr4xKr4xXwc_yoW5Kr4kpr
 W7CFZxKFWUtFZ7C3Z7Jay5Wrn8Xr4xGr42v3WfAr97uF1DXr17XF18t3sFvFykC34UAF4S
 gF10kay5WanrJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07Ui
 iSdUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.405, SPF_HELO_NONE=0.001,
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

�� 2024/5/21 ����4:05, Bibo Mao д��:
> Loongson Binary Translation (LBT) is used to accelerate binary
> translation, which contains 4 scratch registers (scr0 to scr3), x86/ARM
> eflags (eflags) and x87 fpu stack pointer (ftop).
>
> Now LBT feature is added in kvm mode, not supported in TCG mode since
> it is not emulated. And only LBT feature is added here, LBT register
> saving and restoring is not supported since it depeeds on LBT feautre
> implemented in KVM kernel.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
>   target/loongarch/cpu.c                | 32 +++++++++++++++++++++++++++
>   target/loongarch/cpu.h                |  1 +
>   target/loongarch/loongarch-qmp-cmds.c |  2 +-
>   3 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index b5c1ec94af..84254c0f42 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -412,6 +412,9 @@ static void loongarch_la464_initfn(Object *obj)
>       data = FIELD_DP32(data, CPUCFG2, LLFTP_VER, 1);
>       data = FIELD_DP32(data, CPUCFG2, LSPW, 1);
>       data = FIELD_DP32(data, CPUCFG2, LAM, 1);
> +    if (kvm_enabled()) {
> +        data = FIELD_DP32(data, CPUCFG2, LBT_ALL, 7);
> +    }
>       env->cpucfg[2] = data;
>   
>       env->cpucfg[4] = 100 * 1000 * 1000; /* Crystal frequency */
> @@ -643,12 +646,41 @@ static void loongarch_set_lasx(Object *obj, bool value, Error **errp)
>       }
>   }
>   
> +static bool loongarch_get_lbt(Object *obj, Error **errp)
> + {
> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> +    bool ret;
> +
> +    ret = false;
> +    /* lbt is enabled only in kvm mode, not supported in tcg mode */
> +    if (kvm_enabled() &&
> +        (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LBT_ALL) == 7)) {
> +        ret = true;
> +     }
> +    return ret;
> +}
> +
> +static void loongarch_set_lbt(Object *obj, bool value, Error **errp)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> +    int lbt;
> +
> +    lbt = 0;
> +    if (kvm_enabled() && value) {
> +        /* Enable binary translation for all architectures */
> +        lbt = 7;
> +    }
> +    cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LBT_ALL, lbt);
> +}
> +
>   void loongarch_cpu_post_init(Object *obj)
>   {
>       object_property_add_bool(obj, "lsx", loongarch_get_lsx,
>                                loongarch_set_lsx);
>       object_property_add_bool(obj, "lasx", loongarch_get_lasx,
>                                loongarch_set_lasx);
> +    object_property_add_bool(obj, "lbt", loongarch_get_lbt,
> +                             loongarch_set_lbt);
>   }
>   
>   static void loongarch_cpu_init(Object *obj)
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 41b8e6d96d..2021e85303 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -152,6 +152,7 @@ FIELD(CPUCFG2, LLFTP_VER, 15, 3)
>   FIELD(CPUCFG2, LBT_X86, 18, 1)
>   FIELD(CPUCFG2, LBT_ARM, 19, 1)
>   FIELD(CPUCFG2, LBT_MIPS, 20, 1)
> +FIELD(CPUCFG2, LBT_ALL, 18, 3)
>   FIELD(CPUCFG2, LSPW, 21, 1)
>   FIELD(CPUCFG2, LAM, 22, 1)
>   
> diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
> index 8721a5eb13..c6f6e1ef85 100644
> --- a/target/loongarch/loongarch-qmp-cmds.c
> +++ b/target/loongarch/loongarch-qmp-cmds.c
> @@ -40,7 +40,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
>   }
>   
>   static const char *cpu_model_advertised_features[] = {
> -    "lsx", "lasx", NULL
> +    "lsx", "lasx", "lbt", NULL
>   };
>   
>   CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,


