Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEC47BA8ED
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 20:19:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoSuf-0000N9-Kg; Thu, 05 Oct 2023 14:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qoSud-0000Mp-Qy; Thu, 05 Oct 2023 14:17:27 -0400
Received: from mail-bn1nam02on20602.outbound.protection.outlook.com
 ([2a01:111:f400:7eb2::602]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qoSub-0006KI-09; Thu, 05 Oct 2023 14:17:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQ60KordRDLJk98TPECF5nvC5mN0nSp+h7LCynQAx1LdHZr0ITDtVq4Q13NowFIbQd882EWLzza0t/A6dE1gh7WiiiW2BmblhWp16qjgBkQLZkZlYWpr1ClbvSVhNImhbNAyTl684nGo3OOAEwUVBAKy4y1WPNtDS0/8oYmaTNXJP9QVcSZLw7E1QkMPMLFtzLoqtLZqfUJYJA+mfCiA7SUDsgbw/i/cUVtmirbdobi7zRalV+i1OXR2vQ7HGbDAJkJf1p5gaeNJyyXOAkAVQXL4QGuSsTC9AbpC9kRmRvihxYXCueeHSaau96u4ho1OerhX6PCECv4Yt8BklWp4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksF652jkj0H+gVQIly5PpnylBV9Mz7gsmo/SYfg2AAk=;
 b=bWOOlNmVE5MCa2zZX9MzhK/VDBKbouq8gPFMEdNYgeNLC8wfZmJ2yUvA2iEgUt/zso/YxDRdSlue7nDmYQhMpWyCJjoCsEzBfU3+CHOlK+Qg7FKHZleowDb0jhu/nLT6RUiz5bMhBLXeO90b/Z8KkTQRT/kxxQJw29hyu1RhQa6NNlecJ2wSVWJyKUP/jAW5Kiqbd4hhPrXajyHv0/lDfxbm0HkLzKP+n1SSM2KrN7v0JB3QICU4jmlAG5z598+FRvOnlwRDSywnNZeFtplxfFY8yYyRgQXOZtYryi6c2Q89oufRwZS68BZtSOESnAY6ZnziqzrsLVjc5zUuUXNQOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksF652jkj0H+gVQIly5PpnylBV9Mz7gsmo/SYfg2AAk=;
 b=JU2Rlt/gGAhiCHG/127cqotu6VpYt4jRd1NyTsX8+uDme+9BQ5rbBUdxVocy+Um3Tp06FoBTC1tj3MrxvXxrUfcu7LrU0GjZSIbpswPxRIoZkfa6U9Bgt2e6fT4CG84hB9xjObDt0RwXs15xWL7GYn+iclvG8cXiNV66zOfiZ38=
Received: from MN2PR03CA0018.namprd03.prod.outlook.com (2603:10b6:208:23a::23)
 by BY5PR12MB4872.namprd12.prod.outlook.com (2603:10b6:a03:1c4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Thu, 5 Oct
 2023 18:17:20 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::f) by MN2PR03CA0018.outlook.office365.com
 (2603:10b6:208:23a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.36 via Frontend
 Transport; Thu, 5 Oct 2023 18:17:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 18:17:20 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 13:17:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 11:17:19 -0700
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 5 Oct 2023 13:17:19 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, Vikram Garhwal <vikram.garhwal@amd.com>, "Peter
 Maydell" <peter.maydell@linaro.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
Subject: [QEMU][PATCH v1 7/7] hw: arm: Add grant mapping.
Date: Thu, 5 Oct 2023 11:16:29 -0700
Message-ID: <20231005181629.4046-8-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231005181629.4046-1-vikram.garhwal@amd.com>
References: <20231005181629.4046-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|BY5PR12MB4872:EE_
X-MS-Office365-Filtering-Correlation-Id: 158ff665-8502-45a5-33e6-08dbc5cf509d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N7RAjEjLnU/2LSkwB+ZtOvuPP3Sbzy2Dek9LBer8nc9aIMNRFD+wmAg3cs7SbGs7G2Vscb9ctyteCY84jHXLDFeUEUdV7iexRgIlIyh5/w2Zz3L6WOIIWIUUWwY0MdTO0h+nBZZhENYUzPaCKy8APXyDBtwvKHl1iUFmK2YfRKQbCDoYgvQGUl6ByvcqtomnxpUZoNk8ZHQzgDOxZddqasJxoReGZZb7uKhqfqnzyVo17atDo/uya+pJzk6I+fhiQ8zYhD8cU4FI/Nk+JEK3xaaPeeZ5wvWIfgLUfPOudTuOcMGneDorb/jC5bgigUh2gOMyeNEcQYTiwshmxTVWnh8US0mrQ8noJmRPqhBruV7HDOHxPQSykeLUZPUUxQfXQbKhevWN33W1lAAoOVYQPc7cKD2OxJzgcZDVW+fJH/3//v3cOXwpaa8Wg9o56rriASgSfr+kVF8D8ZbVjEW3yfUscfBUqnu0P5pZOOKiLGsLTP1u9R+TNgcTQzMpIc1jf21SxbDvSHeENu/3lU6GxqbyRzAX0J5ZmLR3je1e+kXT0bSXrOJeP/ikbOgmayUFEfV4SKFlA81vpwQGtcJbguxMAbHjc9jbXgizFUUNmqTBA4WvJr1JZWn2zpIbgmD+xpiJK4yVxaLbFNFjxQjTHHqC+KZ7tKNeVkkdASeQcMN8ZlgK06nzHJUIQelBnmGZuWod5JKynlgs2gZZLnT45bYTDhbBq5KfMmo0CXdn+ziaFZPIOQqh19rZkqxQ81TCgFjjUyqxYiqZA+bvnD+Jig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(1800799009)(451199024)(82310400011)(64100799003)(186009)(36840700001)(40470700004)(46966006)(2616005)(2906002)(1076003)(6666004)(47076005)(336012)(426003)(4744005)(26005)(4326008)(54906003)(44832011)(5660300002)(70586007)(6916009)(70206006)(41300700001)(316002)(8676002)(8936002)(40480700001)(40460700003)(36860700001)(478600001)(82740400003)(36756003)(356005)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:17:20.3971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 158ff665-8502-45a5-33e6-08dbc5cf509d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4872
Received-SPF: softfail client-ip=2a01:111:f400:7eb2::602;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
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

Enable grant ram mapping support for Xenpvh machine on ARM.

Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
---
 hw/arm/xen_arm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index f83b983ec5..553c289720 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -125,6 +125,9 @@ static void xen_init_ram(MachineState *machine)
         DPRINTF("Initialized region xen.ram.hi: base 0x%llx size 0x%lx\n",
                 GUEST_RAM1_BASE, ram_size[1]);
     }
+
+    DPRINTF("init grant ram mapping for XEN\n");
+    ram_grants = *xen_init_grant_ram();
 }
 
 void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
-- 
2.17.1


