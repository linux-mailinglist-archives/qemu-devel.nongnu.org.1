Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4867AF815
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 04:27:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlKFy-0001Ye-Rc; Tue, 26 Sep 2023 22:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qlKFt-0001YU-Nk
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 22:26:26 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qlKFq-0002j0-PE
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 22:26:25 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8AxEvDJkhNlSBItAA--.19995S3;
 Wed, 27 Sep 2023 10:26:17 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxPC_GkhNlxosTAA--.1951S2; 
 Wed, 27 Sep 2023 10:26:16 +0800 (CST)
Subject: Re: [PATCH v3 7/7] Update the ACPI table for the Loongarch CPU
To: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>, Salil Mehta
 <salil.mehta@opnsrc.net>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>
References: <cover.1695697701.git.lixianglai@loongson.cn>
 <eb15eaa49c27beb7918a0dbaf4ba53ad6f3cd805.1695697701.git.lixianglai@loongson.cn>
 <fb85e363198c40e89583296f8ab0d9a5@huawei.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <32565111-9749-318d-d5dd-58b2076e3207@loongson.cn>
Date: Wed, 27 Sep 2023 10:26:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fb85e363198c40e89583296f8ab0d9a5@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxPC_GkhNlxosTAA--.1951S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXFW7Zr4xWFy5KF4kKw1xZwc_yoW5ur4UpF
 9rC3WY9ryqyrW7Ca1aqFy2yas3Xr4kG3yxXws7tr9YkasFyw13Ar18Xw4DXF9Fvw1fWF48
 Zr40g3Z2g3W5ZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67
 AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIY
 rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
 v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
 JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxhiSDU
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


Hi Salil Mehta:
> Hi Xianglai,
>
>> From: xianglai li <lixianglai@loongson.cn>
>> Sent: Tuesday, September 26, 2023 10:55 AM
>> To: qemu-devel@nongnu.org
>> Cc: Bernhard Beschow <shentey@gmail.com>; Salil Mehta
>> <salil.mehta@opnsrc.net>; Salil Mehta <salil.mehta@huawei.com>; Xiaojuan
>> Yang <yangxiaojuan@loongson.cn>; Song Gao <gaosong@loongson.cn>; Michael S.
>> Tsirkin <mst@redhat.com>; Igor Mammedov <imammedo@redhat.com>; Ani Sinha
>> <anisinha@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Richard
>> Henderson <richard.henderson@linaro.org>; Eduardo Habkost
>> <eduardo@habkost.net>; Marcel Apfelbaum <marcel.apfelbaum@gmail.com>;
>> Philippe Mathieu-Daudé <philmd@linaro.org>; wangyanan (Y)
>> <wangyanan55@huawei.com>; Daniel P. Berrangé <berrange@redhat.com>; Peter
>> Xu <peterx@redhat.com>; David Hildenbrand <david@redhat.com>; Bibo Mao
>> <maobibo@loongson.cn>
>> Subject: [PATCH v3 7/7] Update the ACPI table for the Loongarch CPU
>>
>> Add new types of GED devices for Loongarch machines,
>> add CPU hot-(un)plug event response and address spaces,
>> and update the ACPI table.
>>
>> Cc: "Bernhard Beschow" <shentey@gmail.com>
>> Cc: "Salil Mehta" <salil.mehta@opnsrc.net>
>> Cc: "Salil Mehta" <salil.mehta@huawei.com>
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
>> Signed-off-by: xianglai li <lixianglai@loongson.cn>
>> ---
>>   hw/acpi/acpi-cpu-hotplug-stub.c |  9 +++++++++
>>   hw/loongarch/acpi-build.c       | 34 ++++++++++++++++++++++++++++++++-
>>   hw/loongarch/virt.c             |  3 ++-
>>   include/hw/loongarch/virt.h     |  1 +
>>   4 files changed, 45 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-
>> stub.c
>> index 2aec90d968..b3ac7a1e31 100644
>> --- a/hw/acpi/acpi-cpu-hotplug-stub.c
>> +++ b/hw/acpi/acpi-cpu-hotplug-stub.c
>> @@ -19,6 +19,15 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent,
>> Object *owner,
>>       return;
>>   }
>>
>> +void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures
>> opts,
>> +                    build_madt_cpu_fn build_madt_cpu, hwaddr mmap_io_base,
>> +                    const char *res_root,
>> +                    const char *event_handler_method,
>> +                    AmlRegionSpace rs)
>> +{
>> +    return;
>> +}
>> +
>>   void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList
>> ***list)
>>   {
>>       return;


Ok, I'll take care of that.

Thanks,

Xianglai.

>
> Above change is already part of the architecture agnostic patch-set.
> Not required here!
>
> Thanks
> Salil.


