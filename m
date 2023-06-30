Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 725C874368E
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:09:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF92G-00084B-MA; Fri, 30 Jun 2023 03:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qF92C-00082o-UN
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qF929-0007uW-9s
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:16 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxbcdKi55kWzQEAA--.6842S3;
 Fri, 30 Jun 2023 15:59:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiNIi55kExQTAA--.24469S4; 
 Fri, 30 Jun 2023 15:59:05 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 02/46] target/loongarch: meson.build support build LASX
Date: Fri, 30 Jun 2023 15:58:20 +0800
Message-Id: <20230630075904.45940-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230630075904.45940-1-gaosong@loongson.cn>
References: <20230630075904.45940-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNIi55kExQTAA--.24469S4
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

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/insn_trans/trans_lasx.c.inc | 6 ++++++
 target/loongarch/translate.c                 | 1 +
 2 files changed, 7 insertions(+)
 create mode 100644 target/loongarch/insn_trans/trans_lasx.c.inc

diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
new file mode 100644
index 0000000000..56a9839255
--- /dev/null
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * LASX translate functions
+ * Copyright (c) 2023 Loongson Technology Corporation Limited
+ */
+
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index 3146a2d4ac..6bf2d726d6 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -220,6 +220,7 @@ static void set_fpr(int reg_num, TCGv val)
 #include "insn_trans/trans_branch.c.inc"
 #include "insn_trans/trans_privileged.c.inc"
 #include "insn_trans/trans_lsx.c.inc"
+#include "insn_trans/trans_lasx.c.inc"
 
 static void loongarch_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
-- 
2.39.1


