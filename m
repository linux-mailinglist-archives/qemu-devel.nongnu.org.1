Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD62A7A13F8
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 04:47:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgyqb-0007M0-Or; Thu, 14 Sep 2023 22:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qgyqV-0007L8-I8; Thu, 14 Sep 2023 22:46:15 -0400
Received: from mail-dm6nam04on20629.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::629]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qgyqR-0001VD-RC; Thu, 14 Sep 2023 22:46:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSn/vpW36WjjR8kg/tnnrEuWwKYQhQdPLR7r/yTGRY3RO8we+Wx1/5VX4NAZr1soku5NLdTOfcUxfqidd/sB4MAqEVDPa7uSzbqF2A2SS2epWASMac4YcV2gYma3+eI/bDvTcyxNAVa0UnREy6z3RRW9KvbBX/PBVSqkvF5pcGUYc+J6W3zz4L+SkgOPnivhcH/uVr1QooJrYJbjh1YF/or0jOvQVQXCLhJMh0YoDHK48F6L+KVAqaKy1dq0g8NT/uML5rVmYWQTr/vgxCWKwdDtFtQscgoT9BZgzx/E+KW0PC673rfPJv3sbnHKP0QsXfYc5LIvmfwHLMACyGfWtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVU0T//EffajPJTzMgnm46fiAdGYtH4xC1a7Ulhkxog=;
 b=jKn57mXM1JsxIMs0OnqZ8Ee9W85V2rJEDA74gsh3lXI/r3Isa5K5YEhqATGN7p7T16hIlK5qHDfXuhbqSEAQrz+Vp1h7av/FRy3IOgjslsmt5qHgX3hr+kkNjg304QDkIn/CwfWIzpPlglBlWEmC9lEs5lk+HVUtLDT/ijYyrL0YH5AUm0Gfy2vplfgl9ZKWtrfLswh8NwBBwIRJ01r+Lgs8JBDmiqC7dTkMd00XrpeJVpi2s0vp8yi+wgryhUINoSP1ynXvuf/DT/DnDMqw225PALOA6UEcs9PhU1y0uaPI+RbZZZ4PORc0A/2AeD4VqIwQL/HVeVwYbgDdK/D5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVU0T//EffajPJTzMgnm46fiAdGYtH4xC1a7Ulhkxog=;
 b=cCOH3k7las/ZbJQQDR6p2CIzWayGf6DMmltsrJwukFQvOZ0JWS+fwD0mUYeku0Oq/XhU+aMN1hcst+eevcrW5+IX+rcXjnGGyJF4+v65J0VTUviiPN65fvx/fO5dY5Hb4ok7XFXd7KuXXytGtDAgBBakXH7/kzOCc9C6Ta0BtZIMseEMLUoB8Wvvf/N+Lk3jnRtMQ65px+o/+rr2f5YO4vHvtwyNYPvqfnyNYW9NVjkWvEgLzQU2kiM7loqxpo5sAoSH/YSUOU9HQq3yes0UFmsr9nJHdH7HMGlAXeepqmfPvinzFMGsIZxHMMRPyV7QVYOhL5wVO0CDdR1oXSncfg==
Received: from MN2PR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:c0::24)
 by PH7PR12MB8425.namprd12.prod.outlook.com (2603:10b6:510:240::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 02:46:08 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::85) by MN2PR05CA0011.outlook.office365.com
 (2603:10b6:208:c0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Fri, 15 Sep 2023 02:46:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 02:46:08 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Sep
 2023 19:46:00 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 14 Sep 2023 19:45:59 -0700
Received: from ankita-dt2.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Thu, 14 Sep 2023 19:45:59 -0700
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <jgg@nvidia.com>, <alex.williamson@redhat.com>,
 <clg@redhat.com>, <shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>,
 <ani@anisinha.ca>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <vsethi@nvidia.com>, <acurrid@nvidia.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
Date: Thu, 14 Sep 2023 19:45:55 -0700
Message-ID: <20230915024559.6565-1-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|PH7PR12MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: 374487b8-4334-4ebd-8d67-08dbb595e9ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QJqx1Z6NWoS9a+7Xuooo2ydAFw8DnLBUTw4oZv+LMBTBl19tV48rct3VR5QIl5cnNj4bPS6wT+h+1ja/wKnoJZjqdVDw5zubvSQUyhc4w206FCb+Dl0Xpskns1F4MnYugpFsxNPHkeW+K/dVJIHQv339UB6UzK0epBLdRpEu3NXHEPL6sCkfCDythXRQE/GnWmFyV69BHAuAVthI5yV57p87T4hTdUPnVwTJaATavAdP4yaiIOHPWUFOm62JjiNjcWA0YIoofkpE+h4L/2CEgpmnFmN3TrV9Hivhv4Y9/MrXZIf8fH0L+M1q7cnzyXTx5d/2nRDDDZWM1o4UKsdppKaJZrbbihRXSaP4xlWYT6YwKjOlraYaQJlE0SrTiDRF1pM7v5qLmu9zYPaEO/r4MSjMeXqyRuczIyXzyXd43IHeZVRMwnJUsablIa3n0X6YuZjr5kOBYOFEgZ+KQyMCrxaSw/LSTikOuZNE+5eaMlUtj6qtZefr3ICRoAnztdpg6wtygYtHGI7O9FlplUKpN/xjbMuk0VG1fjMa077WSnQVUY421aN5tmGG7ylfFMJg9RYAy2H4E+9abAWi0Ldjgy40S3Ay+kM2h4+Ey6g0jr6xCSVz26XbX6nPCMIX8My+Ghk/aDw/qkm6RPiwHwkb6N9LmlUzbyyiVRNmGFHEXhsUbyAtQuyyO6KxHgyHp+F7wv4f18SgNtiLD4FYre34AwsBJy0o6suPJnxboQP9CPK7cDppgv7z9uAGZtCdCQI8
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(82310400011)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(2906002)(2876002)(86362001)(36756003)(26005)(426003)(2616005)(336012)(1076003)(478600001)(6666004)(7696005)(83380400001)(47076005)(356005)(82740400003)(40480700001)(7636003)(36860700001)(41300700001)(4326008)(8676002)(8936002)(5660300002)(70586007)(70206006)(54906003)(316002)(110136005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 02:46:08.0505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 374487b8-4334-4ebd-8d67-08dbb595e9ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8425
Received-SPF: softfail client-ip=2a01:111:f400:7e8b::629;
 envelope-from=ankita@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
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

From: Ankit Agrawal <ankita@nvidia.com>

For devices which allow CPU to cache coherently access their memory,
it is sensible to expose such memory as NUMA nodes separate from
the sysmem node. Qemu currently do not provide a mechanism for creation
of NUMA nodes associated with a vfio-pci device.

Implement a mechanism to create and associate a set of unique NUMA nodes
with a vfio-pci device.

NUMA node is created by inserting a series of the unique proximity
domains (PXM) in the VM SRAT ACPI table. The ACPI tables are read once
at the time of bootup by the kernel to determine the NUMA configuration
and is inflexible post that. Hence this feature is incompatible with
device hotplug. The added node range associated with the device is
communicated through ACPI DSD and can be fetched by the VM kernel or
kernel modules. QEMU's VM SRAT and DSD builder code is modified
accordingly.

New command line params are introduced for admin to have a control on
the NUMA node assignment.

It is expected for a vfio-pci driver to expose this feature through
sysfs. Presence of the feature is checked to enable these code changes.

Applied over v8.1.0-rc4.

Ankit Agrawal (4):
  vfio: new command line params for device memory NUMA nodes
  vfio: assign default values to node params
  hw/arm/virt-acpi-build: patch guest SRAT for NUMA nodes
  acpi/gpex: patch guest DSDT for dev mem information

 hw/arm/virt-acpi-build.c    |  54 +++++++++++++
 hw/pci-host/gpex-acpi.c     |  69 +++++++++++++++++
 hw/vfio/pci.c               | 146 ++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h               |   2 +
 include/hw/pci/pci_device.h |   3 +
 5 files changed, 274 insertions(+)

-- 
2.17.1


