Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F54CA2D186
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Feb 2025 00:35:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgXs9-0005ci-U3; Fri, 07 Feb 2025 18:34:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kim.phillips@amd.com>)
 id 1tgXs8-0005c5-IG
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 18:34:56 -0500
Received: from mail-bn8nam12on2062e.outbound.protection.outlook.com
 ([2a01:111:f403:2418::62e]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kim.phillips@amd.com>)
 id 1tgXs6-0005qi-HM
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 18:34:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKCiMuZF5SrJ9C95BYhoSYBMJ0sFvYkIxUHn5rChuHRsjNwlHT1UrcfGsHAnlMaApx5bd29KFfugVk3bs3t6emFtcMOu4b80BBu39z9BYsIB/q2hIDJnPLhrqcwpEq5PA0tqB61zly693z1nibr2hbF/8iS8/fGvweHhZxhJy4wz6cLQRS/3NL0jxgwFBY83KVUCzwv/ocjG8J3WZP/vQ2lDRlvCAg7vQ5lDL8max5iH1U6AS/94tXdsphxQ1x4JfqDtjf+Sjm5gIDBZEXv2yWD6jYUQM16E7UqBrnvOvm6uC5v84r+rJW5PWkREly2oDFkeNnERUkRB32R7Ok508w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zCyf/9o8EcVmGuPfIo75VZBwAT40Wd68cp9w/rW7hk=;
 b=g7sNN1nJGZEspruhMdppsGx+dl1cp+PNMVPzcM+7kM8k92oYbdBlebiEHIqY1f+r9N6SrYgQEHIfLOCzk0r9pv6dDfDFfJA3SVhweI6j2QWm6q0wfF2f3CMzBtp82Ue3/dYCsTXflAzTqsMLYfQ/Cx8E06OIjg1LFqD6tCo92qqLEF/bdGdmqx/wxYzP7CoNA82I8aanCkte9zCnCtxIQImjXQE+BjiYG64x/OC41pkBStXRH2cNwJHXysUQeotnJSwgiVQRwOP2z+/bxBNz+bWy6eNPuNrOQ8LtfMTG173IiJjG1RZw2+cOaajxHsmhb5zEUPhowW4utUZ7kSNlUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zCyf/9o8EcVmGuPfIo75VZBwAT40Wd68cp9w/rW7hk=;
 b=Hl8qAsoZ/fxfiFvahHH0fggpvfRXgXXC28ZD9IeG++kuym3vQi7rlpZVZX33N9D+tScbb7NOO6D6cKHtff9qQSJOCQ7tkxmtLGiT57M7zIjt3TIJQDA+3s3YkEf1XoPFG0cCqEpBWA5NTFRPhTZ2e8Up9n3BxSPxJPufXSZiwSs=
Received: from BL0PR1501CA0032.namprd15.prod.outlook.com
 (2603:10b6:207:17::45) by DS0PR12MB8454.namprd12.prod.outlook.com
 (2603:10b6:8:15e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 23:34:47 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:207:17:cafe::e4) by BL0PR1501CA0032.outlook.office365.com
 (2603:10b6:207:17::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.30 via Frontend Transport; Fri,
 7 Feb 2025 23:34:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 23:34:47 +0000
Received: from zweier.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 17:34:46 -0600
From: Kim Phillips <kim.phillips@amd.com>
To: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>
CC: Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, "Nikunj A .
 Dadhania" <nikunj@amd.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Sean Christopherson <seanjc@google.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, Kim Phillips <kim.phillips@amd.com>,
 "Kishon Vijay Abraham I" <kvijayab@amd.com>
Subject: [PATCH v3 2/2] KVM: SEV: Configure "ALLOWED_SEV_FEATURES" VMCB Field
Date: Fri, 7 Feb 2025 17:34:09 -0600
Message-ID: <20250207233410.130813-3-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207233410.130813-1-kim.phillips@amd.com>
References: <20250207233410.130813-1-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 0987dc23-2bbc-4ee3-22de-08dd47d0026f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iPNsxxPa6r8VLkujid06bvadA6vJTZ80XJf+i9Rul1adGS0a0krHNdKEnZsg?=
 =?us-ascii?Q?9U68Kam5kQfnTjx7gVJVcODbrCtiQlyLuDKcm1Mshb17z663kF/WN5fpM7uN?=
 =?us-ascii?Q?2LP6O6jhhz4HGsbR54YxJ6riRmtR1RN6g0Qe8/DiTKFnmVypvajedtmXJsBS?=
 =?us-ascii?Q?9wEyjB3ZUeGgSRFLDuADZEOTUjv1l4COe114HSlWKIX1tLjyZsVRrJ3nTmZs?=
 =?us-ascii?Q?/y3NfiPdqM9MfqNW2A5S8LUoV0/yFOuchjV0naansmdVNkW6Q9R84z9kwl9P?=
 =?us-ascii?Q?hcircUbG5DLp2ZC+LmCEgSobNjs7yFPDTNPwwxGmZJi30ZXATlA7Woq1XlTg?=
 =?us-ascii?Q?Gtfpxv2pGXJ/JyxAfQmYhP5cudNFOJrhJEBAfTXaZvo8Juf08nWE6MoGsrqO?=
 =?us-ascii?Q?sA/pTnzIQEhPHFUrgJlpDMCGbwFGUqpssx1mjnBAmc0vX1el/7phWCiCXHSq?=
 =?us-ascii?Q?t3L9vCvLV2ifgek44etRD1WgeiXI9Dz1J7o7Qyut9GXbfQX81PpGk770agQz?=
 =?us-ascii?Q?o+nb+CHcy7s9fkMc+pHArs+XSvigtjdXuaCcYrM5MV8b9lbY0QmgLcqNYZmr?=
 =?us-ascii?Q?0jUJbNrmTSjSILraK2NVSPXYOzijJObR/TdZXIqIFuG7CXpbrrzKElT5xQPO?=
 =?us-ascii?Q?YgXBi4a7KO+nPRitCaw6Yt+PDrAVP0pcE5MZFOLm8arSYGmYoCOo3Gwat8Z7?=
 =?us-ascii?Q?pmtLTtcf8kvr0i7B1jFA9h1jJzgF6H84b3CZTwbNo52iPV/+KBvnhy50l5tp?=
 =?us-ascii?Q?kGphKOlkK4VSlJvc4AwEn78UiLwko5NmVN7tOBQ2mG5GHSDIObodxlRo6jAE?=
 =?us-ascii?Q?j8UIKjzNlZRYXLzm9tvhwS+qq8r68S2WfaE/yaV+WxZmIJWBggqo3iWDWVyj?=
 =?us-ascii?Q?kNcyTdAPFtfMhJJxfl5EPueYJCJENnjWdQcUhSUMZ6ut05nT8VflHb8z1ec4?=
 =?us-ascii?Q?LXyt6wsz4ZM4dz0WxILgRlfhR3IfB6UIiul4f+DQlpjNuQiCM3zmi05YR/6d?=
 =?us-ascii?Q?l/PICDzuaRhEGfGuugby5PkTWyiG2ORDZaw0bZNeFtHvyQo+kqILJxzpEHQl?=
 =?us-ascii?Q?L886zBBtRUptG/NnWv6N9pIMO1xmiYd18w56GPpABjo4qxHcgolacSzso8Oz?=
 =?us-ascii?Q?7csiysfiLJVYktu3UWDkl1Sfdq3JwHDgSr1+5i3lJimm+3IkQT0Qv6kL8E+T?=
 =?us-ascii?Q?0+kQY9FOpIz+jiK6/6eO62UgXGq8qj5tJusAKb/DHAnxvpFu/5LSBj/GB8tj?=
 =?us-ascii?Q?SR8THDNBf2WlQGoic3LAcpjSZJ19MxzONuK3bF2TH6nZinfvC2CtdJPycD+G?=
 =?us-ascii?Q?EJQ8mx63XJXAm91NGFSiEXazawFRcwIbtxplXzUEb8OZ9IIC3mBlE5s4nAYD?=
 =?us-ascii?Q?WiROrHQueeN7SIVjvL1TGvwv4ZeCQ5ig6ZMsP4n3GuVj/On8sg6mpEbSAdcA?=
 =?us-ascii?Q?zWES6B/Yq1A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 23:34:47.5460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0987dc23-2bbc-4ee3-22de-08dd47d0026f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454
Received-SPF: permerror client-ip=2a01:111:f403:2418::62e;
 envelope-from=kim.phillips@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

AMD EPYC 5th generation processors have introduced a feature that allows
the hypervisor to control the SEV_FEATURES that are set for, or by, a
guest [1].  ALLOWED_SEV_FEATURES can be used by the hypervisor to enforce
that SEV-ES and SEV-SNP guests cannot enable features that the
hypervisor does not want to be enabled.

When ALLOWED_SEV_FEATURES is enabled, a VMRUN will fail if any
non-reserved bits are 1 in SEV_FEATURES but are 0 in
ALLOWED_SEV_FEATURES.

Some SEV_FEATURES - currently PmcVirtualization and SecureAvic
(see Appendix B, Table B-4) - require an opt-in via ALLOWED_SEV_FEATURES,
i.e. are off-by-default, whereas all other features are effectively
on-by-default, but still honor ALLOWED_SEV_FEATURES.

[1] Section 15.36.20 "Allowed SEV Features", AMD64 Architecture
    Programmer's Manual, Pub. 24593 Rev. 3.42 - March 2024:
    https://bugzilla.kernel.org/attachment.cgi?id=306250

Co-developed-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
 arch/x86/include/asm/svm.h |  5 ++++-
 arch/x86/kvm/svm/sev.c     | 17 +++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index e2fac21471f5..6d94a727cc1a 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -158,7 +158,9 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 	u64 avic_physical_id;	/* Offset 0xf8 */
 	u8 reserved_7[8];
 	u64 vmsa_pa;		/* Used for an SEV-ES guest */
-	u8 reserved_8[720];
+	u8 reserved_8[40];
+	u64 allowed_sev_features;	/* Offset 0x138 */
+	u8 reserved_9[672];
 	/*
 	 * Offset 0x3e0, 32 bytes reserved
 	 * for use by hypervisor/software.
@@ -289,6 +291,7 @@ static_assert((X2AVIC_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AVIC_
 #define SVM_SEV_FEAT_RESTRICTED_INJECTION		BIT(3)
 #define SVM_SEV_FEAT_ALTERNATE_INJECTION		BIT(4)
 #define SVM_SEV_FEAT_DEBUG_SWAP				BIT(5)
+#define SVM_SEV_FEAT_ALLOWED_SEV_FEATURES		BIT_ULL(63)
 
 #define SVM_SEV_FEAT_INT_INJ_MODES		\
 	(SVM_SEV_FEAT_RESTRICTED_INJECTION |	\
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a2a794c32050..a9e16792cac0 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -894,9 +894,19 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 	return 0;
 }
 
+static u64 allowed_sev_features(struct kvm_sev_info *sev)
+{
+	if (cpu_feature_enabled(X86_FEATURE_ALLOWED_SEV_FEATURES) &&
+	    (sev->vmsa_features & SVM_SEV_FEAT_ALLOWED_SEV_FEATURES))
+		return sev->vmsa_features;
+
+	return 0;
+}
+
 static int __sev_launch_update_vmsa(struct kvm *kvm, struct kvm_vcpu *vcpu,
 				    int *error)
 {
+	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
 	struct sev_data_launch_update_vmsa vmsa;
 	struct vcpu_svm *svm = to_svm(vcpu);
 	int ret;
@@ -906,6 +916,8 @@ static int __sev_launch_update_vmsa(struct kvm *kvm, struct kvm_vcpu *vcpu,
 		return -EINVAL;
 	}
 
+	svm->vmcb->control.allowed_sev_features = allowed_sev_features(sev);
+
 	/* Perform some pre-encryption checks against the VMSA */
 	ret = sev_es_sync_vmsa(svm);
 	if (ret)
@@ -2447,6 +2459,8 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		struct vcpu_svm *svm = to_svm(vcpu);
 		u64 pfn = __pa(svm->sev_es.vmsa) >> PAGE_SHIFT;
 
+		svm->vmcb->control.allowed_sev_features = allowed_sev_features(sev);
+
 		ret = sev_es_sync_vmsa(svm);
 		if (ret)
 			return ret;
@@ -3069,6 +3083,9 @@ void __init sev_hardware_setup(void)
 	sev_supported_vmsa_features = 0;
 	if (sev_es_debug_swap_enabled)
 		sev_supported_vmsa_features |= SVM_SEV_FEAT_DEBUG_SWAP;
+
+	if (sev_es_enabled && cpu_feature_enabled(X86_FEATURE_ALLOWED_SEV_FEATURES))
+		sev_supported_vmsa_features |= SVM_SEV_FEAT_ALLOWED_SEV_FEATURES;
 }
 
 void sev_hardware_unsetup(void)
-- 
2.43.0


