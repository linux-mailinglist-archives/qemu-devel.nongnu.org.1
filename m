Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A255B77298E
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 17:44:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT2Oi-0001oh-AY; Mon, 07 Aug 2023 11:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qT2Od-0001nZ-PF
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:43:52 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qT2Ob-0007jU-LF
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:43:51 -0400
Received: from [172.20.10.3] (unknown [112.97.81.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 047B043AF2;
 Mon,  7 Aug 2023 15:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691423026; bh=KHv5EELhIXEFl00D+IeC8B+LRGveoATRl6y24nH3Kic=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=MCnRGE46uHxdL+QLxxxgWvONGhCi+QTGqHkxr3pHXKWZ1+767SWn6PeCCL6hp3i9+
 hph1Mq8Y74rfKI9VUxlm38YT6Q4KWUKnqezScLanYr5hmN0IdbCtFS38gUR2WMCBzP
 j1hP5gfaAg1RFf4CbL8Ytx31HZm6GLnYuw1vth0E=
Message-ID: <f9dc0f47-ab22-0227-7ecb-ba7530609888@jia.je>
Date: Mon, 7 Aug 2023 23:43:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 0/6] Add loongarch32 mode for loongarch64-softmmu
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230807094505.2030603-1-c@jia.je>
 <29e320c8-b95b-2188-a250-0eb5a19708da@linaro.org>
From: Jiajie Chen <c@jia.je>
In-Reply-To: <29e320c8-b95b-2188-a250-0eb5a19708da@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 2023/8/7 23:40, Richard Henderson wrote:
> On 8/7/23 02:44, Jiajie Chen wrote:
>> This patch series allow qemu-system-loongarch64 to emulate a LoongArch32
>> machine. A mode enum is added to CPUArchState to select LA32 or LA64 at
>> runtime. A new CPU model is added for loongarch32. Initial GDB support
>> is added.
>>
>> Changes since v2:
>>
>> - Fix typo in previous commit
>> - Fix VPPN width in TLBEHI/TLBREHI
>>
>> Changes since v1:
>>
>> - No longer create a separate qemu-system-loongarch32 executable, but
>>    allow user to run loongarch32 emulation using qemu-system-loongarch64
>> - Add loongarch32 cpu support for virt machine
>>
>> Full changes:
>>
>> Jiajie Chen (6):
>>    target/loongarch: Add loongarch32 mode for loongarch64-softmmu
>>    target/loongarch: Add loongarch32 cpu la132
>>    target/loongarch: Add GDB support for loongarch32 mode
>>    target/loongarch: Support LoongArch32 TLB entry
>>    target/loongarch: Support LoongArch32 DMW
>>    target/loongarch: Support LoongArch32 VPPN
>
> There are changes missing for the translator.
>
> All of the doubleword (D) instructions must be rejected in LA32 mode.
I was trying to do this, but I failed to figure out how to read the 
current cpucfg when translating instructions to TCP ops. This problem 
applies to the mode-specific behavior below: VA32L1, BL, JIRL, PCADD*, 
PWCH etc.
>
> Virtual addresses must be zero-extended from 32 bits in 32-bit 
> addressing mode.
It is done in the TLB change.
>
> I see a note about VA32L1/VA32L2/VA32L3 in CSR.MISC enabling 32-bit 
> address mode for LA64.  You would want to implement this with a 
> HW_FLAGS bit which indicates to the translator whether 32-bit 
> addressing is enabled in the current mode.  This would always be true 
> for LA32, and from MISC for the current priv level for LA64.
>
> There are changes to BL, JIRL and PCADD* to sign-extend in 32-bit 
> address mode.
>
> What happened to the PWCH adjustment from v1?
>
>
> r~

