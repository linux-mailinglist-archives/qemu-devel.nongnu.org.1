Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E4574B963
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 00:09:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHtdm-00037W-NV; Fri, 07 Jul 2023 18:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qHtdk-00035E-W9
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 18:09:25 -0400
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com
 ([40.107.236.41] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qHtdd-0007Bs-2x
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 18:09:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ca2nHDmco1Rupw6Qgk9rjLUy2jDH1RFeXmUATmT1YWFeWT5lJy+AM0UTtXxPMWjzxyxiuMQqoINPbETJvaBMhwW8LDvmYNrbPWxXBgJEJI1k9uVyIGXe3sFUPC1zMWeSiXF0K2Xu9Z7zkKu06s+/ps51INBZB+cKOsgA29GeWmBSOMGRDJO7owZIQnu3WzRbEcC6kMy8LMyeuvIXi0Pl3iEcaV7R486dI1UqtYSsOrNN3+KpY1ZttaESrGpFBogj+p+7QTe29JuBnrU64KnOJgxBbgm/hB0Ezn6qvoq1FZld3FiLrhw631fqSGnolT3/dcvKziSJBa++FBCJXC+wzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEHCi9qXZGsX4uwuftacT5zzo4zHv/fy3AG9dFsQvXA=;
 b=PaGsozmFhTG6mdTsC/kwz//31hK4vLfnhSOjxP5QH5t5ypQ+kCmoF3LpCFbVY08LS5l3xcAj5/FST6z0SI58ZTYOWamWzBRgdg0G744kB1fEn8r1R4zXxYUtOEmwBNmoY9YcqAsdqaZ0kuEHR3TeBOQgrNffE5k7F2QeDxZxC9w5kE+hVdxg/tyXf8jr8JTt1VnwVkgngo1kg3b2lecHj9LZGQ32W6KYiJ+2KW924+f2V1CsF5y+9C9TdwG9hoC0mYabVjw16fIaxtUQkWPMmgDcfcBKtccF101NkswUDeOTwaRuNoL0OvDlSq0waP+Es3ZKpyZLPk3G5t1UsUhlVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEHCi9qXZGsX4uwuftacT5zzo4zHv/fy3AG9dFsQvXA=;
 b=pBebmsG8lTJp/OqJxq6vC+0Ng2JeJdteP4YzFeiTGiidfbLZYnXPTxiWIpNut5F+od+AkEdHmJn74VLj36HriJqsyTZ33kwcqOtl0k/9YtVvZWRwxd0Jy1tJ4FS2D5wc+JeRyyHwksyQzOUPUJkCgQ2dGxCCC1XVg9VbHhvdO5A=
Received: from BN9PR03CA0292.namprd03.prod.outlook.com (2603:10b6:408:f5::27)
 by CH0PR12MB5265.namprd12.prod.outlook.com (2603:10b6:610:d0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Fri, 7 Jul
 2023 22:04:03 +0000
Received: from BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::b7) by BN9PR03CA0292.outlook.office365.com
 (2603:10b6:408:f5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 22:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT098.mail.protection.outlook.com (10.13.177.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Fri, 7 Jul 2023 22:04:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 17:04:02 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Fri, 7 Jul 2023 17:04:02 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>
Subject: [QEMU][PATCH v2 0/2] Add Virtio support to Xenpvh machine for arm
Date: Fri, 7 Jul 2023 15:03:56 -0700
Message-ID: <20230707220358.920-1-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT098:EE_|CH0PR12MB5265:EE_
X-MS-Office365-Filtering-Correlation-Id: 004034d8-05fb-49e3-7fc2-08db7f361363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tIDE6u5vfh6PJJJc1KCqKF4Kv1Ag873t1F1FT8fREQGWZHDc4EriLcedo3UnaDy/L2+kS1z0UhOBI9Io4NPycUSAn1OsRjKLfwGLrGzY3+Qw00sNcCvIFl+uQ3acwRDifXZQADlXT+tK5inDFYB8U/uXC5Dg5aoWKKmTs8RSyxEmh3UNQ7lAFIAfwIfwvtojP5KA3mN9CUByae2Thk2Xe60MLb64qT1JwxyJCtCHxEeAGWQA3VnYPx1GiocofbeRBMX7lF/p2EE3TnGz7GIU4eJKfxrIiHUr1RcqKt2M7MfmBhCtlDTXj9mCogtzRGH9bPdcv4V8y8GRamD1+u5Saa5CJqvQohGtlNdC/hctNTFK3aFDIhI/+wgOR9DJNKTY1GdjVQmL7LfLiCC/bacBmDO2t33WspsrlymWLuD2ppvmmdrMLB42xvwhhoXtfkHJ9vjfLFvVfEQBTITaJaZll0VOb5pEMzwfAZdXRr+3rA7ErU4OKEcegHwzGsDDfDf4KR4M+xVwwW/36eUl5dUBixbgt3Jukk+F7lnXep+lxNzZTEQGHQ/DxBhpiZf4IO8vYaPThahzbyl72aKJD9Cref2GaZnI6lUsLdgV6OooSUj2fuDDMtc30fDxiy2Xb2P0b8GyF5TaZH2Y+ZTLBuGTGC+cjhpggHLP56J4xfeHBkSUrdvVY+GurGPPetHxDeOr/2caTZ6jMXuwHPT1KGNGEcKOAzUrULFhV4gDOHd7JP+mLFRzuF56VoJAGG+4k1IcICpHOppLFUtpyQul3E2mVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(36840700001)(46966006)(40470700004)(6666004)(478600001)(54906003)(1076003)(26005)(186003)(2906002)(70586007)(4744005)(82310400005)(70206006)(41300700001)(6916009)(4326008)(316002)(5660300002)(44832011)(8936002)(8676002)(81166007)(82740400003)(356005)(86362001)(36756003)(47076005)(36860700001)(2616005)(83380400001)(336012)(426003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 22:04:03.2056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 004034d8-05fb-49e3-7fc2-08db7f361363
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5265
Received-SPF: softfail client-ip=40.107.236.41;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

Changelog:
   v1->v2:
        Add reference for VIRTIO_MMIO_DEV_SIZE.
        Update ram_size=0 print statement.

Oleksandr Tyshchenko (2):
  xen_arm: Create virtio-mmio devices during initialization
  xen_arm: Initialize RAM and add hi/low memory regions

 hw/arm/xen_arm.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

-- 
2.25.1


