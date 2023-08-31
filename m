Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 000DC78E98E
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 11:35:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbe5H-0001oh-7Y; Thu, 31 Aug 2023 05:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1qbe4n-0001VF-1q
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 05:34:58 -0400
Received: from mail-bn8nam04on2061e.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::61e]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1qbe4j-0005WX-0K
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 05:34:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YepS+TXID+Z+ZHNMAD1kNfGCDvWlVCtu/J5o3lYJZO9dlg3fTr8Mn8t4N3KZTB/0Xc3fnKmqrkPDbZMJGNIjTc+JdtOK3DRCv9hGGDkQpoyLXTuplBoxp6MAgN3heUFW0ifr2DUxBhAYHXtavn793ttZnUf+ymXj8r7LKjeCL7nn9TwXsqELSOxgwlqk1zA2qRBSYbcX14ftoomVXItGSuXBkAa8/JxYHxqHBQYNngWsjMKikweJ9/dXSizIwHQh+AtE+ToR6/VrJjl9+IFBQeIwlgMO0YdJ51qC5a73hQyRoy/Oq+XhctESu6VWvTnAGDf83NbNhOZo5lfxDqnZIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DK5ukbAvzb0hia2JZcQd7uC3Wb/ok/DT6B60FOX8X3E=;
 b=nhmL7S7g8iXZbnUtz3Uqfs+AXAPoPe4z4ECOQvrzt8hw+Dev2iCsfdZaXH1LkUDseFf31EWHhOPLHgOka6RzZfrl12gh9Rypg8gotutOQsHhvqQyqTaIejsHfElhxGyLnfNu5MO9UmSTF/1u3UiDBUYSUfl+A4LUze5cqJjLVakoOL4HtEKI/W/GjXL/g+RrNKbI+u48dKPeRF++fu9kOiMRCph4GCpaQjXSdQIEqe+TcQL44J56Iuc8RrLnjEUfioDflzfXNAGCiQ5k6ZG/yz/PztLYZwXJUnfpx1CfP+yE61QzFd9OU5dgn5/6PyeoZyf5dAeEVSetn2aPrsOtTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DK5ukbAvzb0hia2JZcQd7uC3Wb/ok/DT6B60FOX8X3E=;
 b=SYhuz/qKpKW8uVbWcsxB15kjfTXawcsT1c66/BCFDutDN6bvt4vyyKsuOCpoiDg/epBTAqBcC1FdJz+U9dS7Vf5urMfvFCJtRd/2eqMDah7yfhoIO/vDjrz/XVi+gGlO0Qov8PBQ1NFykaxkOYTuNCCtvctDyCZmGTPNZe/o9IA=
Received: from BYAPR07CA0042.namprd07.prod.outlook.com (2603:10b6:a03:60::19)
 by DM4PR12MB5216.namprd12.prod.outlook.com (2603:10b6:5:398::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 09:34:48 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::5e) by BYAPR07CA0042.outlook.office365.com
 (2603:10b6:a03:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21 via Frontend
 Transport; Thu, 31 Aug 2023 09:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 09:34:48 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 04:34:41 -0500
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
Subject: [QEMU PATCH v4 12/13] virtio-gpu: Initialize Venus
Date: Thu, 31 Aug 2023 17:32:51 +0800
Message-ID: <20230831093252.2461282-13-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|DM4PR12MB5216:EE_
X-MS-Office365-Filtering-Correlation-Id: 975ef433-94de-4d6b-2e37-08dbaa0584ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ImOCzu6+/kEHOzXZGZYrt7abyqr8nqwzXQuC1Za7cvBlTQF4s/Hq1iqker4JBvJkYehLs8E7d2npiBzuHKpASwTpfrb8PDizHTHlfCDBNtqprTvS96Kf4E1Aa1nDsOzrbRNxBH974xBt+zjUGGuhP0XDJyKoslV71Do+MV9/6eBz7jdBOXpBn4fsd6OzNBegRygmaz47dVagVYbSoRVFVxxUI8/oQlS7epTvgROgxzH+RexHGVPaoSpD4Ikyp0g8IXTh/aAhQHtof7TBqOl2CL91ALmoivsXbd9JDUpzftXBMuYqWw/Fg8SllUVTbuN2tp7evKKlsoMxyhJlbdGYHoQWIS+VjSeVSXkm6kDTyaP0RHxSADtQPeDtr9vEXNZZdk5lielelsz5Z/spjhI1RdzYbprIKHOBcatY5coz+DGc0fwfw9VA3hON++tLJWaD2NKsCZg33pIkesmfiFJCX9kPL9OVLV5lNpawctMewuS5Ccy5b5kUw9KguJj3/1fBeiwy1b9GoqZnFGZqCfsa8GCj0IJiMxJKF0CUkO1hfzm5npE0qgSwPiYNmKOUW3NGrAuycouy+Gnfo5PaX1yWGm9q+YEFl3fih/tm/ZGzHu/si/9QrbqgjsPsHD30/jPDL749pXGSt+ajOiVsHPpfTAhjuubq99KduVaAi3nKZqXUzNRy7sLmnP/MjTXk4X6maSkGGjRaEx0ArQ2BPxgA+7AS0kyGVQbM7jLnVP3mznlQ+da86qiOEhtaEXe5DdOH1BqFwqgrK8D7RIER4ZtUvSVPxF6U/larb0JQ+Wozpls=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(186009)(82310400011)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(36756003)(40460700003)(40480700001)(83380400001)(4326008)(41300700001)(86362001)(8936002)(5660300002)(7416002)(8676002)(1076003)(26005)(336012)(6666004)(16526019)(426003)(7696005)(2616005)(36860700001)(47076005)(82740400003)(110136005)(356005)(921005)(478600001)(4744005)(81166007)(2906002)(70206006)(70586007)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 09:34:48.4525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 975ef433-94de-4d6b-2e37-08dbaa0584ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5216
Received-SPF: softfail client-ip=2a01:111:f400:7e8d::61e;
 envelope-from=Ray.Huang@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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

v1->v2:
    - Rebase to latest version

 hw/display/virtio-gpu-virgl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 83cd8c8fd0..c5a62665bd 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -887,6 +887,8 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     }
 #endif
 
+    flags |= VIRGL_RENDERER_VENUS;
+
     ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
     if (ret != 0) {
         error_report("virgl could not be initialized: %d", ret);
-- 
2.34.1


