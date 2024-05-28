Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5098D167E
	for <lists+qemu-devel@lfdr.de>; Tue, 28 May 2024 10:40:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBsMP-0002lE-HE; Tue, 28 May 2024 04:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sBsMM-0002hp-Mn
 for qemu-devel@nongnu.org; Tue, 28 May 2024 04:39:06 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sBsMK-0004oS-68
 for qemu-devel@nongnu.org; Tue, 28 May 2024 04:39:06 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxW+ogmFVmpJwAAA--.2405S3;
 Tue, 28 May 2024 16:38:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxosQfmFVmQcYLAA--.20131S2; 
 Tue, 28 May 2024 16:38:55 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org
Subject: [PATCH v4 0/3] Add extioi virt extension support
Date: Tue, 28 May 2024 16:38:52 +0800
Message-Id: <20240528083855.1912757-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxosQfmFVmQcYLAA--.20131S2
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

On LoongArch, IRQs can be routed to four vcpus with hardware extioi.
This patch adds the extioi virt extension support so that the IRQ can
route to 256 vcpus.

v4:
- Put patch3 ahead of patch2;
- patch1 Introduce two IRQ model(Extended IRQ model and Virt extended IRQ model);
- Link to v3: https://patchew.org/QEMU/20240521123225.231072-1-gaosong@loongson.cn/

v3:
- Split patch2 to two small patch.
- remove unused code.
- loongarch_extioi_reset() clear status without checking virt extioi
  features.
- Link to v2: https://patchew.org/QEMU/20240514090756.988096-1-gaosong@loongson.cn/

v2:
- Split the patch to two small patch.
- Drop 'RFC' title. extioi virt extension suport only enable on kvm
  mode and  the extioi driver need patch[1].
  but this series do not affect the old codes in any way.
- Link to v1: https://lore.kernel.org/all/20240116022526.498613-1-gaosong@loongson.cn/#r

[1]: https://gitee.com/openeuler/kernel/commit/5d97cff72f91f4f20a536efd60eca75bfcb78a64

Thanks.
Song Gao

Song Gao (3):
  hw/intc/loongarch_extioi: Add extioi virt extension definition
  hw/loongarch/virt: Use MemTxAttrs interface for misc ops
  hw/loongarch/virt: Enable extioi virt extension

 include/hw/intc/loongarch_extioi.h |  21 ++++
 include/hw/loongarch/virt.h        |   1 +
 target/loongarch/cpu.h             |   1 +
 hw/intc/loongarch_extioi.c         |  88 +++++++++++++-
 hw/loongarch/virt.c                | 182 +++++++++++++++++++++++------
 5 files changed, 256 insertions(+), 37 deletions(-)

-- 
2.34.1


