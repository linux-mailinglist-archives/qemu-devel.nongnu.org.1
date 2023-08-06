Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B130F771588
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 16:14:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSeVi-0006Ff-1W; Sun, 06 Aug 2023 10:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSeVg-0006FG-J3
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 10:13:32 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSeVd-0005tL-Gg
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 10:13:32 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-686ba97e4feso3563746b3a.0
 for <qemu-devel@nongnu.org>; Sun, 06 Aug 2023 07:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691331196; x=1691935996;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yxifkdl4ef8SHpQwA9as1XGMGdtopwx9GaL/xip4nn8=;
 b=edRUcJ4kMQrRkeIhRszKxnJTnfTdFA/TbWmwhmOyDRPoQ0DBLdhxZPD9cMdwjtKLQO
 xDVOp7EQ+YEJ2RgS7w2bKxEyffYoa+ceaJ67q2t+wCZuSVfVR3a7gdt1Bf85IZqouAv/
 8HCQxNRoJtm5evBKgvv8z5Mej2ApTEP2fYxvFcEOSE5dVfvY1E8k6HGIZjl9UUZdRBke
 izx5jg3RyTLRm5F4Qa66PRC1zB3wp2cf+o+JKoL4vbmaGEfE7ED8VhA+lCkbP1VwC3wX
 JAfxC7aBjQJ3Xi9SiqE8u+2Ah7NLbx9CV/CCJszCObidcIqdDuD5aQT4029xuxMy77g+
 8zPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691331196; x=1691935996;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yxifkdl4ef8SHpQwA9as1XGMGdtopwx9GaL/xip4nn8=;
 b=W+GSUMGSX8lNPlzMiFlG6ViCPtM34ibtr7h+DOic4p6EJperhnETuhnc3iOpKu1p1w
 j06w5DWeuu88pObM5SV8MYczGZ1vhkGu1nDeSGhhUgyCXF6f+qB61OTL2iKMtx5QYlzV
 REKME373FKSFIGoDiK+sK1T2PgiUR4TapadEG7G3E5IudWo00PSZTd4zUOVDJSwB5ktz
 xOTtuWEwc4lQ9wFiQ38z/FGHAzDOxsUidO7mCbs/1PGlzeyjXdGuaRUwmJX5cNfkuTQg
 xYHARMnvPvyrDVg9DQzG5IzlCCgmVHR5jPZGCbiG9EdnzRYQMyhRHb1N+EtlUjTJAS6c
 EA7Q==
X-Gm-Message-State: AOJu0YzOA1zWSjDwcFsZOscUFMu8bDAFtfUmIUed7OKHX6VYKGfZ3SqJ
 izbKW+EeMsIoL/5hloetf/JCYQ==
X-Google-Smtp-Source: AGHT+IG0igleASnjygYpdIrDWXQkHbVOSF4/TwE0tgLfguvfKVs3JSP73/pjSyvzZDCxgsGP6/7Ixw==
X-Received: by 2002:a05:6a20:9497:b0:134:5c75:3d23 with SMTP id
 hs23-20020a056a20949700b001345c753d23mr6904508pzb.18.1691331196342; 
 Sun, 06 Aug 2023 07:13:16 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e72:57bd:c5e4:990c?
 ([2602:47:d490:6901:e72:57bd:c5e4:990c])
 by smtp.gmail.com with ESMTPSA id
 p27-20020a63951b000000b00563590be25esm3688674pgd.29.2023.08.06.07.13.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Aug 2023 07:13:15 -0700 (PDT)
Message-ID: <a0db9ba1-31df-87ab-949e-518c72e3639a@linaro.org>
Date: Sun, 6 Aug 2023 07:13:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 7/7] tcg/ppc: Use prefixed instructions for tcg_out_goto_tb
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: jniethe5@gmail.com, qemu-ppc@nongnu.org, bgray@linux.ibm.com
References: <20230804213355.294443-1-richard.henderson@linaro.org>
 <20230804213355.294443-8-richard.henderson@linaro.org>
 <CULH7KALGQKY.2AVIQQUXLTX5U@wheely>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CULH7KALGQKY.2AVIQQUXLTX5U@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.139,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 8/6/23 05:55, Nicholas Piggin wrote:
> On Sat Aug 5, 2023 at 7:33 AM AEST, Richard Henderson wrote:
>> When a direct branch is out of range, we can load the destination for
>> the indirect branch using PLA (for 16GB worth of buffer) and PLD from
>> the TranslationBlock for everything larger.
>>
>> This means the patch affects exactly one instruction: B (plus filler),
>> PLA or PLD.  Which means we can update and execute the patch atomically.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/ppc/tcg-target.c.inc | 76 ++++++++++++++++++++++++++++++----------
>>   1 file changed, 58 insertions(+), 18 deletions(-)
>>
>> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
>> index 5b243b2353..47c71bb5f2 100644
>> --- a/tcg/ppc/tcg-target.c.inc
>> +++ b/tcg/ppc/tcg-target.c.inc
>> @@ -2642,31 +2642,41 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
>>       uintptr_t ptr = get_jmp_target_addr(s, which);
>>   
>>       if (USE_REG_TB) {
>> +        /*
>> +         * With REG_TB, we must always use indirect branching,
>> +         * so that the branch destination and TCG_REG_TB match.
>> +         */
>>           ptrdiff_t offset = tcg_tbrel_diff(s, (void *)ptr);
>>           tcg_out_mem_long(s, LD, LDX, TCG_REG_TB, TCG_REG_TB, offset);
>> -
>> -        /* TODO: Use direct branches when possible. */
>> -        set_jmp_insn_offset(s, which);
>>           tcg_out32(s, MTSPR | RS(TCG_REG_TB) | CTR);
>> -
>>           tcg_out32(s, BCCTR | BO_ALWAYS);
>>   
>>           /* For the unlinked case, need to reset TCG_REG_TB.  */
>>           set_jmp_reset_offset(s, which);
>>           tcg_out_mem_long(s, ADDI, ADD, TCG_REG_TB, TCG_REG_TB,
>>                            -tcg_current_code_size(s));
>> +        return;
>> +    }
>> +
>> +    if (have_isa_3_10) {
>> +        /* Align, so that we can patch 8 bytes atomically. */
>> +        if ((uintptr_t)s->code_ptr & 7) {
>> +            tcg_out32(s, NOP);
>> +        }
>> +        set_jmp_insn_offset(s, which);
>> +        /* Direct branch will be patched by tb_target_set_jmp_target. */
>> +        tcg_out_mls_d(s, ADDI, TCG_REG_TMP1, 0, 0, 1);
>>       } else {
>>           /* Direct branch will be patched by tb_target_set_jmp_target. */
>> -        set_jmp_insn_offset(s, which);
>> -        tcg_out32(s, NOP);
>> -
>> +        tcg_out32(s, B);
>>           /* When branch is out of range, fall through to indirect. */
>>           tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP1, ptr - (int16_t)ptr);
>>           tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1, (int16_t)ptr);
>> -        tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | CTR);
>> -        tcg_out32(s, BCCTR | BO_ALWAYS);
>> -        set_jmp_reset_offset(s, which);
>>       }
>> +
>> +    tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | CTR);
>> +    tcg_out32(s, BCCTR | BO_ALWAYS);
>> +    set_jmp_reset_offset(s, which);
>>   }
>>   
>>   void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
>> @@ -2674,20 +2684,50 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
>>   {
>>       uintptr_t addr = tb->jmp_target_addr[n];
>>       intptr_t diff = addr - jmp_rx;
>> -    tcg_insn_unit insn;
>>   
>>       if (USE_REG_TB) {
>>           return;
>>       }
>>   
>> -    if (in_range_b(diff)) {
>> -        insn = B | (diff & 0x3fffffc);
>> -    } else {
>> -        insn = NOP;
>> -    }
>> +    if (have_isa_3_10) {
>> +        tcg_insn_unit insn1, insn2;
>> +        uint64_t pair;
>>   
>> -    qatomic_set((uint32_t *)jmp_rw, insn);
>> -    flush_idcache_range(jmp_rx, jmp_rw, 4);
>> +        if (in_range_b(diff)) {
>> +            insn1 = B | (diff & 0x3fffffc);
>> +            insn2 = NOP;
>> +        } else if (diff == sextract64(diff, 0, 34)) {
>> +            /* PLA tmp1, diff */
>> +            insn1 = OPCD(1) | (2 << 24) | (1 << 20) | ((diff >> 16) & 0x3ffff);
>> +            insn2 = ADDI | TAI(TCG_REG_TMP1, 0, diff);
>> +        } else {
>> +            addr = (uintptr_t)&tb->jmp_target_addr[n];
>> +            diff = addr - jmp_rx;
>> +            tcg_debug_assert(diff == sextract64(diff, 0, 34));
>> +            /* PLD tmp1, diff */
>> +            insn1 = OPCD(1) | (1 << 20) | ((diff >> 16) & 0x3ffff);
>> +            insn2 = PLD | TAI(TCG_REG_TMP1, 0, diff);
>> +        }
> 
> B is a "patch class" word instruction as per CMODX in the ISA, which may
> be patched to/from other instructions without a flush+isync sequence
> betwen. So that part is okay, at least if you were just patching the B
> word. But patching between the PLA and PLD I don't think is kosher per
> ISA.
> 
> I struggle a bit with this part of the ISA, particularly with prefix
> instructions (it only talks about patching 4 bytes at a time).
> 
> If we patch something it has to go through a patch instruction, which
> is a direct branch, trap, or nop. I think that makes this non-trivial.
> 
> It could work if you only patched between B and PLD. B->PLD would have
> to patch the suffix word first, possibly with an interleaving sync, and
> then the prefix. PLD->B could just patch the B word.
> 
> How much would losing the PLA hurt?

Really?  I can't imagine how some icache would see a torn prefixed insn given an atomic 
store (CMODX talks about prefixed instructions which "may be unaligned" -- but what if 
they are not?).

But if patching an aligned prefixed insn isn't allowed, I would patch between B and NOP, 
leave the PLD alone on the fall-through path, and drop the PLA.


r~

