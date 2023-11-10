Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1FC7E7CE5
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 15:15:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1SHL-0000kV-Ue; Fri, 10 Nov 2023 09:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Julia.Zhang@amd.com>)
 id 1r1M8Z-0006BG-Gc
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 02:41:07 -0500
Received: from mail-mw2nam12on20616.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::616]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Julia.Zhang@amd.com>)
 id 1r1M8V-0000ZM-OL
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 02:41:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvJHzzDsr9rxlQYkyovyhC6hW7jT0JDxtmOSZJkwpqqRUI4o5njlf1F0aOLTgsy1124GBN2P1GyM5CJ/YaSdOjSL/shD/2C4ls6RcjAm8ZT7Oqf46IqYxRxj8V2B13ryYn0KVuQZZ97c8KCtidtDMEQkp6uRvbcu3cp0gqRIBYdfsAsxfMs8i/KufKUZOQv/dmTz7jJl2F6kJPLv02vrWQ+xwbBUI6AwAJssISJFMDu0SHuwhYSuowIw0G0cmq+Y+FsKQeUiZDFm8jMwMJ7YQX6HeoUCh+KRcu8c5T+jqpzQETHV+dt9v6GagaVAPC8s4Teei6wDhQBkCWH/9GSFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XntG1E0uj8N6zad76P/32qeRpwpbBJx1Tke7x6cAJhI=;
 b=Ww6XzYopI1t/JblGGPpo4S3esBRVSKHUJxAjCOY5LH6t3mfhzHnP0+8Ou0NIQKIOSHpGPDjOM9eXgCeGSr6GOfw87fy4FWp0sNQpK6nADFiSvdXZXf6byZLUO4CJZI1YeaZUBsXxfr4rbUD7cxcgB5/YTJN1dzKHYePxNI9B1nNujcxc4rbdIvYHJ9KRwup3ii77cZfv8fpmi4boVvva/OvlU49vV03tAYkefiLFzxffUCdluYuWQmNSG2sieyZRG/KIb/jDnqd3hmiXfXk1KfcLq4pAh0krmLdPwIpsMKZh+fA65n/ev1XX/rub2/QervbTSDA861dv9MHASAupGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XntG1E0uj8N6zad76P/32qeRpwpbBJx1Tke7x6cAJhI=;
 b=H9ZUIQxyTeMBSk/9E+9hPg52zMPIMj2zBY66CmR6WTJFZPOYM90sTCbo0cmyGD1v2OOt2ZxiE/GL8D6CNcnat6KBHXvTp1bf9TnqJ/T9mR0woCN6BNkX7C5Cyeo65i1H3Rqxhgfh4UGCHI44a17TAiQiTAM0yJPK3wHG61ULST8=
Received: from CH0PR13CA0032.namprd13.prod.outlook.com (2603:10b6:610:b2::7)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 07:40:55 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::3d) by CH0PR13CA0032.outlook.office365.com
 (2603:10b6:610:b2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.10 via Frontend
 Transport; Fri, 10 Nov 2023 07:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 07:40:55 +0000
Received: from jenkins-julia.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 01:40:49 -0600
From: Julia Zhang <julia.zhang@amd.com>
To: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD
 <anthony.perard@citrix.com>, Antonio Caggiano
 <antonio.caggiano@collabora.com>, "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>, Robert Beckett <bob.beckett@collabora.com>,
 <qemu-devel@nongnu.org>
CC: <xen-devel@lists.xenproject.org>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>,
 "Honglei Huang" <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 "Chen Jiqian" <Jiqian.Chen@amd.com>, Daniel Stone <daniels@collabora.com>
Subject: [PATCH 1/2] virgl: Implement resource_query_layout
Date: Fri, 10 Nov 2023 15:40:26 +0800
Message-ID: <20231110074027.24862-2-julia.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110074027.24862-1-julia.zhang@amd.com>
References: <20231110074027.24862-1-julia.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ae4815-2f44-4877-ba54-08dbe1c05f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9BJDQy8Fa5HnkabUM8uEhEFh4/vpFxiRUftmaFPFJJau0pm5Cf+km4HROU97tN7DKmPHhM4VG8MWx/FZWZvX+tNe/sPRYCjmavewxaY3VnwFaRRtOcSNCm1XBLVPBDqshW+b0kCWXpB6+YbCGaZv8Dyc4iJznDGTg6ylm8YWGifAMK7cM3hdobfGwFj5SIg6gzAGrJNbLpaeuSKyqDmGIjPtDkEBP1hcgdp8l8s/ZpgnE0/XClfYjemWtOs0mDBOoAICE34f6DD/0c7ha+eXYbDznxuFByszZsZcg3rHcizzvLykAfD01vpgT7GE3qiJ8TwyYRo+ZmEpYcwLkV7+frI4C8pCSZGEShTTOWCTq+WdUSia9SHcyDHlhV4US1u/UoRJw/lpmBtvtafvzAMER3bFci73+938BD1mXUI2qWsqfJ9jiuc3CdodQJFnFN+ouBPbGkAOdhFTr5mk2VrphjFM1Fd4VVy07Z+yyXUZAi3hbnuqvh6d8B76lJQZvpmz+CvsUqnwcRKmDN181kFCOlx55tpXXtK1g5UgSZwSqjDn6QWh0CyvWky+pRfS0evGWmprmazIi7vEVCnloYwsg2L9ddDJW1GS0L+CN8YhK+Z1VD9s5C+Do1VceC0jIp9aaZtbply2SPh3OJ7ZvZcvZE8U+Gpi4HL1Y+g8po38kOTX8Ix+DrAM0Mlw6YvsVrsKkUpeDDttjrn9JLx/CF9dcWw++lwnDnOnWqaev8Jh78AGTnPrbC2oU5tvUHa0icVDfNRVHOVnvcs/gls2wzswZRs7hV6zHa61laQ1o5uyXFKayD3Js9KDLE8b97UmOJPM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(230273577357003)(230173577357003)(1800799009)(64100799003)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(2616005)(6666004)(478600001)(7416002)(36860700001)(356005)(7696005)(82740400003)(86362001)(41300700001)(81166007)(36756003)(70206006)(5660300002)(4326008)(54906003)(70586007)(2906002)(44832011)(1076003)(16526019)(336012)(110136005)(426003)(47076005)(83380400001)(26005)(316002)(8936002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 07:40:55.1372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ae4815-2f44-4877-ba54-08dbe1c05f50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::616;
 envelope-from=Julia.Zhang@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Nov 2023 09:14:31 -0500
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

From: Daniel Stone <daniels@collabora.com>

A new ioctl to shuttle information between host and guest about the
actual buffer allocation, which can be used for interop between GL and
Vulkan when supporting standard window systems.
---
 hw/display/virtio-gpu-base.c                |  4 ++
 hw/display/virtio-gpu-virgl.c               | 49 +++++++++++++++++++++
 include/hw/virtio/virtio-gpu-bswap.h        |  7 +++
 include/standard-headers/linux/virtio_gpu.h | 29 ++++++++++++
 meson.build                                 |  4 ++
 5 files changed, 93 insertions(+)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 8d8aa2c88f..efaa681e54 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -246,6 +246,10 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
     features |= (1 << VIRTIO_GPU_F_RESOURCE_UUID);
     features |= (1 << VIRTIO_GPU_F_CONTEXT_FENCE_WAIT);
 
+#ifdef HAVE_VIRGL_RESOURCE_QUERY_LAYOUT
+    features |= (1 << VIRTIO_GPU_F_RESOURCE_QUERY_LAYOUT);
+#endif /* HAVE_VIRGL_RESOURCE_QUERY_LAYOUT */
+
     return features;
 }
 
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 2ac9a8b864..9c5a07cef1 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -715,6 +715,55 @@ static void virgl_cmd_resource_unmap_blob(VirtIOGPU *g,
     virtio_gpu_virgl_resource_unmap(g, cmd->cmd_hdr.ctx_id, res);
 }
 
+#ifdef HAVE_VIRGL_RESOURCE_QUERY_LAYOUT
+static void virgl_cmd_resource_query_layout(VirtIOGPU *g,
+					    struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_simple_resource *res;
+    struct virtio_gpu_resource_query_layout qlayout;
+    struct virtio_gpu_resp_resource_layout resp;
+    struct virgl_renderer_resource_layout rlayout;
+    int ret;
+    int i;
+    VIRTIO_GPU_FILL_CMD(qlayout);
+    virtio_gpu_resource_query_layout_bswap(&qlayout);
+
+    if (qlayout.resource_id == 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource id 0 is not allowed\n",
+                      __func__);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    res = virtio_gpu_find_resource(g, qlayout.resource_id);
+    if (!res) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not exist %d\n",
+                      __func__, qlayout.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    ret = virgl_renderer_resource_query_layout(qlayout.resource_id, &rlayout);
+    if (ret != 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource %d is not externally-allocated\n",
+                      __func__, qlayout.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    memset(&resp, 0, sizeof(resp));
+    resp.hdr.type = VIRTIO_GPU_RESP_OK_RESOURCE_LAYOUT;
+    resp.num_planes = rlayout.num_planes;
+    resp.modifier = rlayout.modifier;
+    for (i = 0; i < resp.num_planes; i++) {
+        resp.planes[i].offset = rlayout.planes[i].offset;
+        resp.planes[i].stride = rlayout.planes[i].stride;
+	resp.planes[i].size = rlayout.planes[i].size;
+    }
+    virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
+}
+#endif /* HAVE_VIRGL_RESOURCE_QUERY_LAYOUT */
+
 void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
                                       struct virtio_gpu_ctrl_command *cmd)
 {
diff --git a/include/hw/virtio/virtio-gpu-bswap.h b/include/hw/virtio/virtio-gpu-bswap.h
index 8bbca1e751..49316758cc 100644
--- a/include/hw/virtio/virtio-gpu-bswap.h
+++ b/include/hw/virtio/virtio-gpu-bswap.h
@@ -99,4 +99,11 @@ virtio_gpu_host_wait_bswap(struct virtio_gpu_cmd_host_wait *host_wait)
     le64_to_cpus(&host_wait->fence_id);
 }
 
+static inline void
+virtio_gpu_resource_query_layout_bswap(struct virtio_gpu_resource_query_layout *rql)
+{
+    virtio_gpu_ctrl_hdr_bswap(&rql->hdr);
+    le32_to_cpus(&rql->resource_id);
+}
+
 #endif
diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index a04419757f..734fdb6beb 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -70,6 +70,11 @@
  */
 #define VIRTIO_GPU_F_CONTEXT_FENCE_WAIT  5
 
+/*
+ * VIRTIO_GPU_CMD_RESOURCE_QUERY_LAYOUT
+ */
+#define VIRTIO_GPU_F_RESOURCE_QUERY_LAYOUT 6
+
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
 
@@ -102,6 +107,7 @@ enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB,
 	VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB,
 	VIRTIO_GPU_CMD_WAIT_FENCE,
+	VIRTIO_GPU_CMD_RESOURCE_QUERY_LAYOUT,
 
 	/* cursor commands */
 	VIRTIO_GPU_CMD_UPDATE_CURSOR = 0x0300,
@@ -115,6 +121,7 @@ enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_RESP_OK_EDID,
 	VIRTIO_GPU_RESP_OK_RESOURCE_UUID,
 	VIRTIO_GPU_RESP_OK_MAP_INFO,
+	VIRTIO_GPU_RESP_OK_RESOURCE_LAYOUT,
 
 	/* error responses */
 	VIRTIO_GPU_RESP_ERR_UNSPEC = 0x1200,
@@ -495,4 +502,26 @@ struct virtio_gpu_status_freezing {
 	__u32 freezing;
 };
 
+/* VIRTIO_GPU_CMD_RESOURCE_QUERY_LAYOUT */
+struct virtio_gpu_resource_query_layout {
+	struct virtio_gpu_ctrl_hdr hdr;
+	uint32_t resource_id;
+	uint32_t padding;
+};
+
+/* VIRTIO_GPU_RESP_OK_RESOURCE_LAYOUT */
+#define VIRTIO_GPU_RES_MAX_PLANES 4
+struct virtio_gpu_resp_resource_layout {
+	struct virtio_gpu_ctrl_hdr hdr;
+	uint64_t modifier;
+	uint32_t num_planes;
+	uint32_t padding;
+	struct virtio_gpu_resource_plane {
+		uint64_t offset;
+		uint64_t size;
+		uint32_t stride;
+		uint32_t padding;
+	} planes[VIRTIO_GPU_RES_MAX_PLANES];
+};
+
 #endif
diff --git a/meson.build b/meson.build
index 59235aff28..0c20a00daa 100644
--- a/meson.build
+++ b/meson.build
@@ -790,6 +790,10 @@ if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
                                      'get_egl_display',
                                      prefix: '#include <virglrenderer.h>',
                                      dependencies: virgl))
+  config_host_data.set('HAVE_VIRGL_RESOURCE_QUERY_LAYOUT',
+                       cc.has_function('virgl_renderer_resource_query_layout',
+                                       prefix: '#include <virglrenderer.h>',
+                                       dependencies: virgl))
 endif
 blkio = not_found
 if not get_option('blkio').auto() or have_block
-- 
2.34.1


