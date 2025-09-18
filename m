Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0AEB28BF7
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Aug 2025 10:41:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unCSo-00023D-59; Sat, 16 Aug 2025 04:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>)
 id 1unCSj-000225-2O; Sat, 16 Aug 2025 04:40:29 -0400
Received: from mail-m16.yeah.net ([220.197.32.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>)
 id 1unCSd-0000PX-Hc; Sat, 16 Aug 2025 04:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=8a6jqdb3Jm80sJ855uO2bdLlSQv1H5iLcHNwv0/Bcg8=;
 b=dp/fHgqEalk9ZgPtQtZa26FA8gOnXAzq/BM1a3y5plcAhDqPqrMeF1wHUMfiks
 P7O0enVOyE5eW8/qiUvdhMqNDo6qpBIZLd9+R8pJWVvurUh0gYz+Ekv5JI8YEjq2
 qTwzTw5ZkrC3sU/gf62NYnZ94kejgs9jJD3UZt9aw0SVw=
Received: from [192.168.71.3] (unknown [])
 by gzsmtp3 (Coremail) with SMTP id M88vCgD3n73LQ6BoLHWwAg--.33320S2;
 Sat, 16 Aug 2025 16:39:40 +0800 (CST)
Message-ID: <85784dcd-c43a-4a9b-88f8-cd6241cfc311@yeah.net>
Date: Sat, 16 Aug 2025 16:39:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] Generate strided vector loads/stores with tcg
 nodes.
To: Richard Henderson <richard.henderson@linaro.org>,
 paolo.savini@embecosm.com, ebiggers@kernel.org, dbarboza@ventanamicro.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <cover.1755305184.git.chao.liu@yeah.net>
 <468515337182030ddf6b05ec5eec7b6af9d43153.1755305184.git.chao.liu@yeah.net>
 <43454225-4239-4f44-a210-b0bb31818213@linaro.org>
From: Chao Liu <chao.liu@yeah.net>
In-Reply-To: <43454225-4239-4f44-a210-b0bb31818213@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: M88vCgD3n73LQ6BoLHWwAg--.33320S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3uFy5Jry5Kr1ftF43uw1DAwb_yoW8Ar4kCo
 W7Kr1rJry3Xr1jgr1UJryUJry3XF17Jrnrtw1UGry7Jw4rAF1UG3yUJrWUt3yUJF18GryU
 XF1UJFyjyFW7Zrnxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVtC7UUUUU
X-Originating-IP: [114.88.98.193]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiNgxGbmigQ8xHxAAA3W
Received-SPF: pass client-ip=220.197.32.19; envelope-from=chao.liu@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 8/16/2025 2:52 PM, Richard Henderson wrote:
> On 8/16/25 10:56, Chao Liu wrote:
>> This commit improves the performance of QEMU when emulating strided vector
>> loads and stores by substituting the call for the helper function with the
>> generation of equivalent TCG operations.
>>
>> Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
>> Signed-off-by: Chao Liu <chao.liu@yeah.net>
>> Tested-by: Eric Biggers <ebiggers@kernel.org>
>> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/insn_trans/trans_rvv.c.inc | 326 ++++++++++++++++++++----
>>   1 file changed, 276 insertions(+), 50 deletions(-)
>>
>> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
>> index 71f98fb350..b5d74b0ec9 100644
>> --- a/target/riscv/insn_trans/trans_rvv.c.inc
>> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
>> @@ -864,32 +864,289 @@ GEN_VEXT_TRANS(vlm_v, MO_8, vlm_v, ld_us_mask_op, ld_us_mask_check)
>>   GEN_VEXT_TRANS(vsm_v, MO_8, vsm_v, st_us_mask_op, st_us_mask_check)
>>   /*
>> - *** stride load and store
>> + * MAXSZ returns the maximum vector size can be operated in bytes,
>> + * which is used in GVEC IR when vl_eq_vlmax flag is set to true
>> + * to accelerate vector operation.
>> + */
>> +static inline uint32_t MAXSZ(DisasContext *s)
>> +{
>> +    int max_sz = s->cfg_ptr->vlenb << 3;
>> +    return max_sz >> (3 - s->lmul);
>> +}
>> +
>> +static inline uint32_t get_log2(uint32_t a)
>> +{
>> +    uint32_t i = 0;
>> +    if (a == 0) {
>> +        return i;
>> +    }
>> +    for (; a > 1;) {
>> +        a >>= 1;
>> +        i++;
>> +    }
>> +    return i;
>> +}
> 
> Since I didn't see v3 had been posted before I replied to v2, I'll repeat my suggestion of
> 
>      assert(is_power_of_2(a));
>      return ctz32(a);
> 
> as a better implementation of this function.
> 
> 
> r~
> 

This is a great idea. I'll adopt it and release a new version of the patch.


Best regards,

Chao

> 
>> +
>> +typedef void gen_tl_ldst(TCGv, TCGv_ptr, tcg_target_long);
>> +
>> +/*
>> + * Simulate the strided load/store main loop:
>> + *
>> + * for (i = env->vstart; i < env->vl; env->vstart = ++i) {
>> + *     k = 0;
>> + *     while (k < nf) {
>> + *         if (!vm && !vext_elem_mask(v0, i)) {
>> + *             vext_set_elems_1s(vd, vma, (i + k * max_elems) * esz,
>> + *                               (i + k * max_elems + 1) * esz);
>> + *             k++;
>> + *             continue;
>> + *         }
>> + *         target_ulong addr = base + stride * i + (k << log2_esz);
>> + *         ldst(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
>> + *         k++;
>> + *     }
>> + * }
>> + */
>> +static void gen_ldst_stride_main_loop(DisasContext *s, TCGv dest, uint32_t rs1,
>> +                                      uint32_t rs2, uint32_t vm, uint32_t nf,
>> +                                      gen_tl_ldst *ld_fn, gen_tl_ldst *st_fn,
>> +                                      bool is_load)
>> +{
>> +    TCGv addr = tcg_temp_new();
>> +    TCGv base = get_gpr(s, rs1, EXT_NONE);
>> +    TCGv stride = get_gpr(s, rs2, EXT_NONE);
>> +
>> +    TCGv i = tcg_temp_new();
>> +    TCGv i_esz = tcg_temp_new();
>> +    TCGv k = tcg_temp_new();
>> +    TCGv k_esz = tcg_temp_new();
>> +    TCGv k_max = tcg_temp_new();
>> +    TCGv mask = tcg_temp_new();
>> +    TCGv mask_offs = tcg_temp_new();
>> +    TCGv mask_offs_64 = tcg_temp_new();
>> +    TCGv mask_elem = tcg_temp_new();
>> +    TCGv mask_offs_rem = tcg_temp_new();
>> +    TCGv vreg = tcg_temp_new();
>> +    TCGv dest_offs = tcg_temp_new();
>> +    TCGv stride_offs = tcg_temp_new();
>> +
>> +    uint32_t max_elems = MAXSZ(s) >> s->sew;
>> +
>> +    TCGLabel *start = gen_new_label();
>> +    TCGLabel *end = gen_new_label();
>> +    TCGLabel *start_k = gen_new_label();
>> +    TCGLabel *inc_k = gen_new_label();
>> +    TCGLabel *end_k = gen_new_label();
>> +
>> +    MemOp atomicity = MO_ATOM_NONE;
>> +    if (s->sew == 0) {
>> +        atomicity = MO_ATOM_NONE;
>> +    } else {
>> +        atomicity = MO_ATOM_IFALIGN_PAIR;
>> +    }
>> +
>> +    mark_vs_dirty(s);
>> +
>> +    tcg_gen_addi_tl(mask, (TCGv)tcg_env, vreg_ofs(s, 0));
>> +
>> +    /* Start of outer loop. */
>> +    tcg_gen_mov_tl(i, cpu_vstart);
>> +    gen_set_label(start);
>> +    tcg_gen_brcond_tl(TCG_COND_GE, i, cpu_vl, end);
>> +    tcg_gen_shli_tl(i_esz, i, s->sew);
>> +    /* Start of inner loop. */
>> +    tcg_gen_movi_tl(k, 0);
>> +    gen_set_label(start_k);
>> +    tcg_gen_brcond_tl(TCG_COND_GE, k, tcg_constant_tl(nf), end_k);
>> +    /*
>> +     * If we are in mask agnostic regime and the operation is not unmasked we
>> +     * set the inactive elements to 1.
>> +     */
>> +    if (!vm && s->vma) {
>> +        TCGLabel *active_element = gen_new_label();
>> +        /* (i + k * max_elems) * esz */
>> +        tcg_gen_shli_tl(mask_offs, k, get_log2(max_elems << s->sew));
>> +        tcg_gen_add_tl(mask_offs, mask_offs, i_esz);
>> +
>> +        /*
>> +         * Check whether the i bit of the mask is 0 or 1.
>> +         *
>> +         * static inline int vext_elem_mask(void *v0, int index)
>> +         * {
>> +         *     int idx = index / 64;
>> +         *     int pos = index  % 64;
>> +         *     return (((uint64_t *)v0)[idx] >> pos) & 1;
>> +         * }
>> +         */
>> +        tcg_gen_shri_tl(mask_offs_64, mask_offs, 3);
>> +        tcg_gen_add_tl(mask_offs_64, mask_offs_64, mask);
>> +        tcg_gen_ld_i64((TCGv_i64)mask_elem, (TCGv_ptr)mask_offs_64, 0);
>> +        tcg_gen_rem_tl(mask_offs_rem, mask_offs, tcg_constant_tl(8));
>> +        tcg_gen_shr_tl(mask_elem, mask_elem, mask_offs_rem);
>> +        tcg_gen_andi_tl(mask_elem, mask_elem, 1);
>> +        tcg_gen_brcond_tl(TCG_COND_NE, mask_elem, tcg_constant_tl(0),
>> +                          active_element);
>> +        /*
>> +         * Set masked-off elements in the destination vector register to 1s.
>> +         * Store instructions simply skip this bit as memory ops access memory
>> +         * only for active elements.
>> +         */
>> +        if (is_load) {
>> +            tcg_gen_shli_tl(mask_offs, mask_offs, s->sew);
>> +            tcg_gen_add_tl(mask_offs, mask_offs, dest);
>> +            st_fn(tcg_constant_tl(-1), (TCGv_ptr)mask_offs, 0);
>> +        }
>> +        tcg_gen_br(inc_k);
>> +        gen_set_label(active_element);
>> +    }
>> +    /*
>> +     * The element is active, calculate the address with stride:
>> +     * target_ulong addr = base + stride * i + (k << log2_esz);
>> +     */
>> +    tcg_gen_mul_tl(stride_offs, stride, i);
>> +    tcg_gen_shli_tl(k_esz, k, s->sew);
>> +    tcg_gen_add_tl(stride_offs, stride_offs, k_esz);
>> +    tcg_gen_add_tl(addr, base, stride_offs);
>> +    /* Calculate the offset in the dst/src vector register. */
>> +    tcg_gen_shli_tl(k_max, k, get_log2(max_elems));
>> +    tcg_gen_add_tl(dest_offs, i, k_max);
>> +    tcg_gen_shli_tl(dest_offs, dest_offs, s->sew);
>> +    tcg_gen_add_tl(dest_offs, dest_offs, dest);
>> +    if (is_load) {
>> +        tcg_gen_qemu_ld_tl(vreg, addr, s->mem_idx, MO_LE | s->sew | atomicity);
>> +        st_fn((TCGv)vreg, (TCGv_ptr)dest_offs, 0);
>> +    } else {
>> +        ld_fn((TCGv)vreg, (TCGv_ptr)dest_offs, 0);
>> +        tcg_gen_qemu_st_tl(vreg, addr, s->mem_idx, MO_LE | s->sew | atomicity);
>> +    }
>> +    /*
>> +     * We don't execute the load/store above if the element was inactive.
>> +     * We jump instead directly to incrementing k and continuing the loop.
>> +     */
>> +    if (!vm && s->vma) {
>> +        gen_set_label(inc_k);
>> +    }
>> +    tcg_gen_addi_tl(k, k, 1);
>> +    tcg_gen_br(start_k);
>> +    /* End of the inner loop. */
>> +    gen_set_label(end_k);
>> +
>> +    tcg_gen_addi_tl(i, i, 1);
>> +    tcg_gen_mov_tl(cpu_vstart, i);
>> +    tcg_gen_br(start);
>> +
>> +    /* End of the outer loop. */
>> +    gen_set_label(end);
>> +
>> +    return;
>> +}
>> +
>> +
>> +/*
>> + * Set the tail bytes of the strided loads/stores to 1:
>> + *
>> + * for (k = 0; k < nf; ++k) {
>> + *     cnt = (k * max_elems + vl) * esz;
>> + *     tot = (k * max_elems + max_elems) * esz;
>> + *     for (i = cnt; i < tot; i += esz) {
>> + *         store_1s(-1, vd[vl+i]);
>> + *     }
>> + * }
>>    */
>> -typedef void gen_helper_ldst_stride(TCGv_ptr, TCGv_ptr, TCGv,
>> -                                    TCGv, TCGv_env, TCGv_i32);
>> +static void gen_ldst_stride_tail_loop(DisasContext *s, TCGv dest, uint32_t nf,
>> +                                      gen_tl_ldst *st_fn)
>> +{
>> +    TCGv i = tcg_temp_new();
>> +    TCGv k = tcg_temp_new();
>> +    TCGv tail_cnt = tcg_temp_new();
>> +    TCGv tail_tot = tcg_temp_new();
>> +    TCGv tail_addr = tcg_temp_new();
>> +
>> +    TCGLabel *start = gen_new_label();
>> +    TCGLabel *end = gen_new_label();
>> +    TCGLabel *start_i = gen_new_label();
>> +    TCGLabel *end_i = gen_new_label();
>> +
>> +    uint32_t max_elems_b = MAXSZ(s);
>> +    uint32_t esz = 1 << s->sew;
>> +
>> +    /* Start of the outer loop. */
>> +    tcg_gen_movi_tl(k, 0);
>> +    tcg_gen_shli_tl(tail_cnt, cpu_vl, s->sew);
>> +    tcg_gen_movi_tl(tail_tot, max_elems_b);
>> +    tcg_gen_add_tl(tail_addr, dest, tail_cnt);
>> +    gen_set_label(start);
>> +    tcg_gen_brcond_tl(TCG_COND_GE, k, tcg_constant_tl(nf), end);
>> +    /* Start of the inner loop. */
>> +    tcg_gen_mov_tl(i, tail_cnt);
>> +    gen_set_label(start_i);
>> +    tcg_gen_brcond_tl(TCG_COND_GE, i, tail_tot, end_i);
>> +    /* store_1s(-1, vd[vl+i]); */
>> +    st_fn(tcg_constant_tl(-1), (TCGv_ptr)tail_addr, 0);
>> +    tcg_gen_addi_tl(tail_addr, tail_addr, esz);
>> +    tcg_gen_addi_tl(i, i, esz);
>> +    tcg_gen_br(start_i);
>> +    /* End of the inner loop. */
>> +    gen_set_label(end_i);
>> +    /* Update the counts */
>> +    tcg_gen_addi_tl(tail_cnt, tail_cnt, max_elems_b);
>> +    tcg_gen_addi_tl(tail_tot, tail_cnt, max_elems_b);
>> +    tcg_gen_addi_tl(k, k, 1);
>> +    tcg_gen_br(start);
>> +    /* End of the outer loop. */
>> +    gen_set_label(end);
>> +
>> +    return;
>> +}
>>   static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
>> -                              uint32_t data, gen_helper_ldst_stride *fn,
>> -                              DisasContext *s)
>> +                              uint32_t data, DisasContext *s, bool is_load)
>>   {
>> -    TCGv_ptr dest, mask;
>> -    TCGv base, stride;
>> -    TCGv_i32 desc;
>> +    if (!s->vstart_eq_zero) {
>> +        return false;
>> +    }
>> -    dest = tcg_temp_new_ptr();
>> -    mask = tcg_temp_new_ptr();
>> -    base = get_gpr(s, rs1, EXT_NONE);
>> -    stride = get_gpr(s, rs2, EXT_NONE);
>> -    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
>> -                                      s->cfg_ptr->vlenb, data));
>> +    TCGv dest = tcg_temp_new();
>> -    tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
>> -    tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
>> +    uint32_t nf = FIELD_EX32(data, VDATA, NF);
>> +    uint32_t vm = FIELD_EX32(data, VDATA, VM);
>> +
>> +    /* Destination register and mask register */
>> +    tcg_gen_addi_tl(dest, (TCGv)tcg_env, vreg_ofs(s, vd));
>> +
>> +    /*
>> +     * Select the appropriate load/tore to retrieve data from the vector
>> +     * register given a specific sew.
>> +     */
>> +    static gen_tl_ldst * const ld_fns[4] = {
>> +        tcg_gen_ld8u_tl, tcg_gen_ld16u_tl,
>> +        tcg_gen_ld32u_tl, tcg_gen_ld_tl
>> +    };
>> +
>> +    static gen_tl_ldst * const st_fns[4] = {
>> +        tcg_gen_st8_tl, tcg_gen_st16_tl,
>> +        tcg_gen_st32_tl, tcg_gen_st_tl
>> +    };
>> +
>> +    gen_tl_ldst *ld_fn = ld_fns[s->sew];
>> +    gen_tl_ldst *st_fn = st_fns[s->sew];
>> +
>> +    if (ld_fn == NULL || st_fn == NULL) {
>> +        return false;
>> +    }
>>       mark_vs_dirty(s);
>> -    fn(dest, mask, base, stride, tcg_env, desc);
>> +    gen_ldst_stride_main_loop(s, dest, rs1, rs2, vm, nf, ld_fn, st_fn, is_load);
>> +
>> +    tcg_gen_movi_tl(cpu_vstart, 0);
>> +
>> +    /*
>> +     * Set the tail bytes to 1 if tail agnostic:
>> +     */
>> +    if (s->vta != 0 && is_load) {
>> +        gen_ldst_stride_tail_loop(s, dest, nf, st_fn);
>> +    }
>>       finalize_rvv_inst(s);
>>       return true;
>> @@ -898,16 +1155,6 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
>>   static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
>>   {
>>       uint32_t data = 0;
>> -    gen_helper_ldst_stride *fn;
>> -    static gen_helper_ldst_stride * const fns[4] = {
>> -        gen_helper_vlse8_v, gen_helper_vlse16_v,
>> -        gen_helper_vlse32_v, gen_helper_vlse64_v
>> -    };
>> -
>> -    fn = fns[eew];
>> -    if (fn == NULL) {
>> -        return false;
>> -    }
>>       uint8_t emul = vext_get_emul(s, eew);
>>       data = FIELD_DP32(data, VDATA, VM, a->vm);
>> @@ -915,7 +1162,7 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
>>       data = FIELD_DP32(data, VDATA, NF, a->nf);
>>       data = FIELD_DP32(data, VDATA, VTA, s->vta);
>>       data = FIELD_DP32(data, VDATA, VMA, s->vma);
>> -    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
>> +    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, s, true);
>>   }
>>   static bool ld_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
>> @@ -933,23 +1180,13 @@ GEN_VEXT_TRANS(vlse64_v, MO_64, rnfvm, ld_stride_op, ld_stride_check)
>>   static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
>>   {
>>       uint32_t data = 0;
>> -    gen_helper_ldst_stride *fn;
>> -    static gen_helper_ldst_stride * const fns[4] = {
>> -        /* masked stride store */
>> -        gen_helper_vsse8_v,  gen_helper_vsse16_v,
>> -        gen_helper_vsse32_v,  gen_helper_vsse64_v
>> -    };
>>       uint8_t emul = vext_get_emul(s, eew);
>>       data = FIELD_DP32(data, VDATA, VM, a->vm);
>>       data = FIELD_DP32(data, VDATA, LMUL, emul);
>>       data = FIELD_DP32(data, VDATA, NF, a->nf);
>> -    fn = fns[eew];
>> -    if (fn == NULL) {
>> -        return false;
>> -    }
>> -    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
>> +    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, s, false);
>>   }
>>   static bool st_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
>> @@ -1300,17 +1537,6 @@ GEN_LDST_WHOLE_TRANS(vs8r_v, int8_t, 8, false)
>>    *** Vector Integer Arithmetic Instructions
>>    */
>> -/*
>> - * MAXSZ returns the maximum vector size can be operated in bytes,
>> - * which is used in GVEC IR when vl_eq_vlmax flag is set to true
>> - * to accelerate vector operation.
>> - */
>> -static inline uint32_t MAXSZ(DisasContext *s)
>> -{
>> -    int max_sz = s->cfg_ptr->vlenb * 8;
>> -    return max_sz >> (3 - s->lmul);
>> -}
>> -
>>   static bool opivv_check(DisasContext *s, arg_rmrr *a)
>>   {
>>       return require_rvv(s) &&


