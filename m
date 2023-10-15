Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5520E7C9BAB
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 23:00:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs8Cx-0004yo-S4; Sun, 15 Oct 2023 16:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qs8Cv-0004yc-6f
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 16:59:29 -0400
Received: from hoth.uni-paderborn.de ([2001:638:502:c003::19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qs8Cs-0007RS-GJ
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 16:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fECGx6bLgz/u26aTDexJ1KMd0hIX/TG2tinE+ED9B8Y=; b=RthRaz5BpmnUf1tBnVGl7QFEGF
 Eqhdbun5cMlUCa57oYzV9jbyOOFEQSFUagWzV9xqWLqPf+xbIE6ieQrQROH0uTYNbjPyH8l/etojK
 KSnBtTHaTKGzCFtsrKemmw46xHZf9H84+qXDIKm8/NwxEh9++Ifdf1LP4mhR1HAGPsws=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PATCH 1/6] target/tricore: Add semihosting stub
Date: Sun, 15 Oct 2023 22:59:08 +0200
Message-ID: <20231015205913.264782-2-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015205913.264782-1-kbastian@mail.uni-paderborn.de>
References: <20231015205913.264782-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.10.15.205116, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.10.8.602001
X-Sophos-SenderHistory: ip=79.202.213.239, fs=1596196, da=185012625, mc=73,
 sc=0, hc=73, sp=0, fso=1596196, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::19;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=hoth.uni-paderborn.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/helper.h       |   1 +
 target/tricore/meson.build    |   1 +
 target/tricore/tricore-semi.c | 197 ++++++++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+)
 create mode 100644 target/tricore/tricore-semi.c

diff --git a/target/tricore/helper.h b/target/tricore/helper.h
index 1d97d078b0..587de1e06f 100644
--- a/target/tricore/helper.h
+++ b/target/tricore/helper.h
@@ -160,3 +160,4 @@ DEF_HELPER_2(psw_write, void, env, i32)
 DEF_HELPER_1(psw_read, i32, env)
 /* Exceptions */
 DEF_HELPER_3(raise_exception_sync, noreturn, env, i32, i32)
+DEF_HELPER_2(tricore_semihost, void, env, i32)
diff --git a/target/tricore/meson.build b/target/tricore/meson.build
index 45f49f0128..6cfc9355b7 100644
--- a/target/tricore/meson.build
+++ b/target/tricore/meson.build
@@ -6,6 +6,7 @@ tricore_ss.add(files(
   'op_helper.c',
   'translate.c',
   'gdbstub.c',
+  'tricore-semi.c',
 ))
 tricore_ss.add(zlib)
 
diff --git a/target/tricore/tricore-semi.c b/target/tricore/tricore-semi.c
new file mode 100644
index 0000000000..27e1bdc59d
--- /dev/null
+++ b/target/tricore/tricore-semi.c
@@ -0,0 +1,197 @@
+/*
+ *  Copyright (c) 2023 Bastian Koppelmann
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/cpu_ldst.h"
+#include "exec/helper-proto.h"
+#include "exec/helper-gen.h"
+#include "qemu/log.h"
+
+enum {
+    SYS__OPEN        = 0x01,
+    SYS__CLOSE       = 0x02,
+    SYS__LSEEK       = 0x03,
+    SYS__READ        = 0x04,
+    SYS__WRITE       = 0x05,
+    SYS__CREAT       = 0x06,
+    SYS__UNLINK      = 0x07,
+    SYS__STAT        = 0x08,
+    SYS__FSTAT       = 0x09,
+    SYS__GETTIME     = 0x0a,
+};
+
+enum {
+    TARGET_EPERM        = 1,
+    TARGET_ENOENT       = 2,
+    TARGET_ESRCH        = 3,
+    TARGET_EINTR        = 4,
+    TARGET_EIO          = 5,
+    TARGET_ENXIO        = 6,
+    TARGET_E2BIG        = 7,
+    TARGET_ENOEXEC      = 8,
+    TARGET_EBADF        = 9,
+    TARGET_ECHILD       = 10,
+    TARGET_EAGAIN       = 11,
+    TARGET_ENOMEM       = 12,
+    TARGET_EACCES       = 13,
+    TARGET_EFAULT       = 14,
+    TARGET_ENOTBLK      = 15,
+    TARGET_EBUSY        = 16,
+    TARGET_EEXIST       = 17,
+    TARGET_EXDEV        = 18,
+    TARGET_ENODEV       = 19,
+    TARGET_ENOTDIR      = 20,
+    TARGET_EISDIR       = 21,
+    TARGET_EINVAL       = 22,
+    TARGET_ENFILE       = 23,
+    TARGET_EMFILE       = 24,
+    TARGET_ENOTTY       = 25,
+    TARGET_ETXTBSY      = 26,
+    TARGET_EFBIG        = 27,
+    TARGET_ENOSPC       = 28,
+    TARGET_ESPIPE       = 29,
+    TARGET_EROFS        = 30,
+    TARGET_EMLINK       = 31,
+    TARGET_EPIPE        = 32,
+    TARGET_ENOSYS       = 88,
+    TARGET_ENOTEMPTY    = 90,
+    TARGET_ENAMETOOLONG = 9
+};
+
+static int
+tricore_vio_errno_h2g(int host_errno)
+{
+    switch (host_errno) {
+    case EPERM:
+        return TARGET_EPERM;
+    case ENOENT:
+        return TARGET_ENOENT;
+    case ESRCH:
+        return TARGET_ESRCH;
+    case EINTR:
+        return TARGET_EINTR;
+    case EIO:
+        return TARGET_EIO;
+    case ENXIO:
+        return TARGET_ENXIO;
+    case E2BIG:
+        return TARGET_E2BIG;
+    case ENOEXEC:
+        return TARGET_ENOEXEC;
+    case EBADF:
+        return TARGET_EBADF;
+    case ECHILD:
+        return TARGET_ECHILD;
+    case EAGAIN:
+        return TARGET_EAGAIN;
+    case ENOMEM:
+        return TARGET_ENOMEM;
+    case EACCES:
+        return TARGET_EACCES;
+    case EFAULT:
+        return TARGET_EFAULT;
+    case ENOTBLK:
+        return TARGET_ENOTBLK;
+    case EBUSY:
+        return TARGET_EBUSY;
+    case EEXIST:
+        return TARGET_EEXIST;
+    case EXDEV:
+        return TARGET_EXDEV;
+    case ENODEV:
+        return TARGET_ENODEV;
+    case ENOTDIR:
+        return TARGET_ENOTDIR;
+    case EISDIR:
+        return TARGET_EISDIR;
+    case EINVAL:
+        return TARGET_EINVAL;
+    case ENFILE:
+        return TARGET_ENFILE;
+    case EMFILE:
+        return TARGET_EMFILE;
+    case ENOTTY:
+        return TARGET_ENOTTY;
+    case ETXTBSY:
+        return TARGET_ETXTBSY;
+    case EFBIG:
+        return TARGET_EFBIG;
+    case ENOSPC:
+        return TARGET_ENOSPC;
+    case ESPIPE:
+        return TARGET_ESPIPE;
+    case EROFS:
+        return TARGET_EROFS;
+    case EMLINK:
+        return TARGET_EMLINK;
+    case EPIPE:
+        return TARGET_EPIPE;
+    case ENOSYS:
+        return TARGET_ENOSYS;
+    case ENOTEMPTY:
+        return TARGET_ENOTEMPTY;
+    case ENAMETOOLONG:
+        return TARGET_ENAMETOOLONG;
+    default:
+        return host_errno;
+    }
+}
+
+/*
+ * Set return and errno values;  the ___virtio function takes care
+ * that the target's errno variable gets updated from %d12, and
+ * eventually moves %d11 to the return register (%d2).
+ */
+static void tricore_vio_set_result(CPUTriCoreState *env, int retval,
+                                   int host_errno)
+{
+    env->gpr_d[11] = retval;
+    env->gpr_d[12] = tricore_vio_errno_h2g(host_errno);
+}
+
+
+#define TRICORE_VIO_MARKER 0x6f69765f /* "_vio" */
+#define TRICORE_VIO_EXIT_MARKER 0xE60
+#define TRICORE_VIO_SIMTEST_SUCC 0x900d
+void helper_tricore_semihost(CPUTriCoreState *env, uint32_t pc)
+{
+    int syscall;
+    uint32_t marker = cpu_ldl_code(env, pc - 4);
+
+    /* check for exit marker */
+    if (extract32(marker, 0, 12) == TRICORE_VIO_EXIT_MARKER) {
+        if (env->gpr_a[14] == TRICORE_VIO_SIMTEST_SUCC) {
+            exit(0);
+        } else {
+            exit(env->gpr_a[14]);
+        }
+    }
+
+    if (marker != TRICORE_VIO_MARKER) {
+        return;
+    }
+
+    syscall = (int)env->gpr_d[12];
+    switch (syscall) {
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s(%d): not implemented\n", __func__,
+                      syscall);
+        tricore_vio_set_result(env, -1, ENOSYS);
+        break;
+    }
+}
-- 
2.42.0


