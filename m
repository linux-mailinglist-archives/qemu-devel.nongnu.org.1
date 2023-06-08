Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 825BE727607
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 06:24:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q77BJ-0006A3-85; Thu, 08 Jun 2023 00:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1q75rO-0005tN-R7
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 22:58:51 -0400
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::600]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1q75rM-0004L6-DA
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 22:58:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHnTvZELV5fQRc/5XKlqBcucRzsEVOheRTQB+wBLFYswRCfx5tXCAn4mDlFhjFMHrYOE7TQ48faAhpnnvpL2BHhglD+nrtf6DDuPLeIrMWiR/2Ss8CZjpvtSmuzAzBafbRQ7sI5nU5Pn4BvKyzgSLHmSjCnRnFBbmEHLTI6wzEtVcMu8eHSDrpCmDahQkY3uAQZ2hhIC76o3pJ76EuaeuXbzjka4VPyzeEy7i1SaiEm/q4TgiunG4To7KhclADj0CR/bwz5CUMZ+KwM2mQbceglipSEeKyL3c7LPCH0zmH6oY30keSzpFivnOWHzNvQMQW/3hZrW5k0QbjluafhHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aK8k7wmBdZjOn2C5EO1ZKL5Opw/gfR8vtLglsPFkJG4=;
 b=ZI7h8vzQh5gyhB+pm+fPeVbB7IgoNTK5mUsAGaRyKA86RxvXD8ibvLVdheXpgZlPfR4Gd/28ANHh3eViTxWsFOHkd9fNpZ5nxVE2n6R1B8QPPU5mCmqgNijdhRCU8LTyZZMXBAuM5w37Vq7MV0Bym2g6cOnDL42J+yy2JwOJdHe1Rqzjy4XfMGzYLxXMiwT7C9UPn65LFF7XQkVql6bkg6NaVsHBFPsZx4JV5tMra/9fLwBTxgp9I3XyMIIS/JMyXteMgp5sjGKOJOYqVwZ5GZPfe9w9vqCl+yJuLTDSm5wriYui1HGobi8c/D9SAk0aLsd4gblL0liqS4Gl9LDiBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aK8k7wmBdZjOn2C5EO1ZKL5Opw/gfR8vtLglsPFkJG4=;
 b=Lf/l3y0c9ntwIb5bWanzkJ1t9QJRRC9nDVaPtDXg5SXC7Eimgyaczy3bO1STNPewITbZuKfqNu+fFEd+A4ZCpWkpJGf7P9SX6ffTVR5o/OJXhl2y9ZHeXMpnbQK2TrBJJo0hyqXhcvFaQ747MbUzps17gq2N9awFyn1FQaF/8n8=
Received: from MW4P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::10)
 by SJ2PR12MB8720.namprd12.prod.outlook.com (2603:10b6:a03:539::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 02:58:41 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:303:8b:cafe::59) by MW4P221CA0005.outlook.office365.com
 (2603:10b6:303:8b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Thu, 8 Jun 2023 02:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Thu, 8 Jun 2023 02:58:41 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 21:58:35 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD
 <anthony.perard@citrix.com>, =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?=
 <roger.pau@citrix.com>, Jan Beulich <jbeulich@suse.com>, Antonio Caggiano
 <antonio.caggiano@collabora.com>, "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>, Robert Beckett <bob.beckett@collabora.com>,
 <qemu-devel@nongnu.org>, <xen-devel@lists.xenproject.org>
CC: Alex Deucher <Alexander.Deucher@amd.com>, Christian Koenig
 <Christian.Koenig@amd.com>, Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
 Xenia Ragiadakou <burzalodowa@gmail.com>, Honglei Huang
 <Honglei1.Huang@amd.com>, Julia Zhang <Julia.Zhang@amd.com>, Huang Rui
 <Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [QEMU PATCH 1/1] virtgpu: do not destroy resources when guest suspend
Date: Thu, 8 Jun 2023 10:56:55 +0800
Message-ID: <20230608025655.1674357-2-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608025655.1674357-1-Jiqian.Chen@amd.com>
References: <20230608025655.1674357-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|SJ2PR12MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5dfc70-2937-4659-ce06-08db67cc43fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J7oHQ15EcAJHkXnoUM31E6qEgZTTZyMDHiGDqXF3jtpqpK1JTVW6tBpTCYSBxyJvg17jQrhYFraV3ASMbCBxRF7oe3uWVLWu4u40oAtuKsIEBhXwNOKml+NnugeEyrAQ1j+xMr00NmP62Gqdn/BwdMG8KWTkQ0UjvwdaH5CR/tq999l/zHYkiKSYmJOQQZTZ7lVyvikaP9sAoSqvidyMCK0ml8bfSa9RAh+IkNGBkPP3a53DdR6YgZTEVEgfOzre8JOgumRYJOM8O6B3T5Hx1/a5/BzeHoz36dTm8o6tOo1oVMDZpNJhWflsDnBDepkLowde2Ye2MOyCw4a691oIKaUMYSuujk0lVjNJo+2059Xu+dBlwswfgsqLrKrd/AZ+rICQqAUmGhwKAdoKzcWObh8sa3m9Zjqre2tjnaqDtq4MNqxjEIxlMudAtnYCOFA1SYb88PnjKorN2HgPfhGv6b1djHyMxvEEcw5TBIxyawkVyLrepxvGYsFNyq4V//rGWA9j4hx4pggoMpomX4j3y9VjgfVVRVc9rp67PT7WPkYL051gMK9xA0VXPAeVKzj0Xer60BPgHQmI61qXc69SAKCd3qJMwvmAmg1sLzeIbmZqfUpjKKNPBOqJ6SRRb2nFkF/oHtLI73Zo650u8AiaotNAxTRrXu+PCGljU6pMKCbvc8Sj0bCcY5of7v63sxa1JYHqv375ccx+1BZHfmml4I1O/frJpNXMbifx8INGoCk7S7UtbQUIEMbAWSteKDVRSkuJD3pTXJwB11JuKnwWruylVLYiZG6jtfHJikrN0D4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(70586007)(15650500001)(478600001)(70206006)(316002)(2906002)(8936002)(41300700001)(4326008)(8676002)(110136005)(54906003)(6666004)(5660300002)(7416002)(7696005)(26005)(40460700003)(1076003)(82740400003)(921005)(356005)(2616005)(16526019)(40480700001)(83380400001)(47076005)(36860700001)(186003)(336012)(81166007)(36756003)(86362001)(82310400005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 02:58:41.2994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5dfc70-2937-4659-ce06-08db67cc43fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8720
Received-SPF: softfail client-ip=2a01:111:f400:7eae::600;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 08 Jun 2023 00:23:23 -0400
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

After suspending and resuming guest VM, you will get
a black screen, and the display can't come back.

This is because when guest did suspending, it called
into qemu to call virtio_gpu_gl_reset. In function
virtio_gpu_gl_reset, it destroyed resources and reset
renderer, which were used for display. As a result,
guest's screen can't come back to the time when it was
suspended and only showed black.

So, this patch adds a new ctrl message
VIRTIO_GPU_CMD_STATUS_FREEZING to get notification from
guest. If guest is during suspending, it sets freezing
status of virtgpu to true, this will prevent destroying
resources and resetting renderer when guest calls into
virtio_gpu_gl_reset. If guest is during resuming, it sets
freezing to false, and then virtio_gpu_gl_reset will keep
its origin actions and has no other impaction.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 hw/display/virtio-gpu-gl.c                  |  9 ++++++-
 hw/display/virtio-gpu-virgl.c               |  3 +++
 hw/display/virtio-gpu.c                     | 26 +++++++++++++++++++--
 include/hw/virtio/virtio-gpu.h              |  3 +++
 include/standard-headers/linux/virtio_gpu.h |  9 +++++++
 5 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index e06be60dfb..e11ad233eb 100644
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
+        if (!g->freezing) {
+            gl->renderer_reset = true;
+        }
     }
 }
 
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 73cb92c8d5..183ec92d53 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -464,6 +464,9 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
     case VIRTIO_GPU_CMD_GET_EDID:
         virtio_gpu_get_edid(g, cmd);
         break;
+    case VIRTIO_GPU_CMD_STATUS_FREEZING:
+        virtio_gpu_cmd_status_freezing(g, cmd);
+        break;
     default:
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         break;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 5e15c79b94..8f235d7848 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -373,6 +373,16 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
     QTAILQ_INSERT_HEAD(&g->reslist, res, next);
 }
 
+void virtio_gpu_cmd_status_freezing(VirtIOGPU *g,
+                         struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_status_freezing sf;
+
+    VIRTIO_GPU_FILL_CMD(sf);
+    virtio_gpu_bswap_32(&sf, sizeof(sf));
+    g->freezing = sf.freezing;
+}
+
 static void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
 {
     struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
@@ -986,6 +996,9 @@ void virtio_gpu_simple_process_cmd(VirtIOGPU *g,
     case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:
         virtio_gpu_resource_detach_backing(g, cmd);
         break;
+    case VIRTIO_GPU_CMD_STATUS_FREEZING:
+        virtio_gpu_cmd_status_freezing(g, cmd);
+        break;
     default:
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         break;
@@ -1344,6 +1357,8 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
     QTAILQ_INIT(&g->reslist);
     QTAILQ_INIT(&g->cmdq);
     QTAILQ_INIT(&g->fenceq);
+
+    g->freezing = false;
 }
 
 void virtio_gpu_reset(VirtIODevice *vdev)
@@ -1352,8 +1367,15 @@ void virtio_gpu_reset(VirtIODevice *vdev)
     struct virtio_gpu_simple_resource *res, *tmp;
     struct virtio_gpu_ctrl_command *cmd;
 
-    QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
-        virtio_gpu_resource_destroy(g, res);
+    /*
+     * If guest is suspending, we shouldn't destroy resources,
+     * otherwise, the display can't come back to the time when
+     * it was suspended after guest resumed.
+     */
+    if (!g->freezing) {
+        QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
+            virtio_gpu_resource_destroy(g, res);
+        }
     }
 
     while (!QTAILQ_EMPTY(&g->cmdq)) {
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 2e28507efe..c21c2990fb 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -173,6 +173,7 @@ struct VirtIOGPU {
 
     uint64_t hostmem;
 
+    bool freezing;
     bool processing_cmdq;
     QEMUTimer *fence_poll;
     QEMUTimer *print_stats;
@@ -284,5 +285,7 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
 void virtio_gpu_virgl_reset(VirtIOGPU *g);
 int virtio_gpu_virgl_init(VirtIOGPU *g);
 int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);
+void virtio_gpu_cmd_status_freezing(VirtIOGPU *g,
+                         struct virtio_gpu_ctrl_command *cmd);
 
 #endif
diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index 2da48d3d4c..aefffbd751 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -116,6 +116,9 @@ enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID,
 	VIRTIO_GPU_RESP_ERR_INVALID_CONTEXT_ID,
 	VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER,
+
+	/* status */
+	VIRTIO_GPU_CMD_STATUS_FREEZING = 0x1300,
 };
 
 enum virtio_gpu_shm_id {
@@ -453,4 +456,10 @@ struct virtio_gpu_resource_unmap_blob {
 	uint32_t padding;
 };
 
+/* VIRTIO_GPU_CMD_STATUS_FREEZING */
+struct virtio_gpu_status_freezing {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__u32 freezing;
+};
+
 #endif
-- 
2.34.1


