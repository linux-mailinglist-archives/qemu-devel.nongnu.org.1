Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E01657AED96
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 15:03:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql7iB-0000Bq-Cx; Tue, 26 Sep 2023 09:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1ql7i6-00008N-Je; Tue, 26 Sep 2023 09:02:42 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>)
 id 1ql7i2-00056W-GF; Tue, 26 Sep 2023 09:02:42 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8DxPOth1hJloLYsAA--.14689S3;
 Tue, 26 Sep 2023 21:02:25 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxPC9S1hJlrcgSAA--.1924S2; 
 Tue, 26 Sep 2023 21:02:12 +0800 (CST)
Subject: Re: [PATCH RFC V2 24/37] hw/acpi: Update ACPI GED framework to
 support vCPU Hotplug
To: "Michael S. Tsirkin" <mst@redhat.com>, Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "maz@kernel.org"
 <maz@kernel.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-25-salil.mehta@huawei.com>
 <20230926070112-mutt-send-email-mst@kernel.org>
 <f68a5ccc153f4971b5fbe681095a7624@huawei.com>
 <20230926075838-mutt-send-email-mst@kernel.org>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <b5d15a63-57f8-f136-827f-c0dfbd9eb6bf@loongson.cn>
Date: Tue, 26 Sep 2023 21:02:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230926075838-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxPC9S1hJlrcgSAA--.1924S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3AFyxuF48tryDAw4xJr4xAFc_yoWxJFWrpF
 ZFqF4Y9rWDGr12ya1Iqr9IyFyDKw4UA3yxWrZIyr17KFyqgryakF10gr15WFyftr93GF4U
 ZwnIvrZa93y5tFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
 xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
 6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
 1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxG
 rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14
 v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIY
 rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
 v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
 JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUaJ3kDU
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


Hi Michael S. Tsirkin :
> On Tue, Sep 26, 2023 at 11:37:38AM +0000, Salil Mehta wrote:
>>> From: Michael S. Tsirkin <mst@redhat.com>
>>> Sent: Tuesday, September 26, 2023 12:02 PM
>>> To: Salil Mehta <salil.mehta@huawei.com>
>>> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; maz@kernel.org; jean-
>>> philippe@linaro.org; Jonathan Cameron <jonathan.cameron@huawei.com>;
>>> lpieralisi@kernel.org; peter.maydell@linaro.org;
>>> richard.henderson@linaro.org; imammedo@redhat.com; andrew.jones@linux.dev;
>>> david@redhat.com; philmd@linaro.org; eric.auger@redhat.com;
>>> will@kernel.org; ardb@kernel.org; oliver.upton@linux.dev;
>>> pbonzini@redhat.com; gshan@redhat.com; rafael@kernel.org;
>>> borntraeger@linux.ibm.com; alex.bennee@linaro.org; linux@armlinux.org.uk;
>>> darren@os.amperecomputing.com; ilkka@os.amperecomputing.com;
>>> vishnu@os.amperecomputing.com; karl.heubaum@oracle.com;
>>> miguel.luis@oracle.com; salil.mehta@opnsrc.net; zhukeqian
>>> <zhukeqian1@huawei.com>; wangxiongfeng (C) <wangxiongfeng2@huawei.com>;
>>> wangyanan (Y) <wangyanan55@huawei.com>; jiakernel2@gmail.com;
>>> maobibo@loongson.cn; lixianglai@loongson.cn
>>> Subject: Re: [PATCH RFC V2 24/37] hw/acpi: Update ACPI GED framework to
>>> support vCPU Hotplug
>>>
>>> On Tue, Sep 26, 2023 at 11:04:23AM +0100, Salil Mehta wrote:
>>>> ACPI GED shall be used to convey to the guest kernel about any CPU hot-
>>> (un)plug
>>>> events. Therefore, existing ACPI GED framework inside QEMU needs to be
>>> enhanced
>>>> to support CPU hotplug state and events.
>>>>
>>>> Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
>>> Co-developed with yourself?
>>>
>>> didn't you co-develop this with xianglai li?
>> No, our effort is quite old ARM patch-set existed since the year 2020
>> without any change. Please check the original patch-set here:
>>
>> https://lore.kernel.org/qemu-devel/20200613213629.21984-11-salil.mehta@huawei.com/
>>
>>
>> To be fair to the authors, it will not be right to add another SOB here.
>>
> I see. And what's the difference with patches that xianglai li posted?
> Are they both rebases of the same old patch then?
>
The two patches in front of me in the patch I sent were indeed Salil 
Mehta's patches from rebase,

which were explained in the cover letter of my patch.


I apologize for any misunderstanding this may have caused.

Thanks,

Xianglai.


>>> Just include his S.O.B then, and drop the non-standard Co-developed-by.
>> Co-developed-by Tag has been added to ensure main authors of the patch
>> get highlighted clearly.
> I think I don't know the patch provenance at this point.
>
>>>
>>>
>>>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>>> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
>>>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>>>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>>
>>>
>>>> ---
>>>>   hw/acpi/generic_event_device.c | 10 ++++++++++
>>>>   1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/hw/acpi/generic_event_device.c
>>> b/hw/acpi/generic_event_device.c
>>>> index ad252e6a91..0266733a54 100644
>>>> --- a/hw/acpi/generic_event_device.c
>>>> +++ b/hw/acpi/generic_event_device.c
>>>> @@ -12,6 +12,7 @@
>>>>   #include "qemu/osdep.h"
>>>>   #include "qapi/error.h"
>>>>   #include "hw/acpi/acpi.h"
>>>> +#include "hw/acpi/cpu.h"
>>>>   #include "hw/acpi/generic_event_device.h"
>>>>   #include "hw/irq.h"
>>>>   #include "hw/mem/pc-dimm.h"
>>>> @@ -239,6 +240,8 @@ static void acpi_ged_device_plug_cb(HotplugHandler
>>> *hotplug_dev,
>>>>           } else {
>>>>               acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev,
>>> errp);
>>>>           }
>>>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>>>> +        acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
>>>>       } else {
>>>>           error_setg(errp, "virt: device plug request for unsupported
>>> device"
>>>>                      " type: %s", object_get_typename(OBJECT(dev)));
>>>> @@ -253,6 +256,8 @@ static void acpi_ged_unplug_request_cb(HotplugHandler
>>> *hotplug_dev,
>>>>       if ((object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
>>>>                          !(object_dynamic_cast(OBJECT(dev),
>>> TYPE_NVDIMM)))) {
>>>>           acpi_memory_unplug_request_cb(hotplug_dev, &s->memhp_state, dev,
>>> errp);
>>>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>>>> +        acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev,
>>> errp);
>>>>       } else {
>>>>           error_setg(errp, "acpi: device unplug request for unsupported
>>> device"
>>>>                      " type: %s", object_get_typename(OBJECT(dev)));
>>>> @@ -266,6 +271,8 @@ static void acpi_ged_unplug_cb(HotplugHandler
>>> *hotplug_dev,
>>>>       if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>>>>           acpi_memory_unplug_cb(&s->memhp_state, dev, errp);
>>>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>>>> +        acpi_cpu_unplug_cb(&s->cpuhp_state, dev, errp);
>>>>       } else {
>>>>           error_setg(errp, "acpi: device unplug for unsupported device"
>>>>                      " type: %s", object_get_typename(OBJECT(dev)));
>>>> @@ -277,6 +284,7 @@ static void acpi_ged_ospm_status(AcpiDeviceIf *adev,
>>> ACPIOSTInfoList ***list)
>>>>       AcpiGedState *s = ACPI_GED(adev);
>>>>
>>>>       acpi_memory_ospm_status(&s->memhp_state, list);
>>>> +    acpi_cpu_ospm_status(&s->cpuhp_state, list);
>>>>   }
>>>>
>>>>   static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits
>>> ev)
>>>> @@ -291,6 +299,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev,
>>> AcpiEventStatusBits ev)
>>>>           sel = ACPI_GED_PWR_DOWN_EVT;
>>>>       } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
>>>>           sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
>>>> +    } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
>>>> +        sel = ACPI_GED_CPU_HOTPLUG_EVT;
>>>>       } else {
>>>>           /* Unknown event. Return without generating interrupt. */
>>>>           warn_report("GED: Unsupported event %d. No irq injected", ev);
>>>> --
>>>> 2.34.1


