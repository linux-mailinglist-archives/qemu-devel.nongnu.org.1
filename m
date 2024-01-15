Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B997582D4DB
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 09:04:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPHw8-0006Os-BJ; Mon, 15 Jan 2024 03:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1rPHw6-0006Oj-Kl
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 03:03:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1rPHw4-0006cR-O6
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 03:03:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705305788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ImySdM6rVLcpykjYKF0CY09VSeZgLPq5jeZ421owvpE=;
 b=PJqdhhXPAZ1gWVIKPI9QKmA0Ilj/NkJGCIOklia+hTU7Ylh8jihxlsWAI1s9A8y5U/jGR8
 GeeYqOINjGWNPc1CkzJHRvGrPceXXBRQrMSKr7o58O5Yf31Pabq7RYmjv6QPv1mM2IqBLL
 4rroYRGYkpNtSUI8Nk7JirXMRC8U36c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-W9tPWVHqOrGi1YlGmT-Fng-1; Mon, 15 Jan 2024 03:01:48 -0500
X-MC-Unique: W9tPWVHqOrGi1YlGmT-Fng-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9422388CDCD;
 Mon, 15 Jan 2024 08:01:46 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com
 (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 876AF1121306;
 Mon, 15 Jan 2024 08:01:46 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: qemu-arm@nongnu.org
Cc: Eric Auger <eauger@redhat.com>, Gavin Shan <gshan@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: [PATCH v5] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
Date: Mon, 15 Jan 2024 03:01:44 -0500
Message-Id: <20240115080144.44944-1-shahuang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The KVM_ARM_VCPU_PMU_V3_FILTER provides the ability to let the VMM decide
which PMU events are provided to the guest. Add a new option
`kvm-pmu-filter` as -cpu sub-option to set the PMU Event Filtering.
Without the filter, all PMU events are exposed from host to guest by
default. The usage of the new sub-option can be found from the updated
document (docs/system/arm/cpu-features.rst).

Here is an example shows how to use the PMU Event Filtering, when
we launch a guest by use kvm, add such command line:

  # qemu-system-aarch64 \
        -accel kvm \
        -cpu host,kvm-pmu-filter="D:0x11-0x11"

Since the first action is deny, we have a global allow policy. This
disables the filtering of the cycle counter (event 0x11 being CPU_CYCLES).

And then in guest, use the perf to count the cycle:

  # perf stat sleep 1

   Performance counter stats for 'sleep 1':

              1.22 msec task-clock                       #    0.001 CPUs utilized
                 1      context-switches                 #  820.695 /sec
                 0      cpu-migrations                   #    0.000 /sec
                55      page-faults                      #   45.138 K/sec
   <not supported>      cycles
           1128954      instructions
            227031      branches                         #  186.323 M/sec
              8686      branch-misses                    #    3.83% of all branches

       1.002492480 seconds time elapsed

       0.001752000 seconds user
       0.000000000 seconds sys

As we can see, the cycle counter has been disabled in the guest, but
other pmu events are still work.

Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
---
v4->v5:
  - Change the kvm-pmu-filter as a -cpu sub-option.     [Eric]
  - Comment tweak.                                      [Gavin]
  - Rebase to the latest branch.

v3->v4:
  - Fix the wrong check for pmu_filter_init.            [Sebastian]
  - Fix multiple alignment issue.                       [Gavin]
  - Report error by warn_report() instead of error_report(), and don't use
  abort() since the PMU Event Filter is an add-on and best-effort feature.
                                                        [Gavin]
  - Add several missing {  } for single line of code.   [Gavin]
  - Use the g_strsplit() to replace strtok().           [Gavin]

v2->v3:
  - Improve commits message, use kernel doc wording, add more explaination on
    filter example, fix some typo error.                [Eric]
  - Add g_free() in kvm_arch_set_pmu_filter() to prevent memory leak. [Eric]
  - Add more precise error message report.              [Eric]
  - In options doc, add pmu-filter rely on KVM_ARM_VCPU_PMU_V3_FILTER support in
    KVM.                                                [Eric]

v1->v2:
  - Add more description for allow and deny meaning in 
    commit message.                                     [Sebastian]
  - Small improvement.                                  [Sebastian]

 docs/system/arm/cpu-features.rst | 23 ++++++++++
 include/sysemu/kvm_int.h         |  1 +
 target/arm/cpu.h                 |  3 ++
 target/arm/kvm.c                 | 78 ++++++++++++++++++++++++++++++++
 4 files changed, 105 insertions(+)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index a5fb929243..44a797c50e 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -204,6 +204,29 @@ the list of KVM VCPU features and their descriptions.
   the guest scheduler behavior and/or be exposed to the guest
   userspace.
 
+``kvm-pmu-filter``
+  By default kvm-pmu-filter is disabled. This means that by default all pmu
+  events will be exposed to guest.
+
+  KVM implements PMU Event Filtering to prevent a guest from being able to
+  sample certain events. It depends on the KVM_ARM_VCPU_PMU_V3_FILTER
+  attribute supported in KVM. It has the following format:
+
+  kvm-pmu-filter="{A,D}:start-end[;{A,D}:start-end...]"
+
+  The A means "allow" and D means "deny", start is the first event of the
+  range and the end is the last one. The first registered range defines
+  the global policy(global ALLOW if the first @action is DENY, global DENY
+  if the first @action is ALLOW). The start and end only support hexadecimal
+  format now. For example:
+
+  kvm-pmu-filter="A:0x11-0x11;A:0x23-0x3a;D:0x30-0x30"
+
+  Since the first action is allow, we have a global deny policy. It
+  will allow event 0x11 (The cycle counter), events 0x23 to 0x3a is
+  also allowed except the event 0x30 is denied, and all the other events
+  are disallowed.
+
 TCG VCPU Features
 =================
 
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index fd846394be..8f4601474f 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -120,6 +120,7 @@ struct KVMState
     uint32_t xen_caps;
     uint16_t xen_gnttab_max_frames;
     uint16_t xen_evtchn_max_pirq;
+    char *kvm_pmu_filter;
 };
 
 void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8c3ca2e231..1be7dca4aa 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -971,6 +971,9 @@ struct ArchCPU {
 
     /* KVM steal time */
     OnOffAuto kvm_steal_time;
+
+    /* KVM PMU Filter */
+    char *kvm_pmu_filter;
 #endif /* CONFIG_KVM */
 
     /* Uniprocessor system with MP extensions */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index c5a3183843..413ee2720e 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -495,6 +495,22 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
     ARM_CPU(obj)->kvm_steal_time = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
 }
 
+static char *kvm_pmu_filter_get(Object *obj, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    return g_strdup(cpu->kvm_pmu_filter);
+}
+
+static void kvm_pmu_filter_set(Object *obj, const char *pmu_filter,
+                               Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    g_free(cpu->kvm_pmu_filter);
+    cpu->kvm_pmu_filter = g_strdup(pmu_filter);
+}
+
 /* KVM VCPU properties should be prefixed with "kvm-". */
 void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
 {
@@ -516,6 +532,12 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
                              kvm_steal_time_set);
     object_property_set_description(obj, "kvm-steal-time",
                                     "Set off to disable KVM steal time.");
+
+    object_property_add_str(obj, "kvm-pmu-filter", kvm_pmu_filter_get,
+                            kvm_pmu_filter_set);
+    object_property_set_description(obj, "kvm-pmu-filter",
+                                    "PMU Event Filtering description for "
+                                    "guest PMU. (default: NULL, disabled)");
 }
 
 bool kvm_arm_pmu_supported(void)
@@ -1705,6 +1727,60 @@ static bool kvm_arm_set_device_attr(ARMCPU *cpu, struct kvm_device_attr *attr,
     return true;
 }
 
+static void kvm_arm_pmu_filter_init(ARMCPU *cpu)
+{
+    static bool pmu_filter_init;
+    struct kvm_pmu_event_filter filter;
+    struct kvm_device_attr attr = {
+        .group      = KVM_ARM_VCPU_PMU_V3_CTRL,
+        .attr       = KVM_ARM_VCPU_PMU_V3_FILTER,
+        .addr       = (uint64_t)&filter,
+    };
+    int i;
+    gchar **event_filters;
+
+    if (!cpu->kvm_pmu_filter) {
+        return;
+    }
+    if (kvm_vcpu_ioctl(CPU(cpu), KVM_HAS_DEVICE_ATTR, &attr)) {
+        warn_report("The KVM doesn't support the PMU Event Filter!");
+        return;
+    }
+
+    /*
+     * The filter only needs to be initialized through one vcpu ioctl and it
+     * will affect all other vcpu in the vm.
+     */
+    if (pmu_filter_init) {
+        return;
+    } else {
+        pmu_filter_init = true;
+    }
+
+    event_filters = g_strsplit(cpu->kvm_pmu_filter, ";", -1);
+    for (i = 0; event_filters[i]; i++) {
+        unsigned short start = 0, end = 0;
+        char act;
+
+        sscanf(event_filters[i], "%c:%hx-%hx", &act, &start, &end);
+        if ((act != 'A' && act != 'D') || (!start && !end)) {
+            warn_report("Skipping invalid PMU filter %s", event_filters[i]);
+            continue;
+        }
+
+        filter.base_event = start;
+        filter.nevents = end - start + 1;
+        filter.action = (act == 'A') ? KVM_PMU_EVENT_ALLOW :
+                                       KVM_PMU_EVENT_DENY;
+
+        if (!kvm_arm_set_device_attr(cpu, &attr, "PMU Event Filter")) {
+            break;
+        }
+    }
+
+    g_strfreev(event_filters);
+}
+
 void kvm_arm_pmu_init(ARMCPU *cpu)
 {
     struct kvm_device_attr attr = {
@@ -1715,6 +1791,8 @@ void kvm_arm_pmu_init(ARMCPU *cpu)
     if (!cpu->has_pmu) {
         return;
     }
+
+    kvm_arm_pmu_filter_init(cpu);
     if (!kvm_arm_set_device_attr(cpu, &attr, "PMU")) {
         error_report("failed to init PMU");
         abort();
-- 
2.40.1


