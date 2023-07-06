Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DA37498EC
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 12:02:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHLoV-0006af-7R; Thu, 06 Jul 2023 06:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <71d72ececa086114df80fe4cc04d701b59002eb2@lizzy.crudebyte.com>)
 id 1qHLoT-0006aI-LK
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:02:13 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <71d72ececa086114df80fe4cc04d701b59002eb2@lizzy.crudebyte.com>)
 id 1qHLoR-0007m7-87
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=HHufXd/OMMSTetyFLkbhJrx/asltuYb5hxrGu0qxGkk=; b=IBoDQ
 XsAdGWp1QUMUFZK6fdGKCsjOkF4Wp4tCKvRdeL00fncH+X3QntLoxo09EuxgOvH3v7IrBUVng78I5
 Br2PNt4jqoKcfS73oNKZDhKyQydrphZUXoaeuimD02/O4bD6yAFjwqJpUNF/2HatobfCEB46WpSYN
 g03lhW+u/s5+x7ISqdx1S25kX3gpQKKKrSVjVSx5xxIPAST3zkJDb251w0TyowwLjmJZT71bM4FZd
 yt+0alk/s+TUXeWTryXRU4udbhxeJ7nxmHXaaCcOHmLkRJIXvFlSukUlm1aOguOFKbGW2mNtN5Xow
 0foGQtby2jIkZyfQINgF8xIZL+obw==;
Message-Id: <71d72ececa086114df80fe4cc04d701b59002eb2.1688637466.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1688637466.git.qemu_oss@crudebyte.com>
References: <cover.1688637466.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 06 Jul 2023 11:57:47 +0200
Subject: [PULL 1/2] 9pfs: deprecate 'proxy' backend
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=71d72ececa086114df80fe4cc04d701b59002eb2@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

As recent CVE-2023-2861 (fixed by f6b0de53fb) once again showed, the 9p
'proxy' fs driver is in bad shape. Using the 'proxy' backend was already
discouraged for safety reasons before and we recommended to use the
'local' backend (preferably in conjunction with its 'mapped' security
model) instead, but now it is time to officially deprecate the 'proxy'
backend.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <E1qDkmw-0007M1-8f@lizzy.crudebyte.com>
---
 MAINTAINERS                        |  9 ++++++++-
 docs/about/deprecated.rst          | 23 +++++++++++++++++++++++
 docs/tools/virtfs-proxy-helper.rst |  3 +++
 fsdev/qemu-fsdev.c                 |  8 ++++++++
 fsdev/virtfs-proxy-helper.c        |  9 +++++++++
 hw/9pfs/9p-proxy.c                 |  5 +++++
 hw/9pfs/9p-proxy.h                 |  5 +++++
 meson.build                        |  2 +-
 qemu-options.hx                    |  6 +++++-
 9 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7164cf55a1..80934ad2c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2124,13 +2124,20 @@ S: Odd Fixes
 W: https://wiki.qemu.org/Documentation/9p
 F: hw/9pfs/
 X: hw/9pfs/xen-9p*
+X: hw/9pfs/9p-proxy*
 F: fsdev/
-F: docs/tools/virtfs-proxy-helper.rst
+X: fsdev/virtfs-proxy-helper.c
 F: tests/qtest/virtio-9p-test.c
 F: tests/qtest/libqos/virtio-9p*
 T: git https://gitlab.com/gkurz/qemu.git 9p-next
 T: git https://github.com/cschoenebeck/qemu.git 9p.next
 
+virtio-9p-proxy
+F: hw/9pfs/9p-proxy*
+F: fsdev/virtfs-proxy-helper.c
+F: docs/tools/virtfs-proxy-helper.rst
+S: Obsolete
+
 virtio-blk
 M: Stefan Hajnoczi <stefanha@redhat.com>
 L: qemu-block@nongnu.org
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 0743459862..ddc1e48460 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -343,6 +343,29 @@ the addition of volatile memory support, it is now necessary to distinguish
 between persistent and volatile memory backends.  As such, memdev is deprecated
 in favor of persistent-memdev.
 
+``-fsdev proxy`` and ``-virtfs proxy`` (since 8.1)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The 9p ``proxy`` filesystem backend driver has been deprecated and will be
+removed (along with its proxy helper daemon) in a future version of QEMU. Please
+use ``-fsdev local`` or ``-virtfs local`` for using the 9p ``local`` filesystem
+backend, or alternatively consider deploying virtiofsd instead.
+
+The 9p ``proxy`` backend was originally developed as an alternative to the 9p
+``local`` backend. The idea was to enhance security by dispatching actual low
+level filesystem operations from 9p server (QEMU process) over to a separate
+process (the virtfs-proxy-helper binary). However this alternative never gained
+momentum. The proxy backend is much slower than the local backend, hasn't seen
+any development in years, and showed to be less secure, especially due to the
+fact that its helper daemon must be run as root, whereas with the local backend
+QEMU is typically run as unprivileged user and allows to tighten behaviour by
+mapping permissions et al by using its 'mapped' security model option.
+
+Nowadays it would make sense to reimplement the ``proxy`` backend by using
+QEMU's ``vhost`` feature, which would eliminate the high latency costs under
+which the 9p ``proxy`` backend currently suffers. However as of to date nobody
+has indicated plans for such kind of reimplemention unfortunately.
+
 
 Block device options
 ''''''''''''''''''''
diff --git a/docs/tools/virtfs-proxy-helper.rst b/docs/tools/virtfs-proxy-helper.rst
index 6cdeedf8e9..bd310ebb07 100644
--- a/docs/tools/virtfs-proxy-helper.rst
+++ b/docs/tools/virtfs-proxy-helper.rst
@@ -9,6 +9,9 @@ Synopsis
 Description
 -----------
 
+NOTE: The 9p 'proxy' backend is deprecated (since QEMU 8.1) and will be
+removed, along with this daemon, in a future version of QEMU!
+
 Pass-through security model in QEMU 9p server needs root privilege to do
 few file operations (like chown, chmod to any mode/uid:gid).  There are two
 issues in pass-through security model:
diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index 3da64e9f72..f5c953a710 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -133,6 +133,14 @@ int qemu_fsdev_add(QemuOpts *opts, Error **errp)
     }
 
     if (fsdriver) {
+        if (strncmp(fsdriver, "proxy", 5) == 0) {
+            warn_report(
+                "'-fsdev proxy' and '-virtfs proxy' are deprecated, use "
+                "'local' instead of 'proxy, or consider deploying virtiofsd "
+                "as alternative to 9p"
+            );
+        }
+
         for (i = 0; i < ARRAY_SIZE(FsDrivers); i++) {
             if (strcmp(FsDrivers[i].name, fsdriver) == 0) {
                 break;
diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
index d9511f429c..144aaf585a 100644
--- a/fsdev/virtfs-proxy-helper.c
+++ b/fsdev/virtfs-proxy-helper.c
@@ -9,6 +9,11 @@
  * the COPYING file in the top-level directory.
  */
 
+/*
+ * NOTE: The 9p 'proxy' backend is deprecated (since QEMU 8.1) and will be
+ * removed in a future version of QEMU!
+ */
+
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
 #include <sys/resource.h>
@@ -1057,6 +1062,10 @@ int main(int argc, char **argv)
     struct statfs st_fs;
 #endif
 
+    fprintf(stderr, "NOTE: The 9p 'proxy' backend is deprecated (since "
+                    "QEMU 8.1) and will be removed in a future version of "
+                    "QEMU!\n");
+
     prog_name = g_path_get_basename(argv[0]);
 
     is_daemon = true;
diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
index 99d115ff0d..905cae6992 100644
--- a/hw/9pfs/9p-proxy.c
+++ b/hw/9pfs/9p-proxy.c
@@ -15,6 +15,11 @@
  * https://wiki.qemu.org/Documentation/9p
  */
 
+/*
+ * NOTE: The 9p 'proxy' backend is deprecated (since QEMU 8.1) and will be
+ * removed in a future version of QEMU!
+ */
+
 #include "qemu/osdep.h"
 #include <sys/socket.h>
 #include <sys/un.h>
diff --git a/hw/9pfs/9p-proxy.h b/hw/9pfs/9p-proxy.h
index b84301d001..9be4718d3e 100644
--- a/hw/9pfs/9p-proxy.h
+++ b/hw/9pfs/9p-proxy.h
@@ -10,6 +10,11 @@
  * the COPYING file in the top-level directory.
  */
 
+/*
+ * NOTE: The 9p 'proxy' backend is deprecated (since QEMU 8.1) and will be
+ * removed in a future version of QEMU!
+ */
+
 #ifndef QEMU_9P_PROXY_H
 #define QEMU_9P_PROXY_H
 
diff --git a/meson.build b/meson.build
index a9ba0bfab3..b82d5b7cd0 100644
--- a/meson.build
+++ b/meson.build
@@ -4179,7 +4179,7 @@ if have_block
   summary_info += {'Block whitelist (ro)': get_option('block_drv_ro_whitelist')}
   summary_info += {'Use block whitelist in tools': get_option('block_drv_whitelist_in_tools')}
   summary_info += {'VirtFS (9P) support':    have_virtfs}
-  summary_info += {'VirtFS (9P) Proxy Helper support': have_virtfs_proxy_helper}
+  summary_info += {'VirtFS (9P) Proxy Helper support (deprecated)': have_virtfs_proxy_helper}
   summary_info += {'Live block migration': config_host_data.get('CONFIG_LIVE_BLOCK_MIGRATION')}
   summary_info += {'replication support': config_host_data.get('CONFIG_REPLICATION')}
   summary_info += {'bochs support':     get_option('bochs').allowed()}
diff --git a/qemu-options.hx b/qemu-options.hx
index b57489d7ca..3a6c7d3ef9 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1735,7 +1735,9 @@ SRST
         Accesses to the filesystem are done by QEMU.
 
     ``proxy``
-        Accesses to the filesystem are done by virtfs-proxy-helper(1).
+        Accesses to the filesystem are done by virtfs-proxy-helper(1). This
+        option is deprecated (since QEMU 8.1) and will be removed in a future
+        version of QEMU. Use ``local`` instead.
 
     ``synth``
         Synthetic filesystem, only used by QTests.
@@ -1867,6 +1869,8 @@ SRST
 
     ``proxy``
         Accesses to the filesystem are done by virtfs-proxy-helper(1).
+        This option is deprecated (since QEMU 8.1) and will be removed in a
+        future version of QEMU. Use ``local`` instead.
 
     ``synth``
         Synthetic filesystem, only used by QTests.
-- 
2.30.2


