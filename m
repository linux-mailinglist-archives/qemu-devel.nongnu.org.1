Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7A57E6A4B
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 13:04:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r13ih-0001pe-SH; Thu, 09 Nov 2023 07:01:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r13if-0001pA-US
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:01:09 -0500
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r13id-0001a4-Ku
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699531267; x=1731067267;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xfYdE/sfHzxpNd9P8HStTRnSBJnBgBklnuiYV/TgcRI=;
 b=bl+gHBlr5cmhlpT/a1I/Wa8+e80AwChGSumxG4qAckCt7eGVeRB/yOrG
 H3XrMuv8CJeEHahGnzDnNkOc3Qo+JoJBqBSStmO45UNHrrgyrqixI1zse
 DjsOzFAzhrayclks+ErGr/+Voa+kMOaz/q4cp4nWIPISIL922s9Dr+0D+
 yddqaIE4kGvz0uVtVEdJy5uxuclDpICwtYGehlsu03RkNG9uHLdbnzeWJ
 0Q4e5f4xEagtgFTDYCDBot2hW/DpVx3/To67fYN3oRwj1nlq3fCGcX2cZ
 rh8cNb3xxoPqGfoDTZdYbpb0vcn3zNfd/7S63vb8V0jhlDxa+aFadvlus g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="369304955"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; d="scan'208";a="369304955"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 04:01:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; d="scan'208";a="11515167"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 04:01:01 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 02/20] util/char_dev: Add open_cdev()
Date: Thu,  9 Nov 2023 19:45:11 +0800
Message-Id: <20231109114529.1904193-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
References: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
---
v5: move chardev_open.[h|c] under the IOMMUFD entry

 MAINTAINERS                 |  3 ++
 include/qemu/chardev_open.h | 16 ++++++++
 util/chardev_open.c         | 81 +++++++++++++++++++++++++++++++++++++
 util/meson.build            |  1 +
 4 files changed, 101 insertions(+)
 create mode 100644 include/qemu/chardev_open.h
 create mode 100644 util/chardev_open.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d09d19df6d..12ab8d9740 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2156,6 +2156,9 @@ M: Eric Auger <eric.auger@redhat.com>
 S: Supported
 F: backends/iommufd.c
 F: include/sysemu/iommufd.h
+F: include/qemu/chardev_open.h
+F: util/chardev_open.c
+
 
 vhost
 M: Michael S. Tsirkin <mst@redhat.com>
diff --git a/include/qemu/chardev_open.h b/include/qemu/chardev_open.h
new file mode 100644
index 0000000000..64e8fcfdcb
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
index 0000000000..f776429788
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
index c2322ef6e7..174c133368 100644
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
2.34.1


