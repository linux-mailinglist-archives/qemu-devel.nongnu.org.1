Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 790907C9BB0
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 23:01:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs8D0-00050B-Of; Sun, 15 Oct 2023 16:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qs8Cy-0004zX-T9
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 16:59:32 -0400
Received: from hoth.uni-paderborn.de ([2001:638:502:c003::19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qs8Cx-0007SD-6e
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 16:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vg04xSTVC+8bvi0zGgGmFrrRkI8c3HuVbiNGVnW1AtY=; b=swGQQh7kCfztkGAM/HnqDdug6l
 R1OtKjBDDfFPnQH1ClOLu1QCjg/Ilc2ubxKLlbNR8oTzJtj0dG6QoFNOfVOMrAvDGWJ1rAnOoqkJQ
 027rtacDvmHV7L4ws0KttUDznIsW+F1uqDzvfDLQ2gsqCDxmF/YYwjRUjSnIFugbsAEU=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PATCH 5/6] target/tricore: Add open and creat semihosting calls
Date: Sun, 15 Oct 2023 22:59:12 +0200
Message-ID: <20231015205913.264782-6-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015205913.264782-1-kbastian@mail.uni-paderborn.de>
References: <20231015205913.264782-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.10.15.205116, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.10.8.602001
X-Sophos-SenderHistory: ip=79.202.213.239, fs=1596204, da=185012633, mc=79,
 sc=0, hc=79, sp=0, fso=1596204, re=0, sd=0, hd=0
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
 target/tricore/tricore-semi.c | 101 ++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/target/tricore/tricore-semi.c b/target/tricore/tricore-semi.c
index 2188ceeed0..34e546c3bf 100644
--- a/target/tricore/tricore-semi.c
+++ b/target/tricore/tricore-semi.c
@@ -73,6 +73,21 @@ enum {
     TARGET_ENAMETOOLONG = 9
 };
 
+enum {
+    TARGET_O_RDONLY   = 0x00001,
+    TARGET_O_WRONLY   = 0x00002,
+    TARGET_O_RDWR     = 0x00003,
+    TARGET_O_APPEND   = 0x00008,
+    TARGET_O_CREAT    = 0x00200,
+    TARGET_O_TRUNC    = 0x00400,
+    TARGET_O_EXCL     = 0x00800,
+    TARGET_O_NDELAY   = 0x01000,
+    TARGET_O_SYNC     = 0x02000,
+    TARGET_O_NONBLOCK = 0x04000,
+    TARGET_O_NOCTTY   = 0x08000,
+    TARGET_O_BINARY   = 0x10000,
+};
+
 static int
 tricore_vio_errno_h2g(int host_errno)
 {
@@ -152,6 +167,49 @@ tricore_vio_errno_h2g(int host_errno)
     }
 }
 
+static int tricore_vio_open_flags_g2h(int guest_flags)
+{
+    int host_flags = guest_flags & 0x3;
+    if (guest_flags & TARGET_O_APPEND) {
+        host_flags |= O_APPEND;
+    }
+
+    if (guest_flags & TARGET_O_CREAT) {
+        host_flags |= O_CREAT;
+    }
+
+    if (guest_flags & TARGET_O_TRUNC) {
+        host_flags |= O_TRUNC;
+    }
+
+    if (guest_flags & TARGET_O_EXCL) {
+        host_flags |= O_EXCL;
+    }
+
+    if (guest_flags & TARGET_O_NDELAY) {
+        host_flags |= O_NDELAY;
+    }
+
+    if (guest_flags & TARGET_O_SYNC) {
+        host_flags |= O_SYNC;
+    }
+
+    if (guest_flags & TARGET_O_NONBLOCK) {
+        host_flags |= O_NONBLOCK;
+    }
+
+    if (guest_flags & TARGET_O_NOCTTY) {
+        host_flags |= O_NOCTTY;
+    }
+#ifdef O_BINARY
+    if (guest_flags & TARGET_O_BINARY) {
+        host_flags |= O_BINARY;
+    }
+#endif
+
+    return host_flags;
+}
+
 /*
  * Set return and errno values;  the ___virtio function takes care
  * that the target's errno variable gets updated from %d12, and
@@ -164,6 +222,43 @@ static void tricore_vio_set_result(CPUTriCoreState *env, int retval,
     env->gpr_d[12] = tricore_vio_errno_h2g(host_errno);
 }
 
+static void tricore_vio_opencreat(CPUTriCoreState *env, bool do_creat)
+{
+    CPUState *cs = env_cpu(env);
+    char name[1024];
+    int rc, i, res;
+    uint32_t nameptr = env->gpr_a[4];
+    for (i = 0; i < ARRAY_SIZE(name); ++i) {
+        rc = cpu_memory_rw_debug(cs, nameptr + i, (uint8_t *)name + i, 1, 0);
+        if (rc != 0 || name[i] == 0) {
+            break;
+        }
+    }
+
+    if (rc == 0 && i < ARRAY_SIZE(name)) {
+        if (do_creat) {
+            /* Infineon's TSIM hardcodes 'mode' */
+            res = creat(name, S_IROTH | S_IRUSR | S_IWUSR | S_IRGRP);
+        } else {
+            int flags = tricore_vio_open_flags_g2h(env->gpr_d[4]);
+            res = open(name, flags);
+        }
+        tricore_vio_set_result(env, res, errno);
+    } else {
+        tricore_vio_set_result(env, -1, EIO);
+    }
+}
+
+static void tricore_vio_open(CPUTriCoreState *env)
+{
+    tricore_vio_opencreat(env, false);
+}
+
+static void tricore_vio_creat(CPUTriCoreState *env)
+{
+    tricore_vio_opencreat(env, true);
+}
+
 static void tricore_vio_close(CPUTriCoreState *env)
 {
     int fd = env->gpr_d[4];
@@ -258,6 +353,9 @@ void helper_tricore_semihost(CPUTriCoreState *env, uint32_t pc)
 
     syscall = (int)env->gpr_d[12];
     switch (syscall) {
+    case SYS__OPEN:
+        tricore_vio_open(env);
+        break;
     case SYS__CLOSE:
         tricore_vio_close(env);
         break;
@@ -270,6 +368,9 @@ void helper_tricore_semihost(CPUTriCoreState *env, uint32_t pc)
     case SYS__WRITE:
         tricore_vio_write(env);
         break;
+    case SYS__CREAT:
+        tricore_vio_creat(env);
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s(%d): not implemented\n", __func__,
                       syscall);
-- 
2.42.0


