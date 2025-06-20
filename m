Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 713FDAE148B
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Jun 2025 09:08:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSVqc-0000Un-1v; Fri, 20 Jun 2025 03:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uSVqQ-0000UM-L9
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:07:26 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uSVqN-0005u7-Or
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:07:26 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxyuChCFVovjoaAQ--.60392S3;
 Fri, 20 Jun 2025 15:07:13 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAxzxudCFVo_hgiAQ--.50970S3;
 Fri, 20 Jun 2025 15:07:13 +0800 (CST)
Subject: Re: [PATCH v2 4/9] target/loongarch: add msg interrupt CSR registers
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250619023944.1278716-1-gaosong@loongson.cn>
 <20250619023944.1278716-5-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <4eef878f-8d08-74e2-ab40-f11680880d3e@loongson.cn>
Date: Fri, 20 Jun 2025 15:05:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250619023944.1278716-5-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzxudCFVo_hgiAQ--.50970S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXFWUGFykCF43WF1fZFy7Arc_yoW5Gw17pr
 sxCFyDKFWUtFZrA3Z3J345XFnxXr1xKw4I9a1akF1Ika1kXr48Wr18tasFyF15J3WFkr40
 vF1Fy34UXa17XabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70PfDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.648,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 2025/6/19 上午10:39, Song Gao wrote:
> include CSR_MSGIS0-3, CSR_MSGIR and CSR_MSGIE.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu.c     |  7 +++++++
>   target/loongarch/cpu.h     | 10 ++++++++++
>   target/loongarch/machine.c |  5 +++++
>   3 files changed, 22 insertions(+)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index abad84c054..bde9f917fc 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -523,6 +523,13 @@ static void loongarch_la464_initfn(Object *obj)
>       env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, STLB_WAYS, 7);
>       env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, STLB_SETS, 8);
>   
> +    env->CSR_MSGIS[0] = 0;
> +    env->CSR_MSGIS[1] = 0;
> +    env->CSR_MSGIS[2] = 0;
> +    env->CSR_MSGIS[3] = 0;
> +    env->CSR_MSGIR = 0;
> +    env->CSR_MSGIE = 0;
> +
>       loongarch_la464_init_csr(obj);
>       loongarch_cpu_post_init(obj);
>   }
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 1169768632..231ad5a7cb 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -233,6 +233,12 @@ FIELD(TLB_MISC, ASID, 1, 10)
>   FIELD(TLB_MISC, VPPN, 13, 35)
>   FIELD(TLB_MISC, PS, 48, 6)
>   
> +/*Msg interrupt registers */
> +FIELD(CSR_MSGIS, IS, 0, 63)
> +FIELD(CSR_MSGIR, INTNUM, 0, 8)
> +FIELD(CSR_MSGIR, ACTIVE, 31, 1)
> +FIELD(CSR_MSGIE, PT, 0, 8)
> +
>   #define LSX_LEN    (128)
>   #define LASX_LEN   (256)
>   
> @@ -350,6 +356,10 @@ typedef struct CPUArchState {
>       uint64_t CSR_DBG;
>       uint64_t CSR_DERA;
>       uint64_t CSR_DSAVE;
> +    /* Msg interrupt registers */
> +    uint64_t CSR_MSGIS[4];
> +    uint64_t CSR_MSGIR;
> +    uint64_t CSR_MSGIE;
>       struct {
>           uint64_t guest_addr;
>       } stealtime;
> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
> index 4e70f5c879..7d5ee34f90 100644
> --- a/target/loongarch/machine.c
> +++ b/target/loongarch/machine.c
> @@ -231,6 +231,11 @@ const VMStateDescription vmstate_loongarch_cpu = {
>           VMSTATE_UINT64(env.CSR_DERA, LoongArchCPU),
>           VMSTATE_UINT64(env.CSR_DSAVE, LoongArchCPU),
>   
> +        /* Msg interrupt CSRs */
> +        VMSTATE_UINT64_ARRAY(env.CSR_MSGIS, LoongArchCPU, 4),
> +        VMSTATE_UINT64(env.CSR_MSGIR, LoongArchCPU),
> +        VMSTATE_UINT64(env.CSR_MSGIE, LoongArchCPU),
> +
Can it be appended with one subsection in the end of structure 
vmstate_loongarch_cpu?  So that it is compatible with old machine.

Regards
Bibo Mao
>           VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
>           /* PV steal time */
>           VMSTATE_UINT64(env.stealtime.guest_addr, LoongArchCPU),
> 


