Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C0B725236
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 04:51:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6jFc-00011B-UQ; Tue, 06 Jun 2023 22:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6jFY-00010M-I8
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 22:50:16 -0400
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::600]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6jFV-00029q-2L
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 22:50:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Is4QOH/h3vD0XAo4faDYjnPMgLVmch+xVzpm0N4zpSo1gmbVjxn0Z4YnsnbW2lXLblW+q85TcCeNpfBncqRjZqw28BNBTYVMVvKlSLFgblYpdvEKIgrSeZFVG5rmdfC28P8ap/KkALZB0egwmfji6lou+NSw33uB1IGBnlsNkmB1i9TLeS1b5bHh8BL30ajzlwea4rThIn53c/zQ1HRro94xJrAmltjY6oXrSjR4iJ08HPBo3yaTXy3G2p0R+7C4xVSxNDJx37mSGwZMoE2/HkfrP6ZQPS0KxRLmZMFjjTknc/RgNIhc6UNjf6kTWVer0UP7A28+Bje+X/ylTT9x+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYyvetY9dEO3GOSo4MPE7xao1BakK2r6LElIsmcQK78=;
 b=bd6t9qmvPpU4dqgWR9vmODR3dtl4Gzdpxu+fNs/RQJowZW3H+JKOkJnKB/N/+TPC8PvjRlGtWfhtcJZcxOD0NkeLchrUdkpVoDbWB66aZfg93YnTmRJ8ei2puNLFj/vMworMJbHBN9bvKHHxDrJZw6jF6fOSX6GDMlXNXlYjKyt2B5Yr0xCAGok0kDVka+rZ9sm0HcHaBhkTqVw39LceBHhAS/VupyOU4x3dKNveryh4xzIczr0knzZSq2jvu63SBNpuq1lz/p2SdctWLBbSBWPleFLKVOn+r6cBNV8Vid6RX89fPJb7kfjNIBuiOQxSuS/+3ThcT3uV/D13llMm5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYyvetY9dEO3GOSo4MPE7xao1BakK2r6LElIsmcQK78=;
 b=Pb8g/UF7/wRmrtkSFAEd662S316M6/MQ/hjuVdjbqcheRHnm5wslnaHt7SbsIv7zWCoe/2q3+XxATqVXSkB7eFhAfKk9rdA7vpfzDb7z9uJIUQ1MA7sltuYdIm+/jy1HeOn/9uHghoNqOfs7G73lG7vs3Ikt8wxQ9GG4oB7MNBE=
Received: from BN0PR02CA0045.namprd02.prod.outlook.com (2603:10b6:408:e5::20)
 by PH8PR12MB6819.namprd12.prod.outlook.com (2603:10b6:510:1ca::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 02:50:06 +0000
Received: from BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::d5) by BN0PR02CA0045.outlook.office365.com
 (2603:10b6:408:e5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 02:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT106.mail.protection.outlook.com (10.13.177.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Wed, 7 Jun 2023 02:50:06 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 21:50:04 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <imammedo@redhat.com>, <berrange@redhat.com>, <jusual@redhat.com>,
 <dfaggioli@suse.com>, <joao.m.martins@oracle.com>, <jon.grimm@amd.com>,
 <santosh.Shukla@amd.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 2/3] hw/i386/pc: Default to use SMBIOS 3.0 for newer
 machine models
Date: Tue, 6 Jun 2023 21:49:38 -0500
Message-ID: <20230607024939.703991-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607024939.703991-1-suravee.suthikulpanit@amd.com>
References: <20230607024939.703991-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT106:EE_|PH8PR12MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c55fb9-2afd-42d6-8540-08db6701e6d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vl8bGWQgdY/qZYbZKUK7hHUF4OAQSqj20kWVMcj+tjyS9BnyHBxeJQrxZjZD0Lu4MoivydzshnKBJYaOUiO04JafYUkSRFvuMJ4YBRLujk9/qwr/27nGQ3zVtj8hmRpDjoFqFQ1yaSGoLNuZ8gcV7pcoJaDnzRAQcXgn4YtIw8naPTIrJ0kvvulHdu57A06ocTS/B6N0CFGNbjf+IkXlcpKRajnsb0dO3CDxXhXEgvj69vGzUsGEZ3/h5vcVKzbmtvVNTGn5WdlyweEyuNdc7pR/yAvKsiBjDcMWifa7cpydXyLElO8g7JRf9KUl2HwJHJunYqtRAkzUEVV6uQDqR7KXBjW92RdOvyFVnynwqwUWLMTlnEVVVS76UgpGlHgqdzRbeAmuxMqBL2LEhr9r2lSt+VMPES0hQkdpww0JyPrCE1Pnbl/L0/XkW1I0euDMcHfV3uFKpS2jXeVwdc3x3B5qJX71qu+GyQF0lIpX/IOY3tImn5ygkv87ffoVyZ+/X34ynh1EvCXHwbqwoCTHy9jwSCI8AmGBc4udy5NOTx+5Ov1Zpe8EKHitHJh/hZxuQlnXRvcBkXs6ljj0cQlhjLKyciRz5oYX9sq5pAmGBqjMUbun91URvDKHoBHM2xFII332RLaWBRH3KNn0zKYPdxUeoDTUSZFBVqfjmDoaHm/J7PzZ1lIpRz6GVFm+WRtn0p4DhYUlJndSIMEzvHsO6vhs3D1pbNmhQo/cmnX2tZrrRF1n6yghyySzNeWKqXZlIDwSlZo+SR5AQ64Pljy/IncYGyhizx+PQzUGJWp4RO4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(26005)(1076003)(40460700003)(40480700001)(36756003)(36860700001)(47076005)(426003)(336012)(83380400001)(86362001)(82310400005)(16526019)(81166007)(356005)(2616005)(186003)(82740400003)(8936002)(41300700001)(44832011)(54906003)(2906002)(6916009)(478600001)(70206006)(70586007)(8676002)(4326008)(316002)(7416002)(5660300002)(7696005)(6666004)(170073001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 02:50:06.7500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c55fb9-2afd-42d6-8540-08db6701e6d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6819
Received-SPF: softfail client-ip=2a01:111:f400:7eae::600;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

Currently, pc-q35 and pc-i44fx machine models are default to use SMBIOS 2.8
(32-bit entry point). Since SMBIOS 3.0 (64-bit entry point) is now fully
supported since QEMU 7.0, default to use SMBIOS 3.0 for newer machine
models. This is necessary to avoid the following message when launching
a VM with large number of vcpus.

   "SMBIOS 2.1 table length 66822 exceeds 65535"

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 hw/i386/pc.c         | 6 +++++-
 hw/i386/pc_piix.c    | 5 +++++
 hw/i386/pc_q35.c     | 5 +++++
 include/hw/i386/pc.h | 1 +
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b720dc67b6..b5c585579a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1765,6 +1765,8 @@ static void pc_machine_init_smbios(PCMachineState *pcms)
         return;
     }
 
+    pcms->smbios_entry_point_type = pcmc->default_smbios_ep_type;
+
     /* These values are guest ABI, do not change */
     smbios_set_defaults("QEMU", mc->desc,
                         mc->name, pcmc->smbios_legacy_mode,
@@ -1786,11 +1788,12 @@ static void pc_machine_set_smbios_ep(Object *obj, Visitor *v, const char *name,
 {
     SmbiosEntryPointType ep_type;
     PCMachineState *pcms = PC_MACHINE(obj);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
 
     if (!visit_type_SmbiosEntryPointType(v, name, &ep_type, errp)) {
         return;
     }
-    pcms->smbios_entry_point_type = ep_type;
+    pcmc->default_smbios_ep_type = ep_type;
     pc_machine_init_smbios(pcms);
 }
 
@@ -2002,6 +2005,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->nvdimm_supported = true;
     mc->smp_props.dies_supported = true;
     mc->default_ram_id = "pc.ram";
+    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
 
     object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
         pc_machine_get_max_ram_below_4g, pc_machine_set_max_ram_below_4g,
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index da6ba4eeb4..1a2bb25c75 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -467,11 +467,16 @@ DEFINE_I440FX_MACHINE(v8_1, "pc-i440fx-8.1", NULL,
 
 static void pc_i440fx_8_0_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_i440fx_8_1_machine_options(m);
     m->alias = NULL;
     m->is_default = false;
     compat_props_add(m->compat_props, hw_compat_8_0, hw_compat_8_0_len);
     compat_props_add(m->compat_props, pc_compat_8_0, pc_compat_8_0_len);
+
+    /* For pc-i44fx-8.0 and older, use SMBIOS 2.8 by default */
+    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
 }
 
 DEFINE_I440FX_MACHINE(v8_0, "pc-i440fx-8.0", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index a58cd1d3ea..371cca7484 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -379,10 +379,15 @@ DEFINE_Q35_MACHINE(v8_1, "pc-q35-8.1", NULL,
 
 static void pc_q35_8_0_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_q35_8_1_machine_options(m);
     m->alias = NULL;
     compat_props_add(m->compat_props, hw_compat_8_0, hw_compat_8_0_len);
     compat_props_add(m->compat_props, pc_compat_8_0, pc_compat_8_0_len);
+
+    /* For pc-q35-8.0 and older, use SMBIOS 2.8 by default */
+    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
 }
 
 DEFINE_Q35_MACHINE(v8_0, "pc-q35-8.0", NULL,
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index c661e9cc80..6eec0fc51d 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -110,6 +110,7 @@ struct PCMachineClass {
     bool smbios_defaults;
     bool smbios_legacy_mode;
     bool smbios_uuid_encoded;
+    SmbiosEntryPointType default_smbios_ep_type;
 
     /* RAM / address space compat: */
     bool gigabyte_align;
-- 
2.34.1


