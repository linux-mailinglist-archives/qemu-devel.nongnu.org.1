Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B128182B3
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 08:56:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFUxN-0000jN-4f; Tue, 19 Dec 2023 02:56:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1rFUx6-0008KX-28
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 02:55:44 -0500
Received: from mail-dm3nam02on2061a.outbound.protection.outlook.com
 ([2a01:111:f400:7e83::61a]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1rFUx4-0002ND-CD
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 02:55:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b50qcdpOymzRlZCBYZZ06eMcPdqcfMoBSGjOqfsR9yFu2sxZRo1erO3xhRaHTOgaQb8KWEb074Jx2zpjG/Rp3PxVerllEpHQ5FgOulGx3rHN17vpz5hGb/e3YsAgY+8Rq9Ysu4cCQYTfkOVxCJaLGbMJ2aCkhKnnST/WdM922Lx7ngfu+rSqo9Az+1i/pWcPMuz2B1i2nUR/kgaB0REdJNauP6FYRvRNolz/y3whNXbGIHpwDPBnWMnaXQ410I72Xk/5Tj+ec/L2yJ4uoKnZgVvebMvxNn8OMSsJ+8L9+sWFiXennDphISsOdT34+DYRMl7GIatFua7VyTezvpu2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvgusWKUlI0uMUDyWkUtYn1Wm+NitcLGw9FDbxFSIOA=;
 b=G7edWXkLeEbP9v6OmHRb/qvshgCg3EfjzZ838KSHTi21nWWLVnvMX9KZ+ua9GhAcMbSTstmChQ3N/7Kmn8VaSA0elcXvCVizYun6e9cYhWaVdxvJtpdYvCqebvQjWfMf95guEwrprVR+x8yVCM0c8mrQdh+UtQ3cVpwj+Zj14Kk1VGejQrPEm1NX61zuXQTIl9pgEffOJKbS6D8s+e5H75+mpzgS7OaMFl+oUpCs2vwkErGARRITWTQpiw1WFxyoUMI4uWJV3MheAFq+KAkiDjFWfEcbLngBxMorH2SyX9f08F9TsaW6amDIuNTA9EbQpz/FkKtVTVVMu6w0EQF1cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=daynix.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvgusWKUlI0uMUDyWkUtYn1Wm+NitcLGw9FDbxFSIOA=;
 b=QSBVrwa4OPNsqr+LNeuzja4/IP3G8KCgWTtW1aIjNmhxxM/Ij5xf9JnuV5fuRa6TE2iwyOdixQFclBk2aDNqRVf08TatYjHqY8d+tvli+/Q7Ar/cY4bKdBTzV5imKji5+eTgII3Kgg+6SMhFHDo4eJGeXcTUsPTYPBNnMEbQW0Q=
Received: from MW4PR03CA0245.namprd03.prod.outlook.com (2603:10b6:303:b4::10)
 by CY8PR12MB7609.namprd12.prod.outlook.com (2603:10b6:930:99::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 07:55:38 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:b4:cafe::69) by MW4PR03CA0245.outlook.office365.com
 (2603:10b6:303:b4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 07:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.8 via Frontend Transport; Tue, 19 Dec 2023 07:55:38 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 19 Dec
 2023 01:55:30 -0600
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
 Jiqian" <Jiqian.Chen@amd.com>, Antonio Caggiano
 <antonio.caggiano@collabora.com>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH v6 10/11] virtio-gpu: Initialize Venus
Date: Tue, 19 Dec 2023 15:53:19 +0800
Message-ID: <20231219075320.165227-11-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|CY8PR12MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: 4612d029-dba4-4586-d194-08dc0067e3fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xCLb+vKXrvOzJsJcYukuVIz0BQ+QbCuOItwXMTGhoJBEoahC3U7nTIzUz1mDNezKoY0L0QWTlCPp+WXkCxEEv0nRH0Q4tUR61MmiakDnU0HNyGMk7WgDfXgJBBXUhOag8qsFDwWSpVXevH8wxRdoPpkZhORNX9TFSAJFJOrE5ZNTPhRoQg+RA7Tsy/yAV5nG7nxiGBN68DuiqIYYBslU5zfVoCR/EzvwbH7+8lngqR481tl+t/8mn4ylM+SfmdeTWBSz5sd8JiGSoxwk7LO6xQqKh0pqld2BHCfclGlmPSBimwJthkCHpXE31GGZRt4unZETkGOskKfHz2lb5sT2OWuxgULRL3WFSfjdTeGxNbsepCGaOMMYSOMsCYBMV5Y3zlHREFH/6o8Wef/I245x1JH22wbntj3I56f8Yx5Xu+p/U7qlY+qd49PHlhIwyowq9/cZXTePdfh+vWjjf4ftD8RJBFbrGvOa4UhlRaP5aSa4p5b1hq5d04incxqSkuORiqLg3y10PB27HLeN90wZ4CjMniN66yox2Go1NlXXP4h+ceJ+03ewgQplO79Y1mYFQTUi9Jx03oDzjlXQX6wNXzpT1GMuNwfdT1LJpRb5KD48xIT4Zc9ZO4jpI1uYiDGWlI1j5Jkjd0jZO1xIopGBNPpG2guqfroaJEZzq8tTfmZBdvUtz4ksVrS9TJo+giAmVqF38Iqw9yS0MaqKYe7vENcq316I/tf2JmocGfA8l6onb6NIQx6euRDh2K4EMARUet90zc5WMBlm/ebirIxyCsRD1dn9zDKa2Mt1SQJ8JtY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(1076003)(2616005)(336012)(426003)(26005)(16526019)(7696005)(36860700001)(83380400001)(5660300002)(7416002)(41300700001)(2906002)(4744005)(6666004)(478600001)(316002)(4326008)(8676002)(70206006)(70586007)(54906003)(110136005)(8936002)(82740400003)(86362001)(81166007)(356005)(36756003)(47076005)(921008)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 07:55:38.4768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4612d029-dba4-4586-d194-08dc0067e3fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7609
Received-SPF: softfail client-ip=2a01:111:f400:7e83::61a;
 envelope-from=Ray.Huang@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
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

From: Antonio Caggiano <antonio.caggiano@collabora.com>

Request Venus when initializing VirGL.

Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---

Changes in v6:
- Remove the unstable API flags check because virglrenderer is already 1.0.
- Squash the render server flag support into "Initialize Venus".

 hw/display/virtio-gpu-virgl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index f35a751824..c523a6717a 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -964,6 +964,10 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     }
 #endif
 
+#ifdef VIRGL_RENDERER_VENUS
+    flags |= VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
+#endif
+
     ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
     if (ret != 0) {
         error_report("virgl could not be initialized: %d", ret);
-- 
2.25.1


