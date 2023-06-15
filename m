Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1B0730BFC
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 02:08:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9aUi-0005yP-D8; Wed, 14 Jun 2023 20:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q9aUJ-0005mh-AD
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 20:05:19 -0400
Received: from mail-dm6nam11on2060c.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::60c]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q9aUF-0006rF-9J
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 20:05:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNPvy/iks6iDDr4imGqUF+i2+tyAc77KrUEOlJ75Y/przafgwx9TDJafoiZ5C8nCEG8YZyRSmCpb6z0UlfyH5fy7QAycVq7pU5zFsA1bTppB8RACr38sa+r5myT7ArueU6X6MKdigDaZu+tZ8MORllDnPsWI/GotsUZvMDoU4s738lCh0Z+4HcvFMfJ49YUgKzNuq8xcHixeZNY0Ix6R54YY/MgxscxZF8c5NaGCCgSNBHOJAMyh/F7weS+chbRKAmfTiqTphKW3LqTbvhZOASZNQzZs1TJLrAI+QfXPfHRkJkFqf5n/Djv54tJ7IPfLYmgZ2VwNjbWaJaGE/4YGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tmh1dCxZuDVpegEWwz4s/MEsuA4Y58vGnEhunl81M9c=;
 b=SHRolyw0499HPtGOQu4nePHXqadDnLOS8xqYa1I+2j3HK4Q3qz7NTZnJ055/OJSz+75SXZBtw1t11wSGQtrCRuVSKmB9mjXLAnv9r/Y7X/oZ1wvdNihvSKguJ9V7Mk6GZotKZFghXJtVB50nPiKcwP53rz4zRr4YkLiEMYfPXB6GvUCPuD8pFh2v6JPaNKRLM9UV7kRkztSmtPubXwbufIne4y1FnWdBt1ikSWDwhtJIL0HTGBJee1m1ljyvwh9gCvYa7uR/W+Dcb4gQsbFS9dOt/E5QxCuVpo28n97+fT1CSjyLbZFonnFfU3Nx1KY6FbZ2Ctzu/IAVEbrMc5/ySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tmh1dCxZuDVpegEWwz4s/MEsuA4Y58vGnEhunl81M9c=;
 b=lf0keIvGpAmmZwpUL0wj4XnEt0l8MWMtQrq7I3WZQwfseTT3NDJgSsZ7F4qG5/0ldzL6LWOkX1VdTA4Bw1mKAFA4vjFui2gtsuDlD+8EznSiSNbiqa0LkFuqgajBgwaopZAo4K1bTM8pItQMM3ogkCevC8/OxKAAfar0fg8KahA=
Received: from MW4PR04CA0281.namprd04.prod.outlook.com (2603:10b6:303:89::16)
 by PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 00:05:12 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::71) by MW4PR04CA0281.outlook.office365.com
 (2603:10b6:303:89::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Thu, 15 Jun 2023 00:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Thu, 15 Jun 2023 00:05:11 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 19:05:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 17:04:43 -0700
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 14 Jun 2023 19:04:43 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, Stefano Stabellini <stefano.stabellini@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [QEMU][PATCH v8 08/11] meson.build: do not set
 have_xen_pci_passthrough for aarch64 targets
Date: Wed, 14 Jun 2023 17:03:36 -0700
Message-ID: <20230615000340.1135-9-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230615000340.1135-1-vikram.garhwal@amd.com>
References: <20230615000340.1135-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|PH7PR12MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a591755-6b9a-4550-a020-08db6d34305b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O0TQ7aBWRL+FNHMfzIIZgwWxvnkKn/+71GE0GEzLdoi/8LUcGvmX1ozN7CgI35fs6yRaL6emiBKIVbMXVaJ183/w/2rHWPMBUHMRk6ExM/Wrg2ktBwAoOf7EbimWiX67+SuZqQfrm8DOSLQh8ekz+WedVkyWVzpYqZwwozMzeS7tKae42DLtOQFJ4sR+Zzmx5vPDD8Gr67gFh59sitjIJ7ZBEB39xZybwfw4AY56pQsBZrCuisxR7MyJwrTGoWPtyhCiG5fHwffwyoSSi86xvBcu8pU8kQK0XVuVKH73oXvTTwotQg1vWPl1l73PXEPtSB8qU3FZVgOHDSjgL1QKS31310ScQaEVV6gerPgwWXn2mHXEk+WQ3gAyj/l/9rlaPFTIY+hOIaBuupobjH7lqNtgtiO0MCtKXUSAts4v1ol7sccfNODB/JOXEASINki2lgnI9McCB9fKurh997wV9rOicnRhcocu0vodePQtFcuG45UEMb8mYkcAn973pxjGhALy46adxo3oo/qaTm98nZQ/wp8bpiaSMOBn35iEwQCC+Iv5Se6+uLbbHD25LJl2FA95Ri7x1NHPg6lkJ4iP1qw4CM5d/Y34XFzIPYtw89F5xl58AKgXY4DcZk6unLifLyog8DQuNVYdk7FEUPFmMy3/OJ6lqH4Iou4YPaYgKcrOEQ1AX5Y/U4YR7iylFfVLntBLn+i00/ni54PJi6rpxPoxthJrVWhIbH7mQYY4do01Iq2ZcLcQEf850J4C5b6j/gxgxwJ1TFijE/dEx9pc2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(4744005)(8676002)(8936002)(82310400005)(2906002)(5660300002)(82740400003)(70586007)(70206006)(316002)(81166007)(4326008)(6916009)(356005)(36860700001)(47076005)(83380400001)(2616005)(54906003)(426003)(336012)(41300700001)(36756003)(478600001)(186003)(1076003)(26005)(40480700001)(6666004)(40460700003)(44832011)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 00:05:11.8532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a591755-6b9a-4550-a020-08db6d34305b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::60c;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Stefano Stabellini <stefano.stabellini@amd.com>

have_xen_pci_passthrough is only used for Xen x86 VMs.

Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meson.build b/meson.build
index 34306a6205..481865bfa9 100644
--- a/meson.build
+++ b/meson.build
@@ -1726,6 +1726,8 @@ have_xen_pci_passthrough = get_option('xen_pci_passthrough') \
            error_message: 'Xen PCI passthrough requested but Xen not enabled') \
   .require(targetos == 'linux',
            error_message: 'Xen PCI passthrough not available on this platform') \
+  .require(cpu == 'x86'  or cpu == 'x86_64',
+           error_message: 'Xen PCI passthrough not available on this platform') \
   .allowed()
 
 
-- 
2.17.1


