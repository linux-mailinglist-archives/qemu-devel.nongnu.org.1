Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F39A8B43BF6
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Sep 2025 14:45:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu9IJ-0004ql-TE; Thu, 04 Sep 2025 08:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uu9IF-0004pB-NM
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 08:42:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uu9I8-0007uz-KY
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 08:42:23 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxztIfiblo8qkGAA--.13969S3;
 Thu, 04 Sep 2025 20:42:07 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCxdOQbiblo4QJ+AA--.6028S5;
 Thu, 04 Sep 2025 20:42:07 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v6 03/11] hw/loongarch: add misc register supoort avecintc
Date: Thu,  4 Sep 2025 20:18:32 +0800
Message-Id: <20250904121840.2023683-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250904121840.2023683-1-gaosong@loongson.cn>
References: <20250904121840.2023683-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxdOQbiblo4QJ+AA--.6028S5
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

Add feature register and misc register for avecintc feature checking and
setting

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 1a2aa92c25..124f96af03 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -560,6 +560,10 @@ static MemTxResult virt_iocsr_misc_write(void *opaque, hwaddr addr,
             return MEMTX_OK;
         }
 
+        if (val & BIT(IOCSRM_AVEC_EN)) {
+            lvms->misc_status |= BIT(IOCSRM_AVEC_EN);
+        }
+
         features = address_space_ldl(&lvms->as_iocsr,
                                      EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
                                      attrs, NULL);
@@ -595,6 +599,9 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
         break;
     case FEATURE_REG:
         ret = BIT(IOCSRF_MSI) | BIT(IOCSRF_EXTIOI) | BIT(IOCSRF_CSRIPI);
+        if (virt_has_avecintc(lvms)) {
+            ret |= BIT(IOCSRF_AVEC);
+        }
         if (kvm_enabled()) {
             ret |= BIT(IOCSRF_VM);
         }
@@ -624,6 +631,10 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
         if (features & BIT(EXTIOI_ENABLE_INT_ENCODE)) {
             ret |= BIT_ULL(IOCSRM_EXTIOI_INT_ENCODE);
         }
+        if (virt_has_avecintc(lvms) &&
+            (lvms->misc_status & BIT(IOCSRM_AVEC_EN))) {
+            ret |= BIT_ULL(IOCSRM_AVEC_EN);
+        }
         break;
     default:
         g_assert_not_reached();
-- 
2.41.0


