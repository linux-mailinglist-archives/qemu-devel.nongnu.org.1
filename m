Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6EB7C7C68
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 05:59:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr9K3-0007ge-DE; Thu, 12 Oct 2023 23:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qr9Jy-0007fp-Kn; Thu, 12 Oct 2023 23:58:43 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>)
 id 1qr9Jv-0004T4-G8; Thu, 12 Oct 2023 23:58:42 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8BxuOhlwChlfJQxAA--.59748S3;
 Fri, 13 Oct 2023 11:58:29 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dx3t5hwChlzn0iAA--.3543S2; 
 Fri, 13 Oct 2023 11:58:27 +0800 (CST)
Subject: Re: [PATCH V5 0/9] Add architecture agnostic code to support vCPU
 Hotplug
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, linuxarm@huawei.com
References: <20231011194355.15628-1-salil.mehta@huawei.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <34927805-a968-271f-16c2-17c8d90693d9@loongson.cn>
Date: Fri, 13 Oct 2023 11:58:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20231011194355.15628-1-salil.mehta@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Dx3t5hwChlzn0iAA--.3543S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWr48Wr4kuFy3tFy3JF48Zrc_yoWrZF4kpa
 nY93WYgw45Kr47ur4fXryrZ345Wa1kGw4IqrsF934rZas0gw1kZrW0g3yjqFyUJrZ7KFyx
 XFnIqF1kGw1jywcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67
 AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCI
 c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
 AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
 Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUnoSoJ
 UUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.339,
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

Hi Salil Mehta via:

> Virtual CPU hotplug support is being added across various architectures[1][3].
> This series adds various code bits common across all architectures:
>
> 1. vCPU creation and Parking code refactor [Patch 1]
> 2. Update ACPI GED framework to support vCPU Hotplug [Patch 4,6,7]
> 3. ACPI CPUs AML code change [Patch 5]
> 4. Helper functions to support unrealization of CPU objects [Patch 8,9]
> 5. Misc [Patch 2,3]
>
>
> Repository:
>
> [*] https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v2.common.v5
>
>
> Revision History:
>
> RFC V4 -> RFC V5
> 1. Addressed Gavin Shan's comments
>     - Fixed the trace events print string for kvm_{create,get,park,destroy}_vcpu
>     - Added Reviewed-by tag for patch {1}
> 2. Added Shaoqin Huang's Reviewed-by tags for Patches {2,3}
> 3. Added Tested-by Tag from Vishnu Pajjuri to the patch-set
> 4. Dropped the ARM specific Patch-10 from V4
> Link: https://lore.kernel.org/qemu-devel/20231009203601.17584-1-salil.mehta@huawei.com/
>
> RFC V3 -> RFC V4
> 1. Addressed David Hilderbrand's comments
>     - Fixed the wrong doc comment of kvm_park_vcpu API prototype
>     - Added Reviewed-by tags for patches {2,4}
> Link: https://lore.kernel.org/qemu-devel/20231009112812.10612-1-salil.mehta@huawei.com/
>
> RFC V2 -> RFC V3
> 1. Addressed Jonathan Cameron's comments
>     - Fixed 'vcpu-id' type wrongly changed from 'unsigned long' to 'integer'
>     - Removed unnecessary use of variable 'vcpu_id' in kvm_park_vcpu
>     - Updated [Patch V2 03/10] commit-log with details of ACPI_CPU_SCAN_METHOD macro
>     - Updated [Patch V2 05/10] commit-log with details of conditional event handler method
>     - Added Reviewed-by tags for patches {2,3,4,6,7}
> 2. Addressed Gavin Shan's comments
>     - Remove unnecessary use of variable 'vcpu_id' in kvm_par_vcpu
>     - Fixed return value in kvm_get_vcpu from -1 to -ENOENT
>     - Reset the value of 'gdb_num_g_regs' in gdb_unregister_coprocessor_all
>     - Fixed the kvm_{create,park}_vcpu prototypes docs
>     - Added Reviewed-by tags for patches {2,3,4,5,6,7,9,10}
> 3. Addressed one earlier missed comment by Alex Bennée in RFC V1
>     - Added traces instead of DPRINTF in the newly added and some existing functions
> Link: https://lore.kernel.org/qemu-devel/20230930001933.2660-1-salil.mehta@huawei.com/
>
> RFC V1 -> RFC V2
> 1. Addressed Alex Bennée's comments
>     - Refactored the kvm_create_vcpu logic to get rid of goto
>     - Added the docs for kvm_{create,park}_vcpu prototypes
>     - Splitted the gdbstub and AddressSpace destruction change into separate patches
>     - Added Reviewed-by tags for patches {2,10}
> Link: https://lore.kernel.org/qemu-devel/20230929124304.13672-1-salil.mehta@huawei.com/
>
> References:
>
> [1] https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@huawei.com/
> [2] https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/
> [3] https://lore.kernel.org/qemu-devel/cover.1695697701.git.lixianglai@loongson.cn/
>
>
> Salil Mehta (9):
>    accel/kvm: Extract common KVM vCPU {creation,parking} code
>    hw/acpi: Move CPU ctrl-dev MMIO region len macro to common header file
>    hw/acpi: Add ACPI CPU hotplug init stub
>    hw/acpi: Init GED framework with CPU hotplug events
>    hw/acpi: Update CPUs AML with cpu-(ctrl)dev change
>    hw/acpi: Update GED _EVT method AML with CPU scan
>    hw/acpi: Update ACPI GED framework to support vCPU Hotplug
>    physmem: Add helper function to destroy CPU AddressSpace
>    gdbstub: Add helper function to unregister GDB register space
>
>   accel/kvm/kvm-all.c                    | 64 ++++++++++++++++++++------
>   accel/kvm/trace-events                 |  4 ++
>   gdbstub/gdbstub.c                      | 15 ++++++
>   hw/acpi/acpi-cpu-hotplug-stub.c        |  6 +++
>   hw/acpi/cpu.c                          | 27 +++++++----
>   hw/acpi/generic_event_device.c         | 22 +++++++++
>   hw/i386/acpi-build.c                   |  2 +-
>   include/exec/cpu-common.h              |  8 ++++
>   include/exec/gdbstub.h                 |  5 ++
>   include/hw/acpi/cpu.h                  |  5 +-
>   include/hw/acpi/cpu_hotplug.h          |  4 ++
>   include/hw/acpi/generic_event_device.h |  5 ++
>   include/hw/core/cpu.h                  |  1 +
>   include/sysemu/kvm.h                   | 16 +++++++
>   softmmu/physmem.c                      | 25 ++++++++++
>   15 files changed, 182 insertions(+), 27 deletions(-)


I rebase your patch v5 on loongarch tcg, there is no problem with cpu
hotplug/unplug.

Thank you so much for your contribution to the community.

Thanks,
Xianglai.


