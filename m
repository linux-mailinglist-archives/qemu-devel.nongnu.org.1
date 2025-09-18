Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA7EB1DA1B
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Aug 2025 16:42:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk1ou-0000aT-Sd; Thu, 07 Aug 2025 10:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uk1ny-00087p-2V
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:41:21 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uk1nt-0000ym-D2
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:41:15 -0400
Received: from localhost.localdomain (unknown [167.220.208.72])
 by linux.microsoft.com (Postfix) with ESMTPSA id 660E1201BC80;
 Thu,  7 Aug 2025 07:41:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 660E1201BC80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1754577671;
 bh=b7tC7gDlv9eoDsfEjV42zWzz1JAtDIgUDIp1t+YjR2E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ADg2DZjfB61Nn8rBxg5zS9WCRdI6xlRIhqmg7sDXcx3uPrZoMY2HYiXRMPieQ71Gv
 NB4P4UVECNj36QKcBjTnNHnw09xmA68lSyaAxB0Sw7N9degx6fjmrLpYg0JthOi9pk
 cXvaYMCPG+zoxSkN103SHWCgdZKJvzY89R72O6wg=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 10/26] accel/mshv: Add vCPU creation and execution loop
Date: Thu,  7 Aug 2025 16:39:35 +0200
Message-Id: <20250807143951.1154713-11-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Create MSHV vCPUs using MSHV_CREATE_VP and initialize their state.
Register the MSHV CPU execution loop loop with the QEMU accelerator
framework to enable guest code execution.

The target/i386 functionality is still mostly stubbed out and will be
populated in a later commit in this series.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c       | 187 +++++++++++++++++++++++++++++++++---
 accel/mshv/trace-events     |   2 +
 include/system/mshv.h       |  17 ++++
 target/i386/mshv/mshv-cpu.c |  63 ++++++++++++
 4 files changed, 257 insertions(+), 12 deletions(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 54c32d6252..a4eeaeec76 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -391,6 +391,24 @@ int mshv_hvcall(int vm_fd, const struct mshv_root_hvcall *args)
     return ret;
 }
 
+static int mshv_init_vcpu(CPUState *cpu)
+{
+    int vm_fd = mshv_state->vm;
+    uint8_t vp_index = cpu->cpu_index;
+    int ret;
+
+    mshv_arch_init_vcpu(cpu);
+    cpu->accel = g_new0(AccelCPUState, 1);
+
+    ret = mshv_create_vcpu(vm_fd, vp_index, &cpu->accel->cpufd);
+    if (ret < 0) {
+        return -1;
+    }
+
+    cpu->accel->dirty = true;
+
+    return 0;
+}
 
 static int mshv_init(AccelState *as, MachineState *ms)
 {
@@ -413,6 +431,8 @@ static int mshv_init(AccelState *as, MachineState *ms)
         return -1;
     }
 
+    mshv_init_cpu_logic();
+
     mshv_init_msicontrol();
 
     ret = create_vm(mshv_fd, &vm_fd);
@@ -442,40 +462,183 @@ static int mshv_init(AccelState *as, MachineState *ms)
     return 0;
 }
 
+static int mshv_destroy_vcpu(CPUState *cpu)
+{
+    int cpu_fd = mshv_vcpufd(cpu);
+    int vm_fd = mshv_state->vm;
+
+    mshv_remove_vcpu(vm_fd, cpu_fd);
+    mshv_vcpufd(cpu) = 0;
+
+    mshv_arch_destroy_vcpu(cpu);
+    g_free(cpu->accel);
+    return 0;
+}
+
+static int mshv_cpu_exec(CPUState *cpu)
+{
+    hv_message mshv_msg;
+    enum MshvVmExit exit_reason;
+    int ret = 0;
+
+    bql_unlock();
+    cpu_exec_start(cpu);
+
+    do {
+        if (cpu->accel->dirty) {
+            ret = mshv_arch_put_registers(cpu);
+            if (ret) {
+                error_report("Failed to put registers after init: %s",
+                              strerror(-ret));
+                ret = -1;
+                break;
+            }
+            cpu->accel->dirty = false;
+        }
+
+        ret = mshv_run_vcpu(mshv_state->vm, cpu, &mshv_msg, &exit_reason);
+        if (ret < 0) {
+            error_report("Failed to run on vcpu %d", cpu->cpu_index);
+            abort();
+        }
+
+        switch (exit_reason) {
+        case MshvVmExitIgnore:
+            break;
+        default:
+            ret = EXCP_INTERRUPT;
+            break;
+        }
+    } while (ret == 0);
+
+    cpu_exec_end(cpu);
+    bql_lock();
+
+    if (ret < 0) {
+        cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
+        vm_stop(RUN_STATE_INTERNAL_ERROR);
+    }
+
+    qatomic_set(&cpu->exit_request, 0);
+    return ret;
+}
+
+static void *mshv_vcpu_thread(void *arg)
+{
+    CPUState *cpu = arg;
+    int ret;
+
+    rcu_register_thread();
+
+    bql_lock();
+    qemu_thread_get_self(cpu->thread);
+    cpu->thread_id = qemu_get_thread_id();
+    current_cpu = cpu;
+    ret = mshv_init_vcpu(cpu);
+    if (ret < 0) {
+        error_report("Failed to init vcpu %d", cpu->cpu_index);
+        goto cleanup;
+    }
+
+    /* signal CPU creation */
+    cpu_thread_signal_created(cpu);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
+
+    do {
+        if (cpu_can_run(cpu)) {
+            mshv_cpu_exec(cpu);
+        }
+        qemu_wait_io_event(cpu);
+    } while (!cpu->unplug || cpu_can_run(cpu));
+
+    mshv_destroy_vcpu(cpu);
+cleanup:
+    cpu_thread_signal_destroyed(cpu);
+    bql_unlock();
+    rcu_unregister_thread();
+    return NULL;
+}
+
 static void mshv_start_vcpu_thread(CPUState *cpu)
 {
-    error_report("unimplemented");
-    abort();
+    char thread_name[VCPU_THREAD_NAME_SIZE];
+
+    cpu->thread = g_malloc0(sizeof(QemuThread));
+    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+
+    qemu_cond_init(cpu->halt_cond);
+
+    trace_mshv_start_vcpu_thread(thread_name, cpu->cpu_index);
+    qemu_thread_create(cpu->thread, thread_name, mshv_vcpu_thread, cpu,
+                       QEMU_THREAD_JOINABLE);
+}
+
+static void do_mshv_cpu_synchronize_post_init(CPUState *cpu,
+                                              run_on_cpu_data arg)
+{
+    int ret = mshv_arch_put_registers(cpu);
+    if (ret < 0) {
+        error_report("Failed to put registers after init: %s", strerror(-ret));
+        abort();
+    }
+
+    cpu->accel->dirty = false;
 }
 
 static void mshv_cpu_synchronize_post_init(CPUState *cpu)
 {
-    error_report("unimplemented");
-    abort();
+    run_on_cpu(cpu, do_mshv_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
 }
 
 static void mshv_cpu_synchronize_post_reset(CPUState *cpu)
 {
-    error_report("unimplemented");
-    abort();
+    int ret = mshv_arch_put_registers(cpu);
+    if (ret) {
+        error_report("Failed to put registers after reset: %s",
+                     strerror(-ret));
+        cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
+        vm_stop(RUN_STATE_INTERNAL_ERROR);
+    }
+    cpu->accel->dirty = false;
+}
+
+static void do_mshv_cpu_synchronize_pre_loadvm(CPUState *cpu,
+                                               run_on_cpu_data arg)
+{
+    cpu->accel->dirty = true;
 }
 
 static void mshv_cpu_synchronize_pre_loadvm(CPUState *cpu)
 {
-    error_report("unimplemented");
-    abort();
+    run_on_cpu(cpu, do_mshv_cpu_synchronize_pre_loadvm, RUN_ON_CPU_NULL);
+}
+
+static void do_mshv_cpu_synchronize(CPUState *cpu, run_on_cpu_data arg)
+{
+    if (!cpu->accel->dirty) {
+        int ret = mshv_load_regs(cpu);
+        if (ret < 0) {
+            error_report("Failed to load registers for vcpu %d",
+                         cpu->cpu_index);
+
+            cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
+            vm_stop(RUN_STATE_INTERNAL_ERROR);
+        }
+
+        cpu->accel->dirty = true;
+    }
 }
 
 static void mshv_cpu_synchronize(CPUState *cpu)
 {
-    error_report("unimplemented");
-    abort();
+    if (!cpu->accel->dirty) {
+        run_on_cpu(cpu, do_mshv_cpu_synchronize, RUN_ON_CPU_NULL);
+    }
 }
 
 static bool mshv_cpus_are_resettable(void)
 {
-    error_report("unimplemented");
-    abort();
+    return false;
 }
 
 static void mshv_accel_class_init(ObjectClass *oc, const void *data)
diff --git a/accel/mshv/trace-events b/accel/mshv/trace-events
index 5ea5e74722..1b1b43a1e8 100644
--- a/accel/mshv/trace-events
+++ b/accel/mshv/trace-events
@@ -1,5 +1,7 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
+mshv_start_vcpu_thread(const char* thread, uint32_t cpu) "thread=%s cpu_index=%d"
+
 mshv_set_memory(bool add, uint64_t gpa, uint64_t size, uint64_t user_addr, bool readonly, int ret) "add=%d gpa=0x%lx size=0x%lx user=0x%lx readonly=%d result=%d"
 mshv_mem_ioeventfd_add(uint64_t addr, uint32_t size, uint32_t data) "addr=0x%lx size=%d data=0x%x"
 mshv_mem_ioeventfd_del(uint64_t addr, uint32_t size, uint32_t data) "addr=0x%lx size=%d data=0x%x"
diff --git a/include/system/mshv.h b/include/system/mshv.h
index f2ffbe4ace..301228a813 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -72,12 +72,29 @@ typedef struct MshvMsiControl {
     GHashTable *gsi_routes;
 } MshvMsiControl;
 
+#define mshv_vcpufd(cpu) (cpu->accel->cpufd)
+
 #else /* CONFIG_MSHV_IS_POSSIBLE */
 #define mshv_enabled() false
 #endif
 #define mshv_msi_via_irqfd_enabled() mshv_enabled()
 
 /* cpu */
+typedef enum MshvVmExit {
+    MshvVmExitIgnore   = 0,
+    MshvVmExitShutdown = 1,
+    MshvVmExitSpecial  = 2,
+} MshvVmExit;
+
+void mshv_init_cpu_logic(void);
+int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
+void mshv_remove_vcpu(int vm_fd, int cpu_fd);
+int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
+int mshv_load_regs(CPUState *cpu);
+int mshv_store_regs(CPUState *cpu);
+int mshv_arch_put_registers(const CPUState *cpu);
+void mshv_arch_init_vcpu(CPUState *cpu);
+void mshv_arch_destroy_vcpu(CPUState *cpu);
 void mshv_arch_amend_proc_features(
     union hv_partition_synthetic_processor_features *features);
 int mshv_arch_post_init_vm(int vm_fd);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index c00e98dfba..2fe5319201 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -20,16 +20,79 @@
 #include "hw/hyperv/hvhdk_mini.h"
 #include "hw/hyperv/hvgdk.h"
 
+#include "cpu.h"
+#include "emulate/x86_decode.h"
+#include "emulate/x86_emu.h"
+#include "emulate/x86_flags.h"
 
 #include "trace-accel_mshv.h"
 #include "trace.h"
 
+int mshv_store_regs(CPUState *cpu)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+int mshv_load_regs(CPUState *cpu)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+int mshv_arch_put_registers(const CPUState *cpu)
+{
+    error_report("unimplemented");
+    abort();
+}
+
 void mshv_arch_amend_proc_features(
     union hv_partition_synthetic_processor_features *features)
 {
     features->access_guest_idle_reg = 1;
 }
 
+int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+void mshv_remove_vcpu(int vm_fd, int cpu_fd)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+void mshv_init_cpu_logic(void)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+void mshv_arch_init_vcpu(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    env->emu_mmio_buf = g_new(char, 4096);
+}
+
+void mshv_arch_destroy_vcpu(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    g_free(env->emu_mmio_buf);
+    env->emu_mmio_buf = NULL;
+}
+
 /*
  * Default Microsoft Hypervisor behavior for unimplemented MSR is to send a
  * fault to the guest if it tries to access it. It is possible to override
-- 
2.34.1


