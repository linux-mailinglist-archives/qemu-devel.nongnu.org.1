Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B4B720D99
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 05:25:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5Hrh-0004j5-Nc; Fri, 02 Jun 2023 23:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q5Hrg-0004iw-6V
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:23:40 -0400
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::600]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q5Hrd-0002yQ-77
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:23:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eixLZ/GJT7omYwzoc1TF38X9dTPO7ePUzAtHxLi5mxCDfRuOD1ARwFWJk6AdjZLBZdZXlfJ9mP3xpzkmCSlkX2btu+aX+nOiOm+ZPcelowmFnx4dWTyM+aKQRPRZHSeFOroXXB5jtrC+U6Nu+QhG64dnVKorUmhevjohx8Qj10093yVOG8/kZQjj93AZlNlQW2fiDY9qbTig+3B2HLYeayYXWl0R6BZg+rUGkfTgJIWfFLZmye+D7E2bsBm1PRePRgL01JbxgSaZH05rGvaB5vKOEj2S97QKLOwuKPOjUFP18KLgyeiht+GjTRzBy11JoUfjSV309JI3V2ZlITAONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFhxDCRF8GeMrrS0ZI/crF3sNgmkXLGkAy9E/tO6Tuc=;
 b=affqTDKQupcDqe1IKTHUCIB5GwxGCmzdHe3iR9dmylN8Gzy6Rz8m5IHJxnDo9b+t8IOMw3TDlWRnUCinngYmx922PPhtPp/lR//iam/CjtGH1smoIxbvVFJhGKcDjFZuK/nV+xvO9bRlJ1syJP7r+JH422SYaXndyFbSXo6aQ4agTWU5q+A2qjILI/PLUaWM/DmPHgmIBTTT6o/e5iYyYRojnzCmUytjuYWi3uh4BuB0etLmQDF+RTU6x0uNmS8fiW0hlSSN/8tNhXGhb3++XPaufY6OOgON/NemT/TVWwKcgLO/siPzKdyeWL9jzuzzRT+685PphqS9mRYY+/EZ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFhxDCRF8GeMrrS0ZI/crF3sNgmkXLGkAy9E/tO6Tuc=;
 b=BuhixTyRbo5UOgERrUVvyCtxLrv43In4e3LFMy8qQOiCsaNIMOLKQ8mWjKiDLTjZ8Ion9zzl0wRH17gS4tGgS/RyeebuPXr6B3+DfhGu5QAP+vIGp35vr/BZyB1lMMTPjD0WJV/VtnUbOs+vgcFCzGV1FdnRZZ8LCJAiTfukULA=
Received: from MW4PR03CA0098.namprd03.prod.outlook.com (2603:10b6:303:b7::13)
 by CH0PR12MB5170.namprd12.prod.outlook.com (2603:10b6:610:b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Sat, 3 Jun
 2023 03:23:28 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::c8) by MW4PR03CA0098.outlook.office365.com
 (2603:10b6:303:b7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Sat, 3 Jun 2023 03:23:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.26 via Frontend Transport; Sat, 3 Jun 2023 03:23:27 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 22:23:26 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <imammedo@redhat.com>, <berrange@redhat.com>, <jusual@redhat.com>,
 <dfaggioli@suse.com>, <joao.m.martins@oracle.com>, <jon.grimm@amd.com>,
 <santosh.Shukla@amd.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 1/2] hw/i386/pc: Default to use SMBIOS 3.0 for newer
 machine models
Date: Fri, 2 Jun 2023 22:22:54 -0500
Message-ID: <20230603032255.517970-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603032255.517970-1-suravee.suthikulpanit@amd.com>
References: <20230603032255.517970-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|CH0PR12MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: 5127c72a-fe31-4011-55f6-08db63e1e5f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p98h5zIMLhqS88lnPZyZcCsc7v+3eBgAxdm1LbOaxI21rdL784QKyOvomDQVAmCsFUe+3FR/FA1uX0XKKEbhch8JwXiMkM+Ud8kmWAg4lrImKac4LhqLRUCpIfTxfoChCAUu/um+NaNLCo05Uu/mSjtK2lsiXiBlcSXBRqAGI0L+39HGEkw9cDLjzpQsjcYklcvZOgVyZrPaknw7fBTetE5J80seh43BYHHpM3eJatd7PSejnPWSCXPLGw3GJ4tNEImU2m/B2k47ptlBLPC8W3ilWKu5uqcn9YTNSc+quLVjBuSvpNh69SpgbaAP3DlR0Qu3OY4vKbZSfOjun6GrCWNQKKEwwVJc2SZrDxdc4eDoVAQc+xTp2SMRTSjjeKmLG6k54O5k66AtOmvilRTEgMummbN/lsjZwC8o/MYNrEaDtMUGRKTYD6I8H5P2wI4CdHCAczAml++rM+336aqaJQj/tmjh18XX/zH7q+ybGkkMZaeC4wLQEWKyfp/xEewZRyT9VnbixVplpby54v/Cl/qyia1HnakByVpK7Oxyq6tN7RseT4cD0ixQU+lpqwd6bEqmLk/I1/Cy2fc40i6KPXtkn/fsUyqN5p/IzccCKxrNCeQMG/QJFClAwQjgEuzge1Hx2mVY/KEYmghEIYzEHN+yql05lVK8agzDwU5OsUoQyZ1y9MlvEIjceeODd/jpd/A4XhPdAS+r3FVGnRT1lnvSvZ/sT0ZF1WxHp/qKEv52TfkUD2w2twGS4+MSuozMmLtdF/PSI5HsfeBLbe7JHJUwgTou5F+NDxBqCE36UHk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(7696005)(40460700003)(6666004)(26005)(1076003)(40480700001)(83380400001)(47076005)(426003)(336012)(36860700001)(16526019)(186003)(36756003)(2616005)(86362001)(82740400003)(356005)(81166007)(44832011)(7416002)(54906003)(5660300002)(316002)(41300700001)(8676002)(8936002)(6916009)(4326008)(70586007)(70206006)(478600001)(2906002)(170073001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 03:23:27.8437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5127c72a-fe31-4011-55f6-08db63e1e5f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5170
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

Note that user can still override the entry point tyme w/ QEMU option
"-M ..., smbios-entry-point-type=[32|64].

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 hw/i386/pc.c         |  5 ++++-
 hw/i386/pc_piix.c    | 14 ++++++++++++++
 hw/i386/pc_q35.c     | 14 ++++++++++++++
 include/hw/i386/pc.h |  2 ++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bb62c994fa..fced0ab0eb 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1770,7 +1770,10 @@ static void pc_machine_set_smbios_ep(Object *obj, Visitor *v, const char *name,
 {
     PCMachineState *pcms = PC_MACHINE(obj);
 
-    visit_type_SmbiosEntryPointType(v, name, &pcms->smbios_entry_point_type, errp);
+    pcms->smbios_use_cmdline_ep_type =
+        visit_type_SmbiosEntryPointType(v, name,
+                                        &pcms->smbios_entry_point_type,
+                                        errp);
 }
 
 static void pc_machine_get_max_ram_below_4g(Object *obj, Visitor *v,
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index d5b0dcd1fe..2905b26666 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -199,6 +199,14 @@ static void pc_init1(MachineState *machine,
     pc_guest_info_init(pcms);
 
     if (pcmc->smbios_defaults) {
+        /*
+         * Check if user has specified command line option to override
+         * the default SMBIOS default entry point type.
+         */
+        if (!pcms->smbios_use_cmdline_ep_type) {
+            pcms->smbios_entry_point_type = pcmc->default_smbios_ep_type;
+        }
+
         MachineClass *mc = MACHINE_GET_CLASS(machine);
         /* These values are guest ABI, do not change */
         smbios_set_defaults("QEMU", mc->desc,
@@ -453,6 +461,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pcmc->pci_root_uid = 0;
     pcmc->default_cpu_version = 1;
+    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
 
     m->family = "pc_piix";
     m->desc = "Standard PC (i440FX + PIIX, 1996)";
@@ -476,11 +485,16 @@ DEFINE_I440FX_MACHINE(v8_1, "pc-i440fx-8.1", NULL,
 
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
index 6155427e48..2d1bb5fde5 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -199,6 +199,14 @@ static void pc_q35_init(MachineState *machine)
     pc_guest_info_init(pcms);
 
     if (pcmc->smbios_defaults) {
+        /*
+         * Check if user has specified command line option to override
+         * the default SMBIOS default entry point type.
+         */
+        if (!pcms->smbios_use_cmdline_ep_type) {
+            pcms->smbios_entry_point_type = pcmc->default_smbios_ep_type;
+        }
+
         /* These values are guest ABI, do not change */
         smbios_set_defaults("QEMU", mc->desc,
                             mc->name, pcmc->smbios_legacy_mode,
@@ -359,6 +367,7 @@ static void pc_q35_machine_options(MachineClass *m)
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pcmc->pci_root_uid = 0;
     pcmc->default_cpu_version = 1;
+    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
 
     m->family = "pc_q35";
     m->desc = "Standard PC (Q35 + ICH9, 2009)";
@@ -387,10 +396,15 @@ DEFINE_Q35_MACHINE(v8_1, "pc-q35-8.1", NULL,
 
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
index c661e9cc80..f754da5a38 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -50,6 +50,7 @@ typedef struct PCMachineState {
     bool i8042_enabled;
     bool default_bus_bypass_iommu;
     uint64_t max_fw_size;
+    bool smbios_use_cmdline_ep_type;
 
     /* ACPI Memory hotplug IO base address */
     hwaddr memhp_io_base;
@@ -110,6 +111,7 @@ struct PCMachineClass {
     bool smbios_defaults;
     bool smbios_legacy_mode;
     bool smbios_uuid_encoded;
+    SmbiosEntryPointType default_smbios_ep_type;
 
     /* RAM / address space compat: */
     bool gigabyte_align;
-- 
2.34.1


