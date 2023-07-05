Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB955748367
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 13:47:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH0y2-0001eh-OK; Wed, 05 Jul 2023 07:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=c5xU=CX=kaod.org=clg@ozlabs.org>)
 id 1qH0xv-0001e1-1p; Wed, 05 Jul 2023 07:46:40 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=c5xU=CX=kaod.org=clg@ozlabs.org>)
 id 1qH0xo-0005cJ-TD; Wed, 05 Jul 2023 07:46:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QwyYB3MYHz4wb8;
 Wed,  5 Jul 2023 21:46:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QwyY83PdHz4wZv;
 Wed,  5 Jul 2023 21:46:20 +1000 (AEST)
Message-ID: <31793f93-5996-80a7-99a1-382a9614ba56@kaod.org>
Date: Wed, 5 Jul 2023 13:46:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] pnv/xive: Print CPU target in all TIMA traces
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230705110039.231148-1-fbarrat@linux.ibm.com>
 <060f5a94-30ab-b708-5086-09332531fd81@linaro.org>
 <dfbaa810-d1b8-1873-2994-14e7be16ce46@kaod.org>
 <cf7ed8a2-8fce-7ec9-c124-dd07871de362@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <cf7ed8a2-8fce-7ec9-c124-dd07871de362@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=c5xU=CX=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.089, SPF_HELO_PASS=-0.001,
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

On 7/5/23 13:26, Philippe Mathieu-Daudé wrote:
> On 5/7/23 13:18, Cédric Le Goater wrote:
>> On 7/5/23 13:12, Philippe Mathieu-Daudé wrote:
>>> On 5/7/23 13:00, Frederic Barrat wrote:
>>>> Add the CPU target in the trace when reading/writing the TIMA
>>>> space. It was already done for other TIMA ops (notify, accept, ...),
>>>> only missing for those 2. Useful for debug and even more now that we
>>>> experiment with SMT.
>>>>
>>>> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
>>>> ---
>>>>   hw/intc/trace-events | 4 ++--
>>>>   hw/intc/xive.c       | 4 ++--
>>>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
>>>> index 5c6094c457..36ff71f947 100644
>>>> --- a/hw/intc/trace-events
>>>> +++ b/hw/intc/trace-events
>>>> @@ -265,8 +265,8 @@ xive_source_esb_read(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64
>>>>   xive_source_esb_write(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64" IRQ 0x%x val=0x%"PRIx64
>>>>   xive_router_end_notify(uint8_t end_blk, uint32_t end_idx, uint32_t end_data) "END 0x%02x/0x%04x -> enqueue 0x%08x"
>>>>   xive_router_end_escalate(uint8_t end_blk, uint32_t end_idx, uint8_t esc_blk, uint32_t esc_idx, uint32_t end_data) "END 0x%02x/0x%04x -> escalate END 0x%02x/0x%04x data 0x%08x"
>>>> -xive_tctx_tm_write(uint64_t offset, unsigned int size, uint64_t value) "@0x%"PRIx64" sz=%d val=0x%" PRIx64
>>>> -xive_tctx_tm_read(uint64_t offset, unsigned int size, uint64_t value) "@0x%"PRIx64" sz=%d val=0x%" PRIx64
>>>> +xive_tctx_tm_write(uint32_t index, uint64_t offset, unsigned int size, uint64_t value) "target=%d @0x%"PRIx64" sz=%d val=0x%" PRIx64
>>>> +xive_tctx_tm_read(uint32_t index, uint64_t offset, unsigned int size, uint64_t value) "target=%d @0x%"PRIx64" sz=%d val=0x%" PRIx64
>>>
>>> "target" is kinda confusing, what about:
>>>
>>> xive_tctx_tm_read(uint32_t cpu_index, ...) "cpu=%d @0x%"PRIx64" ...
>>
>> An interrupt 'source' is served by a 'target', a target could be a CPU,
>> a vCPU id, a group of vCPU, a process id.
>>
>> 'target' is part of the XIVE nomenclature, in HW specs, in drivers, FW,
>> Linux, KVM, and models in QEMU. It is fine.
> 
> Ah OK. Then xive_tctx_tm_read(uint32_t target, ...).

better indeed. What would be good to know also, is which vCPU is currently
dispatched on the HW thread. The info is in W2 of the ring being accessed.

Thanks,

C.


  


