Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E209E79EA08
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 15:47:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgQDB-000173-2O; Wed, 13 Sep 2023 09:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qgQCx-00012l-IS
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 09:47:17 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qgQCt-00068M-8i
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 09:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:Reply-To:MIME-Version:Date:Message-ID:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sOpPhG8Ooo2YF5UD3LM7PKW5QTxtf6PYfmn10LNAEtY=; b=RV1CiANhzwteSGU4xCayFa2E6j
 uA487TSk3tR1X62HP+bsb8RlpuiSHFusddkPaggiw80SKTXV/Tz4x75WJGokcNx/2EBVOEYqSEcyY
 z2cVFtFeH7uv/zYP1K7iKqqepXba8o2EcOW3u1968Q5KBm1ZlLiYvgpGo6F3NHmuIRII=;
Message-ID: <561b2f3c-5002-4ef1-a201-8d3eb8699fbb@rev.ng>
Date: Wed, 13 Sep 2023 15:46:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] accel/tcg: Modifies memory access functions to use
 CPUState
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, philmd@linaro.org,
 peter.maydell@linaro.org
References: <20230912153428.17816-1-anjo@rev.ng>
 <20230912153428.17816-6-anjo@rev.ng>
 <ef6f5d06-4dfc-e114-3f1b-52ccc125c34e@linaro.org>
Content-Language: en-US
Organization: rev.ng
In-Reply-To: <ef6f5d06-4dfc-e114-3f1b-52ccc125c34e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  anjo@rev.ng
X-ACL-Warn: ,  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 9/12/23 21:34, Richard Henderson wrote:

> On 9/12/23 08:34, Anton Johansson wrote:
>> do_[ld|st]*() and mmu_lookup*() are changed to use CPUState over
>> CPUArchState, moving the target-dependence to the target-facing facing
>> cpu_[ld|st] functions.
>>
>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>> ---
>>   accel/tcg/cputlb.c | 324 ++++++++++++++++++++++-----------------------
>>   1 file changed, 161 insertions(+), 163 deletions(-)
>
> So... what's your ultimate plan here?
>
> At the moment through patches 5-11, all you do is take CPUArchState, 
> discard knowledge of it via CPUState, and then recover knowledge of it 
> via cpu->tlb_ptr.
>
> I agree that *something* has to happen in order to allow these entry 
> points to be used by multiple cpu types simultaneously, but there must 
> be a plan.
>
> Is it to have tcg generated code perform env_cpu() inline before the 
> call?  That's just pointer arithmetic, so it's certainly an easy option.
>
My bad, I wasn't expressing this clearly enough, but yes that is
more or less the idea.  We need full access to env for two things:
getting to CPUState, and getting the mmu_idx.  This needs to happen
on the target side, somehow.  My ideas here are:

     For non-helpers (e.g. cpu_ldb_mmu):
         - These functions are just thin wrappers around
           do_[ld|st]*_mmu(), env_cpu() and cpu_mmu_index(),
           and can be compiled with each target;
         - or make these functions take CPUState, and explicitly
           call env_cpu on the target side. Functions needing
           to call cpu_mmu_index() can be compiled with the target
           (~20 small functions);
         - or, Minimize calls to env_cpu() and cpu_mmu_index(), as
           we have done, and make them non-inline so they can work
           on opaque pointers.

     For helpers (helper_ldub_mmu):
         - Either compile with the target as with non-helpers
           since these are also thin wrappers;
         - or allow helpers to only accept CPUState and
           automatically convert env -> cpu when calling
           (what you suggested)

Other ideas and approaches are ofc very welcome!:)

-- 
Anton Johansson,
rev.ng Labs Srl.


