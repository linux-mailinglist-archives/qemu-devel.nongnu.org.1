Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB01AD8EDB
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Jun 2025 16:11:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ57y-0001cM-0w; Fri, 13 Jun 2025 10:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uQ57s-0001Ob-3W
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:11:24 -0400
Received: from smtp-out-60.livemail.co.uk ([213.171.216.60]
 helo=dkim.livemail.co.uk)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uQ57p-0002CM-MA
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:11:23 -0400
Received: from smtp.livemail.co.uk (unknown [10.44.132.82])
 by dkim.livemail.co.uk (Postfix) with ESMTPS id D97611802D4;
 Fri, 13 Jun 2025 15:11:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=randomman.co.uk;
 s=livemail2; t=1749823879;
 bh=2Ql4x0vibybJS4USky7CMG78BCCbeUBBq6FeJfBQwEs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k+n238ocloDzLuWDki7losdBtSVaP+aLw5ypF1VYMyrovyvy78zzy4t/yx11yuBXd
 LCL8D+6NDSYlSheIZuvrwQaHBelB3KBd9dLsyKdBLvDwXqSI/aQuVEAO5xeEGj6uau
 B1fkFKYhHJzh5zeLI84JS/miej6JjmU1Q18tePQs=
Received: from localhost.localdomain (unknown [145.40.191.116])
 (Authenticated sender: roy.hopkins@randomman.co.uk)
 by smtp.livemail.co.uk (Postfix) with ESMTPSA id 56462C0B3E;
 Fri, 13 Jun 2025 15:11:15 +0100 (BST)
From: Roy Hopkins <roy.hopkins@randomman.co.uk>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v8 06/16] sev: Update launch_update_data functions to use
 Error handling
Date: Fri, 13 Jun 2025 14:53:21 +0100
Message-ID: <8e41059626469c94459b6a6b6cc1ce745968dae9.1749820158.git.roy.hopkins@randomman.co.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749820158.git.roy.hopkins@randomman.co.uk>
References: <cover.1749820158.git.roy.hopkins@randomman.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.171.216.60;
 envelope-from=roy.hopkins@randomman.co.uk; helo=dkim.livemail.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The class function and implementations for updating launch data return
a code in case of error. In some cases an error message is generated and
in other cases, just the error return value is used.

This small refactor adds an 'Error **errp' parameter to all functions
which consistently set an error condition if a non-zero value is
returned.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Gerd Hoffman <kraxel@redhat.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 target/i386/sev.c | 68 +++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 1a12f0671c..a84f5f5d28 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -122,7 +122,8 @@ struct SevCommonStateClass {
                                        Error **errp);
     int (*launch_start)(SevCommonState *sev_common);
     void (*launch_finish)(SevCommonState *sev_common);
-    int (*launch_update_data)(SevCommonState *sev_common, hwaddr gpa, uint8_t *ptr, size_t len);
+    int (*launch_update_data)(SevCommonState *sev_common, hwaddr gpa,
+                              uint8_t *ptr, size_t len, Error **errp);
     int (*kvm_init)(ConfidentialGuestSupport *cgs, Error **errp);
 };
 
@@ -970,9 +971,8 @@ sev_snp_adjust_cpuid_features(X86ConfidentialGuest *cg, uint32_t feature, uint32
     return value;
 }
 
-static int
-sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
-                       uint8_t *addr, size_t len)
+static int sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
+                                  uint8_t *addr, size_t len, Error **errp)
 {
     int ret, fw_error;
     struct kvm_sev_launch_update_data update;
@@ -987,8 +987,8 @@ sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
     ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_LAUNCH_UPDATE_DATA,
                     &update, &fw_error);
     if (ret) {
-        error_report("%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'",
-                __func__, ret, fw_error, fw_error_to_str(fw_error));
+        error_setg(errp, "%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'", __func__,
+                   ret, fw_error, fw_error_to_str(fw_error));
     }
 
     return ret;
@@ -1116,8 +1116,8 @@ sev_launch_finish(SevCommonState *sev_common)
     migrate_add_blocker(&sev_mig_blocker, &error_fatal);
 }
 
-static int
-snp_launch_update_data(uint64_t gpa, void *hva, size_t len, int type)
+static int snp_launch_update_data(uint64_t gpa, void *hva, size_t len,
+                                  int type, Error **errp)
 {
     SevLaunchUpdateData *data;
 
@@ -1132,23 +1132,21 @@ snp_launch_update_data(uint64_t gpa, void *hva, size_t len, int type)
     return 0;
 }
 
-static int
-sev_snp_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
-                           uint8_t *ptr, size_t len)
+static int sev_snp_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
+                                      uint8_t *ptr, size_t len, Error **errp)
 {
-       int ret = snp_launch_update_data(gpa, ptr, len,
-                                         KVM_SEV_SNP_PAGE_TYPE_NORMAL);
-       return ret;
+    return snp_launch_update_data(gpa, ptr, len,
+                                     KVM_SEV_SNP_PAGE_TYPE_NORMAL, errp);
 }
 
 static int
 sev_snp_cpuid_info_fill(SnpCpuidInfo *snp_cpuid_info,
-                        const KvmCpuidInfo *kvm_cpuid_info)
+                        const KvmCpuidInfo *kvm_cpuid_info, Error **errp)
 {
     size_t i;
 
     if (kvm_cpuid_info->cpuid.nent > SNP_CPUID_FUNCTION_MAXCOUNT) {
-        error_report("SEV-SNP: CPUID entry count (%d) exceeds max (%d)",
+        error_setg(errp, "SEV-SNP: CPUID entry count (%d) exceeds max (%d)",
                      kvm_cpuid_info->cpuid.nent, SNP_CPUID_FUNCTION_MAXCOUNT);
         return -1;
     }
@@ -1190,8 +1188,8 @@ sev_snp_cpuid_info_fill(SnpCpuidInfo *snp_cpuid_info,
     return 0;
 }
 
-static int
-snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva, size_t cpuid_len)
+static int snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva,
+                                   size_t cpuid_len, Error **errp)
 {
     KvmCpuidInfo kvm_cpuid_info = {0};
     SnpCpuidInfo snp_cpuid_info;
@@ -1208,26 +1206,25 @@ snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva, size_t cpuid_len)
     } while (ret == -E2BIG);
 
     if (ret) {
-        error_report("SEV-SNP: unable to query CPUID values for CPU: '%s'",
-                     strerror(-ret));
-        return 1;
+        error_setg(errp, "SEV-SNP: unable to query CPUID values for CPU: '%s'",
+                   strerror(-ret));
+        return -1;
     }
 
-    ret = sev_snp_cpuid_info_fill(&snp_cpuid_info, &kvm_cpuid_info);
-    if (ret) {
-        error_report("SEV-SNP: failed to generate CPUID table information");
-        return 1;
+    ret = sev_snp_cpuid_info_fill(&snp_cpuid_info, &kvm_cpuid_info, errp);
+    if (ret < 0) {
+        return -1;
     }
 
     memcpy(hva, &snp_cpuid_info, sizeof(snp_cpuid_info));
 
     return snp_launch_update_data(cpuid_addr, hva, cpuid_len,
-                                  KVM_SEV_SNP_PAGE_TYPE_CPUID);
+                                  KVM_SEV_SNP_PAGE_TYPE_CPUID, errp);
 }
 
-static int
-snp_launch_update_kernel_hashes(SevSnpGuestState *sev_snp, uint32_t addr,
-                                void *hva, uint32_t len)
+static int snp_launch_update_kernel_hashes(SevSnpGuestState *sev_snp,
+                                           uint32_t addr, void *hva,
+                                           uint32_t len, Error **errp)
 {
     int type = KVM_SEV_SNP_PAGE_TYPE_ZERO;
     if (sev_snp->parent_obj.kernel_hashes) {
@@ -1239,7 +1236,7 @@ snp_launch_update_kernel_hashes(SevSnpGuestState *sev_snp, uint32_t addr,
                sizeof(*sev_snp->kernel_hashes_data));
         type = KVM_SEV_SNP_PAGE_TYPE_NORMAL;
     }
-    return snp_launch_update_data(addr, hva, len, type);
+    return snp_launch_update_data(addr, hva, len, type, errp);
 }
 
 static int
@@ -1277,12 +1274,14 @@ snp_populate_metadata_pages(SevSnpGuestState *sev_snp,
         }
 
         if (type == KVM_SEV_SNP_PAGE_TYPE_CPUID) {
-            ret = snp_launch_update_cpuid(desc->base, hva, desc->len);
+            ret = snp_launch_update_cpuid(desc->base, hva, desc->len,
+                                          &error_fatal);
         } else if (desc->type == SEV_DESC_TYPE_SNP_KERNEL_HASHES) {
             ret = snp_launch_update_kernel_hashes(sev_snp, desc->base, hva,
-                                                  desc->len);
+                                                  desc->len, &error_fatal);
         } else {
-            ret = snp_launch_update_data(desc->base, hva, desc->len, type);
+            ret = snp_launch_update_data(desc->base, hva, desc->len, type,
+                                         &error_fatal);
         }
 
         if (ret) {
@@ -1615,9 +1614,8 @@ sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp)
     if (sev_check_state(sev_common, SEV_STATE_LAUNCH_UPDATE)) {
         int ret;
 
-        ret = klass->launch_update_data(sev_common, gpa, ptr, len);
+        ret = klass->launch_update_data(sev_common, gpa, ptr, len, errp);
         if (ret < 0) {
-            error_setg(errp, "SEV: Failed to encrypt pflash rom");
             return ret;
         }
     }
-- 
2.43.0


