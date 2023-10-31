Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD44C7DD647
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 19:48:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtlL-0005KY-OH; Tue, 31 Oct 2023 14:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qxtl6-0005FA-8i; Tue, 31 Oct 2023 14:46:36 -0400
Received: from mail-mw2nam04on2061f.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::61f]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qxtl3-0003lF-Kp; Tue, 31 Oct 2023 14:46:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iq8tcP2W8jtXqMiVDqb3G7LNwxkiotfg4Qq9xDAgNrjdRdRV5JP6tKSurr12nwUTipMpl3ytIsO+CSUuut56nYrswVNRG+5aidItDaMfBAhqyv3oAs579NBn3EugbmALAjzejv3Y8kCrU4zRkhHPcLi6bbPxpW/pEHYnXcbevDWohdh+6Yqz8LVWcp6QGn/DnnzSpXRjIJIgq0e+NQrBzMCUhhQrCGlPO17r1CuLqlchvORHYPmK/pEA98sKjPFDTtzS/HBvie/ij3mdMFAIXJe9+3OoyqyMJD6WsOolcXKqOzC2VEkzSUHsFqz5b3J+/waaSf6qoET2uCjbNDKl2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3cyjvjnuN/u1v7fPP9VRXAo84lBR5H9rvioTd6b7Xo=;
 b=fBMExs/OWyJdvXgIMpXL0KFsXWIlz4Rt2uUGBhl6iEFfG3zu02I2sB9Sfc1bpPKo7E1XUeuS42oJ9q9CwkNDFaitCCMpUQRGbtVrWkO8jJgmH4k0qBPWpiDTeZQ9fDkYw4+XcutL2pQCYzF6dyrzcKgiU8IHz7APFfTZl7CwlXkLcpRrh+/oJIHImCnj7GHyvY/Gj3t4m7bjRo9TQ5vohFdXD1SngHhWycWC6yAXU07bND9Tqzc7u7fEYGwr4OqZugGLcm3C1ixpHSHXpcxKUZ71MApuirvTP1t123sbxHhMuUnUOe4BST7olHRidSjGTnidt3VI1N2J7ikD6R60pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3cyjvjnuN/u1v7fPP9VRXAo84lBR5H9rvioTd6b7Xo=;
 b=qtBhs+ijddIUdj/mew6pBx9hYugg/sJYQYmcNIqt3walOuoiwkfPL6QLQC3pP14x+LNktPkoPEJKCrHc6qKZ+hwfdwWLgd+e3GiiUDCsmnAEFcIhM2D9kqKEDiF63rUBtMtEvNH7XlqgQ7MdJVxCJeV+KBzi/nOfsAkhmpHdC4E=
Received: from CY5PR15CA0103.namprd15.prod.outlook.com (2603:10b6:930:7::26)
 by DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 18:46:23 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:7:cafe::90) by CY5PR15CA0103.outlook.office365.com
 (2603:10b6:930:7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Tue, 31 Oct 2023 18:46:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Tue, 31 Oct 2023 18:46:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 13:46:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 13:46:17 -0500
Received: from xsjtongh40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Tue, 31 Oct 2023 13:46:16 -0500
From: Tong Ho <tong.ho@amd.com>
To: <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <frasse.iglesias@gmail.com>,
 <tong.ho@amd.com>
Subject: [PATCH v5 0/3] AMD/Xilinx Versal TRNG support
Date: Tue, 31 Oct 2023 11:46:08 -0700
Message-ID: <20231031184611.3029156-1-tong.ho@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af83149-c800-4b10-eab3-08dbda41adc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UsC68+ApNUU2qeOeFuk4beocu8UA1XI0lD502pmLN7yikarDzSPNGuSZ+hHggq+tPIXBpiKG4oAXuYvlRj/xPorNVI+oVtkpc/nD5k6GYX7JG/30invIgmzp8nSqfq6iuUwooqpwo+3CD6JPZFgh/wPnPQTSbcQ8qVUY+aDThx/XJA/v/ZYD54Z+pc7YLcb20PYA6LBrS4NBbDv+c8WUb1Bx9/FbTUGGFIGlZfyER8G+HkRKZyHojWCvaWd0SqyHzs1dBg6IOBYHMOnrUWu4WinT5Y4H2EmEwiZQYeBPzIPNFdEXVs/5xzZgq1VpHtu4McFeI5hHFGdjhf0qLzGXh598MIYsXIM42Q5mM2RhejUYqJbP+717OGj2NeKYVY+sTZsAkZFiQ1C//I3n2kWf4Mvx4+KrHgcIkI7Xd8shcXrY563604IiUyzLs3Ne1w5DCGgE1J1VMVCjohc2YyJyAXLQzSNvhmWT5qQaCALaGxddDh//N5fOrAiPg2vhsjxE8uR6tphuhoJ8D0K92118NbI68ZLKVT8qI00jJbje4v/0PEi5YdoYFdULhAWZJiQtzrkHEMqy3gT/34MElspOU2h74UL59lI8RGzRJgyr+4dRYhAKxzST425mv8Wa8eQoELhgD5pjchBydfmReCkUkAyHKRojJjHNxtzRu4pLt2WJNidp6BeFKpjhCYRhi2TQ36DA2Jh+1xXOPICLY9EIPRIZ9I2t9r/TlTRaUxIOqech9gYEU6cskEUWnsor8zRtJjVw1vqLIZd3ys4PwPSWzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(8676002)(86362001)(36756003)(40480700001)(6666004)(47076005)(41300700001)(36860700001)(2906002)(6916009)(70206006)(70586007)(316002)(54906003)(8936002)(44832011)(5660300002)(82740400003)(356005)(478600001)(81166007)(4326008)(336012)(426003)(2616005)(26005)(1076003)(40460700003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 18:46:19.8599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af83149-c800-4b10-eab3-08dbda41adc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440
Received-SPF: softfail client-ip=2a01:111:f400:7e8c::61f;
 envelope-from=tong.ho@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

V4 => V5
1) Patch #1
   Use host-endian uint32 array to seed GRand to ensure consistent
   sequence generated in different host endian.
2) Patch #3
   a) Remove incorrect time-wait for checking status register
      update by device-under-test.
   b) Use g_assert_no_error() instead of g_error() to report
      failed tests.
   c) Rename FAILED macro to TRNG_FAILED to build for Windows.

V3 => V4
1) Patch #1
   a) Simplify the data given to g_rand_set_seed_array() as an
      array of guint32.
   b) Use qemu_guest_getrandom_nofail() as the entropy source
      when the device is configured in TRNG (mode 3).
   c) Allow 0 and (2^32-1) as valid output of the generator
   d) Add output-related context to VMSTATE.
2) Patch #3
   Remove test's assumption of PRNG output != TRNG output.

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
 hw/misc/xlnx-versal-trng.c          | 717 ++++++++++++++++++++++++++++
 include/hw/arm/xlnx-versal.h        |   5 +
 include/hw/misc/xlnx-versal-trng.h  |  58 +++
 tests/qtest/meson.build             |   2 +-
 tests/qtest/xlnx-versal-trng-test.c | 485 +++++++++++++++++++
 9 files changed, 1289 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/xlnx-versal-trng.c
 create mode 100644 include/hw/misc/xlnx-versal-trng.h
 create mode 100644 tests/qtest/xlnx-versal-trng-test.c

-- 
2.25.1


