Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB5CA2D18B
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Feb 2025 00:39:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgXwF-0007hE-Rj; Fri, 07 Feb 2025 18:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kim.phillips@amd.com>)
 id 1tgXwD-0007gz-2Q
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 18:39:09 -0500
Received: from mail-mw2nam10on2066.outbound.protection.outlook.com
 ([40.107.94.66] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kim.phillips@amd.com>)
 id 1tgXwA-0006G7-60
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 18:39:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/c0Q+vKoofO9G8Cx/ZynsvQqc8m0XFCxuu2S3sIQmmMrN9Dsg6t3OWIT/weiT0eV0dCagK4rb1RSmJsC9uXz/j/3pU26ORfXDvszGHDRchB6MwQiRmM4UKqD4ak++GO9KOSk7P8jOuOEh8gGq8pJDSpImKceZeyeQEwDIfNze21ocUpnLLDzDAG1MxlYgvG9QRp/VfDSMOshq/BmfzPB90tp/qvfkCQClZebYXSIpTasmANNy6JGfF+2ehlT/WgeZF5atwxUu9/cpkfEth/fF88EV1JmgVwlcF80I5dQnESmVufs7gsEjWL2IWDNJZe83t47y49ZLOGyRNwk1g/Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GglrWOgNwYsNo56niQdwLOMavoxiF6xaEQk7EgPN0Ic=;
 b=TQXmYQ8G+XoYFAPaNwjO+MkLuq9wzF+gV34tkZh6pfpCdwosVNGo7ke/Tc1Fe/DZLfjeRP14svJUnxmMEcyPSSMlvepZABkUKn8f1VSy+/aqT8v0uhvsvOZMXg3IO2sAlMTdLSSKsgoJd7wayFEgFOqfTUfU8NieG6GbsOET/kWE2h+G2kCY7w26M10I8MdNERuoVnO9OeBpismHi7f8fVzJW+i6OJyJDlroAWbw1Lpt8lVFk48ewalz55ZkdRYzJJY1/fV6yhT50kL/qMViwEDmehZDonVGCvnynsBjqe+t1LuZPetIAGqfD3nrOHdEYDyhDv3qEZGb5HPLbJY4yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GglrWOgNwYsNo56niQdwLOMavoxiF6xaEQk7EgPN0Ic=;
 b=Q0cHv9JDQXDNvkUZj+aLXVgDUswkhKXky3qKDEOBhvHEGiMZvvWC7OcODN2JHxtMDi2aT3qbIQW4PfM4C5fQK9yMLDEYVjtlhNCbu7sBPZ938Ie8cS3l0sk52bY4K5lkRUJKYURW0xo2EPmb46aa9TLxKjBkkqTg12xZ1aR+IH4=
Received: from BN9PR03CA0368.namprd03.prod.outlook.com (2603:10b6:408:f7::13)
 by IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 23:33:57 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:408:f7:cafe::87) by BN9PR03CA0368.outlook.office365.com
 (2603:10b6:408:f7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.30 via Frontend Transport; Fri,
 7 Feb 2025 23:33:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 23:33:56 +0000
Received: from zweier.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 17:33:54 -0600
From: Kim Phillips <kim.phillips@amd.com>
To: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>
CC: Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, "Nikunj A .
 Dadhania" <nikunj@amd.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Sean Christopherson <seanjc@google.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Kim
 Phillips <kim.phillips@amd.com>
Subject: [RFC] target/i386: sev: Add cmdline option to enable the Allowed SEV
 Features feature
Date: Fri, 7 Feb 2025 17:33:27 -0600
Message-ID: <20250207233327.130770-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: 9056aa45-214c-4698-b828-08dd47cfe3ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UGLrhmqwvhkxVQZjCoO3TJEpHO5BuzFkqx/Ck2zRTXTkjkNIWjZZJO1Lbyqq?=
 =?us-ascii?Q?UoQjqeBaL4s4BHsS5Ei8QTwUG+kb6yhFzdGKUAfesh2P/NwwhcnqpR/pi8TK?=
 =?us-ascii?Q?8Y9CMF0wMDlpJwFE5r7hNpKysrCgkjOcep9UVlPaLU+hl8WcTL/z+Lm751e7?=
 =?us-ascii?Q?ORSYWF2rc12o5TpCOo9GREfQ+9U/zIJk8dFp+Do27K6IbyeNwKB0m4KvasiN?=
 =?us-ascii?Q?vV8d4L1yVjd0tWAO2zwElpuLJatCi6Fro+Y9Pte0U0wwfA6va8V10GVV8BTv?=
 =?us-ascii?Q?xdXO/mqMkQHPd7bpjEfwbNeXofoWIdNdBmw26jqnViynqecSZ7CyMV3wVbYb?=
 =?us-ascii?Q?R+Hxd94hXF4qKGZW1JnG/EEIVxXH4Px7IB3tpHgT/ervkQLHWgFcYziU0ucc?=
 =?us-ascii?Q?7wXPOdMX6bKgIJWKlYVz9VBG2ko/reD2gp+JPATTITxQ8ootHR801k4TINdE?=
 =?us-ascii?Q?WvZKrxWOxzmB9DWk7f9Q4P9AU5TW23kxBeEjvyDpHvS5Jhps6iRjXk62WYCC?=
 =?us-ascii?Q?LiPivhpyqkamHu/qzgclHBG0ea1x+KPHgaP0P+1FN0ItWQ8I+KCQZZ9Ee7zp?=
 =?us-ascii?Q?pNy2CvwMZTghSN8T4ieay0ElyL9boFmGRxyk1d17XN5NvKLwsBcJUm4g9xMW?=
 =?us-ascii?Q?oRr7FjFmSwt6igwf0JQwc3rBynMQYA0zjE2RJ1+e9wvSt5C1YVbzE2N53PD7?=
 =?us-ascii?Q?ATnUymWAnXIwg/DW8PkxP7YC2dnz9LMDviobxsYw6RNAm8tkZI+vB78Vaxgv?=
 =?us-ascii?Q?bd3ZtIp8+lPBBtYAL8DDlcaOaQRsG1OVwJofLoXDGFkbd3u0/qxp7Edy3OoJ?=
 =?us-ascii?Q?0r4g6eDDrTfbEtzhnLggJJa+Bm1NyOuxjDhfmjAV9O5snsTHmNGvxSOZQSLB?=
 =?us-ascii?Q?Y5Ul3jgpX8o434WcINLQRnshTnM3AToY/kSPF+IkkRDB2G2Sfqoq4QwQ52/e?=
 =?us-ascii?Q?2MpQaGDJH7ZwHWhfpaz0mqlmO5XBPYU9dAXDQ7LdVagKNqt2t5m5edLlbaol?=
 =?us-ascii?Q?h1vnd6v2IBIxtAnx4HQWkq2VrSRaruCrRAA99DXTx79kD1Uh2KG/qM0Kn0EJ?=
 =?us-ascii?Q?EBW18kVKKu2GXpN5lJvSR876cOsMZq/fZQWrA/GeE5v7g7EXvg6e/7W2vKMP?=
 =?us-ascii?Q?uYr15W/N5/Guch3/VOLQqt2vTJgEn4vYnE/DqeLSbRePZ/8WgEEHGbB7SyRm?=
 =?us-ascii?Q?R8jVFU+yHe7zwlPgyq7WiiTE7Cp4poVOdbuF3f7tyOnyEwJ2YvtRiazECUPn?=
 =?us-ascii?Q?zBd2H1iD8AzQftg7AgeJQ8VhUa50ySFjgPZU6DiJiZoOmzCQfZTeXb2Zyybz?=
 =?us-ascii?Q?uhWv1W0W3RsP6rvkRtMP+9PRS5+wxBhrei0LQs5s5uE2h/RjtD1qZHAppAPE?=
 =?us-ascii?Q?JoS77/KJ+4fWQOZo5S6BMMixNI5fsoVMBCSMLN02r9FrfQgQ3NdsO6tw37UT?=
 =?us-ascii?Q?Vqctay9xCiu2HejSIj7puapKt33libwr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 23:33:56.3728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9056aa45-214c-4698-b828-08dd47cfe3ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650
Received-SPF: permerror client-ip=40.107.94.66;
 envelope-from=kim.phillips@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The Allowed SEV Features feature allows the host kernel to control
which SEV features it does not want the guest to enable [1].

This has to be explicitly opted-in by the user because it has the
ability to break existing VMs if it were set automatically.

Currently, both the PmcVirtualization and SecureAvic features
require the Allowed SEV Features feature to be set.

Based on a similar patch written for Secure TSC [2].

[1] Section 15.36.20 "Allowed SEV Features", AMD64 Architecture
    Programmer's Manual, Pub. 24593 Rev. 3.42 - March 2024:
    https://bugzilla.kernel.org/attachment.cgi?id=306250

[2] https://github.com/qemu/qemu/commit/4b2288dc6025ba32519ee8d202ca72d565cbbab7

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
 qapi/qom.json     |  6 ++++-
 target/i386/sev.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/sev.h |  2 ++
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 28ce24cd8d..113b44ad74 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -948,13 +948,17 @@
 #     designated guest firmware page for measured boot with -kernel
 #     (default: false) (since 6.2)
 #
+# @allowed-sev-features: true if secure allowed-sev-features feature
+#     is to be enabled in an SEV-ES or SNP guest. (default: false)
+#
 # Since: 9.1
 ##
 { 'struct': 'SevCommonProperties',
   'data': { '*sev-device': 'str',
             '*cbitpos': 'uint32',
             'reduced-phys-bits': 'uint32',
-            '*kernel-hashes': 'bool' } }
+            '*kernel-hashes': 'bool',
+            '*allowed-sev-features': 'bool' } }
 
 ##
 # @SevGuestProperties:
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 0e1dbb6959..85ad73f9a0 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -98,6 +98,7 @@ struct SevCommonState {
     uint32_t cbitpos;
     uint32_t reduced_phys_bits;
     bool kernel_hashes;
+    uint64_t vmsa_features;
 
     /* runtime state */
     uint8_t api_major;
@@ -411,6 +412,33 @@ sev_get_reduced_phys_bits(void)
     return sev_common ? sev_common->reduced_phys_bits : 0;
 }
 
+static __u64
+sev_supported_vmsa_features(void)
+{
+    uint64_t supported_vmsa_features = 0;
+    struct kvm_device_attr attr = {
+        .group = KVM_X86_GRP_SEV,
+        .attr = KVM_X86_SEV_VMSA_FEATURES,
+        .addr = (unsigned long) &supported_vmsa_features
+    };
+
+    bool sys_attr = kvm_check_extension(kvm_state, KVM_CAP_SYS_ATTRIBUTES);
+    if (!sys_attr) {
+        return 0;
+    }
+
+    int rc = kvm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
+    if (rc < 0) {
+        if (rc != -ENXIO) {
+            warn_report("KVM_GET_DEVICE_ATTR(0, KVM_X86_SEV_VMSA_FEATURES) "
+                        "error: %d", rc);
+        }
+        return 0;
+    }
+
+    return supported_vmsa_features;
+}
+
 static SevInfo *sev_get_info(void)
 {
     SevInfo *info;
@@ -1524,6 +1552,20 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     case KVM_X86_SNP_VM: {
         struct kvm_sev_init args = { 0 };
 
+        if (sev_es_enabled()) {
+            __u64 vmsa_features, supported_vmsa_features;
+
+            supported_vmsa_features = sev_supported_vmsa_features();
+            vmsa_features = sev_common->vmsa_features;
+            if ((vmsa_features & supported_vmsa_features) != vmsa_features) {
+                error_setg(errp, "%s: requested sev feature mask (0x%llx) "
+                           "contains bits not supported by the host kernel "
+                           " (0x%llx)", __func__, vmsa_features,
+                           supported_vmsa_features);
+            return -1;
+            }
+            args.vmsa_features = vmsa_features;
+        }
         ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_INIT2, &args, &fw_error);
         break;
     }
@@ -2044,6 +2086,19 @@ static void sev_common_set_kernel_hashes(Object *obj, bool value, Error **errp)
     SEV_COMMON(obj)->kernel_hashes = value;
 }
 
+static bool
+sev_snp_guest_get_allowed_sev_features(Object *obj, Error **errp)
+{
+    return SEV_COMMON(obj)->vmsa_features & SEV_VMSA_ALLOWED_SEV_FEATURES;
+}
+
+static void
+sev_snp_guest_set_allowed_sev_features(Object *obj, bool value, Error **errp)
+{
+    if (value)
+        SEV_COMMON(obj)->vmsa_features |= SEV_VMSA_ALLOWED_SEV_FEATURES;
+}
+
 static void
 sev_common_class_init(ObjectClass *oc, void *data)
 {
@@ -2061,6 +2116,11 @@ sev_common_class_init(ObjectClass *oc, void *data)
                                    sev_common_set_kernel_hashes);
     object_class_property_set_description(oc, "kernel-hashes",
             "add kernel hashes to guest firmware for measured Linux boot");
+    object_class_property_add_bool(oc, "allowed-sev-features",
+                                   sev_snp_guest_get_allowed_sev_features,
+                                   sev_snp_guest_set_allowed_sev_features);
+    object_class_property_set_description(oc, "allowed-sev-features",
+            "Enable the Allowed SEV Features feature");
 }
 
 static void
diff --git a/target/i386/sev.h b/target/i386/sev.h
index 373669eaac..07447c4b01 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -44,6 +44,8 @@ bool sev_snp_enabled(void);
 #define SEV_SNP_POLICY_SMT      0x10000
 #define SEV_SNP_POLICY_DBG      0x80000
 
+#define SEV_VMSA_ALLOWED_SEV_FEATURES BIT_ULL(63)
+
 typedef struct SevKernelLoaderContext {
     char *setup_data;
     size_t setup_size;
-- 
2.43.0


