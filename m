Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 499EDB43BEA
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Sep 2025 14:44:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu9IQ-0004vH-JK; Thu, 04 Sep 2025 08:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uu9IK-0004tO-Tw
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 08:42:29 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uu9IA-0007un-93
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 08:42:28 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxqdEdiblo6akGAA--.13985S3;
 Thu, 04 Sep 2025 20:42:05 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCxdOQbiblo4QJ+AA--.6028S2;
 Thu, 04 Sep 2025 20:42:03 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v6 00/11] hw/loongarch: add the advanced extended interrupt
 controllers (AVECINTC) support
Date: Thu,  4 Sep 2025 20:18:29 +0800
Message-Id: <20250904121840.2023683-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxdOQbiblo4QJ+AA--.6028S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi,

Introduce the advanced extended interrupt controllers (AVECINTC). This
feature will allow each core to have 256 independent interrupt vectors
and MSI interrupts can be independently routed to any vector on any CPU.

The whole topology of irqchips in LoongArch machines looks like this if
AVECINTC is supported:
      +-----+     +---------------------------------+     +-------+
      | IPI | --> |        CPUINTC                  | <-- | Timer |
      +-----+     +---------------------------------+     +-------+
                          ^            ^          ^
                          |            |          |
                 +-------------+ +----------+ +---------+     +-------+
                 |   EIOINTC   | | AVECINTC | | LIOINTC | <-- | UARTs |
                 +-------------+ +----------+ +---------+     +-------+
                 ^            ^       ^
                 |            |       |
            +---------+  +---------+  |
            | PCH-PIC |  | PCH-MSI |  |
            +---------+  +---------+  |
              ^     ^           ^     |
              |     |           |     |
      +---------+ +---------+ +---------+
      | Devices | | PCH-LPC | | Devices |
      +---------+ +---------+ +---------+
                      ^
                      |
                 +---------+
                 | Devices |
                 +---------+

We can see more about AVECINTC on linux driver code[1]
and loongarch msg interrupts on volI 6.2 Message-Interrupts

Tested the code using the virion-net NIC the start scripts is kernel.sh at[3] and then
run 'ifconfig eth0 192.168.122.12' or
test avec plug and unplug interfaces
1 run kernel.sh[3]
2 telnet localhost 4418;
3 run QOM 'device_add la464-loongarch-cpu,socket-id=2,core-id=0,thread-id=0,id=cpu-2'
4 run vm 'ifconfig eth0 192.168.122.12';
5 run QOM 'device_de cpu-2'
6 run vm 'ifconfig eth0 192.168.122.11';

[1]: https://github.com/torvalds/linux/blob/master/drivers/irqchip/irq-loongarch-avec.c
[2]: https://github.com/loongson/LoongArch-Documentation/releases/download/2023.04.20/LoongArch-Vol1-v1.10-EN.pdf
[3]: https://github.com/gaosong715/qemu/releases/download/pull-loongarch-20250514/kernel.sh

v6:
  1: Change some code to support KVM mode, and will add a patch in late.
  2: Use async_run_on_cpu() to update CSR_MSGIS;
  3: Rebase.

v5:
  1: rebase and R_b;
  2; change patch2 and patch3 commit message;
  3, change virt_is_avecintc_enabled() to virt_has_avecintc();
  4: remove set and clean CSR_ECFG.bit15;
  5; patch11 add some check lvms->avec, beacuse someone my set avecintc=off.

v4:
  1: Implemetnt the AVEC plug/unplug interface. test with devcice-add
cpu and device-add and then setup the virtio-net nic. new patch11;
  2: add a new patch1 move some machine define to virt.h;
  3; add a new patch3 to implemet write/raad misc' avec feature and
status bit.
  4: Simplification of patch8 and patch10 as per bibo's suggestion.

v3:
  1: Implement the read-clear feature for CSR_MSGIR register
  2: Fix some code style;
  3: Merge patch8 and patch9 into one patch8;
  4: Fix patch7 get wrong cpu_num and irq_num;
  5: Add vmstate_msg for messag-interrupt registers migrate;
  6: Update test scripts use  '-bios', because kernel use avec need acpi
support. the bios is qemu/pc_bios/edk2-loongarch64-code.fd.bz2.

Thanks.
Song Gao


Song Gao (11):
  target/loongarch: move some machine define to virt.h
  hw/loongarch: add virt feature avecintc support
  hw/loongarch: add misc register supoort avecintc
  loongarch: add a advance interrupt controller device
  target/loongarch: add msg interrupt CSR registers
  hw/loongarch: AVEC controller add a MemoryRegion
  hw/loongarch: Implement avec controller imput and output pins
  hw/loongarch: Implement avec set irq
  target/loongarch: Add CSR_ESTAT.bit15 and CSR_ECFG.bit15 for msg
    interrupts.
  target/loongarch:Implement csrrd CSR_MSGIR register
  hw/loongarch: Implement AVEC plug/unplug interfaces

 hw/intc/Kconfig                               |   3 +
 hw/intc/loongarch_avec.c                      | 237 ++++++++++++++++++
 hw/intc/meson.build                           |   1 +
 hw/loongarch/Kconfig                          |   1 +
 hw/loongarch/virt.c                           |  99 +++++++-
 include/hw/intc/loongarch_avec.h              |  39 +++
 include/hw/loongarch/virt.h                   |  34 +++
 include/hw/pci-host/ls7a.h                    |   2 +
 target/loongarch/cpu-csr.h                    |   9 +-
 target/loongarch/cpu.h                        |  35 +--
 target/loongarch/csr.c                        |   5 +
 target/loongarch/machine.c                    |  27 +-
 target/loongarch/tcg/csr_helper.c             |  21 ++
 target/loongarch/tcg/helper.h                 |   1 +
 .../tcg/insn_trans/trans_privileged.c.inc     |   1 +
 15 files changed, 488 insertions(+), 27 deletions(-)
 create mode 100644 hw/intc/loongarch_avec.c
 create mode 100644 include/hw/intc/loongarch_avec.h

-- 
2.41.0


