Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CEEB29176
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Aug 2025 05:48:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unUMD-00060C-73; Sat, 16 Aug 2025 23:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1unUMA-000600-66; Sat, 16 Aug 2025 23:46:54 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1unUM6-0006jz-1W; Sat, 16 Aug 2025 23:46:53 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBnblKZUKFoonVCBg--.44882S2;
 Sun, 17 Aug 2025 11:46:33 +0800 (CST)
Received: from [192.168.31.34] (unknown [113.246.232.52])
 by mail (Coremail) with SMTP id AQAAfwCnMAiMUKFoHl8WAA--.4273S2;
 Sun, 17 Aug 2025 11:46:30 +0800 (CST)
Message-ID: <99286e4b-7964-4e8a-858c-60b5776e40cd@phytium.com.cn>
Date: Sun, 17 Aug 2025 11:46:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 04/11] hw/arm/smmuv3: Enable command processing for the
 Secure state
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Chen Baozi <chenbaozi@phytium.com.cn>, smostafa@google.com,
 jean-philippe@linaro.org
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-5-tangtao1634@phytium.com.cn>
 <0b38d386-9d8b-46bd-a981-718cc7281eb6@linaro.org>
 <f74b4d64-893f-4b39-aa95-4e9ff52edebd@phytium.com.cn>
 <4ff26d30-3b0d-4392-8bac-698ecb0fbdde@linaro.org>
 <CAFEAcA-imgF9NLPWeXfE1JRL0gaKpVyfbbNKxojHDVz0t7EBKw@mail.gmail.com>
 <0c95f7de-ffbe-4787-ae14-6039bc4f31a3@phytium.com.cn>
 <CAFEAcA9MUhRX7yVx23Aw3FRPAnxNn1PifSjR3hJ2eK8KwFvXJw@mail.gmail.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <CAFEAcA9MUhRX7yVx23Aw3FRPAnxNn1PifSjR3hJ2eK8KwFvXJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAfwCnMAiMUKFoHl8WAA--.4273S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQADBWieOgALvwAEs7
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxGF1fJFy7Aw47XF4fuw1kAFb_yoWrCFWUpF
 Z8uwn5Kr4DKF1akr1xXa18JF48A3yfJFy5Cr95Kwn8Aa1Ygw1vvFWjy3yY9F17Zw40q3W0
 vF40vrn8Xan8ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 2025/8/15 22:53, Peter Maydell wrote:
> On Fri, 15 Aug 2025 at 07:02, Tao Tang <tangtao1634@phytium.com.cn> wrote:
>> This leads me to two questions on the best path forward:
>>
>> 1. How should the SEC_SID be propagated from the device? The only thing
>> that is certain is that the hardware transaction will carry a SEC_SID
>> value that is consistent with the manual. My initial thought was to
>> extend MemTxAttrs.secure to carry the four states, but I am unsure if
>> this is the best approach.
>>
> The SEC_SID is the information in the transaction that tells
> us whether the device that initiated the transaction is
> NonSecure, Secure, or Realm, right? I think we can
> straightforwardly use 'space' for this. (The mapping between
> SEC_SID and space can be written "space = sec_sid ^ 1" but
> that is perhaps being unnecessarily clever.)
>
> "secure" is (as the comment notes) for the benefit of code
> that doesn't understand Realm. It should be initialized to
> arm_space_is_secure(space). (Currently that function is in
> target/arm/cpu.h, which is an awkward place for it: we
> should probably move it to somewhere that lets code that's
> not tied to the CPU use it.)
>
>> To accurately model the SMMU, our smmuv3_translate function must
>> ultimately use this SEC_SID value. Taking the translate callback
>> signature into consideration:
>>
>> IOMMUTLBEntry (*translate)(IOMMUMemoryRegion *iommu, hwaddr addr,
>>                              IOMMUAccessFlags flags, int iommu_idx);
>>
>> My understanding is that we can use the iommu_idx parameter to carry the
>> SEC_SID value for each transaction.
> Yes. You also will need to implement the attrs_to_index method,
> which is what converts from the attrs in the MemTxAttrs to
> the iommu_idx that the translate method gets passed.
>
> (We do actually have hw/misc/tz-mpc.c that uses the IOMMU
> APIs to handle Secure vs NonSecure transactions differently,
> though it's such a long way from a real SMMU that I don't
> know that it's a very useful thing to look at.)
>
>> 2. What should we use as the internal bank index within the SMMUv3
>> model? I see two potential options:
>> a) Use the existing ARMSecuritySpace as the internal index. This would
>> require conversions from the SEC_SID carried by each transaction.
>> b) Define a new, SMMU-specific enum that perfectly matches the SEC_SID
>> hardware specification (e.g., enum SmmuSecSid { NS=0, S=1, REALM=2,
>> ROOT=3 }). We would use this new enum as our bank index internally.
>>
>> I am leaning towards option (2b) as it seems to offer better
>> encapsulation and fidelity to the hardware specification, but I would be
>> very grateful to hear your opinions and guidance on this architectural
>> choice.
> Yes, I like 2b here. This is what I am doing for the GICv5 --
> there the architecture specifies various "interrupt domains",
> and there's an obvious encoding from those to 0..3, which is
> what I use to pick the register bank to use. The MemTxAttrs
> don't quite line up with the domain index, and they are something
> we need to figure out less often than "which register bank", so
> it's OK for that to be something we do via a function or
> whatever.
>
> For the GICv5 in fact I have opted to create the MemTxAttrs
> ahead of time at the point where the guest enables things
> and we know what they should be (roughly, the device state
> caches various bits of info about the configured state
> in a struct, and one of those fields is a MemTxAttrs; so
> you can pass cfg[domain]->txattrs as your attrs rather than
> computing it on the spot every time -- especially since you
> need to initialize both .space and .secure this seemed
> nicer to me).
>
> thanks
> -- PMM

Hi Peter,

Thanks for the very clear and actionable feedback.

I will refactor the code in V2 according to the plan you laid out. The 
approach will be to use MemTxAttrs.space to carry the security state, 
and I will be sure to set the legacy .secure field correctly for 
compatibility as you pointed out. This will then be converted via the 
attrs_to_index method, leading to the use of a new spec-compliant enum 
for the internal bank index (your preferred option 2b).

Your GICv5 analogy was very helpful for clarifying the design, and I'll 
keep the MemTxAttrs caching tip in mind as an optimization method.

Thanks again for the excellent guidance.

Best regards,

Tao



