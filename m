Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AE27AA955
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 08:51:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qja0C-00023c-3n; Fri, 22 Sep 2023 02:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qjZzv-0001zf-Gk; Fri, 22 Sep 2023 02:50:43 -0400
Received: from mail-dm6nam11on20623.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::623]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qjZzo-00046B-1n; Fri, 22 Sep 2023 02:50:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwikJ/qv1wGqc1ASN59PqKOdcuK26rF+8GCLDBTDLr+4dUIn3xzltmOfeVfT6yYhN9/jXpaA2jwrn5oBkznJwFQFL4hLRLl3CcS0BugpVvSjzaBw3j2T5InVqdvTAFBRhWdhe8qXbqTUng8BVMJSGwkE/RE1zt+4i8sbGK99QXf1pwIK8BpW3L5JARFu8dlADiy0kKeUF8ZSHenM36flFjzP4IDRYVWsKETj6S/CHeoja2t7gLwi0GRNSWjDQZW+UBnOCmmpqHOczeImcx9em0mLFYxD7yzdqV1i8ClbylwOTCB5aPDiyHnvxLXoMoeRSZtKsEfqnM8z5fyO0yfDYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZlkzWKFd2MF252wQKZNIGioyIJ3sq9C8WilcC+I1iM=;
 b=VcQwd40XdK2yURxD/tv5VxUyASbwCQ0zlF/8JWalOfzY57tMXeopuqvD5ugCZY3wUFXL4p4BQH8Qk3o4BRl1ITaDhhX2klEQ0qAORusrlY6XCzwEhy6vrAtZ6UHjoPd5Mnyw3XA0jwl91hlEqoDy1SfvH0Gv/Bup+xxFDAHiaZn2Qw8A0rnherJEInNaSitLTUS69kChhrNov4TR+W0AorzQz1Ekv0nMj4yqbBya/6FDniOjkipUZq29RxtUneNL+wHX7aqnkhc/2wu9jCw7iuc6BEef8D+jkW82ARUHtdWdS5ldcuRQhgcQ7s4QFMpGvtJS2D6gVfA2XRScvjXRXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZlkzWKFd2MF252wQKZNIGioyIJ3sq9C8WilcC+I1iM=;
 b=CBs3ImdmeLn7g1CKHgUCTFUi1my/E/SfV5NmEE7xr810LkK4YBBk9VQ/L5113IUxDfGpmBwZfhts8jl81tf9IsUXmgOcUSy3PH26gwr+RLs3JRgdqTs1ExBjQgXaPMeElVECHFx4pvBjHF3/66D+VZrJtntkZlH5FH0X63ye0m8=
Received: from BL1P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::18)
 by DS0PR12MB9274.namprd12.prod.outlook.com (2603:10b6:8:1a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 06:50:26 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::46) by BL1P222CA0013.outlook.office365.com
 (2603:10b6:208:2c7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.32 via Frontend
 Transport; Fri, 22 Sep 2023 06:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 22 Sep 2023 06:50:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 01:50:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 01:50:10 -0500
Received: from xsjtongh40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 22 Sep 2023 01:50:10 -0500
From: Tong Ho <tong.ho@amd.com>
To: <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <tong.ho@amd.com>
Subject: [PATCH v2 0/3]  AMD/Xilinx Versal TRNG support
Date: Thu, 21 Sep 2023 23:50:07 -0700
Message-ID: <20230922065010.4071693-1-tong.ho@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DS0PR12MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d8184f-5b90-4ed0-9b52-08dbbb38338f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P9U99DcaqXN2m7FgWbGP2hkFvZfdS/b/Wrw/n7wmVtaZMU//E5aVitsYhCNTpyX3MKZGLP7xNp6D7va95K466+ZkqycUvrUdSEGhqDGRylEkEov+eYaUur3R3511KZPJWkhQvln2JC4JyrO/4QXFfte8NHYLqxkImsdak/kRlYLJww4PFpqG4S/+rEmQgoQTnBlJ0GRDRdpPS80Ek/6jUuhDMVdGPHGQjVBHUg8pnYK3MIH76rNFb4L5BTU+atERFEkBL3ElRj271tbGX7bXIp1CLWZ9LyaNnQdIblu9XDEi29zcXAPCbTXzLTeV59cAw8jo92WPgSfOf7IM8I7wncYWyH1p7ZibwpfsNWe+uv+zzm9vCHDA4bqmZuagvNEWgDwNwavTiQ+IG2e6eStZ5JWSqyDUO03eksSwMefiWU9G0J0a9IdKAm1y/Z3N7BztPO3GdpXWYkBXyrgsPuX3wnsvDX6pm2NNWyp0S6LOWJUxmXru5X31i4r71kTEamAgla3nBdGuqePt6pg3zlRdrCMtCxWfvEh9DYtACXHofWbGWJ60fyzhp5nvHC8Q+kl0i61dqEt9DDdN4Bi1GjiCWymfHf9M2d9aZrIplftB3EKcsv3sK15mj6stjwwsIf1J0JN1+F0c7LOmlHrwsR1r+neNdmIU8fyFP8iOOI7zayVNKAmLhsj8tco7E5sryx3NE7AYUGAwnr9DOyrQT1CANHrNyrI74mzd57E5jPBlb1fe+XFcKzXLM8Ktx4Os44GAse7nyVpEXfqHeRJ3N+qai4dY4ZiRZN37C2sIDPD0vXKGaWau1WJdGClY9odi6zfh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230921699003)(186009)(82310400011)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(316002)(26005)(70206006)(40460700003)(6916009)(478600001)(1076003)(70586007)(2616005)(41300700001)(81166007)(36756003)(54906003)(40480700001)(356005)(6666004)(82740400003)(86362001)(47076005)(2906002)(83380400001)(36860700001)(44832011)(8936002)(8676002)(336012)(426003)(4326008)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 06:50:26.0200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d8184f-5b90-4ed0-9b52-08dbbb38338f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9274
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::623;
 envelope-from=tong.ho@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

V1 => V2
1) Change patch #1 only
2) Use g_rand_*() PRNG from glib to replace V1's custom PRNG.
3) Implement ResettableClass for device-reset.
4) Add device-mode description to commit-message.

Best regards,
Tong Ho

Tong Ho (3):
  hw/misc: Introduce AMD/Xilix Versal TRNG device
  hw/arm: xlnx-versal-virt: Add AMD/Xilinx TRNG device
  tests/qtest: Introduce tests for AMD/Xilinx Versal TRNG device

 hw/arm/Kconfig                      |   1 +
 hw/arm/xlnx-versal-virt.c           |  20 +
 hw/arm/xlnx-versal.c                |  16 +
 hw/misc/Kconfig                     |   3 +
 hw/misc/meson.build                 |   3 +
 hw/misc/xlnx-versal-trng.c          | 734 ++++++++++++++++++++++++++++
 include/hw/arm/xlnx-versal.h        |   5 +
 include/hw/misc/xlnx-versal-trng.h  |  57 +++
 tests/qtest/meson.build             |   2 +-
 tests/qtest/xlnx-versal-trng-test.c | 490 +++++++++++++++++++
 10 files changed, 1330 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/xlnx-versal-trng.c
 create mode 100644 include/hw/misc/xlnx-versal-trng.h
 create mode 100644 tests/qtest/xlnx-versal-trng-test.c

-- 
2.25.1


