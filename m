Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDAF7A1B5B
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 11:54:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh5Ws-0003g4-6y; Fri, 15 Sep 2023 05:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qh5Wh-0003bR-OG
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:54:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qh5Wd-0004D1-Sn
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:54:15 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8AxJui8KQRl2lMoAA--.18634S3;
 Fri, 15 Sep 2023 17:54:04 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Axrt66KQRlk_0GAA--.640S2; 
 Fri, 15 Sep 2023 17:54:03 +0800 (CST)
Subject: Re: [PATCH v2 04/10] Introduce the CPU address space destruction
 function
To: David Hildenbrand <david@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Salil Mehta <salil.mehta@huawei.com>
Cc: Salil Mehta <salil.mehta@opnsrc.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>
References: <cover.1694433326.git.lixianglai@loongson.cn>
 <3a4fc2a3df4b767c3c296a7da3bc15ca9c251316.1694433326.git.lixianglai@loongson.cn>
 <43f04ba4-3e16-ea5c-a212-66dda73a76c4@redhat.com>
 <20eb8316-22a2-c812-7172-6bd9016877cc@loongson.cn>
 <dd2b9190-c748-0ae2-b9de-8842e6e758e2@redhat.com>
 <7e0e1639-d821-fecb-b647-4a18afa600cc@loongson.cn>
 <e4e88068-4754-f7d4-e080-b7b8d5bcf006@loongson.cn>
 <5f610a1d-da1b-0094-41e7-f69164c4d0e0@redhat.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <3a54878a-6f1b-1dee-ddd6-49c7bbaf3558@loongson.cn>
Date: Fri, 15 Sep 2023 17:54:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5f610a1d-da1b-0094-41e7-f69164c4d0e0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Axrt66KQRlk_0GAA--.640S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxur4kKr1DCw4xCw1xCr13WrX_yoWrCw17pF
 y8Za1DKr4rJr1xAw40q3WkJryUtFy0v3W8X3srAr45CrnIgF43Zr4jkw45C3ZrXr18Gr1x
 Jr4DJFsFvrsrA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jY
 SoJUUUUU=
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


Hi David :
> On 15.09.23 04:53, lixianglai wrote:
>> Hi David Hildenbrand:
>>
>>>
>>> Hi David Hildenbrand:
>>>> On 14.09.23 15:00, lixianglai wrote:
>>>>> Hi David:
>>>>
>>>> Hi!
>>>>
>>>>>
>>>>>> On 12.09.23 04:11, xianglai li wrote:
>>>>>>> Introduce new function to destroy CPU address space resources
>>>>>>> for cpu hot-(un)plug.
>>>>>>>
>>>>>> How do other archs handle that? Or how are they able to get away
>>>>>> without destroying?
>>>>>>
>>>>> They do not remove the cpu address space, taking the X86
>>>>> architecture as
>>>>> an example:
>>>>>
>>>>> 1.Start the x86 VM:
>>>>>
>>>>> ./qemu-system-x86_64 \
>>>>> -machine q35  \
>>>>> -cpu Broadwell-IBRS \
>>>>> -smp 1,maxcpus=100,sockets=100,cores=1,threads=1 \
>>>>> -m 4G \
>>>>> -drive file=~/anolis-8.8.qcow2  \
>>>>> -serial stdio   \
>>>>> -monitor telnet:localhost:4498,server,nowait   \
>>>>> -nographic
>>>>>
>>>>> 2.Connect the qemu monitor
>>>>>
>>>>> telnet 127.0.0.1 4498
>>>>>
>>>>> info mtree
>>>>>
>>>>> address-space: cpu-memory-0
>>>>> address-space: memory
>>>>>      0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>>>>        0000000000000000-000000007fffffff (prio 0, ram): alias
>>>>> ram-below-4g
>>>>> @pc.ram 0000000000000000-000000007fffffff
>>>>>        0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>>>>>          00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
>>>>>
>>>>> 3.Perform cpu hot swap int qemu monitor
>>>>>
>>>>> device_add
>>>>> Broadwell-IBRS-x86_64-cpu,socket-id=1,core-id=0,thread-id=0,id=cpu1
>>>>> device_del cpu1
>>>>>
>>>>
>>>> Hm, doesn't seem to work for me on upstream QEMU for some reason:
>>>> "Error: acpi: device unplug request for not supported device type:
>>>> Broadwell-IBRS-x86_64-cpu"
>>>
>> First I use qemu tcg, and then the cpu needs to be removed after the
>> operating system is booted.
>
> Ah, the last thing is the important bit. I can reproduce this with KVM 
> easily.
>
> Doing it a couple of times
>
> address-space: cpu-memory-0
> address-space: cpu-memory-1
> address-space: cpu-memory-1
> address-space: cpu-memory-1
> address-space: cpu-memory-1
> address-space: cpu-memory-1
> address-space: cpu-memory-1
> address-space: cpu-memory-1
> address-space: cpu-memory-1
> address-space: cpu-memory-1
> address-space: cpu-memory-1
> address-space: cpu-memory-1
> address-space: cpu-memory-1
> address-space: cpu-memory-1
> address-space: cpu-memory-1
> address-space: cpu-memory-1
> address-space: cpu-memory-1
> address-space: cpu-memory-1
> address-space: cpu-memory-1
> address-space: cpu-memory-1
>
> Looks like a resource/memory leak.
>
> [...]
>
>>> I think it can also be done in the public code flow. Since I refer to
>>> arm's scheme
>>>
>>> (https://lore.kernel.org/all/20200613213629.21984-1-salil.mehta@huawei.com/), 
>>>
>>>
>>>
>>> and arm's patch will be issued soon, I will conduct rebase based on
>>> arm patch in the future.
>>>
>>> Therefore, I would like to see if arm has any good suggestions. If
>>> there are no good suggestions at this stage,
>>>
>>> I think we can shelve this problem for the first time, and I can
>>> consider not referencing this function for the first time,
>>>
>>> and we can submit another patch to solve this problem.
>>>
>>> Hi Salil Mehta:
>>>
>>> Is the cpu_address_space_destroy function still present in the new
>>> patch version of arm?
>>>
>>> Can we put this function on the public path of cpu destroy?
>
> Looks like this has to be fixed for all archs that support VCPU unplug.
>
> The CPU implementation end up call qemu_init_vcpu() in their realize 
> function; there should be something like qemu_destroy_vcpu() on the 
> unrealize path that takes care of undoing any cpu_address_space_init().
>
> We seem to have cpu_common_unrealizefn()->cpu_exec_unrealizefn() but 
> that doesn't take care of address spaces.
>
> Also, in qemu_init_vcpu() we do a cpus_accel->create_vcpu_thread(cpu). 
> I'm, curious if we destroy that thread somehow.
>

Although there is no visible destory of the vcpu thread, no trace of the 
thread was found when debugging through gdb,

it should be the loop in the thread ended the thread naturally exited.

Thanks,

xianglai.


