Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50557726701
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 19:17:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6wko-0008UA-Aw; Wed, 07 Jun 2023 13:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q6wkY-0008SV-VQ
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 13:15:11 -0400
Received: from mail-dm6nam12on20622.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::622]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q6wkW-00067N-7c
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 13:15:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsHUTX9G7echIG59c5OSkHH8nblncsRjCu1Vo+MZUXjZQAvRD6JihN0E1iNXJd9cE8H40/bCFKUH4ZizL1MBQRdxSTk+mxg46FWDaoYXBdS6C2hiXn4FhZHEnrPoApKy7mmjD9VFhxYgXXHUqU+r3oKhA5TW0fU0+XdpxrOrs9VA+xCpuc2oTJt0gDg0+hj5lnztccO08FL0YT194L99nPoqbxYNrjW4HisYE8ra24rtVHaCBh7KAtFw/Re3DrIn1o4eaTmtWQAXhdU3J2AHiyIBJrMD6FyF06UDf2dRng8dfyNAk695qhtK95loVze+C/zrSojiRd4dCpFLyK9g9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1s7hiqeZJSWKMtzOXD71YKZXs3yYFRh5uwgvUfLYPI=;
 b=OsTYuMRlGKvKnToVolTTfsL3W+QgG55FmZJbPP2jDYlRH+H1b5PPmRC1rLRYL5rx+zvXp7HLe61MyXGuNU5Qq6LPZhvenvMtzhLePO/uqOmiyKj+p04ZO5ICp4JUgpWLzSPx/5nSFNWXD1lDMKP/h5ihwkToEYJsPmOwMVeg79owtYD+xvOtRtB7vDGT46+/Iovw3Gk5XZBIdOVY7Oq19nMA5AAnCVm2FoynvMfJeqAox37HcGKUoNYj7lD6bU0Qnq7bMndj+46thGyuK+f9xAF74zKBaFCiHGqQH7QjPd1l4ApfVIO3LBMg2TcgwFiofiN/7ryS6l8CSp+PDSmD4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1s7hiqeZJSWKMtzOXD71YKZXs3yYFRh5uwgvUfLYPI=;
 b=T5l9Fw+Dq5aLQIwo07PTNGD/nfVa+WfF3hYpDcEoAP9RYCfPwCByymZNqnAYzu2RVPyL4CXhst9A9blGWkfmFkZn1gwtwafGNu+D8lhu1ueS3EzlRpIiQiLnWs7gJEyP52z5BytDnWctVC0TI7YzXvX5s2LhC68QSLEi9PZrVpE=
Received: from DM6PR07CA0113.namprd07.prod.outlook.com (2603:10b6:5:330::16)
 by LV3PR12MB9216.namprd12.prod.outlook.com (2603:10b6:408:1a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 17:15:04 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::c8) by DM6PR07CA0113.outlook.office365.com
 (2603:10b6:5:330::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 17:15:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 17:15:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 12:14:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 12:14:54 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 7 Jun 2023 12:14:54 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, Stefano Stabellini
 <stefano.stabellini@amd.com>
Subject: [QEMU][PATCH v7 08/10] meson.build: do not set
 have_xen_pci_passthrough for aarch64 targets
Date: Wed, 7 Jun 2023 10:04:57 -0700
Message-ID: <20230607170459.14722-9-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230607170459.14722-1-vikram.garhwal@amd.com>
References: <20230607170459.14722-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|LV3PR12MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: 46391a56-5a61-48c3-deda-08db677abc15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +4ecFERvs6aQNrX1PTXLLSt3iFVt/l3YnLsgS2rpp9fZ8uu82/IFYCnyfDn6z9b+hwuPEPCGjg1Q5e0hJeOa8DF6XAFM6SAWkUEkkXv0rUHY/I1WsjTq22lnEx2ai5d2L3Mv0UjWbdu5Lv3IjLJwL5pS8gehfQhA+noRLLyE6nTeXF37srqUFwpU/hVZCPlW4Sx/JmoMV7l/PxoB32QbDaR79SFGdeMHbNZ7YrtuuXrPztp9njSP5v4RJy9ZoIkdUpBFStcD3HMItMu1XwZxqjFbRfrYNsRDcRF+qBZwwSpwGmCi50sYmMbEc+AGvs98r6tmH8sttjBTFN3s5IveVNBjeKFC7Q5DBZshl0jiBXb036jZ9JLKPvEWigRYiuUdrCTsq/Wjlg46NankMjRwhn8x2ZWLRpA4QLcFSnsqqrJgvmdtlwybWAbIXkKhUjH/kBUbnz2elgInyYQoy7YH/v1rKhAWlbelck3xKWvEK8/bf5IOssqRhNqEeEkb8F/v0yb0B/Rg0I9DNqFkbLUQIplIhjrnvXoN9qm9M7s5EXi1e+LeC+VDDpRYyCqXWz1udbOTNWWaYEKhbGDjXRA2q3F4Xd8rAeeakVXg+wY69UksmQxX1jh/fX+/bFJsp0rhh4ptl/WxS4fkbMlDHKkdihvE4K5rg3l7UPw6wBioG+QQxD8iz9ELkkEpWr2pK1H6dhtAK9+UdvvfZAFhP02oEfMeW8AMwtol2Y0fmADzr4vJz6pSZ9fqwFfXR3yzaaklXvWDAgWhq7a78UiAJA3Jhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(47076005)(26005)(2616005)(1076003)(356005)(81166007)(44832011)(316002)(6916009)(40480700001)(83380400001)(4326008)(70586007)(70206006)(186003)(36860700001)(336012)(426003)(478600001)(82310400005)(36756003)(54906003)(40460700003)(4744005)(2906002)(5660300002)(8936002)(8676002)(82740400003)(86362001)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:15:04.1184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46391a56-5a61-48c3-deda-08db677abc15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216
Received-SPF: softfail client-ip=2a01:111:f400:fe59::622;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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
index a61d3e9b06..786c69b06d 100644
--- a/meson.build
+++ b/meson.build
@@ -1737,6 +1737,8 @@ have_xen_pci_passthrough = get_option('xen_pci_passthrough') \
            error_message: 'Xen PCI passthrough requested but Xen not enabled') \
   .require(targetos == 'linux',
            error_message: 'Xen PCI passthrough not available on this platform') \
+  .require(cpu == 'x86'  or cpu == 'x86_64',
+           error_message: 'Xen PCI passthrough not available on this platform') \
   .allowed()
 
 
-- 
2.17.1


