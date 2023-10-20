Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D267D0A3D
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 10:07:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtkVu-0003QN-Qd; Fri, 20 Oct 2023 04:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1qtkVm-0003Bt-RB
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 04:05:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1qtkVi-0001nR-Ue
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 04:05:37 -0400
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8DxxPDANDJlBW0zAA--.35354S3;
 Fri, 20 Oct 2023 16:05:21 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dx_y+9NDJlBhUsAA--.27772S3; 
 Fri, 20 Oct 2023 16:05:19 +0800 (CST)
Subject: Re: [PATCH v2 2/4] target/loongarch: Add cpu feature flags
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@redhat.com,
 peter.maydell@linaro.org, eblake@redhat.com, armbru@redhat.com
References: <20231019125853.3436531-1-gaosong@loongson.cn>
 <20231019125853.3436531-3-gaosong@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <a3448f95-bcb5-f4ba-2cb0-65a80501ef5a@loongson.cn>
Date: Fri, 20 Oct 2023 16:05:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20231019125853.3436531-3-gaosong@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx_y+9NDJlBhUsAA--.27772S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AF4UAw1UZrW8AF4xtr13Awc_yoW8Kry3p3
 47AFn09FWUJrW3Can3J3y5ZFn8Xw4xGa12ga1ak3s7Ca1UGryxZr18KanrCFWDJ345Ww1I
 gFyFgryUCF1UX3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
 VUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-3.339, SPF_HELO_NONE=0.001,
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



ÔÚ 2023/10/19 ÏÂÎç8:58, Song Gao Ð´µÀ:
> CPULoongArchState adds cpu feature flags features.
> Intrduce loongarch_feature() to check feature and
> set_feature() to set feature.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu.c |  4 ++++
>   target/loongarch/cpu.h | 32 ++++++++++++++++++++++++++++++++
>   2 files changed, 36 insertions(+)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index ef6922e812..87fcd08110 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -366,6 +366,10 @@ static void loongarch_la464_initfn(Object *obj)
>       CPULoongArchState *env = &cpu->env;
>       int i;
>   
> +    env->features = 0;
> +    set_feature(env, CPU_FEATURE_LSX);
> +    set_feature(env, CPU_FEATURE_LASX);
> +
>       for (i = 0; i < 21; i++) {
>           env->cpucfg[i] = 0x0;
>       }
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 8b54cf109c..b98064945a 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -295,6 +295,8 @@ typedef struct CPUArchState {
>       uint64_t lladdr; /* LL virtual address compared against SC */
>       uint64_t llval;
>   
> +    uint64_t features;
Like what Richard says, it is not necessary to use features here,
cpucfg2 can be used directly.

> +
>       /* LoongArch CSRs */
>       uint64_t CSR_CRMD;
>       uint64_t CSR_PRMD;
> @@ -364,6 +366,36 @@ typedef struct CPUArchState {
>   #endif
>   } CPULoongArchState;
>   
> +/*
> + * See arch/loongarch/include/asm/cpu.h
> + * and arch/loongarch/include/uapi/asm/hwcap.h
> + */
> +enum loongarch_features {
> +    CPU_FEATURE_CPUCFG,
> +    CPU_FEATURE_LAM,
> +    CPU_FEATURE_UAL,
> +    CPU_FEATURE_FPU,
> +    CPU_FEATURE_LSX,
> +    CPU_FEATURE_LASX,
> +    CPU_FEATURE_CRC32,
> +    CPU_FEATURE_COMPLEX,
> +    CPU_FEATURE_CRYPTO,
> +    CPU_FEATURE_LVZ,
> +    CPU_FEATURE_LBT_X86,
> +    CPU_FEATURE_LBT_ARM,
> +    CPU_FEATURE_LBT_MIPS,
> +};
Suggest to only list features which can be set on/off from QEMU command 
line.

Regards
Bibo, Mao
> +
> +static inline int loongarch_feature(CPULoongArchState *env, int feature)
> +{
> +    return (env->features & (1ULL << feature)) != 0;
> +}
> +
> +static inline void set_feature(CPULoongArchState *env, int feature)
> +{
> +    env->features |= 1ULL << feature;
> +}
> +
>   /**
>    * LoongArchCPU:
>    * @env: #CPULoongArchState
> 


