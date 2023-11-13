Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C53E7E977A
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 09:18:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2S8t-0004Tm-Mi; Mon, 13 Nov 2023 03:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1r2S8r-0004TI-O7
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 03:17:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1r2S8q-0007Db-2V
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 03:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699863475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=q42X0BrKYlxA1k6mvCtM7nD6PBtAE2gh+Zb8mj4NqmM=;
 b=Rjne0zwFr+INK5DxYDDlM7aqgv88We1A/q99s4W+mKIYHfx+afJYI+T/SZt08wy519J27U
 f+2nozHGP1zQfizg9lFtMYw+or/RzUaSWOCPserbmJSqDjtu7HBrWgXtbrRcbl8ORG4G3k
 X0zCDqT2BEndHXs2JC7ochREe3YqRoo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-tb-QDpZDOFuZcXOUGt6lPA-1; Mon,
 13 Nov 2023 03:17:51 -0500
X-MC-Unique: tb-QDpZDOFuZcXOUGt6lPA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97A843813BC4;
 Mon, 13 Nov 2023 08:17:51 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com
 (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 837A22026D4C;
 Mon, 13 Nov 2023 08:17:51 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: qemu-arm@nongnu.org
Cc: eric.auger@redhat.com, Shaoqin Huang <shahuang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v1] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
Date: Mon, 13 Nov 2023 03:17:13 -0500
Message-Id: <20231113081713.153615-1-shahuang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The KVM_ARM_VCPU_PMU_V3_FILTER provide the ability to let the VMM decide
which PMU events are provided to the guest. Add a new option
`pmu-filter` as -accel sub-option to set the PMU Event Filtering.

The `pmu-filter` has such format:

  pmu-filter="{A,D}:start-end[;{A,D}:start-end...]"

The A means "allow" and D means "deny", start if the first event of the
range and the end is the last one. For example:

  pmu-filter="A:0x11-0x11;A:0x23-0x3a,D:0x30-0x30"

This will allow event 0x11 (The cycle counter), events 0x23 to 0x3a is
also allowed except the event 0x30 is denied, and all the other events
are disallowed.

Here is an real example shows how to use the PMU Event Filtering, when
we launch a guest by use kvm, add such command line:

  # qemu-system-aarch64 \
	-accel kvm,pmu-filter="D:0x11-0x11"

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
 include/sysemu/kvm_int.h |  1 +
 qemu-options.hx          | 16 +++++++++++++
 target/arm/kvm.c         | 22 ++++++++++++++++++
 target/arm/kvm64.c       | 49 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+)

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
diff --git a/qemu-options.hx b/qemu-options.hx
index 42fd09e4de..dd3518092c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -187,6 +187,7 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "                tb-size=n (TCG translation block cache size)\n"
     "                dirty-ring-size=n (KVM dirty ring GFN count, default 0)\n"
     "                eager-split-size=n (KVM Eager Page Split chunk size, default 0, disabled. ARM only)\n"
+    "                pmu-filter={A,D}:start-end[;...] (KVM PMU Event Filter, default no filter. ARM only)\n"
     "                notify-vmexit=run|internal-error|disable,notify-window=n (enable notify VM exit and set notify window, x86 only)\n"
     "                thread=single|multi (enable multi-threaded TCG)\n", QEMU_ARCH_ALL)
 SRST
@@ -259,6 +260,21 @@ SRST
         impact on the memory. By default, this feature is disabled
         (eager-split-size=0).
 
+    ``pmu-filter={A,D}:start-end[;...]``
+        KVM implements pmu event filtering to prevent a guest from being able to
+	sample certain events. It has the following format:
+
+	pmu-filter="{A,D}:start-end[;{A,D}:start-end...]"
+
+	The A means "allow" and D means "deny", start if the first event of the
+	range and the end is the last one. For example:
+
+	pmu-filter="A:0x11-0x11;A:0x23-0x3a,D:0x30-0x30"
+
+	This will allow event 0x11 (The cycle counter), events 0x23 to 0x3a is
+	also allowed except the event 0x30 is denied, and all the other events
+	are disallowed.
+
     ``notify-vmexit=run|internal-error|disable,notify-window=n``
         Enables or disables notify VM exit support on x86 host and specify
         the corresponding notify window to trigger the VM exit if enabled.
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 7903e2ddde..74796de055 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1108,6 +1108,21 @@ static void kvm_arch_set_eager_split_size(Object *obj, Visitor *v,
     s->kvm_eager_split_size = value;
 }
 
+static char *kvm_arch_get_pmu_filter(Object *obj, Error **errp)
+{
+    KVMState *s = KVM_STATE(obj);
+
+    return g_strdup(s->kvm_pmu_filter);
+}
+
+static void kvm_arch_set_pmu_filter(Object *obj, const char *pmu_filter,
+                                    Error **errp)
+{
+    KVMState *s = KVM_STATE(obj);
+
+    s->kvm_pmu_filter = g_strdup(pmu_filter);
+}
+
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
     object_class_property_add(oc, "eager-split-size", "size",
@@ -1116,4 +1131,11 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
 
     object_class_property_set_description(oc, "eager-split-size",
         "Eager Page Split chunk size for hugepages. (default: 0, disabled)");
+
+    object_class_property_add_str(oc, "pmu-filter",
+                                  kvm_arch_get_pmu_filter,
+                                  kvm_arch_set_pmu_filter);
+
+    object_class_property_set_description(oc, "pmu-filter",
+        "PMU Event Filtering description for guest pmu. (default: NULL, disabled)");
 }
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 3c175c93a7..ce03b22312 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include <asm-arm64/kvm.h>
 #include <sys/ioctl.h>
 #include <sys/ptrace.h>
 
@@ -131,16 +132,64 @@ static bool kvm_arm_set_device_attr(CPUState *cs, struct kvm_device_attr *attr,
     return true;
 }
 
+static void kvm_arm_pmu_filter_init(CPUState *cs)
+{
+    struct kvm_pmu_event_filter filter;
+    struct kvm_device_attr attr = {
+        .group      = KVM_ARM_VCPU_PMU_V3_CTRL,
+        .attr       = KVM_ARM_VCPU_PMU_V3_FILTER,
+    };
+    KVMState *kvm_state = cs->kvm_state;
+    char *tmp;
+    char *str, act;
+
+    if (!kvm_state->kvm_pmu_filter)
+        return;
+
+    tmp = g_strdup(kvm_state->kvm_pmu_filter);
+
+    for (str = strtok(tmp, ";"); str != NULL; str = strtok(NULL, ";")) {
+        unsigned short start = 0, end = 0;
+
+        sscanf(str, "%c:%hx-%hx", &act, &start, &end);
+        if ((act != 'A' && act != 'D') || (!start && !end)) {
+            error_report("skipping invalid filter %s\n", str);
+            continue;
+        }
+
+        filter = (struct kvm_pmu_event_filter) {
+            .base_event     = start,
+            .nevents        = end - start + 1,
+            .action         = act == 'A' ? KVM_PMU_EVENT_ALLOW :
+                                           KVM_PMU_EVENT_DENY,
+        };
+
+        attr.addr = (uint64_t)&filter;
+        if (!kvm_arm_set_device_attr(cs, &attr, "PMU Event Filter")) {
+            error_report("Failed to init PMU Event Filter\n");
+            abort();
+        }
+    }
+
+    g_free(tmp);
+}
+
 void kvm_arm_pmu_init(CPUState *cs)
 {
     struct kvm_device_attr attr = {
         .group = KVM_ARM_VCPU_PMU_V3_CTRL,
         .attr = KVM_ARM_VCPU_PMU_V3_INIT,
     };
+    static bool pmu_filter_init = false;
 
     if (!ARM_CPU(cs)->has_pmu) {
         return;
     }
+    if (!pmu_filter_init) {
+        kvm_arm_pmu_filter_init(cs);
+        pmu_filter_init = true;
+    }
+
     if (!kvm_arm_set_device_attr(cs, &attr, "PMU")) {
         error_report("failed to init PMU");
         abort();
-- 
2.40.1


