Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A4F832B86
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:44:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQq30-0005tM-5t; Fri, 19 Jan 2024 09:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2r-0005q6-1K
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:35 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2o-0003tr-La
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6AVkUode0/nFErUFeXqxbWUts2uWARq/IxNNk6oJatw=; b=RhvwCsMCzhEtIQ8fyEh8bpOIps
 kfOC4idAY8mF4Eizmz0oGyEFNr7lOo1ffnEIkqL8i1Kh+dqvjJdupkUsoBmGKT5dTfXHOWIcmKRfV
 ZyCK9FaMN9c2UuCyVGDUeh+bE9Icg8TQmn2TfGMxpw82WmqA/1jMjRPTNqoUq5+KNIdg=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 18/34] accel/stubs: [CPUTLB] Move xen.h stubs to xen-stub.c
Date: Fri, 19 Jan 2024 15:40:08 +0100
Message-ID: <20240119144024.14289-19-anjo@rev.ng>
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

Makes xen.h header independent of softmmu target.  Note:
CONFIG_XEN_IS_POSSIBLE is only used define stubs in xen.h and optimize
xen_enabled().

Required by cpu_physical_memory_set_dirty_range() in ram_addr.h.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/sysemu/xen.h   | 27 ---------------------------
 accel/stubs/xen-stub.c | 12 ++++++++++++
 2 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
index bc13ad5692..838bb5a003 100644
--- a/include/sysemu/xen.h
+++ b/include/sysemu/xen.h
@@ -12,16 +12,6 @@
 
 #include "exec/cpu-common.h"
 
-#ifdef NEED_CPU_H
-# ifdef CONFIG_XEN
-#  define CONFIG_XEN_IS_POSSIBLE
-# endif
-#else
-# define CONFIG_XEN_IS_POSSIBLE
-#endif
-
-#ifdef CONFIG_XEN_IS_POSSIBLE
-
 extern bool xen_allowed;
 
 #define xen_enabled()           (xen_allowed)
@@ -32,21 +22,4 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
                    struct MemoryRegion *mr, Error **errp);
 #endif
 
-#else /* !CONFIG_XEN_IS_POSSIBLE */
-
-#define xen_enabled() 0
-#ifndef CONFIG_USER_ONLY
-static inline void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
-{
-    /* nothing */
-}
-static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
-                                 MemoryRegion *mr, Error **errp)
-{
-    g_assert_not_reached();
-}
-#endif
-
-#endif /* CONFIG_XEN_IS_POSSIBLE */
-
 #endif
diff --git a/accel/stubs/xen-stub.c b/accel/stubs/xen-stub.c
index 7054965c48..73cfa2d291 100644
--- a/accel/stubs/xen-stub.c
+++ b/accel/stubs/xen-stub.c
@@ -14,3 +14,15 @@ bool xen_allowed;
 void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
 {
 }
+
+#ifndef CONFIG_USER_ONLY
+void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
+{
+    /* nothing */
+}
+void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
+                   MemoryRegion *mr, Error **errp)
+{
+    g_assert_not_reached();
+}
+#endif
-- 
2.43.0


