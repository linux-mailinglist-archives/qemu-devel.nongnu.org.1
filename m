Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4609743815
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 11:19:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFAGn-0002Ge-7Y; Fri, 30 Jun 2023 05:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qFAGk-0002G6-Tz; Fri, 30 Jun 2023 05:18:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qFAGj-00028N-1K; Fri, 30 Jun 2023 05:18:22 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35U9Hc7U029572; Fri, 30 Jun 2023 09:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ohfe0OXnIKRQjDDHWNvjJtNRg7k6re2tWFFw40vsjC4=;
 b=l83jE836UGXtd0Fd35a6mf4EPSZB53FcYeorzGwfs71mWCIDM99dlitGi8HZlSMqzWmA
 hGROdbiQrda0EwiQ/KiYMaCyiWytUgSoIubJRM/ro08m5H+QBDqJfdSvLyy+9eOTt5SP
 UZw46ZqdgLR1jDwRbCMk66dmX29703I42IS1YuZUTziyF3QiV99HuePrLOvoMWG24Q7H
 Fg9y8pqoLMGyfJID9k6HEynRL/BK3X+jStZ989pA8teva3/4Dme5ko334hidZ/RmBgE4
 GHJ6q5Tp5OrZYWchWc4/C82gAh3KqCip41Mnx3lZmRzYqa74r/CwOpV9fHBozbE1jsKf bA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhv9kg0qm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 09:18:10 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35U9HtLv030913;
 Fri, 30 Jun 2023 09:18:10 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhv9kg0ny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 09:18:10 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35U2qeHI027568;
 Fri, 30 Jun 2023 09:18:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rdr4542da-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 09:18:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35U9I10H31785366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 09:18:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D66FB2004B;
 Fri, 30 Jun 2023 09:18:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A23220049;
 Fri, 30 Jun 2023 09:18:00 +0000 (GMT)
Received: from li-c6ac47cc-293c-11b2-a85c-d421c8e4747b.ibm.com.com (unknown
 [9.171.38.86]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jun 2023 09:18:00 +0000 (GMT)
From: Pierre Morel <pmorel@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, thuth@redhat.com,
 cohuck@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 kvm@vger.kernel.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com,
 eblake@redhat.com, armbru@redhat.com, seiden@linux.ibm.com,
 nrb@linux.ibm.com, nsg@linux.ibm.com, frankja@linux.ibm.com,
 berrange@redhat.com, clg@kaod.org
Subject: [PATCH v21 05/20] s390x/cpu topology: resetting the
 Topology-Change-Report
Date: Fri, 30 Jun 2023 11:17:37 +0200
Message-Id: <20230630091752.67190-6-pmorel@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230630091752.67190-1-pmorel@linux.ibm.com>
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ep8bzUxbMh64K6HLNUtHqtO_kcaKKG1g
X-Proofpoint-GUID: lR1GQDEaoE17BkYp_N-iOBUO4_o9kAYN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015 mlxscore=0
 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306300076
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pmorel@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

During a subsystem reset the Topology-Change-Report is cleared
by the machine.
Let's ask KVM to clear the Modified Topology Change Report (MTCR)
bit of the SCA in the case of a subsystem reset.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/cpu-topology.h |  1 +
 target/s390x/cpu.h              |  1 +
 target/s390x/kvm/kvm_s390x.h    |  1 +
 hw/s390x/cpu-topology.c         | 11 +++++++++++
 hw/s390x/s390-virtio-ccw.c      |  3 +++
 target/s390x/cpu-sysemu.c       | 13 +++++++++++++
 target/s390x/kvm/kvm.c          | 17 +++++++++++++++++
 7 files changed, 47 insertions(+)

diff --git a/include/hw/s390x/cpu-topology.h b/include/hw/s390x/cpu-topology.h
index 193b33a2fc..ca7e9a22f2 100644
--- a/include/hw/s390x/cpu-topology.h
+++ b/include/hw/s390x/cpu-topology.h
@@ -58,6 +58,7 @@ static inline void s390_topology_setup_cpu(MachineState *ms,
 #endif
 
 extern S390Topology s390_topology;
+void s390_topology_reset(void);
 
 static inline int s390_std_socket(int n, CpuTopology *smp)
 {
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 6e7d041b01..f236750cc5 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -654,6 +654,7 @@ typedef struct SysIBTl_cpu {
 QEMU_BUILD_BUG_ON(sizeof(SysIBTl_cpu) != 16);
 
 void insert_stsi_15_1_x(S390CPU *cpu, int sel2, uint64_t addr, uint8_t ar);
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
index ca1634d0ce..764ff92573 100644
--- a/hw/s390x/cpu-topology.c
+++ b/hw/s390x/cpu-topology.c
@@ -92,6 +92,17 @@ static void s390_topology_init(MachineState *ms)
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
index 1dac9d5073..789b87f7aa 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -123,6 +123,9 @@ static void subsystem_reset(void)
             device_cold_reset(dev);
         }
     }
+    if (s390_has_topology()) {
+        s390_topology_reset();
+    }
 }
 
 static int virtio_ccw_hcall_notify(const uint64_t *args)
diff --git a/target/s390x/cpu-sysemu.c b/target/s390x/cpu-sysemu.c
index 97d6c760a8..a8e2552ef4 100644
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
index 5ea358cbb0..bc953151ce 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2592,6 +2592,23 @@ int kvm_s390_get_zpci_op(void)
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
2.31.1


