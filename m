Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C52FF755E4F
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 10:18:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLJQA-0000Mn-4Z; Mon, 17 Jul 2023 04:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ssoM=DD=kaod.org=clg@ozlabs.org>)
 id 1qLJPe-0000Lb-Bi; Mon, 17 Jul 2023 04:16:58 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ssoM=DD=kaod.org=clg@ozlabs.org>)
 id 1qLJPb-0002dq-42; Mon, 17 Jul 2023 04:16:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4R4FKh3MsGz4wxP;
 Mon, 17 Jul 2023 18:16:40 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4R4FKc4TDKz4wb8;
 Mon, 17 Jul 2023 18:16:36 +1000 (AEST)
Message-ID: <69e30854-79c5-af62-74ee-177daa55af7f@kaod.org>
Date: Mon, 17 Jul 2023 10:16:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tcg/ppc: Fix race in goto_tb implementation
To: Richard Henderson <richard.henderson@linaro.org>,
 Jordan Niethe <jniethe5@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, alex.bennee@linaro.org, dbarboza@ventanamicro.com,
 npiggin@gmail.com, anushree.mathur@linux.vnet.ibm.com, mjt@tls.msk.ru,
 bgray@linux.ibm.com
References: <20230717012327.20149-1-jniethe5@gmail.com>
 <504c0ab2-e314-c27b-a119-a310d8b028a1@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <504c0ab2-e314-c27b-a119-a310d8b028a1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=ssoM=DD=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.091, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 7/17/23 09:35, Richard Henderson wrote:
> On 7/17/23 02:23, Jordan Niethe wrote:
>> Commit 20b6643324 ("tcg/ppc: Reorg goto_tb implementation") modified
>> goto_tb to ensure only a single instruction was patched to prevent
>> incorrect behaviour if a thread was in the middle of multiple
>> instructions when they were replaced. However this introduced a race
>> between loading the jmp target into TCG_REG_TB and patching and
>> executing the direct branch.
>>
>> The relevent part of the goto_tb implementation:
>>
>>      ld TCG_REG_TB, TARGET_ADDR_LOCATION(TCG_REG_TB)
>>    patch_location:
>>      mtctr TCG_REG_TB
>>      bctr
>>
>> tb_target_set_jmp_target() will replace 'patch_location' with a direct
>> branch if the target is in range. The direct branch now relies on
>> TCG_REG_TB being set up correctly by the ld. Prior to this commit
>> multiple instructions were patched in for the direct branch case; these
>> instructions would initalise TCG_REG_TB to the same value as the branch
>> target.
>>
>> Imagine the following sequence:
>>
>> 1) Thread A is executing the goto_tb sequence and loads the jmp
>>     target into TCG_REG_TB.
>>
>> 2) Thread B updates the jmp target address and calls
>>     tb_target_set_jmp_target(). This patches a new direct branch into the
>>     goto_tb sequence.
>>
>> 3) Thread A executes the newly patched direct branch. The value in
>>     TCG_REG_TB still contains the old jmp target.
>>
>> TCG_REG_TB MUST contain the translation block's tc.ptr. Execution will
>> eventually crash after performing memory accesses generated from a
>> faulty value in TCG_REG_TB.
>>
>> This presents as segfaults or illegal instruction exceptions.
>>
>> Do not revert commit 20b6643324 as it did fix a different race
>> condition. Instead remove the direct branch optimization and always use
>> indirect branches.
>>
>> The direct branch optimization can be re-added later with a race free
>> sequence.
>>
>> Gitlab issue: https://gitlab.com/qemu-project/qemu/-/issues/1726

Resolves: ...

Please send a v2 with updated tags. Run scripts/checkpatch.pl also.

Thanks,

C.


>>
>> Fixes: 20b6643324 ("tcg/ppc: Reorg goto_tb implementation")
>>
>> Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
>> Co-developed-by: Benjamin Gray <bgray@linux.ibm.com>
>> Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
>> ---
>>   tcg/ppc/tcg-target.c.inc | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
>> index 8d6899cf40..a7323f479b 100644
>> --- a/tcg/ppc/tcg-target.c.inc
>> +++ b/tcg/ppc/tcg-target.c.inc
>> @@ -2533,11 +2533,10 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
>>           ptrdiff_t offset = tcg_tbrel_diff(s, (void *)ptr);
>>           tcg_out_mem_long(s, LD, LDX, TCG_REG_TB, TCG_REG_TB, offset);
>> -        /* Direct branch will be patched by tb_target_set_jmp_target. */
>> +        /* TODO: Use direct branches when possible. */
>>           set_jmp_insn_offset(s, which);
>>           tcg_out32(s, MTSPR | RS(TCG_REG_TB) | CTR);
>> -        /* When branch is out of range, fall through to indirect. */
>>           tcg_out32(s, BCCTR | BO_ALWAYS);
>>           /* For the unlinked case, need to reset TCG_REG_TB.  */
>> @@ -2565,10 +2564,11 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
>>       intptr_t diff = addr - jmp_rx;
>>       tcg_insn_unit insn;
>> +    if (USE_REG_TB)
>> +        return;
>> +
> 
> Braces.  Otherwise,
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> This is an excellent reason to add support for power10, and its pc-relative references. We can disable REG_TB for that case.
> 
> 
> r~


