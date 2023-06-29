Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A03742B7B
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 19:45:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEvgI-0003qx-BK; Thu, 29 Jun 2023 13:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qEvg6-0003hG-Mn
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 13:43:34 -0400
Received: from mail-dm6nam10on20625.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::625]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qEvg4-0001UE-MI
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 13:43:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSLsnl/+jir0dNu8tTuprrM81i6eIE/mEughZJWN17kwUHWl0e9qhlV8ueUr4ddusoL1DBqE1NzwyeOXAul+ZHSeey2FYDh1HbNHv+36ziKikAwnOydh7MVGKOe53obXKcSf/rVy17mFZphOiIk0oXzJKEWjeY40VjQJQe4vwG8Y046g9QYiXCS5a9LkyIvkn4pkiAifyPBKEkBwKybzqOZ6wxC6JCTowEZcyM/cObCeuBQLqEHxpclG8A92A9yHCDMMCR8FrIKxnd3sFnm78/Fz9zH8Um1IMv48YRsHh1Xy4QjYiPGoYtZRLGlGEY2lvQZ78525UHQ0hPHODa1QjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73z4cXs24h8gC5xihw8FcpfpTTwRRR/1HUBVeNYZANY=;
 b=CYsjfYJHwcY5+g3HynVCvnmCvR67BG0gC8CBGCb5uh1lvuYoi+uR52OdL39u0dK/XsSQYsBJvKBRurkIFmjr4ddlRosP6kSl83LUzgNJsPYzI5zycJPrwZWIJiZJc/8CIMFL51FnQRDNGdtwHm5CfZWCvQmVpGOsCMA4rAuoXu7RjB8lGtTubQHRkfYMr4788zdxMKR+4HVbvjDeJ1/DYTpEdalVgIpvcOSgK6EvJ/P2X2qIGlTm6p9P/x//aHOh4xv3oZbhluEQGXszuklQzcR/eyFOxFq8+BpgKswaDuGCFjUKrCxcuOu89KW/ioztN78YJBlhrd86jTM35qdbSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73z4cXs24h8gC5xihw8FcpfpTTwRRR/1HUBVeNYZANY=;
 b=cBvOti8kTM1IbzPQuOtYFOND22QhgcsGmhCZlYHfF0HsYeoduTkVFZBqtahbrTJJfTwl4LUHj6wVcYxNASfTUpzziLgKG4qjlRM525ZaEJSJcv2SoYvb5tigy2c2eHXkEqAFQcTGVc3pVFMqtqacGP0cSiQ0+dEzxdhuvo7OLAw=
Received: from BN1PR12CA0010.namprd12.prod.outlook.com (2603:10b6:408:e1::15)
 by MW4PR12MB6851.namprd12.prod.outlook.com (2603:10b6:303:20b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.47; Thu, 29 Jun
 2023 17:43:26 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::10) by BN1PR12CA0010.outlook.office365.com
 (2603:10b6:408:e1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Thu, 29 Jun 2023 17:43:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Thu, 29 Jun 2023 17:43:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 12:43:26 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 29 Jun 2023 12:43:25 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>
Subject: [RESEND][PATCH v1 0/2] Add Virtio support to Xenpvh machine for arm
Date: Thu, 29 Jun 2023 10:43:08 -0700
Message-ID: <20230629174310.14434-1-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT011:EE_|MW4PR12MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: ee379f63-2307-49cc-eca7-08db78c857d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v1h2yU9Lekj1mA49MZEVTBhS5AVJvGv8zD4rXs6n+DcwQwGMbIQSIggrZYFEJlZYHZhql2UROUkg1L6rD9Ihv6rEvwmLlMW+FUp+S/3cB12f80H+upP5+TAQHBy6l3by9RlcaqvzuSHgzxGjOOPQw/DWLJCVEHn75NFcTssPwX3PTnaGsSxrMHHSeYddfGYSrK+OLeEJW5HuTbVmUd3z3N5pxJqUvU3Wz/eRJY3E7Kl40CC5SGs6EC22m8/ntkpo1WNpIGvX1h5tvci87DjgKKkK0FrlxPXpqX2NzxPWpuMYQ0QxjYdnjks5iJZWy53w2DBrTRkJ0wHG71ovegPLGOSwTCmT6QF/hyYNbeCTpAY+66Cbuyo03q76YiewFDifT9ivRhsh1a/K+7IC3C55rfueWeyCMG9npt4mgMk6LiebMyBAqA3GDyE9dE8HoGymS0W8OH/VL5fmuAsbcz1DjIam8kC6X9ecMDSayv31j0JnhY/5q9gPucAIJDWuUdAFG+NYv9Yb9yXS4/lOuFrElhnxTHh18nrLtpfLtDxX253XsDG/zHg/fD7xC9Wcraud0tpO5eb4Ht9nkD5sPCY5JHnjOVPfFYbMXfekOeyQy6X1Ij+lL/w7/wKp1qWXMobK2Y5/2IRnjS+es53zK/1B9fdKkeE2Ta0sHdQM9eDxLZzRIA3Scd8NrLI9mPmZyzlA1Xi8JxIWQTerfazpU/Pa5s9T1sM9axW+C5WzqCCRpOVEZw9gPAcTVn3baNZtN6KiGk+Ta9oPXfSJ1rPf2Zrddw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(6666004)(40460700003)(26005)(82310400005)(82740400003)(81166007)(186003)(336012)(356005)(1076003)(2616005)(36860700001)(47076005)(40480700001)(41300700001)(54906003)(86362001)(4744005)(36756003)(8936002)(316002)(478600001)(2906002)(70206006)(4326008)(70586007)(6916009)(8676002)(426003)(44832011)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 17:43:26.4196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee379f63-2307-49cc-eca7-08db78c857d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6851
Received-SPF: softfail client-ip=2a01:111:f400:7e88::625;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

Hi,
We added virtio-mmio support in xenpvh machine. Now, it can support upto
10 virtio mmio.

I think none of previous patches were delivered to mailing list so Resending this series.

Regards,
Vikram

Oleksandr Tyshchenko (2):
  xen_arm: Create virtio-mmio devices during initialization
  xen_arm: Initialize RAM and add hi/low memory regions

 hw/arm/xen_arm.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

-- 
2.25.1


