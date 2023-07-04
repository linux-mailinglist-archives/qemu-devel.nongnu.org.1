Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B8E746C44
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:47:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbgG-0003Wv-OZ; Tue, 04 Jul 2023 04:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qGbg5-0003T6-UU
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:46:37 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qGbg2-0001gX-U5
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:Reply-To:MIME-Version:Date:Message-ID:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Fxql732l+Dk3d8uyIk/7sZzGBQD8SXFBMKe8yEugmgA=; b=Qnf3ErHO1irmvgnpL3CE8OK1X5
 m9jbOcu7vp3GKwow1X66/cj9QdBBLmLvkzqUJRWEe/6MgBqOmxHBJiZfnqVFI45z6T6Lx3X2DF/C4
 /A+6U1dvoimhIZJhWxB8fcmQllNCbD/PfPfI7UY39+tCHG6JqzLMFnwaQqd8izC/1ofY=;
Message-ID: <b90d0c4d-0f3a-e479-9851-6de2267d4be6@rev.ng>
Date: Tue, 4 Jul 2023 10:45:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 5/9] accel: Move CPUTLB to CPUState and assert offset
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, eduardo@habkost.net, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, peter.maydell@linaro.org, wangyanan55@huawei.com
References: <20230630122551.21766-1-anjo@rev.ng>
 <20230630122551.21766-6-anjo@rev.ng>
 <bc65acdc-b32d-0f0f-82c3-b2143c9af6e9@linaro.org>
Content-Language: en-US
Organization: rev.ng
In-Reply-To: <bc65acdc-b32d-0f0f-82c3-b2143c9af6e9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  anjo@rev.ng
X-ACL-Warn: ,  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


On 6/30/23 16:16, Richard Henderson wrote:
> On 6/30/23 14:25, Anton Johansson wrote:
>> @@ -448,6 +448,13 @@ struct CPUState {
>>         /* track IOMMUs whose translations we've cached in the TCG 
>> TLB */
>>       GArray *iommu_notifiers;
>> +
>> +    /*
>> +     * The following fields needs to be within 
>> CPU_MAX_NEGATIVE_ENV_OFFSET of
>> +     * CPUArchState.  As CPUArchState is assumed to follow CPUState 
>> in the
>> +     * ArchCPU struct these are placed last.  This is checked 
>> statically.
>> +     */
>> +    CPUTLB tlb;
>>   };
>
> This is what we had before CPUNegativeOffsetState, comment and all, 
> and over the course of time the comment was ignored and the CPUTLB 
> crept toward the middle of the structure.

I recall you talking about this earlier.  Is there any reason the
drifting of CPUTLB/IcountDecr from env wouldn't be caught by the static
asserts we've added?

>
> I really don't see how this merge helps.  There's nothing 
> target-specific about CPUTLBDescFast or CPUNegativeOffsetState, and 
> keeping them separate enforces their importance.
>

There isn't anything target specific about CPUTLBDescFast but its offset
in ArchCPU does depend on the target.  This is due to the
TARGET_PAGE_ENTRY_EXTRA macro in CPUTLBEntryFull which is replaced
with a union in the first patch of this patchset.

On second thought, I think you're right and keeping CPUTLB and IcountDecr
together to emphasize their importance makes sense.  There would still be
an implicit assumption on the target to keep CPUArchState and CPUState
close together, at least the intent is signaled better by 
CPUNegativeOffsetState.
Even so, statically asserting the offset to CPUTLB and IcountDecr would be a
good idea.

The main concern of this patchset is being able to access the tlb and
icount_decr fields in a target-independent way only having access to
CPUState.  Merging CPUNegativeOffsetState simply made the accessing part
simpler, but let's have a cpu_tlb(CPUState *) function instead.

I'll pull out the patch for making CPUTLB target independent and include
it in the patchset replacing CPUArchState with CPUState in cputlb.c and
user-exec.c.  The static assert patches will be resubmitted separately.

Thanks,

-- 
Anton Johansson,
rev.ng Labs Srl.


