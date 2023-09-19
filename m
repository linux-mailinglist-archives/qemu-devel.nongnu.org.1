Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8637A608B
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 13:04:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiYWF-0002XK-RB; Tue, 19 Sep 2023 07:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1qiYVX-0002Hv-Mu
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 07:03:10 -0400
Received: from mail-bn1nam02on2062b.outbound.protection.outlook.com
 ([2a01:111:f400:7eb2::62b]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1qiYVV-0001m6-SQ
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 07:03:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dI4fWYe6u+bC6UwMDX06BDTpX+7MJr7gcyNxyjF1/VtD8zuL9dFPN0qlPCGtisOM+u73v8lPuDjaYquCgjRucb0ecFpmikyOy4NAiWE9wOPnaeCJ4xm+J2OTSxFe/v/OjilhdDb5vw/ErDSfoQbfb73ewBssORVdE/VP/xbNtYCmYfiW3vk0LFKCBtZs2nbtbuk3hbOfdG+vl5Wng3mpjqVqr/9SDPfnPeL6gL04N3oHfQNjHUFaH5kp5Ua10DgLZyG/IlY1uKIZht8S245yASFMX5sQOjEgOUdOnhHGY6iR34o4V4CIcXRHEtRjDvQp97NgB/AGpLtnIueDaEUdbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zFFMq6/WNp+pmycz2wKVPOA9hZcBqrLaYWI6cq+BAc=;
 b=SV0DUlAD6VwBFtsk90C7ZcDkMRcGUIuLiH5DEhjvAa5uD+6fZLRUSDtAfc5ZmxTwsjdTVFRM//XicpVqvYPrHZeAcmuy6aDbZsH+fngqs1FzjAU+8K4ygyKZ2j/Yoj6OIfWxNMKWMwm42HJhgXyn30Dbip6pKZvpzHtJfvAnkPRTyOQO6fHNUF7DG2SK+/LF8hjlpxoAsxhKS5rUA9/SpsreSmNH8tEngvMXqFZZcvViZIzOx1ey/KHXNmyuYExAU+C8GQmsf31YmBT3iuGGqh82PRbbBWy6i6OtYd64J0vvR2FgQFnHlY+qK8GUVCO8tmwbIE++KaRRe+Oou+Ufwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zFFMq6/WNp+pmycz2wKVPOA9hZcBqrLaYWI6cq+BAc=;
 b=ZfpOIPUTiYYL7QopoPMN4WBHavM5dWJqP4lqPftAeU/lAdvLBQnNNdnrwwZk0hNlP1BN1YWEcNmaNzeWHJMN0gzCL0iSxd+9ny/He7NefqkP0aN/c6a5CnMaK2H3wUZ7NciXLCNvhRirc2o8BdwyS3/IEimlpy2UUg9lFBz4rn0=
Received: from MW4PR04CA0310.namprd04.prod.outlook.com (2603:10b6:303:82::15)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 11:02:59 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:82:cafe::8f) by MW4PR04CA0310.outlook.office365.com
 (2603:10b6:303:82::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Tue, 19 Sep 2023 11:02:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.0 via Frontend Transport; Tue, 19 Sep 2023 11:02:58 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 06:02:52 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, David Airlie <airlied@redhat.com>, "Gurchetan
 Singh" <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, "Robert
 Beckett" <bob.beckett@collabora.com>, <qemu-devel@nongnu.org>
CC: <linux-kernel@vger.kernel.org>, Stefano Stabellini
 <sstabellini@kernel.org>, Anthony PERARD <anthony.perard@citrix.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>, "Dr . David Alan
 Gilbert" <dgilbert@redhat.com>, Alex Deucher <Alexander.Deucher@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>, Stewart Hildebrand
 <Stewart.Hildebrand@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>,
 Honglei Huang <Honglei1.Huang@amd.com>, Julia Zhang <Julia.Zhang@amd.com>,
 Huang Rui <Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [QEMU PATCH v5 2/2] virtgpu: do not destroy resources when guest does
 S3
Date: Tue, 19 Sep 2023 19:02:25 +0800
Message-ID: <20230919110225.2282914-3-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919110225.2282914-1-Jiqian.Chen@amd.com>
References: <20230919110225.2282914-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|DM4PR12MB5232:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bfdcef5-8b68-416c-6c65-08dbb8fffc37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U+dswkq9hUd4Az1y8NQWLlzWdWyM+Ib9HYL9r5mzVai4vKUQuoDNXCEfTm/TgkNkIB7xR5GCou50Znlqud1uJskflEQEXbMHUMHjOKdYsKttP2yh+t3ObM23P/iJsMW48U8o5y1+iAYtG7fl8+G7koLsUeryBiQ526DoxO7aBPmBfoyvM63X06UIe+t7TmiDjG+JBNrRBsYatQioX9m6j3zL0hUKjP7kWy7kECXiHXu6m7fPUl1C4Xc34hMqCGNZmdJjETRwMGKqt4zQ+UDjbSC/ROVuaK/uLYlqWgZJL9nJyQ+icERbBnuIe5JQwTwjZEVHkuCPbg6kbTJDFV3EEm3IxAs4Ql32sH1uHp4GNK2ABSv0QZV2svLZVDyaQk0/3vwvPqmu9TGhnwW6UP1tfH99XCCNSW9wKkEpaNCbkbmPQTgZWG165K8TljG12+toQbzhgzHp1qcC6YrNI/7U9N1GJRLbiBZLGlg8U8NJrllLsTVqBoDRHT8UO98oocKyQxpD+kO8+GB0zW0ohOmCvbvJCrdAR7IyUZDSOWYnexukE1Q5LWyQup++UlQJKmjclZVf3o9g24CSU7a3LXCsA4vtKgCNaluqVJvuD6snSI6BWrfX9+9qFh4aCr+czEY3BH7mxqHVS3duII6p8th016wcenpxpvbsrQIEPTxvRpNhnVomWZNEYOYK8C5NYB8KULrOjNdCJ6668zwrZp1U7WHzEePnxoB5MswoGNinWBuk113ATHGpAOJE9s5CSVOrlg/cXrzpulMEWj6Iu9fBPT82/4sCxkBLiK692Q6wvgs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(186009)(1800799009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(6666004)(7696005)(40460700003)(86362001)(36756003)(921005)(356005)(82740400003)(81166007)(40480700001)(36860700001)(2616005)(16526019)(26005)(1076003)(47076005)(2906002)(426003)(336012)(83380400001)(478600001)(5660300002)(8676002)(4326008)(110136005)(7416002)(8936002)(41300700001)(70206006)(54906003)(70586007)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 11:02:58.9156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfdcef5-8b68-416c-6c65-08dbb8fffc37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
Received-SPF: softfail client-ip=2a01:111:f400:7eb2::62b;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
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

After guest VM resumed, you will get a black screen, and the display
can't come back. It is because when guest did resuming, it called
into qemu to call virtio_gpu_gl_reset. In that function, it destroyed
resources created by command VIRTIO_GPU_CMD_RESOURCE_CREATE_*, which
were used for display. As a result, guest's screen can't come back to
the time when it was suspended.

So when freeze_mode is set FREEZE_S3 by guest, we can know that guest
is doing S3, and we can prevent Qemu to destroy the resources.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 hw/display/virtio-gpu-gl.c |  9 ++++++++-
 hw/display/virtio-gpu.c    | 12 ++++++++++--
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index e06be60dfb..2519dc12ff 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -100,7 +100,14 @@ static void virtio_gpu_gl_reset(VirtIODevice *vdev)
      */
     if (gl->renderer_inited && !gl->renderer_reset) {
         virtio_gpu_virgl_reset_scanout(g);
-        gl->renderer_reset = true;
+        /*
+         * If guest is suspending, we shouldn't reset renderer,
+         * otherwise, the display can't come back to the time when
+         * it was suspended after guest resumed.
+         */
+        if (vdev->freeze_mode != VIRTIO_PCI_FREEZE_MODE_FREEZE_S3) {
+            gl->renderer_reset = true;
+        }
     }
 }
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 93857ad523..d363b886dc 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1412,11 +1412,19 @@ static void virtio_gpu_device_unrealize(DeviceState *qdev)
 static void virtio_gpu_reset_bh(void *opaque)
 {
     VirtIOGPU *g = VIRTIO_GPU(opaque);
+    VirtIODevice *vdev = &g->parent_obj.parent_obj;
     struct virtio_gpu_simple_resource *res, *tmp;
     int i = 0;
 
-    QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
-        virtio_gpu_resource_destroy(g, res);
+    /*
+     * If guest is suspending, we shouldn't destroy resources,
+     * otherwise, the display can't come back to the time when
+     * it was suspended after guest resumed.
+     */
+    if (vdev->freeze_mode != VIRTIO_PCI_FREEZE_MODE_FREEZE_S3) {
+        QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
+            virtio_gpu_resource_destroy(g, res);
+        }
     }
 
     for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
-- 
2.34.1


