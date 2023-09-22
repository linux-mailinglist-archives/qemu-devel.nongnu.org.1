Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 811B57AB29C
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 15:23:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjg6L-0008Cq-Gu; Fri, 22 Sep 2023 09:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michal.Orzel@amd.com>)
 id 1qjg6I-0008C3-LA; Fri, 22 Sep 2023 09:21:42 -0400
Received: from mail-mw2nam12on2061c.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::61c]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michal.Orzel@amd.com>)
 id 1qjg6G-00061D-BR; Fri, 22 Sep 2023 09:21:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqXlpFlu+CQBVp20DU0DlYEBSFfPxrftYVe97aRs4tjl+7L35ulUzGDoenV5d8c1x7FVhtZfHiCRsiTrusQxA3GpkUvtroDoX/g8/wwjN7nqVBQGw5QiwxrNGE7M1PaeU60HR7QZmNFxppIoOIUsiw8DQ+fOyVH70jNq7+tuKMzC8qEfGYB+ujo49CV2YwChvXe9K9e0dDUNkPu8FJsC0TbxzOilpsbmDd/qOCIhmsUGps64B1VP69h0MH7NCrl9f6PEeMWVC6ZgfMr2l9dgXRDxk5imrH/qMHxveYMv9LnbstE8VDak/0HghfQ6OgDB3bqkgooXjFJ3j9w6O7c64A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uaw5tFW7gkAlAuXBeD/xBaDXyGhywPYZN2c5xta3X0=;
 b=OUeNEr9j7787pK/hyz+VlVkNbPlMHVLN2PFkDzHQyjUgUwrakix2XwcMR0f+s8PvqCU/XGR3WZLRBYx+/ta4XcrmIDyQLf68JMOaZCbm2F1du462KKwIsqesks01YkKQZaGCzfvwWUFmUIDxRKqYNF3cNUaaD3Iiu7SVdd4o1ndGHIqJe+56qS6ZAH1ZNO+oelCEXMxIGyJSYjQDTgpIzbUCwAkiAo8oB69qD+G82+3COlEbOlT9qUi+m2PhroW3HXmWRQ4MJRfgYCUYh6AlRt0r+Rits6HtqV6vQxwqycsO0oPA/THhXq8xiPJ7JEC/0Jf/7wt9ydmUAdD8hIU0VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uaw5tFW7gkAlAuXBeD/xBaDXyGhywPYZN2c5xta3X0=;
 b=o3W0sR1WDI/5HBKId6ikcnBrt0cKomZbO8pdxWgXxfL165PZKeMHCHWMeG95hrt2q4pzbh9X+9BoGEXjprk+LKH+GFM5QPN7Ni2HYxbhwVCEMafiiTRIVg5RuAdVdZlcDtVbXQHAdgSPXFHtk6ymT6ZvehPoTs37KTaHQPUjDn0=
Received: from BLAPR03CA0169.namprd03.prod.outlook.com (2603:10b6:208:32f::21)
 by IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Fri, 22 Sep
 2023 13:21:32 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:32f:cafe::9) by BLAPR03CA0169.outlook.office365.com
 (2603:10b6:208:32f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.32 via Frontend
 Transport; Fri, 22 Sep 2023 13:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 13:21:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 08:21:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 08:21:31 -0500
Received: from XIR-MICHALO-L1.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Fri, 22 Sep 2023 08:21:30 -0500
From: Michal Orzel <michal.orzel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Michal Orzel <michal.orzel@amd.com>, <peter.maydell@linaro.org>,
 <stefano.stabellini@amd.com>, <Oleksandr_Tyshchenko@epam.com>
Subject: [PATCH] target/arm: Fix CNTPCT_EL0 trapping from EL0 when HCR_EL2.E2H
 is 0
Date: Fri, 22 Sep 2023 15:21:11 +0200
Message-ID: <20230922132111.9149-1-michal.orzel@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|IA0PR12MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b1ae31-0805-44a6-e25f-08dbbb6ed6c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qRwNkxh5WR3hd9ADsDGxb3Ew4smy3aCOG/NK9Yopedoo5FXNRbJapEun7jFevnvNz4ubioMpxmKHd8gUjFReuap6fltyLCLgJjc2axUkL2+BlM1zVPKb5cjXpHmLDduH+xRmZ7bI0MsY8FnQh+GahpU7R2OgY+uCm043Ni+sEytK9bzxc3zAT6DbtYGyZyWepFBE7wXFViovoVyGLnK5QF0uwUg3R4O/EowfVI4Re0ncmm7VEdbX9+KltgnBwOFBvdreZKUXf5ueWvMVObHviq8h0ITFP/kaokuwZlsegcffifmMCc6ZTk9LWZLy9cfQElhOCSU52Vy6eSGOedKzrjYkkikbRNAEo0E5+wTR9FggRFPKfzFNXgQOFAVml4mvqs0IiFzA0dathtK+IQxQcmPmHU8M1lP7ibn45oanG/ePdAdJIPtkXZKF3NdkbqGoNYGQQn++FS8QgVv2pkCKqb3PXX/Cs3+yJNkSXOl0XngvDAuTOYfDCa2/wK6HuZyM7H8cCnNN3nqxwyXiJHEjBdyis9YtNDGNYbsuK5e92mYTpHU64POkkJz+KANQGkH1xj9qx+gmqJVaGWOfaTgfBlT58RfrBKBr1hy5v0zlrv6wEjQ+jZqCgqHXNSMPLjhE+Ds5wC5KiG8QXLFKWEVLM/kPKrYuY6IqClGqlTZ5+LxAAHd3ygKWfGm6dIyveb+yf9vR7q1SRilbauQFwNv/DLPwaa6trH/ItI0UQq4lCRTpOrAyyTx1IwqqLKXfICbvqAaQM5Uu3tJdzJBcsefIKItg6aAybjfZNL7l/Vtyf99aqKApq/Siqw1BjEHiBTo9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230921699003)(451199024)(186009)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(6666004)(41300700001)(86362001)(40480700001)(54906003)(70586007)(70206006)(5660300002)(478600001)(110136005)(316002)(82740400003)(2616005)(8936002)(26005)(356005)(36756003)(81166007)(40460700003)(36860700001)(2906002)(336012)(44832011)(1076003)(426003)(4326008)(8676002)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 13:21:32.6808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b1ae31-0805-44a6-e25f-08dbbb6ed6c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::61c;
 envelope-from=Michal.Orzel@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

On an attempt to access CNTPCT_EL0 from EL0 using a guest running on top
of Xen, a trap from EL2 was observed which is something not reproducible
on HW (also, Xen does not trap accesses to physical counter).

This is because gt_counter_access() checks for an incorrect bit (1
instead of 0) of CNTHCTL_EL2 if HCR_EL2.E2H is 0 and access is made to
physical counter. Refer ARM ARM DDI 0487J.a, D19.12.2:
When HCR_EL2.E2H is 0:
 - EL1PCTEN, bit [0]: refers to physical counter
 - EL1PCEN, bit [1]: refers to physical timer registers

Fix it by checking for the right bit (i.e. 0) and update the comment
referring to incorrect bit name.

Fixes: 5bc8437136fb ("target/arm: Update timer access for VHE")
Signed-off-by: Michal Orzel <michal.orzel@amd.com>
---
This is now in conformance to ARM ARM CNTPCT_EL0 pseudocode:
if PSTATE.EL == EL0 then
...
    elif EL2Enabled() && HCR_EL2.E2H == '0' && CNTHCTL_EL2.EL1PCTEN == '0' then
        AArch64.SystemAccessTrap(EL2, 0x18);
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3b22596eabf3..3a2d77b3f81e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2483,9 +2483,9 @@ static CPAccessResult gt_counter_access(CPUARMState *env, int timeridx,
                 return CP_ACCESS_TRAP_EL2;
             }
         } else {
-            /* If HCR_EL2.<E2H> == 0: check CNTHCTL_EL2.EL1PCEN. */
+            /* If HCR_EL2.<E2H> == 0: check CNTHCTL_EL2.EL1PCTEN. */
             if (has_el2 && timeridx == GTIMER_PHYS &&
-                !extract32(env->cp15.cnthctl_el2, 1, 1)) {
+                !extract32(env->cp15.cnthctl_el2, 0, 1)) {
                 return CP_ACCESS_TRAP_EL2;
             }
         }
-- 
2.25.1


