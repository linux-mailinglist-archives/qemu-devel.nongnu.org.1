Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 873987EB5E6
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 18:57:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2xeW-0003bT-Ml; Tue, 14 Nov 2023 12:56:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1r2xeQ-0003Uh-80; Tue, 14 Nov 2023 12:56:39 -0500
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1r2xeO-0008CI-1b; Tue, 14 Nov 2023 12:56:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lWFmJaXdNb1cvdOqSWYWj5lK+WjOKKjQscIAYFDHkGk=; b=s7BLtcsUn11XePqDDdrVw1L0j8
 ZQTFqOTdTxcm1EKu63Dvm7PK+qviOdU71NVzyRuWHBmJV2LUCiqNUKDuBBuS4uQrUyL2nq/GflXpA
 EvK8i1P6L4sGgYGiLIYqinfHHBrBJad/AZdU6D5ea7vvdq2e2KDgswKw4U14ftjBLtVxG78zUQgkl
 u1LXKwoclK3j0dk6zpVntJ4xpJDY+KfPjq1LCW+UGvDtZ0t1IieoJCq0xLELRbg1eYWQxBVJPtlbw
 gXTb3r1ZyElyXdTPdMVw7mfXxPT9ciqWOsbzS+UFiPiS/q01k4XEwp3p3zXbbFYqPqf053Ca+PfdC
 FXfMM8Bw==;
Received: from [167.98.27.226] (helo=[10.35.4.236])
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1r2x8I-001oh5-U3; Tue, 14 Nov 2023 17:23:27 +0000
Message-ID: <78989536-e29c-4ce1-a972-36be6c70349c@codethink.co.uk>
Date: Tue, 14 Nov 2023 17:23:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/arm_gicv3: ICC_PMR_EL1 high bits should be RAZ
Content-Language: en-GB
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20231114165404.681826-1-ben.dooks@codethink.co.uk>
 <CAFEAcA-MG+ak8+xVyqgpWqmKAryOXJtOckUmA=GysQwnpuz5SQ@mail.gmail.com>
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <CAFEAcA-MG+ak8+xVyqgpWqmKAryOXJtOckUmA=GysQwnpuz5SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=188.40.203.114;
 envelope-from=ben.dooks@codethink.co.uk; helo=imap4.hz.codethink.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 14/11/2023 17:14, Peter Maydell wrote:
> On Tue, 14 Nov 2023 at 16:54, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>
>> The ICC_PMR_ELx bit msak returned from icc_fullprio_mask
>> should technically also remove any bit above 7 as these
>> are marked reserved (read 0) and should therefore should
>> not be written as anything other than 0.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>>   hw/intc/arm_gicv3_cpuif.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
>> index d07b13eb27..986044df79 100644
>> --- a/hw/intc/arm_gicv3_cpuif.c
>> +++ b/hw/intc/arm_gicv3_cpuif.c
>> @@ -803,7 +803,7 @@ static uint32_t icc_fullprio_mask(GICv3CPUState *cs)
>>        * with the group priority, whose mask depends on the value of BPR
>>        * for the interrupt group.)
>>        */
>> -    return ~0U << (8 - cs->pribits);
>> +    return (~0U << (8 - cs->pribits)) & 0xff;
>>   }
> 
> The upper bits of ICC_PMR_ELx are defined as RES0, which has a
> complicated technical definition which you can find in the GIC
> architecture specification glossary. It's valid for RES0 bits to
> be implemented as reads-as-written, which is the way our current
> implementation works. Valid guest code should never be writing
> any non-zero value into those bits.

Yeah, got some proprietary test code that is trying write-1 and
then assuming read-0.

> What problem are you running into that you're trying to fix
> with this patch? If our implementation misbehaves as a result
> of letting these high bits through into cs->icc_pmr_el1 that
> would be a good reason for making the change.

See above, local test code issue.

  > If we do want to change this, for consistency we'd want
> to change icv_fullprio_mask() too.

If this isn't useful then I'll keep it as a local patch for now.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html


