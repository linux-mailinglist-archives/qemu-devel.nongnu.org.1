Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 758699B6939
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Oct 2024 17:32:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6BbW-0006be-GW; Wed, 30 Oct 2024 12:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t6BbT-0006bO-U8
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 12:31:27 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t6BbR-0004sN-L4
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 12:31:27 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7db238d07b3so65541a12.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730305884; x=1730910684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sVfVlwVu+Z3kwY1hRP86rZwjIeIgzm597+76gxAN1sI=;
 b=RYJome1RwwCrpPQXrVIIQz4AAYk2ac8ymiFP7goivN0Xmmaj56/DEHc7j8eL+nBDnw
 ACwc3iMwOqFoSZl1I6IH85MQcCpI3pGuVS4Ijd5ot/wOm9qex7djfuy/I4ehG8S36BDI
 YLZM8bIebg3Fi7hHcZ4YLBq53xw1Qlc5R9EE5b17dlLnoAqPKjg9r7M6noNbVNad1BvP
 vI+eqSQbV+wWFSql6M7/Mghd0O44TSoirPsnJfBr++GFIpLsFUNOD+knD4Cxczge26qr
 TEKiAsDXJ5PntF0pW4jE6Ukmatp+PESIBMnaAxuONy7IqBzwYfEtrBWskDJ0iYQZD9CF
 5FZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730305884; x=1730910684;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sVfVlwVu+Z3kwY1hRP86rZwjIeIgzm597+76gxAN1sI=;
 b=aN1XJdJcsDs9twWYZYqYOren/wr/XEFJKosU5qwRs6EVB3MJnRV+GBJgfQIE75EGod
 V/415kxLuVTBpQxRmxvE+WbhcZSg4kCMT/vLAkTDeXmFT+17MpFOWs1rfHqgm36D+mZJ
 /Gaj1w92zXuUNhBOBBuYXO8DoKp2OfUoLWdmI+Hx5fQXak6NNpNrVg18ARhCE1kkxKdV
 BgFl4YomiryFPwldLyZAAjJE5A0kyMl0uXRC7hjIGprbM21HFN5WMzZe5onMOXFtcOI3
 9dWE0J/qgAJ8aRDW6BoVAyaHYLsF6VLprvbj0P9F11CnRYGkChxvMS1VqG7WZFWm0fR7
 k+Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV247lY6wqdyUCV9Bit7L4RIslU/DYMHEg6NpCVQWLusARA0jQOLz91QztHbVuXyuvHPz/ZJoQgDYLh@nongnu.org
X-Gm-Message-State: AOJu0YwXesvI1qN1bPFP3m0WVAWDJ2kl9BQaBjOAfgZd9B0jt+ps/uBG
 e/dCtsjmkPJVCNAsEUiUv+I/VA4xj3fItQ4w8v8SC9eQHfxGyUdAj+WEha1zBss=
X-Google-Smtp-Source: AGHT+IFh22L7hkCSI17lYcOMgpU7Q8oR8LDKFg5cl3upjG4Cfl6OBZn4hs2HCE1XXa+jNeVJgGre3w==
X-Received: by 2002:a05:6a20:c793:b0:1d8:d613:7d6f with SMTP id
 adf61e73a8af0-1d9a83a9a56mr21410859637.4.1730305883748; 
 Wed, 30 Oct 2024 09:31:23 -0700 (PDT)
Received: from [192.168.68.110] ([191.8.109.222])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72057931cd4sm9459216b3a.70.2024.10.30.09.31.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 09:31:23 -0700 (PDT)
Message-ID: <5dc3808b-2420-4a58-9e01-526b6ab01a67@ventanamicro.com>
Date: Wed, 30 Oct 2024 13:31:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] target/riscv: rvv: Provide a fast path using
 direct access to host ram for unit-stride whole register load/store
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 richard.henderson@linaro.org, negge@google.com
References: <20240918171412.150107-1-max.chou@sifive.com>
 <20240918171412.150107-5-max.chou@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240918171412.150107-5-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 9/18/24 2:14 PM, Max Chou wrote:
> The vector unit-stride whole register load/store instructions are
> similar to unmasked unit-stride load/store instructions that is suitable
> to be optimized by using a direct access to host ram fast path.
> 
> Because the vector whole register load/store instructions do not need to
> handle the tail agnostic, so remove the vstart early exit checking.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/vector_helper.c | 129 +++++++++++++++++++----------------
>   1 file changed, 70 insertions(+), 59 deletions(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index c2fcf8b3a00..824e6401736 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -665,80 +665,91 @@ GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d_tlb)
>    */
>   static void
>   vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
> -                vext_ldst_elem_fn_tlb *ldst_elem, uint32_t log2_esz,
> -                uintptr_t ra)
> +                vext_ldst_elem_fn_tlb *ldst_tlb,
> +                vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
> +                uintptr_t ra, bool is_load)
>   {
> -    uint32_t i, k, off, pos;
> +    target_ulong page_split, elems, addr;
>       uint32_t nf = vext_nf(desc);
>       uint32_t vlenb = riscv_cpu_cfg(env)->vlenb;
>       uint32_t max_elems = vlenb >> log2_esz;
> +    uint32_t evl = nf * max_elems;
> +    uint32_t esz = 1 << log2_esz;
> +    int mmu_index = riscv_env_mmu_index(env, false);
>   
> -    if (env->vstart >= ((vlenb * nf) >> log2_esz)) {
> -        env->vstart = 0;
> -        return;
> +    /* Calculate the page range of first page */
> +    addr = base + (env->vstart << log2_esz);
> +    page_split = -(addr | TARGET_PAGE_MASK);
> +    /* Get number of elements */
> +    elems = page_split / esz;
> +    if (unlikely(env->vstart + elems >= evl)) {
> +        elems = evl - env->vstart;
>       }
>   
> -    k = env->vstart / max_elems;
> -    off = env->vstart % max_elems;
> -
> -    if (off) {
> -        /* load/store rest of elements of current segment pointed by vstart */
> -        for (pos = off; pos < max_elems; pos++, env->vstart++) {
> -            target_ulong addr = base + ((pos + k * max_elems) << log2_esz);
> -            ldst_elem(env, adjust_addr(env, addr), pos + k * max_elems, vd,
> -                      ra);
> -        }
> -        k++;
> +    /* Load/store elements in the first page */
> +    if (likely(elems)) {
> +        vext_page_ldst_us(env, vd, addr, elems, 1, max_elems, log2_esz,
> +                          is_load, mmu_index, ldst_tlb, ldst_host, ra);
>       }
>   
> -    /* load/store elements for rest of segments */
> -    for (; k < nf; k++) {
> -        for (i = 0; i < max_elems; i++, env->vstart++) {
> -            target_ulong addr = base + ((i + k * max_elems) << log2_esz);
> -            ldst_elem(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
> +    /* Load/store elements in the second page */
> +    if (unlikely(env->vstart < evl)) {
> +        /* Cross page element */
> +        if (unlikely(page_split % esz)) {
> +            addr = base + (env->vstart << log2_esz);
> +            ldst_tlb(env, adjust_addr(env, addr), env->vstart, vd, ra);
> +            env->vstart++;
>           }
> +
> +        addr = base + (env->vstart << log2_esz);
> +        /* Get number of elements of second page */
> +        elems = evl - env->vstart;
> +
> +        /* Load/store elements in the second page */
> +        vext_page_ldst_us(env, vd, addr, elems, 1, max_elems, log2_esz,
> +                          is_load, mmu_index, ldst_tlb, ldst_host, ra);
>       }
>   
>       env->vstart = 0;
>   }
>   
> -#define GEN_VEXT_LD_WHOLE(NAME, ETYPE, LOAD_FN)      \
> -void HELPER(NAME)(void *vd, target_ulong base,       \
> -                  CPURISCVState *env, uint32_t desc) \
> -{                                                    \
> -    vext_ldst_whole(vd, base, env, desc, LOAD_FN,    \
> -                    ctzl(sizeof(ETYPE)), GETPC());   \
> -}
> -
> -GEN_VEXT_LD_WHOLE(vl1re8_v,  int8_t,  lde_b_tlb)
> -GEN_VEXT_LD_WHOLE(vl1re16_v, int16_t, lde_h_tlb)
> -GEN_VEXT_LD_WHOLE(vl1re32_v, int32_t, lde_w_tlb)
> -GEN_VEXT_LD_WHOLE(vl1re64_v, int64_t, lde_d_tlb)
> -GEN_VEXT_LD_WHOLE(vl2re8_v,  int8_t,  lde_b_tlb)
> -GEN_VEXT_LD_WHOLE(vl2re16_v, int16_t, lde_h_tlb)
> -GEN_VEXT_LD_WHOLE(vl2re32_v, int32_t, lde_w_tlb)
> -GEN_VEXT_LD_WHOLE(vl2re64_v, int64_t, lde_d_tlb)
> -GEN_VEXT_LD_WHOLE(vl4re8_v,  int8_t,  lde_b_tlb)
> -GEN_VEXT_LD_WHOLE(vl4re16_v, int16_t, lde_h_tlb)
> -GEN_VEXT_LD_WHOLE(vl4re32_v, int32_t, lde_w_tlb)
> -GEN_VEXT_LD_WHOLE(vl4re64_v, int64_t, lde_d_tlb)
> -GEN_VEXT_LD_WHOLE(vl8re8_v,  int8_t,  lde_b_tlb)
> -GEN_VEXT_LD_WHOLE(vl8re16_v, int16_t, lde_h_tlb)
> -GEN_VEXT_LD_WHOLE(vl8re32_v, int32_t, lde_w_tlb)
> -GEN_VEXT_LD_WHOLE(vl8re64_v, int64_t, lde_d_tlb)
> -
> -#define GEN_VEXT_ST_WHOLE(NAME, ETYPE, STORE_FN)     \
> -void HELPER(NAME)(void *vd, target_ulong base,       \
> -                  CPURISCVState *env, uint32_t desc) \
> -{                                                    \
> -    vext_ldst_whole(vd, base, env, desc, STORE_FN,   \
> -                    ctzl(sizeof(ETYPE)), GETPC());   \
> -}
> -
> -GEN_VEXT_ST_WHOLE(vs1r_v, int8_t, ste_b_tlb)
> -GEN_VEXT_ST_WHOLE(vs2r_v, int8_t, ste_b_tlb)
> -GEN_VEXT_ST_WHOLE(vs4r_v, int8_t, ste_b_tlb)
> -GEN_VEXT_ST_WHOLE(vs8r_v, int8_t, ste_b_tlb)
> +#define GEN_VEXT_LD_WHOLE(NAME, ETYPE, LOAD_FN_TLB, LOAD_FN_HOST)   \
> +void HELPER(NAME)(void *vd, target_ulong base, CPURISCVState *env,  \
> +                  uint32_t desc)                                    \
> +{                                                                   \
> +    vext_ldst_whole(vd, base, env, desc, LOAD_FN_TLB, LOAD_FN_HOST, \
> +                    ctzl(sizeof(ETYPE)), GETPC(), true);            \
> +}
> +
> +GEN_VEXT_LD_WHOLE(vl1re8_v,  int8_t,  lde_b_tlb, lde_b_host)
> +GEN_VEXT_LD_WHOLE(vl1re16_v, int16_t, lde_h_tlb, lde_h_host)
> +GEN_VEXT_LD_WHOLE(vl1re32_v, int32_t, lde_w_tlb, lde_w_host)
> +GEN_VEXT_LD_WHOLE(vl1re64_v, int64_t, lde_d_tlb, lde_d_host)
> +GEN_VEXT_LD_WHOLE(vl2re8_v,  int8_t,  lde_b_tlb, lde_b_host)
> +GEN_VEXT_LD_WHOLE(vl2re16_v, int16_t, lde_h_tlb, lde_h_host)
> +GEN_VEXT_LD_WHOLE(vl2re32_v, int32_t, lde_w_tlb, lde_w_host)
> +GEN_VEXT_LD_WHOLE(vl2re64_v, int64_t, lde_d_tlb, lde_d_host)
> +GEN_VEXT_LD_WHOLE(vl4re8_v,  int8_t,  lde_b_tlb, lde_b_host)
> +GEN_VEXT_LD_WHOLE(vl4re16_v, int16_t, lde_h_tlb, lde_h_host)
> +GEN_VEXT_LD_WHOLE(vl4re32_v, int32_t, lde_w_tlb, lde_w_host)
> +GEN_VEXT_LD_WHOLE(vl4re64_v, int64_t, lde_d_tlb, lde_d_host)
> +GEN_VEXT_LD_WHOLE(vl8re8_v,  int8_t,  lde_b_tlb, lde_b_host)
> +GEN_VEXT_LD_WHOLE(vl8re16_v, int16_t, lde_h_tlb, lde_h_host)
> +GEN_VEXT_LD_WHOLE(vl8re32_v, int32_t, lde_w_tlb, lde_w_host)
> +GEN_VEXT_LD_WHOLE(vl8re64_v, int64_t, lde_d_tlb, lde_d_host)
> +
> +#define GEN_VEXT_ST_WHOLE(NAME, ETYPE, STORE_FN_TLB, STORE_FN_HOST)     \
> +void HELPER(NAME)(void *vd, target_ulong base, CPURISCVState *env,      \
> +                  uint32_t desc)                                        \
> +{                                                                       \
> +    vext_ldst_whole(vd, base, env, desc, STORE_FN_TLB, STORE_FN_HOST,   \
> +                    ctzl(sizeof(ETYPE)), GETPC(), false);               \
> +}
> +
> +GEN_VEXT_ST_WHOLE(vs1r_v, int8_t, ste_b_tlb, ste_b_host)
> +GEN_VEXT_ST_WHOLE(vs2r_v, int8_t, ste_b_tlb, ste_b_host)
> +GEN_VEXT_ST_WHOLE(vs4r_v, int8_t, ste_b_tlb, ste_b_host)
> +GEN_VEXT_ST_WHOLE(vs8r_v, int8_t, ste_b_tlb, ste_b_host)
>   
>   /*
>    * Vector Integer Arithmetic Instructions

