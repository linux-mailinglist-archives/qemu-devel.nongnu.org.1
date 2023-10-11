Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B8A7C599A
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 18:54:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqcSu-0000ls-Q7; Wed, 11 Oct 2023 12:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qqcSp-0000jV-JK; Wed, 11 Oct 2023 12:53:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qqcSn-0001Br-FP; Wed, 11 Oct 2023 12:53:39 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39BFNPnK020958; Wed, 11 Oct 2023 16:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=qUyIFkwbd6e1etfK764hgND3mEq0yYMReIGpdrOoXWg=;
 b=UpvQo1CcXrABu7JftsLSZhYWRzKXugi2I+mcjQyun4UhwOQV45v9PSHCfjGn2ZZ11PeK
 x8/gQog78dd/HDWFb1cEZdIYfhCJtW+OA3AzNMtmJGZ3YRwZoFDT8wWa+CdLVARVCPlG
 tcHgpaCjxqqeJhVH0H/9zLS6zMJg08z5G+/QSQp00zJdDwvnXVORYVO1gh2qLS4tk/Oe
 vDjghVQ8TJyi4Jz6MREKLfFImUs3gD82fMmEiKNowuKqBW1YSLcH0vmEjwTc2sXpKrdN
 HeJqTw/l8qqBP5AaHHDs0kS4HukO94mOysU1TDC8xqB0xl/3qNXnJ0rEALBiUGaNziV8 SQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tnmds9pv5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 16:53:31 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39BGrVGJ002389
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 16:53:31 GMT
Received: from blr-ubuntu-31.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 11 Oct 2023 09:53:27 -0700
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: <peter.maydell@linaro.org>, <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <quic_svaddagi@quicinc.com>, <quic_tsoni@quicinc.com>,
 <quic_pheragu@quicinc.com>, <quic_eberman@quicinc.com>,
 <quic_yvasi@quicinc.com>, <quic_cvanscha@quicinc.com>,
 <quic_mnalajal@quicinc.com>
Subject: [RFC/PATCH v0 10/12] gunyah: CPU execution loop
Date: Wed, 11 Oct 2023 16:52:32 +0000
Message-ID: <20231011165234.1323725-11-quic_svaddagi@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
References: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: HwJ4O6HliuwYfX50nFFjCbnD3XfZh3Yi
X-Proofpoint-GUID: HwJ4O6HliuwYfX50nFFjCbnD3XfZh3Yi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_12,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 mlxlogscore=973
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110148
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Complete the cpu execution loop. At this time, we recognize exits
associated with only MMIO access. Future patches will add support for
recognizing other exit reasons, such as PSCI calls made by guest.

Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
---
 accel/gunyah/gunyah-accel-ops.c |   1 +
 accel/gunyah/gunyah-all.c       | 216 ++++++++++++++++++++++++++++++--
 include/hw/core/cpu.h           |   6 +
 include/sysemu/gunyah.h         |   1 +
 include/sysemu/gunyah_int.h     |   3 +
 target/arm/gunyah.c             |  13 ++
 6 files changed, 229 insertions(+), 11 deletions(-)

diff --git a/accel/gunyah/gunyah-accel-ops.c b/accel/gunyah/gunyah-accel-ops.c
index 77089c4f36..32727e7bf2 100644
--- a/accel/gunyah/gunyah-accel-ops.c
+++ b/accel/gunyah/gunyah-accel-ops.c
@@ -150,6 +150,7 @@ static void gunyah_accel_ops_class_init(ObjectClass *oc, void *data)
 
     ops->create_vcpu_thread = gunyah_start_vcpu_thread;
     ops->kick_vcpu_thread = gunyah_kick_vcpu_thread;
+    ops->synchronize_post_reset = gunyah_cpu_synchronize_post_reset;
 };
 
 static const TypeInfo gunyah_accel_ops_type = {
diff --git a/accel/gunyah/gunyah-all.c b/accel/gunyah/gunyah-all.c
index ea6c74fdc6..edc61e542b 100644
--- a/accel/gunyah/gunyah-all.c
+++ b/accel/gunyah/gunyah-all.c
@@ -25,6 +25,9 @@
 #include "exec/address-spaces.h"
 #include "qapi/error.h"
 #include "qemu/event_notifier.h"
+#include "qemu/main-loop.h"
+#include "sysemu/runstate.h"
+#include "qemu/guest-random.h"
 
 static void gunyah_region_add(MemoryListener *listener,
                            MemoryRegionSection *section);
@@ -69,6 +72,18 @@ int gunyah_vm_ioctl(int type, ...)
     return ioctl(s->vmfd, type, arg);
 }
 
+static int gunyah_vcpu_ioctl(CPUState *cpu, int type, ...)
+{
+    void *arg;
+    va_list ap;
+
+    va_start(ap, type);
+    arg = va_arg(ap, void *);
+    va_end(ap);
+
+    return ioctl(cpu->gunyah.fd, type, arg);
+}
+
 static MemoryListener gunyah_memory_listener = {
     .name = "gunyah",
     .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
@@ -110,17 +125,6 @@ int gunyah_create_vm(void)
     return 0;
 }
 
-void *gunyah_cpu_thread_fn(void *arg)
-{
-    CPUState *cpu = arg;
-
-    do {
-        /* Do nothing */
-    } while (!cpu->unplug || cpu_can_run(cpu));
-
-    return NULL;
-}
-
 #define gunyah_slots_lock(s)    qemu_mutex_lock(&s->slots_lock)
 #define gunyah_slots_unlock(s)  qemu_mutex_unlock(&s->slots_lock)
 
@@ -287,6 +291,11 @@ static void gunyah_set_phys_mem(GUNYAHState *s,
             error_report("Overlapping slot registration not supported!");
             exit(1);
         }
+
+        if (qatomic_read(&s->vm_started)) {
+            error_report("Memory map changes after VM start not supported!");
+            exit(1);
+        }
     }
 
     if (area->readonly ||
@@ -415,3 +424,188 @@ GUNYAHState *get_gunyah_state(void)
 {
     return GUNYAH_STATE(current_accel());
 }
+
+static void gunyah_ipi_signal(int sig)
+{
+    if (current_cpu) {
+        qatomic_set(&current_cpu->gunyah.run->immediate_exit, 1);
+    }
+}
+
+static void gunyah_cpu_kick_self(void)
+{
+    qatomic_set(&current_cpu->gunyah.run->immediate_exit, 1);
+}
+
+static int gunyah_init_vcpu(CPUState *cpu, Error **errp)
+{
+    int ret;
+    struct gh_fn_desc fdesc;
+    struct gh_fn_vcpu_arg vcpu;
+    struct sigaction sigact;
+    sigset_t set;
+
+    /* init cpu signals */
+    memset(&sigact, 0, sizeof(sigact));
+    sigact.sa_handler = gunyah_ipi_signal;
+    sigaction(SIG_IPI, &sigact, NULL);
+
+    pthread_sigmask(SIG_BLOCK, NULL, &set);
+    sigdelset(&set, SIG_IPI);
+
+    ret = pthread_sigmask(SIG_SETMASK, &set, NULL);
+    if (ret) {
+        error_report("pthread_sigmask: %s", strerror(ret));
+        exit(1);
+    }
+
+    vcpu.id = cpu->cpu_index;
+    fdesc.type = GH_FN_VCPU;
+    fdesc.arg_size = sizeof(struct gh_fn_vcpu_arg);
+    fdesc.arg = (__u64)(&vcpu);
+
+    ret = gunyah_vm_ioctl(GH_VM_ADD_FUNCTION, &fdesc);
+    if (ret < 0) {
+        error_report("could not create VCPU %d: %s", vcpu.id, strerror(errno));
+        exit(1);
+    }
+
+    cpu->gunyah.fd = ret;
+    cpu->gunyah.run = mmap(0, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, ret, 0);
+    if (cpu->gunyah.run == MAP_FAILED) {
+        error_report("mmap of vcpu run structure failed : %s", strerror(errno));
+        exit(1);
+    }
+
+    return 0;
+}
+
+static void gunyah_vcpu_destroy(CPUState *cpu)
+{
+    int ret;
+
+    ret = munmap(cpu->gunyah.run, 4096);
+    if (ret < 0) {
+        error_report("munmap of vcpu run structure failed: %s",
+                strerror(errno));
+        exit(1);
+    }
+
+    close(cpu->gunyah.fd);
+}
+
+static int gunyah_vcpu_exec(CPUState *cpu)
+{
+    int ret;
+    GUNYAHState *s = GUNYAH_STATE(current_accel());
+
+    ret = qatomic_cmpxchg(&s->vm_started, 0, 1);
+    if (!ret) {
+        ret = gunyah_vm_ioctl(GH_VM_START);
+        if (ret != 0) {
+            error_report("Failed to start VM: %s", strerror(errno));
+            exit(1);
+        }
+        qatomic_set(&s->vm_started, 1);
+    }
+
+    qemu_mutex_unlock_iothread();
+    cpu_exec_start(cpu);
+
+    do {
+        struct gh_vcpu_run *run = cpu->gunyah.run;
+        int exit_reason, ret;
+
+        if (qatomic_read(&cpu->exit_request)) {
+            gunyah_cpu_kick_self();
+        }
+
+        /* Todo: Check need for smp_rmb() here */
+
+        ret = gunyah_vcpu_ioctl(cpu, GH_VCPU_RUN);
+        if (ret < 0) {
+            if (errno == EINTR || errno == EAGAIN) {
+                qatomic_set(&run->immediate_exit, 0);
+                /* Todo: Check need for smp_wmb() here */
+                ret = EXCP_INTERRUPT;
+                break;
+            }
+
+            error_report("GH_VCPU_RUN: %s", strerror(errno));
+            ret = -1;
+            break;
+        }
+
+        exit_reason = run->exit_reason;
+        switch (exit_reason) {
+        case GH_VCPU_EXIT_MMIO:
+            address_space_rw(&address_space_memory,
+                run->mmio.phys_addr, MEMTXATTRS_UNSPECIFIED,
+                run->mmio.data,
+                run->mmio.len,
+                run->mmio.is_write);
+            break;
+
+        /* Todo: Handle VM shutdown */
+        default:
+            error_report("unhandled exit %d", exit_reason);
+        }
+    } while (ret == 0);
+
+    cpu_exec_end(cpu);
+    qemu_mutex_lock_iothread();
+
+    if (ret < 0) {
+        cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
+        vm_stop(RUN_STATE_INTERNAL_ERROR);
+    }
+
+    qatomic_set(&cpu->exit_request, 0);
+
+    return ret;
+}
+
+void *gunyah_cpu_thread_fn(void *arg)
+{
+    CPUState *cpu = arg;
+
+    rcu_register_thread();
+
+    qemu_mutex_lock_iothread();
+    qemu_thread_get_self(cpu->thread);
+
+    cpu->thread_id = qemu_get_thread_id();
+    cpu->can_do_io = 1;
+    current_cpu = cpu;
+
+    gunyah_init_vcpu(cpu, &error_fatal);
+
+    /* signal CPU creation */
+    cpu_thread_signal_created(cpu);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
+
+    do {
+        if (cpu_can_run(cpu)) {
+            gunyah_vcpu_exec(cpu);
+        }
+        qemu_wait_io_event(cpu);
+    } while (!cpu->unplug || cpu_can_run(cpu));
+
+    gunyah_vcpu_destroy(cpu);
+    cpu_thread_signal_destroyed(cpu);
+    qemu_mutex_unlock_iothread();
+    rcu_unregister_thread();
+    return NULL;
+}
+
+static void do_gunyah_cpu_synchronize_post_reset(CPUState *cpu,
+                                run_on_cpu_data arg)
+{
+    gunyah_arch_put_registers(cpu, 0);
+    cpu->vcpu_dirty = false;
+}
+
+void gunyah_cpu_synchronize_post_reset(CPUState *cpu)
+{
+    run_on_cpu(cpu, do_gunyah_cpu_synchronize_post_reset, RUN_ON_CPU_NULL);
+}
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index fdcbe87352..b3901e134d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -240,6 +240,7 @@ typedef struct SavedIOTLB {
 
 struct KVMState;
 struct kvm_run;
+struct gh_vcpu_run;
 
 /* work queue */
 
@@ -443,6 +444,11 @@ struct CPUState {
 
     /* track IOMMUs whose translations we've cached in the TCG TLB */
     GArray *iommu_notifiers;
+
+    struct {
+        int fd;
+        struct gh_vcpu_run *run;
+    } gunyah;
 };
 
 typedef QTAILQ_HEAD(CPUTailQ, CPUState) CPUTailQ;
diff --git a/include/sysemu/gunyah.h b/include/sysemu/gunyah.h
index f077837437..c96334502b 100644
--- a/include/sysemu/gunyah.h
+++ b/include/sysemu/gunyah.h
@@ -16,6 +16,7 @@
 
 #ifdef NEED_CPU_H
 #include "cpu.h"
+
 #ifdef CONFIG_GUNYAH
 # define CONFIG_GUNYAH_IS_POSSIBLE
 #endif
diff --git a/include/sysemu/gunyah_int.h b/include/sysemu/gunyah_int.h
index dc5b4847a9..92ba0bc9f0 100644
--- a/include/sysemu/gunyah_int.h
+++ b/include/sysemu/gunyah_int.h
@@ -46,6 +46,7 @@ struct GUNYAHState {
     bool preshmem_reserved;
     uint32_t preshmem_size;
     uint32_t nr_irqs;
+    uint32_t vm_started;
 };
 
 int gunyah_create_vm(void);
@@ -53,5 +54,7 @@ int gunyah_vm_ioctl(int type, ...);
 void *gunyah_cpu_thread_fn(void *arg);
 int gunyah_add_irqfd(int irqfd, int label, Error **errp);
 GUNYAHState *get_gunyah_state(void);
+int gunyah_arch_put_registers(CPUState *cs, int level);
+void gunyah_cpu_synchronize_post_reset(CPUState *cpu);
 
 #endif    /* GUNYAH_INT_H */
diff --git a/target/arm/gunyah.c b/target/arm/gunyah.c
index 1521f2d414..06600dbdb7 100644
--- a/target/arm/gunyah.c
+++ b/target/arm/gunyah.c
@@ -122,3 +122,16 @@ void gunyah_arm_fdt_customize(void *fdt, uint64_t mem_base,
         g_free(nodename);
     }
 }
+
+int gunyah_arch_put_registers(CPUState *cs, int level)
+{
+    /*
+     * No support (yet) to set/get vCPU registers. We specify device-tree
+     * location, which is passed on to VM via X0. Image entry point is assumed
+     * to be the beginning of slot containing device-tree, which seems to be
+     * true currently. In future, Gunyah could add API to set boot CPU's
+     * register context.
+     */
+
+    return 0;
+}
-- 
2.25.1


