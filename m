Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70137AD2FB9
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Jun 2025 10:18:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOu9t-0004nW-Or; Tue, 10 Jun 2025 04:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uOu9o-0004mX-OT
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 04:16:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uOu9m-0000Sw-35
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 04:16:32 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cxqmra6UdocH0SAQ--.4923S3;
 Tue, 10 Jun 2025 16:16:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxb8fT6UdojgwUAQ--.58593S6;
 Tue, 10 Jun 2025 16:16:26 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Qiang Ma <maqianga@uniontech.com>,
 Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 4/7] hw/loongarch/virt: inform guest of kvm
Date: Tue, 10 Jun 2025 15:53:47 +0800
Message-Id: <20250610075350.865626-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250610075350.865626-1-gaosong@loongson.cn>
References: <20250610075350.865626-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxb8fT6UdojgwUAQ--.58593S6
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

From: Qiang Ma <maqianga@uniontech.com>

Commit bab27ea2e3 ("hw/arm/virt: smbios:
inform guest of kvm") fixes the same issue
on arm.

without this patch:
[root@localhost ~]# virt-what
qemu

with this patch:
[root@localhost ~]# virt-what
kvm

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20250603031813.31794-1-maqianga@uniontech.com>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 1b504047db..a3d449ca8b 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -136,6 +136,10 @@ static void virt_build_smbios(LoongArchVirtMachineState *lvms)
         return;
     }
 
+    if (kvm_enabled()) {
+        product = "KVM Virtual Machine";
+    }
+
     smbios_set_defaults("QEMU", product, mc->name);
 
     smbios_get_tables(ms, SMBIOS_ENTRY_POINT_TYPE_64,
-- 
2.34.1


