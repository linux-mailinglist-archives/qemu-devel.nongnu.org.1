Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48102880E0C
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Mar 2024 09:57:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrlE-0000I7-3q; Wed, 20 Mar 2024 04:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrlC-0000Hn-6v
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:57:22 -0400
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2418::600]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrlA-0002jo-GV
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:57:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFF+D6N4Fa+YL52gzdMGOM1rlPKEVNCqT3gVufsKrMpsGyE4B7TwJ2OIIZ8Ew+/X40m23WDAn1Ne5RAxrM4zBZNP78wPJHnHBMXDa2Y0K4y28id2Ff7GKmAKFrpVSQo9hcLRHjj6t0Rq7XVsVfP+aH2DcXReC9ZWvbKNVahOwV9QDZgdbUCsWVvSqJFGnB4oFDMv1BlFmbxuXMgHhQbHrbNg1Mc55jJ8+25IxdqNnio4E0JyfpmhsQhFDf3qRnAug6KFoDILIUS03da0ubFGA0jE2J/YWtO34WFPBmcXD3rzXZTKoxcdlMA7+BG8lBwJltfkrB9Dk19mwv1XbF3PFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeQHQNX4ESsynKfd1VItjvo9w0VkudnViDwXsXm7N64=;
 b=NNbc+oBPenTWLphVC29e45uN0wqyLNWJIrHWDTJaeVhA/BFtTvPy5FtX3ydyQcBa5IRUmgLe4934YXa6zd3pVsP/YXJuzE4JEL/guroMev9DESZNVnA6vCKURa9boJA2ch3myxG+ME61v7Y9R7ID2GihjhjiHyrlDAxqM5bE/1ZngymBPLWLh4D9q8ZWfV/ZfkjtDWzPYDhmCtut6eysv2cVE93o4PCTa+q3GlXzoM+nPuZQOKXXewvQbACYJi1v0QQZR2PJdme7ojwmeWuJTbz5k/iUWtozroYhByd1+DDvFKlvQhbXx/uk2uxDcnzpFRfiQLFItggiBYRBv4wwjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeQHQNX4ESsynKfd1VItjvo9w0VkudnViDwXsXm7N64=;
 b=H0b1MM2i1h/uGWcManH/GHan7jL1CbgJesaS4TEClhAnYrbO/lXERNDtd9xd+XtjWAiPaq7sph2yXAFjir+CcqZKXzznEAvDi8yCy2qJ2HSPL5jdVKiSo7y/Am42DZSPkogRp6+hfLVbw8pj8u0EiFGqyiu51Q3YVah+htWe2XM=
Received: from BYAPR07CA0040.namprd07.prod.outlook.com (2603:10b6:a03:60::17)
 by SJ2PR12MB8978.namprd12.prod.outlook.com (2603:10b6:a03:545::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Wed, 20 Mar
 2024 08:57:17 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::1c) by BYAPR07CA0040.outlook.office365.com
 (2603:10b6:a03:60::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Wed, 20 Mar 2024 08:57:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:57:16 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:57:12 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: [PATCH v3 05/49] [TEMP] hw/i386: Remove redeclaration of struct
 setup_data
Date: Wed, 20 Mar 2024 03:39:01 -0500
Message-ID: <20240320083945.991426-6-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240320083945.991426-1-michael.roth@amd.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|SJ2PR12MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: e919ae73-7d6b-459a-bcf5-08dc48bbbe67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aw9n/6Y14j5OohTFLUV52M5k9bpA5dPsi7mAQPC8NNU+WOCUKjjM7G+7gaDxRhpZX+PHDXstsPN7J1SkAZOuxT+Vq3Kty4Wy+x6+5R/9aevvG9RfcqWd2nCMKy+WZyjp8sokYwS7JC/kM3SOlYsRRqX2OUpROp0yGLfdIiLWGe63e+xHiucIeTtvm98Xenj1NqUo3pBF2cFy//6K1xJSOjXIFHzos9mvn1EEms/p6Y7hRPEDvn6Ji44LDfzthUZ4h6+S+Uwoaf1zA0JvQvKoFbqIdEy6xsEWwykZEB/7rE85/pUfjc7oH5B9xvSDyFDHvOJ+IMBj0MjI1eUkjPjfB6EZy1DCo5HBVjrIeaflpQcsi9j4TSwZwVZYB6QFrgM+hqVEWmh/+RidB3Y1/LkS3APnt5YSuhFieKmfpmMkyFx59+LcFKICp+PBmzuvjk8PMn5X4LhLzPa60syvBg5boidqXMwQpRHCkqkCpkOv60bJbtjXH5fL3ajnzrlo6HmDqGCPjo5Knmlwzzga7wqxQPB0vRghPT4vnhslbZr95SCHMRZgvd/DsWi/EwV+cYJzoRO0Q+I0F5rkpH1/9KIzY0nFR2dyOq/WZFrMBEnkxrGfoNSEkgS4lXB/XkIkVZ1G5FgiZdD9hwosGVtuIvmjAi7phFf2h8zNwZeT/RXRJtzPjWsdSU7jBp4Ogdr2zaUAduZZ6/lgb0kjjuDEMbMHcV/JQw6A26goFAgY0oNj6d8NVJnIW8yzzb0DMmonSxxF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:57:16.8759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e919ae73-7d6b-459a-bcf5-08dc48bbbe67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8978
Received-SPF: permerror client-ip=2a01:111:f403:2418::600;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

TODO: this needs to be done as part of header update to avoid temporary
build bisect breakage. Keeping it separate for reference.

It is now provided by kernel headers.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 hw/i386/x86.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 2d4b148cd2..825dc4c735 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -679,14 +679,6 @@ DeviceState *ioapic_init_secondary(GSIState *gsi_state)
     return dev;
 }
 
-struct setup_data {
-    uint64_t next;
-    uint32_t type;
-    uint32_t len;
-    uint8_t data[];
-} __attribute__((packed));
-
-
 /*
  * The entry point into the kernel for PVH boot is different from
  * the native entry point.  The PVH entry is defined by the x86/HVM
-- 
2.25.1


