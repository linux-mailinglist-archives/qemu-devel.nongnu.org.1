Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 650DC7A1D36
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 13:14:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh6lX-0006Gv-9p; Fri, 15 Sep 2023 07:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1qh6lU-0006AP-8T
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:13:36 -0400
Received: from mail-bn7nam10on2062c.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::62c]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1qh6lR-00065k-UT
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:13:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pigl4i3gyS+HEMvXRXxFqo1H8pQQJ6XH2ugszUc1Vi2mzt2KBhADo4DrAO1oUL8YroDZjSXy0gXPHFVj8Dz8kDAZGRjsiOVrBwVC2KmgeBK1dh8TOJDe/PW/M9s0EalwhnS1lrYoNSGToOWU81CXJG4qRbdlgomtsBsxLDNZ9CY9SONXyBxtiafB+KJSpdEg5b+fZE1nCYOATXY1ZZ1N8OtIPHUUlsogmW2mIyEVYRDoAerl+rikOQNkF4MVlNMUQA78TfTlQyh84r7f7pCbIlKq+G2r7Qcaq/yn8I/PUpAwUhgn/Th9Rjp90S6BXaa+H3mOfeGdtiOH8W/jhcuuMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSkyHF6vxVVhxr6BksCITEGigkoq1JtKA4LzqMq3d1Q=;
 b=mEo4B7VbkO5F6mJ27RxZ75yHyXlbUATmQujL+GV03gsN3YS5SfNcIXBO00i+Uzs9JCTP2/lg+5DbOJz9PUYhZqEpRql+XW1AhcNQ8gRpUATQutqDN9Q19aZ41ndwyd57eB/Khm3+9ujnColeR7yIYsOXeDDle7OZ9Lz/Ukz6IimKTc4olGuN8A/JYgftbEfBzHQ8I4NFogmpYhSeYXK4U1b+UAFWDk4PqMRkK/z9+pr3SzwRsG1CBAXlViAKllo2kqeYm81PyRddueJ0csjAekvja/sFgyYaS0QBS6UFCwXcEXwJcuZQg4LxXj7DvZNy855SFy6PQbityeUxiQc2YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSkyHF6vxVVhxr6BksCITEGigkoq1JtKA4LzqMq3d1Q=;
 b=Mv/l/Lq5sV4kJmLGddBoaRzGDC6o6S4ClRy7qLLCki2XkZrCrGRXEgLBwlLqoM5GMT7SMe83po0MqT0Yby15RqWjtjxEWHTXI60ZeKmLL6WbsNSNV4cL0lZ3TVn4g3E0Ani+LA+eV6nJ8/eWpl3Dc+8CnsQMKoElhIxhGLMeo/M=
Received: from DM6PR10CA0001.namprd10.prod.outlook.com (2603:10b6:5:60::14) by
 DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.34; Fri, 15 Sep 2023 11:13:30 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:60:cafe::c8) by DM6PR10CA0001.outlook.office365.com
 (2603:10b6:5:60::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 11:13:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 15 Sep 2023 11:13:30 +0000
Received: from hr-test6.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 06:13:23 -0500
From: Huang Rui <ray.huang@amd.com>
To: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Anthony PERARD <anthony.perard@citrix.com>,
 "Antonio Caggiano" <quic_acaggian@quicinc.com>, "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>, Robert Beckett <bob.beckett@collabora.com>, "Dmitry
 Osipenko" <dmitry.osipenko@collabora.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
 <alex.bennee@linaro.org>, <qemu-devel@nongnu.org>
CC: <xen-devel@lists.xenproject.org>, Gurchetan Singh
 <gurchetansingh@chromium.org>, Albert Esteve <aesteve@redhat.com>,
 <ernunes@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Honglei
 Huang" <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>, "Chen
 Jiqian" <Jiqian.Chen@amd.com>, Antonio Caggiano
 <antonio.caggiano@collabora.com>, Huang Rui <ray.huang@amd.com>
Subject: [QEMU PATCH v5 11/13] virtio-gpu: Support Venus capset
Date: Fri, 15 Sep 2023 19:11:28 +0800
Message-ID: <20230915111130.24064-12-ray.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915111130.24064-1-ray.huang@amd.com>
References: <20230915111130.24064-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|DM4PR12MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 5039c86c-aa90-42dc-6932-08dbb5dccad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Np+ABieQKRZO+JP9XsbX9lGtb0zKljyWnPn2FzRMyuJdfXU0eBaiukM5QolIazTrD84oTld5MzeUpPkFz/XU0/zNKkqsh4CzFK4f5Im1pD0qzM2PBJM5WfXZ0svTga/1cyLfvPuk3HfwUTdvw8JZ6lq5MyQorp9CCcHyvtPMhzadgKOkEGHtBEouX+wLNJrfiiMpQ+5Y1qevxJ3Yvsfmzrjh1kLmYf/Q3Nd9VnLFfKUhOF5n1pZi6AKTaAvgOkMuDoqdEmxaRVkhHq84FbB+OyWxXGN7x3zQ3F2ArsNlkTtXBNyumsOceQyPRO/YBiycULgm4xTkJerHFlJ8wKWmj2L5K3x/PZOJryI8SNwAIDCAnHJBHdUY99lNRkQ/kxrQvpysJOvvOAv2M8UvzueEsaTSGgGGQWbu78+Fm2w40vjTm7djDHLIdkLl2pp2cQKNhaj+9WeVi8eF3Wdj8x7CJkXY/4hoC5pzegRZUciB3nGz7ZWVTREHr6ysewCGLCTLnjawl3GtgFtgnWq2t7Ek3k8unlfa/dket8kJQK8iATy4QVNqM+z+wFwwSB/p+RHDxyId/6N0abEKdfncadFB+8V4MWn7iQfUtq0nEVgUSqF3GhmE94qZ/Q5JDeUKLUoxfWvIijGZXd3iddVr+m7pvOiCR/c+yYxsJ4Yr+gU8xNZBCftqrGvIZ5TG58qYRmmeHfvQpFEVTM9J5v6HdNPhBEV4RNmMGWC4YmyQ3qq6V+vXnbzRG2kb3U12B4zqcVlTE3Dlq5gJxP935sLWTFJKkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199024)(1800799009)(186009)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(36756003)(86362001)(40480700001)(5660300002)(316002)(7696005)(26005)(966005)(70206006)(8676002)(426003)(70586007)(336012)(110136005)(2616005)(8936002)(54906003)(921005)(41300700001)(4326008)(2906002)(16526019)(47076005)(81166007)(36860700001)(478600001)(356005)(1076003)(82740400003)(83380400001)(7416002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 11:13:30.2495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5039c86c-aa90-42dc-6932-08dbb5dccad2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::62c;
 envelope-from=Ray.Huang@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

From: Antonio Caggiano <antonio.caggiano@collabora.com>

Add support for the Venus capset, which enables Vulkan support through
the Venus Vulkan driver for virtio-gpu.

Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---

V4 -> V5:
    - Send kernel patch to define VIRTIO_GPU_CAPSET_VENUS and will use
      another patch to sync up linux headers. (Akihiko)
    - https://lore.kernel.org/lkml/20230915105918.3763061-1-ray.huang@amd.com/

 hw/display/virtio-gpu-virgl.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 8a017dbeb4..7f95490e90 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -437,6 +437,11 @@ static void virgl_cmd_get_capset_info(VirtIOGPU *g,
         virgl_renderer_get_cap_set(resp.capset_id,
                                    &resp.capset_max_version,
                                    &resp.capset_max_size);
+    } else if (info.capset_index == 2) {
+        resp.capset_id = VIRTIO_GPU_CAPSET_VENUS;
+        virgl_renderer_get_cap_set(resp.capset_id,
+                                   &resp.capset_max_version,
+                                   &resp.capset_max_size);
     } else {
         resp.capset_max_version = 0;
         resp.capset_max_size = 0;
@@ -901,10 +906,18 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
 
 int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
 {
-    uint32_t capset2_max_ver, capset2_max_size;
+    uint32_t capset2_max_ver, capset2_max_size, num_capsets;
+    num_capsets = 1;
+
     virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
-                              &capset2_max_ver,
-                              &capset2_max_size);
+                               &capset2_max_ver,
+                               &capset2_max_size);
+    num_capsets += capset2_max_ver ? 1 : 0;
+
+    virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VENUS,
+                               &capset2_max_ver,
+                               &capset2_max_size);
+    num_capsets += capset2_max_size ? 1 : 0;
 
-    return capset2_max_ver ? 2 : 1;
+    return num_capsets;
 }
-- 
2.34.1


