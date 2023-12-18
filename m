Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 332D7816AB9
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 11:14:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFAdW-0003n6-Vv; Mon, 18 Dec 2023 05:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rFAdV-0003ms-2p
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 05:14:09 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rFAdI-0004K2-V4
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 05:14:08 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8E964482EE;
 Mon, 18 Dec 2023 11:13:46 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sw@weilnetz.de, t.lamprecht@proxmox.com,
 berrange@redhat.com
Subject: [PATCH v2] qemu_init: increase NOFILE soft limit on POSIX
Date: Mon, 18 Dec 2023 11:13:40 +0100
Message-Id: <20231218101340.35053-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
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

In many configurations, e.g. multiple vNICs with multiple queues or
with many Ceph OSDs, the default soft limit of 1024 is not enough.
QEMU is supposed to work fine with file descriptors >= 1024 and does
not use select() on POSIX. Bump the soft limit to the allowed hard
limit to avoid issues with the aforementioned configurations.

Of course the limit could be raised from the outside, but the man page
of systemd.exec states about 'LimitNOFILE=':

> Don't use.
> [...]
> Typically applications should increase their soft limit to the hard
> limit on their own, if they are OK with working with file
> descriptors above 1023,

If the soft limit is already the same as the hard limit, avoid the
superfluous setrlimit call. This can avoid a warning with a strict
seccomp filter blocking setrlimit if NOFILE was already raised before
executing QEMU.

Buglink: https://bugzilla.proxmox.com/show_bug.cgi?id=4507
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v2:
    * avoid the redundant setrlimit call when cur == max

 include/sysemu/os-posix.h |  1 +
 include/sysemu/os-win32.h |  5 +++++
 os-posix.c                | 22 ++++++++++++++++++++++
 system/vl.c               |  2 ++
 4 files changed, 30 insertions(+)

diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
index dff32ae185..b881ac6c6f 100644
--- a/include/sysemu/os-posix.h
+++ b/include/sysemu/os-posix.h
@@ -51,6 +51,7 @@ bool is_daemonized(void);
 void os_daemonize(void);
 bool os_set_runas(const char *user_id);
 void os_set_chroot(const char *path);
+void os_setup_limits(void);
 void os_setup_post(void);
 int os_mlock(void);
 
diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
index 1047d260cb..106f155037 100644
--- a/include/sysemu/os-win32.h
+++ b/include/sysemu/os-win32.h
@@ -128,6 +128,11 @@ static inline int os_mlock(void)
     return -ENOSYS;
 }
 
+void os_setup_limits(void)
+{
+    return;
+}
+
 #define fsync _commit
 
 #if !defined(lseek)
diff --git a/os-posix.c b/os-posix.c
index 52ef6990ff..a4284e2c07 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include <sys/resource.h>
 #include <sys/wait.h>
 #include <pwd.h>
 #include <grp.h>
@@ -256,6 +257,27 @@ void os_daemonize(void)
     }
 }
 
+void os_setup_limits(void)
+{
+    struct rlimit nofile;
+
+    if (getrlimit(RLIMIT_NOFILE, &nofile) < 0) {
+        warn_report("unable to query NOFILE limit: %s", strerror(errno));
+        return;
+    }
+
+    if (nofile.rlim_cur == nofile.rlim_max) {
+        return;
+    }
+
+    nofile.rlim_cur = nofile.rlim_max;
+
+    if (setrlimit(RLIMIT_NOFILE, &nofile) < 0) {
+        warn_report("unable to set NOFILE limit: %s", strerror(errno));
+        return;
+    }
+}
+
 void os_setup_post(void)
 {
     int fd = 0;
diff --git a/system/vl.c b/system/vl.c
index 2bcd9efb9a..6f42f37200 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2774,6 +2774,8 @@ void qemu_init(int argc, char **argv)
     error_init(argv[0]);
     qemu_init_exec_dir(argv[0]);
 
+    os_setup_limits();
+
     qemu_init_arch_modules();
 
     qemu_init_subsystems();
-- 
2.39.2



