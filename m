Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 644B689AE1E
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Apr 2024 04:48:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtIY7-0005ex-Dv; Sat, 06 Apr 2024 22:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rtIY5-0005eD-68; Sat, 06 Apr 2024 22:46:25 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rtIY2-0002Hl-Io; Sat, 06 Apr 2024 22:46:24 -0400
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VBxNd2143zwRNQ;
 Sun,  7 Apr 2024 10:43:13 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 21CF314037B;
 Sun,  7 Apr 2024 10:46:05 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 10:46:04 +0800
Message-ID: <028f285f-2bf7-c8cb-820c-ba1fd7ee7c9d@huawei.com>
Date: Sun, 7 Apr 2024 10:46:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v12 10/23] hw/arm/virt: Wire NMI and VINMI irq lines from
 GIC to CPU
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
CC: <eduardo@habkost.net>, <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, 
 <wangyanan55@huawei.com>, <richard.henderson@linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20240403101611.3204086-1-ruanjinjie@huawei.com>
 <20240403101611.3204086-11-ruanjinjie@huawei.com>
 <CAFEAcA8ESSRQtemj7xefeb8Fp0__EEiJh2FamGy7w7_iTpyf4A@mail.gmail.com>
In-Reply-To: <CAFEAcA8ESSRQtemj7xefeb8Fp0__EEiJh2FamGy7w7_iTpyf4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=ruanjinjie@huawei.com; helo=szxga01-in.huawei.com
X-Spam_score_int: -76
X-Spam_score: -7.7
X-Spam_bar: -------
X-Spam_report: (-7.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.458,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jinjie Ruan <ruanjinjie@huawei.com>
From:  Jinjie Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 2024/4/4 22:47, Peter Maydell wrote:
> On Wed, 3 Apr 2024 at 11:18, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>> Wire the new NMI and VINMI interrupt line from the GIC to each CPU.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> v9:
>> - Rename ARM_CPU_VNMI to ARM_CPU_VINMI.
>> - Update the commit message.
>> v4:
>> - Add Reviewed-by.
>> v3:
>> - Also add VNMI wire.
>> ---
>>  hw/arm/virt.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index a9a913aead..ef2e6c2c4d 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -821,7 +821,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
>>
>>      /* Wire the outputs from each CPU's generic timer and the GICv3
>>       * maintenance interrupt signal to the appropriate GIC PPI inputs,
>> -     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's inputs.
>> +     * and the GIC's IRQ/FIQ/VIRQ/VFIQ/NMI/VINMI interrupt outputs to the
>> +     * CPU's inputs.
>>       */
>>      for (i = 0; i < smp_cpus; i++) {
>>          DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
>> @@ -865,6 +866,10 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
>>                             qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
>>          sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
>>                             qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
>> +        sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus,
>> +                           qdev_get_gpio_in(cpudev, ARM_CPU_NMI));
>> +        sysbus_connect_irq(gicbusdev, i + 5 * smp_cpus,
>> +                           qdev_get_gpio_in(cpudev, ARM_CPU_VINMI));
>>      }
> 
> This patch needs to go after patch 11. Otherwise at this point
> in the patchseries we are trying to wire up GPIOs on the GIC
> which don't exist, and QEMU will assert:
> 
> $ ./build/x86/qemu-system-aarch64 -M virt,gic-version=3
> Unexpected error in object_property_find_err() at ../../qom/object.c:1366:
> qemu-system-aarch64: Property 'arm-gicv3.sysbus-irq[4]' not found
> Aborted (core dumped)
> 
> We also need to only connect these up if vms->gic_version
> is not VIRT_GIC_VERSION_2. This is because these GPIOs don't
> exist on the GICv2, and otherwise we again assert if you
> try to wire them up but you're using GICv2:
> 
> $ ./build/x86/qemu-system-aarch64 -M virt,gic-version=2
> Unexpected error in object_property_find_err() at ../../qom/object.c:1366:
> qemu-system-aarch64: Property 'arm_gic.sysbus-irq[4]' not found
> Aborted (core dumped)

Thank you! I'll fix them.

> 
> thanks
> -- PMM

