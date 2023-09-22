Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F147AA956
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 08:52:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qja09-00020c-D2; Fri, 22 Sep 2023 02:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qjZzv-0001zd-GY; Fri, 22 Sep 2023 02:50:43 -0400
Received: from mail-bn8nam04on2060f.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::60f]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qjZzo-00046P-MV; Fri, 22 Sep 2023 02:50:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8Uyl41FLfCaj89iUKyCbGPH1hrX3bWUNKcA/71cLWjPhBzO2SfssZ4mzCmX3fBa9jqreS7HLRDUPN4wuiTEQixRGHPaqwDj1N08bwLql64GW9DbyCk6YZaZ8X6vPkj5W3SDFfJdUybw9L4cjehsbn3ccsmrvv5UWeYBa4rYfDaAzJerMyt3aW0ySCCAk3kiEF0Iq+s3yMmdcIcQsM16hHe4yNtkOYOIFJRcjY6dvzy2jBoVly47XtffQBxCjUMReIVySe741TG7+zAMBGFbJZ/qU84Y8s9pq9RMV0nYOaCDJc3aFdS14ey4fJzazHVhpOQUgJbOMCq97oD3apK1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uee0P6N3zOFSy84Mg967+zwc0sH7/3W81SNTfXQs9Fk=;
 b=JeZajvtnLYPNqu1PI809nU2fNnKszrjbNPYuS3Xz1e0K3d3Ey57k+iPKDuah9VFIXCVr+NIyvXZGyYY5QKNo3LzoYCYWaHdy4pEDkJA4/3za4lwl7JuC6HqQaM9LwSF4FKT+d1BP9XohDT6AKwulKWw/4Pt9Dwz5/tu7RxWubfd6lfureSHu7v+K29vPL77fC0AZ8ACpWlkCag0Blw1Iafrk43mHH+fZZG2K91eSPQWOx1uoUSIM2yxQj1QyMMy3Txkj1FFa4uNGllAwDSHU8jsK380pU4Gyq9NAvgzZrSP0b25e/uhlQy1IeKDHa0roqLlKpH6+MNHLWGdW+7kRdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uee0P6N3zOFSy84Mg967+zwc0sH7/3W81SNTfXQs9Fk=;
 b=jeA497bEP1nwICoRbe3Ihp9jBdTwmWeJeHAW/PBu2Ji4+AypghejsxRmGxj0qFX3Id5/LbhmNFEvsCOQY00mGJWaR5lRO/xVonojhcdUEBENj9riRk9ch1slm+dthYsbrAIOM4OBU3260Udz1kz+jZeupwCKivewFBe0DdeEFi0=
Received: from BL1PR13CA0313.namprd13.prod.outlook.com (2603:10b6:208:2c1::18)
 by BL0PR12MB4883.namprd12.prod.outlook.com (2603:10b6:208:1c6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 22 Sep
 2023 06:50:29 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::e5) by BL1PR13CA0313.outlook.office365.com
 (2603:10b6:208:2c1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.11 via Frontend
 Transport; Fri, 22 Sep 2023 06:50:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 06:50:29 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 01:50:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 01:50:11 -0500
Received: from xsjtongh40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 22 Sep 2023 01:50:11 -0500
From: Tong Ho <tong.ho@amd.com>
To: <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <tong.ho@amd.com>
Subject: [PATCH v2 1/3] hw/misc: Introduce AMD/Xilix Versal TRNG device
Date: Thu, 21 Sep 2023 23:50:08 -0700
Message-ID: <20230922065010.4071693-2-tong.ho@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230922065010.4071693-1-tong.ho@amd.com>
References: <20230922065010.4071693-1-tong.ho@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|BL0PR12MB4883:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d1eff2b-d5dc-4d69-3faa-08dbbb383575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PlxOBCztvQq5IFb7H8aTybivrT4g4R6qV0D7T8wogJ/NOfByvuC4s0rCN4jXbL58EMu93g5wvHUUFR+wGGOUDrf1U4d6HF4GYDI/xdEJa1j6STlaZTrabGah/88rNN6kTzOOl59XEgHwT4qthqo5hq5UvaW3w+cYegKa0eW/V5RcZfeeHgRJG/wwhPxGfuFsMbj0W243TejCT3s9UKPhT6Ymb3cbTVbjW/V8vlnFptbhTMXvG/6wrNwkzkUsP96olcAOoInY+z2zigSK3Bmytzq9aM5vtN1Ub4KbDFiI5NokA/eCsOVzQ1zqLBn/3JWAVd1ynUZg6c6eX1iPMW+31X/MUE/OivcARaWa8RTQP+2WMnfQ3612ReUHRYcml9pL8yLjYwDdaBsb0NZEM5iZEyYyMNzy73bodXQicJfzFCInPAQ47Wlp2nKej/jy+RNAhoFmqC4VxsVhjTqfZ4h2cyiX7VwyLKLkIFdnkOS/H5qMoCwekSB51VECejko6uwDVh5uzw7uKp7m8lUqjSbzjz0sRpk9ZE0OvYQoJClRUdm/kdQOlW/QhtBOrN3H/dIUzyHf5M2h6z3W0AegNRT9m6pWfpQGLYTeR8In8plTfTHDhL9ShlMjGTknRxcku8aE9KwqfqALaEFffNuibwi2lsMdNLsMssmj/U236zn4TZXkD0/i64Czc9C1bBPS/px4jgPTejpa1JnJRbWvMztaGk5V1ILqZOMDQYv1nNjvSAjYlecoSbhtdE/75xJipXKs4K75PSDTxVsO5q2WcvSUkT5oUhS4dcbusMSKQFBQ1Hh/Pg4apsMYuLJh6uDxB2Lh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(1800799009)(230921699003)(451199024)(82310400011)(186009)(36840700001)(46966006)(40470700004)(36860700001)(36756003)(426003)(336012)(356005)(66899024)(26005)(81166007)(40480700001)(83380400001)(40460700003)(86362001)(82740400003)(47076005)(44832011)(5660300002)(478600001)(2906002)(30864003)(54906003)(8676002)(8936002)(4326008)(41300700001)(316002)(6916009)(70206006)(70586007)(1076003)(2616005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 06:50:29.2183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1eff2b-d5dc-4d69-3faa-08dbbb383575
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4883
Received-SPF: softfail client-ip=2a01:111:f400:7e8d::60f;
 envelope-from=tong.ho@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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

This adds a non-cryptographic grade implementation of the
model for the True Random Number Generator (TRNG) component
in AMD/Xilinx Versal device family.

This implements all 3 modes defined by the actual hardware
specs, all of which selectable by guest software at will
at anytime:
1) PRNG mode, in which the generated sequence is required to
   be reproducible after reseeded by the same 384-bit value
   as supplied by guest software.
2) Test mode, in which the generated sequence is required to
   be reproducible ater reseeded by the same 128-bit test
   seed supplied by guest software.
3) TRNG mode, in which non-reproducible sequence is generated
   based on periodic reseed by a suitable entropy source.

This model is only intended for non-real world testing of
guest software, where cryptographically strong PRNG and TRNG
is not needed.

This model supports versions 1 & 2 of the device, with
default to be version 2; the 'hw-version' uint32 property
can be set to 0x0100 to override the default.

Other implemented properties:
- 'forced-prng', uint64
  When set to non-zero, mode 3's entropy source is implemented
  as a deterministic sequence based on the given value and other
  deterministic parameters.
  This option allows the emulation to test guest software using
  mode 3 and to reproduce data-dependent defects.

- 'fips-fault-events', uint32, bit-mask
  bit 3: Triggers the SP800-90B entropy health test fault irq
  bit 1: Triggers the FIPS 140-2 continuous test fault irq

Signed-off-by: Tong Ho <tong.ho@amd.com>
---
 hw/misc/Kconfig                    |   3 +
 hw/misc/meson.build                |   3 +
 hw/misc/xlnx-versal-trng.c         | 734 +++++++++++++++++++++++++++++
 include/hw/misc/xlnx-versal-trng.h |  57 +++
 4 files changed, 797 insertions(+)
 create mode 100644 hw/misc/xlnx-versal-trng.c
 create mode 100644 include/hw/misc/xlnx-versal-trng.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 6996d265e4..6b6105dcbf 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -186,4 +186,7 @@ config AXP2XX_PMU
     bool
     depends on I2C
 
+config XLNX_VERSAL_TRNG
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 88ecab8392..8507ec9e86 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -102,6 +102,9 @@ system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files(
   'xlnx-cfi-if.c',
   'xlnx-versal-cframe-reg.c',
 ))
+system_ss.add(when: 'CONFIG_XLNX_VERSAL_TRNG', if_true: files(
+  'xlnx-versal-trng.c',
+))
 system_ss.add(when: 'CONFIG_STM32F2XX_SYSCFG', if_true: files('stm32f2xx_syscfg.c'))
 system_ss.add(when: 'CONFIG_STM32F4XX_SYSCFG', if_true: files('stm32f4xx_syscfg.c'))
 system_ss.add(when: 'CONFIG_STM32F4XX_EXTI', if_true: files('stm32f4xx_exti.c'))
diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
new file mode 100644
index 0000000000..6f52b0d636
--- /dev/null
+++ b/hw/misc/xlnx-versal-trng.c
@@ -0,0 +1,734 @@
+/*
+ * Non-crypto strength model of the True Random Number Generator
+ * in the AMD/Xilinx Versal device family.
+ *
+ * Copyright (c) 2017-2020 Xilinx Inc.
+ * Copyright (c) 2023 Advanced Micro Devices, Inc.
+ *
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "hw/misc/xlnx-versal-trng.h"
+
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "qemu/timer.h"
+#include "qapi/visitor.h"
+#include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
+
+#ifndef XLNX_VERSAL_TRNG_ERR_DEBUG
+#define XLNX_VERSAL_TRNG_ERR_DEBUG 0
+#endif
+
+REG32(INT_CTRL, 0x0)
+    FIELD(INT_CTRL, CERTF_RST, 5, 1)
+    FIELD(INT_CTRL, DTF_RST, 4, 1)
+    FIELD(INT_CTRL, DONE_RST, 3, 1)
+    FIELD(INT_CTRL, CERTF_EN, 2, 1)
+    FIELD(INT_CTRL, DTF_EN, 1, 1)
+    FIELD(INT_CTRL, DONE_EN, 0, 1)
+REG32(STATUS, 0x4)
+    FIELD(STATUS, QCNT, 9, 3)
+    FIELD(STATUS, EAT, 4, 5)
+    FIELD(STATUS, CERTF, 3, 1)
+    FIELD(STATUS, DTF, 1, 1)
+    FIELD(STATUS, DONE, 0, 1)
+REG32(CTRL, 0x8)
+    FIELD(CTRL, PERSODISABLE, 10, 1)
+    FIELD(CTRL, SINGLEGENMODE, 9, 1)
+    FIELD(CTRL, EUMODE, 8, 1)
+    FIELD(CTRL, PRNGMODE, 7, 1)
+    FIELD(CTRL, TSTMODE, 6, 1)
+    FIELD(CTRL, PRNGSTART, 5, 1)
+    FIELD(CTRL, EATAU, 4, 1)
+    FIELD(CTRL, PRNGXS, 3, 1)
+    FIELD(CTRL, TRSSEN, 2, 1)
+    FIELD(CTRL, QERTUEN, 1, 1)
+    FIELD(CTRL, PRNGSRST, 0, 1)
+REG32(CTRL_2, 0xc)
+    FIELD(CTRL_2, REPCOUNTTESTCUTOFF, 8, 9)
+    FIELD(CTRL_2, RESERVED_7_5, 5, 3)
+    FIELD(CTRL_2, DIT, 0, 5)
+REG32(CTRL_3, 0x10)
+    FIELD(CTRL_3, ADAPTPROPTESTCUTOFF, 8, 10)
+    FIELD(CTRL_3, DLEN, 0, 8)
+REG32(CTRL_4, 0x14)
+    FIELD(CTRL_4, SINGLEBITRAW, 0, 1)
+REG32(EXT_SEED_0, 0x40)
+REG32(EXT_SEED_1, 0x44)
+REG32(EXT_SEED_2, 0x48)
+REG32(EXT_SEED_3, 0x4c)
+REG32(EXT_SEED_4, 0x50)
+REG32(EXT_SEED_5, 0x54)
+REG32(EXT_SEED_6, 0x58)
+REG32(EXT_SEED_7, 0x5c)
+REG32(EXT_SEED_8, 0x60)
+REG32(EXT_SEED_9, 0x64)
+REG32(EXT_SEED_10, 0x68)
+REG32(EXT_SEED_11, 0x6c)
+REG32(PER_STRNG_0, 0x80)
+REG32(PER_STRNG_1, 0x84)
+REG32(PER_STRNG_2, 0x88)
+REG32(PER_STRNG_3, 0x8c)
+REG32(PER_STRNG_4, 0x90)
+REG32(PER_STRNG_5, 0x94)
+REG32(PER_STRNG_6, 0x98)
+REG32(PER_STRNG_7, 0x9c)
+REG32(PER_STRNG_8, 0xa0)
+REG32(PER_STRNG_9, 0xa4)
+REG32(PER_STRNG_10, 0xa8)
+REG32(PER_STRNG_11, 0xac)
+REG32(CORE_OUTPUT, 0xc0)
+REG32(RESET, 0xd0)
+    FIELD(RESET, VAL, 0, 1)
+REG32(OSC_EN, 0xd4)
+    FIELD(OSC_EN, VAL, 0, 1)
+REG32(TRNG_ISR, 0xe0)
+    FIELD(TRNG_ISR, SLVERR, 1, 1)
+    FIELD(TRNG_ISR, CORE_INT, 0, 1)
+REG32(TRNG_IMR, 0xe4)
+    FIELD(TRNG_IMR, SLVERR, 1, 1)
+    FIELD(TRNG_IMR, CORE_INT, 0, 1)
+REG32(TRNG_IER, 0xe8)
+    FIELD(TRNG_IER, SLVERR, 1, 1)
+    FIELD(TRNG_IER, CORE_INT, 0, 1)
+REG32(TRNG_IDR, 0xec)
+    FIELD(TRNG_IDR, SLVERR, 1, 1)
+    FIELD(TRNG_IDR, CORE_INT, 0, 1)
+REG32(SLV_ERR_CTRL, 0xf0)
+    FIELD(SLV_ERR_CTRL, ENABLE, 0, 1)
+
+#define R_MAX (R_SLV_ERR_CTRL + 1)
+
+QEMU_BUILD_BUG_ON(R_MAX * 4 != sizeof_field(XlnxVersalTRng, regs));
+
+#define TRNG_GUEST_ERROR(D, FMT, ...) \
+    do {                                                               \
+        g_autofree char *p = object_get_canonical_path(OBJECT(D));     \
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: " FMT, p, ## __VA_ARGS__); \
+    } while (0)
+
+#define TRNG_WARN(D, FMT, ...) \
+    do {                                                               \
+        g_autofree char *p = object_get_canonical_path(OBJECT(D));     \
+        warn_report("%s: " FMT, p, ## __VA_ARGS__);                    \
+    } while (0)
+
+static bool trng_older_than_v2(XlnxVersalTRng *s)
+{
+    return s->hw_version < 0x0200;
+}
+
+static bool trng_in_reset(XlnxVersalTRng *s)
+{
+    if (ARRAY_FIELD_EX32(s->regs, RESET, VAL)) {
+        return true;
+    }
+    if (ARRAY_FIELD_EX32(s->regs, CTRL, PRNGSRST)) {
+        return true;
+    }
+
+    return false;
+}
+
+static bool trng_test_enabled(XlnxVersalTRng *s)
+{
+    return ARRAY_FIELD_EX32(s->regs, CTRL, TSTMODE);
+}
+
+static bool trng_trss_enabled(XlnxVersalTRng *s)
+{
+    if (trng_in_reset(s)) {
+        return false;
+    }
+    if (!ARRAY_FIELD_EX32(s->regs, CTRL, TRSSEN)) {
+        return false;
+    }
+    if (!ARRAY_FIELD_EX32(s->regs, OSC_EN, VAL)) {
+        return false;
+    }
+
+    return true;
+}
+
+static void trng_le384(uint32_t *le384, const uint32_t *h384)
+{
+    size_t i;
+
+    for (i = 0; i < (384 / 32); i++) {
+        le384[i] = cpu_to_le32(h384[i]);
+    }
+}
+
+static void trng_reseed(XlnxVersalTRng *s)
+{
+    bool ext_seed = ARRAY_FIELD_EX32(s->regs, CTRL, PRNGXS);
+    bool pers_disabled = ARRAY_FIELD_EX32(s->regs, CTRL, PERSODISABLE);
+
+    enum {
+        U384_U32 = 384 / 32,
+    };
+
+    /*
+     * Maximum seed length is len(personalized string) + len(ext seed).
+     *
+     * Use little-endian to ensure guest sequence being indepedent of
+     * host endian.
+     */
+    struct {
+        guint32 ps[U384_U32];
+        union {
+            uint64_t int_seed[2];
+            guint32 ext_seed[U384_U32];
+        };
+    } gs;
+
+    /*
+     * A disabled personalized string is the same as
+     * a string with all zeros.
+     *
+     * The device's hardware spec defines 3 modes (all selectable
+     * by guest at will and at anytime):
+     * 1) External seeding
+     *    This is a PRNG mode, in which the produced sequence shall
+     *    be reproducible if reseeded by the same 384-bit seed, as
+     *    supplied by guest software.
+     * 2) Test seeding
+     *    This is a PRNG mode, in which the produced sequence shall
+     *    be reproducible if reseeded by a 128-bit test seed, as
+     *    supplied by guest software.
+     * 3) Truly-random seeding
+     *    This is the TRNG mode, in which the produced sequence is
+     *    periodically reseeded by a crypto-strength entropy source.
+     *
+     * To assist debugging of certain classes of software defects,
+     * this QEMU model implements a 4th mode,
+     * 4) Forced PRNG
+     *    When in this mode, a reproducible sequence is generated
+     *    if software has selected the TRNG mode (mode 2).
+     *
+     *    This emulation-only mode can only be selected by setting
+     *    the uint64 property 'forced-prng' to a non-zero value.
+     *    Guest software cannot select this mode.
+     */
+    memset(&gs, 0, sizeof(gs));
+    gs.ext_seed[ARRAY_SIZE(gs.ext_seed) - 1] = cpu_to_be32(1);
+
+    if (!pers_disabled) {
+        trng_le384(gs.ps, &s->regs[R_PER_STRNG_0]);
+    }
+
+    if (ext_seed) {
+        trng_le384(gs.ext_seed, &s->regs[R_EXT_SEED_0]);
+    } else if (trng_test_enabled(s)) {
+        gs.int_seed[0] = cpu_to_le64(s->tst_seed[0]);
+        gs.int_seed[1] = cpu_to_le64(s->tst_seed[1]);
+    } else if (s->forced_prng_seed) {
+        s->forced_prng_count++;
+        gs.int_seed[0] = cpu_to_le64(s->forced_prng_count);
+        gs.int_seed[1] = cpu_to_le64(s->forced_prng_seed);
+    } else {
+        gs.int_seed[0] = cpu_to_le64(qemu_clock_get_ns(QEMU_CLOCK_HOST));
+        gs.int_seed[1] = cpu_to_le64(getpid());
+    }
+
+    g_rand_set_seed_array(s->prng, gs.ps,
+                          sizeof(gs) / sizeof(guint32));
+
+    s->rand_count = 0;
+    s->rand_reseed = 1ULL << 48;
+}
+
+static void trng_regen(XlnxVersalTRng *s)
+{
+    if (s->rand_reseed == 0) {
+        TRNG_GUEST_ERROR(s, "Too many generations without a reseed");
+        trng_reseed(s);
+    }
+    s->rand_reseed--;
+
+    /*
+     * In real hardware, each regen creates 256 bits, but QCNT
+     * reports a max of 4.
+     */
+    ARRAY_FIELD_DP32(s->regs, STATUS, QCNT, 4);
+    s->rand_count = 256 / 32;
+}
+
+static uint32_t trng_rdout(XlnxVersalTRng *s)
+{
+    assert(s->rand_count);
+
+    s->rand_count--;
+    if (s->rand_count < 4) {
+        ARRAY_FIELD_DP32(s->regs, STATUS, QCNT, s->rand_count);
+    }
+
+    /* Reject all 0's and all 1's */
+    while (true) {
+        /* g_rand_int_range() returns gint32, not guint32 */
+        guint32 nr = g_rand_int(s->prng);
+
+        if (nr && (nr != ~0)) {
+            return nr;
+        }
+    }
+}
+
+static void trng_irq_update(XlnxVersalTRng *s)
+{
+    bool pending = s->regs[R_TRNG_ISR] & ~s->regs[R_TRNG_IMR];
+    qemu_set_irq(s->irq, pending);
+}
+
+static void trng_isr_postw(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxVersalTRng *s = XLNX_VERSAL_TRNG(reg->opaque);
+    trng_irq_update(s);
+}
+
+static uint64_t trng_ier_prew(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxVersalTRng *s = XLNX_VERSAL_TRNG(reg->opaque);
+    uint32_t val = val64;
+
+    s->regs[R_TRNG_IMR] &= ~val;
+    trng_irq_update(s);
+    return 0;
+}
+
+static uint64_t trng_idr_prew(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxVersalTRng *s = XLNX_VERSAL_TRNG(reg->opaque);
+    uint32_t val = val64;
+
+    s->regs[R_TRNG_IMR] |= val;
+    trng_irq_update(s);
+    return 0;
+}
+
+static void trng_core_int_update(XlnxVersalTRng *s)
+{
+    bool pending = false;
+    uint32_t st = s->regs[R_STATUS];
+    uint32_t en = s->regs[R_INT_CTRL];
+
+    if (FIELD_EX32(st, STATUS, CERTF) && FIELD_EX32(en, INT_CTRL, CERTF_EN)) {
+        pending = true;
+    }
+
+    if (FIELD_EX32(st, STATUS, DTF) && FIELD_EX32(en, INT_CTRL, DTF_EN)) {
+        pending = true;
+    }
+
+    if (FIELD_EX32(st, STATUS, DONE) && FIELD_EX32(en, INT_CTRL, DONE_EN)) {
+        pending = true;
+    }
+
+    ARRAY_FIELD_DP32(s->regs, TRNG_ISR, CORE_INT, pending);
+    trng_irq_update(s);
+}
+
+static void trng_int_ctrl_postw(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxVersalTRng *s = XLNX_VERSAL_TRNG(reg->opaque);
+    uint32_t v32 = val64;
+    uint32_t clr_mask = 0;
+
+    if (FIELD_EX32(v32, INT_CTRL, CERTF_RST)) {
+        clr_mask |= R_STATUS_CERTF_MASK;
+    }
+    if (FIELD_EX32(v32, INT_CTRL, DTF_RST)) {
+        clr_mask |= R_STATUS_DTF_MASK;
+    }
+    if (FIELD_EX32(v32, INT_CTRL, DONE_RST)) {
+        clr_mask |= R_STATUS_DONE_MASK;
+    }
+
+    s->regs[R_STATUS] &= ~clr_mask;
+    trng_core_int_update(s);
+}
+
+static void trng_done(XlnxVersalTRng *s)
+{
+    ARRAY_FIELD_DP32(s->regs, STATUS, DONE, true);
+    trng_core_int_update(s);
+}
+
+static void trng_fault_event_set(XlnxVersalTRng *s, uint32_t events)
+{
+    bool pending = false;
+
+    /* Disabled TRSS cannot generate any fault event */
+    if (!trng_trss_enabled(s)) {
+        return;
+    }
+
+    if (FIELD_EX32(events, STATUS, CERTF)) {
+        /* In older version, ERTU must be enabled explicitly to get CERTF */
+        if (trng_older_than_v2(s) &&
+            !ARRAY_FIELD_EX32(s->regs, CTRL, QERTUEN)) {
+            TRNG_WARN(s, "CERTF injection ignored: ERTU disabled");
+        } else {
+            ARRAY_FIELD_DP32(s->regs, STATUS, CERTF, true);
+            pending = true;
+        }
+    }
+
+    if (FIELD_EX32(events, STATUS, DTF)) {
+        ARRAY_FIELD_DP32(s->regs, STATUS, DTF, true);
+        pending = true;
+    }
+
+    if (pending) {
+        trng_core_int_update(s);
+    }
+}
+
+static void trng_soft_reset(XlnxVersalTRng *s)
+{
+    s->rand_count = 0;
+    s->regs[R_STATUS] = 0;
+
+    ARRAY_FIELD_DP32(s->regs, TRNG_ISR, CORE_INT, 0);
+}
+
+static void trng_ctrl_postw(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxVersalTRng *s = XLNX_VERSAL_TRNG(reg->opaque);
+
+    if (trng_in_reset(s)) {
+        return;
+    }
+
+    if (FIELD_EX32(val64, CTRL, PRNGSRST)) {
+        trng_soft_reset(s);
+        trng_irq_update(s);
+        return;
+    }
+
+    if (!FIELD_EX32(val64, CTRL, PRNGSTART)) {
+        return;
+    }
+
+    if (FIELD_EX32(val64, CTRL, PRNGMODE)) {
+        trng_regen(s);
+    } else {
+        trng_reseed(s);
+    }
+
+    trng_done(s);
+}
+
+static void trng_ctrl4_postw(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxVersalTRng *s = XLNX_VERSAL_TRNG(reg->opaque);
+
+    if (trng_older_than_v2(s)) {
+        return;
+    }
+
+    /* Only applies to test mode with TRSS enabled */
+    if (!trng_test_enabled(s) || !trng_trss_enabled(s)) {
+        return;
+    }
+
+    /* Shift in a single bit.  */
+    s->tst_seed[1] <<= 1;
+    s->tst_seed[1] |= s->tst_seed[0] >> 63;
+    s->tst_seed[0] <<= 1;
+    s->tst_seed[0] |= val64 & 1;
+
+    trng_reseed(s);
+    trng_regen(s);
+}
+
+static uint64_t trng_core_out_postr(RegisterInfo *reg, uint64_t val)
+{
+    XlnxVersalTRng *s = XLNX_VERSAL_TRNG(reg->opaque);
+    bool oneshot = ARRAY_FIELD_EX32(s->regs, CTRL, SINGLEGENMODE);
+    bool start = ARRAY_FIELD_EX32(s->regs, CTRL, PRNGSTART);
+    uint32_t r = 0xbad;
+
+    if (trng_in_reset(s)) {
+        TRNG_GUEST_ERROR(s, "Reading random number while in reset!");
+        return r;
+    }
+
+    if (s->rand_count == 0) {
+        TRNG_GUEST_ERROR(s, "Reading random number when unavailable!");
+        return r;
+    }
+
+    r = trng_rdout(s);
+
+    /* Automatic mode regenerates when half the output reg is empty.  */
+    if (!oneshot && start && s->rand_count <= 3) {
+        trng_regen(s);
+    }
+
+    return r;
+}
+
+static void trng_reset(XlnxVersalTRng *s)
+{
+    unsigned int i;
+
+    s->forced_prng_count = 0;
+
+    for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
+        register_reset(&s->regs_info[i]);
+    }
+    trng_soft_reset(s);
+    trng_irq_update(s);
+}
+
+static uint64_t trng_reset_prew(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxVersalTRng *s = XLNX_VERSAL_TRNG(reg->opaque);
+
+    if (!ARRAY_FIELD_EX32(s->regs, RESET, VAL) &&
+        FIELD_EX32(val64, RESET, VAL)) {
+        trng_reset(s);
+    }
+
+    return val64;
+}
+
+static uint64_t trng_register_read(void *opaque, hwaddr addr, unsigned size)
+{
+    /*
+     * Guest provided seed and personalized strings cannot be
+     * read back, and read attempts return value of A_STATUS.
+     */
+    switch (addr) {
+    case A_EXT_SEED_0 ... A_PER_STRNG_11:
+        addr = A_STATUS;
+        break;
+    }
+
+    return register_read_memory(opaque, addr, size);
+}
+
+static void trng_register_write(void *opaque, hwaddr addr,
+                                uint64_t value, unsigned size)
+{
+    RegisterInfoArray *reg_array = opaque;
+    XlnxVersalTRng *s = XLNX_VERSAL_TRNG(reg_array->r[0]->opaque);
+
+    if (trng_older_than_v2(s)) {
+        switch (addr) {
+        case A_CTRL:
+            value = FIELD_DP64(value, CTRL, PERSODISABLE, 0);
+            value = FIELD_DP64(value, CTRL, SINGLEGENMODE, 0);
+            break;
+        case A_CTRL_2:
+        case A_CTRL_3:
+        case A_CTRL_4:
+            return;
+        }
+    } else {
+        switch (addr) {
+        case A_CTRL:
+            value = FIELD_DP64(value, CTRL, EATAU, 0);
+            value = FIELD_DP64(value, CTRL, QERTUEN, 0);
+            break;
+        }
+    }
+
+    register_write_memory(opaque, addr, value, size);
+}
+
+static RegisterAccessInfo trng_regs_info[] = {
+    {   .name = "INT_CTRL",  .addr = A_INT_CTRL,
+        .post_write = trng_int_ctrl_postw,
+    },{ .name = "STATUS",  .addr = A_STATUS,
+        .ro = 0xfff,
+    },{ .name = "CTRL",  .addr = A_CTRL,
+        .post_write = trng_ctrl_postw,
+    },{ .name = "CTRL_2",  .addr = A_CTRL_2,
+        .reset = 0x210c,
+    },{ .name = "CTRL_3",  .addr = A_CTRL_3,
+        .reset = 0x26f09,
+    },{ .name = "CTRL_4",  .addr = A_CTRL_4,
+        .post_write = trng_ctrl4_postw,
+    },{ .name = "EXT_SEED_0",  .addr = A_EXT_SEED_0,
+    },{ .name = "EXT_SEED_1",  .addr = A_EXT_SEED_1,
+    },{ .name = "EXT_SEED_2",  .addr = A_EXT_SEED_2,
+    },{ .name = "EXT_SEED_3",  .addr = A_EXT_SEED_3,
+    },{ .name = "EXT_SEED_4",  .addr = A_EXT_SEED_4,
+    },{ .name = "EXT_SEED_5",  .addr = A_EXT_SEED_5,
+    },{ .name = "EXT_SEED_6",  .addr = A_EXT_SEED_6,
+    },{ .name = "EXT_SEED_7",  .addr = A_EXT_SEED_7,
+    },{ .name = "EXT_SEED_8",  .addr = A_EXT_SEED_8,
+    },{ .name = "EXT_SEED_9",  .addr = A_EXT_SEED_9,
+    },{ .name = "EXT_SEED_10",  .addr = A_EXT_SEED_10,
+    },{ .name = "EXT_SEED_11",  .addr = A_EXT_SEED_11,
+    },{ .name = "PER_STRNG_0",  .addr = A_PER_STRNG_0,
+    },{ .name = "PER_STRNG_1",  .addr = A_PER_STRNG_1,
+    },{ .name = "PER_STRNG_2",  .addr = A_PER_STRNG_2,
+    },{ .name = "PER_STRNG_3",  .addr = A_PER_STRNG_3,
+    },{ .name = "PER_STRNG_4",  .addr = A_PER_STRNG_4,
+    },{ .name = "PER_STRNG_5",  .addr = A_PER_STRNG_5,
+    },{ .name = "PER_STRNG_6",  .addr = A_PER_STRNG_6,
+    },{ .name = "PER_STRNG_7",  .addr = A_PER_STRNG_7,
+    },{ .name = "PER_STRNG_8",  .addr = A_PER_STRNG_8,
+    },{ .name = "PER_STRNG_9",  .addr = A_PER_STRNG_9,
+    },{ .name = "PER_STRNG_10",  .addr = A_PER_STRNG_10,
+    },{ .name = "PER_STRNG_11",  .addr = A_PER_STRNG_11,
+    },{ .name = "CORE_OUTPUT",  .addr = A_CORE_OUTPUT,
+        .ro = 0xffffffff,
+        .post_read = trng_core_out_postr,
+    },{ .name = "RESET",  .addr = A_RESET,
+        .reset = 0x1,
+        .pre_write = trng_reset_prew,
+    },{ .name = "OSC_EN",  .addr = A_OSC_EN,
+    },{ .name = "TRNG_ISR",  .addr = A_TRNG_ISR,
+        .w1c = 0x3,
+        .post_write = trng_isr_postw,
+    },{ .name = "TRNG_IMR",  .addr = A_TRNG_IMR,
+        .reset = 0x3,
+        .ro = 0x3,
+    },{ .name = "TRNG_IER",  .addr = A_TRNG_IER,
+        .pre_write = trng_ier_prew,
+    },{ .name = "TRNG_IDR",  .addr = A_TRNG_IDR,
+        .pre_write = trng_idr_prew,
+    },{ .name = "SLV_ERR_CTRL",  .addr = A_SLV_ERR_CTRL,
+    }
+};
+
+static const MemoryRegionOps trng_ops = {
+    .read = trng_register_read,
+    .write = trng_register_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void trng_init(Object *obj)
+{
+    XlnxVersalTRng *s = XLNX_VERSAL_TRNG(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    RegisterInfoArray *reg_array;
+
+    reg_array =
+        register_init_block32(DEVICE(obj), trng_regs_info,
+                              ARRAY_SIZE(trng_regs_info),
+                              s->regs_info, s->regs,
+                              &trng_ops,
+                              XLNX_VERSAL_TRNG_ERR_DEBUG,
+                              R_MAX * 4);
+
+    sysbus_init_mmio(sbd, &reg_array->mem);
+    sysbus_init_irq(sbd, &s->irq);
+
+    s->prng = g_rand_new();
+}
+
+static void trng_unrealize(DeviceState *dev)
+{
+    XlnxVersalTRng *s = XLNX_VERSAL_TRNG(dev);
+
+    g_rand_free(s->prng);
+    s->prng = NULL;
+}
+
+static void trng_reset_hold(Object *obj)
+{
+    trng_reset(XLNX_VERSAL_TRNG(obj));
+}
+
+static void trng_prop_fault_event_set(Object *obj, Visitor *v,
+                                      const char *name, void *opaque,
+                                      Error **errp)
+{
+    uint32_t events = 0;
+
+    visit_type_uint32(v, name, &events, errp);
+    if (*errp) {
+        return;
+    }
+
+    trng_fault_event_set(XLNX_VERSAL_TRNG(obj), events);
+}
+
+static const PropertyInfo trng_prop_fault_events = {
+    .name = "uint32:bits",
+    .description = "Set to trigger TRNG fault events",
+    .set = trng_prop_fault_event_set,
+    .realized_set_allowed = true,
+};
+
+static PropertyInfo trng_prop_uint64; /* to extend qdev_prop_uint64 */
+
+static Property trng_props[] = {
+    DEFINE_PROP_UINT64("forced-prng", XlnxVersalTRng, forced_prng_seed, 0),
+    DEFINE_PROP_UINT32("hw-version", XlnxVersalTRng, hw_version, 0x0200),
+    { .name = "fips-fault-events", .info = &trng_prop_fault_events, },
+
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static const VMStateDescription vmstate_trng = {
+    .name = TYPE_XLNX_VERSAL_TRNG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, XlnxVersalTRng, R_MAX),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static void trng_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->vmsd = &vmstate_trng;
+    dc->unrealize = trng_unrealize;
+    rc->phases.hold = trng_reset_hold;
+
+    /* Clone uint64 property with set allowed after realized */
+    trng_prop_uint64 = qdev_prop_uint64;
+    trng_prop_uint64.realized_set_allowed = true;
+    trng_props[0].info = &trng_prop_uint64;
+
+    device_class_set_props(dc, trng_props);
+}
+
+static const TypeInfo trng_info = {
+    .name          = TYPE_XLNX_VERSAL_TRNG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(XlnxVersalTRng),
+    .class_init    = trng_class_init,
+    .instance_init = trng_init,
+};
+
+static void trng_register_types(void)
+{
+    type_register_static(&trng_info);
+}
+
+type_init(trng_register_types)
diff --git a/include/hw/misc/xlnx-versal-trng.h b/include/hw/misc/xlnx-versal-trng.h
new file mode 100644
index 0000000000..d25508c424
--- /dev/null
+++ b/include/hw/misc/xlnx-versal-trng.h
@@ -0,0 +1,57 @@
+/*
+ * Non-crypto strength model of the True Random Number Generator
+ * in the AMD/Xilinx Versal device family.
+ *
+ * Copyright (c) 2017-2020 Xilinx Inc.
+ * Copyright (c) 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#ifndef XLNX_VERSAL_TRNG_H
+#define XLNX_VERSAL_TRNG_H
+
+#include "hw/irq.h"
+#include "hw/sysbus.h"
+#include "hw/register.h"
+
+#define TYPE_XLNX_VERSAL_TRNG "xlnx.versal-trng"
+OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalTRng, XLNX_VERSAL_TRNG);
+
+#define RMAX_XLNX_VERSAL_TRNG ((0xf0 / 4) + 1)
+
+typedef struct XlnxVersalTRng {
+    SysBusDevice parent_obj;
+    qemu_irq irq;
+    GRand *prng;
+
+    uint32_t hw_version;
+
+    uint32_t rand_count;
+    uint64_t rand_reseed;
+
+    uint64_t forced_prng_seed;
+    uint64_t forced_prng_count;
+    uint64_t tst_seed[2];
+
+    uint32_t regs[RMAX_XLNX_VERSAL_TRNG];
+    RegisterInfo regs_info[RMAX_XLNX_VERSAL_TRNG];
+} XlnxVersalTRng;
+
+#undef RMAX_XLNX_VERSAL_TRNG
+#endif
-- 
2.25.1


