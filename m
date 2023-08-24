Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D37AC786ADE
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 10:58:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6Ai-000832-52; Thu, 24 Aug 2023 04:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qZ6Af-00082d-RJ
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 04:58:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qZ6Ad-0003qM-LM
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 04:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692867507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FejcfvmcyBS10KS1IwKQD1UjRIW+u81CbUOC29wnz6Q=;
 b=ebOYGsD5cX4XoQvEIlA+IcFsCENew6Cqu9j1m6ntGjzElA3ZSEogyDi+YkKd31OQLumKsh
 jPlVDqm77X/SK/ImJz8T5F8Exej+92YegVvh92RTS7nFPsw8rOQDhZVWAmJn4ZxvH+S27t
 04DaMrbGagePmH2sURZp5cbjeyPtgSY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517--UABpUiMPomgKqhkaaAKLg-1; Thu, 24 Aug 2023 04:57:58 -0400
X-MC-Unique: -UABpUiMPomgKqhkaaAKLg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4523A2808B2F;
 Thu, 24 Aug 2023 08:57:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.155])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EEE80140E91D;
 Thu, 24 Aug 2023 08:57:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B1BEE1800627; Thu, 24 Aug 2023 10:57:56 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: seabios@seabios.org
Cc: qemu-devel@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 1/6] better kvm detection
Date: Thu, 24 Aug 2023 10:57:51 +0200
Message-ID: <20230824085756.66732-2-kraxel@redhat.com>
In-Reply-To: <20230824085756.66732-1-kraxel@redhat.com>
References: <20230824085756.66732-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In case kvm emulates features of another hypervisor (for example hyperv)
two VMM CPUID blocks will be present, one for the emulated hypervisor
and one for kvm itself.

This patch makes seabios loop over the VMM CPUID blocks to make sure it
will properly detect kvm when multiple blocks are present.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 src/fw/paravirt.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/src/fw/paravirt.c b/src/fw/paravirt.c
index fba4e52db684..42abac8460c5 100644
--- a/src/fw/paravirt.c
+++ b/src/fw/paravirt.c
@@ -53,23 +53,35 @@ inline int qemu_cfg_dma_enabled(void)
  * should be used to determine that a VM is running under KVM.
  */
 #define KVM_CPUID_SIGNATURE     0x40000000
+static unsigned int kvm_cpuid_base = 0;
 
 static void kvm_detect(void)
 {
+    unsigned int i, max = 0;
     unsigned int eax, ebx, ecx, edx;
     char signature[13];
 
-    cpuid(KVM_CPUID_SIGNATURE, &eax, &ebx, &ecx, &edx);
-    memcpy(signature + 0, &ebx, 4);
-    memcpy(signature + 4, &ecx, 4);
-    memcpy(signature + 8, &edx, 4);
-    signature[12] = 0;
+    for (i = KVM_CPUID_SIGNATURE;; i += 0x100) {
+        eax = 0;
+        cpuid(i, &eax, &ebx, &ecx, &edx);
+        if (eax < i)
+            break;
+        memcpy(signature + 0, &ebx, 4);
+        memcpy(signature + 4, &ecx, 4);
+        memcpy(signature + 8, &edx, 4);
+        signature[12] = 0;
+        dprintf(1, "cpuid 0x%x: eax %x, signature '%s'\n", i, eax, signature);
+        if (strcmp(signature, "KVMKVMKVM") == 0) {
+            kvm_cpuid_base = i;
+            max = eax;
+        }
+    }
 
-    if (strcmp(signature, "KVMKVMKVM") == 0) {
+    if (kvm_cpuid_base) {
         dprintf(1, "Running on KVM\n");
         PlatformRunningOn |= PF_KVM;
-        if (eax >= KVM_CPUID_SIGNATURE + 0x10) {
-            cpuid(KVM_CPUID_SIGNATURE + 0x10, &eax, &ebx, &ecx, &edx);
+        if (max >= kvm_cpuid_base + 0x10) {
+            cpuid(kvm_cpuid_base + 0x10, &eax, &ebx, &ecx, &edx);
             dprintf(1, "kvm: have invtsc, freq %u kHz\n", eax);
             tsctimer_setfreq(eax, "invtsc");
         }
@@ -93,7 +105,7 @@ static void kvmclock_init(void)
     if (!runningOnKVM())
         return;
 
-    cpuid(KVM_CPUID_SIGNATURE + 0x01, &eax, &ebx, &ecx, &edx);
+    cpuid(kvm_cpuid_base + 0x01, &eax, &ebx, &ecx, &edx);
     if (eax & (1 <<  KVM_FEATURE_CLOCKSOURCE2))
         msr = MSR_KVM_SYSTEM_TIME_NEW;
     else if (eax & (1 <<  KVM_FEATURE_CLOCKSOURCE))
-- 
2.41.0


