Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1117A402D
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 06:51:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi6DH-0003PV-Dq; Mon, 18 Sep 2023 00:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1qi6DB-0003PG-JZ
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 00:50:17 -0400
Received: from mail-dm6nam10on20627.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::627]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1qi6D7-0003ca-Jv
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 00:50:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsQf+AYnIPKe9110bw0vYisIqlXcglkTbZXdRc9Za00dnX1biODPJg14FhMXMKR79H+2JBM8MP+o3OSoAXLIRqySzj3nZ+WjC7OVqb2tUahky4MMy6hX83frr5TkvE0F8tuYbREvPY9yYrV89fWlgWJqvtLWEERvrNYyYVhJeBFBIF9FOlILFKPhbkFiCS17o+KklqXOpb1u3tK5xtIeIILtfJptI98KgRzeySMantRc8e7U56/GWhs5myS2SopXN/41a7nSiH/TDj465AMzH2HQsiaT6AXfoDo7jDvYMeyZ0azWJyS6Il/KRq2KbjMi+MlSHuoJT8n5RiFdOWafSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zc94vzKvovPU3QIUbycGTkCqSy0UJtxZMcuTJ1j+Fd8=;
 b=MVRt0KrAbXk2wnvtQ8w5pPmDaqK8deLuD8Io4sXTJ6mRdQS2ieKQVlRBGSOj0cQOur4MjIn1h9RP2DebyYVCSOBCuzr3DCEVdUqcQeNwzT4pswBO4UcrzjWTeXryYWU5p17FTFotDWCItevR3UOGx+vfIZhElyyREMPB0VJxPk+OmML0kbo0EV8U3IlPyE5K3L9MzCA93mgpqFD51cDmRocwIofL76jHKhoJziYKf1Jcoa6D1/sh2Bx+aF30yxpokmyWD/xWhU/BxK+pn/YlsOu8cmZPYyg+5e+bivwRrS7U7PFB3wFn6XS1uAaEG81OwxnowXPJVMWOtZu1AR61ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zc94vzKvovPU3QIUbycGTkCqSy0UJtxZMcuTJ1j+Fd8=;
 b=HQ9aL0tvXMQBUQAVVmy+bE7VVPnbSsE1S27qZmL8P20hFYRiQjLSCsHgszT43BjkAbRNyRJ6ONbZlgHfGAbXcGfRWyMC5rit5TOsqj75xTyoekPqsFf+jrHxWaBoRfsSXR81ucTDI1+fALA0G46NGRv9RR5j54/NvENDrfyKohVCHGxi1yOFGNLnASxu3Z8sIvaU7gBs7/IhxLCShfQTbbgtZOhPXAo92GEne2kBYZaGpw90qN31KndvXvDj1Lo+DGwo90rDr9iV3mNvLlKDmpQyi357MvmSV9FvulGxL/7PiJFoceFNTSq9+japZ2/djiEusisrwUidWCqbkjFtjA==
Received: from CY5PR22CA0012.namprd22.prod.outlook.com (2603:10b6:930:16::32)
 by IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 04:50:08 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:16:cafe::3c) by CY5PR22CA0012.outlook.office365.com
 (2603:10b6:930:16::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26 via Frontend
 Transport; Mon, 18 Sep 2023 04:50:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 04:50:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 17 Sep
 2023 21:50:01 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 17 Sep
 2023 21:49:59 -0700
From: Yajun Wu <yajunw@nvidia.com>
To: <qemu-devel@nongnu.org>, <jasowang@redhat.com>, <mst@redhat.com>,
 <yajunw@nvidia.com>
CC: Avihai Horon <avihaih@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [RFC PATCH 4/5] virtio: Add VMState for early load
Date: Mon, 18 Sep 2023 12:49:31 +0800
Message-ID: <20230918044932.1433744-5-yajunw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|IA1PR12MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 317d5241-e2a9-460b-996b-08dbb802bb59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nkr3bO3lNmYEwNgaJbpVwii5XzRiqhWRzNyozMAvw+ov4Uc7Jc67BjcJGO9pmVCNYzl2xW7mvYT6/ZzEFdFg2VSZgTa5q4k1UGsqkj37srLJP0r/5W6PxSz3PwLuSjQKWpssVrZ2e/+Yvg8wUmig3YoksqfuuDSi9J89aU9Y92+FmzewqPvMcvqX5tBdQMaG8QQ9gqZZsU9ilhPmzM71HZxPQiNYVMn8h0pILcSiy23pKr7cUxlT+lsn64UdjR3iq7FqbzIJ7oFzisFDm0LjfDR66E7Lw+DqJ7zLqUrzmmLarWYhnht3z2sCxbHygbgi+LGllIuObP67bN1VdnhOCtzAos1JfwpbvwIGlddeDz6JGyO89WZEbE0Z9zy4Q8rqTyEtS2Txu2EH7WhhWiDYqPTqYs5/6pk8XzYZwhZNN8Qgm4Gmps1mPeGo76B2hJZAaMDimCgXtrcBYbj9QXszL7/ekNwM/a1JBmc8+u4uGj2iP3y7WlO4JC1piXdxpD4s6pc1/0WOT6eB8Mn9Wemf6PT1rzUJEgTRZlIPxksehZO3dp86TeLlVT6AEGTokNiBbGwzjD5zLH5ddLdC7G+pvTPdJoCNSby1pd6YYuWc7thjiTRs/pN7RRea5FaWy3X92DuIstjSC85e+fMH1DbC+CtHY678QfGncQuf5x1raaTlYOgFgC7bHznSySqDpSUOu7ZJTk2cXyxuuLHBOWPKLml34lBsiWe1JPVGtTeUtr+u5pPgRSkRpDLIXEWjqr/v
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(82310400011)(1800799009)(186009)(451199024)(46966006)(40470700004)(36840700001)(7049001)(6666004)(7696005)(478600001)(26005)(6286002)(1076003)(16526019)(2616005)(107886003)(336012)(426003)(47076005)(2906002)(316002)(70206006)(54906003)(70586007)(110136005)(41300700001)(4326008)(8676002)(8936002)(5660300002)(40460700003)(82740400003)(356005)(36860700001)(40480700001)(36756003)(86362001)(7636003)(55016003)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 04:50:07.4620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 317d5241-e2a9-460b-996b-08dbb802bb59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078
Received-SPF: softfail client-ip=2a01:111:f400:7e88::627;
 envelope-from=yajunw@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Define new virtio device vmstate for early save/load (happens in
LM setup stage). Same as original vmstate, except:

In LM setup phase of the destination VM, the guest memory has not
been synchronized yet. To address this, a flag has been added to
virtio_load function to skip the index check.

Signed-off-by: Yajun Wu <yajunw@nvidia.com>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 hw/virtio/virtio.c         | 152 +++++++++++++++++++++++--------------
 include/hw/virtio/virtio.h |  10 ++-
 2 files changed, 103 insertions(+), 59 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 969c25f4cf..8c73c245dd 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2832,7 +2832,17 @@ virtio_device_get(QEMUFile *f, void *opaque, size_t size,
     VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
     DeviceClass *dc = DEVICE_CLASS(VIRTIO_DEVICE_GET_CLASS(vdev));
 
-    return virtio_load(vdev, f, dc->vmsd->version_id);
+    return virtio_load(vdev, f, dc->vmsd->version_id, false);
+}
+
+/* A wrapper for use as a VMState .get function */
+static int virtio_early_device_get(QEMUFile *f, void *opaque, size_t size,
+                                      const VMStateField *field)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
+    DeviceClass *dc = DEVICE_CLASS(VIRTIO_DEVICE_GET_CLASS(vdev));
+
+    return virtio_load(vdev, f, dc->vmsd->version_id, true);
 }
 
 const VMStateInfo  virtio_vmstate_info = {
@@ -2841,6 +2851,12 @@ const VMStateInfo  virtio_vmstate_info = {
     .put = virtio_device_put,
 };
 
+const VMStateInfo virtio_early_vmstate_info = {
+    .name = "virtio-early",
+    .get = virtio_early_device_get,
+    .put = virtio_device_put,
+};
+
 static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t val)
 {
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
@@ -2940,8 +2956,75 @@ size_t virtio_get_config_size(const VirtIOConfigSizeParams *params,
     return config_size;
 }
 
+static int virtio_load_check_index(VirtIODevice *vdev, int num)
+{
+    int i;
+
+    RCU_READ_LOCK_GUARD();
+
+    for (i = 0; i < num; i++) {
+        if (vdev->vq[i].vring.desc) {
+            uint16_t nheads;
+
+            /*
+             * VIRTIO-1 devices migrate desc, used, and avail ring addresses so
+             * only the region cache needs to be set up.  Legacy devices need
+             * to calculate used and avail ring addresses based on the desc
+             * address.
+             */
+            if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+                virtio_init_region_cache(vdev, i);
+            } else {
+                virtio_queue_update_rings(vdev, i);
+            }
+
+            if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+                vdev->vq[i].shadow_avail_idx = vdev->vq[i].last_avail_idx;
+                vdev->vq[i].shadow_avail_wrap_counter =
+                                        vdev->vq[i].last_avail_wrap_counter;
+                continue;
+            }
+
+            nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
+            /* Check it isn't doing strange things with descriptor numbers. */
+            if (nheads > vdev->vq[i].vring.num) {
+                virtio_error(vdev, "VQ %d size 0x%x Guest index 0x%x "
+                             "inconsistent with Host index 0x%x: delta 0x%x",
+                             i, vdev->vq[i].vring.num,
+                             vring_avail_idx(&vdev->vq[i]),
+                             vdev->vq[i].last_avail_idx, nheads);
+                vdev->vq[i].used_idx = 0;
+                vdev->vq[i].shadow_avail_idx = 0;
+                vdev->vq[i].inuse = 0;
+                continue;
+            }
+            vdev->vq[i].used_idx = vring_used_idx(&vdev->vq[i]);
+            vdev->vq[i].shadow_avail_idx = vring_avail_idx(&vdev->vq[i]);
+
+            /*
+             * Some devices migrate VirtQueueElements that have been popped
+             * from the avail ring but not yet returned to the used ring.
+             * Since max ring size < UINT16_MAX it's safe to use modulo
+             * UINT16_MAX + 1 subtraction.
+             */
+            vdev->vq[i].inuse = (uint16_t)(vdev->vq[i].last_avail_idx -
+                                vdev->vq[i].used_idx);
+            if (vdev->vq[i].inuse > vdev->vq[i].vring.num) {
+                error_report("VQ %d size 0x%x < last_avail_idx 0x%x - "
+                             "used_idx 0x%x",
+                             i, vdev->vq[i].vring.num,
+                             vdev->vq[i].last_avail_idx,
+                             vdev->vq[i].used_idx);
+                return -1;
+            }
+        }
+    }
+
+    return 0;
+}
+
 int coroutine_mixed_fn
-virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
+virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id, bool early)
 {
     int i, ret;
     int32_t config_len;
@@ -3078,62 +3161,15 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         vdev->start_on_kick = true;
     }
 
-    RCU_READ_LOCK_GUARD();
-    for (i = 0; i < num; i++) {
-        if (vdev->vq[i].vring.desc) {
-            uint16_t nheads;
-
-            /*
-             * VIRTIO-1 devices migrate desc, used, and avail ring addresses so
-             * only the region cache needs to be set up.  Legacy devices need
-             * to calculate used and avail ring addresses based on the desc
-             * address.
-             */
-            if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-                virtio_init_region_cache(vdev, i);
-            } else {
-                virtio_queue_update_rings(vdev, i);
-            }
-
-            if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
-                vdev->vq[i].shadow_avail_idx = vdev->vq[i].last_avail_idx;
-                vdev->vq[i].shadow_avail_wrap_counter =
-                                        vdev->vq[i].last_avail_wrap_counter;
-                continue;
-            }
-
-            nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
-            /* Check it isn't doing strange things with descriptor numbers. */
-            if (nheads > vdev->vq[i].vring.num) {
-                virtio_error(vdev, "VQ %d size 0x%x Guest index 0x%x "
-                             "inconsistent with Host index 0x%x: delta 0x%x",
-                             i, vdev->vq[i].vring.num,
-                             vring_avail_idx(&vdev->vq[i]),
-                             vdev->vq[i].last_avail_idx, nheads);
-                vdev->vq[i].used_idx = 0;
-                vdev->vq[i].shadow_avail_idx = 0;
-                vdev->vq[i].inuse = 0;
-                continue;
-            }
-            vdev->vq[i].used_idx = vring_used_idx(&vdev->vq[i]);
-            vdev->vq[i].shadow_avail_idx = vring_avail_idx(&vdev->vq[i]);
-
-            /*
-             * Some devices migrate VirtQueueElements that have been popped
-             * from the avail ring but not yet returned to the used ring.
-             * Since max ring size < UINT16_MAX it's safe to use modulo
-             * UINT16_MAX + 1 subtraction.
-             */
-            vdev->vq[i].inuse = (uint16_t)(vdev->vq[i].last_avail_idx -
-                                vdev->vq[i].used_idx);
-            if (vdev->vq[i].inuse > vdev->vq[i].vring.num) {
-                error_report("VQ %d size 0x%x < last_avail_idx 0x%x - "
-                             "used_idx 0x%x",
-                             i, vdev->vq[i].vring.num,
-                             vdev->vq[i].last_avail_idx,
-                             vdev->vq[i].used_idx);
-                return -1;
-            }
+    /*
+     * Early setup happens in LM setup stage when the guest memory hasn't
+     * synced to target VM yet. So skip all guest memory access and index check
+     * in early load.
+     */
+    if (!early) {
+        ret = virtio_load_check_index(vdev, num);
+        if (ret) {
+            return ret;
         }
     }
 
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c8f72850bc..c9e6faf72c 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -280,6 +280,7 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *vq);
 int virtio_save(VirtIODevice *vdev, QEMUFile *f);
 
 extern const VMStateInfo virtio_vmstate_info;
+extern const VMStateInfo virtio_early_vmstate_info;
 
 #define VMSTATE_VIRTIO_DEVICE \
     {                                         \
@@ -288,7 +289,14 @@ extern const VMStateInfo virtio_vmstate_info;
         .flags = VMS_SINGLE,                  \
     }
 
-int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id);
+#define VMSTATE_EARLY_VIRTIO_DEVICE \
+    {                                         \
+        .name = "virtio-early",            \
+        .info = &virtio_early_vmstate_info,\
+        .flags = VMS_SINGLE,                  \
+    }
+
+int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id, bool early);
 
 /**
  * virtio_notify_config() - signal a change to device config
-- 
2.27.0


