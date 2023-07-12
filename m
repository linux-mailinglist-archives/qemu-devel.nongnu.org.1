Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF05750057
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:43:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJUTA-0006zc-NU; Wed, 12 Jul 2023 03:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJUSo-0006av-M1
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:40:44 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJUSi-0006qz-55
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689147636; x=1720683636;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=H9g5l3hj4qWFix41U6zqOzpKDRQVEwZP3YNyfk+8CgI=;
 b=O1SCOcYwYwSjBg7nV7GAXrCwNQXNnjF1pA1pmv7+0tyTTfAJ/nmvKmv8
 q9NKPRf0GMYyMQOoTWqcWghWNIZut43quB3DPVo5x3btFuB9KLgkW7jp+
 LMSbLXnmUGMTyJ7w8JEhi6HdIZBAO36gvqPAKpzBNOcHR3ERTUkWoY3ce
 1eUKZKCGANx3szkmMV+pPg8+QleSGrWh2YCGf/kINprvJ89geIRVVjOSG
 7CjTUBoJXShKo8+Cka2E+Tn88Wkle7Qsnh/220bBLD6uqRSL7QxUfFMVp
 H59UmzXe3xR6mPNW8Xs39CKPzGKlLAoiMeiFKk+8yOEqLimBy8zHe2V3v A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430953842"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="430953842"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:40:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="835024127"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="835024127"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:40:05 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, eric.auger@redhat.com, peterx@redhat.com,
 jasonwang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFC PATCH v4 19/24] util/char_dev: Add open_cdev()
Date: Wed, 12 Jul 2023 15:25:23 +0800
Message-Id: <20230712072528.275577-20-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712072528.275577-1-zhenzhong.duan@intel.com>
References: <20230712072528.275577-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mga07.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

From: Yi Liu <yi.l.liu@intel.com>

/dev/vfio/devices/vfioX may not exist. In that case it is still possible
to open /dev/char/$major:$minor instead. Add helper function to abstract
the cdev open.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 MAINTAINERS             |  6 ++++
 include/qemu/char_dev.h | 16 +++++++++++
 util/chardev_open.c     | 61 +++++++++++++++++++++++++++++++++++++++++
 util/meson.build        |  1 +
 4 files changed, 84 insertions(+)
 create mode 100644 include/qemu/char_dev.h
 create mode 100644 util/chardev_open.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 25835caf39..edecf366b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3356,6 +3356,12 @@ S: Maintained
 F: include/qemu/iova-tree.h
 F: util/iova-tree.c
 
+cdev Open
+M: Yi Liu <yi.l.liu@intel.com>
+S: Maintained
+F: include/qemu/char_dev.h
+F: util/chardev_open.c
+
 elf2dmp
 M: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
 S: Maintained
diff --git a/include/qemu/char_dev.h b/include/qemu/char_dev.h
new file mode 100644
index 0000000000..6580d351c6
--- /dev/null
+++ b/include/qemu/char_dev.h
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
+#ifndef QEMU_CHARDEV_HELPERS_H
+#define QEMU_CHARDEV_HELPERS_H
+
+int open_cdev(const char *devpath, dev_t cdev);
+#endif
diff --git a/util/chardev_open.c b/util/chardev_open.c
new file mode 100644
index 0000000000..d03e415131
--- /dev/null
+++ b/util/chardev_open.c
@@ -0,0 +1,61 @@
+/*
+ * Copyright (C) 2023 Intel Corporation.
+ * Copyright (c) 2019, Mellanox Technologies. All rights reserved.
+ *
+ * Authors: Yi Liu <yi.l.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Copied from
+ * https://github.com/linux-rdma/rdma-core/blob/master/util/open_cdev.c
+ *
+ */
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include "qemu/osdep.h"
+#include "qemu/char_dev.h"
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
+    char *devpath;
+    int ret;
+
+    /*
+     * This assumes that udev is being used and is creating the /dev/char/
+     * symlinks.
+     */
+    devpath = g_strdup_printf("/dev/char/%u:%u", major(cdev), minor(cdev));
+    ret = open_cdev_internal(devpath, cdev);
+    g_free(devpath);
+    return ret;
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
index a375160286..d5313d858f 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -107,6 +107,7 @@ if have_block
     util_ss.add(files('filemonitor-stub.c'))
   endif
   util_ss.add(when: 'CONFIG_LINUX', if_true: files('vfio-helpers.c'))
+  util_ss.add(when: 'CONFIG_LINUX', if_true: files('chardev_open.c'))
 endif
 
 if cpu == 'aarch64'
-- 
2.34.1


