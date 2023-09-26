Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 417BA7AE9A6
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 11:55:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql4mJ-0003Yd-8I; Tue, 26 Sep 2023 05:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1ql4mD-0003Xu-Mh
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 05:54:45 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1ql4m9-0001ao-Hw
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 05:54:45 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxTetYqhJlLaIsAA--.14436S3;
 Tue, 26 Sep 2023 17:54:32 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxnd5YqhJlTJgSAA--.40131S2; 
 Tue, 26 Sep 2023 17:54:32 +0800 (CST)
From: xianglai li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/7] *** Adds CPU hot-plug support to Loongarch ***
Date: Tue, 26 Sep 2023 17:54:25 +0800
Message-Id: <cover.1695697701.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxnd5YqhJlTJgSAA--.40131S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hello everyone, We refer to the implementation of ARM CPU
Hot-Plug to add GED-based CPU Hot-Plug support to Loongarch.

The first 2 patches are changes to the QEMU common code,
including adding GED support for CPU Hot-Plug, updating
the ACPI table creation process.

For the modification of the public part of the code, we refer to the
arm-related patch, and the link address of the corresponding patch is
as follows:
https://lore.kernel.org/all/20200613213629.21984-1-salil.mehta@huawei.com/

We also refer to shentey's patch link as follows:
https://patchew.org/QEMU/20230908084234.17642-1-shentey@gmail.com/

In order to respect the work of "Salil Mehta" and shentey, we will rebase
the first 2 patches in the final patch, which are referenced here to ensure
that the loongarch cpu hotplug can work properly.

The last 5 patches are Loongarch architecture-related,
and the modifications include the definition of the hook
function related to the CPU Hot-(UN)Plug, the allocation
and release of CPU resources when CPU Hot-(UN)Plug,
the creation process of updating the ACPI table,
and finally the custom switch for the CPU Hot-Plug.

V3:
- The call to the function qdev_disconnect_gpio_out_named was removed
- The use of the function cpu_address_space_destroy is necessary,
  most architectures also need to be called, we want to call
  in the common path, rather than each cpu architecture itself,
  because the scheme is not sure we want to solve this problem
  in a separate patch, here we do the function rollback processing.
- Referring to shentey's patch, loongarch no longer creates the
  TYPE_ACPI_GED_LOONGARCH device class, but instead passes build_madt_cpu_fn
  directly as an argument to the build_cpus_aml function

V2:
- Fix formatting and spelling errors
- Split large patches into smaller patches
  - Split the original patch
    <<Add basic CPU hot-(un)plug support for Loongarch>> into
    <<Added CPU topology support for Loongarch>>
    <<Optimize loongarch_irq_init function implementation >>
    <<Add basic CPU hot-(un)plug support for Loongarch>>.
  - Split the original patch
    <<Update the ACPI table for the Loongarch CPU>> into
    <<Add generic event device for Loongarch>>
    <<Update the ACPI table for the Loongarch CPU>>
- Added loongarch cpu topology calculation method.
- Change the position of the cpu topology patch.
- Change unreasonable variable and function names.

xianglai li (7):
  Update ACPI GED framework to support vcpu hot-(un)plug
  Update CPUs AML with cpu-(ctrl)dev change
  Added CPU topology support for Loongarch
  Optimize loongarch_irq_init function implementation
  Add basic CPU hot-(un)plug support for Loongarch
  Add support of *unrealize* for Loongarch cpu
  Update the ACPI table for the Loongarch CPU

 .../devices/loongarch64-softmmu/default.mak   |   1 +
 docs/system/loongarch/virt.rst                |  31 ++
 hw/acpi/acpi-cpu-hotplug-stub.c               |  15 +
 hw/acpi/cpu.c                                 |  27 +-
 hw/acpi/generic_event_device.c                |  33 ++
 hw/i386/acpi-build.c                          |   3 +-
 hw/loongarch/acpi-build.c                     |  34 +-
 hw/loongarch/virt.c                           | 409 +++++++++++++++---
 include/hw/acpi/cpu.h                         |   5 +-
 include/hw/acpi/cpu_hotplug.h                 |  10 +
 include/hw/acpi/generic_event_device.h        |   5 +
 include/hw/loongarch/virt.h                   |   6 +-
 target/loongarch/cpu.c                        |  33 +-
 target/loongarch/cpu.h                        |  13 +-
 14 files changed, 542 insertions(+), 83 deletions(-)

-- 
2.39.1


