Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C13975EF1
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Sep 2024 04:37:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soZgX-000433-GM; Wed, 11 Sep 2024 22:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1soZgV-00040O-Ct
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:35:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1soZgQ-0003Wp-EP
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:35:51 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dx2ul6U+JmXmMFAA--.12520S3;
 Thu, 12 Sep 2024 10:35:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxHeR5U+JmelsEAA--.25141S2;
 Thu, 12 Sep 2024 10:35:38 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Subject: [PATCH 0/5] hw/intc/loongarch_pch: Split into pic common and
Date: Thu, 12 Sep 2024 10:35:32 +0800
Message-Id: <20240912023537.1004979-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxHeR5U+JmelsEAA--.25141S2
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

In order to support irqchip_in_kenrel method, split loongarch pch pic
driver into two parts, pic common and pic TCG driver. LoongArch pic common
driver includes vmstate and property interface, also vmstate load and
store interface is defined in pic common driver.

In future LoongArch pic kvm driver can inherit from pic common driver.

bibo mao (5):
  hw/intc/loongarch_pic: Add loongarch pch pic common driver
  hw/intc/loongarch_pch: Merge instance_init() into realize()
  include: Add loongarch_pic_common header file
  hw/intc/loongarch_pch: Inherit from loongarch_pic_common
  hw/intc/loongarch_pch: Cleanup loongarch_pch_pic

 hw/intc/loongarch_pch_pic.c            | 107 ++++++++-----------------
 hw/intc/loongarch_pic_common.c         |  97 ++++++++++++++++++++++
 hw/intc/meson.build                    |   2 +-
 hw/loongarch/virt.c                    |   2 +-
 include/hw/intc/loongarch_pch_pic.h    |  71 ++++------------
 include/hw/intc/loongarch_pic_common.h |  82 +++++++++++++++++++
 6 files changed, 231 insertions(+), 130 deletions(-)
 create mode 100644 hw/intc/loongarch_pic_common.c
 create mode 100644 include/hw/intc/loongarch_pic_common.h


base-commit: a4eb31c678400472de0b4915b9154a7c20d8332f
-- 
2.39.3


