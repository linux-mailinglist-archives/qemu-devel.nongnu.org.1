Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 042BE7D0791
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 07:22:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qthwj-0003FW-8c; Fri, 20 Oct 2023 01:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qthwc-0003Ed-TJ
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 01:21:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qthwb-0003o9-8L
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 01:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697779268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A1XM82wsPRSTb9efy3pyxezSU9H04wZmejdvHDWCzaA=;
 b=hnhzreSi4lHN1B8jZZjIbuOuIUQrt2ZaKawVohB83kXZ4rynoYvT+brQRzCjSicWuBSKdF
 KXkv9FmpFmbISSCeR0e1gz5euLrBZGKtAGRWu8pW9PP5+iZywCHK0rS+2WYoDySMdLDCLF
 DN//ZotxXM02SfrJ36M7Dx8YQQlPcUM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-afs5ZSODOTS1AdxN2uSGgg-1; Fri, 20 Oct 2023 01:21:00 -0400
X-MC-Unique: afs5ZSODOTS1AdxN2uSGgg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99CC387A9F6;
 Fri, 20 Oct 2023 05:20:59 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A5C28B9;
 Fri, 20 Oct 2023 05:20:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL 06/24] s390x/cpu topology: resetting the Topology-Change-Report
Date: Fri, 20 Oct 2023 07:20:55 +0200
Message-ID: <20231020052055.519460-3-thuth@redhat.com>
In-Reply-To: <20231020052055.519460-1-thuth@redhat.com>
References: <20231020052055.519460-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Pierre Morel <pmorel@linux.ibm.com>

During a subsystem reset the Topology-Change-Report is cleared
by the machine.
Let's ask KVM to clear the Modified Topology Change Report (MTCR)
bit of the SCA in the case of a subsystem reset.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Message-ID: <20231016183925.2384704-7-nsg@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/cpu-topology.h |  6 ++++++
 target/s390x/cpu.h              |  1 +
 target/s390x/kvm/kvm_s390x.h    |  1 +
 hw/s390x/cpu-topology.c         | 11 +++++++++++
 hw/s390x/s390-virtio-ccw.c      |  3 +++
 target/s390x/cpu-sysemu.c       | 13 +++++++++++++
 target/s390x/kvm/kvm.c          | 17 +++++++++++++++++
 7 files changed, 52 insertions(+)

diff --git a/include/hw/s390x/cpu-topology.h b/include/hw/s390x/cpu-topology.h
index 85499fea3e..c064f427e9 100644
--- a/include/hw/s390x/cpu-topology.h
+++ b/include/hw/s390x/cpu-topology.h
@@ -45,6 +45,7 @@ typedef QTAILQ_HEAD(, S390TopologyEntry) S390TopologyList;
 #ifdef CONFIG_KVM
 bool s390_has_topology(void);
 void s390_topology_setup_cpu(MachineState *ms, S390CPU *cpu, Error **errp);
+void s390_topology_reset(void);
 #else
 static inline bool s390_has_topology(void)
 {
@@ -53,6 +54,11 @@ static inline bool s390_has_topology(void)
 static inline void s390_topology_setup_cpu(MachineState *ms,
                                            S390CPU *cpu,
                                            Error **errp) {}
+static inline void s390_topology_reset(void)
+{
+    /* Unreachable, CPU topology not implemented for TCG */
+    assert(false);
+}
 #endif
 
 extern S390Topology s390_topology;
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 09bff39fe4..40c5cedd0e 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -654,6 +654,7 @@ typedef struct SysIBCPUListEntry {
 QEMU_BUILD_BUG_ON(sizeof(SysIBCPUListEntry) != 16);
 
 void insert_stsi_15_1_x(S390CPU *cpu, int sel2, uint64_t addr, uint8_t ar, uintptr_t ra);
+void s390_cpu_topology_set_changed(bool changed);
 
 /* MMU defines */
 #define ASCE_ORIGIN           (~0xfffULL) /* segment table origin             */
diff --git a/target/s390x/kvm/kvm_s390x.h b/target/s390x/kvm/kvm_s390x.h
index f9785564d0..649dae5948 100644
--- a/target/s390x/kvm/kvm_s390x.h
+++ b/target/s390x/kvm/kvm_s390x.h
@@ -47,5 +47,6 @@ void kvm_s390_crypto_reset(void);
 void kvm_s390_restart_interrupt(S390CPU *cpu);
 void kvm_s390_stop_interrupt(S390CPU *cpu);
 void kvm_s390_set_diag318(CPUState *cs, uint64_t diag318_info);
+int kvm_s390_topology_set_mtcr(uint64_t attr);
 
 #endif /* KVM_S390X_H */
diff --git a/hw/s390x/cpu-topology.c b/hw/s390x/cpu-topology.c
index 13168341b6..7ec9319272 100644
--- a/hw/s390x/cpu-topology.c
+++ b/hw/s390x/cpu-topology.c
@@ -90,6 +90,17 @@ static void s390_topology_init(MachineState *ms)
                                             smp->books * smp->drawers);
 }
 
+/**
+ * s390_topology_reset:
+ *
+ * Generic reset for CPU topology, calls s390_topology_reset()
+ * to reset the kernel Modified Topology Change Record.
+ */
+void s390_topology_reset(void)
+{
+    s390_cpu_topology_set_changed(false);
+}
+
 /**
  * s390_topology_cpu_default:
  * @cpu: pointer to a S390CPU
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 7fe2bce20c..6012165d41 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -124,6 +124,9 @@ static void subsystem_reset(void)
             device_cold_reset(dev);
         }
     }
+    if (s390_has_topology()) {
+        s390_topology_reset();
+    }
 }
 
 static int virtio_ccw_hcall_notify(const uint64_t *args)
diff --git a/target/s390x/cpu-sysemu.c b/target/s390x/cpu-sysemu.c
index 8112561e5e..1cd30c1d84 100644
--- a/target/s390x/cpu-sysemu.c
+++ b/target/s390x/cpu-sysemu.c
@@ -307,3 +307,16 @@ void s390_do_cpu_set_diag318(CPUState *cs, run_on_cpu_data arg)
         kvm_s390_set_diag318(cs, arg.host_ulong);
     }
 }
+
+void s390_cpu_topology_set_changed(bool changed)
+{
+    int ret;
+
+    if (kvm_enabled()) {
+        ret = kvm_s390_topology_set_mtcr(changed);
+        if (ret) {
+            error_report("Failed to set Modified Topology Change Report: %s",
+                         strerror(-ret));
+        }
+    }
+}
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 53d6300809..d6bda3a2a8 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2664,6 +2664,23 @@ int kvm_s390_get_zpci_op(void)
     return cap_zpci_op;
 }
 
+int kvm_s390_topology_set_mtcr(uint64_t attr)
+{
+    struct kvm_device_attr attribute = {
+        .group = KVM_S390_VM_CPU_TOPOLOGY,
+        .attr  = attr,
+    };
+
+    if (!s390_has_feat(S390_FEAT_CONFIGURATION_TOPOLOGY)) {
+        return 0;
+    }
+    if (!kvm_vm_check_attr(kvm_state, KVM_S390_VM_CPU_TOPOLOGY, attr)) {
+        return -ENOTSUP;
+    }
+
+    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attribute);
+}
+
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
-- 
2.41.0


