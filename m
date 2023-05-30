Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF2F716F63
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 23:08:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q46Yr-0000gK-Fm; Tue, 30 May 2023 17:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q46Yo-0000g5-Sk
 for qemu-devel@nongnu.org; Tue, 30 May 2023 17:07:18 -0400
Received: from mail-bn7nam10on20631.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::631]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q46Yl-0002dF-S0
 for qemu-devel@nongnu.org; Tue, 30 May 2023 17:07:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+V4ReExN6b7IzhLNoZjPbQvmaQA5xSha9GJN0PXvc/DUSgDk7p4pe3wxMvcAg5qI7EUprHxYHWzGhq2jMREG6HQBFNvxRlTsNPKkTnqIY+hE0sq51M5g3Z0qTMsrIr1G/oz2vWRucTh+iT/qjkKdFB18+JO1xVJgLhe//kjpuTBiaFCjaQ++1pO5h+BjPjKNLpiy17w2gYSwXHsglTHjtj5/pbswCEdiTZwl7OBDwDdNWS00IhqEb4bPdI0Im+/si9z6RPnsltTvrINN6JEqLpX+P6D8T2zZ4lGNoP8eIwuBg0oNp7TGqzA3GYvMBj3gqoBbMZUnlXq/P3urcF/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuTnaiNwRgS/HzvbCVFLqCN/yHiJ9clpF2sbt7MRWXU=;
 b=jU6AL537CHs348ANWRlBRDs40w0Xa2b41HK+EWkwe0fh4g4JH5k8V3ARXS0IFB7GeN6ug8L1OmGOg/We7eoMJhkiWX0hoqhJmWy8vNHfjyOh7hSLO2F1bP6OZNivUBcKPbssAvOjwaLvvvCtGiMuRAUinMUeWMrzUKg45XXql5WaxHSfQ1x6xtwFl4qnNmm3PFwJzHn58OCvgWY8MB21i622khXG7nnR6zm+EJ4zKmBHqLL7bhqkOS7HR+19R6Gb+KGLDXf2A1gOWJUlZWSNOTrnEv2RT6DrfXDjza9S8NZBpMwbDMS5weX83EywcLQPvNKbjcb6wlCdaMoH0IQsww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuTnaiNwRgS/HzvbCVFLqCN/yHiJ9clpF2sbt7MRWXU=;
 b=MWR5VKyEL0e/hGFKCmQa0P0efFaVQ06S2tTQFTkvjv/RJha2yZUQP8Ivv006hC+hk0z61zzkoUeKYyw+1FEVG8v4ANRM49hr+HNqWiFvkpel9Ets1AGR/0YR+FxDWkpF+/e/k13m6cquqRG3ZmZIv66LqCBb80D11OoaUbMVhZ4=
Received: from BN9PR03CA0665.namprd03.prod.outlook.com (2603:10b6:408:10e::10)
 by CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 21:07:12 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::e3) by BN9PR03CA0665.outlook.office365.com
 (2603:10b6:408:10e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 21:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 21:07:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 16:07:11 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 30 May 2023 16:07:11 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, Vikram Garhwal <vikram.garhwal@amd.com>
Subject: [QEMU][PATCH v6 1/4] MAINTAINERS: Include canfd tests under Xilinx CAN
Date: Tue, 30 May 2023 14:06:59 -0700
Message-ID: <20230530210703.6707-2-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230530210703.6707-1-vikram.garhwal@amd.com>
References: <20230530210703.6707-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|CH2PR12MB4280:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9c0a6e-e013-4854-5234-08db6151d683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iKHDoGT+a/gLx1SqzyExYncEEBCFhPPXr6s/5zKnUj1C0aEBTP/Pwv4zkoJro/uQooBo6VRsKMMAva7kryZhFlTzdHZVQVeFHO2T8jn92IycfbZgcTQfsHocZB0N3KVAWyQRD6qmCUZUDrSxPcuQWFwYDD7cQybzDIMJZTKQKzFe1jDSsD6zzXyd3ALQwgEtXRCxKAPtg/CLtDOZQCbkWLLUKe7zTM1N074eUlEpFkHQbPZ0rT61p88H41UxW1bGXlH1JTe9Dqk3ZlpAEQlMiqY2ma2ujTySYOOzMkXfSovXV9TbOeulprn9x4xhUfPfKBzJ1D2ySUqYULcJFuYFoCVzYUDcgVDMEOsUwayDszkKz5ITi72XNcgbNyRvYhvxA5c22fj0Ej4uWC8Y1MJOSKpcs6w+wPvZBrfKSSYM1WQzVzWvSu1fr46+lmRxeP6WweCzgN23UX/H3lw7+/ybsKO1oidiMdWriK2A/AhtKprK35UShEDrPUv7Jvj3lTt7vahqo0chm65bJuBi+LqmDPFfi7zktLH+GxBp/4VE01iUcCQUCJZg8UFvMco1Qa2gO8RIbozPdp/c5TZu2svGGoKFgoDTPs51147ffs3qToAtVR+RdsVTfYrJiSAJDKrkqe02iJQvfEl03PUtRNGB3uGSpTKzmdi+WxadzSDaHfkK2SZ/jPP+LDfMT71fjt49ziRu/nGe8XPg9LguBdHAMI+qMM6OlxU+nfvkfNbeCVug+QyOFJWLwUp0DtCMhA7Mo7VgVI9WeFZDZXxn+mBCHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(36756003)(54906003)(478600001)(40460700003)(2906002)(8936002)(44832011)(5660300002)(4744005)(8676002)(86362001)(82310400005)(70206006)(70586007)(4326008)(82740400003)(6916009)(356005)(316002)(81166007)(40480700001)(41300700001)(2616005)(426003)(336012)(1076003)(26005)(186003)(47076005)(36860700001)(6666004)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 21:07:12.1764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9c0a6e-e013-4854-5234-08db6151d683
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::631;
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
index 4b025a7b63..1d73f182c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1817,7 +1817,7 @@ M: Francisco Iglesias <francisco.iglesias@amd.com>
 S: Maintained
 F: hw/net/can/xlnx-*
 F: include/hw/net/xlnx-*
-F: tests/qtest/xlnx-can-test*
+F: tests/qtest/xlnx-can*-test*
 
 EDU
 M: Jiri Slaby <jslaby@suse.cz>
-- 
2.17.1


