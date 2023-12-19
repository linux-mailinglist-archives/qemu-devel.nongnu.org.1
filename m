Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2048182AA
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 08:55:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFUw5-00078E-0f; Tue, 19 Dec 2023 02:54:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1rFUw2-000782-RY
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 02:54:38 -0500
Received: from mail-dm6nam12on20603.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::603]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1rFUw0-0001zH-3A
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 02:54:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8o7/GpuVDxi0X+dQ9kLesyUpRE5JoLTG9AYgCeeY49Yhu1WmvyNGjIJONPCAldGG57B3d5dZrH1hoaOfStwCBx+DQGac45NJVBVml+XeEz4JhK1xjvcxgyH39A00pzWq6CsKxkZn9qmGBsSB3RFSXWsPAgO/v9esk3PFC3YeWb1OMqD41pkJnwJZbV7uBBhwWngP7hiYFBvxT01NXYpslCcJ0fOO9hfpRVYd6Id9RG2l6ryJG4aHKne/c7Ldo2FNK/5ibSpRhSOGALUv6J5Pv5Ftf900X8vDdi7b41zZMX/DgJSLCwWt8HlX8uP3RZPENsE1ZhJ44zW+8lnH08+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKmMnMCdCaydrQlgeL0qolLO6nUxwbJNYBpgWhWfXsU=;
 b=MWGkXHInlpavH+xN4sP4QlXnU7GxLnN+OeVLNZKmBP7Ul6PoiXJSOtFdMdBaYopfdg0BfvKxo1TE577nwsC3+8mIUXuoi8CuaHxxjT1NIqWmUQQhnsCAHkxzukw7xh9DIN59Y0HulReraGmLLTKHmF47XP9wpkJFzh5YWcvlIhLKUGqUHf2lzTMZAI8lG6khJsXoAVWalSywrsGOgC/vJo0YbSAAe0eUi5GIsceqLAmrPjgcZcw1/DhxND9V6m52nB3FCTF5X5eIs0vkb9NAxH/WvDJhfvqMLS18Afi5y3hR6HUXAujZN3YxrSs6zR1Enc4yIReSgDSoXoXD9VSMXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=daynix.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKmMnMCdCaydrQlgeL0qolLO6nUxwbJNYBpgWhWfXsU=;
 b=4u0JsdR2HdG+p2NSusJjlhnAjVC1uk6Ytl45tMeFxyKGaTId/V1oixOEkjai18dDk2T9DGjLNqnDwJjOQQZx2w6JF8XTTEQnz9PWSLzQv+d1MAiuZ03QLL5XTG+HuRqiCGSI72/Vf/j1MaJRPT96dof5lWgzjkSclTKAbGQx3MM=
Received: from MW3PR06CA0017.namprd06.prod.outlook.com (2603:10b6:303:2a::22)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 07:54:32 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:2a:cafe::55) by MW3PR06CA0017.outlook.office365.com
 (2603:10b6:303:2a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 07:54:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.8 via Frontend Transport; Tue, 19 Dec 2023 07:54:32 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 19 Dec
 2023 01:54:15 -0600
From: Huang Rui <ray.huang@amd.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Gerd Hoffmann
 <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Stefano
 Stabellini" <sstabellini@kernel.org>, Anthony PERARD
 <anthony.perard@citrix.com>, Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Robert Beckett
 <bob.beckett@collabora.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
 <alex.bennee@linaro.org>, <qemu-devel@nongnu.org>
CC: <xen-devel@lists.xenproject.org>, Gurchetan Singh
 <gurchetansingh@chromium.org>, <ernunes@redhat.com>, Alyssa Ross
 <hi@alyssa.is>, =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>, Stefano Stabellini
 <stefano.stabellini@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Honglei
 Huang" <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>, "Chen
 Jiqian" <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>, Antonio
 Caggiano <antonio.caggiano@collabora.com>
Subject: [PATCH v6 03/11] virtio-gpu: Support context init feature with
 virglrenderer
Date: Tue, 19 Dec 2023 15:53:12 +0800
Message-ID: <20231219075320.165227-4-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231219075320.165227-1-ray.huang@amd.com>
References: <20231219075320.165227-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc82c44-91f7-4633-1956-08dc0067bc7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /cm2gXc1/JNXdY36bfebsljXl4vJij1lTwjsnsIvZV8LKN0BMKNpfbG+fB65x0qK4PsV114l5DID2nEbVeTh9xMB9EUeKYxFtxFuTi/qk0pfCnVnr5IlsqAR/oE/58yDIezonCGqLuC7y9cGy24/LlPyCthh6oNBMZNUyKOD6csHJr6ih+ga7oVKiIGuYA4pNfaLeu+mbU/I9IFiA2vI0CqeJfm33URdNEK8+/LVOWTHoZ7NKYdPIpdRbx9tjhVZKbVIT3l7cYLzDXkLg409Vgy8Xh+WLOXJD4KlgsOwlp0kuJ6ItyPSY/OcB+u9BzWkxmusiHWagAYa+xuNSgZ/mbpRtwUA/fWQuwIyTfnz/toGUv29fgvbQZREg0WqG4A1kgwYxKFfEZeVu9ll0KiGgJC8f6pJiztVvbscyZRNNYPZlCBCM9HmaB9fdGHpn5AIIL+ZH4EboQtXRtYZ6az0vLq7ceU7YZB2oXItJFuiobx9jkAqYUrq4mhnhRUy6bUO+U+9uwF9bZshe2cW/89DQFyKqeQkTTran6zX0ZRvMQw/o/xomJPhlSRqnminqo7rRWGHgUUWTFeofLaWcQbMdLt9oGoN7BBtrSLM/c71PK/mthNo7QP2yf2Ri48IgQ5SgxXemYYMhNhHB7fLZelegDWoDol7lNCHcyolK/fTfhmF1QRcsxiOfPvtl7S9R/kxol5++vgX4/ynBNFTE+Sn0quuc71IqjaBhz63hKvlfyg1XXRX9FeXpm2qHgS43ooCcsKXVaeEMq1ZgRUk70NoctUdFKn7XbfRINUhAVDSliM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(40480700001)(86362001)(81166007)(356005)(36756003)(82740400003)(40460700003)(7696005)(6666004)(478600001)(41300700001)(70586007)(54906003)(70206006)(921008)(16526019)(336012)(26005)(1076003)(2616005)(47076005)(83380400001)(426003)(2906002)(7416002)(110136005)(36860700001)(5660300002)(316002)(8936002)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 07:54:32.1995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc82c44-91f7-4633-1956-08dc0067bc7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716
Received-SPF: softfail client-ip=2a01:111:f400:fe59::603;
 envelope-from=Ray.Huang@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.083,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Patch "virtio-gpu: CONTEXT_INIT feature" has added the context_init
feature flags.
We would like to enable the feature with virglrenderer, so add to create
virgl renderer context with flags using context_id when valid.

Originally-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---

Changes in v6:
- Handle the case while context_init is disabled.
- Enable context_init by default.

 hw/display/virtio-gpu-virgl.c | 13 +++++++++++--
 hw/display/virtio-gpu.c       |  4 ++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 8bb7a2c21f..5bbc8071b2 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -106,8 +106,17 @@ static void virgl_cmd_context_create(VirtIOGPU *g,
     trace_virtio_gpu_cmd_ctx_create(cc.hdr.ctx_id,
                                     cc.debug_name);
 
-    virgl_renderer_context_create(cc.hdr.ctx_id, cc.nlen,
-                                  cc.debug_name);
+#ifdef HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS
+    if (cc.context_init && virtio_gpu_context_init_enabled(g->parent_obj.conf)) {
+        virgl_renderer_context_create_with_flags(cc.hdr.ctx_id,
+                                                 cc.context_init,
+                                                 cc.nlen,
+                                                 cc.debug_name);
+        return;
+    }
+#endif
+
+    virgl_renderer_context_create(cc.hdr.ctx_id, cc.nlen, cc.debug_name);
 }
 
 static void virgl_cmd_context_destroy(VirtIOGPU *g,
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index b016d3bac8..8b2f4c6be3 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1619,6 +1619,10 @@ static Property virtio_gpu_properties[] = {
     DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
     DEFINE_PROP_SIZE("hostmem", VirtIOGPU, parent_obj.conf.hostmem, 0),
+#ifdef HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS
+    DEFINE_PROP_BIT("context_init", VirtIOGPU, parent_obj.conf.flags,
+                    VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED, true),
+#endif
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.25.1


