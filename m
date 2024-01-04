Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 231498242F5
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 14:48:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLO3U-0001w0-Kt; Thu, 04 Jan 2024 08:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Srikanth.Aithal@amd.com>)
 id 1rLLMC-0007z6-Lq
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 05:53:48 -0500
Received: from mail-bn1nam02on2087.outbound.protection.outlook.com
 ([40.107.212.87] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Srikanth.Aithal@amd.com>)
 id 1rLLMA-0002wj-6A
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 05:53:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0BWeUU+5jFxYHPi7nIutH8INbYHRET1kNdafP+vpIsCZRwY4lfjoZ3hrHEHRFEjrSzcL5rMPWdQZifuVk5rCTaIpkJwX4Q/YRgzsLAv5s9WP8obSFXqJAi3QMUeEYsvTzK/Af5q84HY3jjIXRZaVHYRK+LxF6I1cIOawN9pFpNPxJpEmNd59QyV9Frklxv93gOXjJD4INJTKw68jmmBxzAWCnhGO0j/EbLS/IRGEuD7LnmoD3kJewFO3WKq/aHKS4QyJiyM0iqdgUCeTODJxGimuj93ZzXnBT9iOZQYx+XpDQNxu7uyuxP8wHMQtjBNtnqOadg2FwLtTIgsHpTwXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDju8QZYxD4Y+uCsEEjsnnTeB2WsupH47nWxsv7v1B0=;
 b=O63tKth57nvPGBt7pQLuiy2p9HR/tszBoRzi3e2dyT4150VMoU6O+JYsQ2aSlMP7s3i7+fsf4EFwbUxWdcgUAecVLVSPZwuFEo3/0wiSb2FiKa7kLsBpha8bXotirS3w1BtgIgbuECZJ/EVYZzyjfZA9j0+v2lFPiwlEjG+3QHlCeToR5AGmUjUq6ir1F9M8w9Jsukrox2uIEptmJkXGVkvB6ykzEXxpj27HnlPVhTET9qARJtWqBQlhRT7/1mM394Z4UuMcL5lb8QBz2UGaJX7UsGa00fpzKTlk21lvMuihLKHc3QlKAAegGYoxKg/8sqLZVwz1eMurwWsYgjYMNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDju8QZYxD4Y+uCsEEjsnnTeB2WsupH47nWxsv7v1B0=;
 b=mAuFKJj+DYAxDFv2n5O3h0eK3lMbE4Hx9FDIH4i/zq4kimLL4EX/l38UWLfGwPiD/Rd7RvzHMDEnYFRBIO2hafGK9YRcV+5E0GrDNsG6EBh4rwumXnRMGH23OinELLA3A0dFIVzOIIkqYoaa2GnPG7lSMgC57VEfsCoSCrVMriA=
Received: from DM6PR18CA0032.namprd18.prod.outlook.com (2603:10b6:5:15b::45)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 10:48:39 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:15b:cafe::54) by DM6PR18CA0032.outlook.office365.com
 (2603:10b6:5:15b::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14 via Frontend
 Transport; Thu, 4 Jan 2024 10:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 10:48:38 +0000
Received: from BLR-L-SRAITHAL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 04:48:36 -0600
From: Srikanth Aithal <srikanth.aithal@amd.com>
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <mtosatti@redhat.com>
CC: <nikunj@amd.com>, Srikanth Aithal <srikanth.aithal@amd.com>
Subject: [PATCH] target/i386/sev: Fix a segfault in sev_kvm_init
Date: Thu, 4 Jan 2024 16:18:20 +0530
Message-ID: <20240104104820.14422-1-srikanth.aithal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6b9393-34b9-4dd2-1163-08dc0d12b5e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPjKczVp1WvUp/1i2CztoynVw+wNGmpP0zKrhzhScs0cxkYYDHd8jSiHYef4/20FVKxE2TvIcUsBAwMoVBQemDeu6I5WgO2vANSHx6BDTkOO3aGxFVBf6gp6SgP6ehPFNtCGjIQIQlORBRjnamXPdgYCCCjw7uMRL7wVBhnBf1IatyN933jvV24Yy+rLi/EmLl6gju2m6dytJBf6+ve+Q3fGwPNUH+zoXgWPSdYmRaPTzE5M+3ROAD+k53BROVhEzmFp1w63Z0dXQSdG1KD3PrTFwWAYVTcNaIfDOOEZ/jfOcyVbdzHix8NeeC+lvm5PMf7nGYpaOHHIYINHMIZPA0GoZZTsV4q1WOJ5oqeI6QDqrFY2MgqvjhSC5nNGSXiPJu8+Ep2aHvev4h3GmsKmOmwOMooYF/xiTVAJFsXhBc8Z+on1MFCp5drbF1QHLpQgKK2Ab9hiLYAPm/AcafsVtdo8VC1+gtr31NHEHJsAN1DNE+qHFDefqUvbXhVsHaCJYTsFparG+pGMpzzPmj1MScLZAY7aPIYTnmmSoVxVwWSq2JV1Mm2K8hM2VXuT+z8sEk5lcYNaz8GFlJYU/zfXDPvIkYWvfejasTpoIxftroFIT7gZ7btH3kkmhOyf9mkuMTe90PwxwW4WR+Dx6unzqFryQHR1rhVzb3r1E+mk04VAxRcXVyPdkuxYOs7rxCLHp4ov2gO8HJTYsC9s4VXJcyL9SXsOvCoY22Na2oFbYjM3FKBSinhab6RxxrdJvV4EoKggBtIf4n6aaRQUhJO+ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(1800799012)(186009)(40470700004)(36840700001)(46966006)(2906002)(356005)(81166007)(36756003)(86362001)(41300700001)(40460700003)(2616005)(54906003)(16526019)(8936002)(8676002)(47076005)(6666004)(83380400001)(7696005)(110136005)(316002)(70206006)(1076003)(26005)(70586007)(40480700001)(36860700001)(82740400003)(44832011)(478600001)(5660300002)(336012)(426003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 10:48:38.9175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6b9393-34b9-4dd2-1163-08dc0d12b5e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
Received-SPF: softfail client-ip=40.107.212.87;
 envelope-from=Srikanth.Aithal@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 04 Jan 2024 08:46:37 -0500
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

Propogate error code using errp in sev_kvm_init.

Before fix:
qemu-system-x86_64: sev_kvm_init: guest policy requires SEV-ES,
but host SEV-ES support unavailable
27747 Segmentation fault      (core dumped)

After fix:
qemu-system-x86_64: sev_kvm_init: guest policy requires SEV-ES,
but host SEV-ES support unavailable
qemu-system-x86_64: failed to initialize kvm: Operation not permitted

While at it, also fix two more locations.

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Srikanth Aithal <srikanth.aithal@amd.com>
---
 target/i386/sev.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 9a71246682..c0a4d5e535 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -922,7 +922,8 @@ int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 
     ret = ram_block_discard_disable(true);
     if (ret) {
-        error_report("%s: cannot disable RAM discard", __func__);
+        error_setg(errp, "%s: cannot disable "
+                     "RAM discard", __func__);
         return -1;
     }
 
@@ -979,13 +980,13 @@ int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 
     if (sev_es_enabled()) {
         if (!kvm_kernel_irqchip_allowed()) {
-            error_report("%s: SEV-ES guests require in-kernel irqchip support",
-                         __func__);
+            error_setg(errp, "%s: SEV-ES guests require in-kernel "
+                         "irqchip support", __func__);
             goto err;
         }
 
         if (!(status.flags & SEV_STATUS_FLAGS_CONFIG_ES)) {
-            error_report("%s: guest policy requires SEV-ES, but "
+            error_setg(errp, "%s: guest policy requires SEV-ES, but "
                          "host SEV-ES support unavailable",
                          __func__);
             goto err;
-- 
2.34.1


