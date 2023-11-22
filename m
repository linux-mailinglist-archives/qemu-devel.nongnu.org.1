Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 152F77F458D
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 13:17:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5mAb-0000j6-LW; Wed, 22 Nov 2023 07:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1r5mAT-0000WD-Lv
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 07:17:22 -0500
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1r5mAQ-0006z1-CH
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 07:17:21 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com E4668C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1700655433; bh=9h5JkieJd6des4MTrixxhp6QXlPGMGb0gNhw/rsI3hA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=HHUpoig2WLhCIjzB3OOC3NlqnR6aI/gR3gukSpJkJBb2FHqgp4t0o7sOlrT/osKh7
 RJ7c4TR2rimhwLn8eejvbt4XWzmPNPjsiKsWGeTZCtnxrL5ifuaF6kHK6Z2SqouQbZ
 +IPeYI0iLHTBnLtDNxQ11oP5EAvtAmERVc1vMYkZ+WD0Zt+vurwAALb2+YtnhitVUE
 B541zgzeATt+JKsFlb+bpwvnhKG5PQstUuURWqOuO7EQbbJWqVngdjHQuXLqP5/mb+
 MY1RPAnzvtob+QccJCQcT4EeESVGTWotMoF0/k8onCDF0LX1nsXYLnuekW9gKMM6JL
 kMScw/L9jXm+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1700655433; bh=9h5JkieJd6des4MTrixxhp6QXlPGMGb0gNhw/rsI3hA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=FCGaB2Dn1qMTBevqpaiQwfuy1rLavgG7gdTpH0LbF0gV+AehITSK1glGEqkjnMY2v
 77B7KejqdVjlUc7nb4FIPyoILnkHdx8Jh6Gj/AqLl3agqz/5X0KUUowGxQ5hRsR+U+
 33LmFEB55eKq12mIA2ydWVpBzDvJJb0+D+2SnjQp7zH08W2rpvitF2zi7MT17mmvHe
 53igHEJKeB++xf44HLQcknBO6/GHSS11TegnaDKWXyOwY0AJ54C2v8kYv6EBINzqq8
 rOlVM4OrDvn2ceFHoCTRMtHS4CcbZ50FWHAdZY8PFf8NAQB9/D6uzls4zph2V+k9sD
 ToB17e1F1E1tw==
From: Mikhail Tyutin <m.tyutin@yadro.com>
To: <qemu-devel@nongnu.org>
CC: <richard.henderson@linaro.org>, <pbonzini@redhat.com>,
 <alex.bennee@linaro.org>, Mikhail Tyutin <m.tyutin@yadro.com>
Subject: [PATCH] accel/tcg: Expose translation block flags to plugins
Date: Wed, 22 Nov 2023 15:16:55 +0300
Message-ID: <20231122121655.20818-1-m.tyutin@yadro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-06.corp.yadro.com (172.17.10.110) To
 T-EXCH-10.corp.yadro.com (172.17.11.60)
Received-SPF: pass client-ip=89.207.88.248; envelope-from=m.tyutin@yadro.com;
 helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

In system mode emulation, some of translation blocks could be
interrupted on memory I/O operation. That leads to artificial
construction of another translation block that contains memory
operation only. If TCG plugin is not aware of that TB kind, it
attempts to insert execution callbacks either on translation
block or instruction, which is silently ignored. As the result
it leads to potentially inconsistent processing of execution and
memory callbacks by the plugin.
Exposing appropriate translation block flag allows plugins to
handle "memory only" blocks in appropriate way.

Signed-off-by: Mikhail Tyutin <m.tyutin@yadro.com>
---
 include/qemu/qemu-plugin.h   | 29 ++++++++++++++++++++++++++++-
 plugins/api.c                | 14 ++++++++++++++
 plugins/qemu-plugins.symbols |  1 +
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 4daab6efd2..5f07fa497c 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -54,7 +54,7 @@ typedef uint64_t qemu_plugin_id_t;
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 1
+#define QEMU_PLUGIN_VERSION 2
 
 /**
  * struct qemu_info_t - system information for plugins
@@ -236,6 +236,21 @@ enum qemu_plugin_cb_flags {
     QEMU_PLUGIN_CB_RW_REGS,
 };
 
+/**
+ * enum qemu_plugin_tb_flags - type of translation block
+ *
+ * @QEMU_PLUGIN_TB_MEM_ONLY:
+ *  TB is special block to perform memory I/O operation only.
+ *  Block- and instruction- level callbacks have no effect.
+ * @QEMU_PLUGIN_TB_MEM_OPS:
+ *  TB has at least one instruction that access memory.
+ *  Memory callbacks are applicable to this TB.
+ */
+enum qemu_plugin_tb_flags {
+    QEMU_PLUGIN_TB_MEM_ONLY = 0x01,
+    QEMU_PLUGIN_TB_MEM_OPS = 0x02
+};
+
 enum qemu_plugin_mem_rw {
     QEMU_PLUGIN_MEM_R = 1,
     QEMU_PLUGIN_MEM_W,
@@ -360,6 +375,18 @@ size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb);
 QEMU_PLUGIN_API
 uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb);
 
+/**
+ * qemu_plugin_tb_flags() - returns combination of TB flags
+ * @tb: opaque handle to TB passed to callback
+ *
+ * Returned set of flags can be used to check if TB has a non-typical
+ * behaviour. For example: whether or not instruction execution
+ * callbacks are applicable for the block.
+ *
+ * Returns: 0 or combination of qemu_plugin_tb_flags
+ */
+int qemu_plugin_tb_flags(const struct qemu_plugin_tb *tb);
+
 /**
  * qemu_plugin_tb_get_insn() - retrieve handle for instruction
  * @tb: opaque handle to TB passed to callback
diff --git a/plugins/api.c b/plugins/api.c
index 5521b0ad36..4e73aaf422 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -37,6 +37,7 @@
 #include "qemu/osdep.h"
 #include "qemu/plugin.h"
 #include "qemu/log.h"
+#include "qemu/qemu-plugin.h"
 #include "tcg/tcg.h"
 #include "exec/exec-all.h"
 #include "exec/ram_addr.h"
@@ -193,6 +194,19 @@ uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb)
     return tb->vaddr;
 }
 
+int qemu_plugin_tb_flags(const struct qemu_plugin_tb *tb)
+{
+    int ret = 0;
+    if (tb->mem_only) {
+        ret |= QEMU_PLUGIN_TB_MEM_ONLY;
+    }
+    if (tb->mem_helper) {
+        ret |= QEMU_PLUGIN_TB_MEM_OPS;
+    }
+
+    return ret;
+}
+
 struct qemu_plugin_insn *
 qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx)
 {
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 71f6c90549..f11f633da6 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -40,6 +40,7 @@
   qemu_plugin_tb_get_insn;
   qemu_plugin_tb_n_insns;
   qemu_plugin_tb_vaddr;
+  qemu_plugin_tb_flags;
   qemu_plugin_uninstall;
   qemu_plugin_vcpu_for_each;
 };
-- 
2.34.1


