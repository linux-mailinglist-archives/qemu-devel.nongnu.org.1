Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E8781902D
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:00:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfKB-0005fs-De; Tue, 19 Dec 2023 14:00:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfJD-0004iw-Oa
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:59:25 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfJ5-0007NU-Ek
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:59:15 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmFN5CbXz4xCp;
 Wed, 20 Dec 2023 05:59:04 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmFJ2qMnz4xS7;
 Wed, 20 Dec 2023 05:59:00 +1100 (AEDT)
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
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: [PULL 25/47] vfio/iommufd: Add support for iova_ranges and pgsizes
Date: Tue, 19 Dec 2023 19:56:21 +0100
Message-ID: <20231219185643.725448-26-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219185643.725448-1-clg@redhat.com>
References: <20231219185643.725448-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=7/MV=H6=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Some vIOMMU such as virtio-iommu use IOVA ranges from host side to
setup reserved ranges for passthrough device, so that guest will not
use an IOVA range beyond host support.

Use an uAPI of IOMMUFD to get IOVA ranges of host side and pass to
vIOMMU just like the legacy backend, if this fails, fallback to
64bit IOVA range.

Also use out_iova_alignment returned from uAPI as pgsizes instead of
qemu_real_host_page_size() as a fallback.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/iommufd.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 6d31aeac7bd8781a103328f8a438c011cdc2db1e..01b448e840581e0dd6d3df1897169665f79dcbe3 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -261,6 +261,53 @@ static int iommufd_cdev_ram_block_discard_disable(bool state)
     return ram_block_uncoordinated_discard_disable(state);
 }
 
+static int iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
+                                            uint32_t ioas_id, Error **errp)
+{
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+    struct iommu_ioas_iova_ranges *info;
+    struct iommu_iova_range *iova_ranges;
+    int ret, sz, fd = container->be->fd;
+
+    info = g_malloc0(sizeof(*info));
+    info->size = sizeof(*info);
+    info->ioas_id = ioas_id;
+
+    ret = ioctl(fd, IOMMU_IOAS_IOVA_RANGES, info);
+    if (ret && errno != EMSGSIZE) {
+        goto error;
+    }
+
+    sz = info->num_iovas * sizeof(struct iommu_iova_range);
+    info = g_realloc(info, sizeof(*info) + sz);
+    info->allowed_iovas = (uintptr_t)(info + 1);
+
+    ret = ioctl(fd, IOMMU_IOAS_IOVA_RANGES, info);
+    if (ret) {
+        goto error;
+    }
+
+    iova_ranges = (struct iommu_iova_range *)(uintptr_t)info->allowed_iovas;
+
+    for (int i = 0; i < info->num_iovas; i++) {
+        Range *range = g_new(Range, 1);
+
+        range_set_bounds(range, iova_ranges[i].start, iova_ranges[i].last);
+        bcontainer->iova_ranges =
+            range_list_insert(bcontainer->iova_ranges, range);
+    }
+    bcontainer->pgsizes = info->out_iova_alignment;
+
+    g_free(info);
+    return 0;
+
+error:
+    ret = -errno;
+    g_free(info);
+    error_setg_errno(errp, errno, "Cannot get IOVA ranges");
+    return ret;
+}
+
 static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
                                AddressSpace *as, Error **errp)
 {
@@ -335,7 +382,14 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         goto err_discard_disable;
     }
 
-    bcontainer->pgsizes = qemu_real_host_page_size();
+    ret = iommufd_cdev_get_info_iova_range(container, ioas_id, &err);
+    if (ret) {
+        error_append_hint(&err,
+                   "Fallback to default 64bit IOVA range and 4K page size\n");
+        warn_report_err(err);
+        err = NULL;
+        bcontainer->pgsizes = qemu_real_host_page_size();
+    }
 
     bcontainer->listener = vfio_memory_listener;
     memory_listener_register(&bcontainer->listener, bcontainer->space->as);
-- 
2.43.0


