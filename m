Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF04D78F1BF
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 19:20:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qblJw-0001sT-DJ; Thu, 31 Aug 2023 13:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qblJt-0001rf-EK; Thu, 31 Aug 2023 13:19:01 -0400
Received: from mail-sn1nam02on20603.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::603]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qblJq-0005uV-7a; Thu, 31 Aug 2023 13:19:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SodR19civSaYezaXZ7fkG9E/0X0kKFqbHwef2yH0zCaPtQB1a3E2VECBDXS/lqfOoosidSQtS6bdqsfT9CWZ1PnDNMB31Dg/5ZDHuVcLP8LNB8hWmmuhZ6CPA9OTRyRcj1PJmDZdkTm+cMOtAxSdz8zsQ65+f3VckVvB4cKDizON1udmFlAW2VLIiUHGWgsZCkFRS/N5VqsbsZtgrrWqfx4JQnXzrCW+SnfQgDbabJhzcRTnX92fTSDeyPUikLoZ4H5sHf/pJrNzFFmZDAGnYERX1t0eNQdnzOFZirgEcSoTb29J60rmHFmSciaKhXkzgiKOb1YR8khYV2qcxP1JtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EnDUgUc3qTw/RNMR37PEezNAVJvfhhU9I37o14tguU=;
 b=gFfI9XnawWfWqYvNRBIsoIOXpzKMoNbzML0dhBodoiYE/7W2tUP/NobfEc5gxnFA29378S9TC7VSYlcmB+Wxq6p9/Kgzce53kd8kL81hx8TtiUaL0SvMuYCxZwNusxFdwVY9s73ARl39ybmfZfmobwOdJq8ah1rF3tbYEsvHbM0GaQwQ1KDUFvNJBZQvqpG8tWIgfEAUrVLaQ8l+BA3K+I8J98zvxcToH+Sma9QsGaxhZy0I/PNZ2yYMT1ytIK5qHBqMwpRJ73Bzk+zhPpL8wEHjmXmOHPR6NYPI2UBtxn2O10wcFCq5MhXwrEvPJ9pzGHnewMy6TyKV5A4q7VGigQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EnDUgUc3qTw/RNMR37PEezNAVJvfhhU9I37o14tguU=;
 b=mFelVaCdKyedpgix6Er5U4hHFSk4xbXtNOuJuBwDhxpv32O7wV5EwEY6j9ovDX75cwoUNkVqKZBYGZLaEu0Pasj9kce6WwudujsSwPr8Sf2uYDTU7nyRqMJQrMxCtqAXy2Dcc+YYNSgHtq8kVqZ0Ezb+UDBTT5KiwGvkks8/PhU=
Received: from CY5PR03CA0015.namprd03.prod.outlook.com (2603:10b6:930:8::43)
 by DS7PR12MB6167.namprd12.prod.outlook.com (2603:10b6:8:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 17:18:51 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:8:cafe::15) by CY5PR03CA0015.outlook.office365.com
 (2603:10b6:930:8::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Thu, 31 Aug 2023 17:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 17:18:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 12:18:50 -0500
Received: from xsjtongh40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 31 Aug 2023 12:18:49 -0500
From: Tong Ho <tong.ho@amd.com>
To: <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>, <tong.ho@amd.com>
Subject: [PATCH 0/3] AMD/Xilinx Versal TRNG support
Date: Thu, 31 Aug 2023 10:18:46 -0700
Message-ID: <20230831171849.3297497-1-tong.ho@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DS7PR12MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: 312038fb-d358-4e6a-7e24-08dbaa465862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +pWSvSiXsTRabO6eaaVs8AmJ/2tE5pq1ngTJP4PJAlIi1C7hic8TR4/cb9aDLkWYFf3zRQQufYb9S5s8Y0oY4UxVdRQVc77pbyPtPNLAaq6OFCa1tX9sTNSBzsH4Wb5RkVhTobF+HYcGEVdBSw4YOnDJCix0oGU37X1B7tpY3fzjm97iZyiVsP3lh7xopaGxSk76PlHV5TV6r1CcZKmyM9mBmLP7eUpkWzzAyJsOuWGKdHMXR4YgLXs2INfc5I4ZoTWaKhhG9AIdMOfmwjmigrxA3FrXtsPL5/3PIm3a4uAw6s6wg9j+DjJhWhVhpFwGmdyWHMEAzwEmoUBNlCfSSq0JghbzYp0OW+wesnr+ZrjaWLxvPXg60+RBYSgd1Kmg2ru7nOB7g23tnomaP1VxiwKOF6W8q3BSAPYVdXEkLuhtrRqdXl0lcX6K+8zjbEjkRBUnMTtWPuH9op+yksTEezy03++zd9HNU66WKmLzSwvcnLF205BZg87Eoe0DmP8Gt+Rl+0bDcPwc0c3kcvzvgXxTtDalEw+MvNHIuymwiiNBvJHiGVh0QrJ2EQEF9ZdzjOCf6xqWzOnNH/rKjTbafRcSM0UqHAEryoDufzKHRhYiQYJ7T/Aha6yGlRY2BJNATDeFoDINcThjKXE1AxKTdD2QzzVQLbjqb5IJ0+h+Y64vfunKp5UpGXtuzuKnPko4n8tkSt0VuYR8uN0AXTrlPF9fphzRNcnDTU/4ofJHvgLzsw+d5JzwpNWD4awtAsqS9GpD3s/MfDPwEpDUwRvgDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199024)(186009)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(70206006)(8936002)(41300700001)(47076005)(83380400001)(4326008)(40480700001)(8676002)(36860700001)(478600001)(966005)(6666004)(54906003)(426003)(336012)(26005)(1076003)(6916009)(316002)(70586007)(2616005)(2906002)(44832011)(81166007)(82740400003)(86362001)(356005)(40460700003)(5660300002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 17:18:50.9245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 312038fb-d358-4e6a-7e24-08dbaa465862
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6167
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::603;
 envelope-from=tong.ho@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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

This series adds support for the True Random Number Generator
(TRNG) in the AMD/Xilinx Versal family of devices.

The series starts by introducing a non-cryptographic grade model
of the TRNG controller in the Versal family of devices, followed
by instantiating the model in Xilinx Versal machine.

The series ends with a q-test for sanity check of the TRNG model
in the Xilinx Versal machine.

Best regards,
Tong Ho

References:
[1] https://docs.xilinx.com/r/en-US/am011-versal-acap-trm/True-Random-Number-Generator

Tong Ho (3):
  hw/misc: Introduce AMD/Xilix Versal TRNG device
  hw/arm: xlnx-versal-virt: Add AMD/Xilinx TRNG device
  tests/qtest: Introduce tests for AMD/Xilinx Versal TRNG device

 hw/arm/Kconfig                      |   1 +
 hw/arm/xlnx-versal-virt.c           |  20 +
 hw/arm/xlnx-versal.c                |  16 +
 hw/misc/Kconfig                     |   3 +
 hw/misc/meson.build                 |   3 +
 hw/misc/xlnx-versal-trng.c          | 725 ++++++++++++++++++++++++++++
 include/hw/arm/xlnx-versal.h        |   5 +
 include/hw/misc/xlnx-versal-trng.h  |  58 +++
 tests/qtest/meson.build             |   2 +-
 tests/qtest/xlnx-versal-trng-test.c | 490 +++++++++++++++++++
 10 files changed, 1322 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/xlnx-versal-trng.c
 create mode 100644 include/hw/misc/xlnx-versal-trng.h
 create mode 100644 tests/qtest/xlnx-versal-trng-test.c

-- 
2.25.1


