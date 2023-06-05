Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAD7723277
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 23:45:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6I0M-0004nJ-Hw; Mon, 05 Jun 2023 17:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6I0K-0004mz-Bm
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 17:44:44 -0400
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com
 ([40.107.243.48] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6I0I-0002Yf-DA
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 17:44:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8YOsy/IfUNTAIz3D3mX1ftlRyIBSESkHghzeZWEQR+5TAD6lqMZqRRaaYY+2z4Gr3xCjp9IabLcBU8nopMt2u7IRVB9jLW/LC1xh2EV62YjtBYsk4zisnCi3B2nenUe8L93Fvvr3eV9feVLtNtBalvh6VmlyobYwpropZCUTslU/aGHmYNnWGcDdn/1/8diUhDq/gURxhjwUD/WPecFJLR5NKs6/PbWuuA6046Yvb5M2PASUxRanQxXVsTzQmmw3aKWI2ks/0aSPamIZ6UQxbjL30zywUZFGeqKUmy8vxnUk2FPZpJ65RtHsG9xaTFS2NMlm7siaXBoRD6dDNqXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDfHYxfFZq/WoxqBygKNiCbz024sUu5HQEh5XtsRkRc=;
 b=EVhPl5zh1a7tHJUrxsHJO2I+LZdwqcklOOOnZiwDOXUsiTTXt8/o6qpNb8eX637ID2pv5hRWsVdw7+ahplPq3Lh69EJhPVToHG3W+tyKOmQB3uSKhh69rz+y9O8y2m7+13v4s5IcHVNUg85NGq9wdGJk0SHk8Me/YirvDEP+RvcXtWJwu9BsK+ew+vZqugkepsxdw2b3pvTwBA1V2tlPzhZzU/hfpeSXXFXYODSrlpedtiUJD0gnp/xXtJ58mUvjukdj3XMuGiI84Znz1YYp0KuAuh7n0sn8BY3xJ82A6i4SgIXjEZ3STO3KRBYaM9njn+kt+iGLXA590gj+zg/O5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDfHYxfFZq/WoxqBygKNiCbz024sUu5HQEh5XtsRkRc=;
 b=3JGGz6KliV1HmCF+ogNnzK2ikS4hiBYQ8tI0mWSI17sSr5Jkmb3uPg1SM+84E8JbLgYlA+01b6uEj5ZvYRvwiNOBTcwoGHxvR2yTKZsL+Y5Wdr4K5PHXK+aAYqrvcUQRZUGpTuX6kE9r/PBf9JplsDGXqUmSnfCTpDwcbEOl+0c=
Received: from DS0PR17CA0010.namprd17.prod.outlook.com (2603:10b6:8:191::26)
 by PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 21:39:37 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::9f) by DS0PR17CA0010.outlook.office365.com
 (2603:10b6:8:191::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 21:39:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Mon, 5 Jun 2023 21:39:36 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 16:39:35 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <imammedo@redhat.com>, <berrange@redhat.com>, <jusual@redhat.com>,
 <dfaggioli@suse.com>, <joao.m.martins@oracle.com>, <jon.grimm@amd.com>,
 <santosh.Shukla@amd.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 1/3] hw/i386/pc: Refactor logic to set SMBIOS set defaults
Date: Mon, 5 Jun 2023 16:39:04 -0500
Message-ID: <20230605213906.644883-2-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: 2336f29a-95f6-4559-f6de-08db660d5c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1JD2Ch7R1YObsrkjHSshrNYKut9IpLSGZhjoArYgt2IsTEmmm3KrKLgz5U8tVswq2y/DGrsA6Sc+Y7WB4ZGn+UFSkH5If8jhRc4dT1g9gkcdbYoTdCxBAUtykpRLA5NUz9RWxkVah9/wfMfP7rhVYRb39JbBeEvQY9Oy7X4GFngOQLMASqV/sPPLjaPipuXGuRiE+zgLeFe/eJP6WzAoxJl30FWJxUiTd3XlfaHN5VZsONhGPz7IOoNcmy6oCZ4YJC5FalfaL2ZXMVyvMu5Ju4r9uCigLmoIM637SSlhRas6g57VvmwiaDgDBFJRLTzNTRH1VXsLwmCuQa+YgSwKgK2HUSABz+vIK9hPjUXhAuKjEmM2XHYM7LI1HApetrZXHFwLKY+uSOnEwtNkJbJDMi6dxV6fXYI/dZNQJZhabwFPGHKt3QdYI9Hny3PSCxRe8p/EotDx7E87k3b+6x7S94lBpiixkwqGiSZrwNqJcVA6S20zgXGWihEkrX6v8Xa/jEwgllI0aPIkvHSuYRLAzR+cLVaemKcaZrANSxXAXD63opbBz53zPOaZIPiPOLW9zYcXG75iobys2df32Zd8FHnJu+WPSSlBMqedxhnGxt2bwild5Kqi6BNVLc2iWNCppH+xfRp9xTyc8ezkJlFBbqo+YwhdXbQ9yShHGbB3rBg+8PNOHL2uyqxUI8gSZtl7bPaNR47vhcyuvQQZcjO1mhyPbMIOTRDmhn2iDCgYJXY1aM3ut/wK7TrrU0gheAjhu9sKUCP3QzI+F5W/d9HRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(70206006)(70586007)(2906002)(478600001)(316002)(8936002)(4326008)(6916009)(8676002)(41300700001)(54906003)(44832011)(6666004)(5660300002)(7416002)(7696005)(1076003)(26005)(40460700003)(16526019)(82740400003)(356005)(2616005)(40480700001)(186003)(426003)(336012)(83380400001)(47076005)(36860700001)(81166007)(36756003)(86362001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 21:39:36.7146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2336f29a-95f6-4559-f6de-08db660d5c0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586
Received-SPF: softfail client-ip=40.107.243.48;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

In preparation for subsequent code to upgrade default SMBIOS
entry point type. There is no functional change.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 hw/i386/pc.c      | 12 ++++++++++++
 hw/i386/pc_piix.c |  9 ---------
 hw/i386/pc_q35.c  |  8 --------
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bb62c994fa..8fc34f5454 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -781,6 +781,18 @@ void pc_machine_done(Notifier *notifier, void *data)
 
     acpi_setup();
     if (x86ms->fw_cfg) {
+        PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+
+        if (pcmc->smbios_defaults) {
+            MachineClass *mc = MACHINE_GET_CLASS(pcms);
+
+            /* These values are guest ABI, do not change */
+            smbios_set_defaults("QEMU", mc->desc,
+                                mc->name, pcmc->smbios_legacy_mode,
+                                pcmc->smbios_uuid_encoded,
+                                pcms->smbios_entry_point_type);
+        }
+
         fw_cfg_build_smbios(MACHINE(pcms), x86ms->fw_cfg);
         fw_cfg_build_feature_control(MACHINE(pcms), x86ms->fw_cfg);
         /* update FW_CFG_NB_CPUS to account for -device added CPUs */
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


