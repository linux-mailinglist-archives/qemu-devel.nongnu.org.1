Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9571C75BF7D
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 09:22:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMkSB-0002dm-1a; Fri, 21 Jul 2023 03:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qMkS7-0002dL-AU
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 03:21:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qMkS4-0000gk-14
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 03:21:26 -0400
Received: from loongson.cn (unknown [10.20.42.244])
 by gateway (Coremail) with SMTP id _____8DxBfHoMbpkVu4HAA--.20055S3;
 Fri, 21 Jul 2023 15:21:12 +0800 (CST)
Received: from [10.20.42.244] (unknown [10.20.42.244])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxviPnMbpkfgM2AA--.42461S3; 
 Fri, 21 Jul 2023 15:21:12 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Fix the CSRRD CPUID instruction on big
 endian hosts
To: Thomas Huth <thuth@redhat.com>, Xiaojuan Yang <yangxiaojuan@loongson.cn>, 
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230720175307.854460-1-thuth@redhat.com>
From: Song Gao <gaosong@loongson.cn>
Message-ID: <a3602e62-c30b-6a8b-7680-399526963c9f@loongson.cn>
Date: Fri, 21 Jul 2023 15:21:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230720175307.854460-1-thuth@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxviPnMbpkfgM2AA--.42461S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZryrJr1UZr17Gw1xuFyfAFc_yoWrJFykpF
 W7CrZxtr48GFW3A3WrGa4agF1UXw4xGw42va93t34F9F43XrnFgF4rt3sI9FyDGayUXrW0
 q3Wvvry8Ja18XacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.096, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



ÔÚ 2023/7/21 ÉÏÎç1:53, Thomas Huth Ð´µÀ:
> The test in tests/avocado/machine_loongarch.py is currently failing
> on big endian hosts like s390x. By comparing the traces between running
> the QEMU_EFI.fd bios on a s390x and on a x86 host, it's quickly obvious
> that the CSRRD instruction for the CPUID is behaving differently. And
> indeed: The code currently does a long read (i.e. 64 bit) from the
> address that points to the CPUState->cpu_index field (with tcg_gen_ld_tl()
> in the trans_csrrd() function). But this cpu_index field is only an "int"
> (i.e. 32 bit). While this dirty pointer magic works on little endian hosts,
> it of course fails on big endian hosts. Fix it by using a proper helper
> function instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   Note: There is another bug preventing tests/avocado/machine_loongarch.py
>   from working correctly on big endian hosts (Linux fails to run the shell)
>   but that problem is harder to debug since it happens way later in the boot
>   process...
> 
>   target/loongarch/cpu.h                             | 1 +
>   target/loongarch/helper.h                          | 1 +
>   target/loongarch/csr_helper.c                      | 9 +++++++++
>   target/loongarch/insn_trans/trans_privileged.c.inc | 8 +-------
>   4 files changed, 12 insertions(+), 7 deletions(-)
> 

Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao

> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index ed04027af1..fa371ca8ba 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -342,6 +342,7 @@ typedef struct CPUArchState {
>       uint64_t CSR_DBG;
>       uint64_t CSR_DERA;
>       uint64_t CSR_DSAVE;
> +    uint64_t CSR_CPUID;
>   
>   #ifndef CONFIG_USER_ONLY
>       LoongArchTLB  tlb[LOONGARCH_TLB_MAX];
> diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
> index b9de77d926..ffb1e0b0bf 100644
> --- a/target/loongarch/helper.h
> +++ b/target/loongarch/helper.h
> @@ -98,6 +98,7 @@ DEF_HELPER_1(rdtime_d, i64, env)
>   #ifndef CONFIG_USER_ONLY
>   /* CSRs helper */
>   DEF_HELPER_1(csrrd_pgd, i64, env)
> +DEF_HELPER_1(csrrd_cpuid, i64, env)
>   DEF_HELPER_1(csrrd_tval, i64, env)
>   DEF_HELPER_2(csrwr_estat, i64, env, tl)
>   DEF_HELPER_2(csrwr_asid, i64, env, tl)
> diff --git a/target/loongarch/csr_helper.c b/target/loongarch/csr_helper.c
> index 6526367946..55341551a5 100644
> --- a/target/loongarch/csr_helper.c
> +++ b/target/loongarch/csr_helper.c
> @@ -35,6 +35,15 @@ target_ulong helper_csrrd_pgd(CPULoongArchState *env)
>       return v;
>   }
>   
> +target_ulong helper_csrrd_cpuid(CPULoongArchState *env)
> +{
> +    LoongArchCPU *lac = env_archcpu(env);
> +
> +    env->CSR_CPUID = CPU(lac)->cpu_index;
> +
> +    return env->CSR_CPUID;
> +}
> +
>   target_ulong helper_csrrd_tval(CPULoongArchState *env)
>   {
>       LoongArchCPU *cpu = env_archcpu(env);
> diff --git a/target/loongarch/insn_trans/trans_privileged.c.inc b/target/loongarch/insn_trans/trans_privileged.c.inc
> index 02bca7ca23..9c9de090f0 100644
> --- a/target/loongarch/insn_trans/trans_privileged.c.inc
> +++ b/target/loongarch/insn_trans/trans_privileged.c.inc
> @@ -99,13 +99,7 @@ static const CSRInfo csr_info[] = {
>       CSR_OFF(PWCH),
>       CSR_OFF(STLBPS),
>       CSR_OFF(RVACFG),
> -    [LOONGARCH_CSR_CPUID] = {
> -        .offset = (int)offsetof(CPUState, cpu_index)
> -                  - (int)offsetof(LoongArchCPU, env),
> -        .flags = CSRFL_READONLY,
> -        .readfn = NULL,
> -        .writefn = NULL
> -    },
> +    CSR_OFF_FUNCS(CPUID, CSRFL_READONLY, gen_helper_csrrd_cpuid, NULL),
>       CSR_OFF_FLAGS(PRCFG1, CSRFL_READONLY),
>       CSR_OFF_FLAGS(PRCFG2, CSRFL_READONLY),
>       CSR_OFF_FLAGS(PRCFG3, CSRFL_READONLY),
> 


