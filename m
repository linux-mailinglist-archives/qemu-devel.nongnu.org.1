Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 862438182A2
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 08:55:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFUvn-00076q-OJ; Tue, 19 Dec 2023 02:54:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1rFUvm-00076h-38
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 02:54:22 -0500
Received: from mail-bn7nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2009::601]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1rFUvk-0001xV-5k
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 02:54:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGyQ9QcxwY3n6K6IakXpeu/21Qd6UvDxX/XAV7DlEn04T5HpycRMmtha8TOtj8qZYMacUB8OWQhj5tiHg3VIec/fsGbCulTcldVxfvhcL5mwN6H9WLix7+rQiDp9cFX+svvl3NDZX4tRXXqybG2gDLnOD2aitJ+axaGRvDn69ULZ/vpLdQw7jfViT0CjP0eiMhfPTDUjsu/pjHGaSTGSQeTrloPzXRwBvz6vXgmtBYhSSFwAIqyX3nCK1iAFIjFXRU822n0wzR9bz6T3Q4kHFyaxA8YVt2BLXJeqwrd7MESzhoPbqbE5jSGOGBIlgM4r489qEkU1kpXiIETSmlVkhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXNMgYaYEEec9PYZqBz9D0HOmK6yHA694MJAAoZ2Ylc=;
 b=V02d+HLMsjM+vnBkQx3fKPZY3ELoqlHc8+VA1loIOC3xIFkrT8PXN5IChNNuCvQbJL91hpZcZDTL1nZG+vc0rdM5ssKvMcjmF8MApdN/aowjrqaVWYcBYahq2rgzE1BZoun+aBHZY2asbAXPlCfKQk4o+R8QjkZhFBlu/bhvsiNtFHUZS3zKLX635rnZ2171ishaLM5nQ1EAyKmUXuiN6wjad+fQp7nYzC7We7BoHtk0eBLPGpDTH1nbqlVtruCO+GujxiIBlA75KW3E32FhIZMWSrZOKjOETxKc1bWIf8hiw8SLW+IDhg/tSV/xSA0G53FXcz9HHYskRXJkk4jMRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=daynix.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXNMgYaYEEec9PYZqBz9D0HOmK6yHA694MJAAoZ2Ylc=;
 b=hAUEG551Vm2MmavyONaJ7qpWk4rlocXpb8n3mQjBsvie+h8+/SKs9OqUKdTdK3Z0t8ICCqQzaU0RX+cXXChHUq7hcTFn8JVECkiiSK+FUjcRH+BQF6L5FFK4MLSht6p8eKuSP26enqCoZBEbo4AiqsLKvqikfG8WPKxfvCjXJ7I=
Received: from MW4PR04CA0336.namprd04.prod.outlook.com (2603:10b6:303:8a::11)
 by DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 07:54:16 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:8a:cafe::cc) by MW4PR04CA0336.outlook.office365.com
 (2603:10b6:303:8a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 07:54:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.7 via Frontend Transport; Tue, 19 Dec 2023 07:54:16 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 19 Dec
 2023 01:54:08 -0600
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
Subject: [PATCH v6 02/11] virtio-gpu: Configure new feature flag
 context_create_with_flags for virglrenderer
Date: Tue, 19 Dec 2023 15:53:11 +0800
Message-ID: <20231219075320.165227-3-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|DM4PR12MB5246:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd061f2-5763-46b9-9e98-08dc0067b2da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hEi40K5Yj/cvEb/bX2mxWH5rzyndN5KtrQlgR+KcM7ih2hhb0a3c5rIPkUWGT3S7Lod6I0ERn+f/WjXDDfq3VWU9HHPD2lPx3RzC8ACM1pLR+JVjNl3wxV8oRS2DQNLraKZpniznBHhw+/D9nQ47q90DEADVWs5RUu0vHtIBMfsx7gtNChnoP0DyOr3M2UkqjZ5td6nneqdXwZU7LCYeh+1HMekUdQO9LAS/2a47rMfQWKD/TADofAgXwfEVoQwtvTFOYk1lqkiNN+6Qbe1ezlFgyrEph4nWyaJfUPoZJ4T4G6xNMZMLqRjpiJ3hPROHZKNlb8W0gSOKKBg2Pd+SRAIg8WaCOkNtCHVPuGiq8ajMApHP/5t/mGhBGPKpV68GjOoj5y4uWHzu9B88uQ8aY0jFIZOaQcd38/KPrqKiDzELpbM0kZCbfuRUuEfol8JR29Ei5Ynf/fuuFf71f0DC3n3aOB86dN8Q1Uh7QeQosVDOfb3lC8vtjnTjdPoSPniM4ce9VvV5kEytT7p23egfEIICxklf2jvfyCxDqegNdOxqBfdvwKbQEOZ+CT+gkSRMG9AdpQJRJDUn+ORiF3TftFocMIdSJUB6I+egQp1+Kb4NYf2M9/WhAMMuqotAeAPxaE8vdgQRXbOcLs3ky+3QgKxy9Zq6K4HC62ELOybwXwP1pSHcfZAg6CopGjqj+1Qj5TeniPc4ewMa83foJ/1r0hU8ILwMH3JU/3+f9EmZ2OXARdwMUgNN0/Cfbmm9XshRSvYvJuamsJB5QJ/iULegMeFmBdmM0MGTn48pdbzJ3Zo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(40480700001)(86362001)(81166007)(356005)(36756003)(82740400003)(40460700003)(7696005)(6666004)(478600001)(41300700001)(70586007)(54906003)(70206006)(921008)(16526019)(336012)(26005)(1076003)(2616005)(47076005)(426003)(4744005)(2906002)(7416002)(110136005)(36860700001)(5660300002)(316002)(8936002)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 07:54:16.0664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd061f2-5763-46b9-9e98-08dc0067b2da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5246
Received-SPF: softfail client-ip=2a01:111:f403:2009::601;
 envelope-from=Ray.Huang@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

Configure a new feature flag (context_create_with_flags) for
virglrenderer.

Originally-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---

Changes in v6:
- Move macros configurations under virgl.found() and rename
  HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS.

 meson.build | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/meson.build b/meson.build
index ec01f8b138..ea52ef1b9c 100644
--- a/meson.build
+++ b/meson.build
@@ -1050,6 +1050,10 @@ if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
                          cc.has_member('struct virgl_renderer_resource_info_ext', 'd3d_tex2d',
                                        prefix: '#include <virglrenderer.h>',
                                        dependencies: virgl))
+    config_host_data.set('HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS',
+                         cc.has_function('virgl_renderer_context_create_with_flags',
+                                         prefix: '#include <virglrenderer.h>',
+                                         dependencies: virgl))
   endif
 endif
 rutabaga = not_found
-- 
2.25.1


