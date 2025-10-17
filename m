Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7792BE6C29
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Oct 2025 08:47:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9eDt-000692-5v; Fri, 17 Oct 2025 02:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v9eDf-000606-75
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 02:45:44 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v9eDU-0003uT-IU
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 02:45:41 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dx_78E5vFoOjoXAA--.49687S3;
 Fri, 17 Oct 2025 14:45:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDxQ+QD5vFoHDntAA--.1225S2;
 Fri, 17 Oct 2025 14:45:23 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 0/7] hw/loongarch/virt: Add high MMIO support with GPEX
 host bridge
Date: Fri, 17 Oct 2025 14:45:16 +0800
Message-Id: <20251017064523.2065993-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxQ+QD5vFoHDntAA--.1225S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

On LoongArch Virt Machine, MMIO region with GPEX host bridge is
0x40000000 -- 0x7FFFFFFF. The total size is 1G bytes and it is enough for
emulated virtio devices basically.

However on some conditions such as hostmem is added with virtio-gpu device
with -device virtio-gpu-gl,hostmem=4G. The PCIE MMIO region is not enough,
64-bit high MMIO region is required.

Like other architectures, here property highmem-mmio is added on virt
machine to add 64-bit high MMIO region supported. With high MMIO region
added, it is not compatible with old machine, so property highmem-mmio is
disabled by default.

---
v2 ... v3:
  1. Fix high MMIO space access failure with UEFI BIOS on TCG mode, since
     there is 1:1 identified mapping with UEFI bios, virtual address
     space is 47 bit actually with PGDL root page table, where fail to
     setup mapping table for 48 bit physical address. Here set physical
     address width smaller than virtual address width.

v1 ... v2:
  1. Solve some code conflict and refresh the patch on the latest version.
  2. Base address of GPEX high MMIO starts from end of max physical
     address region rather than adjacent with DRAM, since it is fixed with
     the previous method.
---
Bibo Mao (7):
  hw/loongarch/virt: Add field ram_end in LoongArchVirtMachineState
  hw/loongarch/virt: Add field gpex in LoongArchVirtMachineState
  hw/loongarch/virt: Get irq number from gpex config info
  hw/loongarch/virt: Get PCI info from gpex config info
  hw/loongarch/virt: Add property highmem_mmio with virt machine
  hw/loongarch/virt: Add high MMIO support with GPEX host
  hw/loongarch/virt: Add property highmem-mmio-size with virt machine

 hw/loongarch/virt-acpi-build.c |  17 +---
 hw/loongarch/virt-fdt-build.c  |  43 +++++---
 hw/loongarch/virt.c            | 175 ++++++++++++++++++++++++++++++---
 include/hw/loongarch/virt.h    |   5 +-
 4 files changed, 200 insertions(+), 40 deletions(-)


base-commit: 18f6f30b0089b470f3e737637a86dfb81ebd6eae
-- 
2.39.3


