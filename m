Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FC4B278A5
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Aug 2025 07:51:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umnKP-0006Y9-Po; Fri, 15 Aug 2025 01:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1umnKJ-0006Xf-DH; Fri, 15 Aug 2025 01:50:07 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1umnKD-0006Jg-57; Fri, 15 Aug 2025 01:50:07 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBXXj57yp5oezi9Bg--.1034S2;
 Fri, 15 Aug 2025 13:49:47 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwC3Pwdjyp5oqVATAA--.24706S2;
 Fri, 15 Aug 2025 13:49:39 +0800 (CST)
Message-ID: <75da1d95-df58-4f85-b668-7bdfb0ecf743@phytium.com.cn>
Date: Fri, 15 Aug 2025 13:49:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/11] hw/arm/smmuv3: Add initial support for Secure State
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>, smostafa@google.com,
 jean-philippe@linaro.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <d4fcf3a2-6789-4926-882e-1abac4c07843@linaro.org>
 <2169e4b1-97d1-43c9-a512-5e6e25a562ad@phytium.com.cn>
 <8b5cbf44-02a1-45f0-8a59-3cb7b762ad0a@linaro.org>
Content-Language: en-US
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <8b5cbf44-02a1-45f0-8a59-3cb7b762ad0a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwC3Pwdjyp5oqVATAA--.24706S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQADBWieOgABnAAEsS
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Jw4kGFW7AryDWw43GFWfKrg_yoWxXw4UpF
 W3Ka47KF4DJF1UAw12qw48ZF1ak395Cr43Grn8Gwn5C3s0kr97tF1UtFyF9F97WrZ7Xa4j
 vFWjvrWxXr4DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 2025/8/13 02:04, Pierrick Bouvier wrote:
> On 8/10/25 9:11 AM, Tao Tang wrote:
>>
>> On 2025/8/7 05:28, Pierrick Bouvier wrote:
>>> On 8/6/25 8:11 AM, Tao Tang wrote:
>>>> Hi all,
>>>>
>>>> This patch series introduces initial support for emulating the Arm
>>>> SMMUv3
>>>> Secure State.
>>>> ------------------------------<snip>------------------------------
>>>>
>>>>
>>>> ------------------------------<snip>------------------------------
>>>> Secure Register/Command Interface: I set up an OP-TEE + Hafnium
>>>> environment. Hafnium's smmuv3_driver_init function was used to test
>>>> the secure register I/O and command queue functionality (excluding
>>>> translation). As Hafnium assumes larger queue and StreamID sizes than
>>>> are practical without TTST support, I temporarily patched Hafnium to
>>>> use smaller values, allowing its driver to initialize the emulated
>>>> secure SMMU successfully.
>>>>
>>>
>>> Would that be possible to share your changes, and build instructions
>>> for this? While working on SMMU emulation, we finally left this on the
>>> side due to lack of a software stack being able to use secure SMMU, as
>>> we were not aware that Hafnium + op-tee could make use of it.
>>>
>> Hi Pierrick,
>>
>> Thanks for your interest! I'm very happy to share my work on this. I've
>> documented the setup process, including our code modifications and the
>> step-by-step build instructions in  this link:
>>
>> https://hnusdr.github.io/2025/08/09/Test-Secure-SMMU-with-Hafnium-ENG
>>
>
> Thanks for taking the time to assemble all this in a comprehensible 
> post, I'll give it a try when I have some spare time.

Hi Pierrick,

You're welcome, and please feel free to let me know if you run into any 
issues.


>
>>
>> The core point of these changes is to enable the SMMUv3 feature in
>> Hafnium. This leads to numerous read/write operations on SMMUv3 secure
>> registers and various queue manipulations within the smmuv3_driver_init
>> function in Hafnium.
>>
>> However, it's important to note that this initialization process itself
>> does not initiate any DMA memory access that would trigger the
>> smmuv3_translate flow.
>>
>
> I understand the difference. It can be tricky to generate specific 
> translation scenarios, which is where a custom test device can really 
> help.
>
>> Even so, we've devised a method to test the subsequent Secure
>> Translation Path by leveraging the smmuv3-test platform device. This
>> approach allows us to verify the entire SMMUv3 flow, from initialization
>> to translation.
>>
>
> Does it rely on a custom driver integration into an existing firmware 
> or the kernel?
>
>>
>>>> Secure Translation Path: Since the TF-A SMMUv3 Test Engine does not
>>>> support QEMU, and no secure device assignment feature exists yet, I
>>>> created a custom platform device to test the secure translation flow.
>>>> To trigger the translation logic, I initiated MMIO writes to this
>>>> device from within Hafnium. The device's MMIO callback handler then
>>>> performed DMA accesses via its IOMMU region, exercising the secure
>>>> translation path. While SMMUv3 is typically used for PCIe on
>>>> physical SoCs, the architecture allows its use with platform devices
>>>> via a stream-id binding in the device tree. The test harness
>>>> required some non-standard modifications to decouple the SMMU from
>>>> its tight integration with PCIe. The code for this test device is
>>>> available for review at [3]. README.md with detailed instructions is
>>>> also provided.
>>>>
>>>
>>> I am not sure about the current policy in QEMU for test oriented
>>> devices, but it would be really useful to have something similar
>>> upstream (Note: it's out of the scope of this series).
>>> One challenge working with SMMU emulation is that reproducing setups
>>> and triggering specific code paths is hard to achieve, due to the
>>> indirect use of SMMU feature (through DMA) and the complex software
>>> stack usually involved.
>>> Having something upstream available to work on SMMU emulation, at
>>> least on device side, would be a great addition.
>>>
>>> Eric, Peter, is this something that would be acceptable to merge?
>>>
>>
>> Looking ahead, my plan is to refactor the smmuv3-test platform device.
>> The goal is to make it self-contained within QEMU, removing the current
>> dependency on Hafnium to trigger its operations. I plan to submit this
>> as a separate RFC patch series in the next few days.
>>
>
> This is very welcome. Once this is in place, it would be great to add 
> a new test to make sure things don't regress, and from where we can 
> iterate.
> By self-contained within QEMU, do you mean a QTest based test?
>
> Regards,
> Pierrick


Thanks for the follow-up and the great questions.

To answer your question about the custom test driver: yes, the current 
implementation of the smmuv3-test device relies on integration with 
Hafnium to be triggered.

The test flow is initiated when Hafnium performs an mmio_write32 to the 
smmuv3-test device's MMIO space. This triggers the device's read/write 
callback in QEMU. Inside this callback, I use address_space_write/read 
to first populate the necessary SMMU structures (STEs, CDs, PTEs) in 
guest secure memory, and then perform another address_space_write/read 
to an IOMMU-protected region of smmuv3-test. It is this final access 
that exercises the full secure translation path. So for now, it is 
indeed dependent on the Hafnium firmware for debugging.

That brings me to your next point about making the test 
"self-contained". My goal is exactly to remove this dependency. I'm 
currently exploring ways to achieve this within QEMU—for instance, by 
using QMP commands or another monitor interface to replace the 
mmio_write32 action that Hafnium currently provides. This is what I 
meant by "self-contained": allowing us to test the entire SMMUv3 
translation flow relying only on the QEMU emulator itself, without any 
specific guest firmware or kernel.

This leads perfectly to your question about QTest. I'm not very familiar 
with it, so your suggestion is very helpful. Is QTest the standard or 
required framework for implementing this kind of self-contained test 
device? I would appreciate any guidance or pointers you could provide on 
this topic.

Thanks again for the valuable discussion.

Best regards,

Tao


