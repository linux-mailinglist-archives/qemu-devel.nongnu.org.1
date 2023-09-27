Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7D97AF80F
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 04:17:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlK6e-00009i-EQ; Tue, 26 Sep 2023 22:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qlK6b-00009W-F3
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 22:16:49 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qlK6Y-0006S2-9l
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 22:16:49 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8AxJuiJkBNl0xEtAA--.27353S3;
 Wed, 27 Sep 2023 10:16:41 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dx3t6DkBNlyooTAA--.2191S2; 
 Wed, 27 Sep 2023 10:16:37 +0800 (CST)
Subject: Re: [PATCH v2 04/10] Introduce the CPU address space destruction
 function
To: Salil Mehta <salil.mehta@huawei.com>, David Hildenbrand
 <david@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Salil Mehta <salil.mehta@opnsrc.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Bibo Mao <maobibo@loongson.cn>
References: <cover.1694433326.git.lixianglai@loongson.cn>
 <3a4fc2a3df4b767c3c296a7da3bc15ca9c251316.1694433326.git.lixianglai@loongson.cn>
 <43f04ba4-3e16-ea5c-a212-66dda73a76c4@redhat.com>
 <20eb8316-22a2-c812-7172-6bd9016877cc@loongson.cn>
 <dd2b9190-c748-0ae2-b9de-8842e6e758e2@redhat.com>
 <7e0e1639-d821-fecb-b647-4a18afa600cc@loongson.cn>
 <e4e88068-4754-f7d4-e080-b7b8d5bcf006@loongson.cn>
 <5f610a1d-da1b-0094-41e7-f69164c4d0e0@redhat.com>
 <7906109a36c5467fa9b529520671fa77@huawei.com>
 <b8f256b3549e41a09119dee5ab5439d9@huawei.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <24c47505-9fb8-60cf-eabe-7cae7954e087@loongson.cn>
Date: Wed, 27 Sep 2023 10:16:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b8f256b3549e41a09119dee5ab5439d9@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Dx3t6DkBNlyooTAA--.2191S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3WF1rAF4ktw4rAr4kKF13Jrc_yoW7Aw1Upa
 4fAanrKr4xJr1UAr4qqF1kJFyUtry8uay8X3s7Ar18CrnF9r43Zr4j9w1UCF98Xw4xGF17
 Ar1qqrZIqa13AagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67
 AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIY
 rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
 v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
 JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOa93UUU
 UU=
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
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


Hi Salil Mehta:
>> From: Salil Mehta
>> Sent: Tuesday, September 26, 2023 12:21 PM
>> To: 'David Hildenbrand' <david@redhat.com>; lixianglai
>> <lixianglai@loongson.cn>; qemu-devel@nongnu.org
>> Cc: Salil Mehta <salil.mehta@opnsrc.net>; Xiaojuan Yang
>> <yangxiaojuan@loongson.cn>; Song Gao <gaosong@loongson.cn>; Michael S.
>> Tsirkin <mst@redhat.com>; Igor Mammedov <imammedo@redhat.com>; Ani Sinha
>> <anisinha@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Richard
>> Henderson <richard.henderson@linaro.org>; Eduardo Habkost
>> <eduardo@habkost.net>; Marcel Apfelbaum <marcel.apfelbaum@gmail.com>;
>> Philippe Mathieu-Daudé <philmd@linaro.org>; wangyanan (Y)
>> <wangyanan55@huawei.com>; Daniel P. Berrangé <berrange@redhat.com>; Peter
>> Xu <peterx@redhat.com>; Bibo Mao <maobibo@loongson.cn>
>> Subject: RE: [PATCH v2 04/10] Introduce the CPU address space destruction
>> function
>>
>> Hi David,
>>
>>> From: David Hildenbrand <david@redhat.com>
>>> Sent: Friday, September 15, 2023 9:07 AM
>>> To: lixianglai <lixianglai@loongson.cn>; qemu-devel@nongnu.org; Salil
>> Mehta
>>> <salil.mehta@huawei.com>
>>> Cc: Salil Mehta <salil.mehta@opnsrc.net>; Xiaojuan Yang
>>> <yangxiaojuan@loongson.cn>; Song Gao <gaosong@loongson.cn>; Michael S.
>>> Tsirkin <mst@redhat.com>; Igor Mammedov <imammedo@redhat.com>; Ani Sinha
>>> <anisinha@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Richard
>>> Henderson <richard.henderson@linaro.org>; Eduardo Habkost
>>> <eduardo@habkost.net>; Marcel Apfelbaum <marcel.apfelbaum@gmail.com>;
>>> Philippe Mathieu-Daudé <philmd@linaro.org>; wangyanan (Y)
>>> <wangyanan55@huawei.com>; Daniel P. Berrangé <berrange@redhat.com>; Peter
>>> Xu <peterx@redhat.com>; Bibo Mao <maobibo@loongson.cn>
>>> Subject: Re: [PATCH v2 04/10] Introduce the CPU address space destruction
>>> function
>>>
>>> On 15.09.23 04:53, lixianglai wrote:
>>>> Hi David Hildenbrand:
>>>>
>>>>> Hi David Hildenbrand:
>>>>>> On 14.09.23 15:00, lixianglai wrote:
>>>>>>> Hi David:
>>>>>> Hi!
>>>>>>
>>>>>>>> On 12.09.23 04:11, xianglai li wrote:
>>>>>>>>> Introduce new function to destroy CPU address space resources
>>>>>>>>> for cpu hot-(un)plug.
>>>>>>>>>
>>>>>>>> How do other archs handle that? Or how are they able to get away
>>>>>>>> without destroying?
>>>>>>>>
>>>>>>> They do not remove the cpu address space, taking the X86
>>>>>>> architecture as
>>>>>>> an example:
>>>>>>>
>>>>>>> 1.Start the x86 VM:
>>>>>>>
>>>>>>> ./qemu-system-x86_64 \
>>>>>>> -machine q35  \
>>>>>>> -cpu Broadwell-IBRS \
>>>>>>> -smp 1,maxcpus=100,sockets=100,cores=1,threads=1 \
>>>>>>> -m 4G \
>>>>>>> -drive file=~/anolis-8.8.qcow2  \
>>>>>>> -serial stdio   \
>>>>>>> -monitor telnet:localhost:4498,server,nowait   \
>>>>>>> -nographic
>>>>>>>
>>>>>>> 2.Connect the qemu monitor
>>>>>>>
>>>>>>> telnet 127.0.0.1 4498
>>>>>>>
>>>>>>> info mtree
>>>>>>>
>>>>>>> address-space: cpu-memory-0
>>>>>>> address-space: memory
>>>>>>>       0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>>>>>>         0000000000000000-000000007fffffff (prio 0, ram): alias
>>>>>>> ram-below-4g
>>>>>>> @pc.ram 0000000000000000-000000007fffffff
>>>>>>>         0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>>>>>>>           00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
>>>>>>>
>>>>>>> 3.Perform cpu hot swap int qemu monitor
>>>>>>>
>>>>>>> device_add
>>>>>>> Broadwell-IBRS-x86_64-cpu,socket-id=1,core-id=0,thread-id=0,id=cpu1
>>>>>>> device_del cpu1
>>>>>>>
>>>>>> Hm, doesn't seem to work for me on upstream QEMU for some reason:
>>>>>> "Error: acpi: device unplug request for not supported device type:
>>>>>> Broadwell-IBRS-x86_64-cpu"
>>>> First I use qemu tcg, and then the cpu needs to be removed after the
>>>> operating system is booted.
>>> Ah, the last thing is the important bit. I can reproduce this with KVM
>>> easily.
>>>
>>> Doing it a couple of times
>>>
>>> address-space: cpu-memory-0
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>> address-space: cpu-memory-1
>>>
>>> Looks like a resource/memory leak.
>> Yes, there was. Thanks for identifying it. I have fixed in the
>> latest RFC V2. Please check here:
>>
>> https://lore.kernel.org/qemu-devel/20230926100436.28284-1-
>> salil.mehta@huawei.com/T/#m5f5ae40b091d69d01012880d7500d96874a9d39c
>>
>> I have tested and AddressSpace comes and goes away cleanly
>> on CPU hot(un)plug action.
> Hi David/Xianglai,
> Are you okay if I put Reported-by and give reference to this
> conversation?

That's Ok for me.

Thanks,

Xianglai.


> Many thanks
> Salil
>
>


