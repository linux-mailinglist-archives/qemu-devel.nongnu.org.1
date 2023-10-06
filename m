Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D37387BB3FE
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:11:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qognx-00011J-36; Fri, 06 Oct 2023 05:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognf-0008Qi-NL
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:07:11 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qognd-00014V-7h
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:07:10 -0400
Received: (qmail 20012 invoked by uid 484); 6 Oct 2023 09:06:57 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 4e-06 secs); 06 Oct 2023 09:06:57 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:56 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 26/29] moved all mcd related header files into
 include/mcdstub
Date: Fri,  6 Oct 2023 11:06:07 +0200
Message-Id: <20231006090610.26171-27-nicolas.eder@lauterbach.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006090610.26171-1-nicolas.eder@lauterbach.com>
References: <20231006090610.26171-1-nicolas.eder@lauterbach.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Qmail-Scanner-2.11: added fake Content-Type header
Content-Type: text/plain
Received-SPF: pass client-ip=62.154.241.196;
 envelope-from=nicolas.eder@lauterbach.com; helo=smtp1.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: neder <nicolas.eder@lauterbach.com>

---
 target/arm/mcdstub.h => include/mcdstub/arm_mcdstub.h | 2 +-
 {mcdstub => include/mcdstub}/mcd_shared_defines.h     | 0
 {mcdstub => include/mcdstub}/mcdstub.h                | 0
 {mcdstub => include/mcdstub}/mcdstub_common.h         | 0
 mcdstub/mcd_syscalls.c                                | 2 +-
 mcdstub/mcdstub.c                                     | 6 +++---
 target/arm/mcdstub.c                                  | 3 ++-
 7 files changed, 7 insertions(+), 6 deletions(-)
 rename target/arm/mcdstub.h => include/mcdstub/arm_mcdstub.h (99%)
 rename {mcdstub => include/mcdstub}/mcd_shared_defines.h (100%)
 rename {mcdstub => include/mcdstub}/mcdstub.h (100%)
 rename {mcdstub => include/mcdstub}/mcdstub_common.h (100%)

diff --git a/target/arm/mcdstub.h b/include/mcdstub/arm_mcdstub.h
similarity index 99%
rename from target/arm/mcdstub.h
rename to include/mcdstub/arm_mcdstub.h
index daba7a04d7..3db271150a 100644
--- a/target/arm/mcdstub.h
+++ b/include/mcdstub/arm_mcdstub.h
@@ -2,7 +2,7 @@
 #define ARM_MCDSTUB_H
 
 #include "hw/core/cpu.h"
-#include "mcdstub/mcdstub_common.h"
+#include "mcdstub_common.h"
 /* just used for the register xml files */
 #include "exec/gdbstub.h"
 
diff --git a/mcdstub/mcd_shared_defines.h b/include/mcdstub/mcd_shared_defines.h
similarity index 100%
rename from mcdstub/mcd_shared_defines.h
rename to include/mcdstub/mcd_shared_defines.h
diff --git a/mcdstub/mcdstub.h b/include/mcdstub/mcdstub.h
similarity index 100%
rename from mcdstub/mcdstub.h
rename to include/mcdstub/mcdstub.h
diff --git a/mcdstub/mcdstub_common.h b/include/mcdstub/mcdstub_common.h
similarity index 100%
rename from mcdstub/mcdstub_common.h
rename to include/mcdstub/mcdstub_common.h
diff --git a/mcdstub/mcd_syscalls.c b/mcdstub/mcd_syscalls.c
index eaa6853335..e363a249ca 100644
--- a/mcdstub/mcd_syscalls.c
+++ b/mcdstub/mcd_syscalls.c
@@ -3,7 +3,7 @@
 #include "semihosting/semihost.h"
 #include "sysemu/runstate.h"
 #include "mcdstub/syscalls.h"
-#include "mcdstub.h"
+#include "mcdstub/mcdstub.h"
 
 typedef struct {
     char syscall_buf[256];
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index a468a7d7b8..4f9fafe749 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -25,11 +25,11 @@
 #include "monitor/monitor.h"
 
 /* mcdstub header files */
-#include "mcd_shared_defines.h"
-#include "mcdstub.h"
+#include "mcdstub/mcd_shared_defines.h"
+#include "mcdstub/mcdstub.h"
 
 /* architecture specific stubs */
-#include "target/arm/mcdstub.h"
+#include "mcdstub/arm_mcdstub.h"
 
 typedef struct {
     CharBackend chr;
diff --git a/target/arm/mcdstub.c b/target/arm/mcdstub.c
index 6c98c34673..1b82b9d439 100644
--- a/target/arm/mcdstub.c
+++ b/target/arm/mcdstub.c
@@ -4,7 +4,8 @@
 #include "sysemu/tcg.h"
 #include "internals.h"
 #include "cpregs.h"
-#include "mcdstub.h"
+
+#include "mcdstub/arm_mcdstub.h"
 
 static inline int mcd_get_reg32(GByteArray *buf, uint32_t val)
 {
-- 
2.34.1


