Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B9578E992
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 11:35:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbe5N-0002uo-57; Thu, 31 Aug 2023 05:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1qbe58-0001uF-30
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 05:35:20 -0400
Received: from mail-bn1nam02on2061b.outbound.protection.outlook.com
 ([2a01:111:f400:7eb2::61b]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1qbe4t-0005fu-6n
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 05:35:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0F/TSCq02pTe4wuSpSwJ/o872tStH5tjsI7bbMQgcEpbIg8WmgCK/pDq5iVAil8KB9Uddj7paraFEO20yWj1s6yTdaOaG7+QQc4XkrpANr07nBoRIeeaZQINq+bRE8D4lRlG0GohPeYPUgeZBY/JIRkpZs5ekreXx9YAe7L23uza1OOUOfg0Z1bBL8XUY376/+Wj0KCep34rsKpFZCErlu4YwIYuZX5aX9BqE6PouHcAxOjinc6q9mVcMTY2W68MwpRU+jrGlYwQ/0Gwb8cqSUnwS4BsCYfhuKb4qT7X+70XuNv9x+yiqBVIrvvEoGLPzfKU+qYkmtNmJQ56mAouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4whcxvah1WNdrkYpCcvCkFOjLQI+i6Mv2VIKDJHLJ8=;
 b=gX97QL9BfYFUspxzJWU3Nnhjkuriy+IuT3xgFYu5xvid1RZuh1cBHGIPbQYdNW1fpJgvVmqT5dRewFyQFdhLahS/vKTjcTP1BeBzjMXW9OQxom6B3IkuKIif6olwPGYEL9VzG9rbPPP4pbxX3u4soI2bfg/NikEWMiyARxa330gkEmx/WRUMvfIKmykQAKcbytU4hFYlpXG8dluyPjhBfZxLME9pmT8HbIObvIY4P692M/trYurg9vUA6v74AJRuOV0uGEbSHQlu5BDY00cb3o+5vAlY594vPKWqvXyCJ2bVwhd1HmM5+6lRQdLu/3SvlHdIyEqAiK/4eVZa3oVNIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4whcxvah1WNdrkYpCcvCkFOjLQI+i6Mv2VIKDJHLJ8=;
 b=YgcB3AfY5Bsr1h2I7aCuKGEdpVCwW5D1PpiFPcYiKuBbg1uf1vqmNPALpPeC1jAtI/s0e9LzTjNG1eqgiuk1xPc/f5DLOgysALCdAjWgLt1GHdpq0Cuilgjx7ALIFguVZphRw1yICy+IsNd3PXr+TXs/QXDZL9mOVy7R/ZguC+w=
Received: from MW4PR03CA0326.namprd03.prod.outlook.com (2603:10b6:303:dd::31)
 by LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 09:34:58 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::83) by MW4PR03CA0326.outlook.office365.com
 (2603:10b6:303:dd::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23 via Frontend
 Transport; Thu, 31 Aug 2023 09:34:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Thu, 31 Aug 2023 09:34:58 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 04:34:47 -0500
From: Huang Rui <ray.huang@amd.com>
To: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD
 <anthony.perard@citrix.com>, Antonio Caggiano
 <antonio.caggiano@collabora.com>, "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>, Robert Beckett <bob.beckett@collabora.com>, "Dmitry
 Osipenko" <dmitry.osipenko@collabora.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
 <alex.bennee@linaro.org>, <qemu-devel@nongnu.org>
CC: <xen-devel@lists.xenproject.org>, Gurchetan Singh
 <gurchetansingh@chromium.org>, <ernunes@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Akihiko Odaki
 <akihiko.odaki@daynix.com>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Honglei
 Huang" <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>, "Chen
 Jiqian" <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [QEMU PATCH v4 13/13] virtio-gpu: Enable virglrenderer render server
 flag for venus
Date: Thu, 31 Aug 2023 17:32:52 +0800
Message-ID: <20230831093252.2461282-14-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831093252.2461282-1-ray.huang@amd.com>
References: <20230831093252.2461282-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: f9c50f6f-8198-46a0-e949-08dbaa058ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dBidW6jv6RWFnhTcFds4EOIGSsBaVzzcWeA0MlWcvFkkGb12aSaqQAEeUv6UVbddR4Js5U0JAoteZ8u+8isMOXeCUzIXQ36b8uJJt4OWp0gbjE8h4TUzAy2iCwbhoFr9jlevLTBDYKb6DN2WMPg1ag4VN+xXdzaUoobRFxY4tI0wPM4OMgSsIfmko9fCdGDtZ617ZDdlSmgR75fG8CZIDpcHC3+b2xnGieKXqBtKRb3Q+j46TpEiSEnkEt8WCCj9KVjIc/3L56HcIZfS+Xu0Zz/vX/0oStolXr4BvZvDidcSy3P1T3/yKZ6z0+p/RV/5mjKA6YLEXSKbBeG6S4Z6LFZMtQxW1TCgUjMMelnUVxnBLTKsSomGvG7mqsGKEy0QTRt5fAtHSmu7oFm/nHqO0Fqd0so+HA9oYMDbVr3Qt6gerob2V5LT1fE8eV1MiKpwRm4lyjZ0H0I3kr2FzEKeMvTy5G5RZqdhGXwVGDWWIDV1lx1yUeu8RDk3MqiKC8Lj/9gNc67VmzUgNDWeqMn8HrDj5jjspgEkXhdUPUIF6Ol9AdF+jj6P8LmOl1YgHdkKBhWRsf70OM21ixHlFxqVxMEm5tBJHYD9oTgB2ccQjr6S1h453p0FpPFLK1XNGmxn2b980kwrVxGQ8UJvIiHrDh5fW6Sf2ljytxROS7dqSNQ7Yrxsm7XrUyhbvhhfz9USgvV6aTNyAN5XWBPTwK/H796I9+XI9J53VQFTIGBokA3GthMGVsawjehKPwt63I8hQnPMe6j9V2rvM3noU7SjCp1jahLq3aZj9J5SuxQXPOA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(186009)(1800799009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(83380400001)(54906003)(70206006)(70586007)(316002)(921005)(356005)(478600001)(2906002)(4744005)(81166007)(82740400003)(86362001)(41300700001)(8676002)(8936002)(4326008)(5660300002)(26005)(7696005)(47076005)(336012)(1076003)(6666004)(426003)(36860700001)(7416002)(2616005)(16526019)(110136005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 09:34:58.1435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c50f6f-8198-46a0-e949-08dbaa058ac5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232
Received-SPF: softfail client-ip=2a01:111:f400:7eb2::61b;
 envelope-from=Ray.Huang@amd.com;
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

Venus in virglrenderer has required render server support.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---

New patch

 hw/display/virtio-gpu-virgl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index c5a62665bd..1ae3e458e2 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -887,7 +887,7 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     }
 #endif
 
-    flags |= VIRGL_RENDERER_VENUS;
+    flags |= VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
 
     ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
     if (ret != 0) {
-- 
2.34.1


