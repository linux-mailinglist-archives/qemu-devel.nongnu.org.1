Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F448725234
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 04:51:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6jFY-0000zw-EP; Tue, 06 Jun 2023 22:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6jFW-0000zm-Cv
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 22:50:14 -0400
Received: from mail-bn8nam04on2062b.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::62b]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6jFU-00029l-B4
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 22:50:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAEkGcunfvhSsV0AKrLAy1mY+4ydofgO5RI4JSRlWKtWPzSp4YawV3oTAUq3/EQcygglSGrIHzMCjRs6Xi7LJSqdkkc1UaTA3yg+fq5C/GQPEveKDsgM3r//bJ4yUWbdbLn9jl7helRK9UdBWxGm4mYws/dRHzMQmMtB0vX0bvbDefoclCRevCWFY8SeBOQC0W0Mg19kGiz2rDKSEImOtvD6nT1/p2CshXoj1syrWS/XMl4XDdKV8yITwXvNDoqlP1DT5dN6mF1Xe5KeyU7+81ZxFFhRMofDEHeQfXKGTWlvvK10RMAW/4+a9+1yIlKt0ce/lqSIgWjG6aryjdLnRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnnkjAIUfAsrQaRCV0CPp+2TM9Ws5yjKKcFt6C1ghxk=;
 b=bFU87hLcIJcTsw0zRtOjUKBohlh9LtqqUqo2bAeDrPUyLAtpn3miYKTIye6tluhw4YYGhS4B6gt6ZkKgjJhCyOY8Ya2rGzoGAd/ad5cCW7JaUxSLHEwTOMEBi8yYgAVM1T9bTlvP9h5TUvfhgOFzqNB1LD0ViHtd3CT1yk0MVQJt3WxqPAa2naHbI+P8rtSOyOc++0o/VYmFRTsk6OyYfITNfodfBgmp5Ne89K2zfmzlPU5xNun+QAUUDsnFBODHM6CtIC53d75ZInQKZV1cVwL18hhRnSbvL/xElj3NL5x8aYLwALpwyCF8hLxStoAuV0HDNlQUqNbUG+xoo0bn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnnkjAIUfAsrQaRCV0CPp+2TM9Ws5yjKKcFt6C1ghxk=;
 b=ySFdugH64Xnj1g5fdbHrNhXFnN1tDcsq4+orbm7IQmgq/IqZK4z+iaeOgGHkKEt+f0arzGpGNAXzEkx8ZLKCfIoAjZFd2rK1aI6TlZCWxB8BQ0kqrFVch3+t1ArSGP9GPPHxwxtyZiPVfuaw40zv5GCJTJlwCc9cd+eX0kU4ts0=
Received: from BN0PR02CA0050.namprd02.prod.outlook.com (2603:10b6:408:e5::25)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 02:50:06 +0000
Received: from BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::d7) by BN0PR02CA0050.outlook.office365.com
 (2603:10b6:408:e5::25) with Microsoft SMTP Server (version=TLS1_2,
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
 2023 21:50:03 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <imammedo@redhat.com>, <berrange@redhat.com>, <jusual@redhat.com>,
 <dfaggioli@suse.com>, <joao.m.martins@oracle.com>, <jon.grimm@amd.com>,
 <santosh.Shukla@amd.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 1/3] hw/i386/pc: Refactor logic to set SMBIOS defaults
Date: Tue, 6 Jun 2023 21:49:37 -0500
Message-ID: <20230607024939.703991-2-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT106:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: b825fe7c-6037-4baf-3b92-08db6701e689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xLh14kLVfFojqXmgRZ6NZka9KDeQiOqpt4aX/5ltydWs3fk0gAzbYHZlu7NFLUEKWOlgS1lWMElilnMCsig9b36QATiVNXla3K/ix4TVEZnHSLMctj6lGPhkozw5sgyssSnMdwQAwb+cZQsdPuWOPOvacKK6zBcMIpnzBz3nHRWjrA5UlZjIotnQ6dTgEpn6oZgZT/lr20bN3Z9SSI/C3mybFlW+iOS8/LUIfz0/M84cOpPNTKN5UoPodhYpDDSnewkjrRWhuf27dRAq1zN7Q5YHRp5x5xQ1lYOgCpVmRFqNp7Mm4kKVRPQ/RbtWBRXtSp4pJIrxYzakex4EwxyiqFgOiyoic3bv5AzXJ5HMxmb44zMuSz0GGGfK3aS4HCPBvulCV79LRRnCLxnaKfrjRQRu7sSvo8/mDy7FF83jUlmVXVpJK44yUTz4ZpsOT9Fb7vkM0tS4jOdGa48rk9/MaHVGD5thWhJWnVdS8pfPfX/w0eYF5RdeGaRfIrIxj63r55swICkWGmo9uwDtKBi1A6IUNtwW0N+ZUJXwKBVEmh6rvGpVSVK6n25qDzIH5dfJBtoLV2xIdTGXyhcVIYE4xb4J2jow/CX9Caxc6/O+BPSA2qvOGwzuzmzki+oNLPeoEUSEzrPtwRZ3+hBMuGCf15Tp5JAEkMkfvAph/44Dp//GJ4Ydd9VTX71AFXSbtlrSb8cXuXxnyj1LULZ9HvWn1PPWNSc6kA6QEGE3uRhZpoy5TDsXVDbMKKHlcjxFloLB3pgaMnKnl4pPixmtIw13HA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(36756003)(40460700003)(2906002)(54906003)(478600001)(82310400005)(86362001)(7416002)(41300700001)(8936002)(8676002)(5660300002)(82740400003)(316002)(81166007)(356005)(44832011)(6916009)(40480700001)(4326008)(70586007)(70206006)(83380400001)(47076005)(1076003)(2616005)(26005)(16526019)(186003)(336012)(426003)(36860700001)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 02:50:06.2188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b825fe7c-6037-4baf-3b92-08db6701e689
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255
Received-SPF: softfail client-ip=2a01:111:f400:7e8d::62b;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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

Into a helper function pc_machine_init_smbios() in preparation for
subsequent code to upgrade default SMBIOS entry point type.

Then, call the helper function from the pc_machine_initfn() to eliminate
duplicate code in pc_q35.c and pc_pixx.c. However, this changes the
ordering of when the smbios_set_defaults() is called to before
pc_machine_set_smbios_ep() (i.e. before handling the user specified
QEMU option "-M ...,smbios-entry-point-type=[32|64]" to override
the default type.)

Therefore, also call the helper function in pc_machine_set_smbios_ep()
to update the defaults.

There is no functional change.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 hw/i386/pc.c      | 24 +++++++++++++++++++++++-
 hw/i386/pc_piix.c |  9 ---------
 hw/i386/pc_q35.c  |  8 --------
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bb62c994fa..b720dc67b6 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1756,6 +1756,22 @@ static void pc_machine_set_default_bus_bypass_iommu(Object *obj, bool value,
     pcms->default_bus_bypass_iommu = value;
 }
 
+static void pc_machine_init_smbios(PCMachineState *pcms)
+{
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    MachineClass *mc = MACHINE_GET_CLASS(pcms);
+
+    if (!pcmc->smbios_defaults) {
+        return;
+    }
+
+    /* These values are guest ABI, do not change */
+    smbios_set_defaults("QEMU", mc->desc,
+                        mc->name, pcmc->smbios_legacy_mode,
+                        pcmc->smbios_uuid_encoded,
+                        pcms->smbios_entry_point_type);
+}
+
 static void pc_machine_get_smbios_ep(Object *obj, Visitor *v, const char *name,
                                      void *opaque, Error **errp)
 {
@@ -1768,9 +1784,14 @@ static void pc_machine_get_smbios_ep(Object *obj, Visitor *v, const char *name,
 static void pc_machine_set_smbios_ep(Object *obj, Visitor *v, const char *name,
                                      void *opaque, Error **errp)
 {
+    SmbiosEntryPointType ep_type;
     PCMachineState *pcms = PC_MACHINE(obj);
 
-    visit_type_SmbiosEntryPointType(v, name, &pcms->smbios_entry_point_type, errp);
+    if (!visit_type_SmbiosEntryPointType(v, name, &ep_type, errp)) {
+        return;
+    }
+    pcms->smbios_entry_point_type = ep_type;
+    pc_machine_init_smbios(pcms);
 }
 
 static void pc_machine_get_max_ram_below_4g(Object *obj, Visitor *v,
@@ -1878,6 +1899,7 @@ static void pc_machine_initfn(Object *obj)
     object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
                               OBJECT(pcms->pcspk), "audiodev");
     cxl_machine_init(obj, &pcms->cxl_devices_state);
+    pc_machine_init_smbios(pcms);
 }
 
 int pc_machine_kvm_type(MachineState *machine, const char *kvm_type)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index d5b0dcd1fe..da6ba4eeb4 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -198,15 +198,6 @@ static void pc_init1(MachineState *machine,
 
     pc_guest_info_init(pcms);
 
-    if (pcmc->smbios_defaults) {
-        MachineClass *mc = MACHINE_GET_CLASS(machine);
-        /* These values are guest ABI, do not change */
-        smbios_set_defaults("QEMU", mc->desc,
-                            mc->name, pcmc->smbios_legacy_mode,
-                            pcmc->smbios_uuid_encoded,
-                            pcms->smbios_entry_point_type);
-    }
-
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
         pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6155427e48..a58cd1d3ea 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -198,14 +198,6 @@ static void pc_q35_init(MachineState *machine)
 
     pc_guest_info_init(pcms);
 
-    if (pcmc->smbios_defaults) {
-        /* These values are guest ABI, do not change */
-        smbios_set_defaults("QEMU", mc->desc,
-                            mc->name, pcmc->smbios_legacy_mode,
-                            pcmc->smbios_uuid_encoded,
-                            pcms->smbios_entry_point_type);
-    }
-
     /* create pci host bus */
     q35_host = Q35_HOST_DEVICE(qdev_new(TYPE_Q35_HOST_DEVICE));
 
-- 
2.34.1


