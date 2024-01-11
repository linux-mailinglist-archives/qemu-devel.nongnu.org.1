Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC7282AD55
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:26:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNtBA-0005uH-AN; Thu, 11 Jan 2024 06:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rNtB3-0005u8-Tc
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:24:49 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rNtB1-0005Gp-4z
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:24:49 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxLOv4z59lRD8EAA--.12655S3;
 Thu, 11 Jan 2024 19:24:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Ax6934z59lWOsPAA--.42068S2; 
 Thu, 11 Jan 2024 19:24:40 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: 
Cc: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL  00/14] loongarch-to-apply queue
Date: Thu, 11 Jan 2024 19:11:34 +0800
Message-Id: <20240111111149.899011-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax6934z59lWOsPAA--.42068S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
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

The following changes since commit 34eac35f893664eb8545b98142e23d9954722766:

  Merge tag 'pull-riscv-to-apply-20240110' of https://github.com/alistair23/qemu into staging (2024-01-10 11:41:56 +0000)

are available in the Git repository at:

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240111

for you to fetch changes up to 428a6ef4396aa910c86e16c1e4409e3927a3698e:

  hw/intc/loongarch_extioi: Add vmstate post_load support (2024-01-11 19:22:47 +0800)

----------------------------------------------------------------
pull-loongarch-20240111

----------------------------------------------------------------
Bibo Mao (4):
      hw/intc/loongarch_ipi: Use MemTxAttrs interface for ipi ops
      hw/loongarch/virt: Set iocsr address space per-board rather than percpu
      hw/intc/loongarch_extioi: Add dynamic cpu number support
      hw/intc/loongarch_extioi: Add vmstate post_load support

Tianrui Zhao (10):
      linux-headers: Synchronize linux headers from linux v6.7.0-rc8
      target/loongarch: Define some kvm_arch interfaces
      target/loongarch: Supplement vcpu env initial when vcpu reset
      target/loongarch: Implement kvm get/set registers
      target/loongarch: Implement kvm_arch_init function
      target/loongarch: Implement kvm_arch_init_vcpu
      target/loongarch: Implement kvm_arch_handle_exit
      target/loongarch: Restrict TCG-specific code
      target/loongarch: Implement set vcpu intr for kvm
      target/loongarch: Add loongarch kvm into meson build

 hw/intc/loongarch_extioi.c            | 230 ++++++----
 hw/intc/loongarch_ipi.c               | 191 +++++----
 hw/loongarch/virt.c                   |  94 +++--
 include/hw/intc/loongarch_extioi.h    |  12 +-
 include/hw/intc/loongarch_ipi.h       |   3 +-
 include/hw/loongarch/virt.h           |   3 +
 include/standard-headers/linux/fuse.h |  10 +-
 meson.build                           |   3 +
 target/loongarch/cpu.c                |  90 ++--
 target/loongarch/cpu.h                |   9 +-
 target/loongarch/internals.h          |   5 +-
 target/loongarch/kvm/kvm.c            | 768 ++++++++++++++++++++++++++++++++++
 target/loongarch/kvm/kvm_loongarch.h  |  16 +
 target/loongarch/kvm/meson.build      |   1 +
 target/loongarch/meson.build          |   1 +
 target/loongarch/tcg/iocsr_helper.c   |  16 +-
 target/loongarch/trace-events         |  15 +
 target/loongarch/trace.h              |   1 +
 18 files changed, 1210 insertions(+), 258 deletions(-)
 create mode 100644 target/loongarch/kvm/kvm.c
 create mode 100644 target/loongarch/kvm/kvm_loongarch.h
 create mode 100644 target/loongarch/kvm/meson.build
 create mode 100644 target/loongarch/trace-events
 create mode 100644 target/loongarch/trace.h


