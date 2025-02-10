Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2E8A2E7F0
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Feb 2025 10:37:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thQDi-0003xV-HA; Mon, 10 Feb 2025 04:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1thQDd-0003v5-03
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 04:36:45 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1thQDY-0001x6-GS
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 04:36:44 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxC3KhyKlnkRtxAA--.199S3;
 Mon, 10 Feb 2025 17:36:33 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxn8WgyKlnqwUKAA--.39266S2;
 Mon, 10 Feb 2025 17:36:32 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/7] hw/loongarch/virt: CPU irq routing enhancement
Date: Mon, 10 Feb 2025 17:36:25 +0800
Message-Id: <20250210093632.3274012-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn8WgyKlnqwUKAA--.39266S2
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

Interrupt controller ipi and extioi on LoongArch system can send
intterrupt to multiple CPUs, physical cpu id is used to route interrupt
for CPUs.

With cpu hotplug feature in future, notification with ipi and extioi
interrupt controller is required. Since there is common Notifier API for
CPU hotplug, cpu hotplug interface is added on ipi and extioi class for
notification usage.

With CPU hotplug event notfication, gpio irq line is connected to cpu irq
line, and irq routing for irqchip is setup.

---
  v1 .. v2:
    1. Combine patchset ipi and extioi irq routing enhancement together
    2. Rebase patch based on latest version
---
Bibo Mao (7):
  hw/intc/loongarch_ipi: Add basic hotplug framework
  hw/intc/loongarch_ipi: Implment cpu hotplug interface
  hw/intc/loongarch_ipi: Notify ipi object when cpu is plugged
  hw/intc/loongarch_extioi: Move gpio irq initial to common code
  hw/intc/loongarch_extioi: Add basic hotplug framework
  hw/intc/loongarch_extioi: Implment cpu hotplug interface
  hw/intc/loongarch_extioi: Use cpu plug notification

 hw/intc/loongarch_extioi.c        |  8 +--
 hw/intc/loongarch_extioi_common.c | 84 ++++++++++++++++++++++++++++++-
 hw/intc/loongarch_ipi.c           | 71 ++++++++++++++++++++++++++
 hw/loongarch/virt.c               | 17 ++-----
 4 files changed, 159 insertions(+), 21 deletions(-)

-- 
2.39.3


