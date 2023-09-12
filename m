Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A89479C278
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 04:14:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfstH-0001GO-3i; Mon, 11 Sep 2023 22:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qfst5-0001Ev-GM
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 22:12:24 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qfssy-0005QR-UH
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 22:12:21 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxnuvuyP9k3jElAA--.4740S3;
 Tue, 12 Sep 2023 10:11:58 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxfSPqyP9kCnh4AA--.42014S2; 
 Tue, 12 Sep 2023 10:11:55 +0800 (CST)
From: xianglai li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: "Salil Mehta" <salil.mehta@opnsrc.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>, Xianglai li <lixianglai@loongson.cn>
Subject: [PATCH v2 00/10] Adds CPU hot-plug support to Loongarch
Date: Tue, 12 Sep 2023 10:11:37 +0800
Message-Id: <cover.1694433326.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxfSPqyP9kCnh4AA--.42014S2
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

The first 4 patches are changes to the QEMU common code,
including adding GED support for CPU Hot-Plug, updating
the ACPI table creation process, and adding qdev_disconnect_gpio_out_named
and cpu_address_space_destroy interfaces to release resources
when CPU un-plug.

For the modification of the public part of the code, we refer to the
arm-related patch, and the link address of the corresponding patch is
as follows:
https://lore.kernel.org/all/20200613213629.21984-1-salil.mehta@huawei.com/

In order to respect the work of "Salil Mehta", we will rebase the first
4 patches in the final patch, which are referenced here to ensure that
the loongarch cpu hotplug can work properly.

The last 6 patches are Loongarch architecture-related,
and the modifications include the definition of the hook
function related to the CPU Hot-(UN)Plug, the allocation
and release of CPU resources when CPU Hot-(UN)Plug,
the creation process of updating the ACPI table,
and finally the custom switch for the CPU Hot-Plug.

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



xianglai li (10):
  Update ACPI GED framework to support vcpu hot-(un)plug
  Update CPUs AML with cpu-(ctrl)dev change
  make qdev_disconnect_gpio_out_named() public
  Introduce the CPU address space destruction function
  Added CPU topology support for Loongarch
  Optimize loongarch_irq_init function implementation
  Add basic CPU hot-(un)plug support for Loongarch
  Add support of *unrealize* for Loongarch cpu
  Add generic event device for Loongarch
  Update the ACPI table for the Loongarch CPU

 .../devices/loongarch64-softmmu/default.mak   |   1 +
 docs/system/loongarch/virt.rst                |  31 ++
 hw/acpi/acpi-cpu-hotplug-stub.c               |  15 +
 hw/acpi/cpu.c                                 |  27 +-
 hw/acpi/generic_event_device.c                |  33 ++
 hw/core/gpio.c                                |   4 +-
 hw/i386/acpi-build.c                          |   2 +-
 hw/loongarch/acpi-build.c                     |  33 +-
 hw/loongarch/generic_event_device_loongarch.c |  36 ++
 hw/loongarch/meson.build                      |   2 +-
 hw/loongarch/virt.c                           | 424 +++++++++++++++---
 include/exec/cpu-common.h                     |   8 +
 include/hw/acpi/cpu.h                         |   5 +-
 include/hw/acpi/cpu_hotplug.h                 |  10 +
 include/hw/acpi/generic_event_device.h        |   6 +
 include/hw/core/cpu.h                         |   1 +
 include/hw/loongarch/virt.h                   |  10 +-
 include/hw/qdev-core.h                        |   2 +
 softmmu/physmem.c                             |  24 +
 target/loongarch/cpu.c                        |  35 +-
 target/loongarch/cpu.h                        |  13 +-
 21 files changed, 635 insertions(+), 87 deletions(-)
 create mode 100644 hw/loongarch/generic_event_device_loongarch.c

Cc: "Salil Mehta" <salil.mehta@opnsrc.net>
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
Cc: Yanan Wang <wangyanan55@huawei.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Xianglai li <lixianglai@loongson.cn>
--
2.39.1


