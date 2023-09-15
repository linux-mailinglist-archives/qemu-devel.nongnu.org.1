Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFE37A1D35
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 13:14:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh6l4-0003iq-K5; Fri, 15 Sep 2023 07:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1qh6l1-0003fH-S0
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:13:07 -0400
Received: from mail-bn8nam12on20614.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::614]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1qh6kz-00063U-7y
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:13:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LacU50plnPYPQiL6CHeXCR2jrrXbW/gSO+t2uz93J0u2OQjgGesS8zjgLku2viGbtVPVhhnOyKGzvZ+z4glc5+VwgEAW6VC16a9Oc/qIrqVDeJvsynJZ0k1hEox5nVQN4hZdI8pEODg4N7CQSfB+uthwH8cgKZN/teHg9aU67mUZkHYydM8PZL9WoSAssvBZ9YNRomUqH8cVjngQSALInF2myyydfQkGGw8HVk4swYudzJ7RpL3W4RGgBcEwyahS7C2VFixIsZS8k1iTiV3mX+PfGwvZ+quYYKVmq+xI0dSY9qe+Y038TKgHaxBaz5Iw1LNz+65dWaF5UW4Ax/B8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDKzYMd2SjrX3jhI6nrBvFF+gbF1l4mTQRj0VTPIzeo=;
 b=kPqAevPxKrdjvF0RZryHnjOa9TJUQ5Tz7CZvAUv50bfpbEJ3xP4zTiV4Cc/sqoMCvtQo5/5M0Ijd1H4+ad8ppb03j6Gpyr4gxneOLh4LSbvxZBUalvD7ay4/118LLwTQ0TZw9et/+Z6BZm0W25vCm7TyDmAGy9D5xlvhir+oEcwVJMz2xGUHQSvWck8Z2f8qVZOis3gbVNjKRUtMWGsUQ5rGULlY3/2YB6+JiUgL3S4xC/d3xCl0PIC0yay+5L9k+wlZkRcQxLslFpwwcfFnnWhaOZdomcAQ3XP2r53DwbYzKg4FVt/JezQ3HeQmB9+5OX6x6+2/E7YaeoHRRVrpUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDKzYMd2SjrX3jhI6nrBvFF+gbF1l4mTQRj0VTPIzeo=;
 b=qBMdKpDtxGnFolRgmvHSG3E8U+sa7B5bbZYH5wgbbNRdCdG6fNqeAApnmlLcIxgHPZvklwz4cNqxIC2NUMccdY3+B2cUBYEQj9IJkqrpQXUWR6yKT6LwWkgOwuhUbDelkSS/vMSEYxva8JFT/IczCO2mMugcENiLmG2DzDsMf1Q=
Received: from DM6PR02CA0038.namprd02.prod.outlook.com (2603:10b6:5:177::15)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 11:12:59 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:177:cafe::63) by DM6PR02CA0038.outlook.office365.com
 (2603:10b6:5:177::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Fri, 15 Sep 2023 11:12:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 11:12:59 +0000
Received: from hr-test6.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 06:12:53 -0500
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
 Jiqian" <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>, Antonio
 Caggiano <antonio.caggiano@collabora.com>
Subject: [QEMU PATCH v5 06/13] virtio-gpu: Support context init feature with
 virglrenderer
Date: Fri, 15 Sep 2023 19:11:23 +0800
Message-ID: <20230915111130.24064-7-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: f959d7d3-ab8a-47d0-b842-08dbb5dcb87d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SLkza3en713N31+EauxcBDcLOQh5WV8bcKGM6CUb/p7oyPtKr5SwnQ1cebelQJSR8ANTBgst2uzminkL5ZKCL1MTEvBHezY3lknfrUeYzLfA+umnfDpEO8q7S4zdJdB6h9R9x1dBrdlBcFeSg2XihWOOL7J/KTlYUI6J7PBfBiRcEsTFPfJ0unRvVh+KSCIn7RQ1zlwUF+Qugf/7KwYiRvCZAGjmuGtW/eKX/P8lGziS3cBD82mJlt/9ezoSFuruiFdtGLt0AT8byVJ9+JmDW5BQPMBD3wy2Zw8EnBub5roiD29J2GSNrQhIO1sQDeZvYHOcihWrDRvgEuYZLsgWE0PIDNneXgLp0RM9P+BmWNJZPgWz4Puf10feDCRVmXuouM5Fr3jYkdgf2boMS/Kic7iq7Au0v8VPb3CTkD5TiEKRy8VZSFtmYbNJIMkjpC3XwdpWCqvEkEjtGL9n5am/pYHUfvHuhBZKdj9iX89sWvTasvayQ4LFrM+qZ6axDpmDei5bdZnLGVOqJ0DC53K9fYLiuS1B74Xi/9H/3/l7losGGrsIyPdDiJQHcsf/xPnUCY5nesAgZrScC2YNTuuLq04TQl1appEbFn9hB6fkcofg5f6zPVTGsVwWRrs6C63+QmFT9E5vFpUGTCB2KGw8TZjux3GU5YCQdiMsks1hjmgAfG2O8+wxZLtiJA7G/8Vu5NeLRRLhHuctfix8gYkVqux3erpN/vWsZD2Y+gMTNGzxtMXJgDflK3A3N91PmErJZ54EpU9qg9H6g2NgG00sEN0QNXR6wb15vojeftfUcCs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199024)(1800799009)(186009)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(36756003)(86362001)(40480700001)(5660300002)(316002)(7696005)(26005)(70206006)(8676002)(426003)(70586007)(336012)(110136005)(2616005)(8936002)(54906003)(921005)(41300700001)(4326008)(2906002)(16526019)(6666004)(47076005)(81166007)(36860700001)(478600001)(356005)(1076003)(82740400003)(83380400001)(7416002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 11:12:59.4955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f959d7d3-ab8a-47d0-b842-08dbb5dcb87d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::614;
 envelope-from=Ray.Huang@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

Patch "virtio-gpu: CONTEXT_INIT feature" has added the context_init
feature flags.
We would like to enable the feature with virglrenderer, so add to create
virgl renderer context with flags using context_id when valid.

Originally-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---

V4 -> V5:
    - Inverted patch 5 and 6 because we should configure
      HAVE_VIRGL_CONTEXT_INIT firstly. (Philippe)

 hw/display/virtio-gpu-virgl.c | 13 +++++++++++--
 hw/display/virtio-gpu.c       |  2 ++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 8bb7a2c21f..312953ec16 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -106,8 +106,17 @@ static void virgl_cmd_context_create(VirtIOGPU *g,
     trace_virtio_gpu_cmd_ctx_create(cc.hdr.ctx_id,
                                     cc.debug_name);
 
-    virgl_renderer_context_create(cc.hdr.ctx_id, cc.nlen,
-                                  cc.debug_name);
+    if (cc.context_init) {
+#ifdef HAVE_VIRGL_CONTEXT_INIT
+        virgl_renderer_context_create_with_flags(cc.hdr.ctx_id,
+                                                 cc.context_init,
+                                                 cc.nlen,
+                                                 cc.debug_name);
+        return;
+#endif
+    }
+
+    virgl_renderer_context_create(cc.hdr.ctx_id, cc.nlen, cc.debug_name);
 }
 
 static void virgl_cmd_context_destroy(VirtIOGPU *g,
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 3e658f1fef..a66cbd9930 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1506,6 +1506,8 @@ static Property virtio_gpu_properties[] = {
     DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
     DEFINE_PROP_SIZE("hostmem", VirtIOGPU, parent_obj.conf.hostmem, 0),
+    DEFINE_PROP_BIT("context_init", VirtIOGPU, parent_obj.conf.flags,
+                    VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.34.1


