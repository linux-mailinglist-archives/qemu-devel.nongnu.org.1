Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 404DC7CCC5A
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 21:33:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qspnq-0006ti-HJ; Tue, 17 Oct 2023 15:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qspnn-0006t3-Kk; Tue, 17 Oct 2023 15:32:27 -0400
Received: from mail-mw2nam04on20603.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::603]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qspnl-0006n6-3x; Tue, 17 Oct 2023 15:32:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9wPvpF3LtrXGlZpWK4cgtjwNGjwAY+nLL26lgHOjKlkstw3PnQUtDCtnhYQ7kZGtAa6cQGw5rzHGgFZ0EkyJMyUwnu8o1U/VQhUj9jk6v1oNNXKByqGbz8YqMcmboRc2L2uf7ZY4rC1SungCG5mSQ+KGVH4k6qki61yaXO1NwGS1St4ync0e6v+iskc1D4DvoD5c1GbQkLUbmOANltTnhKpQT6+5u1Uv+908OH6l7pV5W6yTJEkr2YIA2LTmbWpV4zfv4IjGsw15NDVa4ywoLyxuZAI3YJpsHNJOFQoAUDFyJ7G/JHdsxc3KQ75YZROfeRgZ52l4U1doTcYgqCGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2PpJPMLEli0H1jbdkD4Iy1a39gpyhemoraoTUKHYNo=;
 b=DsTq/dCfIK4xfu0iLMK2W7T17TyTTISiI1ptTWnPoErmj+EIpa23UPlph8jnwbg/Soe1qYqsBBWEC7R5k4QHJXW1mk48QYVrkI7KvRkGdJ6Rg+KoIAhY48Z5DGFwM2sqp6WUYm0DU7RwY7SdBuK3zLOb31NKFsEuPJZGVpbLpUF23LCuBiDOSkROJ/UXcXTnO9I5DcSgTbGjo4hTzKzjR3Pn40EGU5663K9EDiKzShpuutF0iklN+5G5uNQoH+73FMMBwHd1ItnJSOmD3ky9yTRYf5BHiA0ri1Wy1RRDNCivTErWX3YpJw8V0I76VD59yIMPhsAyD61PElGw56ipug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2PpJPMLEli0H1jbdkD4Iy1a39gpyhemoraoTUKHYNo=;
 b=D/ofKKW+GbcYue+9YaH2vcpNxUTWJyvjYWH8DzM/99wy4njsu2pZEZ2bEqwJ/NthfwF7nBbiy9c8q0cts3Kg5v9i8gN+TRN18lxx8UgIT2PUlKVZ6j14u4n/m8TMZk4kEy31Kgoa2Y4m1Y84On305Y0mEca6+ROkor2IdG/ld4w=
Received: from DM6PR07CA0079.namprd07.prod.outlook.com (2603:10b6:5:337::12)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Tue, 17 Oct
 2023 19:32:19 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::7d) by DM6PR07CA0079.outlook.office365.com
 (2603:10b6:5:337::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 19:32:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 19:32:18 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:32:18 -0500
Received: from xsjtongh40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 14:32:17 -0500
From: Tong Ho <tong.ho@amd.com>
To: <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <frasse.iglesias@gmail.com>,
 <tong.ho@amd.com>
Subject: [PATCH v4 0/3] AMD/Xilinx Versal TRNG support
Date: Tue, 17 Oct 2023 12:32:14 -0700
Message-ID: <20231017193217.1512868-1-tong.ho@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: f774f362-61e9-4def-84b4-08dbcf47c6d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nR72qtSkRsOsTolvn1zXbhUcF1RL5xofGRTbwlG5PXBiRFRG2s2FsLe9ZOa4J6HtCr2liKX9CaePdx80DfM5jaavkqmJo5qKmfSCIu3w3tf6/ALiesjt3PInq0/I7LGT9bdaT4995x32tnJljUyle3AqrmCOUgjZiKLKzIv/6PDiraV0kqMgdAbE4C+jd0QyBbD2ZHE0g+QRQj4y2GBtEfU64HA1ToLcPeIIYsucirOxA28tQo1dYkYGPPjRA85NKEmyVjPBo7AZdpUsemku0Jy/2msM/e/ui5BsxDFOhj7uLIuoXXg6XqLa6RqZrsiGz6CFLeb16NiySI/m9iH0UNUChUzVYx69q6ZBVWY2V/7cFCeUuHynFm6gVchjxuPZuQ9E64sidNOM4w2C6cMHGVT3k2avSwJZArOWkraO5Cb8LEx/bev8K1JNHQIQHEOnoE1bUHw7VWPFS6h6kMyQwE3mbB1W3rJguWg0njYwvEcuBVakJ+M0Hv7UUVnFhIaXltdBTWY54YtPy877pXWsJYCst3s9rZSp65GYD0BUebtf34rFel6ZgncZ5qRFi/mUMWQSXYtVnZjPi/KGQ9a3P35tHOXlO6KXazEXkI1SjgF3UJgfwENxQMgpgCOUt1Yv6SIRWFqiLGbXtm+yDydYY8GnZ/77l7G/wNwP1JOEQRaR+AJqYXFQlKAmp1wDSgJ61SGaglZiRo6atf1D9KHHkGWgOHoPqQDyfvPMkGu5CinAzegYldfl7g/qRKW9gryg4RG0UpO7cs4qeqMmJ7RN1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(6666004)(36756003)(336012)(426003)(478600001)(47076005)(2616005)(36860700001)(316002)(54906003)(6916009)(70206006)(70586007)(26005)(83380400001)(1076003)(41300700001)(44832011)(5660300002)(81166007)(82740400003)(356005)(40460700003)(4326008)(8676002)(8936002)(2906002)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:32:18.8047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f774f362-61e9-4def-84b4-08dbcf47c6d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446
Received-SPF: softfail client-ip=2a01:111:f400:7e8c::603;
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
 hw/misc/xlnx-versal-trng.c          | 727 ++++++++++++++++++++++++++++
 include/hw/arm/xlnx-versal.h        |   5 +
 include/hw/misc/xlnx-versal-trng.h  |  58 +++
 tests/qtest/meson.build             |   2 +-
 tests/qtest/xlnx-versal-trng-test.c | 486 +++++++++++++++++++
 9 files changed, 1300 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/xlnx-versal-trng.c
 create mode 100644 include/hw/misc/xlnx-versal-trng.h
 create mode 100644 tests/qtest/xlnx-versal-trng-test.c

-- 
2.25.1


