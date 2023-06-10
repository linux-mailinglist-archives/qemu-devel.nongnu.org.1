Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 262DE72ABD7
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:46:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yv1-0001Ng-4R; Sat, 10 Jun 2023 09:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <6da2d83e900a42d067cff38aee9d064cda6427cc@lizzy.crudebyte.com>)
 id 1q7yuy-0001Mt-7C
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 09:46:12 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <6da2d83e900a42d067cff38aee9d064cda6427cc@lizzy.crudebyte.com>)
 id 1q7yuu-0001N8-W3
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 09:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Message-Id:Cc:To:Subject:Date:From:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=0y3svgKdLUZb7L6Ar9r+lInvBXxx/WbSr/sS+RK2m2w=; b=hWifz
 /EOyHgjiM9Kn9D1I3KC8ZuoKYAHN6EZeKgWthiBVGSSAsgQdx4VKayLSkiKMJEjC6aVa419aJBgU6
 1/6/UlB96ZLEgSXTr9mE8LXpHkZ8N89WybuVoaqyIRcdGfcYlq7do4/ZVK+nnhjxwMX9ZE0T7zDeF
 i7wsM+yg6dxd2LW+6hquzqyBLA419It00zXMJB9A1UAAmBdgMzW7neNkO0VnbTA0WI/4zLQJQ6oYP
 6Oo45h3IipZCSmSCfG0saGBJLNIsUUFBIWvWoNe7EnVfTN8DOteAheHCYcMDhOc64sagRgz9seId6
 3kDQjK4cz2JCr8n4+zy45863b5STw==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 10 Jun 2023 15:39:44 +0200
Subject: [PATCH v3] 9pfs: deprecate 'proxy' backend
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Message-Id: <E1q7ytt-0005Fl-JX@lizzy.crudebyte.com>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=6da2d83e900a42d067cff38aee9d064cda6427cc@lizzy.crudebyte.com;
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

As recent CVE-2023-2861 once again showed, the 9p 'proxy' fs driver is in
bad shape. Using the 'proxy' backend was already discouraged for safety
reasons before and we recommended to use the 'local' backend instead,
but now it is time to officially deprecate the 'proxy' backend.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 v2 -> v3:
 * Fix copy wasted typo (-> 'backend').

 MAINTAINERS                        |  7 +++++++
 docs/about/deprecated.rst          | 17 +++++++++++++++++
 docs/tools/virtfs-proxy-helper.rst |  3 +++
 fsdev/qemu-fsdev.c                 |  5 +++++
 fsdev/virtfs-proxy-helper.c        |  5 +++++
 hw/9pfs/9p-proxy.c                 |  5 +++++
 hw/9pfs/9p-proxy.h                 |  5 +++++
 meson.build                        |  2 +-
 qemu-options.hx                    |  6 +++++-
 softmmu/vl.c                       |  5 +++++
 10 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 436b3f0afe..185d694b2e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2118,13 +2118,20 @@ S: Odd Fixes
 W: https://wiki.qemu.org/Documentation/9p
 F: hw/9pfs/
 X: hw/9pfs/xen-9p*
+X: hw/9pfs/9p-proxy*
 F: fsdev/
+X: fsdev/virtfs-proxy-helper.c
 F: docs/tools/virtfs-proxy-helper.rst
 F: tests/qtest/virtio-9p-test.c
 F: tests/qtest/libqos/virtio-9p*
 T: git https://gitlab.com/gkurz/qemu.git 9p-next
 T: git https://github.com/cschoenebeck/qemu.git 9p.next
 
+virtio-9p-proxy
+F: hw/9pfs/9p-proxy*
+F: fsdev/virtfs-proxy-helper.c
+S: Obsolete
+
 virtio-blk
 M: Stefan Hajnoczi <stefanha@redhat.com>
 L: qemu-block@nongnu.org
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 0743459862..9b2c780365 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -343,6 +343,23 @@ the addition of volatile memory support, it is now necessary to distinguish
 between persistent and volatile memory backends.  As such, memdev is deprecated
 in favor of persistent-memdev.
 
+``-fsdev proxy`` and ``-virtfs proxy`` (since 8.1)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The 9p ``proxy`` filesystem backend driver has been deprecated and will be
+removed in a future version of QEMU. Please use ``-fsdev local`` or
+``-virtfs local`` for using the ``local`` 9p filesystem backend instead.
+
+The 9p ``proxy`` backend was originally developed as an alternative to the 9p
+``local`` backend. The idea was to enhance security by dispatching actual low
+level filesystem operations from 9p server (QEMU process) over to a separate
+process (the virtfs-proxy-helper binary). However this alternative never gained
+momentum. The proxy backend is much slower than the local backend, hasn't seen
+any development in years, and showed to be less secure, especially due to the
+fact that its helper daemon must be run as root, whereas with the local backend
+QEMU is typically run as unprivileged user and allows to tighten behaviour by
+mapping permissions et al.
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
index 3da64e9f72..242f54ab49 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -133,6 +133,11 @@ int qemu_fsdev_add(QemuOpts *opts, Error **errp)
     }
 
     if (fsdriver) {
+        if (strncmp(fsdriver, "proxy", 5) == 0) {
+            warn_report("'-fsdev proxy' is deprecated, use '-fsdev local' "
+                        "instead");
+        }
+
         for (i = 0; i < ARRAY_SIZE(FsDrivers); i++) {
             if (strcmp(FsDrivers[i].name, fsdriver) == 0) {
                 break;
diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
index d9511f429c..5dd5d99284 100644
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
index 34306a6205..05c01b72bb 100644
--- a/meson.build
+++ b/meson.build
@@ -4170,7 +4170,7 @@ if have_block
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
diff --git a/softmmu/vl.c b/softmmu/vl.c
index b0b96f67fa..e60648b591 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -3102,6 +3102,11 @@ void qemu_init(int argc, char **argv)
                     error_report("Usage: -virtfs fsdriver,mount_tag=tag");
                     exit(1);
                 }
+                if (strncmp(qemu_opt_get(opts, "fsdriver"), "proxy", 5) == 0) {
+                    warn_report("'-virtfs proxy' is deprecated, use "
+                                "'-virtfs local' instead");
+                }
+
                 fsdev = qemu_opts_create(qemu_find_opts("fsdev"),
                                          qemu_opts_id(opts) ?:
                                          qemu_opt_get(opts, "mount_tag"),
-- 
2.30.2


