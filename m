Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90864A95C6A
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Apr 2025 04:59:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u73pr-0003sw-16; Mon, 21 Apr 2025 22:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u73pf-0003rV-KQ
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 22:57:59 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u73pb-0001Yq-Qh
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 22:57:59 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxLGuuBQdopsPDAA--.61782S3;
 Tue, 22 Apr 2025 10:57:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxzMSmBQdo7VWPAA--.29039S8;
 Tue, 22 Apr 2025 10:57:50 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v3 6/9] target/loongarch: Define function
 loongarch_get_addr_from_tlb() non-static
Date: Tue, 22 Apr 2025 10:57:39 +0800
Message-Id: <20250422025742.2693096-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250422025742.2693096-1-maobibo@loongson.cn>
References: <20250422025742.2693096-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzMSmBQdo7VWPAA--.29039S8
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

Define function loongarch_get_addr_from_tlb() non-static, and add its
definition in header file tcg/tcg_loongarch.h

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu_helper.c        | 10 ++--------
 target/loongarch/tcg/tcg_loongarch.h | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 5db64a45cc..7636b2c265 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -11,6 +11,7 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-csr.h"
+#include "tcg/tcg_loongarch.h"
 
 #ifdef CONFIG_TCG
 static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
@@ -142,7 +143,7 @@ bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
     return false;
 }
 
-static int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
+int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
                                        int *prot, target_ulong address,
                                        MMUAccessType access_type, int mmu_idx)
 {
@@ -156,13 +157,6 @@ static int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
 
     return TLBRET_NOMATCH;
 }
-#else
-static int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
-                                       int *prot, target_ulong address,
-                                       MMUAccessType access_type, int mmu_idx)
-{
-    return TLBRET_NOMATCH;
-}
 #endif
 
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/tcg/tcg_loongarch.h
index da2539e995..69a93bfc3e 100644
--- a/target/loongarch/tcg/tcg_loongarch.h
+++ b/target/loongarch/tcg/tcg_loongarch.h
@@ -6,7 +6,23 @@
  */
 #ifndef TARGET_LOONGARCH_TCG_LOONGARCH_H
 #define TARGET_LOONGARCH_TCG_LOONGARCH_H
+#include "cpu.h"
 
 void loongarch_csr_translate_init(void);
 
+#ifdef CONFIG_TCG
+int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
+                                int *prot, target_ulong address,
+                                MMUAccessType access_type, int mmu_idx);
+#else
+static inline int loongarch_get_addr_from_tlb(CPULoongArchState *env,
+                                              hwaddr *physical,
+                                              int *prot, target_ulong address,
+                                              MMUAccessType access_type,
+                                              int mmu_idx)
+{
+    return TLBRET_NOMATCH;
+}
+#endif
+
 #endif  /* TARGET_LOONGARCH_TCG_LOONGARCH_H */
-- 
2.39.3


