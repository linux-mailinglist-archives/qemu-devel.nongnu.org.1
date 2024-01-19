Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D1E832B72
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:42:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQq2y-0005qA-9h; Fri, 19 Jan 2024 09:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2e-0005mQ-P3
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:20 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2b-0003TL-Gq
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qXOq/h6phsa/tEESVpy5xNTXbPzc//D/ihwH2veRNU8=; b=EWahrOkuQ1I7Hi3RtRzClONnGs
 hFDhsMo4OCCj9XR8NNDfTG+RiTFtaFnwtvocWFUv1LMWxpNcmDeHnhwIVl3T56jBYV2hSZKhLxeEF
 aOlVTHILN0E2PhwVB0saFt/Y7pNekvmq6CpaVWm+BK8Vg5+quAUPjnf+y9gjJ5grcHtE=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 06/34] exec: [VADDR] Move vaddr defines to separate file
Date: Fri, 19 Jan 2024 15:39:56 +0100
Message-ID: <20240119144024.14289-7-anjo@rev.ng>
In-Reply-To: <20240119144024.14289-1-anjo@rev.ng>
References: <20240119144024.14289-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Needed to work around circular includes. vaddr is currently defined in
cpu-common.h and needed by hw/core/cpu.h, but cpu-common.h also need
cpu.h to know the size of the CPUState.

[Maybe we can instead move parts of cpu-common.h w. hw/core/cpu.h to
sort out the circular inclusion.]

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/exec/cpu-common.h | 12 ------------
 include/exec/vaddr.h      | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 12 deletions(-)
 create mode 100644 include/exec/vaddr.h

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index df53252d51..c071f1a003 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -14,18 +14,6 @@
 #define EXCP_YIELD      0x10004 /* cpu wants to yield timeslice to another */
 #define EXCP_ATOMIC     0x10005 /* stop-the-world and emulate atomic */
 
-/**
- * vaddr:
- * Type wide enough to contain any #target_ulong virtual address.
- */
-typedef uint64_t vaddr;
-#define VADDR_PRId PRId64
-#define VADDR_PRIu PRIu64
-#define VADDR_PRIo PRIo64
-#define VADDR_PRIx PRIx64
-#define VADDR_PRIX PRIX64
-#define VADDR_MAX UINT64_MAX
-
 /**
  * Variable page size macros
  *
diff --git a/include/exec/vaddr.h b/include/exec/vaddr.h
new file mode 100644
index 0000000000..db48bb16bc
--- /dev/null
+++ b/include/exec/vaddr.h
@@ -0,0 +1,18 @@
+/* Define vaddr if it exists.  */
+
+#ifndef VADDR_H
+#define VADDR_H
+
+/**
+ * vaddr:
+ * Type wide enough to contain any #target_ulong virtual address.
+ */
+typedef uint64_t vaddr;
+#define VADDR_PRId PRId64
+#define VADDR_PRIu PRIu64
+#define VADDR_PRIo PRIo64
+#define VADDR_PRIx PRIx64
+#define VADDR_PRIX PRIX64
+#define VADDR_MAX UINT64_MAX
+
+#endif
-- 
2.43.0


