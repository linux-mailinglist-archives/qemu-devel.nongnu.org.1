Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 146F9723265
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 23:40:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6HvW-0001P3-RT; Mon, 05 Jun 2023 17:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6HvV-0001ON-5R
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 17:39:45 -0400
Received: from mail-dm6nam10on20607.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::607]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6HvS-0000AN-Op
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 17:39:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eye9dCvcuTtCQEaN2ApIiKl9MP+FDzVK8H29l04OFv92SW+0fvHjRz+FmFXaBnPXlhcdA0x3mc+pTnWqXhb3wrTdWarTfXdYm6PRjCn7RZlFiXU2PeDRDSRjNZSbDSZdZABckVFBGRC5T4smQNNcUtxYqSzbSmwjiI5sbMXpH6fd+YIwkawA4GkzVYR8ZzNp46pCkj2ihPfjMSmj4HmkMPFS7RZxCCb0IyMRIjHKjYJSGe8CcPXFWwn2O+2WlytS+APZoIZhH2qgQS8P1oujHxFEpXW7gnooH1o2N+c2br/E/TdqibadOaYuBHXGlayfSNvrnz8bX1KN5nEze9dgDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfRDU94bMdoc61HSELHL7IQkh2bGcfugwOV9R73tVWM=;
 b=PNA6jmuY8riAlf22ITusEymECPjEfzMsmJR1fDcIzTU7uwHKSk0K5e9it4Fn5e7Ns6i5VOPkolq3uFqlIsoLjYKXSMTBXBPTnRRULbqPBcH2UWEhuC9uNOywpj6dJLxKINpA/XW4hf0G8jEPZCRJ4UA5xia3lZUN1LYshgh8TyR0LkrYZqwsJCWz+tgejWD7Xf9B8mMo+/eEO0wOgqsRCHAN10Qj2kLeSHhfnKRLK+F02642tb4JrmMTVDh10CEu4pIPyq8h8rfl8R+b+Htk3RXjk1ytuA8GTGrjm9zAY0kdShO5n6iRsgbtqos0RzYrsLQb3hh2lgmB41/mjb+9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfRDU94bMdoc61HSELHL7IQkh2bGcfugwOV9R73tVWM=;
 b=baq80z9x94HFtNjRUoIWDgsxJuj5Yf7kSPCpUu97Grgm8vbQtV0TAaMJsrXMMsWZtN+yk2FF4XsuQ7x3WJt7rSoHNNet4eS478AvFnM2WMe2fMM2x9HRieOBtN3UqLMR1L3npMgb3JHv58DE6/5KoZ8pF4ZYQNJb6dG7npn+9Xo=
Received: from DS0PR17CA0005.namprd17.prod.outlook.com (2603:10b6:8:191::6) by
 IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 21:39:38 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::42) by DS0PR17CA0005.outlook.office365.com
 (2603:10b6:8:191::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 21:39:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Mon, 5 Jun 2023 21:39:37 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 16:39:36 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <imammedo@redhat.com>, <berrange@redhat.com>, <jusual@redhat.com>,
 <dfaggioli@suse.com>, <joao.m.martins@oracle.com>, <jon.grimm@amd.com>,
 <santosh.Shukla@amd.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 2/3] hw/i386/pc: Default to use SMBIOS 3.0 for newer
 machine models
Date: Mon, 5 Jun 2023 16:39:05 -0500
Message-ID: <20230605213906.644883-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605213906.644883-1-suravee.suthikulpanit@amd.com>
References: <20230605213906.644883-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|IA1PR12MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: dc4dc086-e2cb-48a4-02ce-08db660d5cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SbqRYaeaCQSqmLr/O3pDYRGtcHirTc0j429fkYD4JddwHUxFBGeop4+mC1WWlo/EeVpqo/HatuIIYCur2zRMhSi88kxB1rMpDqr0Ho+caYMHDi/Pe3zWAANpN/O2W4dESv7fJJhmRo7ApU91pVDQVmgOJ5q6NiseUDL3yJzSxA1jd08jsgwZ3FBV62RTGU0E1T4CSfd/nH1IsIdvE/p100tf/U8FF/y28woxqaedGvstnoJlUDkF+lHo3HuKwN6XHiazvrHotrqcgq8nMxBiMPvxzshzwnDBzG8gtcufwZItfzp/alOCbF+1Gn17WsuemAjLyp8RHLgzK8TSz+pSzYdDGio4JFVYypyz2uV/1OowXmsY0IA+z4ijWckKb43KXfwFOz/Y1V7VPFpNSPSHqRZy6a8jEkMeOa0Ycj5K/3/4MQ7ifmaRmhF6jJmm+qZNdLA4P/2j2OryC+TWW82TvJkNr4UHpBAPZrExWZsSSVWjjyt1M2NgDwwgLuv0Fxldig656hcp6efAAcPtw56mQIAFrrbs4+rzlubFB9S7BAebcnGcw5DVi+uLAUTTyqdZ4LsDbJa6OOIFAzGIy4dQ9G6IamAyMh/zwI0lbJAqsZBBBzT3Xh6MPjDOQBJSb8HT5zDzdWWllLVHT1rl1zfgd8zKlEgC+8n65dC3L3qVrRLMuBTwELIH+xNUyXu/NabsqjVXp8bv+oSpbnCxvt4wxVYvU9qI26DVVKAccqUrsIJz58c3pKbctu7ZU5HILEXXhvOsMUjjlvP1AqJY5/H0L28yoBSnyS23hjxKaPop7MU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(40480700001)(54906003)(81166007)(356005)(478600001)(82740400003)(70586007)(8676002)(8936002)(4326008)(41300700001)(70206006)(6916009)(316002)(2616005)(336012)(186003)(426003)(16526019)(36860700001)(83380400001)(47076005)(6666004)(7696005)(40460700003)(1076003)(26005)(82310400005)(44832011)(5660300002)(7416002)(86362001)(2906002)(36756003)(170073001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 21:39:37.8553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4dc086-e2cb-48a4-02ce-08db660d5cbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235
Received-SPF: softfail client-ip=2a01:111:f400:7e88::607;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
 hw/i386/pc.c         | 14 +++++++++++++-
 hw/i386/pc_piix.c    |  5 +++++
 hw/i386/pc_q35.c     |  5 +++++
 include/hw/i386/pc.h |  2 ++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 8fc34f5454..5a87b82185 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -786,6 +786,14 @@ void pc_machine_done(Notifier *notifier, void *data)
         if (pcmc->smbios_defaults) {
             MachineClass *mc = MACHINE_GET_CLASS(pcms);
 
+            /*
+             * Check if user has specified a command line option
+             * to override the SMBIOS default entry point type.
+             */
+            if (!pcms->smbios_use_cmdline_ep_type) {
+                pcms->smbios_entry_point_type = pcmc->default_smbios_ep_type;
+            }
+
             /* These values are guest ABI, do not change */
             smbios_set_defaults("QEMU", mc->desc,
                                 mc->name, pcmc->smbios_legacy_mode,
@@ -1782,7 +1790,10 @@ static void pc_machine_set_smbios_ep(Object *obj, Visitor *v, const char *name,
 {
     PCMachineState *pcms = PC_MACHINE(obj);
 
-    visit_type_SmbiosEntryPointType(v, name, &pcms->smbios_entry_point_type, errp);
+    pcms->smbios_use_cmdline_ep_type =
+        visit_type_SmbiosEntryPointType(v, name,
+                                        &pcms->smbios_entry_point_type,
+                                        errp);
 }
 
 static void pc_machine_get_max_ram_below_4g(Object *obj, Visitor *v,
@@ -1992,6 +2003,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
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


