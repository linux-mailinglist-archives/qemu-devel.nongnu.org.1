Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 817B19A1D51
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Oct 2024 10:36:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1LyR-0005Dj-9b; Thu, 17 Oct 2024 04:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1LyN-0005D8-QE
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 04:35:07 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1LyK-0005iQ-Q8
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 04:35:07 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4315baec69eso3091585e9.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 01:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729154102; x=1729758902;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=11aMx5lx5rAm8xTIS/VRe2LoHsgXj7opopVn1FTfpZE=;
 b=kwJsC2Zy1nKBQuRXdOVqFmXEp7EZXSgB195Gc1tMpQJisdaVcTRkxxDdupKq9Gu7QM
 a/RXNtqHOIi6OCN1IY1ejiy7MpAXIIm41wa00aHZxaTq3WpeSpuWmkUlzEFNhN2/iOIm
 fpY6j1MsVPpjNGVqAjQSdFH6UGA+CxVRkEQQo4GIvHbHSBH8mdpCSklR4u0eZqlsaD7L
 ZuAaIjN5YDhyYSre51U7HzMINXkMg2e9trguTBSXghntr+d4LWf4AxJ9NUfYtgZCsICy
 dyv53bCQj5PKqiowHvAvR6ffsbdli3tgvtySk6Q8zVN0DV2oqpfYpLLvYHYD8O1PGaLE
 eoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729154102; x=1729758902;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=11aMx5lx5rAm8xTIS/VRe2LoHsgXj7opopVn1FTfpZE=;
 b=OjSTNuPV+Cv38BMB1UkzKo+jYycXE295m31bVC583tzZXmZSom0WvHsrXiB0ne9w47
 aVcJSHSXRc4Uasq2fWjdhRZJqGN6h7WOWKsZvIX3HvRatBIMSsznOqOSJqRBRG6oa99k
 9r1QRll/7g+lzq3my6XrAQJnNLXgPG7jX4olNhnWSc/QOj31e4hyVSh7fKqqe1F0kQmD
 YEXR/KIXbrQMzCR1oYFsoAA3vsZeqa5YXaBGf+5JhefFicrYYySMquyYAxD+FrKaoyw/
 /js6UKfgOg7QW89kEJeqb5bZ8fHJZjtBAmnK0lyAMsl2xZXhxVy96BGdeYOpn/UUa+Jn
 +WYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9vBoJoMamspt4AnefUQwDcwVJNs5CgzEZp90fiHJvJEiSdHdcUfpgIHHGcPxjyMVrDzUk8kqKxst0@nongnu.org
X-Gm-Message-State: AOJu0YzI5UgW9j+TxWPTdRmtAt6NuQp38zCHXMDSnZPai6Qy7uwASid4
 7fbtCWUZOvd9yGmT/HWIfzdqUdjxBzyPi9TZaueb+aJ9Hh8aZtlPkNooZNVi11s=
X-Google-Smtp-Source: AGHT+IF2/pI5NwwmR2a1hO/LXwz4AX8SY98GSSsU97uWRBZpYotOf5Dk3PMFFBj1NQuSz7hY6BqDPA==
X-Received: by 2002:a05:600c:1d20:b0:42b:af5a:109 with SMTP id
 5b1f17b1804b1-4312560903cmr159383085e9.24.1729154102250; 
 Thu, 17 Oct 2024 01:35:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fc45d63sm6555409f8f.117.2024.10.17.01.35.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 01:35:01 -0700 (PDT)
Message-ID: <399d5621-cdbe-47f5-b014-6ee3e9f2b5f7@rivosinc.com>
Date: Thu, 17 Oct 2024 10:35:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] target/riscv: Add Ssdbltrp CSRs handling
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
References: <20241014112225.90297-1-cleger@rivosinc.com>
 <20241014112225.90297-2-cleger@rivosinc.com>
 <f4ae3ad2-bd3e-4b9e-9013-b890e561df0a@linux.alibaba.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <f4ae3ad2-bd3e-4b9e-9013-b890e561df0a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 16/10/2024 11:40, LIU Zhiwei wrote:
> 
> On 2024/10/14 19:22, Clément Léger wrote:
>> Add ext_ssdbltrp in RISCVCPUConfig and implement MSTATUS.SDT,
>> {H|M}ENVCFG.DTE and modify the availability of MTVAL2 based on the
>> presence of the Ssdbltrp ISA extension.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>   target/riscv/cpu.h        |  1 +
>>   target/riscv/cpu_bits.h   |  6 ++++++
>>   target/riscv/cpu_cfg.h    |  1 +
>>   target/riscv/cpu_helper.c | 20 +++++++++++++++++
>>   target/riscv/csr.c        | 45 ++++++++++++++++++++++++++++++---------
>>   5 files changed, 63 insertions(+), 10 deletions(-)
>>
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index a84e719d3f..ee984bf270 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -553,6 +553,7 @@ void riscv_cpu_set_geilen(CPURISCVState *env,
>> target_ulong geilen);
>>   bool riscv_cpu_vector_enabled(CPURISCVState *env);
>>   void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
>>   int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
>> +bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt);
>>   G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr
>> addr,
>>                                                  MMUAccessType
>> access_type,
>>                                                  int mmu_idx,
>> uintptr_t retaddr);
>> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>> index da1723496c..3a5588d4df 100644
>> --- a/target/riscv/cpu_bits.h
>> +++ b/target/riscv/cpu_bits.h
>> @@ -558,6 +558,7 @@
>>   #define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
>>   #define MSTATUS_TW          0x00200000 /* since: priv-1.10 */
>>   #define MSTATUS_TSR         0x00400000 /* since: priv-1.10 */
>> +#define MSTATUS_SDT         0x01000000
>>   #define MSTATUS_GVA         0x4000000000ULL
>>   #define MSTATUS_MPV         0x8000000000ULL
>>   @@ -588,6 +589,7 @@ typedef enum {
>>   #define SSTATUS_XS          0x00018000
>>   #define SSTATUS_SUM         0x00040000 /* since: priv-1.10 */
>>   #define SSTATUS_MXR         0x00080000
>> +#define SSTATUS_SDT         0x01000000
>>     #define SSTATUS64_UXL       0x0000000300000000ULL
>>   @@ -777,11 +779,13 @@ typedef enum RISCVException {
>>   #define MENVCFG_CBIE                       (3UL << 4)
>>   #define MENVCFG_CBCFE                      BIT(6)
>>   #define MENVCFG_CBZE                       BIT(7)
>> +#define MENVCFG_DTE                        (1ULL << 59)
>>   #define MENVCFG_ADUE                       (1ULL << 61)
>>   #define MENVCFG_PBMTE                      (1ULL << 62)
>>   #define MENVCFG_STCE                       (1ULL << 63)
>>     /* For RV32 */
>> +#define MENVCFGH_DTE                       BIT(27)
>>   #define MENVCFGH_ADUE                      BIT(29)
>>   #define MENVCFGH_PBMTE                     BIT(30)
>>   #define MENVCFGH_STCE                      BIT(31)
>> @@ -795,11 +799,13 @@ typedef enum RISCVException {
>>   #define HENVCFG_CBIE                       MENVCFG_CBIE
>>   #define HENVCFG_CBCFE                      MENVCFG_CBCFE
>>   #define HENVCFG_CBZE                       MENVCFG_CBZE
>> +#define HENVCFG_DTE                        MENVCFG_DTE
>>   #define HENVCFG_ADUE                       MENVCFG_ADUE
>>   #define HENVCFG_PBMTE                      MENVCFG_PBMTE
>>   #define HENVCFG_STCE                       MENVCFG_STCE
>>     /* For RV32 */
>> +#define HENVCFGH_DTE                        MENVCFGH_DTE
>>   #define HENVCFGH_ADUE                       MENVCFGH_ADUE
>>   #define HENVCFGH_PBMTE                      MENVCFGH_PBMTE
>>   #define HENVCFGH_STCE                       MENVCFGH_STCE
>> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
>> index ae2a945b5f..dd804f95d4 100644
>> --- a/target/riscv/cpu_cfg.h
>> +++ b/target/riscv/cpu_cfg.h
>> @@ -77,6 +77,7 @@ struct RISCVCPUConfig {
>>       bool ext_smstateen;
>>       bool ext_sstc;
>>       bool ext_smcntrpmf;
>> +    bool ext_ssdbltrp;
>>       bool ext_svadu;
>>       bool ext_svinval;
>>       bool ext_svnapot;
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index 9d0400035f..77e7736d8a 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -63,6 +63,22 @@ int riscv_env_mmu_index(CPURISCVState *env, bool
>> ifetch)
>>   #endif
>>   }
>>   +bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
>> +{
>> +#ifdef CONFIG_USER_ONLY
>> +    return false;
>> +#else
>> +    if (!riscv_cpu_cfg(env)->ext_ssdbltrp) {
>> +        return false;
>> +    }
> 
> As we have guard the write to henvcfg and menvcfg by ext_ssdbltrp, I
> think it is enough only check henvcfg or menvcfg.
> 
> The only miss is we don't guard the writhe to henvcfgh. I think we can
> add the guard there.

Hi Liu,

Actually, since write_henvcfgh() uses mencvfg & (... | HENVCFG_DTE) as a
mask to write the value, if the MENVCFG_DTE bit is not set in menvcfg,
then it won't be set in henvcfgh as well. So I guess you are right about
removing the ext_ssdbltrp check.

> 
>> +    if (virt) {
>> +        return (env->henvcfg & HENVCFG_DTE) != 0;
>> +    } else {
>> +        return (env->menvcfg & MENVCFG_DTE) != 0;
>> +    }
>> +#endif
>> +}
>> +
>>   void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>>                             uint64_t *cs_base, uint32_t *pflags)
>>   {
>> @@ -562,6 +578,10 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState
>> *env)
>>         g_assert(riscv_has_ext(env, RVH));
>>   +    if (riscv_env_smode_dbltrp_enabled(env, current_virt)) {
>> +        mstatus_mask |= MSTATUS_SDT;
>> +    }
>> +
>>       if (current_virt) {
>>           /* Current V=1 and we are about to change to V=0 */
>>           env->vsstatus = env->mstatus & mstatus_mask;
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index e5de72453c..d8280ec956 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -540,6 +540,15 @@ static RISCVException aia_hmode32(CPURISCVState
>> *env, int csrno)
>>       return hmode32(env, csrno);
>>   }
>>   +static RISCVException dbltrp_hmode(CPURISCVState *env, int csrno)
>> +{
>> +    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
>> +        return RISCV_EXCP_NONE;
>> +    }
>> +
>> +    return hmode(env, csrno);
>> +}
>> +
>>   static RISCVException pmp(CPURISCVState *env, int csrno)
>>   {
>>       if (riscv_cpu_cfg(env)->pmp) {
>> @@ -1402,7 +1411,7 @@ static const target_ulong vs_delegable_excps =
>> DELEGABLE_EXCPS &
>>         (1ULL << (RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT)));
>>   static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE |
>> SSTATUS_SPIE |
>>       SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS |
>> SSTATUS_XS |
>> -    SSTATUS_SUM | SSTATUS_MXR | SSTATUS_VS;
>> +    SSTATUS_SUM | SSTATUS_MXR | SSTATUS_VS | SSTATUS_SDT;
> This breaks  the v_1_10 constraint, as it is not part of 1.10
> specification.

Yes, you are right, I'll add individual checks for this bit.

>>     /*
>>    * Spec allows for bits 13:63 to be either read-only or writable.
>> @@ -1600,6 +1609,14 @@ static RISCVException
>> write_mstatus(CPURISCVState *env, int csrno,
>>           mask |= MSTATUS_VS;
>>       }
>>   +    if (riscv_env_smode_dbltrp_enabled(env, env->virt_enabled)) {
>> +        mask |= MSTATUS_SDT;
>> +        if ((val & MSTATUS_SDT) != 0) {
>> +            mstatus &= ~MSTATUS_SIE;
> No need to clean it, if MSTATUS_SIE will be cleaned in val.

Indeed.

>> +            val &= ~MSTATUS_SIE;
>> +        }
>> +    }
>> +
> I think we should also consider vsstatus for SIE field, as
> write_vsstatus doesn't fall through to write_mstatus.

It seems like write_vsstatus() allows any value to be written when
accessed directly. But it is masked correctly when swapping for hs to
virt in riscv_cpu_swap_hypervisor_regs(). So I guess the check for SIE
should actually be done in riscv_cpu_swap_hypervisor_regs() itself
before setting mstatus from vsstatus ?


>>       if (xl != MXL_RV32 || env->debugger) {
>>           if (riscv_has_ext(env, RVH)) {
>>               mask |= MSTATUS_MPV | MSTATUS_GVA;
>> @@ -2354,7 +2371,8 @@ static RISCVException
>> write_menvcfg(CPURISCVState *env, int csrno,
>>       if (riscv_cpu_mxl(env) == MXL_RV64) {
>>           mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>>                   (cfg->ext_sstc ? MENVCFG_STCE : 0) |
>> -                (cfg->ext_svadu ? MENVCFG_ADUE : 0);
>> +                (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
>> +                (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
>>       }
>>       env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
>>   @@ -2374,7 +2392,8 @@ static RISCVException
>> write_menvcfgh(CPURISCVState *env, int csrno,
>>       const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
>>       uint64_t mask = (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>>                       (cfg->ext_sstc ? MENVCFG_STCE : 0) |
>> -                    (cfg->ext_svadu ? MENVCFG_ADUE : 0);
>> +                    (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
>> +                    (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
>>       uint64_t valh = (uint64_t)val << 32;
>>         env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
>> @@ -2425,9 +2444,10 @@ static RISCVException
>> read_henvcfg(CPURISCVState *env, int csrno,
>>        * henvcfg.pbmte is read_only 0 when menvcfg.pbmte = 0
>>        * henvcfg.stce is read_only 0 when menvcfg.stce = 0
>>        * henvcfg.adue is read_only 0 when menvcfg.adue = 0
>> +     * henvcfg.dte is read_only 0 when menvcfg.dte = 0
>>        */
>> -    *val = env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE |
>> HENVCFG_ADUE) |
>> -                           env->menvcfg);
>> +    *val = env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE |
>> HENVCFG_ADUE |
>> +                             HENVCFG_DTE) | env->menvcfg);
>>       return RISCV_EXCP_NONE;
>>   }
>>   @@ -2435,6 +2455,7 @@ static RISCVException
>> write_henvcfg(CPURISCVState *env, int csrno,
>>                                       target_ulong val)
>>   {
>>       uint64_t mask = HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE |
>> HENVCFG_CBZE;
>> +    uint64_t menvcfg_mask;
>>       RISCVException ret;
>>         ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
>> @@ -2443,7 +2464,11 @@ static RISCVException
>> write_henvcfg(CPURISCVState *env, int csrno,
>>       }
>>         if (riscv_cpu_mxl(env) == MXL_RV64) {
>> -        mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
>> HENVCFG_ADUE);
>> +        menvcfg_mask = HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE;
>> +        if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
>> +            menvcfg_mask |= HENVCFG_DTE;
>> +        }
>> +        mask |= env->menvcfg & menvcfg_mask;
>>       }
>>         env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
>> @@ -2461,8 +2486,8 @@ static RISCVException
>> read_henvcfgh(CPURISCVState *env, int csrno,
>>           return ret;
>>       }
>>   -    *val = (env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE |
>> HENVCFG_ADUE) |
>> -                            env->menvcfg)) >> 32;
>> +    *val = (env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE |
>> HENVCFG_ADUE |
>> +                              HENVCFG_DTE) | env->menvcfg)) >> 32;
>>       return RISCV_EXCP_NONE;
>>   }
>>   @@ -2470,7 +2495,7 @@ static RISCVException
>> write_henvcfgh(CPURISCVState *env, int csrno,
>>                                        target_ulong val)
>>   {
>>       uint64_t mask = env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
>> -                                    HENVCFG_ADUE);
>> +                                    HENVCFG_ADUE | HENVCFG_DTE);
> 
> Add the ssdbltrp guard here.

As said at the beginning, since henvcfgh uses the menvcfg value as the
mask, if DTE isn't enabled in menvcfg then henvcfg will not be written
as well (and the DTE write in menvcfg is guarded by ext_ssdbltrp).

Thanks for the review,

Clément

> 
> Thanks,
> Zhiwei
> 
>>       uint64_t valh = (uint64_t)val << 32;
>>       RISCVException ret;
>>   @@ -5246,7 +5271,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>>       [CSR_VSATP]       = { "vsatp",       hmode,   read_vsatp,   
>> write_vsatp,
>>                             .min_priv_ver =
>> PRIV_VERSION_1_12_0                },
>>   -    [CSR_MTVAL2]      = { "mtval2",      hmode,   read_mtval2,  
>> write_mtval2,
>> +    [CSR_MTVAL2]      = { "mtval2", dbltrp_hmode, read_mtval2,
>> write_mtval2,
>>                             .min_priv_ver =
>> PRIV_VERSION_1_12_0                },
>>       [CSR_MTINST]      = { "mtinst",      hmode,   read_mtinst,  
>> write_mtinst,
>>                             .min_priv_ver =
>> PRIV_VERSION_1_12_0                },


