Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BEA72BB0D
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 10:43:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8d90-0003zf-JR; Mon, 12 Jun 2023 04:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1q8d8r-0003yv-Fm
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 04:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1q8d8p-0007XO-5A
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 04:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686559389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJ9XKKQfCBUj1wypA/gFlaBPTwyYRcYctE4LP9sVCSc=;
 b=JGWXiPyowsTZ1J7GbH1XDNXfzPuuhivFRmmuyDMBwaUpIuz3l4X/ihTTDGv4/CI3bnDMvL
 nGiCuk2PF/MNJnyapt8YOXAigdj/0sG02H0CEWU8RFZjyjuGtisJUx5OzmwK0DS1U7k/Qu
 5RI7GJf2t6uJPS0BgQjQ4tfry3yw1Sw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-Tpx3jYLmPFGxip2nyy047Q-1; Mon, 12 Jun 2023 04:42:04 -0400
X-MC-Unique: Tpx3jYLmPFGxip2nyy047Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B94028028B2
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 08:42:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 077351121314;
 Mon, 12 Jun 2023 08:42:02 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 1/2] i386: Fix conditional CONFIG_SYNDBG enablement
Date: Mon, 12 Jun 2023 10:42:00 +0200
Message-Id: <20230612084201.294248-2-vkuznets@redhat.com>
In-Reply-To: <20230612084201.294248-1-vkuznets@redhat.com>
References: <20230612084201.294248-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Putting HYPERV_FEAT_SYNDBG entry under "#ifdef CONFIG_SYNDBG" in
'kvm_hyperv_properties' array is wrong: as HYPERV_FEAT_SYNDBG is not
the highest feature number, the result is an empty (zeroed) entry in
the array (and not a skipped entry!). hyperv_feature_supported() is
designed to check that all CPUID bits are set but for a zeroed
feature in 'kvm_hyperv_properties' it returns 'true' so QEMU considers
HYPERV_FEAT_SYNDBG as always supported, regardless of whether KVM host
actually supports it.

To fix the issue, leave HYPERV_FEAT_SYNDBG's definition in
'kvm_hyperv_properties' array, there's nothing wrong in having it defined
even when 'CONFIG_SYNDBG' is not set. Instead, put "hv-syndbg" CPU property
under '#ifdef CONFIG_SYNDBG' to alter the existing behavior when the flag
is silently skipped in !CONFIG_SYNDBG builds.

Leave an 'assert' sentinel in hyperv_feature_supported() making sure there
are no 'holes' or improperly defined features in 'kvm_hyperv_properties'.

Fixes: d8701185f40c ("hw: hyperv: Initial commit for Synthetic Debugging device")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/cpu.c     |  2 ++
 target/i386/kvm/kvm.c | 11 +++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1242bd541a53..caa207849e9a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7564,8 +7564,10 @@ static Property x86_cpu_properties[] = {
                       HYPERV_FEAT_TLBFLUSH_DIRECT, 0),
     DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
                             hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
+#ifdef CONFIG_SYNDBG
     DEFINE_PROP_BIT64("hv-syndbg", X86CPU, hyperv_features,
                       HYPERV_FEAT_SYNDBG, 0),
+#endif
     DEFINE_PROP_BOOL("hv-passthrough", X86CPU, hyperv_passthrough, false),
     DEFINE_PROP_BOOL("hv-enforce-cpuid", X86CPU, hyperv_enforce_cpuid, false),
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index de531842f6b1..88c75f58f0a6 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -989,7 +989,6 @@ static struct {
              .bits = HV_DEPRECATING_AEOI_RECOMMENDED}
         }
     },
-#ifdef CONFIG_SYNDBG
     [HYPERV_FEAT_SYNDBG] = {
         .desc = "Enable synthetic kernel debugger channel (hv-syndbg)",
         .flags = {
@@ -998,7 +997,6 @@ static struct {
         },
         .dependencies = BIT(HYPERV_FEAT_SYNIC) | BIT(HYPERV_FEAT_RELAXED)
     },
-#endif
     [HYPERV_FEAT_MSR_BITMAP] = {
         .desc = "enlightened MSR-Bitmap (hv-emsr-bitmap)",
         .flags = {
@@ -1250,6 +1248,13 @@ static bool hyperv_feature_supported(CPUState *cs, int feature)
     uint32_t func, bits;
     int i, reg;
 
+    /*
+     * kvm_hyperv_properties needs to define at least one CPUID flag which
+     * must be used to detect the feature, it's hard to say whether it is
+     * supported or not otherwise.
+     */
+    assert(kvm_hyperv_properties[feature].flags[0].func);
+
     for (i = 0; i < ARRAY_SIZE(kvm_hyperv_properties[feature].flags); i++) {
 
         func = kvm_hyperv_properties[feature].flags[i].func;
@@ -3474,13 +3479,11 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
                 kvm_msr_entry_add(cpu, HV_X64_MSR_TSC_EMULATION_STATUS,
                                   env->msr_hv_tsc_emulation_status);
             }
-#ifdef CONFIG_SYNDBG
             if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNDBG) &&
                 has_msr_hv_syndbg_options) {
                 kvm_msr_entry_add(cpu, HV_X64_MSR_SYNDBG_OPTIONS,
                                   hyperv_syndbg_query_options());
             }
-#endif
         }
         if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VAPIC)) {
             kvm_msr_entry_add(cpu, HV_X64_MSR_APIC_ASSIST_PAGE,
-- 
2.40.1


