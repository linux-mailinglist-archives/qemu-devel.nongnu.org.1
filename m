Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E49A17B8245
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:29:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo2rD-0000OM-5X; Wed, 04 Oct 2023 10:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qo2rA-0000NS-Fv; Wed, 04 Oct 2023 10:28:08 -0400
Received: from mail-mw2nam04on2060d.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::60d]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qo2r2-0000JJ-91; Wed, 04 Oct 2023 10:28:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZlMgb27CgGYS6oyPncmueZ8JpsjEL0Cou8EWEVWkfk8m8Nh29xrMeWm5G1olQ9PbKvBKvJoUhrlNQiJGG5wR9bbqjznHGQqvIPiU8MDclgg52mjMUCD1gpN/V2MunCa1t4K1D878ivqy2oXhOWcmy8eyArrbUAKFdX3sOGmZ74GeHkNKGN1XrorxQpttY0m9JrRFBP5MNKkbxcFhw2/3NMtbjMiWfn2EAD5h6BBA6pmUs5BX6Gk9VZqQOLmrs33O+vjaYDRF/g1RQcio53z6xsMKai+doygvSsPKJiIjiXnaAZy2D+W1dvSBvoSepe5P9T3O5B0Eav2QmMYqfnDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccxfVw/lWHfKK7YFZXZNvn704naqVk1Q79R/MIBIPO4=;
 b=G5txKdWJatwQJqapZt5tTQPCML/yteFwmmei9ywm9wwsW7FB2s014BhoFB0CcnuQKBmPXVbJoqEGO+nZGlZsoKpbLmDca5/Xr3ko7MIypTz3yYtzbHEmOBr9LbUXsi8rS+G6DQrkpYkPdyzsb/KEz3jkhQzbGbNa+/GBIUcvqZ6X9r5tRjHtLf+vGPKeSZaGAYuefqNZPgd1NcnIfiULtVT7Tk6FsGKQ/yK/nv2uljQcNpEAb6NqW574Mbk0sFE+d3E7uB1mgzXnZEyD3x2wq8oNuKwcAHo+5nB1x4onzt3CLMSeAkgRAQYDzpYADQXD0TeN2CrnqKNt1ow76ccEGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccxfVw/lWHfKK7YFZXZNvn704naqVk1Q79R/MIBIPO4=;
 b=ubsFQCswyHp5jUKUj0CLFNXHjC6WjTBuccBEKZF2d1CX5JGNE0BaqMSIQok83fXyM5mVq/k9KxHmrIoeXRzIiznW9cUPkKCnT8BPZLT/xkODbPexgAgO0Uj9cMekUYY1AyGD3qcHlRe1TWfJE5AEQdLRsq7kJbL5fGOT11oFeAY=
Received: from BN0PR07CA0016.namprd07.prod.outlook.com (2603:10b6:408:141::21)
 by CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Wed, 4 Oct
 2023 14:27:54 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::6a) by BN0PR07CA0016.outlook.office365.com
 (2603:10b6:408:141::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Wed, 4 Oct 2023 14:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 14:27:52 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 09:27:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 07:27:51 -0700
Received: from xsjtongh40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 09:27:51 -0500
From: Tong Ho <tong.ho@amd.com>
To: <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>,
 <frasse.iglesias@gmail.com>, <tong.ho@amd.com>
Subject: [PATCH v3 0/3] AMD/Xilinx Versal TRNG support
Date: Wed, 4 Oct 2023 07:27:43 -0700
Message-ID: <20231004142746.350225-1-tong.ho@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|CY5PR12MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: 190aa33b-678b-432c-f3e5-08dbc4e617ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J7ii5AG1jEfLmmCZmWMpwthpi2Z428+khdOgi0iQbI/BR/HGpzlcClJC7vcsKYKfk71wgMs7gPixA7BpHsrL0jENfawHFLzIAH92le4PoGnPn+gEQ+gY21H0AzSYYJX0W+LTfHLsxeTK7M8L5QDuSlnOSZsAqC6rKhAv4YnKdVNPd5LJwa9R97DGEIXDapr/vc0jXInDPTQgdYys8AcsFFGKzNYd2HwX5oS50tv/G3BzT4u10xz1JQTdz/rlPZhGYqIxKyhDo7lv7txoVOBcyA4JNMfgLGsude1RPvGvD5w670zJZzFfEd+3d127EHkCFsbudOWsVauUfgjL/83iWAs5CbjW5CIq1H32qUnJZRnRTaF7ofDWyUFJE4i1siWuHheFnzJn4IBhI0IrTgXsYHnXzLzFfQjksr7ORYegebuQZUpGzzRO0CkBvLbnssjezZt4KJ+Ro+9sYrnrm7/fsdkUGlyte41UpwlNx5ffqUFAZnaDg51n2Nmh2Q8ze/WZ1BSQR1fAqX3CkOkaUMf4NrZNen5XE+7SJe2oaSHivaWksWLqU2kTcxgvPkj5frT9LiawZoAZIrCsYL8EVRcBjp/qL6MHSl9yBR3VeXrwfbAV/R4CeWX1YXFSJuEnla3thjk38CrIZbdkeAfPuYmmxw0CJbvqD/sNaTTdJJ4kLyfa8uaBFXGw/u2lmigzUYIa521ewV2U39ah91+m+lj19O69ZohEzOlxF7isCz9muxKdVmY87vmRRbwjxWVM4c2mify3GlQ+BJms4P2mSxfsfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(64100799003)(1800799009)(82310400011)(186009)(451199024)(36840700001)(40470700004)(46966006)(2616005)(6666004)(478600001)(426003)(83380400001)(1076003)(41300700001)(2906002)(26005)(4326008)(70586007)(316002)(6916009)(44832011)(54906003)(5660300002)(8676002)(8936002)(36756003)(70206006)(36860700001)(47076005)(86362001)(81166007)(336012)(356005)(82740400003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 14:27:52.5359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 190aa33b-678b-432c-f3e5-08dbc4e617ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575
Received-SPF: softfail client-ip=2a01:111:f400:7e8c::60d;
 envelope-from=tong.ho@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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

V2 => V3
1) Patch #1 Use DEFINE_PROP to define a property with custom action on set
2) Patch #1 Remove duplicated version-check on writing to CTRL4 register
3) Patch #2 Defer adding TRNG to machine's device-tree to a future patch
4) Patch #3 Code style fix: group all local vars definitions together

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
 hw/arm/xlnx-versal.c                |  16 +
 hw/misc/Kconfig                     |   3 +
 hw/misc/meson.build                 |   3 +
 hw/misc/xlnx-versal-trng.c          | 732 ++++++++++++++++++++++++++++
 include/hw/arm/xlnx-versal.h        |   5 +
 include/hw/misc/xlnx-versal-trng.h  |  58 +++
 tests/qtest/meson.build             |   2 +-
 tests/qtest/xlnx-versal-trng-test.c | 490 +++++++++++++++++++
 9 files changed, 1309 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/xlnx-versal-trng.c
 create mode 100644 include/hw/misc/xlnx-versal-trng.h
 create mode 100644 tests/qtest/xlnx-versal-trng-test.c

-- 
2.25.1


