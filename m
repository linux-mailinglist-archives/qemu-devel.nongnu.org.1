Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93790B2D69E
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Aug 2025 10:35:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeC1-00018c-Sh; Wed, 20 Aug 2025 04:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAi-0007lX-Ri; Wed, 20 Aug 2025 04:27:54 -0400
Received: from mail-dm3nam02on2061d.outbound.protection.outlook.com
 ([2a01:111:f403:2405::61d]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAe-0001BL-UZ; Wed, 20 Aug 2025 04:27:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2yUM3VyXNaWp1C8XzjuiITtocBcyiv9atI0K9GpOYHcgxLuaDeMq62/dA2q+ese39a9P6uaoEmk3SGSxmd/gx1GaTGSe+fh565qpLqTtdFAP8A7/ycxai6wuTSiFn+0qmBSt2rXPjLeVh+ldIItEM3v3dWv4YYPmiuZTaDRld4PMcnlpsGkLHh1rKz/FTzJ0eEvBDrr3hBnm3To3GG9VmINO1TdELRcILiiW+LtElnj8tilQVfjbjqid3k6kckddxvvHErK9JcrDRrSDFXDmzAYLPqIz3yJ0hGEJHBkhqI5tDtQLwNuMmHD8CWeSf5vKAeNFSOejJJ2O508/1tbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYMpPbnCJFbr+0wpAVX+fQVyzaP/7Frj15TepFJddCA=;
 b=i+eT5do6Hh9pCY2tsIJSPGgpjuAeTMzVJtBxDz1A2BKXNEyWDuwKce+YjhTHdNe2mC/g60JD6Zny+arKR1LtaZmv7TP9PzAHCEC8VsZ2lNJy+wIgUjh7z8wbXBwU2unqnPm0oO8izV0ZxjiS3+lhdq8Le6PRnYiJVhOTnMk5RJiSTsr4ridNQQlHCKfxu0PCUd3twJCRJkS4fxB2E3DCnMKcBpLqbcK8j2eTJDS025BmD2A8h7477uV9PLB7URIwQNYc/rmaAXjaP99oBRWqhDOxm8XyKrIZSy3xV/721ZprgSe84yRrqKfzG5PtvRvlpR+eAxzDWyEKjbhoe0jHvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYMpPbnCJFbr+0wpAVX+fQVyzaP/7Frj15TepFJddCA=;
 b=sz7vuZH7RoglMcgVvVUXpJZbwLSWcjkh+2dIqBQnBWPF3fhbB/ZbQzsXipxNWcjdVFVOihTCz1Te6olJ8uxjqJd+v/amIl/DgblI2LUpDg/4/ujVWtOF47PAd4yjBTu3dt7kG//gd+WCsE9bjBlrH4PvgkJcwyu7PmFyheRq84E=
Received: from MW4PR03CA0109.namprd03.prod.outlook.com (2603:10b6:303:b7::24)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 08:27:40 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::46) by MW4PR03CA0109.outlook.office365.com
 (2603:10b6:303:b7::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 08:27:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:27:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:38 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:27:37 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 46/47] hw/arm/xlnx-versal-virt: add the xlnx-versal2-virt
 machine
Date: Wed, 20 Aug 2025 10:25:45 +0200
Message-ID: <20250820082549.69724-47-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d8b40f-e49a-46f0-de72-08dddfc36d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZWI/zU48XfPAJ8/3qc7ct+rQ2IHYfTZkTdfE1FC27mWrvsko/HNDmhpcPrQ9?=
 =?us-ascii?Q?pg5DoRRr/jgboOCy2Z7mwqM+X/zDjHSsGjv1Fi2agsh28wb274AOjzNtohUI?=
 =?us-ascii?Q?nNXV10NYQhAWZX3WaiLX5cvO9/s49Ba/H0jSFoxKl9FFAvMAQLjvLRXtSiCA?=
 =?us-ascii?Q?PlI46X+tuh7xOl1gWlF5pGlZf+jR3GtEQ41iKl9FKqTJS/X9Qh7CAs/RWVne?=
 =?us-ascii?Q?px/23BiY62UZfOcO8PXVkgHy4LnZAr24aiUYk/7TKn1IabzJYPwVq9wi4Q30?=
 =?us-ascii?Q?crydzO71CBtMcXKO/bQj9wEOCA4eDEUE4M7+IR53Bmw/j7gXt0b87G4jWOtx?=
 =?us-ascii?Q?1g6HBpRwwTzKW2egb+mxPDPfUnm/nmT3ay4/SJfybscoNugyjAqnrYAvCEI2?=
 =?us-ascii?Q?aj7nCnlRt47KIXAfuwYNFcyqeYvnYSPscHa0BaGpVL4n8HvWlNl31Y7mTQ6g?=
 =?us-ascii?Q?htLYnPm/f4bq5DZBx9X6IwNp85XsmcxfRHmf84QgoemDRqUSX97Lx8//EKLH?=
 =?us-ascii?Q?HBr8j6oAntvhMjCCCr1V9kbGp+YDgXhmHIvB5uDg4Idco5Ho+I2X9bRDHMbx?=
 =?us-ascii?Q?iM/vufSvrvFSQw2aool9ilk90eR/W2j/Fb6xn3BezTQ4Ns+2Cd7ylvu2VvgH?=
 =?us-ascii?Q?duxYv1bFKPRaE3n6xaTPe+ZIh1vochjZq08jQoQjJ5lZ454yImE7Gs/ka3Vf?=
 =?us-ascii?Q?hc4D7t6z9EeL0b5UL5YNa52Hil572NMUzZrUz34idtCI60BcPmvSGTjE2/cy?=
 =?us-ascii?Q?7cyg5r05a9Ck+t3Bgm7BaWSCAstBlOiUZ9ywh3RE0+IL/BM4SoR5PG6/5uQR?=
 =?us-ascii?Q?jwMNr1v907rFED3QHGq0I9Q9qfGLVfFrZG4A/WqRlte1y28EKSWQNcE6ZWur?=
 =?us-ascii?Q?RWDooCcPEcizQVfUmM/U0/RHTn9TmtjiahO7IPU3UgezLSEH4jeTR5YudyDo?=
 =?us-ascii?Q?fRxPo/HiXOT8duCA1sPKyCV41KNVHT+MwY5UhpmM3mhOVN+i+W4eEGp9aWPY?=
 =?us-ascii?Q?e24ziqMCwDeEEQKNtZZ1j7OhcCWbc555Nid4au5qaci/JhpEXMWJamYGJ+Cs?=
 =?us-ascii?Q?gWi2r3j0o18Xf8euQwFvG6jYuigVDIe6VI4Lwefo5r5XR2AljXhC+etfS67R?=
 =?us-ascii?Q?lF9fShg+15ABIScq5W4HV2MbiXYCmutAQjWPng+nS++8Ucfv5YgmNH4fwhPW?=
 =?us-ascii?Q?xEf80wcLh6MY5E2a2x4Z4slxn++49B7OS3+C/qv5tJlkPzo/H8Pv/S6dSr7F?=
 =?us-ascii?Q?WTbYT7Bio0ByA9HpjfvIF+jHiq/B0nowjyNqD2daCsCxKWIDRwrT3Y3UwpS4?=
 =?us-ascii?Q?Imax5Wj2EMrO3ZnJf7asX+HYqOMGuPYOmRs38S8UEo9hn460F7UrmIj0/SwD?=
 =?us-ascii?Q?e6kgXki+BpoQB1XkAjn1Gs5g7UEkpDEikSjUPNjcs/pU1yOlLTH6GA1MI7w8?=
 =?us-ascii?Q?n/X9q62YIVQyXM7wWiSxxFxI+jLdLyQJQfRrR8HwDXnhWJmCdy5ulh7jZfZ2?=
 =?us-ascii?Q?XU9iuau20FzKSN/mlSLvvcSJc3laemtKvyCk1GpXlwT/R+7ukjMq5J1N/w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:27:39.9720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d8b40f-e49a-46f0-de72-08dddfc36d40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
Received-SPF: permerror client-ip=2a01:111:f403:2405::61d;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Add the Versal Gen 2 Virtual development machine embedding a
versal2 SoC. This machine follows the same principle than the
xlnx-versal-virt machine. It creates its own DTB and feeds it to the
software payload. This way only implemented devices are exposed to the
guest and the user does not need to provide a DTB.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 docs/system/arm/xlnx-versal-virt.rst | 49 ++++++++++++++++++++++++----
 hw/arm/xlnx-versal-virt.c            | 37 +++++++++++++++++++--
 2 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index 5d7fa18592b..af56b275413 100644
--- a/docs/system/arm/xlnx-versal-virt.rst
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -1,16 +1,18 @@
-AMD Versal Virt (``amd-versal-virt``)
-=====================================
+AMD Versal Virt (``amd-versal-virt``, ``amd-versal2-virt``)
+===========================================================
 
 AMD Versal is a family of heterogeneous multi-core SoCs
 (System on Chip) that combine traditional hardened CPUs and I/O
 peripherals in a Processing System (PS) with runtime programmable
 FPGA logic (PL) and an Artificial Intelligence Engine (AIE).
 
-QEMU implements the Versal Series variant of Versal SoCs, with the
-``amd-versal-virt`` machine. The alias ``xlnx-versal-virt`` is kept for
-backward compatibility.
+QEMU implements two variants of Versal SoCs:
+
+- Versal (the ``amd-versal-virt`` machine, the alias ``xlnx-versal-virt`` is
+  kept for backward compatibility)
+- Versal Gen 2 (the ``amd-versal2-virt`` machine)
 
 More details here:
 https://www.amd.com/en/products/adaptive-socs-and-fpgas/versal.html
 
 The family of Versal SoCs share a single architecture but come in
@@ -19,10 +21,12 @@ other differences.
 
 The AMD Versal Virt board in QEMU is a model of a virtual board
 (does not exist in reality) with a virtual Versal SoC without I/O
 limitations. Currently, we support the following cores and devices:
 
+Versal
+""""""
 Implemented CPU cores:
 
 - 2 ACPUs (ARM Cortex-A72) with their GICv3 and ITS
 - 2 RCPUs (ARM Cortex-R5F) with their GICv2
 
@@ -41,20 +45,42 @@ Implemented devices:
 - 2 CANFDs
 - USB controller
 - OSPI controller
 - TRNG controller
 
+Versal Gen 2
+""""""""""""
+Implemented CPU cores:
+
+- 8 ACPUs (ARM Cortex-A78AE) with their GICv3 and ITS
+- 10 RCPUs (ARM Cortex-R52) with their GICv3 (one per cluster)
+
+Implemented devices:
+
+- 2 UARTs (ARM PL011)
+- An RTC (Versal built-in)
+- 3 GEMs (Cadence MACB Ethernet MACs)
+- 8 ADMA (Xilinx zDMA) channels
+- 2 SD Controllers
+- OCM (256KB of On Chip Memory)
+- DDR memory
+- BBRAM (36 bytes of Battery-backed RAM)
+- 2 CANFDs
+- 2 USB controllers
+- OSPI controller
+- TRNG controller
+
 QEMU does not yet model any other devices, including the PL and the AI Engine.
 
 Other differences between the hardware and the QEMU model:
 
 - QEMU allows the amount of DDR memory provided to be specified with the
   ``-m`` argument. If a DTB is provided on the command line then QEMU will
   edit it to include suitable entries describing the Versal DDR memory ranges.
 
-- QEMU provides 8 virtio-mmio virtio transports; these start at
-  address ``0xa0000000`` and have IRQs from 111 and upwards.
+- QEMU provides 8 virtio-mmio virtio transports. They use reserved memory
+  regions and IRQ pins to avoid conflicts with real SoC peripherals.
 
 Running
 """""""
 If the user provides an Operating System to be loaded, we expect users
 to use the ``-kernel`` command line option.
@@ -212,10 +238,15 @@ To use a different index value, N, from default of 0, add:
 
   -global driver=xlnx.bbram-ctrl,property=drive-index,value=N
 
 eFUSE File Backend
 """"""""""""""""""
+
+.. note::
+   The eFUSE device is not implemented in the Versal Gen 2 QEMU model
+   yet.
+
 eFUSE can have an optional file backend, which must be a seekable
 binary file with a size of 3072 bytes or larger. A file with all
 binary 0s is a 'blank'.
 
 To add a file-backend for the eFUSE:
@@ -269,5 +300,9 @@ To connect CANFD0 and CANFD1 to host machine's CAN interface can0:
 
 .. code-block:: bash
 
     -object can-bus,id=canbus -machine canbus0=canbus -machine canbus1=canbus
     -object can-host-socketcan,id=canhost0,if=can0,canbus=canbus
+
+.. note::
+   Versal Gen 2 has 4 CAN controllers. ``canbus0`` to ``canbus3`` can
+   be specified on the command line.
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index b6fddc3920f..fdcf5f15a19 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -1,7 +1,7 @@
 /*
- * AMD/Xilinx Versal Virtual board.
+ * AMD/Xilinx Versal family Virtual board.
  *
  * Copyright (c) 2018 Xilinx Inc.
  * Copyright (c) 2025 Advanced Micro Devices, Inc.
  * Written by Edgar E. Iglesias
  *
@@ -27,10 +27,11 @@
 #define TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE \
     MACHINE_TYPE_NAME("amd-versal-virt-base")
 OBJECT_DECLARE_TYPE(VersalVirt, VersalVirtClass, XLNX_VERSAL_VIRT_BASE_MACHINE)
 
 #define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("amd-versal-virt")
+#define TYPE_XLNX_VERSAL2_VIRT_MACHINE MACHINE_TYPE_NAME("amd-versal2-virt")
 
 #define XLNX_VERSAL_NUM_OSPI_FLASH 4
 
 struct VersalVirt {
     MachineState parent_obj;
@@ -55,11 +56,13 @@ struct VersalVirtClass {
 };
 
 static void fdt_create(VersalVirt *s)
 {
     MachineClass *mc = MACHINE_GET_CLASS(s);
+    VersalVirtClass *vvc = XLNX_VERSAL_VIRT_BASE_MACHINE_GET_CLASS(s);
     const char versal_compat[] = "amd-versal-virt\0xlnx-versal-virt";
+    const char versal2_compat[] = "amd-versal2-virt";
 
     s->fdt = create_device_tree(&s->fdt_size);
     if (!s->fdt) {
         error_report("create_device_tree() failed");
         exit(1);
@@ -69,12 +72,22 @@ static void fdt_create(VersalVirt *s)
     qemu_fdt_add_subnode(s->fdt, "/chosen");
     qemu_fdt_add_subnode(s->fdt, "/aliases");
 
     /* Header */
     qemu_fdt_setprop_string(s->fdt, "/", "model", mc->desc);
-    qemu_fdt_setprop(s->fdt, "/", "compatible", versal_compat,
-                     sizeof(versal_compat));
+
+    switch (vvc->version) {
+    case VERSAL_VER_VERSAL:
+        qemu_fdt_setprop(s->fdt, "/", "compatible", versal_compat,
+                         sizeof(versal_compat));
+        break;
+
+    case VERSAL_VER_VERSAL2:
+        qemu_fdt_setprop(s->fdt, "/", "compatible", versal2_compat,
+                         sizeof(versal2_compat));
+        break;
+    }
 }
 
 static void fdt_nop_memory_nodes(void *fdt, Error **errp)
 {
     Error *err = NULL;
@@ -362,10 +375,21 @@ static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
     vvc->version = VERSAL_VER_VERSAL;
 
     versal_virt_machine_class_init_common(oc);
 }
 
+static void versal2_virt_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    VersalVirtClass *vvc = XLNX_VERSAL_VIRT_BASE_MACHINE_CLASS(oc);
+
+    mc->desc = "AMD Versal Gen 2 Virtual development board";
+    vvc->version = VERSAL_VER_VERSAL2;
+
+    versal_virt_machine_class_init_common(oc);
+}
+
 static const TypeInfo versal_virt_base_machine_init_typeinfo = {
     .name       = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
     .parent     = TYPE_MACHINE,
     .class_size = sizeof(VersalVirtClass),
     .instance_init = versal_virt_machine_instance_init,
@@ -378,12 +402,19 @@ static const TypeInfo versal_virt_machine_init_typeinfo = {
     .name       = TYPE_XLNX_VERSAL_VIRT_MACHINE,
     .parent     = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
     .class_init = versal_virt_machine_class_init,
 };
 
+static const TypeInfo versal2_virt_machine_init_typeinfo = {
+    .name       = TYPE_XLNX_VERSAL2_VIRT_MACHINE,
+    .parent     = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
+    .class_init = versal2_virt_machine_class_init,
+};
+
 static void versal_virt_machine_init_register_types(void)
 {
     type_register_static(&versal_virt_base_machine_init_typeinfo);
     type_register_static(&versal_virt_machine_init_typeinfo);
+    type_register_static(&versal2_virt_machine_init_typeinfo);
 }
 
 type_init(versal_virt_machine_init_register_types)
-- 
2.50.1


