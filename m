Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 136FE726F6E
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 22:58:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q70Dx-0006Y3-Ny; Wed, 07 Jun 2023 16:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q70Ds-0006X0-SS
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 16:57:42 -0400
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::600]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q70Dq-0002eF-HT
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 16:57:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrFtlLnDW3mVluWipODX4q970ock5gb8vlnbXZ3vBZcw8WT9w+Bb1BTWN0iylk/Oek2Ho7fXfOicbW6rq79f/TLcOnTnqBLZqr31bQ/ZPrSRToOky+SImYWCJOIKP0CH5SKQHr/LszcAP0m1Y/VND0L340bg+TsyH/Vb/61ZeUx4gy+/hxq5LWSbJs7Z2O3Ja4mjuWNMpKxJY5p4dfEnPdxDT3HZEtGkEWNXAbZfk7m3tdXefUyvtRW/L+XLlriT0EKM+nh77hMjgYF6q78SvDFFZSXfzwQEhvvi/fY8k/m4aNrv/zfV3kHKxEybLQlabGQ/tJ0fprngkcU6vyk/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p16rpRqWRL5opMtRdBjdK1YQnnGdt5a+9RbAPshvl00=;
 b=m/YjZqEyQ1rtOKPDMxywKAh9tqRTCpYB1nvU03FwG/bPS4kINlLrGLj6KIA04Ib3OFEssKlCKews2i/3Lkh4aAeC+iB0Tha9uqJSDckkjW0NBMjL4NglFkKykoIWJddCsfw2pWD88UnEYrV1+BmqAYSRbnkGQ0LZ57u5gLDZFpDnX670aCZVddDVyGQpd+9KkQTwoIeh8TmY451/G66kUWfpwch7wRAkfua2ZG/KB1Hq3ObbQoMXlwzhGwH01BEqclYTZgHXJnaCA8aUnctxXw5GNVOssfjAf/gReBbbIv8o4Y9F5AJKGAu8gPofbwz4sF05PDZrAkJj9nKKrLaWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p16rpRqWRL5opMtRdBjdK1YQnnGdt5a+9RbAPshvl00=;
 b=2JYaUluavNqrydb1qK3WPMnsPljNVKTJofAVGCLBUoY+h4vgDoRt5uHxbbP5C1DhConX/tGKuxnxfP3yNAb3e9d5JdN2n3WrnAJgghxxqLtXdfnos8MozMPtZONl5ajAh1bfpxdPZQlheg00NN/oBKAbwBtR3fooD2066uJknOo=
Received: from BN7PR02CA0014.namprd02.prod.outlook.com (2603:10b6:408:20::27)
 by CO6PR12MB5458.namprd12.prod.outlook.com (2603:10b6:5:35b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 20:57:34 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::90) by BN7PR02CA0014.outlook.office365.com
 (2603:10b6:408:20::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36 via Frontend
 Transport; Wed, 7 Jun 2023 20:57:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.24 via Frontend Transport; Wed, 7 Jun 2023 20:57:34 +0000
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
Subject: [PATCH v6 1/2] hw/i386/pc: Default to use SMBIOS 3.0 for newer
 machine models
Date: Wed, 7 Jun 2023 15:57:16 -0500
Message-ID: <20230607205717.737749-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607205717.737749-1-suravee.suthikulpanit@amd.com>
References: <20230607205717.737749-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT046:EE_|CO6PR12MB5458:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a45945e-30c4-4ad5-ec13-08db6799d15a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iYjzrhyKUJIUr/oLilmyJlWEn5hlQydShBwzUafc/aAXbQuIMEYu653GjN3TE+KZg5K+ESqqaV5TPy1kHkFi/yaKTVeda8cITKes22AlstfYekGtLjT6fAsglCVb2Yc0UD7Hq/VSDDnFadCFuJm9eVD4DEnhp/8fuv1J7Xy76WK/cK5EbzDbybi4dePr0zT8bSnaUGpaNM/Igxl0XaGeCUaW+Gg2AJaTK93LEd14wEoyC3EXtlmEVzlbTcJ2gSaZWJPahED7ZYYPrGNT095bsqpDGr6ICjdPHv3VEDjANK83k2GzjCdL1ziQid6TGKHjZ1Xs/j1B7/GWJnZ+9who1NR22NNR1IpgRL1SVc+yV/KUjnYj+5Uf7KLKCOXZwPXgyV4R9jWjDVP1iE0TxOd1tA+QvBJqqhih9jd26U7uv58Swjf7PhsaX4fRDft8E1LzGiQz7Rn+jtE2OwYt9QZUaukcZnqAVRmNY67+6tgWZL3X0ef6C3nk9vJqtwJJd0Lg1m+o3ZNwsicWh+SjlUh2ZvfBubxm9LXQHEjV7hh+vlCtBjfTtxm+9vHuNiwSHSvOaf0yArcZ+1JjWrZ6VAukogr7mfWLdtp/PCsKGIVBOtW3Zhd/fjp9z7twhPZlgM1vCzHwC+ZQoPHA8qprC3xqHYNNjHEY2POUcRHO9iP9XaGjfydsm0KXR/LHlws0NT3dAXAV10tiIefBAG7VGJIPlU9hlYVbv/dbgCZQwLukpHa6bn7CwG1N5veo/e9U3OaJc0kUoyv0Gv5FeTAHcebbyP+/DFPQiin5GZaGcWQpUxc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(44832011)(1076003)(26005)(7416002)(83380400001)(82740400003)(81166007)(36860700001)(40460700003)(16526019)(2906002)(2616005)(36756003)(5660300002)(86362001)(316002)(40480700001)(8676002)(41300700001)(8936002)(186003)(336012)(6916009)(426003)(6666004)(70206006)(70586007)(356005)(4326008)(54906003)(47076005)(478600001)(82310400005)(7696005)(170073001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 20:57:34.2642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a45945e-30c4-4ad5-ec13-08db6799d15a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5458
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::600;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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
 hw/i386/pc.c         | 4 +++-
 hw/i386/pc_piix.c    | 5 +++++
 hw/i386/pc_q35.c     | 5 +++++
 include/hw/i386/pc.h | 1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bb62c994fa..33ffb03a32 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1853,6 +1853,7 @@ static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
 static void pc_machine_initfn(Object *obj)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
 
 #ifdef CONFIG_VMPORT
     pcms->vmport = ON_OFF_AUTO_AUTO;
@@ -1860,7 +1861,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->vmport = ON_OFF_AUTO_OFF;
 #endif /* CONFIG_VMPORT */
     pcms->max_ram_below_4g = 0; /* use default */
-    pcms->smbios_entry_point_type = SMBIOS_ENTRY_POINT_TYPE_32;
+    pcms->smbios_entry_point_type = pcmc->default_smbios_ep_type;
 
     /* acpi build is enabled by default if machine supports it */
     pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;
@@ -1980,6 +1981,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->nvdimm_supported = true;
     mc->smp_props.dies_supported = true;
     mc->default_ram_id = "pc.ram";
+    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
 
     object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
         pc_machine_get_max_ram_below_4g, pc_machine_set_max_ram_below_4g,
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index d5b0dcd1fe..49462b0e29 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -476,11 +476,16 @@ DEFINE_I440FX_MACHINE(v8_1, "pc-i440fx-8.1", NULL,
 
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
index 6155427e48..6b9fd4d537 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -387,10 +387,15 @@ DEFINE_Q35_MACHINE(v8_1, "pc-q35-8.1", NULL,
 
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


