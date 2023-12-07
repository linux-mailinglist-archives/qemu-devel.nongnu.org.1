Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C5B809090
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:51:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJSJ-0003ZT-Mn; Thu, 07 Dec 2023 13:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJSB-0003XM-Ba
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:31 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJS9-0006pB-3M
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:30 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7IJWaO006793; Thu, 7 Dec 2023 18:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=1qvAaetJbXbQEOsr+WeZTRGtI7xnUOGqRF8vnQO8kGM=;
 b=T77LF37L05otH+CIttKOwHPIxTBLkd3+rBS5EGqHCaRm3kCna9qtGu+QU4rkY6Y1Se1h
 55uwT6HVhYu7jL/msADehEWlkUF+TaXOvz0FAw2ZRUqvE618pDng2z7RT4ffxf0zr0xT
 rmkPq4DZvrkdZTbXoPTALXqfLNzAscj7+cRfALKsz5SajZk3QeS+RzwwPOxyd1HL3wXT
 R5IEOl2ZsufuX+0r8d2lfjkwzJ6u1P2ZlkY3f2fnCPgjy0anRTINbNIbOaUKeP75bv7b
 TZjLEfSItyFyD+zd/WIQTqXlHXtVXLgJJIqzAtpK8GlnDUKIAmvVMJElxumpX/9vIyAG xQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdabvgdh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:27 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7IZbmR039504; Thu, 7 Dec 2023 18:50:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vhjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:26 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io90C008067;
 Thu, 7 Dec 2023 18:50:26 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-11; Thu, 07 Dec 2023 18:50:25 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 10/40] vdpa: assign svq descriptors a separate ASID when
 possible
Date: Thu,  7 Dec 2023 09:39:23 -0800
Message-Id: <1701970793-6865-11-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_15,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070156
X-Proofpoint-ORIG-GUID: bJLr1SmqAfSzL3C9-fvdQ3nlQTxtaNzC
X-Proofpoint-GUID: bJLr1SmqAfSzL3C9-fvdQ3nlQTxtaNzC
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When backend supports the VHOST_BACKEND_F_DESC_ASID feature
and all the data vqs can support one or more descriptor group
to host SVQ vrings and descriptors, we assign them a different
ASID than where its buffers reside in guest memory address
space. With this dedicated ASID for SVQs, the IOVA for what
vdpa device may care effectively becomes the GPA, thus there's
no need to translate IOVA address. For this reason, shadow_data
can be turned off accordingly. It doesn't mean the SVQ is not
enabled, but just that the translation is not needed from iova
tree perspective.

We can reuse CVQ's address space ID to host SVQ descriptors
because both CVQ and SVQ are emulated in the same QEMU
process, which will share the same VA address space.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 hw/virtio/vhost-vdpa.c |  5 ++++-
 net/vhost-vdpa.c       | 57 ++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 24844b5..30dff95 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -627,6 +627,7 @@ static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque, Error **errp)
     uint64_t qemu_backend_features = 0x1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2 |
                                      0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH |
                                      0x1ULL << VHOST_BACKEND_F_IOTLB_ASID |
+                                     0x1ULL << VHOST_BACKEND_F_DESC_ASID |
                                      0x1ULL << VHOST_BACKEND_F_SUSPEND;
     int ret;
 
@@ -1249,7 +1250,9 @@ static bool vhost_vdpa_svqs_start(struct vhost_dev *dev)
             goto err;
         }
 
-        vhost_svq_start(svq, dev->vdev, vq, v->shared->iova_tree);
+        vhost_svq_start(svq, dev->vdev, vq,
+                        v->desc_group >= 0 && v->address_space_id ?
+                        NULL : v->shared->iova_tree);
         ok = vhost_vdpa_svq_map_rings(dev, svq, &addr, &err);
         if (unlikely(!ok)) {
             goto err_map;
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 2555897..aebaa53 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -366,20 +366,50 @@ static int vhost_vdpa_set_address_space_id(struct vhost_vdpa *v,
 static void vhost_vdpa_net_data_start_first(VhostVDPAState *s)
 {
     struct vhost_vdpa *v = &s->vhost_vdpa;
+    int r;
 
     migration_add_notifier(&s->migration_state,
                            vdpa_net_migration_state_notifier);
 
+    if (!v->shadow_vqs_enabled) {
+        if (v->desc_group >= 0 &&
+            v->address_space_id != VHOST_VDPA_GUEST_PA_ASID) {
+            vhost_vdpa_set_address_space_id(v, v->desc_group,
+                                            VHOST_VDPA_GUEST_PA_ASID);
+            s->vhost_vdpa.address_space_id = VHOST_VDPA_GUEST_PA_ASID;
+        }
+        return;
+    }
+
     /* iova_tree may be initialized by vhost_vdpa_net_load_setup */
-    if (v->shadow_vqs_enabled && !v->shared->iova_tree) {
+    if (!v->shared->iova_tree) {
         v->shared->iova_tree = vhost_iova_tree_new(v->shared->iova_range.first,
                                                    v->shared->iova_range.last);
     }
+
+    if (s->always_svq || v->desc_group < 0) {
+        return;
+    }
+
+    r = vhost_vdpa_set_address_space_id(v, v->desc_group,
+                                        VHOST_VDPA_NET_CVQ_ASID);
+    if (unlikely(r < 0)) {
+        /* The other data vqs should also fall back to using the same ASID */
+        s->vhost_vdpa.address_space_id = VHOST_VDPA_GUEST_PA_ASID;
+        return;
+    }
+
+    /* No translation needed on data SVQ when descriptor group is used */
+    s->vhost_vdpa.address_space_id = VHOST_VDPA_NET_CVQ_ASID;
+    s->vhost_vdpa.shared->shadow_data = false;
+    return;
 }
 
 static int vhost_vdpa_net_data_start(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
+    VhostVDPAState *s0 = vhost_vdpa_net_first_nc_vdpa(s);
+
     struct vhost_vdpa *v = &s->vhost_vdpa;
 
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
@@ -397,6 +427,18 @@ static int vhost_vdpa_net_data_start(NetClientState *nc)
         return 0;
     }
 
+    if (v->desc_group >= 0 && v->desc_group != s0->vhost_vdpa.desc_group) {
+        unsigned asid;
+        asid = v->shadow_vqs_enabled ?
+            s0->vhost_vdpa.address_space_id : VHOST_VDPA_GUEST_PA_ASID;
+        if (asid != s->vhost_vdpa.address_space_id) {
+            vhost_vdpa_set_address_space_id(v, v->desc_group, asid);
+        }
+        s->vhost_vdpa.address_space_id = asid;
+    } else {
+        s->vhost_vdpa.address_space_id = s0->vhost_vdpa.address_space_id;
+    }
+
     return 0;
 }
 
@@ -603,13 +645,19 @@ static int vhost_vdpa_net_cvq_start(NetClientState *nc)
         return 0;
     }
 
-    if (!s->cvq_isolated) {
+    if (!s->cvq_isolated && v->desc_group < 0) {
+        if (s0->vhost_vdpa.shadow_vqs_enabled &&
+            s0->vhost_vdpa.desc_group >= 0 &&
+            s0->vhost_vdpa.address_space_id) {
+            v->shadow_vqs_enabled = false;
+        }
         return 0;
     }
 
-    cvq_group = vhost_vdpa_get_vring_group(v->shared->device_fd,
+    cvq_group = s->cvq_isolated ?
+                vhost_vdpa_get_vring_group(v->shared->device_fd,
                                            v->dev->vq_index_end - 1,
-                                           &err);
+                                           &err) : v->desc_group;
     if (unlikely(cvq_group < 0)) {
         error_report_err(err);
         return cvq_group;
@@ -1840,6 +1888,7 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
     s->always_svq = svq;
     s->migration_state.notify = NULL;
     s->vhost_vdpa.shadow_vqs_enabled = svq;
+    s->vhost_vdpa.address_space_id = VHOST_VDPA_GUEST_PA_ASID;
     if (queue_pair_index == 0) {
         vhost_vdpa_net_valid_svq_features(features,
                                           &s->vhost_vdpa.migration_blocker);
-- 
1.8.3.1


