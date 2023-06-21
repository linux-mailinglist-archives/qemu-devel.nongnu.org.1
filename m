Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C828573859F
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 15:48:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByBX-00080j-Ji; Wed, 21 Jun 2023 09:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qByBR-0007wf-Ik
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:47:42 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qByBN-0000mP-ET
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:References:To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N6EDZ5traJZHrOvCR/Ulph58VuUbOT+TYgJIPgQKBk0=; b=oBYd3atR3vSP0m+u8U4B/mKVQ0
 io2gE6rIWcymnngjfBlZMg6zDNmtJBj6DCFwv9lg8OgWoqYY5KDPv4XJRsCD/s56lmeNY0ID2nwjx
 JMrLofX9PFG27sIbloKhUBQgOGZsK6HbQYhLhfstH4GHZ3KFuSWP9MscROz0WOASqMy1OlWOgwSDJ
 udzZCfkLmRiAOqonmDROXCPDlUsDPLn4UKcJalPf55lEKwLDcPeWGg+486jVCX98r5sPO2k0xge7k
 ZpQbKeELfWkmI7H2++mHLsToJZN3rzc0BpdAsCkerVCLQstBXRMuoiB8jcUjbmKVoRm7VdiiUCwvd
 8AQ5jGxnrIT/mf+1Xu+lPUHQ7rQmhhJbEAaWijmBoipn6u0kRyCldHme6uInwLLST5n3HaIUOrOfO
 DN3TlxISgtMTnuJeGqmGkTezlqpJc7LGTR2E5qh+nX650qnSpvQPUaI1lDhkAtBCFj4MQ+QdYVtRV
 AOp0C32/tHZHp8UsrLTooDsJ6fjDRRZSe0B0paHDHcXm/dILn2zhXGeKROeqwoKOO9zGXHkWthgsk
 euTlAjTCK+fnN2ncVbUV+qEEl9JPYfGczAjhSrr5BEp9DATIIj/2SVFT4p2dYd05k6/u1UOr4lNNZ
 1tA3rMPzit3FAnQNmdIdDGWPYBYmwPaxINAzKSZPU=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qByBE-00038g-4T; Wed, 21 Jun 2023 14:47:28 +0100
Message-ID: <e4c9cd2d-7992-5506-1c10-638e97a66f0e@ilande.co.uk>
Date: Wed, 21 Jun 2023 14:47:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230405185922.2122668-1-richard.henderson@linaro.org>
 <2d46a274-8234-a635-81ca-c79c2969cb7b@linaro.org>
 <fc35257d-8af0-8aa1-af88-982c7506bfa5@ilande.co.uk>
 <a5c261f4-b3e5-314f-b28f-dfac54a0bed8@linaro.org>
 <f7d45693-78db-261b-f016-c198a7c98d97@linaro.org>
 <0489cb19-8d5e-7cdd-4c98-12fea8afa0d1@ilande.co.uk>
In-Reply-To: <0489cb19-8d5e-7cdd-4c98-12fea8afa0d1@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH for-8.1] target/sparc: Use tcg_gen_lookup_and_goto_ptr
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 21/06/2023 10:14, Mark Cave-Ayland wrote:

> On 19/06/2023 16:41, Richard Henderson wrote:
> 
>> On 5/11/23 13:02, Richard Henderson wrote:
>>> On 5/11/23 09:40, Mark Cave-Ayland wrote:
>>>> Obviously nothing notionally against this patch, however if you could give me a 
>>>> few days to run my OpenBIOS SPARC32/SPARC64 boot tests against git master with 
>>>> this patch applied to double-check there are no regressions, that would be great.
>>>
>>> No problem.  I just didn't want it to get lost.
>>
>> Ping for results?
>>
>> r~
> 
> Sorry I haven't had a chance to test this yet - I'll try and get to it later today.

I got as far as running my OpenBIOS sparc32 tests, and I'm seeing an issue with my 
Solaris 8 image in that the mouse is frozen when booting into the GUI with this patch 
applied so looks like something still isn't right here :(


ATB,

Mark.


