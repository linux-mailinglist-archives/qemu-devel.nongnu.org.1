Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D427266F0
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 19:16:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6wkN-0008O8-6q; Wed, 07 Jun 2023 13:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q6wkL-0008Nt-IA
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 13:14:57 -0400
Received: from mail-dm3nam02on20625.outbound.protection.outlook.com
 ([2a01:111:f400:7e83::625]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q6wkJ-0005tH-I3
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 13:14:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aa2q8v3/vX8+XCnOcLhqs8dqIARgfvD8CM+KcZudHC0asylBAlRnKvw/taNlXxTHgPa5LDahgImGcwKfw0CHeE83PWueT7dawekEAOctdXCcKkMxt9NXmejjI3c8WoJdJU5JAu5UNmz/fgZEcnxEVihd8QjzewSMHV3hhX6Igrr/z+ZcCGxeBsNMfWw4SQFwrMpRq6J3foa5vpZt3PHqT3Y9b98eqJbE+xx3Q9i59c/7vYFk1GUcpYxmvvojvnVovN5EJa2qVvvSK06AAPsY1LeV1s3pRGWwUCBMdAHbzmOvMdck126r4+2pPsveEAAOFhYMPFp2g3lQV07cdjYPXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIZ9Kqy8YjbQSlG154dbv8xge2cMSr2whayKUQPoX5U=;
 b=XQIrKpx94v1YoNLeFKDivI4drqGdFU/WPyE+BFZLoqjAhOe15TWxio9qaJGTGQNIO9EW8glJcXn1wkGcRwiO0Yf5p/kdrmGJhi0+IEWwC3EiojrNt3bnDbpPsYW3iTy7kzHhUvquabUJ+KhquLNZ+yPSRjU6BXAkiTIDQbx0QvAK7FMXMArZA3ypsy4zEYKS5e/X5Aeuk3WVkqtFaSsFWAc562NSo9DWduLANdd7Fyog+bzEJXFnEtR2PyI9SFwz1Fb/LwqRsFY0sIM/j1C33GRKtrtmgXjfkHDa5zmP/9g099q8T4AdOa/GYk+ehBawnD1mDNiUjk37+l6CqkYSZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIZ9Kqy8YjbQSlG154dbv8xge2cMSr2whayKUQPoX5U=;
 b=4Du4P69VS1oJiyVQO7giGTBQCBNRFVPfWmFynrwAf3BjFT2Eoe6m4Oftz9X+GyVwPQi+o+UPMdDl7/ZuA+DnqXdhrSLa8AIgEij+jv4DY3PxFftx5knqx9bnRoo4dgBaVrKtpzzfG3euLycJKevbRdndOVylXUeuzEmea1Y5Qzw=
Received: from DM6PR14CA0062.namprd14.prod.outlook.com (2603:10b6:5:18f::39)
 by SJ2PR12MB8033.namprd12.prod.outlook.com (2603:10b6:a03:4c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 17:14:52 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:18f:cafe::75) by DM6PR14CA0062.outlook.office365.com
 (2603:10b6:5:18f::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 17:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 17:14:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 12:14:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 12:14:50 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 7 Jun 2023 12:14:50 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, Stefano Stabellini
 <stefano.stabellini@amd.com>
Subject: [QEMU][PATCH v7 02/10] hw/i386/xen: rearrange xen_hvm_init_pc
Date: Wed, 7 Jun 2023 10:04:51 -0700
Message-ID: <20230607170459.14722-3-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230607170459.14722-1-vikram.garhwal@amd.com>
References: <20230607170459.14722-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SJ2PR12MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 09aa8e4c-2ff5-4e06-c5c1-08db677ab48a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LrwonVaF+Z+EfBp6MmZWPBHksKUAJF+zlf2B1blhfn19r9btywL5xwSbtkjR+ddFc+lhu5QtDX7SsHgfLub2QKLqOPjT6L5a6WiiuIBF+iJv4BCctgBwabbrLsAoLOIGmHRnjc+OHYZolGf3EHmSYU/LqisnaPAxPvShxcBdywaDNlMO/7zEzgOj2X5l4C7sEFX1IdWt0GQ3r+uwlhlusSi9lvL9mR3EzUNdvmep9kLcDQpOEfhz5NBhYVdR2uIrG7eehFhMVsYJAvD/CdkzM9wBf7+Ou2LE1dmCbk0nbrI+hkZYn/3yI0kYE0NXzAek8zoS9zmfSEiq5VIrH25dtZfYI6KsDKdeBkBuoOHXROdnK13CM50DZT8fKjPcgzuyuYam4cV3d+2ViU+XIIiz1Tz6pVd4JikjpAFW4d8Jm0kt7x5Ok2n8wORPnLZzbsqUkB/zuQg7eyYBugCgwdc3aZEtxubuVgpXuEMD1IVWiUAilxTQrYLWdD/gjIYlAf3BebkqURwm7D9Rg4Ooq6XfHoIflIKcy/I7BdETTR8X64PdOa7nf15gfCKoCaKpHOySjvYEQMgTrmHRCLw/yuyCtbsBKe/ZFwUoZMfYzkxrx9OaxFXOj4lojWxDsLADdc4GVkT4W05BhxM0+Ubyc85jpIRwsNjnI/NhkNuKq0xSOvfmGOO7S7KZghlKUMNfDl8F7fVaQQiWNdTA/igLwsfFE9kQ34QM+wdJ5rKh81f67/HjS5qAEvaSi3BGKgMLkRSq6XS9Xvui0nSPUe2byR/3fA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(40460700003)(40480700001)(26005)(1076003)(83380400001)(47076005)(336012)(426003)(36860700001)(2616005)(186003)(36756003)(86362001)(356005)(82740400003)(81166007)(54906003)(5660300002)(44832011)(316002)(41300700001)(8676002)(8936002)(70586007)(4326008)(70206006)(6916009)(478600001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:14:51.4627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09aa8e4c-2ff5-4e06-c5c1-08db677ab48a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8033
Received-SPF: softfail client-ip=2a01:111:f400:7e83::625;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
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

In preparation to moving most of xen-hvm code to an arch-neutral location,
move non IOREQ references to:
- xen_get_vmport_regs_pfn
- xen_suspend_notifier
- xen_wakeup_notifier
- xen_ram_init

towards the end of the xen_hvm_init_pc() function.

This is done to keep the common ioreq functions in one place which will be
moved to new function in next patch in order to make it common to both x86 and
aarch64 machines.

Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 hw/i386/xen/xen-hvm.c | 49 ++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 56641a550e..5403ac4b89 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -1419,12 +1419,6 @@ void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
     state->exit.notify = xen_exit_notifier;
     qemu_add_exit_notifier(&state->exit);
 
-    state->suspend.notify = xen_suspend_notifier;
-    qemu_register_suspend_notifier(&state->suspend);
-
-    state->wakeup.notify = xen_wakeup_notifier;
-    qemu_register_wakeup_notifier(&state->wakeup);
-
     /*
      * Register wake-up support in QMP query-current-machine API
      */
@@ -1435,23 +1429,6 @@ void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
         goto err;
     }
 
-    rc = xen_get_vmport_regs_pfn(xen_xc, xen_domid, &ioreq_pfn);
-    if (!rc) {
-        DPRINTF("shared vmport page at pfn %lx\n", ioreq_pfn);
-        state->shared_vmport_page =
-            xenforeignmemory_map(xen_fmem, xen_domid, PROT_READ|PROT_WRITE,
-                                 1, &ioreq_pfn, NULL);
-        if (state->shared_vmport_page == NULL) {
-            error_report("map shared vmport IO page returned error %d handle=%p",
-                         errno, xen_xc);
-            goto err;
-        }
-    } else if (rc != -ENOSYS) {
-        error_report("get vmport regs pfn returned error %d, rc=%d",
-                     errno, rc);
-        goto err;
-    }
-
     /* Note: cpus is empty at this point in init */
     state->cpu_by_vcpu_id = g_new0(CPUState *, max_cpus);
 
@@ -1490,7 +1467,6 @@ void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
 #else
     xen_map_cache_init(NULL, state);
 #endif
-    xen_ram_init(pcms, ms->ram_size, ram_memory);
 
     qemu_add_vm_change_state_handler(xen_hvm_change_state_handler, state);
 
@@ -1511,6 +1487,31 @@ void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
     QLIST_INIT(&xen_physmap);
     xen_read_physmap(state);
 
+    state->suspend.notify = xen_suspend_notifier;
+    qemu_register_suspend_notifier(&state->suspend);
+
+    state->wakeup.notify = xen_wakeup_notifier;
+    qemu_register_wakeup_notifier(&state->wakeup);
+
+    rc = xen_get_vmport_regs_pfn(xen_xc, xen_domid, &ioreq_pfn);
+    if (!rc) {
+        DPRINTF("shared vmport page at pfn %lx\n", ioreq_pfn);
+        state->shared_vmport_page =
+            xenforeignmemory_map(xen_fmem, xen_domid, PROT_READ|PROT_WRITE,
+                                 1, &ioreq_pfn, NULL);
+        if (state->shared_vmport_page == NULL) {
+            error_report("map shared vmport IO page returned error %d handle=%p",
+                         errno, xen_xc);
+            goto err;
+        }
+    } else if (rc != -ENOSYS) {
+        error_report("get vmport regs pfn returned error %d, rc=%d",
+                     errno, rc);
+        goto err;
+    }
+
+    xen_ram_init(pcms, ms->ram_size, ram_memory);
+
     /* Disable ACPI build because Xen handles it */
     pcms->acpi_build_enabled = false;
 
-- 
2.17.1


