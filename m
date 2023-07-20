Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1265075A78B
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 09:17:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMNt9-0000YT-4n; Thu, 20 Jul 2023 03:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qMNsp-0000Xv-Uy
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 03:15:35 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qMNsm-0007K3-TS
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 03:15:31 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxxPAB37hkcJEHAA--.19774S3;
 Thu, 20 Jul 2023 15:15:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx3yMB37hkIlg1AA--.41433S2; 
 Thu, 20 Jul 2023 15:15:13 +0800 (CST)
From: xianglai li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/8] Adds CPU hot-plug support to Loongarch
Date: Thu, 20 Jul 2023 15:15:05 +0800
Message-Id: <cover.1689837093.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx3yMB37hkIlg1AA--.41433S2
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
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The last four patches are Loongarch architecture-related,
and the modifications include the definition of the hook
function related to the CPU Hot-(UN)Plug, the allocation
and release of CPU resources when CPU Hot-(UN)Plug,
the creation process of updating the ACPI table,
and finally the custom switch for the CPU Hot-Plug.

xianglai li (8):
  Update ACPI GED framework to support vcpu hot-(un)plug
  Update CPUs AML with cpu-(ctrl)dev change
  Introduced a new function to disconnect GPIO connections
  Introduce the CPU address space destruction function
  Adds basic CPU hot-(un)plug support for Loongarch
  Add support of *unrealize* for loongarch cpu
  Update the ACPI table for the Loongarch CPU
  Turn on CPU hot-(un)plug customization for loongarch

 .../devices/loongarch64-softmmu/default.mak   |   1 +
 hw/acpi/acpi-cpu-hotplug-stub.c               |  15 +
 hw/acpi/cpu.c                                 |  37 +-
 hw/acpi/generic_event_device.c                |  33 ++
 hw/core/gpio.c                                |   4 +-
 hw/i386/acpi-build.c                          |   2 +-
 hw/loongarch/acpi-build.c                     |  35 +-
 hw/loongarch/generic_event_device_loongarch.c |  36 ++
 hw/loongarch/meson.build                      |   2 +-
 hw/loongarch/virt.c                           | 381 +++++++++++++++++-
 include/exec/cpu-common.h                     |   8 +
 include/hw/acpi/cpu.h                         |   5 +-
 include/hw/acpi/cpu_hotplug.h                 |  10 +
 include/hw/acpi/generic_event_device.h        |   6 +
 include/hw/core/cpu.h                         |   1 +
 include/hw/loongarch/virt.h                   |  11 +-
 include/hw/qdev-core.h                        |   2 +
 softmmu/physmem.c                             |  24 ++
 target/loongarch/cpu.c                        |  33 ++
 target/loongarch/cpu.h                        |   5 +
 20 files changed, 615 insertions(+), 36 deletions(-)
 create mode 100644 hw/loongarch/generic_event_device_loongarch.c

-- 
2.39.1


