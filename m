Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA28B79DED1
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 05:53:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgGvf-0004CL-TR; Tue, 12 Sep 2023 23:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qgGvZ-0004BP-Sy
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 23:52:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qgGvQ-00016n-4y
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 23:52:33 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8CxbevnMQFlbDImAA--.6332S3;
 Wed, 13 Sep 2023 11:52:07 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxvt7hMQFlkhQCAA--.293S2; 
 Wed, 13 Sep 2023 11:52:01 +0800 (CST)
Subject: Re: [PATCH v2 00/10] Adds CPU hot-plug support to Loongarch
To: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
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
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>
References: <cover.1694433326.git.lixianglai@loongson.cn>
 <823e8dbc2db64190ac75b6b0ffa7c003@huawei.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <7c026919-9eff-65fe-0a7a-2c00867b15a2@loongson.cn>
Date: Wed, 13 Sep 2023 11:52:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <823e8dbc2db64190ac75b6b0ffa7c003@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bxvt7hMQFlkhQCAA--.293S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3WF18KFyUJF1fuFyxZFyruFX_yoWxWF43pa
 y8CF1Ykr95JrWUC3WxX3s2vr9rX3ykGa9rXFnxtryvkryDZw17Ar40qas8ZFyUZa1fWFyx
 Zr1Yg3Z7W3W5JFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
 xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
 Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
 xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
 I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrV
 AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCI
 c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
 AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
 Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUc9a9UU
 UUU
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


Hi, Salil Mehta :
> Hi Xianglai,
>
>> From: qemu-devel-bounces+salil.mehta=huawei.com@nongnu.org <qemu-devel-
>> bounces+salil.mehta=huawei.com@nongnu.org> On Behalf Of xianglai li
>> Sent: Tuesday, September 12, 2023 3:12 AM
>> To: qemu-devel@nongnu.org
>> Cc: Salil Mehta <salil.mehta@opnsrc.net>; Xiaojuan Yang
>> <yangxiaojuan@loongson.cn>; Song Gao <gaosong@loongson.cn>; Michael S.
>> Tsirkin <mst@redhat.com>; Igor Mammedov <imammedo@redhat.com>; Ani Sinha
>> <anisinha@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Richard
>> Henderson <richard.henderson@linaro.org>; Eduardo Habkost
>> <eduardo@habkost.net>; Marcel Apfelbaum <marcel.apfelbaum@gmail.com>;
>> Philippe Mathieu-Daudé <philmd@linaro.org>; wangyanan (Y)
>> <wangyanan55@huawei.com>; Daniel P. Berrangé <berrange@redhat.com>; Peter
>> Xu <peterx@redhat.com>; David Hildenbrand <david@redhat.com>; Bibo Mao
>> <maobibo@loongson.cn>; Xianglai li <lixianglai@loongson.cn>
>> Subject: [PATCH v2 00/10] Adds CPU hot-plug support to Loongarch
>>
>> Hello everyone, We refer to the implementation of ARM CPU
>> Hot-Plug to add GED-based CPU Hot-Plug support to Loongarch.
>>
>> The first 4 patches are changes to the QEMU common code,
>> including adding GED support for CPU Hot-Plug, updating
>> the ACPI table creation process, and adding qdev_disconnect_gpio_out_named
>> and cpu_address_space_destroy interfaces to release resources
>> when CPU un-plug.
>>
>> For the modification of the public part of the code, we refer to the
>> arm-related patch, and the link address of the corresponding patch is
>> as follows:
>> https://lore.kernel.org/all/20200613213629.21984-1-salil.mehta@huawei.com/
>>
>> In order to respect the work of "Salil Mehta", we will rebase the first
>> 4 patches in the final patch, which are referenced here to ensure that
>> the loongarch cpu hotplug can work properly.
>
> Just to let you know RFC V2 for above link is undergoing internal review
> process and I will be posting the patches to community soon.
>
> Also, I am planning to post RFC V2 as one complete patch-set initially.
> (This is required to reflect the clear change from RFC V1)
> This will have patches which are ARM specific and architecture common.
> Later patches can be cherry picked and compiled independently.
>
> After RFC V2 has been posted, and you have confirmed that architecture
> common patches works well with your changes, I will split the RFC V2
> further into 2 patch-sets,
> 1. Architecture common patch-set (This will come with no RFC)
> 2. ARM specific patch-set  (This will continue as RFC V3)
>
> This will help patch-set 1 getting absorbed earlier in this Qemu
> cycle if everything goes well.
>
>
> Thanks
> Salil.
>
That's great,Looking forward to your patch.

However, I suggest that you pay attention to the community's feedback

on patch 3 and patch 4 in the patch series I sent.

I think it may be helpful for your later patch submission.

And I'm still working on how to reply to the community.

>> The last 6 patches are Loongarch architecture-related,
>> and the modifications include the definition of the hook
>> function related to the CPU Hot-(UN)Plug, the allocation
>> and release of CPU resources when CPU Hot-(UN)Plug,
>> the creation process of updating the ACPI table,
>> and finally the custom switch for the CPU Hot-Plug.
>>
>> V2:
>> - Fix formatting and spelling errors
>> - Split large patches into smaller patches
>>    - Split the original patch
>>      <<Add basic CPU hot-(un)plug support for Loongarch>> into
>>      <<Added CPU topology support for Loongarch>>
>>      <<Optimize loongarch_irq_init function implementation >>
>>      <<Add basic CPU hot-(un)plug support for Loongarch>>.
>>    - Split the original patch
>>      <<Update the ACPI table for the Loongarch CPU>> into
>>      <<Add generic event device for Loongarch>>
>>      <<Update the ACPI table for the Loongarch CPU>>
>> - Added loongarch cpu topology calculation method.
>> - Change the position of the cpu topology patch.
>> - Change unreasonable variable and function names.
>>
>>
>>
>> xianglai li (10):
>>    Update ACPI GED framework to support vcpu hot-(un)plug
>>    Update CPUs AML with cpu-(ctrl)dev change
>>    make qdev_disconnect_gpio_out_named() public
>>    Introduce the CPU address space destruction function
>>    Added CPU topology support for Loongarch
>>    Optimize loongarch_irq_init function implementation
>>    Add basic CPU hot-(un)plug support for Loongarch
>>    Add support of *unrealize* for Loongarch cpu
>>    Add generic event device for Loongarch
>>    Update the ACPI table for the Loongarch CPU
>>
>>   .../devices/loongarch64-softmmu/default.mak   |   1 +
>>   docs/system/loongarch/virt.rst                |  31 ++
>>   hw/acpi/acpi-cpu-hotplug-stub.c               |  15 +
>>   hw/acpi/cpu.c                                 |  27 +-
>>   hw/acpi/generic_event_device.c                |  33 ++
>>   hw/core/gpio.c                                |   4 +-
>>   hw/i386/acpi-build.c                          |   2 +-
>>   hw/loongarch/acpi-build.c                     |  33 +-
>>   hw/loongarch/generic_event_device_loongarch.c |  36 ++
>>   hw/loongarch/meson.build                      |   2 +-
>>   hw/loongarch/virt.c                           | 424 +++++++++++++++---
>>   include/exec/cpu-common.h                     |   8 +
>>   include/hw/acpi/cpu.h                         |   5 +-
>>   include/hw/acpi/cpu_hotplug.h                 |  10 +
>>   include/hw/acpi/generic_event_device.h        |   6 +
>>   include/hw/core/cpu.h                         |   1 +
>>   include/hw/loongarch/virt.h                   |  10 +-
>>   include/hw/qdev-core.h                        |   2 +
>>   softmmu/physmem.c                             |  24 +
>>   target/loongarch/cpu.c                        |  35 +-
>>   target/loongarch/cpu.h                        |  13 +-
>>   21 files changed, 635 insertions(+), 87 deletions(-)
>>   create mode 100644 hw/loongarch/generic_event_device_loongarch.c
>>
>> Cc: "Salil Mehta" <salil.mehta@opnsrc.net>
>> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
>> Cc: Song Gao <gaosong@loongson.cn>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Ani Sinha <anisinha@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Eduardo Habkost <eduardo@habkost.net>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
>> Cc: Yanan Wang <wangyanan55@huawei.com>
>> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Bibo Mao <maobibo@loongson.cn>
>> Cc: Xianglai li <lixianglai@loongson.cn>
>> --
>> 2.39.1
>>
>>


