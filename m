Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8F77266F3
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 19:16:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6wkn-0008Tf-GW; Wed, 07 Jun 2023 13:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q6wkZ-0008TM-Fo
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 13:15:11 -0400
Received: from mail-sn1nam02on2062b.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::62b]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q6wkX-00067b-Mc
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 13:15:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zr+l09XxV3ZOqW0edYtGc52dhsBHJF9pJL9S6577YstsEncD7BIRYWN/tMNfKXz0jUDq02Y9u11JeaowiHKc+xtErGOAU8/RNcz/B2/LkjFpVFXIqC6kVtYeqXLE4cnkSyYxyaMh57+L9Txk8jUQjGCAhFRSWGyOX3a8SmhOsBfud6DjLo6Zr1nE8zO1HL2AFEzyy71yD4+UEjmtN5ExQF2Q+W/Hxx7wKULaVXamo1iUaUiYtT0SDjdndsBEp2xlhN5NXbMTMANHDp8zD6U8F/KuNKVns7oN4UBN4J+9YUO/pX1OsCkdiN63c341TB6U1jTR+pTTVFRAtK1d+sJtSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1bg7owrcg+uv5hoA3tdC2YoQhdAsxcDcCsQocCuPE8=;
 b=nRhSkSfEIAWfTC21fL9x+jkczCgV19j+UGW1tK4zb+JdtRwe6vM0cTB76aQSh0tPJ4R87OoJacGPZTgAuUUsQl94mHVe+hZ0b3IbA2+BBjK8wiMuWvWPQOjYOtaAQtV9PPS2XjTcebVmr1W/KDrPmZwgz28NJDVxmbU+gY/vm4uqYrJ8DbSd5CUZg6OOVjdbP+2j7ELpDPkaSpA0FUBEA0V2CoX4jWeVWkDB5MpVG/tSeSnYdHPZ8JNxAq2gO/8i4PTkifFx9bUbDyf7SWBtzXn25l439fEnkTVtx603h0W91bKhBb2RP52Asb+r2Bxx7GrxDwEyGiVjIuW8EmJtWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1bg7owrcg+uv5hoA3tdC2YoQhdAsxcDcCsQocCuPE8=;
 b=kuqpADa5FnYwI5Ygthbvm2HSV59wNXsKk+CCRiN7o11C25yHEUqIVBRq4bnaC2z0sFaOkakQP4ttLaEHUoQqsEJlkTBW7SRKU9o6jg0CJZYYtUOGIenH8450mmFV4bzNDEEbud+R4uuvVqUNwLgca9oZgKTIhMo8C23clyQ5jZI=
Received: from DM6PR07CA0121.namprd07.prod.outlook.com (2603:10b6:5:330::33)
 by BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 17:15:05 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::a) by DM6PR07CA0121.outlook.office365.com
 (2603:10b6:5:330::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 17:15:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 17:15:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 12:14:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 12:14:55 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 7 Jun 2023 12:14:55 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, Stefano Stabellini
 <stefano.stabellini@amd.com>
Subject: [QEMU][PATCH v7 10/10] meson.build: enable xenpv machine build for ARM
Date: Wed, 7 Jun 2023 10:04:59 -0700
Message-ID: <20230607170459.14722-11-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230607170459.14722-1-vikram.garhwal@amd.com>
References: <20230607170459.14722-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|BN9PR12MB5052:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c581ad1-1b01-4c8a-c4ed-08db677abc9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WjBtkQL/V9y8QWv1Ww71BDTV134X9xyno/ISwJmfrxaE7hId/45lwj3IbOwDmj56GBPJ2hByekVSkLBvciLBP1MbS8jHwHxZ+menaUbtsSWAZYql00PgMy85LO9ECL5bMEPp865vPrGMHPDGmz2FCJeNRwdG7dExGV1lVpED3npcBspob1A600R8OQ7U+b1NcH8WWktC1gm8h2FDp7eZ/JHFiQquCa5WJZibnrfLwejhU+7TMciHWULTXidp1s1IYcMUyw2Tud/CIqsfYrPGggb4ZvFmHwrk8kNDGWnony89rApYHPVTScYY5WFBYOSUuV3tDo9R6leIdnSAbyqIb9gtceEggd05kvoRruKjXA52gkrqGZG3d4rJ1eHAUU/tCZskTEmBtThYn7pGAMBTUCRnsBEPT8sqQWElXQ0PXLrxybrPzNW8VFnGtVckOVNuq1zq4lR3wr6dghUch7sMtXOCgtgn+cWi3M6xt8pdew6lYI4Q8IbgAdKl8MsghJ/GFZzfhdKDze0RIjTt5y4RJB6859watjy1WArFoUZOcLJTUpcShdAu9eHEUThi6tCu7Mki73h1F325wtbIkqgB+oAfHIvzAXnkpDgk3aSWCY3lj5q9ryIkLLMpYCsmanSsMy17G/CFqgnMgxIF63zq6PIZUt1bqFJM9tbfMi+NAea09hxdL9mosuYYM+Gzmnlwi8l4xKI0gqW1dsyoc1Vuh5CUhbyvEOD6OuhAnwQzSvRCpM6tuQdpCRyY4kjNgAtV1UfWDqqSApsEgs7/L0SnfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(1076003)(2616005)(41300700001)(336012)(426003)(36860700001)(26005)(47076005)(66574015)(83380400001)(186003)(40460700003)(40480700001)(478600001)(54906003)(81166007)(82310400005)(4326008)(356005)(82740400003)(316002)(70206006)(70586007)(8676002)(6916009)(8936002)(44832011)(5660300002)(4744005)(86362001)(36756003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:15:05.0246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c581ad1-1b01-4c8a-c4ed-08db677abc9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5052
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::62b;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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

Add CONFIG_XEN for aarch64 device to support build for ARM targets.

Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 786c69b06d..afba3b6441 100644
--- a/meson.build
+++ b/meson.build
@@ -136,7 +136,7 @@ endif
 if cpu in ['x86', 'x86_64', 'arm', 'aarch64']
   # i386 emulator provides xenpv machine type for multiple architectures
   accelerator_targets += {
-    'CONFIG_XEN': ['i386-softmmu', 'x86_64-softmmu'],
+    'CONFIG_XEN': ['i386-softmmu', 'x86_64-softmmu', 'aarch64-softmmu'],
   }
 endif
 if cpu in ['x86', 'x86_64']
-- 
2.17.1


