Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0867266F7
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 19:16:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6wkS-0008Q9-Dw; Wed, 07 Jun 2023 13:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q6wkO-0008OQ-Ch
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 13:15:01 -0400
Received: from mail-dm6nam10on20629.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::629]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q6wkE-0005sc-PK
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 13:15:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrZbPEOrbH5DQD2dU3JIdpReBAZmLidCrBOVeRD7kn5CQIWwcXKfB8Txwtry5h8CV94ifXR6HZdBZ44m25JWsoMpHZBOzehZdzB+oLICTzqJNByJc4EafO/7OrMffPULjsuNV4PyQNu6tiixOAuDcEtZeRUIcuq9NaREre8vNaG8DC8OfG44rKUIi3qP7Cm5mopeVyQKdOOsnRdEY/WYerdvK4toP0PN+DE7ggpDXMxdJz/PvS1d1ET3OtJTM7s5ZjOlFuOuv54FE8qlGc3d+Y85YcTWuAxdjSj+kUs9UH3/WmwV9B2Mnfza+ZWcaCoQ5n++YAxhUJLAm0YKbFxOZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FR4BawIl2nyLOoaRXHWpiEutGsBER4awTYitO3dxACs=;
 b=aKha+X8MslBwKkAWYZY1sAWu0wCz0ohtAhIeZ9DQYFCYEZeVnineku2dfy5mb9De4ztQa6ZePRZDfPM2P5cizx+O++XaHZ5iXysrUpcWwaE0M1+Kb0fQ5UlKKfX5e9OwYYFEDYshHFlx+S4lvpn5DFxSF5rDYWwmG3QdpcSBcufdVrGF4mnc1Ic/TZaZMbzsaLMvjs2KO7V6fYrisi0HEZsebEW1krxOtnExBo4HUNPKp/pyoPIWTi1yWRulTc1JHrz0OFykBCPhllv55Z+H4eNH/VaIFIfTqugeFY8veL7NTCMi+dDgZpUYd09kI+3rgsDKnv/e12bDB9j2wgHu2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FR4BawIl2nyLOoaRXHWpiEutGsBER4awTYitO3dxACs=;
 b=jbRfSTFV1s+em9N2Ml/UoYgxV01Ibgl6OkJ5ll+Kil9LTpRePGVvUXpIHoZJR6JnL/eqgnu7ArZ+KbGxgF1OF3tVb75QP+Kd7HapdGlcDSH7ZffiYQSNLSSfcjR//kYr7x83adKGeNxrQhng7NhwAyqFKv9P6d9dQriUTgRVMxk=
Received: from DM6PR13CA0070.namprd13.prod.outlook.com (2603:10b6:5:134::47)
 by MW6PR12MB8997.namprd12.prod.outlook.com (2603:10b6:303:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 17:14:46 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:134:cafe::b4) by DM6PR13CA0070.outlook.office365.com
 (2603:10b6:5:134::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 17:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 17:14:46 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 12:14:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 10:14:45 -0700
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 7 Jun 2023 12:14:44 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, Stefano Stabellini
 <stefano.stabellini@amd.com>
Subject: [QEMU][PATCH v7 01/10] hw/i386/xen/: move xen-mapcache.c to hw/xen/
Date: Wed, 7 Jun 2023 10:04:50 -0700
Message-ID: <20230607170459.14722-2-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230607170459.14722-1-vikram.garhwal@amd.com>
References: <20230607170459.14722-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|MW6PR12MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ea844a-b730-4fa7-2b5b-08db677ab155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ccdJsf7XKyG6COBO0MxgDR1BjfPB6ewfCXjeHVw5k4VrOo59pIEekJOe14OCAa/2L+PTYJHZK5jFHAtSEkTM0KJvmq6cw5dXOwu7Z4Jd+CcKek3yhm7s+RAVMr9Ne+KuYQvEz5tVFxayGOmRZAoGIhQeIUvg/6JEu3+idylEiGs4MuwyVZ+u3fVXojEdvCu2nNnqCmF/Ue03SCbiacl3grqvQD6QRZ/ebPoRp+EOIV5gW8OA6kKWUB0hCo/ZViggT2mZeB2KRWGB7V7rGe/RJJsAEDUu3mbQESEJ9DD5Ar7rHV1hR/Ky6xKc96uTIrYHbYneV+HAjOLhkE1vxER4D466PcHuw1i/7ZetXg0LKoueY39UQX+Fh1RjgbXqsG030mhsP73m3Nd3gFsUtqQlx5YNHXX7AW/j4l0No/mCk/FwUYR9jDhtgdPal47GpDlrdgd4+CjheWuAlLhDK50fkPBl0x5LuF8NFjj4ph6IW7uFZpj6yJ8Enjh+PQ6U8bXnr5L2a8jEBtkPYFDhWu6xuaZuWLVQhSGtGApjhMqg8vwia4/0F0SRP3qWWV94KWkgguIFPGhQpjCLVODpBjMJ8sfiZZuDyd+3lt4Wu6cMgMtWyZR8RsDBhRzEmJCmoIHaYtmAdeKGqF33ba9OcniLzQTSpGLJz0GgE9qKggwYBHw8K4cfws//G5kBwHbAoRFZRgatZqqpSu8018WOC4IxEkMPI/86MhJ06EvUaJ/p4fX5KgxzHkY7ms6uVK1vaLEWcbqoBhO6M7FMUnIjJtxKIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(26005)(70206006)(54906003)(4326008)(70586007)(356005)(81166007)(6916009)(82740400003)(36860700001)(47076005)(336012)(426003)(83380400001)(82310400005)(478600001)(1076003)(36756003)(44832011)(2906002)(40460700003)(41300700001)(8936002)(40480700001)(316002)(8676002)(86362001)(6666004)(2616005)(186003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:14:46.0939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ea844a-b730-4fa7-2b5b-08db677ab155
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8997
Received-SPF: softfail client-ip=2a01:111:f400:7e88::629;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

xen-mapcache.c contains common functions which can be used for enabling Xen on
aarch64 with IOREQ handling. Moving it out from hw/i386/xen to hw/xen to make it
accessible for both aarch64 and x86.

Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 hw/i386/meson.build              | 1 +
 hw/i386/xen/meson.build          | 1 -
 hw/i386/xen/trace-events         | 5 -----
 hw/xen/meson.build               | 4 ++++
 hw/xen/trace-events              | 5 +++++
 hw/{i386 => }/xen/xen-mapcache.c | 0
 6 files changed, 10 insertions(+), 6 deletions(-)
 rename hw/{i386 => }/xen/xen-mapcache.c (100%)

diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 213e2e82b3..cfdbfdcbcb 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -33,5 +33,6 @@ subdir('kvm')
 subdir('xen')
 
 i386_ss.add_all(xenpv_ss)
+i386_ss.add_all(xen_ss)
 
 hw_arch += {'i386': i386_ss}
diff --git a/hw/i386/xen/meson.build b/hw/i386/xen/meson.build
index 2e64a34e16..3dc4c4f106 100644
--- a/hw/i386/xen/meson.build
+++ b/hw/i386/xen/meson.build
@@ -1,6 +1,5 @@
 i386_ss.add(when: 'CONFIG_XEN', if_true: files(
   'xen-hvm.c',
-  'xen-mapcache.c',
   'xen_apic.c',
   'xen_pvdevice.c',
 ))
diff --git a/hw/i386/xen/trace-events b/hw/i386/xen/trace-events
index 5d6be61090..a0c89d91c4 100644
--- a/hw/i386/xen/trace-events
+++ b/hw/i386/xen/trace-events
@@ -21,8 +21,3 @@ xen_map_resource_ioreq(uint32_t id, void *addr) "id: %u addr: %p"
 cpu_ioreq_config_read(void *req, uint32_t sbdf, uint32_t reg, uint32_t size, uint32_t data) "I/O=%p sbdf=0x%x reg=%u size=%u data=0x%x"
 cpu_ioreq_config_write(void *req, uint32_t sbdf, uint32_t reg, uint32_t size, uint32_t data) "I/O=%p sbdf=0x%x reg=%u size=%u data=0x%x"
 
-# xen-mapcache.c
-xen_map_cache(uint64_t phys_addr) "want 0x%"PRIx64
-xen_remap_bucket(uint64_t index) "index 0x%"PRIx64
-xen_map_cache_return(void* ptr) "%p"
-
diff --git a/hw/xen/meson.build b/hw/xen/meson.build
index 19c6aabc7c..202752e557 100644
--- a/hw/xen/meson.build
+++ b/hw/xen/meson.build
@@ -26,3 +26,7 @@ else
 endif
 
 specific_ss.add_all(when: ['CONFIG_XEN', xen], if_true: xen_specific_ss)
+
+xen_ss = ss.source_set()
+
+xen_ss.add(when: 'CONFIG_XEN', if_true: files('xen-mapcache.c'))
diff --git a/hw/xen/trace-events b/hw/xen/trace-events
index 55c9e1df68..f977c7c8c6 100644
--- a/hw/xen/trace-events
+++ b/hw/xen/trace-events
@@ -41,3 +41,8 @@ xs_node_vprintf(char *path, char *value) "%s %s"
 xs_node_vscanf(char *path, char *value) "%s %s"
 xs_node_watch(char *path) "%s"
 xs_node_unwatch(char *path) "%s"
+
+# xen-mapcache.c
+xen_map_cache(uint64_t phys_addr) "want 0x%"PRIx64
+xen_remap_bucket(uint64_t index) "index 0x%"PRIx64
+xen_map_cache_return(void* ptr) "%p"
diff --git a/hw/i386/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
similarity index 100%
rename from hw/i386/xen/xen-mapcache.c
rename to hw/xen/xen-mapcache.c
-- 
2.17.1


