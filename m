Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD3876AA46
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 09:50:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQk8Y-0005c5-Im; Tue, 01 Aug 2023 03:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qQk8V-0005bZ-T0
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 03:49:43 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qQk8S-0001To-79
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 03:49:43 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8BxpPAKuchk6vYNAA--.33060S3;
 Tue, 01 Aug 2023 15:49:31 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxfSMJuchkq7BDAA--.62761S3; 
 Tue, 01 Aug 2023 15:49:29 +0800 (CST)
Subject: Re: [PATCH 0/8] Adds CPU hot-plug support to Loongarch
To: Salil Mehta <salil.mehta@huawei.com>, Gavin Shan <gshan@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 zhukeqian <zhukeqian1@huawei.com>, Bibo Mao <maobibo@loongson.cn>
Cc: Salil Mehta <salil.mehta@opnsrc.net>
References: <cover.1689837093.git.lixianglai@loongson.cn>
 <83d5c2b6-20a2-0637-8373-c1935d97dc68@redhat.com>
 <e1c36ce7-6799-b003-9a47-b8094f869168@loongson.cn>
 <0e2212c9533f49d9ba9dc7e728b8b586@huawei.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <a47400be-bda4-c018-1b5e-0161dfb110d1@loongson.cn>
Date: Tue, 1 Aug 2023 15:49:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0e2212c9533f49d9ba9dc7e728b8b586@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxfSMJuchkq7BDAA--.62761S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWw1xGrWUKFWUAr1UtF1rXwc_yoWrurWkpF
 Wrta1a9a1kGr9Fyws2vw1qvFWxt3y8G345XF15KryFvr98Zr93trWfKa1DuF95Wr1xWr12
 vr1jvas7Z3Z8AacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
 Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
 xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
 cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
 14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjwZcUUUUU=
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.101,
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

Hi,  Salil

On 2023/7/27 pm 10:51, Salil Mehta wrote:
> Hello,
>
>> From: lixianglai <lixianglai@loongson.cn>
>> Sent: Thursday, July 27, 2023 3:14 AM
>> To: Gavin Shan <gshan@redhat.com>; qemu-devel@nongnu.org; Salil Mehta
>> <salil.mehta@huawei.com>; zhukeqian <zhukeqian1@huawei.com>; Bibo Mao
>> <maobibo@loongson.cn>
>> Subject: Re: [PATCH 0/8] Adds CPU hot-plug support to Loongarch
>>
>> Hi Gavin and Salil,
>>
>> On 7/27/23 8:57 AM, Gavin Shan wrote:
>>> Hi Xianglai,
>>>
>>> On 7/20/23 17:15, xianglai li wrote:
>>>> Hello everyone, We refer to the implementation of ARM CPU
>>>> Hot-Plug to add GED-based CPU Hot-Plug support to Loongarch.
>>>>
>>>> The first 4 patches are changes to the QEMU common code,
>>>> including adding GED support for CPU Hot-Plug, updating
>>>> the ACPI table creation process, and adding
>>>> qdev_disconnect_gpio_out_named
>>>> and cpu_address_space_destroy interfaces to release resources
>>>> when CPU un-plug.
>>>>
>>>> The last four patches are Loongarch architecture-related,
>>>> and the modifications include the definition of the hook
>>>> function related to the CPU Hot-(UN)Plug, the allocation
>>>> and release of CPU resources when CPU Hot-(UN)Plug,
>>>> the creation process of updating the ACPI table,
>>>> and finally the custom switch for the CPU Hot-Plug.
>>>>
>>> [...]
>>>
>>> It seems the design for ARM64 hotplug has been greatly referred, but the authors
>>> are missed to be copied if you were referring to the following repository. There
>>> will be conflicts between those two patchsets as I can see and I'm not sure how
>>> it can be resolved. In theory, one patchset needs to be rebased on another one
>>> since they're sharing large amount of codes.
>>>
>>>    https://github.com/salil-mehta/qemu.git
>>>    (branch: virt-cpuhp-armv8/rfc-v1-port11052023.dev-1)
>>>
>>> I took a quick scan on this series. Loongarch doesn't have ARM64's constraint due
>>> to vGIC3 where all vCPUs's file descriptor needs to be in place. It means the possible
>>> and not yet present vCPU needs to be visible to KVM. Without this constraint, the
>>> implementation is simplified a lot.
>> We have great respect and gratitude to Salil and his team for their work
>> and contributions to CPU HotPlug,
>
> Many thanks! Really appreciate this.
>
>
>> which greatly reduced the difficulty of developing CPU HotPlug in
>> Loongarch.
>
> We are glad that this work is useful to other companies as well this
> was one of our goal.
>
>
>> So, We plan to rebase the next version of patch based on their code.
>
> Great. Thanks for clarifying this as accountability is important
> even though we are working in a collaborative environment.
>
> As such, I am planning to send the RFC V2 in 2 weeks of time and
> will make sure that the patches which are required by your patch-set
> are formed in such a way that they can be independently accepted
> w.r.t rest of the ARM64 architecture specific patch-set.
>
>
>> Hi Salil,
>>
>> I estimate that it will take quite some time for your patch series to
>> merge in,
>>
>> if allowed, can you merge your patch series changes to the common code
>> section into the community first,
>>
>> so that our code can be rebase and merged.
>
> Sure, as clarified above, something similar, will create a patch-set
> which will have patches which can be independently accepted/Ack'ed
> and consumed even before the complete patch-set.
>
> Although I think, even in current form most patches have been arranged
> in such a way. But I will doubly check again before I float RFC V2.
I am sorry for the late reply.

Thanks very much,We look forward to joining the community with your 
patch series.

>
>>> Besides, we found the vCPU hotplug isn't working for TCG when Salil's
>>> series was
>>> tested. I'm not sure if we have same issue with this series, or TCG
>>> isn't a concern
>>> to us at all?
>> At present, QEMU only supports TCG under Loongarch,
>>
>> and we test CPU HotPlug is also carried out under QEMU TCG,
>>
>> and CPU HotPlug can work normally when testing.
>>
>> Of course, we are also very happy to see you testing CPU hotplug under
>> Loongarch,
>>
>> which can find more problems and help us improve our patch.
>
> We know that. There are some trivial fixes we already have, I will push
> them as well for the completion. We were not sure if anybody needs them
> as usage of vCPU Hotplug under 'accel=tcg' is highly unlikely except for
> testing cases. Please let us know if you have any?
No, we don't have it yet.
>
> Many thanks!
> Salil.
>


