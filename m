Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 374AC726F6F
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 22:58:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q70Dv-0006XS-Qu; Wed, 07 Jun 2023 16:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q70Ds-0006Wz-Np
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 16:57:42 -0400
Received: from mail-dm6nam12on2060b.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::60b]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q70Dr-0002el-2m
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 16:57:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OI2YpcPCT620aqSevZRl0ZfPKprXDsJDNPXoVHkQ0xgWRxWiosxK1kc5GXbCN6+tXCOxFOdeFbzF0muQ2Ryr59qCfQv1fGyNrtFzk6rB9180JgNP2psvfmrpoHB/3q5+7NDkjFFusNWcS4AiV0S3KpUATdQtAgfcnualoNM26qAJqtYJDeLkS02L+Fa2lAbudzMfXWKOucdPnDJBNfkOJlbeFYOQmLPDv8eV0NmDpeUeoGSMLJVsf/lpoogWYa2EnqHA6IfELZSZqNtcH8ToRTewE/6s25nc6FV2KFxY+2CmV/UNF4ndMC2ypJ60+9ec+KbkaCfBsLCuKepSnhogaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIuJ6aWWUFFBJVYUov+EaIEbf010KZ4tkGnVLrOburU=;
 b=nUSYkXDU7+oopwYlBcWoohvA5/5bDpH5WCDMc/AlEvo8TTUIYBdPgwIpwZ8Rjqpe17BMrZ9hob6+CMu4ApR8HOFBNJpHqGyxs8VTmwHwliMsBIkiFbo8ArvNhwx6WUSXvgmYwit0CLQi2csuNNRnS108s9DXgCYDGQdmYBsWUsRC0FML+EbtlP14mJP7UjhUn3ZJo9lK/AWC34XlhZQFD6dlTw/M1Oi7BHMxSvXCS8s4uSuAuacqPhZAmA5kaso+FzY/cGaDkpbId5Zf5k1ikbIYnb8qcqZr0jYLplRDdK2KbvgCZxglFTTBmQLHVlz6PFapGf+Mj2tAxHn3CFUPlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIuJ6aWWUFFBJVYUov+EaIEbf010KZ4tkGnVLrOburU=;
 b=2Kst3jyq1rIc5KVEu7lb3K4CNfqArItV9z7/XA9OVx/f2dBxJtqnqrdtHz2gH/y5wPbbypW0LTZMK9Adfo6ZljEfNoMYV2sqHaTKPHFnHwX0AM83xmoH/qDuGTusG5M6DPdHsP1sfI1k6Ha2ybdeFuJzkA4uagA+Ru14+mkboIg=
Received: from BN9PR03CA0450.namprd03.prod.outlook.com (2603:10b6:408:113::35)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 20:57:35 +0000
Received: from BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::77) by BN9PR03CA0450.outlook.office365.com
 (2603:10b6:408:113::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 20:57:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT069.mail.protection.outlook.com (10.13.176.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.36 via Frontend Transport; Wed, 7 Jun 2023 20:57:35 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 15:57:33 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <imammedo@redhat.com>, <berrange@redhat.com>, <jusual@redhat.com>,
 <dfaggioli@suse.com>, <joao.m.martins@oracle.com>, <jon.grimm@amd.com>,
 <santosh.Shukla@amd.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 2/2] pc: q35: Bump max_cpus to 1024
Date: Wed, 7 Jun 2023 15:57:17 -0500
Message-ID: <20230607205717.737749-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607205717.737749-1-suravee.suthikulpanit@amd.com>
References: <20230607205717.737749-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT069:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 552206ae-5c07-4561-873e-08db6799d1ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W6qJusRF6YHr6W/pLExnizdnb5qtgj4xCTeYWlxHr/4uH4Y3LmnnRbqVEySVx4nk7pv5IiN3XfcnygO3AyjSIz6kMHkNUOFsTv/BZSlAZtwRcN59OjQ5JEONR7syoF1fZqi6BCg4J7H5zuAdgtaB4VVs4yQ5BPOblrt5yL6aOmLHTVFkCYv/EQNajjqhP4BU281AVJWC1f9zGMptye+UE/Grl0stb1wfeWtz46zOnwYhi2S8oQWEek1ADOJ0OAJ8DhZnezrwd0zXBYzCK977mt9CsM3OFZmX2GO0W2JBw0shsP17WsR6veSzieiCtJBMoSuxirOD+PXHMkRJ+KhL6WaIWTiyb7EXw4vt/L5ercgBuSBcqEy2z5InRuAXLLHRIgKlmBUXGt6Uw1eWE+1GmyilWMnprcEoriojR1gMefuCsO+M4sztF4bL2u5f3wgRKai3wtzzEYMfoYlyTXZuqnniNlnkARns8i6RrMrCoKoRs0LfM6w34IBaeEcdtDDlNvs5thSnLxhJnLP/253z49XMWidv6hvrW2j6ghbFrw3KJNsxVy6gSlJ/LObrZy4QMsziTJ4z8JONeAVsj7/nuxWz+OfaPs0Am2SFdUT5iANeRE7fvs7GXNV8q52CxxxkQ3PEvW5ee7u5aIqiNKTgFRnXMVsQ1plQwFC7d2YGbsV2Ta99ifSJNZbhbJXur/1MXvummQSYt3apsPMA3A1FCHcfSFZ8OCw8WKXxfw5ta3XqZsqFXoRjntsNsZMYvQlkHuYSYhztvIYSWj5FANYne3B3C2cCySKD49Mcba7thb8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(41300700001)(478600001)(316002)(44832011)(54906003)(7416002)(356005)(81166007)(82740400003)(5660300002)(2906002)(70586007)(6916009)(4326008)(8936002)(70206006)(8676002)(6666004)(82310400005)(7696005)(40460700003)(86362001)(36756003)(2616005)(186003)(16526019)(26005)(426003)(36860700001)(1076003)(336012)(83380400001)(40480700001)(47076005)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 20:57:35.2381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 552206ae-5c07-4561-873e-08db6799d1ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996
Received-SPF: softfail client-ip=2a01:111:f400:fe59::60b;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

Since KVM_MAX_VCPUS is currently defined to 1024 for x86 as shown in
arch/x86/include/asm/kvm_host.h, update QEMU limits to the same number.

In case KVM could not support the specified number of vcpus, QEMU would
return the following error message:

  qemu-system-x86_64: kvm_init_vcpu: kvm_get_vcpu failed (xxx): Invalid argument

Also, keep max_cpus at 288 for machine version 8.0 and older.

Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Julia Suvorova <jusual@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 hw/i386/pc_q35.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6b9fd4d537..b26fd9bbaf 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -368,12 +368,12 @@ static void pc_q35_machine_options(MachineClass *m)
     m->default_nic = "e1000e";
     m->default_kernel_irqchip_split = false;
     m->no_floppy = 1;
+    m->max_cpus = 1024;
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
-    m->max_cpus = 288;
 }
 
 static void pc_q35_8_1_machine_options(MachineClass *m)
@@ -396,6 +396,7 @@ static void pc_q35_8_0_machine_options(MachineClass *m)
 
     /* For pc-q35-8.0 and older, use SMBIOS 2.8 by default */
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
+    m->max_cpus = 288;
 }
 
 DEFINE_Q35_MACHINE(v8_0, "pc-q35-8.0", NULL,
-- 
2.34.1


