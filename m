Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA7B797234
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 14:14:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeDt0-0002lr-LT; Thu, 07 Sep 2023 08:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qeDsp-0002jD-F2
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:13:15 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qeDsh-0001Cw-4a
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:13:14 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxVuhLvvlk7V0hAA--.31343S3;
 Thu, 07 Sep 2023 20:13:00 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Ax3c5KvvlkkKNwAA--.8733S3; 
 Thu, 07 Sep 2023 20:12:58 +0800 (CST)
Subject: Re: [PATCH 1/2] tcg: Add gvec compare with immediate and scalar
 operand
From: gaosong <gaosong@loongson.cn>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230831030904.1194667-1-richard.henderson@linaro.org>
 <20230831030904.1194667-2-richard.henderson@linaro.org>
 <274b7ba4-1089-3941-5b9a-fb06b2eb51cf@loongson.cn>
Message-ID: <3210131f-94bc-6c1f-d69e-967f77e8009c@loongson.cn>
Date: Thu, 7 Sep 2023 20:12:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <274b7ba4-1089-3941-5b9a-fb06b2eb51cf@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax3c5KvvlkkKNwAA--.8733S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3CrWkGFWrGFWfKw15tF1kJFc_yoW8Gw18Co
 W7Kr1rJr15Jr1jgr1UXr1UJr13JF1UJFnFqr1UGry7Jr18Jr1UG3yUJrWUtayUJr18CFyU
 JF1DJrWjyFyUAr45l-sFpf9Il3svdjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUY47kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL
 05UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
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

在 2023/9/7 下午3:39, gaosong 写道:
> Hi, Richard
> 在 2023/8/31 上午11:09, Richard Henderson 写道:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   accel/tcg/tcg-runtime.h          |  25 ++++++
>>   include/tcg/tcg-op-gvec-common.h |   6 ++
>>   accel/tcg/tcg-runtime-gvec.c     |  26 ++++++
>>   tcg/tcg-op-gvec.c                | 150 +++++++++++++++++++++++++++++++
>>   4 files changed, 207 insertions(+)
>>
> 
> I use tcg_gen_gvec_cmps for LoongArch vector cmp instructions.  but I 
> got an Aborted error from temp_load().  I'll fixes this later.
> 
My mistaken,  It's work well.
I will use tcg_gen_gvec_cmps on LoongArch's LASX series.

For this patch:
Tested-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao

> And I'll send LASX V5 series. this series will not use tcg_gen_gvec_cmps.
> 
> Thanks.
> Song Gao
> 
>> diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
>> index 186899a2c7..c23b5e66c4 100644
>> --- a/accel/tcg/tcg-runtime.h
>> +++ b/accel/tcg/tcg-runtime.h
>> @@ -297,4 +297,29 @@ DEF_HELPER_FLAGS_4(gvec_leu16, TCG_CALL_NO_RWG, 
>> void, ptr, ptr, ptr, i32)
>>   DEF_HELPER_FLAGS_4(gvec_leu32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, 
>> i32)
>>   DEF_HELPER_FLAGS_4(gvec_leu64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, 
>> i32)
>> +DEF_HELPER_FLAGS_4(gvec_eqs8, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
>> +DEF_HELPER_FLAGS_4(gvec_eqs16, TCG_CALL_NO_RWG, void, ptr, ptr, i64, 
>> i32)
>> +DEF_HELPER_FLAGS_4(gvec_eqs32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, 
>> i32)
>> +DEF_HELPER_FLAGS_4(gvec_eqs64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, 
>> i32)
>> +
>> +DEF_HELPER_FLAGS_4(gvec_lts8, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
>> +DEF_HELPER_FLAGS_4(gvec_lts16, TCG_CALL_NO_RWG, void, ptr, ptr, i64, 
>> i32)
>> +DEF_HELPER_FLAGS_4(gvec_lts32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, 
>> i32)
>> +DEF_HELPER_FLAGS_4(gvec_lts64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, 
>> i32)
>> +
>> +DEF_HELPER_FLAGS_4(gvec_les8, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
>> +DEF_HELPER_FLAGS_4(gvec_les16, TCG_CALL_NO_RWG, void, ptr, ptr, i64, 
>> i32)
>> +DEF_HELPER_FLAGS_4(gvec_les32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, 
>> i32)
>> +DEF_HELPER_FLAGS_4(gvec_les64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, 
>> i32)
>> +
>> +DEF_HELPER_FLAGS_4(gvec_ltus8, TCG_CALL_NO_RWG, void, ptr, ptr, i64, 
>> i32)
>> +DEF_HELPER_FLAGS_4(gvec_ltus16, TCG_CALL_NO_RWG, void, ptr, ptr, i64, 
>> i32)
>> +DEF_HELPER_FLAGS_4(gvec_ltus32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, 
>> i32)
>> +DEF_HELPER_FLAGS_4(gvec_ltus64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, 
>> i32)
>> +
>> +DEF_HELPER_FLAGS_4(gvec_leus8, TCG_CALL_NO_RWG, void, ptr, ptr, i64, 
>> i32)
>> +DEF_HELPER_FLAGS_4(gvec_leus16, TCG_CALL_NO_RWG, void, ptr, ptr, i64, 
>> i32)
>> +DEF_HELPER_FLAGS_4(gvec_leus32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, 
>> i32)
>> +DEF_HELPER_FLAGS_4(gvec_leus64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, 
>> i32)
>> +
>>   DEF_HELPER_FLAGS_5(gvec_bitsel, TCG_CALL_NO_RWG, void, ptr, ptr, 
>> ptr, ptr, i32)
>> diff --git a/include/tcg/tcg-op-gvec-common.h 
>> b/include/tcg/tcg-op-gvec-common.h
>> index e2683d487f..4db8a58c14 100644
>> --- a/include/tcg/tcg-op-gvec-common.h
>> +++ b/include/tcg/tcg-op-gvec-common.h
>> @@ -374,6 +374,12 @@ void tcg_gen_gvec_rotrv(unsigned vece, uint32_t 
>> dofs, uint32_t aofs,
>>   void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
>>                         uint32_t aofs, uint32_t bofs,
>>                         uint32_t oprsz, uint32_t maxsz);
>> +void tcg_gen_gvec_cmpi(TCGCond cond, unsigned vece, uint32_t dofs,
>> +                       uint32_t aofs, int64_t c,
>> +                       uint32_t oprsz, uint32_t maxsz);
>> +void tcg_gen_gvec_cmps(TCGCond cond, unsigned vece, uint32_t dofs,
>> +                       uint32_t aofs, TCGv_i64 c,
>> +                       uint32_t oprsz, uint32_t maxsz);
>>   /*
>>    * Perform vector bit select: d = (b & a) | (c & ~a).
>> diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
>> index 6c99f952ca..afca89baa1 100644
>> --- a/accel/tcg/tcg-runtime-gvec.c
>> +++ b/accel/tcg/tcg-runtime-gvec.c
>> @@ -1042,6 +1042,32 @@ DO_CMP2(64)
>>   #undef DO_CMP1
>>   #undef DO_CMP2
>> +#define DO_CMP1(NAME, TYPE, 
>> OP)                                            \
>> +void HELPER(NAME)(void *d, void *a, uint64_t b64, uint32_t 
>> desc)           \
>> +{                                                                          
>> \
>> +    intptr_t oprsz = 
>> simd_oprsz(desc);                                     \
>> +    TYPE inv = simd_data(desc), b = 
>> b64;                                   \
>> +    for (intptr_t i = 0; i < oprsz; i += sizeof(TYPE)) 
>> {                   \
>> +        *(TYPE *)(d + i) = -((*(TYPE *)(a + i) OP b) ^ 
>> inv);               \
>> +    
>> }                                                                      \
>> +    clear_high(d, oprsz, 
>> desc);                                            \
>> +}
>> +
>> +#define DO_CMP2(SZ) \
>> +    DO_CMP1(gvec_eqs##SZ, uint##SZ##_t, ==)    \
>> +    DO_CMP1(gvec_lts##SZ, int##SZ##_t, <)      \
>> +    DO_CMP1(gvec_les##SZ, int##SZ##_t, <=)     \
>> +    DO_CMP1(gvec_ltus##SZ, uint##SZ##_t, <)    \
>> +    DO_CMP1(gvec_leus##SZ, uint##SZ##_t, <=)
>> +
>> +DO_CMP2(8)
>> +DO_CMP2(16)
>> +DO_CMP2(32)
>> +DO_CMP2(64)
>> +
>> +#undef DO_CMP1
>> +#undef DO_CMP2
>> +
>>   void HELPER(gvec_ssadd8)(void *d, void *a, void *b, uint32_t desc)
>>   {
>>       intptr_t oprsz = simd_oprsz(desc);
>> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
>> index f5cfd9bf99..f7ca9e1051 100644
>> --- a/tcg/tcg-op-gvec.c
>> +++ b/tcg/tcg-op-gvec.c
>> @@ -3819,6 +3819,156 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned 
>> vece, uint32_t dofs,
>>       }
>>   }
>> +void tcg_gen_gvec_cmps(TCGCond cond, unsigned vece, uint32_t dofs,
>> +                       uint32_t aofs, TCGv_i64 c,
>> +                       uint32_t oprsz, uint32_t maxsz)
>> +{
>> +    static const TCGOpcode cmp_list[] = { INDEX_op_cmp_vec, 0 };
>> +    static gen_helper_gvec_2i * const eq_fn[4] = {
>> +        gen_helper_gvec_eqs8, gen_helper_gvec_eqs16,
>> +        gen_helper_gvec_eqs32, gen_helper_gvec_eqs64
>> +    };
>> +    static gen_helper_gvec_2i * const lt_fn[4] = {
>> +        gen_helper_gvec_lts8, gen_helper_gvec_lts16,
>> +        gen_helper_gvec_lts32, gen_helper_gvec_lts64
>> +    };
>> +    static gen_helper_gvec_2i * const le_fn[4] = {
>> +        gen_helper_gvec_les8, gen_helper_gvec_les16,
>> +        gen_helper_gvec_les32, gen_helper_gvec_les64
>> +    };
>> +    static gen_helper_gvec_2i * const ltu_fn[4] = {
>> +        gen_helper_gvec_ltus8, gen_helper_gvec_ltus16,
>> +        gen_helper_gvec_ltus32, gen_helper_gvec_ltus64
>> +    };
>> +    static gen_helper_gvec_2i * const leu_fn[4] = {
>> +        gen_helper_gvec_leus8, gen_helper_gvec_leus16,
>> +        gen_helper_gvec_leus32, gen_helper_gvec_leus64
>> +    };
>> +    static gen_helper_gvec_2i * const * const fns[16] = {
>> +        [TCG_COND_EQ] = eq_fn,
>> +        [TCG_COND_LT] = lt_fn,
>> +        [TCG_COND_LE] = le_fn,
>> +        [TCG_COND_LTU] = ltu_fn,
>> +        [TCG_COND_LEU] = leu_fn,
>> +    };
>> +
>> +    TCGType type;
>> +
>> +    check_size_align(oprsz, maxsz, dofs | aofs);
>> +    check_overlap_2(dofs, aofs, maxsz);
>> +
>> +    if (cond == TCG_COND_NEVER || cond == TCG_COND_ALWAYS) {
>> +        do_dup(MO_8, dofs, oprsz, maxsz,
>> +               NULL, NULL, -(cond == TCG_COND_ALWAYS));
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * Implement inline with a vector type, if possible.
>> +     * Prefer integer when 64-bit host and 64-bit comparison.
>> +     */
>> +    type = choose_vector_type(cmp_list, vece, oprsz,
>> +                              TCG_TARGET_REG_BITS == 64 && vece == 
>> MO_64);
>> +    if (type != 0) {
>> +        const TCGOpcode *hold_list = tcg_swap_vecop_list(cmp_list);
>> +        TCGv_vec t_vec = tcg_temp_new_vec(type);
>> +        uint32_t some, i;
>> +
>> +        tcg_gen_dup_i64_vec(vece, t_vec, c);
>> +
>> +        switch (type) {
>> +        case TCG_TYPE_V256:
>> +            some = QEMU_ALIGN_DOWN(oprsz, 32);
>> +            for (i = 0; i < some; i += 32) {
>> +                TCGv_vec t0 = tcg_temp_new_vec(TCG_TYPE_V256);
>> +                TCGv_vec t1 = tcg_temp_new_vec(TCG_TYPE_V256);
>> +                tcg_gen_ld_vec(t0, cpu_env, aofs);
>> +                tcg_gen_cmp_vec(cond, vece, t0, t1, t_vec);
>> +                tcg_gen_st_vec(t0, cpu_env, dofs);
>> +                aofs += 32;
>> +                dofs += 32;
>> +            }
>> +            oprsz -= some;
>> +            maxsz -= some;
>> +            /* fallthru */
>> +
>> +        case TCG_TYPE_V128:
>> +            some = QEMU_ALIGN_DOWN(oprsz, 16);
>> +            for (i = 0; i < some; i += 16) {
>> +                TCGv_vec t0 = tcg_temp_new_vec(TCG_TYPE_V128);
>> +                TCGv_vec t1 = tcg_temp_new_vec(TCG_TYPE_V128);
>> +                tcg_gen_ld_vec(t0, cpu_env, aofs + i);
>> +                tcg_gen_cmp_vec(cond, vece, t0, t1, t_vec);
>> +                tcg_gen_st_vec(t0, cpu_env, dofs + i);
>> +            }
>> +            break;
>> +
>> +        case TCG_TYPE_V64:
>> +            some = QEMU_ALIGN_DOWN(oprsz, 8);
>> +            for (i = 0; i < some; i += 8) {
>> +                TCGv_vec t0 = tcg_temp_new_vec(TCG_TYPE_V64);
>> +                TCGv_vec t1 = tcg_temp_new_vec(TCG_TYPE_V64);
>> +                tcg_gen_ld_vec(t0, cpu_env, aofs + i);
>> +                tcg_gen_cmp_vec(cond, vece, t0, t1, t_vec);
>> +                tcg_gen_st_vec(t0, cpu_env, dofs + i);
>> +            }
>> +            break;
>> +
>> +        default:
>> +            g_assert_not_reached();
>> +        }
>> +        tcg_temp_free_vec(t_vec);
>> +        tcg_swap_vecop_list(hold_list);
>> +    } else if (vece == MO_64 && check_size_impl(oprsz, 8)) {
>> +        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
>> +        uint32_t i;
>> +
>> +        for (i = 0; i < oprsz; i += 8) {
>> +            tcg_gen_ld_i64(t0, cpu_env, aofs + i);
>> +            tcg_gen_negsetcond_i64(cond, t0, t0, c);
>> +            tcg_gen_st_i64(t0, cpu_env, dofs + i);
>> +        }
>> +        tcg_temp_free_i64(t0);
>> +    } else if (vece == MO_32 && check_size_impl(oprsz, 4)) {
>> +        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
>> +        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
>> +        uint32_t i;
>> +
>> +        tcg_gen_extrl_i64_i32(t1, c);
>> +        for (i = 0; i < oprsz; i += 8) {
>> +            tcg_gen_ld_i32(t0, cpu_env, aofs + i);
>> +            tcg_gen_negsetcond_i32(cond, t0, t0, t1);
>> +            tcg_gen_st_i32(t0, cpu_env, dofs + i);
>> +        }
>> +        tcg_temp_free_i32(t0);
>> +        tcg_temp_free_i32(t1);
>> +    } else {
>> +        gen_helper_gvec_2i * const *fn = fns[cond];
>> +        bool inv = false;
>> +
>> +        if (fn == NULL) {
>> +            cond = tcg_invert_cond(cond);
>> +            fn = fns[cond];
>> +            assert(fn != NULL);
>> +            inv = true;
>> +        }
>> +        tcg_gen_gvec_2i_ool(dofs, aofs, c, oprsz, maxsz, inv, fn[vece]);
>> +        return;
>> +    }
>> +
>> +    if (oprsz < maxsz) {
>> +        expand_clr(dofs + oprsz, maxsz - oprsz);
>> +    }
>> +}
>> +
>> +void tcg_gen_gvec_cmpi(TCGCond cond, unsigned vece, uint32_t dofs,
>> +                       uint32_t aofs, int64_t c,
>> +                       uint32_t oprsz, uint32_t maxsz)
>> +{
>> +    TCGv_i64 tmp = tcg_constant_i64(c);
>> +    tcg_gen_gvec_cmps(cond, vece, dofs, aofs, tmp, oprsz, maxsz);
>> +}
>> +
>>   static void tcg_gen_bitsel_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, 
>> TCGv_i64 c)
>>   {
>>       TCGv_i64 t = tcg_temp_ebb_new_i64();
>>
> 


