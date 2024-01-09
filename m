Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB828282AC
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 10:03:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN7zb-0007wC-UM; Tue, 09 Jan 2024 04:01:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1rN7zO-0007vu-OP; Tue, 09 Jan 2024 04:01:38 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1rN7zM-0003d7-Gt; Tue, 09 Jan 2024 04:01:38 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4096Ivn8002203; Tue, 9 Jan 2024 09:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=QXcESR7lil4F97hbtdqsuTdH30F3JZRqRBmUFs97KDc=; b=Kt
 ayLad+++MPEdnblr0pCuMThRoWanO5PsFNNeU1fGAJtXJjPNCL41oFqVQBVgH4m0
 2XeLuCsQHcdXDWqEi4MF5T21diL8bsrWTbxPfO9SY///xQ1smF612hp6Jur3zPqg
 ugK0w7iCb9slihIRVkuRsGEKJtojiUMWm9PDjxV7kNaVvdO4fOBBNQk6+cFf0LsU
 pQ15tw+T9M7YukfWgh3Tftj86d6gBybmoJ9GFlgETpt2l/gx3soUS/R3kZItppAD
 gUKOFlNvGwq0qcVeL7ItV6onGHQaga5M+8gquJljPDXyFlz286NBnQ0ZrshXPN4H
 uHR6HZtQJxLPmBPwPDQg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgw1k0nxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 09:01:34 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40991Xef003270
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 9 Jan 2024 09:01:33 GMT
Received: from blr-ubuntu-31.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 01:01:28 -0800
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: <peter.maydell@linaro.org>, <philmd@linaro.org>, <alex.bennee@linaro.org>, 
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <quic_svaddagi@quicinc.com>, <quic_tsoni@quicinc.com>,
 <quic_pheragu@quicinc.com>, <quic_eberman@quicinc.com>,
 <quic_yvasi@quicinc.com>, <quic_cvanscha@quicinc.com>,
 <quic_mnalajal@quicinc.com>
Subject: [RFC/PATCH v1 09/11] gunyah: CPU execution loop
Date: Tue, 9 Jan 2024 09:00:37 +0000
Message-ID: <20240109090039.1636383-10-quic_svaddagi@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240109090039.1636383-1-quic_svaddagi@quicinc.com>
References: <20240109090039.1636383-1-quic_svaddagi@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: Ygjc9xBnNsLPP85Gy8jd9ffXAvAUomOA
X-Proofpoint-ORIG-GUID: Ygjc9xBnNsLPP85Gy8jd9ffXAvAUomOA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=661
 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090070
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 accel/gunyah/gunyah-accel-ops.c |   7 ++
 accel/gunyah/gunyah-all.c       | 201 +++++++++++++++++++++++++++++++-
 include/hw/core/cpu.h           |   1 +
 include/sysemu/gunyah_int.h     |   9 ++
 target/arm/gunyah.c             |  13 +++
 5 files changed, 230 insertions(+), 1 deletion(-)

diff --git a/accel/gunyah/gunyah-accel-ops.c b/accel/gunyah/gunyah-accel-ops.c
index fe732a1d47..a13b1c8cb5 100644
--- a/accel/gunyah/gunyah-accel-ops.c
+++ b/accel/gunyah/gunyah-accel-ops.c
@@ -91,6 +91,11 @@ static void gunyah_set_protected_vm(Object *obj, bool value, Error **errp)
     s->is_protected_vm = value;
 }
 
+static void gunyah_setup_post(MachineState *ms, AccelState *accel)
+{
+    gunyah_start_vm();
+}
+
 static void gunyah_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -98,6 +103,7 @@ static void gunyah_accel_class_init(ObjectClass *oc, void *data)
     ac->name = "GUNYAH";
     ac->init_machine = gunyah_init;
     ac->allowed = &gunyah_allowed;
+    ac->setup_post = gunyah_setup_post;
 
     object_class_property_add_bool(oc, "protected-vm",
                     gunyah_get_protected_vm, gunyah_set_protected_vm);
@@ -156,6 +162,7 @@ static void gunyah_accel_ops_class_init(ObjectClass *oc, void *data)
     ops->create_vcpu_thread = gunyah_start_vcpu_thread;
     ops->kick_vcpu_thread = gunyah_kick_vcpu_thread;
     ops->cpu_thread_is_idle = gunyah_vcpu_thread_is_idle;
+    ops->synchronize_post_reset = gunyah_cpu_synchronize_post_reset;
 };
 
 static const TypeInfo gunyah_accel_ops_type = {
diff --git a/accel/gunyah/gunyah-all.c b/accel/gunyah/gunyah-all.c
index 4e4a2b89db..3eeecfd286 100644
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
+    return ioctl(cpu->accel->fd, type, arg);
+}
+
 static MemoryListener gunyah_memory_listener = {
     .name = "gunyah",
     .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
@@ -276,6 +291,11 @@ static void gunyah_set_phys_mem(GUNYAHState *s,
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
@@ -405,13 +425,192 @@ GUNYAHState *get_gunyah_state(void)
     return GUNYAH_STATE(current_accel());
 }
 
+static void gunyah_ipi_signal(int sig)
+{
+    if (current_cpu) {
+        qatomic_set(&current_cpu->accel->run->immediate_exit, 1);
+    }
+}
+
+static void gunyah_cpu_kick_self(void)
+{
+    qatomic_set(&current_cpu->accel->run->immediate_exit, 1);
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
+    cpu->accel = g_new0(AccelCPUState, 1);
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
+    cpu->accel->fd = ret;
+    cpu->accel->run = mmap(0, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, ret, 0);
+    if (cpu->accel->run == MAP_FAILED) {
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
+    ret = munmap(cpu->accel->run, 4096);
+    if (ret < 0) {
+        error_report("munmap of vcpu run structure failed: %s",
+                strerror(errno));
+        exit(1);
+    }
+
+    close(cpu->accel->fd);
+    g_free(cpu->accel);
+}
+
+void gunyah_start_vm(void)
+{
+    int ret;
+    GUNYAHState *s = GUNYAH_STATE(current_accel());
+
+    ret = gunyah_vm_ioctl(GH_VM_START);
+    if (ret != 0) {
+        error_report("Failed to start VM: %s", strerror(errno));
+        exit(1);
+    }
+    qatomic_set(&s->vm_started, 1);
+}
+
+static int gunyah_vcpu_exec(CPUState *cpu)
+{
+    int ret;
+
+    qemu_mutex_unlock_iothread();
+    cpu_exec_start(cpu);
+
+    do {
+        struct gh_vcpu_run *run = cpu->accel->run;
+        int exit_reason;
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
 void *gunyah_cpu_thread_fn(void *arg)
 {
     CPUState *cpu = arg;
 
+    rcu_register_thread();
+
+    qemu_mutex_lock_iothread();
+    qemu_thread_get_self(cpu->thread);
+
+    cpu->thread_id = qemu_get_thread_id();
+    cpu->neg.can_do_io = true;
+    current_cpu = cpu;
+
+    gunyah_init_vcpu(cpu, &error_fatal);
+
+    /* signal CPU creation */
+    cpu_thread_signal_created(cpu);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
+
     do {
-        /* Do nothing */
+        if (cpu_can_run(cpu)) {
+            gunyah_vcpu_exec(cpu);
+        }
+        qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
+    gunyah_vcpu_destroy(cpu);
+    cpu_thread_signal_destroyed(cpu);
+    qemu_mutex_unlock_iothread();
+    rcu_unregister_thread();
     return NULL;
 }
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
index 238c02c05e..ef248a658b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -371,6 +371,7 @@ struct CPUWatchpoint {
 
 struct KVMState;
 struct kvm_run;
+struct gh_vcpu_run;
 
 /* work queue */
 
diff --git a/include/sysemu/gunyah_int.h b/include/sysemu/gunyah_int.h
index dc5b4847a9..72b3027e4e 100644
--- a/include/sysemu/gunyah_int.h
+++ b/include/sysemu/gunyah_int.h
@@ -46,12 +46,21 @@ struct GUNYAHState {
     bool preshmem_reserved;
     uint32_t preshmem_size;
     uint32_t nr_irqs;
+    uint32_t vm_started;
+};
+
+struct AccelCPUState {
+    int fd;
+    struct gh_vcpu_run *run;
 };
 
 int gunyah_create_vm(void);
+void gunyah_start_vm(void);
 int gunyah_vm_ioctl(int type, ...);
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


