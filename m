Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 527498D2FD4
	for <lists+qemu-devel@lfdr.de>; Wed, 29 May 2024 10:07:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCEKB-0004rm-MA; Wed, 29 May 2024 04:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sCEK8-0004rV-Kx
 for qemu-devel@nongnu.org; Wed, 29 May 2024 04:06:16 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sCEK5-0003Ce-Ms
 for qemu-devel@nongnu.org; Wed, 29 May 2024 04:06:16 -0400
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8CxL_Dn4VZm3gsBAA--.4568S3;
 Wed, 29 May 2024 16:05:59 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxvsfk4VZm8bwMAA--.33476S3; 
 Wed, 29 May 2024 16:05:58 +0800 (CST)
Subject: Re: [PATCH] tests/libqos: Add loongarch virt machine node
To: Thomas Huth <thuth@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
References: <20240528082053.938564-1-maobibo@loongson.cn>
 <e10e39b9-f000-4b61-80b8-7ff78b1c176d@redhat.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <2333de16-927f-a37f-6816-0627c36ea617@loongson.cn>
Date: Wed, 29 May 2024 16:05:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e10e39b9-f000-4b61-80b8-7ff78b1c176d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxvsfk4VZm8bwMAA--.33476S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXF1Utw43JF13KrW3WFWkKrX_yoW5XFy7pF
 W8Aa90kryUWrn3J3sxJa4UWFy5Jrs7Ga42gF1IqF40kF9xWr1jvr1Fv34j93ZxJw48Xr4j
 vw1kJr13ZF1YvagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
 67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
 vfC2KfnxnUUI43ZEXa7IU8j-e5UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.786,
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

Thomas,

Thanks for reviewing the patch.

On 2024/5/29 下午3:10, Thomas Huth wrote:
> On 28/05/2024 10.20, Bibo Mao wrote:
>> Add loongarch virt machine to the graph. It is a modified copy of
>> the existing riscv virtmachine in riscv-virt-machine.c
>>
>> It contains a generic-pcihost controller, and an extra function
>> loongarch_config_qpci_bus() to configure GPEX pci host controller
>> information, such as ecam and pio_base addresses.
>>
>> Also hotplug handle checking about TYPE_VIRTIO_IOMMU_PCI device is
>> added on loongarch virt machine, since virtio_mmu_pci device requires
>> it.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   hw/loongarch/virt.c                         |   2 +
>>   tests/qtest/libqos/loongarch-virt-machine.c | 114 ++++++++++++++++++++
>>   tests/qtest/libqos/meson.build              |   1 +
>>   3 files changed, 117 insertions(+)
>>   create mode 100644 tests/qtest/libqos/loongarch-virt-machine.c
>>
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index 3e6e93edf3..2d7f718570 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -45,6 +45,7 @@
>>   #include "sysemu/tpm.h"
>>   #include "sysemu/block-backend.h"
>>   #include "hw/block/flash.h"
>> +#include "hw/virtio/virtio-iommu.h"
>>   #include "qemu/error-report.h"
>>   static PFlashCFI01 *virt_flash_create1(LoongArchVirtMachineState *lvms,
>> @@ -1213,6 +1214,7 @@ static HotplugHandler 
>> *virt_get_hotplug_handler(MachineState *machine,
>>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>>       if (device_is_dynamic_sysbus(mc, dev) ||
>> +        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
>>           memhp_type_supported(dev)) {
>>           return HOTPLUG_HANDLER(machine);
>>       }
>> diff --git a/tests/qtest/libqos/loongarch-virt-machine.c 
>> b/tests/qtest/libqos/loongarch-virt-machine.c
>> new file mode 100644
>> index 0000000000..c12089c015
>> --- /dev/null
>> +++ b/tests/qtest/libqos/loongarch-virt-machine.c
>> @@ -0,0 +1,114 @@
>> +/*
>> + * libqos driver framework
>> + *
>> + * Copyright (c) 2018 Emanuele Giuseppe Esposito 
>> <e.emanuelegiuseppe@gmail.com>
>> + *
> 
> Don't you want to add your information here, too?
Will add in next version.

> 
> Anyway:
> Acked-by: Thomas Huth <thuth@redhat.com>
> 
> I assume this will go through the loongarch tree. Let me know if you 
> want to get this merged through the qtest tree instead.
yes, I think it will go through the loongarch tree.

Regards
Bibo Mao


