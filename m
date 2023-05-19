Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B48BE70A0B0
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 22:39:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q06qt-0007wT-OI; Fri, 19 May 2023 16:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q06qp-0007wI-00
 for qemu-devel@nongnu.org; Fri, 19 May 2023 16:37:23 -0400
Received: from mail-bn7nam10on20613.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::613]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q06qn-0000AO-4x
 for qemu-devel@nongnu.org; Fri, 19 May 2023 16:37:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCOR5pTZ7zkcmVUEKMFR+wccmwbFg+DihdStUXA8QNI1tFGBOEIV40xwmrsI+AyS6rxaaBVcgpzOXU0fVGY+6VEFVml7jtATmPl4equYRNt6RhciazZWk3pMRDuxZTM2/5vtD0bk+D7yw2pr/Av6J6E0YPz8JERBHktz+BIdSXMlCHsiPv4rfu6yIP2BfTkKgxFcbUV0lfC2HUQsFHaSfFhuHPYPo3mR0/jsyf0u6Ev8n9nn/SNQ7x/EHUVV4GUv36A8opZUyIAWPFDqWAwKfHFpt7jsau6i096rlnIiLdos3x8KyvAd5NN9H7QkinfyPIprSjzdU0PftHGEnk1axA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7X3vj53/YA2PfG1xtZNzajmCZhtsYn+1pjUOcxl53c=;
 b=Cvf1tok6uaLobOD6XR20jYmEt4N21ZlJ8j0oHkyksPl6TSOhxbEaEG6seV/Yd3tSslD9HuxLmCQZ2PfOGTSC5pw7mZt6Lg5kEmoHSwq7ICeV97bssxO+qigMBzCPb7klaBI81FFc2qN78gi58KfEHnusoL9NZlJcVW4pFDBmkMeAvHY53H9qkBQjAsLRHgo79hKfnx+kcspIfoECm9lfttbmbfy/5BfdDqUhrtAABqESGjMUP3eHoVcnZ8tYYITfx79MOgp96PvUs5E1D/QRVJhJs8WVxxKDg/17h1MSwvEBs0UsZ75z8d9qlVaI3IiYDXmUpXinIvfZM9MCjhVXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7X3vj53/YA2PfG1xtZNzajmCZhtsYn+1pjUOcxl53c=;
 b=M446/qBGG865Q8UMSHqFqznEJ8cfdoNYsObuVffY5FwXj04CIQckh7HWMmvBnBxInD5gKg2zSl1VL3OEW1LeIK9AQjMYQH8u0+8eRa8gd7vchASFEfem9PIzOSl+VxnBahOcQXFzTPqCgqQNLVUM1mSFqPzq63CSfilpzeNpniM=
Received: from DM6PR14CA0055.namprd14.prod.outlook.com (2603:10b6:5:18f::32)
 by IA1PR12MB7517.namprd12.prod.outlook.com (2603:10b6:208:41a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 20:37:17 +0000
Received: from DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::a4) by DM6PR14CA0055.outlook.office365.com
 (2603:10b6:5:18f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Fri, 19 May 2023 20:37:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT097.mail.protection.outlook.com (10.13.172.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 20:37:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 15:37:16 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 19 May 2023 15:37:15 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, Vikram Garhwal <vikram.garhwal@amd.com>
Subject: [QEMU][PATCH v5 1/4] MAINTAINERS: Include canfd tests under Xilinx CAN
Date: Fri, 19 May 2023 13:36:55 -0700
Message-ID: <20230519203658.21211-2-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT097:EE_|IA1PR12MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: a82136c8-28e2-4887-8bb6-08db58a8d5eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dibyaZk1is71CpEMXl7KVjgmVE/aJkO49bdEAFkq0I5MXdCZfRzyrIxYqsKcr/jLuti6ecmbjnEjhiwH2wLTFr9E2N75BeYkLkiJFD4K/cFR7pKCrDQqEeGVZJ2pJIdJQVBEKnyfiKajY8M7m+IMBhsMOO0EyiBXXTn85+FVGmB6PI4KCl1VRQ5ujFLllZh6lIcxxoyKHvLj+XAlerbsW7X+HrG9BZ+vjah0JywNX3D/HO1Y2RTHZkokv4K/P7wb13dh3nuC1FFKQgkKOOYp3CwsExdFqO5CdxjJUNHKKjW+w693Skp1D9XkhUC4b/NXPku0MDAuNqdg458/aXdWhKnLxK077d1W1IXpaIhEH9t0APuKRJOdjzMtW1I1Rblznhqp8ncBX8DtbDB/lPC3bYmT6vB3+sTFyIkjIY614ZO/nGL+EMYBkSIeSmtiKqkcjX48+optuE+xqOWC85XLkxixYS/7FfiQAk3WEVFREY3EurzanbjrTGlHmCG/+1yc5VHnkm+tF4NF5/Cyve1h/NTXez+t0kCD2PM5r8AysOK+Zl/hKny8Kt5aOXk8JtvPEhukVV6SijDSI1LGqKotLNvbbFuUZRKKUvr4h2LcvCBw2wg583cnSa8Pp0ZDXYJEUitgrupQGcR5kvL7IiA1cSrzWIjgATRpAYXsC5Y6TOSDiV4QUCzv5Y6zEn1stnrhFA1NxNfO9SdANwRQa4xBpgKYRcGpcDkaQXlJGjusZieKMHnmNsd8wDtAMOAD/bGs5J/62LYh7jSq4PjbqTi4/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(70206006)(70586007)(6916009)(478600001)(4326008)(54906003)(316002)(86362001)(36756003)(83380400001)(47076005)(426003)(2616005)(26005)(1076003)(36860700001)(186003)(336012)(5660300002)(44832011)(8936002)(4744005)(8676002)(2906002)(6666004)(82310400005)(40480700001)(41300700001)(81166007)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 20:37:16.9009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a82136c8-28e2-4887-8bb6-08db58a8d5eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7517
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::613;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d0e604c725..e636bb5df8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1813,7 +1813,7 @@ M: Francisco Iglesias <francisco.iglesias@amd.com>
 S: Maintained
 F: hw/net/can/xlnx-*
 F: include/hw/net/xlnx-*
-F: tests/qtest/xlnx-can-test*
+F: tests/qtest/xlnx-can*-test*
 
 EDU
 M: Jiri Slaby <jslaby@suse.cz>
-- 
2.17.1


