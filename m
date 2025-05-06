Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBA7AAAB8D
	for <lists+qemu-devel@lfdr.de>; Tue,  6 May 2025 03:57:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC7Xe-0000B6-ME; Mon, 05 May 2025 21:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uC7XZ-00005M-Og
 for qemu-devel@nongnu.org; Mon, 05 May 2025 21:56:14 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uC7XV-0001f0-VM
 for qemu-devel@nongnu.org; Mon, 05 May 2025 21:56:13 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxyuAtbBlo7TjWAA--.24020S3;
 Tue, 06 May 2025 09:55:57 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxHcUpbBloEoa1AA--.64914S2;
 Tue, 06 May 2025 09:55:54 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PULL 0/8] loongarch-to-apply queue
Date: Tue,  6 May 2025 09:55:45 +0800
Message-Id: <20250506015553.1669363-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxHcUpbBloEoa1AA--.64914S2
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit 5134cf9b5d3aee4475fe7e1c1c11b093731073cf:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2025-04-30 13:34:44 -0400)

are available in the Git repository at:

  https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20250506

for you to fetch changes up to 445c9c645befa759b95b21108447704ab328ae03:

  hw/loongarch/virt: Allow user to customize OEM ID and OEM table ID (2025-05-06 09:17:32 +0800)

----------------------------------------------------------------
pull-loongarch-20250506 queue

----------------------------------------------------------------
Bibo Mao (8):
      hw/intc/loongarch_ipi: Add reset support
      hw/intc/loongarch_extioi: Add reset support
      hw/intc/loongarch_extioi: Replace legacy reset callback with new api
      hw/intc/loongarch_pch: Add reset support
      hw/intc/loongarch_pch: Replace legacy reset callback with new api
      hw/loongarch/virt: Get physical entry address with elf file
      hw/loongarch/virt: Replace RSDT with XSDT table
      hw/loongarch/virt: Allow user to customize OEM ID and OEM table ID

 hw/intc/loongarch_extioi.c                | 12 ++++---
 hw/intc/loongarch_extioi_common.c         | 41 ++++++++++++++++++++++
 hw/intc/loongarch_ipi.c                   | 29 ++++++++++++++++
 hw/intc/loongarch_pch_pic.c               | 26 +++++---------
 hw/intc/loongarch_pic_common.c            | 25 +++++++++++++
 hw/loongarch/boot.c                       |  1 +
 hw/loongarch/virt-acpi-build.c            | 12 +++----
 hw/loongarch/virt.c                       | 58 +++++++++++++++++++++++++++++++
 include/hw/intc/loongarch_extioi.h        |  1 +
 include/hw/intc/loongarch_extioi_common.h |  1 +
 include/hw/intc/loongarch_ipi.h           |  1 +
 include/hw/intc/loongarch_pch_pic.h       |  1 +
 include/hw/intc/loongarch_pic_common.h    |  1 +
 tests/tcg/loongarch64/system/kernel.ld    |  2 +-
 14 files changed, 182 insertions(+), 29 deletions(-)


