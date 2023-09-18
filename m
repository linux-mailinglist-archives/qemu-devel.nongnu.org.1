Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC6E7A4039
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 06:55:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi6I5-00076J-Rw; Mon, 18 Sep 2023 00:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1qi6Hy-00075r-3I
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 00:55:14 -0400
Received: from mail-mw2nam12on2047.outbound.protection.outlook.com
 ([40.107.244.47] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1qi6Hv-0004dp-Qt
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 00:55:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LI2nSRbfAXo7zgbPTpAT3WYf6zfMFcwhIcTlHDpy3wl9f6vof98h+aGltlyO0twv0nkaSEik6B0+u9gQxhMO6Fb1xWfkYrFznEWkFN8m7m8rMDRmDsLzKIsIe4GpfuurPqACGBuToYboAwQPRjJKWrSZ8XLn78Q/9MqZE/qEYciq8XREo9scUl3+A6Wfrcm0J5TbjVQHNSlzbRSlyXMb0ndGoCInw0EBhwvCKnyHu3+dFjLYXcwV4Z8wTcZoAtSIZ+BRLuNicqKKUKqOLCaKMBKOft6soTMwpOWMWxaeK7eDRfdHOqK2sbvVZh4AdNARCbq/IAJEQO9shwUCpl9Wrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUyrIQETz3SMEhrkoA5qJfRqTgbj1DJqmlBH5eju3gQ=;
 b=BOrQRYreIJV06Xq06+V6FukMJffGuou/Y+IJDs+Y00UZroP3vbMdiyoDPGT4r4ZwOiX75A/9bFVSsxJDAG1X3lOtOo8WCw+UpgmybrJPQ3+b6vi/73q4WhmLX7x6SU1AFYbTLH0dsvij2t7u9PgL5780klPTIwlKwyWCq7xwF5Q4da/zE/OKX3A1RMpvIiDrtfdXRWf9BCDewfEVpBBctf7TJkMVI9AQ2k28X1FCJPky2q1LdLcb9XYFJQjEUPtcOSWpQstCOMvAXmEwUiReoaVyytdNxm+KxWh6hv8CDp7cL479K+X9m8sLEE6TvUwMQibdiQ8e2MC3qArLEFuQvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUyrIQETz3SMEhrkoA5qJfRqTgbj1DJqmlBH5eju3gQ=;
 b=NEKnSo/63BjMdKTYolfNypSKKgDWfrhqymG6ng8UnMUypotyJFKXG70rziNz5fj8Vkd8ewvKQG8bpGb5KXepuX2SswZXsfvbRmkYmNsy1B/fBRri3DoIzlQ3HEyAg27lNcTiDyYYrwPJk2GECjB7eqQUePkWYrdVd03GFYMK1rHqXc7/sC+XqlRPQp47mhQZs1DCOxUo6RFMfGOj9+bcFITDg/yB12m0Nf50W1CXgslzSJ0sut9YVW+vZD9yta0Dcd5N6joTFKtxRQKqi6Sdt/dhMo6/2B1AUMQfTMe9gv2naQzX/+40f9uCxz8WZlE5wtte48YGEVMDlWqygIdFHQ==
Received: from DM6PR02CA0083.namprd02.prod.outlook.com (2603:10b6:5:1f4::24)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 04:50:06 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::df) by DM6PR02CA0083.outlook.office365.com
 (2603:10b6:5:1f4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26 via Frontend
 Transport; Mon, 18 Sep 2023 04:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 04:50:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 17 Sep
 2023 21:49:56 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 17 Sep
 2023 21:49:54 -0700
From: Yajun Wu <yajunw@nvidia.com>
To: <qemu-devel@nongnu.org>, <jasowang@redhat.com>, <mst@redhat.com>,
 <yajunw@nvidia.com>
CC: Avihai Horon <avihaih@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [RFC PATCH 2/5] vhost: Add support for presetup
Date: Mon, 18 Sep 2023 12:49:29 +0800
Message-ID: <20230918044932.1433744-3-yajunw@nvidia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230918044932.1433744-1-yajunw@nvidia.com>
References: <20230918044932.1433744-1-yajunw@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|MN2PR12MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: 4652660a-82b0-467f-1d03-08dbb802bab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vh/dW8NqUYiW3IuhyMi9TBkJBIKzRyckejWS6w2fXBDORAs/JD6DzbrN58WpCE9B5BibQCwagjijOZnvVDi9ddkMwvbvO7x7jiV9btO0LV4JBs8Epo8woLGtexJKTucHZz/ZLiypJ63jZ7uj1t2nWjB7X/EoCeRx4JDTzErrsztMvtkPkgrzVxXhh/0jB9jcCmNzHrBhgslrZvoPx7lul4WHJrIq2PQcD0stTbxR5tMU97kfZuql0Jbayv6KWvskPpGVLSq2tkBhA32DdT6bCfKFj3j3/Ze471ht+qG6XnUyDtS8PuVf6O3eijddQ5anPvIB1OY4qhDdL2QDsoPO64Ows/2MaqwYUqumq07q0XlqwdnC949tvOYa06fkuvN/vDVAtAuPiT7CQwSoWra1vVu1U6gPiubBgJ7oK44Z6vVaOjGSB7Ty4OU9wAX1iUZ9SpLd0W1rq2CNk1I1kddBn5cLVHr4GMRaEk8JtXabXvsn/RoMvTx0aEcdwW7bjKy+EqXzcmLrx3IAR2MgHVd4zOlX7z+eBLs5cah2Zl+djyK7an236+RPJivpJxqmfiWnzXxUR1XH3qiRfUtVNx3AKVUFYHF1Kk3naGP1fZ9KRlQkLYnp8/jQ+eHg7RVByzKPOmxgCB0opPs3fwTpN5C40QdaUkruXx39zD1dQKvqZyVkYgaXx32XDVhHQ5z5kI5E8GyM/oa4d7BUF1MIdq7/BKsbV+ULvy+RIu8VURjelZPyEh53oZDT49SGrKAgcCEs
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199024)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(40480700001)(7636003)(36756003)(356005)(82740400003)(86362001)(55016003)(7049001)(40460700003)(7696005)(478600001)(5660300002)(54906003)(70206006)(70586007)(2906002)(6666004)(8676002)(8936002)(4326008)(426003)(336012)(83380400001)(47076005)(41300700001)(110136005)(36860700001)(316002)(107886003)(6286002)(26005)(16526019)(2616005)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 04:50:06.3371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4652660a-82b0-467f-1d03-08dbb802bab5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
Received-SPF: softfail client-ip=40.107.244.47; envelope-from=yajunw@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

Add New API vhost_dev_start_presetup to notify backend the start
and end of presetup.

API vhost_dev_presetup to send out the device configurations:
1. acked_features
2. memory table
3. vring information
4. disable host/guest notifier.

Signed-off-by: Yajun Wu <yajunw@nvidia.com>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 hw/virtio/vhost.c         | 166 ++++++++++++++++++++++++++++++++------
 include/hw/virtio/vhost.h |  12 +++
 2 files changed, 152 insertions(+), 26 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index e2f6ffb446..5b162590fb 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1138,24 +1138,71 @@ out:
     return ret;
 }
 
-int vhost_virtqueue_start(struct vhost_dev *dev,
-                          struct VirtIODevice *vdev,
-                          struct vhost_virtqueue *vq,
-                          unsigned idx)
+static void vhost_virtqueue_memory_unmap(struct vhost_dev *dev,
+                                         struct VirtIODevice *vdev,
+                                         struct vhost_virtqueue *vq,
+                                         unsigned idx)
+{
+    if (vq->used) {
+        vhost_memory_unmap(dev, vq->used,
+                           virtio_queue_get_used_size(vdev, idx),
+                           1, virtio_queue_get_used_size(vdev, idx));
+        vq->used = NULL;
+    }
+
+    if (vq->avail) {
+        vhost_memory_unmap(dev, vq->avail,
+                           virtio_queue_get_avail_size(vdev, idx),
+                           0, virtio_queue_get_avail_size(vdev, idx));
+        vq->avail = NULL;
+    }
+
+    if (vq->desc) {
+        vhost_memory_unmap(dev, vq->desc,
+                           virtio_queue_get_desc_size(vdev, idx),
+                           0, virtio_queue_get_desc_size(vdev, idx));
+        vq->desc = NULL;
+    }
+}
+
+static int vhost_virtqueue_disable_notify(struct vhost_dev *dev,
+                                          struct VirtIODevice *vdev,
+                                          struct vhost_virtqueue *vq,
+                                          unsigned idx)
 {
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusState *vbus = VIRTIO_BUS(qbus);
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
-    hwaddr s, l, a;
-    int r;
     int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
     struct vhost_vring_file file = {
         .index = vhost_vq_index
     };
+    int r;
+
+    file.fd = -1;
+    r = dev->vhost_ops->vhost_set_vring_kick(dev, &file);
+    if (r) {
+        VHOST_OPS_DEBUG(r, "vhost_set_vring_kick failed");
+        return r;
+    }
+
+    r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
+    if (r) {
+        VHOST_OPS_DEBUG(r, "vhost_set_vring_call failed");
+        return r;
+    }
+
+    return 0;
+}
+
+static int vhost_virtqueue_vring_setup(struct vhost_dev *dev,
+                                       struct VirtIODevice *vdev,
+                                       struct vhost_virtqueue *vq,
+                                       unsigned idx)
+{
+    hwaddr s, l, a;
+    int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
     struct vhost_vring_state state = {
         .index = vhost_vq_index
     };
-    struct VirtQueue *vvq = virtio_get_queue(vdev, idx);
+    int r;
 
     a = virtio_queue_get_desc_addr(vdev, idx);
     if (a == 0) {
@@ -1186,6 +1233,10 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
         }
     }
 
+    if (vq->desc) {
+        vhost_virtqueue_memory_unmap(dev, vdev, vq, idx);
+    }
+
     vq->desc_size = s = l = virtio_queue_get_desc_size(vdev, idx);
     vq->desc_phys = a;
     vq->desc = vhost_memory_map(dev, a, &l, false);
@@ -1212,6 +1263,36 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     if (r < 0) {
         goto fail_alloc;
     }
+    return 0;
+
+fail_alloc:
+fail_alloc_used:
+fail_alloc_avail:
+    vhost_virtqueue_memory_unmap(dev, vdev, vq, idx);
+fail_alloc_desc:
+    return r;
+}
+
+int vhost_virtqueue_start(struct vhost_dev *dev,
+                          struct VirtIODevice *vdev,
+                          struct vhost_virtqueue *vq,
+                          unsigned idx)
+{
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusState *vbus = VIRTIO_BUS(qbus);
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
+    int r;
+    int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
+    struct vhost_vring_file file = {
+        .index = vhost_vq_index
+    };
+    struct VirtQueue *vvq = virtio_get_queue(vdev, idx);
+
+    r = vhost_virtqueue_vring_setup(dev, vdev, vq, idx);
+    if (r) {
+        VHOST_OPS_DEBUG(r, "vhost_virtqueue_vring_setup failed");
+        goto fail_vring_setup;
+    }
 
     file.fd = event_notifier_get_fd(virtio_queue_get_host_notifier(vvq));
     r = dev->vhost_ops->vhost_set_vring_kick(dev, &file);
@@ -1245,16 +1326,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
 
 fail_vector:
 fail_kick:
-fail_alloc:
-    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, idx),
-                       0, 0);
-fail_alloc_used:
-    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev, idx),
-                       0, 0);
-fail_alloc_avail:
-    vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, idx),
-                       0, 0);
-fail_alloc_desc:
+    vhost_virtqueue_memory_unmap(dev, vdev, vq, idx);
+fail_vring_setup:
     return r;
 }
 
@@ -1296,12 +1369,7 @@ void vhost_virtqueue_stop(struct vhost_dev *dev,
                                                 vhost_vq_index);
     }
 
-    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, idx),
-                       1, virtio_queue_get_used_size(vdev, idx));
-    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev, idx),
-                       0, virtio_queue_get_avail_size(vdev, idx));
-    vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, idx),
-                       0, virtio_queue_get_desc_size(vdev, idx));
+    vhost_virtqueue_memory_unmap(dev, vdev, vq, idx);
 }
 
 static int vhost_virtqueue_set_busyloop_timeout(struct vhost_dev *dev,
@@ -1921,6 +1989,43 @@ static int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable)
     return hdev->vhost_ops->vhost_set_vring_enable(hdev, enable);
 }
 
+int vhost_dev_presetup(struct vhost_dev *hdev, VirtIODevice *vdev)
+{
+    int i, r;
+
+    /* should only be called after backend is connected */
+    assert(hdev->vhost_ops);
+
+    r = vhost_dev_set_features(hdev, hdev->log_enabled);
+    if (r < 0) {
+        return r;
+    }
+
+    r = hdev->vhost_ops->vhost_set_mem_table(hdev, hdev->mem);
+    if (r < 0) {
+        VHOST_OPS_DEBUG(r, "vhost_set_mem_table failed");
+        return r;
+    }
+
+    for (i = 0; i < hdev->nvqs; ++i) {
+        r = vhost_virtqueue_vring_setup(hdev, vdev,
+                                        hdev->vqs + i,
+                                        hdev->vq_index + i);
+        if (r < 0) {
+            VHOST_OPS_DEBUG(r, "vhost_virtqueue_setup failed");
+            return r;
+        }
+        r = vhost_virtqueue_disable_notify(hdev, vdev,
+                                           hdev->vqs + i,
+                                           hdev->vq_index + i);
+        if (r < 0) {
+            return r;
+        }
+    }
+
+    return 0;
+}
+
 /* Host notifiers must be enabled at this point. */
 int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
 {
@@ -2087,3 +2192,12 @@ int vhost_net_set_backend(struct vhost_dev *hdev,
 
     return -ENOSYS;
 }
+
+int vhost_dev_set_presetup_state(struct vhost_dev *hdev, bool start)
+{
+    if (!hdev->vhost_ops->vhost_presetup) {
+        return -ENOTSUP;
+    }
+
+    return hdev->vhost_ops->vhost_presetup(hdev, start);
+}
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 6a173cb9fa..95a8031d12 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -192,6 +192,17 @@ void vhost_dev_disable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev);
 bool vhost_config_pending(struct vhost_dev *hdev);
 void vhost_config_mask(struct vhost_dev *hdev, VirtIODevice *vdev, bool mask);
 
+/**
+ * vhost_dev_presetup() - pre-setup the vhost device in LM
+ * @hdev: common vhost_dev structure
+ * @vdev: the VirtIODevice structure
+ *
+ * During live migration, send out device information to backend in early
+ * running state. Backend can have enough time to prepare HW.
+ * Return: 0 on success, < 0 on error.
+ */
+int vhost_dev_presetup(struct vhost_dev *hdev, VirtIODevice *vdev);
+
 /**
  * vhost_dev_is_started() - report status of vhost device
  * @hdev: common vhost_dev structure
@@ -338,4 +349,5 @@ int vhost_dev_set_inflight(struct vhost_dev *dev,
 int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
                            struct vhost_inflight *inflight);
 bool vhost_dev_has_iommu(struct vhost_dev *dev);
+int vhost_dev_set_presetup_state(struct vhost_dev *hdev, bool start);
 #endif
-- 
2.27.0


