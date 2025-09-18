Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92683B83E0A
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Sep 2025 11:45:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzBBr-0004RE-HS; Thu, 18 Sep 2025 05:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uzBBp-0004Pn-GO
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:44:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uzBBk-0003YF-Pm
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:44:33 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxVNBz1MtovMALAA--.25061S3;
 Thu, 18 Sep 2025 17:44:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxQ+Ry1Mto4ladAA--.45902S2;
 Thu, 18 Sep 2025 17:44:18 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] loongarch-to-apply queue
Date: Thu, 18 Sep 2025 17:20:44 +0800
Message-Id: <20250918092047.785269-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxQ+Ry1Mto4ladAA--.45902S2
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

The following changes since commit f0007b7f03e2d7fc33e71c3a582f2364c51a226b:

  Merge tag 'pull-target-arm-20250916' of https://gitlab.com/pm215/qemu into staging (2025-09-17 11:10:55 -0700)

are available in the Git repository at:

  https://github.com/gaosong715/qemu.git tags/pull-loongarch-20250918

for you to fetch changes up to cb5ee0017fc9909916383634a3f13eae05e6fe5c:

  hw/loongarch/virt: Register reset interface with cpu plug callback (2025-09-18 17:39:57 +0800)

----------------------------------------------------------------
pull-loongarch-20250918

----------------------------------------------------------------
Bibo Mao (3):
      hw/loongarch/virt: Add BSP support with aux boot code
      hw/loongarch/virt: Remove unnecessay pre-boot setting with BSP
      hw/loongarch/virt: Register reset interface with cpu plug callback

 hw/loongarch/boot.c    | 71 ++++++++++++++++++++++++--------------------------
 hw/loongarch/virt.c    |  2 ++
 target/loongarch/cpu.h |  4 ---
 3 files changed, 36 insertions(+), 41 deletions(-)


