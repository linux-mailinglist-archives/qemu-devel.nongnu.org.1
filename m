Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 600B282C282
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 16:07:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOJ6e-0001Oh-Uv; Fri, 12 Jan 2024 10:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJ69-00010y-Kx
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:05:31 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJ63-0003bw-FB
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:05:28 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40CEXr8E005084; Fri, 12 Jan 2024 15:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=s/SAKt3XssQ6p3fTa6H9EIpUq4lNmkqEKGi4ePzQbi4=;
 b=YY0miYTUFDq1IAODkDe+BuslI095OgwolA+vqlcczVEE6PkidOD4V8wEe6E8Ie41vlRH
 694btaalJEHVbiNq4Ty+9t8akg3XJbZK5JxhHsWegrj8DaucfCZg42T8/VGFbRRgzZwJ
 gOtwHnCS1tfShhYdQ7QYaiVXdgj31gG5FSMfkOV/ALnt8OvMH00lvuyIx1iVo61IdonG
 1ZAVqIxD8CRqYbqUNXGCMR3gv6F58I5ey6Dcp+AIL/Rzpn2pNfkWfvwaRL67U3Wre4cg
 McMSJ3Amtyt8HvAZAaGGBgE54k8NkFM6OjKHiJnzIbLzIUwMclcnugWiZ/swSsY1LwRX IA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vk6afg6ad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:05:20 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40CEQLWE014088; Fri, 12 Jan 2024 15:05:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfurgd8sm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:05:19 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40CF5BoQ017833;
 Fri, 12 Jan 2024 15:05:18 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3vfurgd8k6-11; Fri, 12 Jan 2024 15:05:18 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 10/11] vfio: register container for cpr
Date: Fri, 12 Jan 2024 07:05:09 -0800
Message-Id: <1705071910-174321-11-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
References: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-12_06,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401120117
X-Proofpoint-ORIG-GUID: 8QZIWXJpJKc4YPNhZrxmliKr14eUBmHY
X-Proofpoint-GUID: 8QZIWXJpJKc4YPNhZrxmliKr14eUBmHY
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Define entry points to perform per-container cpr-specific initialization
and teardown.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/container.c           | 11 ++++++++++-
 hw/vfio/cpr.c                 | 19 +++++++++++++++++++
 hw/vfio/meson.build           |  1 +
 include/hw/vfio/vfio-common.h |  3 +++
 4 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 hw/vfio/cpr.c

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index bd25b9f..33a64bc 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -621,10 +621,15 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         goto free_container_exit;
     }
 
+    ret = vfio_cpr_register_container(container, errp);
+    if (ret) {
+        goto free_container_exit;
+    }
+
     ret = vfio_ram_block_discard_disable(container, true);
     if (ret) {
         error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
-        goto free_container_exit;
+        goto unregister_container_exit;
     }
 
     assert(bcontainer->ops->setup);
@@ -667,6 +672,9 @@ listener_release_exit:
 enable_discards_exit:
     vfio_ram_block_discard_disable(container, false);
 
+unregister_container_exit:
+    vfio_cpr_unregister_container(container);
+
 free_container_exit:
     g_free(container);
 
@@ -710,6 +718,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
         vfio_container_destroy(bcontainer);
 
         trace_vfio_disconnect_container(container->fd);
+        vfio_cpr_unregister_container(container);
         close(container->fd);
         g_free(container);
 
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
new file mode 100644
index 0000000..bbd1c7a
--- /dev/null
+++ b/hw/vfio/cpr.c
@@ -0,0 +1,19 @@
+/*
+ * Copyright (c) 2021-2024 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/vfio/vfio-common.h"
+#include "qapi/error.h"
+
+int vfio_cpr_register_container(VFIOContainer *container, Error **errp)
+{
+    return 0;
+}
+
+void vfio_cpr_unregister_container(VFIOContainer *container)
+{
+}
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index bb98493..bba776f 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -5,6 +5,7 @@ vfio_ss.add(files(
   'container-base.c',
   'container.c',
   'migration.c',
+  'cpr.c',
 ))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
 vfio_ss.add(when: 'CONFIG_IOMMUFD', if_true: files(
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 4a6c262..1add5b7 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -205,6 +205,9 @@ void vfio_detach_device(VFIODevice *vbasedev);
 int vfio_kvm_device_add_fd(int fd, Error **errp);
 int vfio_kvm_device_del_fd(int fd, Error **errp);
 
+int vfio_cpr_register_container(VFIOContainer *container, Error **errp);
+void vfio_cpr_unregister_container(VFIOContainer *container);
+
 extern const MemoryRegionOps vfio_region_ops;
 typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
-- 
1.8.3.1


