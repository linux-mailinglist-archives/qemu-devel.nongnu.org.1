Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2936880DE3
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Mar 2024 09:53:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrhn-0001vo-69; Wed, 20 Mar 2024 04:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrhl-0001vG-6E
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:53:49 -0400
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2414::600]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrhj-0001hV-EV
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:53:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RL61Kf3hIv5765WCfjCioYH/bQ+OVIfL2FgDaQsOQiIL6GOd6q0Vg7D6OPVrTh3o7aJ0S6Hh/i5TM365mftp7QDYebgXZ6W81LAC08IQ38LAqQQS9MsoXUbuoJhgVMkNC4mf+jQd0ijNioBPMFMybyOTj9uEbdDOnY8VinyeCTVYekiQm+Nf2iGZo+3v6aqU9m4RJ4BYuUR20aB8bvBTmKdzk0czqJVn4kveHcv++vWmiUXPkTGhSnDyVD2/qVy+lOYC3vzRrt/qITIQSEyvXXWt/Zs6++WJoTEGF0+98bjxH5ElzH1Tj8PHq1LQ7R1M61Cr1ku9YOOtZgJdY2l56A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnTjo2V+1LHsI1rt+5gOeerFr+ojKCKSZXbbVpHBn8M=;
 b=n2Ga9b4H2g47XJcC5UvAqmylYGMxg6mq8ugOstDrarcrzpl1rcQuxMqJX4ggM7zvuzC8Fe2zG0wTaJ6EO/0ETUE3618CFRehDtraZlV5Cp/h/FMakQ0zhlesEGlc7FSE8bHbpo42XtYdo+qU05MJTUYHJvemahvqy/mmO3qZ4+sLuzuF/ZsfpJBzFJzvgyvJzpX3xJDBZdSOVHVVQKNLTab4SYgHer1Uy409mL0fUdSN6Bp/wDY9d0m6P45OfdVqcZ//hdgMonHJl0mVjZ7XMaXI3pLg9NKeDbrP6I1TX1t+VR/2Tv4PMytE4ziI+MEd+5DVzLn96eHLQi5B5dkdYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnTjo2V+1LHsI1rt+5gOeerFr+ojKCKSZXbbVpHBn8M=;
 b=tx+Y4hbtYePp6or0mSpkcIB0DkoRp8nUd6Yy8pK0+tkPAU/qRynuUorpbFyHFuoGrQlVyRgXloIsdHF7QIfoXJ9tdLZX3pxKgpXjTFPoW07mY28/csqnjHsFy+mpDyAm0juUhxnw8DuQWKKp4noMwHeQ6YR3CkxvqP3/+oNDIxI=
Received: from BN9PR03CA0207.namprd03.prod.outlook.com (2603:10b6:408:f9::32)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 08:53:43 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:f9:cafe::c3) by BN9PR03CA0207.outlook.office365.com
 (2603:10b6:408:f9::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25 via Frontend
 Transport; Wed, 20 Mar 2024 08:53:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:53:43 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:53:42 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>, Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v3 41/49] i386/sev: Add support for populating OVMF metadata
 pages
Date: Wed, 20 Mar 2024 03:39:37 -0500
Message-ID: <20240320083945.991426-42-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: fc741a56-c424-4c3f-f0c8-08dc48bb3f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fOBNrZJ5dZt4KsZPlb2gXooAcSQTLaXmNtKh14a1NK6VzzUHAQL5kF9Hi4sGwgwb7YtKaYEeX7kSq/9kVcMsiZ8pJ9FQobO1SmaAlPqLLZk1nvhL6l+QlpgqnkSr+GFbj4JhaW/gq5dOMA9pX3xHu+honn2kzAwhLeZFnHqc9ZQhkj7ulZe/EHP47fd0B/tb3L7b7Dg5KIKM2DhXbJOhYCr8S2f9agErfyvINSpAp1v9yjKg+ehl7n2KM69oOHNrR2Z+KHKv8bXHoq5sYSic3wv4HMpvTzCR9vWKjezTM0ci9a73WLGpF8IeIXwuSEHyt7UKXNJ2msh9PMMiCC0O5X4aHEheZYw8fk1/Z4b7L0lGIRV+LbeFcnfqVUkvqm4LpQyKxe5al0GmBGDXna7WR15t2hK7D+zZCvFwOHwQ8kuvvIsaPTgGtVHfKD6Wzbt5yt4plOR7duLYWX7W6ncSdNujgJlzvaeJaTeUoktDAcxuz7vlwEI1+dqUehXOqpIqFrtoepapj6+o3cJL4Bh68IiEsRmJWg92f6+RHqdc8qeB9R8ZwMbIJnEGSg+cm+kI/dZahxaroHoFWH4jEWcNRId8AurnpUuyzGuGUJEDCp9c1frmLwZzgH6j+Kh8t9/JzQpdT5SFiTOnpQflYU/OhUkVbHuXwlQzJIhShNH3FTtxnjb3QWS+GB5beKn1yQyKrbJ94HO6OlZMKKkP56KYRB2hz7Hzyx5qduq6agBMXAySXclAYLa18Md14zSw8V3u
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:53:43.3916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc741a56-c424-4c3f-f0c8-08dc48bb3f17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898
Received-SPF: permerror client-ip=2a01:111:f403:2414::600;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

From: Brijesh Singh <brijesh.singh@amd.com>

OVMF reserves various pages so they can be pre-initialized/validated
prior to launching the guest. Add support for populating these pages
with the expected content.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 target/i386/sev.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 4d862eef78..6c5166c729 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -949,6 +949,67 @@ sev_launch_finish(SevGuestState *sev_guest)
     migrate_add_blocker(&sev_mig_blocker, &error_fatal);
 }
 
+static int
+snp_launch_update_data(uint64_t gpa, void *hva, uint32_t len, int type)
+{
+    SevLaunchUpdateData *data;
+
+    data = g_new0(SevLaunchUpdateData, 1);
+    data->gpa = gpa;
+    data->hva = hva;
+    data->len = len;
+    data->type = type;
+
+    QTAILQ_INSERT_TAIL(&launch_update, data, next);
+
+    return 0;
+}
+
+static int
+snp_metadata_desc_to_page_type(int desc_type)
+{
+    switch(desc_type) {
+    /* Add the umeasured prevalidated pages as a zero page */
+    case SEV_DESC_TYPE_SNP_SEC_MEM: return KVM_SEV_SNP_PAGE_TYPE_ZERO;
+    case SEV_DESC_TYPE_SNP_SECRETS: return KVM_SEV_SNP_PAGE_TYPE_SECRETS;
+    case SEV_DESC_TYPE_CPUID: return KVM_SEV_SNP_PAGE_TYPE_CPUID;
+    default: return -1;
+    }
+}
+
+static void
+snp_populate_metadata_pages(SevSnpGuestState *sev_snp, OvmfSevMetadata *metadata)
+{
+    OvmfSevMetadataDesc *desc;
+    int type, ret, i;
+    void *hva;
+    MemoryRegion *mr = NULL;
+
+    for (i = 0; i < metadata->num_desc; i++) {
+        desc = &metadata->descs[i];
+
+        type = snp_metadata_desc_to_page_type(desc->type);
+        if (type < 0) {
+            error_report("%s: Invalid memory type '%d'\n", __func__, desc->type);
+            exit(1);
+        }
+
+        hva = gpa2hva(&mr, desc->base, desc->len, NULL);
+        if (!hva) {
+            error_report("%s: Failed to get HVA for GPA 0x%x sz 0x%x\n",
+                         __func__, desc->base, desc->len);
+            exit(1);
+        }
+
+        ret = snp_launch_update_data(desc->base, hva, desc->len, type);
+        if (ret) {
+            error_report("%s: Failed to add metadata page gpa 0x%x+%x type %d\n",
+                         __func__, desc->base, desc->len, desc->type);
+            exit(1);
+        }
+    }
+}
+
 static void
 sev_snp_launch_finish(SevSnpGuestState *sev_snp)
 {
@@ -958,6 +1019,20 @@ sev_snp_launch_finish(SevSnpGuestState *sev_snp)
     SevLaunchUpdateData *data;
     struct kvm_sev_snp_launch_finish *finish = &sev_snp->kvm_finish_conf;
 
+    /*
+     * To boot the SNP guest, the hypervisor is required to populate the CPUID
+     * and Secrets page before finalizing the launch flow. The location of
+     * the secrets and CPUID page is available through the OVMF metadata GUID.
+     */
+    metadata = pc_system_get_ovmf_sev_metadata_ptr();
+    if (metadata == NULL) {
+        error_report("%s: Failed to locate SEV metadata header\n", __func__);
+        exit(1);
+    }
+
+    /* Populate all the metadata pages */
+    snp_populate_metadata_pages(sev_snp, metadata);
+
     QTAILQ_FOREACH(data, &launch_update, next) {
         ret = sev_snp_launch_update(sev_snp, data);
         if (ret) {
-- 
2.25.1


