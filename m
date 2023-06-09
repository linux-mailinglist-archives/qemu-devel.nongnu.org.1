Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A034172A087
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 18:47:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7fFz-00084i-Hw; Fri, 09 Jun 2023 12:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q7fFx-00084X-GY
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 12:46:33 -0400
Received: from mail-dm6nam11on2084.outbound.protection.outlook.com
 ([40.107.223.84] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q7fFv-0006kz-SA
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 12:46:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ge/onru51kvDlCpSkfGex7zorfnFsz8pbHgq+9Xybsl3Tlvfd5DHIiiW9gvC8FCWdWHzGlTEnkaT58eyPedSRUDGgZ7uNeRxDLBhTgLxt3WTNFWNqkcHpbIMvVo3oYaAhW6va6kb4YfhLm5kBaN7RD4xLnP9MTm4ju8WekFJ1dZufAuvb/bwVmVt2bX90RI5Gk69cSzQbACrlqJBkdS6FKpFXSzVDRejgYS5hQkvx14dY5NMTVqxIN0QtOVVQv19NX+/ECBV+cFi5CeQLIBcZ1h3RIZA6VcW9QQerglS/WnGvhha98jWoz3ft9hpOM5rlSpKJ2b6E6dnYa/X2GWdbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCcsfClrdoLSSPjJSUwmhCvRhi0OR7WEtaTDXK8wL5M=;
 b=hTl6Xejlhmf96zVyc+nW/iJBknSvvhXQJiX0WgaUgMylcXNllJyiG8lKlH3RWPJblizNZ+eGRKnVcRo6bdw5SKL1ajSBcU39FfJ9Jmv1O+J6DBwPGPQplPuAGSPLOIKjUoaskOnBHi69zZrLRU1Zg2wS2Sft1FPG7nO4dQBFtEgvFlNJidYAFluPWx9MagMB/qn/DqLYrFMEr2cYOg6DOaFkM21J4ZI/2Uf+7Jt2x3kGogIDc3zLuPbIFofpet1mAZIfe+8BNhYOK8bSFyB1QLSNMqLGjWAU6MkjKBbnGp5xt+yo0BVJPhm96SaRYbB83qMh+eRtvXDMZ/ve6eHsGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCcsfClrdoLSSPjJSUwmhCvRhi0OR7WEtaTDXK8wL5M=;
 b=e0kzgoi3WT1BqXVbwRpcu7odqwMPIVTUuDOFeCXo8aQ5GYLl5R3aAXRmztu4BgpPAhyopmk4vjckf/9pemwvZT7GjnDmTTDE2+UO+4blY9eY9nsj13io6giWTBbypwrWGThgRH9/5ZGWUkahwjqgmHH5+ptd6gORYa7n7KQfX80=
Received: from CY5PR19CA0084.namprd19.prod.outlook.com (2603:10b6:930:69::20)
 by IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 16:41:26 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:69:cafe::6e) by CY5PR19CA0084.outlook.office365.com
 (2603:10b6:930:69::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.27 via Frontend
 Transport; Fri, 9 Jun 2023 16:41:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Fri, 9 Jun 2023 16:41:25 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 11:41:24 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <imammedo@redhat.com>,
 <jon.grimm@amd.com>, <santosh.Shukla@amd.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH] hw/i386/pc: Clean up pc_machine_initfn
Date: Fri, 9 Jun 2023 11:41:07 -0500
Message-ID: <20230609164107.23404-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: ec484828-1e10-4f16-1b77-08db69085db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sGZgvITOsPfkjC2janlK1N1/1j2kNtdrSj5EGBdREkcmXJLjNYVyiKYqj/pbiPddwQAczZXc1unSHqKdSR8On6u9SCFaHK+KKXinzmY6zoCPrrH3XR7fXq/7J+5i0mO6mt2V6eLgKgJFtF3lz+v3jqFFcxCWC82qlJRkAVlGk1fGyQrGlo/yxcI14qhVh0zmhX0PMtiEa0oXW2Ax2T9nVrLHZczZuFUdNJPVgTgUeb23QxLLdnaGWQd6gNhyRerIZNAYoRZa8LeP+01oGpE+Am1qVj5AKbk2oS4dgdGVOFSZEyOmG85VKmPCICaGYxUxuADoZcXMa8SlDLuE8Ebm0Cb5IaQrFduV149oghDrNnV/yyYWXpk7CuchKeWotjiB9OORMJ6UTY5HkuH1qyX5+rI02zYAuHeIjFCkUIjb+oPcEr/KgBXELTCqeRkK/OrEsmyRCSeRXmpcNM7ZgPHX9xjrEygHIbgAVvPCYcPdrHyyy/R0fVtUY+jDwcp/E7mJ6GwQ1a6kT3f+53Y9mJpLepqUIaJb4bhBZBH/vinnk6yTrAuMomuUWlF8Jw+GZDmdxVnKvEJR5po4j3qWHVX8xhfu4vWnbPFeqkMqW8G3cw+Co8oYyFvuJNFM+nGSd2PNMqlDx04HiDvrgdwFVzHp8nvZmimgIkKI5tiwOpUdLbECOZLJWpXqRNLQoJIJpg2uGcVvobz+0kM7ElEvhHm4T2Sf0p1GrdwRarh+Uw36/EWf4pbKKsI38JQk4332VoDQTAMLFql1nkerrknFvy6A0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(356005)(1076003)(2616005)(36860700001)(41300700001)(336012)(7696005)(426003)(186003)(26005)(16526019)(47076005)(83380400001)(6666004)(478600001)(40480700001)(4744005)(40460700003)(54906003)(81166007)(82310400005)(70586007)(6916009)(70206006)(316002)(82740400003)(5660300002)(4326008)(2906002)(8676002)(44832011)(86362001)(8936002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 16:41:25.4571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec484828-1e10-4f16-1b77-08db69085db2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650
Received-SPF: softfail client-ip=40.107.223.84;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

To use the newly introduced PC machine class local variable.

Suggedted-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 hw/i386/pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 33ffb03a32..f8d105e829 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1864,7 +1864,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->smbios_entry_point_type = pcmc->default_smbios_ep_type;
 
     /* acpi build is enabled by default if machine supports it */
-    pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;
+    pcms->acpi_build_enabled = pcmc->has_acpi_build;
     pcms->smbus_enabled = true;
     pcms->sata_enabled = true;
     pcms->i8042_enabled = true;
-- 
2.34.1


