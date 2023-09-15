Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 435757A1D33
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 13:14:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh6le-0006nf-4Y; Fri, 15 Sep 2023 07:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1qh6lZ-0006ZH-Vv
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:13:42 -0400
Received: from mail-bn7nam10on2062f.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::62f]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1qh6lX-000662-Q2
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:13:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRaxgqiAoLzif0lKpmRnD06euhsTfnvVIAfuzxOmWFsV/+pSa33E7v1eRuRLeJ9Juzp+NMexOTyxVhkVK3xziXgTQJhKF9lp0LlY2LRWj6A/WdrbL0LGQOGTqcpk0rgHVp9cK1A6Ty61ZodUMu+07SoNopS7V1KHHc5g3hQ6BDAJLBAQukiEwZ3WLjsamP4qYfObQa8fKSCFW8SJfqiQWcZa0IxnVLakuV0vWOFuoL4wUJrt4+4WUNxgNKqWGTF80QL0a/4bKb2+fv52mgccwSmnUOfVAk4turmIi7UutRszPXSNPRDX9gIOmfEmkCJc/q7dih5IEbT+uf86lSn2Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCctA/d+0Gb5My8OmDqUHYDaathKDBLi1NA3E1Lrd/M=;
 b=U6ZgXko+o2bjDgS8XOakBZTQevApy6+kzm8Gj/UWM4NwEAECFm3ohIVDjIxPa3iYKM38Al5dNEBspYvnFtEYT5hDQ1x2G/iULAvXdlmxe4tExqXWgZ3riTxdrWqmRd2gaXlkLy1Da3BTYVVnNUo5DP0wEKzcAwAwwJVTLZb5jbgtx7Avr04zJwWjxsQvf8yuUAaQ1DPmTTVXtJPkubrqxEpvh383GuyIH7xi/21R10Zw+qJdan4qMXVIMLWWOXeJNe6aTCCTTD932huOx+305S2KJIgm0ANnqx25zlmudgNbgFnOZWjTIgIDMKB83BdFUZJfi/jgjys8Ay3aphAHbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCctA/d+0Gb5My8OmDqUHYDaathKDBLi1NA3E1Lrd/M=;
 b=0wvapmN22PNedA7ekcUvo+6kBbWXNKRMMOiVlbMW8/aLLSumEcZSn/rWJUnYF/4z1YEwK2wmwBL7rj2zG0vIMoDd1m3YV9aGIwMbJ+Sepgg7xh7bmIQ+VAGlPU61fvoOAsC5aDzbAdUA7W+XXShOKHJo+YlQAwQDmvYFXtvfzHg=
Received: from DS7PR03CA0027.namprd03.prod.outlook.com (2603:10b6:5:3b8::32)
 by BL1PR12MB5362.namprd12.prod.outlook.com (2603:10b6:208:31d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 11:13:36 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::ce) by DS7PR03CA0027.outlook.office365.com
 (2603:10b6:5:3b8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 11:13:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 15 Sep 2023 11:13:36 +0000
Received: from hr-test6.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 06:13:29 -0500
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
Subject: [QEMU PATCH v5 12/13] virtio-gpu: Initialize Venus
Date: Fri, 15 Sep 2023 19:11:29 +0800
Message-ID: <20230915111130.24064-13-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|BL1PR12MB5362:EE_
X-MS-Office365-Filtering-Correlation-Id: ab3bcf85-b9a0-4d55-326f-08dbb5dcce60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bxWOhEETmGAmwcLPrzGe/Y27jc3iadxvHmWlqljMAJlOKoSk811V0f+FhFIPnY+BH+xI+xZzU2h7vMaT5UUTB0PhGBzw8RngwmUTJUpgT1vXeAf+VX1lZnR18ChGrgjDgisoe2lkbMEjx+0z9ggPwlQdkNUHj6+PHQglN5zQyWBGAt1LK5nBwsw9Sy/MJqmuv+L2HsHshRTqfb4enocayIQcyjgpdLQHPchVZjhGvjBOe2bCd1lJdmACd+nf3XWHEE/9Sew2d+P2ljIvZ4i9/rVbhjzzgysmRHLY9TIcer+GpPwqiAZX6duLlEY2dX0MgIaCcbleHWm2pMmLvG5vQ2aB8e2PuO4bIo/jwKR3uW4FRxvNzNnOKZoLQdNDqpoK7n3Dvd0esHjsxgEDbnNY9pvJ0Ehf+cLd+3ri39Fqi0lZxS+9jcj1kTXRvvh/1XdxXMI0Fd73uRN2zNQfk/beuJ0aII8/ccISeRcpXUFoA7EPBzUe7Ou/6gxSrWf1tefcAGjx74u9wkBeMRsdDK00x+Vg6L4VQMD532mHO13pNpNlzGSpq7fmvCIiO2VcClm+jOo5VGPfkBBpyGETt9U+55McBC39Y5xl3DJVT4WkxwDi1iWyF8+SAao4LLkziWxxGbWJL6LIXlvAUbMUIcFGR1BQINd3oXCkVmNJOUwLSE0saDkOMazbFlIaMrfXEs0bdZPLEPe4eQgmM4AMPuQXXYpwVwGOirEIPaukeg1XAmOdOTJIRO4TmVAL6fXS9vAVW4pklcgDcEBgCspnIBYwEtCFAPa62+jskw7cbkIiLAU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(5660300002)(8936002)(26005)(16526019)(8676002)(1076003)(4326008)(40460700003)(2616005)(2906002)(83380400001)(7416002)(86362001)(47076005)(81166007)(921005)(356005)(82740400003)(36860700001)(36756003)(426003)(336012)(40480700001)(7696005)(110136005)(54906003)(70586007)(70206006)(478600001)(41300700001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 11:13:36.2119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3bcf85-b9a0-4d55-326f-08dbb5dcce60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5362
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::62f;
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

Request Venus when initializing VirGL.

Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---

V4 -> V5:
    - Add meson check to make sure unstable APIs defined from 0.9.0. (Antonio)

 hw/display/virtio-gpu-virgl.c | 4 ++++
 meson.build                   | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 7f95490e90..39c04d730c 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -887,6 +887,10 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     }
 #endif
 
+#ifdef VIRGL_RENDERER_VENUS
+    flags |= VIRGL_RENDERER_VENUS;
+#endif
+
     ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
     if (ret != 0) {
         error_report("virgl could not be initialized: %d", ret);
diff --git a/meson.build b/meson.build
index f7b744ab82..e4004d05b1 100644
--- a/meson.build
+++ b/meson.build
@@ -1076,6 +1076,11 @@ if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
                        cc.has_function('virgl_renderer_resource_create_blob',
                                        prefix: '#include <virglrenderer.h>',
                                        dependencies: virgl))
+  if virgl.version().version_compare('>= 0.9.0') and virgl.version().version_compare('< 1.0.0')
+    message('Enabling virglrenderer unstable APIs')
+    virgl = declare_dependency(compile_args: '-DVIRGL_RENDERER_UNSTABLE_APIS',
+                               dependencies: virgl)
+  endif
 endif
 blkio = not_found
 if not get_option('blkio').auto() or have_block
-- 
2.34.1


