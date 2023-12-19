Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BF9819032
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:01:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfJY-0004Xe-VB; Tue, 19 Dec 2023 13:59:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfIq-0004Ch-BQ
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:58:53 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfIm-0007Lj-J3
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:58:52 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmF05XDcz4xCp;
 Wed, 20 Dec 2023 05:58:44 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmDv648xz4xS5;
 Wed, 20 Dec 2023 05:58:39 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Yi Liu <yi.l.liu@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: [PULL 21/47] util/char_dev: Add open_cdev()
Date: Tue, 19 Dec 2023 19:56:17 +0100
Message-ID: <20231219185643.725448-22-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219185643.725448-1-clg@redhat.com>
References: <20231219185643.725448-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=7/MV=H6=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Yi Liu <yi.l.liu@intel.com>

/dev/vfio/devices/vfioX may not exist. In that case it is still possible
to open /dev/char/$major:$minor instead. Add helper function to abstract
the cdev open.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS                 |  2 +
 include/qemu/chardev_open.h | 16 ++++++++
 util/chardev_open.c         | 81 +++++++++++++++++++++++++++++++++++++
 util/meson.build            |  1 +
 4 files changed, 100 insertions(+)
 create mode 100644 include/qemu/chardev_open.h
 create mode 100644 util/chardev_open.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a5a446914a1cf505131bfe113540fd501511abb8..ca70bb4e6415fc3af110cc7fd37ac67be5ab8c9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2174,6 +2174,8 @@ M: Zhenzhong Duan <zhenzhong.duan@intel.com>
 S: Supported
 F: backends/iommufd.c
 F: include/sysemu/iommufd.h
+F: include/qemu/chardev_open.h
+F: util/chardev_open.c
 
 vhost
 M: Michael S. Tsirkin <mst@redhat.com>
diff --git a/include/qemu/chardev_open.h b/include/qemu/chardev_open.h
new file mode 100644
index 0000000000000000000000000000000000000000..64e8fcfdcb239e47774d55dfc57efff9101ce0a8
--- /dev/null
+++ b/include/qemu/chardev_open.h
@@ -0,0 +1,16 @@
+/*
+ * QEMU Chardev Helper
+ *
+ * Copyright (C) 2023 Intel Corporation.
+ *
+ * Authors: Yi Liu <yi.l.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_CHARDEV_OPEN_H
+#define QEMU_CHARDEV_OPEN_H
+
+int open_cdev(const char *devpath, dev_t cdev);
+#endif
diff --git a/util/chardev_open.c b/util/chardev_open.c
new file mode 100644
index 0000000000000000000000000000000000000000..f7764297882f59411c81b304a1ab5d16e903a389
--- /dev/null
+++ b/util/chardev_open.c
@@ -0,0 +1,81 @@
+/*
+ * Copyright (c) 2019, Mellanox Technologies. All rights reserved.
+ * Copyright (C) 2023 Intel Corporation.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *      Redistribution and use in source and binary forms, with or
+ *      without modification, are permitted provided that the following
+ *      conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Authors: Yi Liu <yi.l.liu@intel.com>
+ *
+ * Copied from
+ * https://github.com/linux-rdma/rdma-core/blob/master/util/open_cdev.c
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/chardev_open.h"
+
+static int open_cdev_internal(const char *path, dev_t cdev)
+{
+    struct stat st;
+    int fd;
+
+    fd = qemu_open_old(path, O_RDWR);
+    if (fd == -1) {
+        return -1;
+    }
+    if (fstat(fd, &st) || !S_ISCHR(st.st_mode) ||
+        (cdev != 0 && st.st_rdev != cdev)) {
+        close(fd);
+        return -1;
+    }
+    return fd;
+}
+
+static int open_cdev_robust(dev_t cdev)
+{
+    g_autofree char *devpath = NULL;
+
+    /*
+     * This assumes that udev is being used and is creating the /dev/char/
+     * symlinks.
+     */
+    devpath = g_strdup_printf("/dev/char/%u:%u", major(cdev), minor(cdev));
+    return open_cdev_internal(devpath, cdev);
+}
+
+int open_cdev(const char *devpath, dev_t cdev)
+{
+    int fd;
+
+    fd = open_cdev_internal(devpath, cdev);
+    if (fd == -1 && cdev != 0) {
+        return open_cdev_robust(cdev);
+    }
+    return fd;
+}
diff --git a/util/meson.build b/util/meson.build
index c2322ef6e71a1de643d44dd3ad4bad497bc975ec..174c133368a8584315f488786a3d4b59f6cede80 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -108,6 +108,7 @@ if have_block
     util_ss.add(files('filemonitor-stub.c'))
   endif
   util_ss.add(when: 'CONFIG_LINUX', if_true: files('vfio-helpers.c'))
+  util_ss.add(when: 'CONFIG_LINUX', if_true: files('chardev_open.c'))
 endif
 
 if cpu == 'aarch64'
-- 
2.43.0


