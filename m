Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D70777C599E
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 18:54:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqcSP-00005p-5s; Wed, 11 Oct 2023 12:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qqcSI-00005M-9t; Wed, 11 Oct 2023 12:53:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qqcSG-000117-2o; Wed, 11 Oct 2023 12:53:06 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39BFrMNf011672; Wed, 11 Oct 2023 16:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=vIY9iQmVxOtCnb003WgKAaSquLhSf0MtJNj5vG0N7VE=;
 b=p1Oo5wYMbkVsnWjd0BC1EiIFaq76eX2f/I7taboChpIfnMHPYOB/Jk7s1TCWBpyO50sT
 yNi1iJbOZIc/WO6B5Y/g8kG4afCQoBoi6dODkHanxqxAAi8by5rR6Dh/KPy4oUN9mP7x
 AzEVJAM66lrin2yZUv2G2Ur9BywARQhs6G/jXnVO5PEqpucg3n0i2VrpFweJoB2jM9vN
 ITyrPPfGa8xuTXzw7RSZpyU1SvlNk1fDnHmFDZI1kPlXOkzzPvaitLtzVswCjhqZkmTB
 5e8PvFlOULUGUMXen36M/ImZ7TbT/UVokxL8KJd/qAomULg2QNa3dMPHmxxriY5fQmjY mg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tnnvw9hh5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 16:53:02 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39BGr1Zv008046
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 16:53:01 GMT
Received: from blr-ubuntu-31.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 11 Oct 2023 09:52:56 -0700
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: <peter.maydell@linaro.org>, <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <quic_svaddagi@quicinc.com>, <quic_tsoni@quicinc.com>,
 <quic_pheragu@quicinc.com>, <quic_eberman@quicinc.com>,
 <quic_yvasi@quicinc.com>, <quic_cvanscha@quicinc.com>,
 <quic_mnalajal@quicinc.com>
Subject: [RFC/PATCH v0 03/12] gunyah: Basic support
Date: Wed, 11 Oct 2023 16:52:25 +0000
Message-ID: <20231011165234.1323725-4-quic_svaddagi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: NdtPMWSgDDw8rm-VAoSjw4l1_FzRvfOM
X-Proofpoint-GUID: NdtPMWSgDDw8rm-VAoSjw4l1_FzRvfOM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_12,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=939 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110148
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Add a new accelerator, gunyah, with basic functionality of creating a
VM. Subsequent patches will add support for other functions required to
run a VM.

Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
---
 MAINTAINERS                     |   7 +++
 accel/Kconfig                   |   3 +
 accel/gunyah/gunyah-accel-ops.c | 102 ++++++++++++++++++++++++++++++++
 accel/gunyah/gunyah-all.c       |  70 ++++++++++++++++++++++
 accel/gunyah/meson.build        |   7 +++
 accel/meson.build               |   1 +
 accel/stubs/gunyah-stub.c       |  13 ++++
 accel/stubs/meson.build         |   1 +
 docs/about/build-platforms.rst  |   2 +-
 hw/arm/virt.c                   |   3 +
 include/sysemu/gunyah.h         |  43 ++++++++++++++
 include/sysemu/gunyah_int.h     |  27 +++++++++
 meson.build                     |   9 +++
 meson_options.txt               |   2 +
 scripts/meson-buildoptions.sh   |   3 +
 target/arm/cpu64.c              |   5 +-
 16 files changed, 295 insertions(+), 3 deletions(-)
 create mode 100644 accel/gunyah/gunyah-accel-ops.c
 create mode 100644 accel/gunyah/gunyah-all.c
 create mode 100644 accel/gunyah/meson.build
 create mode 100644 accel/stubs/gunyah-stub.c
 create mode 100644 include/sysemu/gunyah.h
 create mode 100644 include/sysemu/gunyah_int.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6111b6b4d9..0e76dda91d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -510,6 +510,13 @@ F: accel/hvf/
 F: include/sysemu/hvf.h
 F: include/sysemu/hvf_int.h
 
+GUNYAH
+M: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
+S: Maintained
+F: accel/gunyah
+F: include/sysemu/gunyah.h
+F: include/sysemu/gunyah_int.h
+
 WHPX CPUs
 M: Sunil Muthuswamy <sunilmut@microsoft.com>
 S: Supported
diff --git a/accel/Kconfig b/accel/Kconfig
index 8bdedb7d15..bab1edebf4 100644
--- a/accel/Kconfig
+++ b/accel/Kconfig
@@ -19,3 +19,6 @@ config KVM
 config XEN
     bool
     select FSDEV_9P if VIRTFS
+
+config GUNYAH
+    bool
diff --git a/accel/gunyah/gunyah-accel-ops.c b/accel/gunyah/gunyah-accel-ops.c
new file mode 100644
index 0000000000..1c1c20abf1
--- /dev/null
+++ b/accel/gunyah/gunyah-accel-ops.c
@@ -0,0 +1,102 @@
+/*
+ * QEMU Gunyah hypervisor support
+ *
+ * (based on KVM accelerator code structure)
+ *
+ * Copyright 2008 IBM Corporation
+ *           2008 Red Hat, Inc.
+ *
+ * Copyright(c) 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/thread.h"
+#include "hw/boards.h"
+#include "hw/core/cpu.h"
+#include "sysemu/accel-ops.h"
+#include "sysemu/cpus.h"
+#include "sysemu/gunyah.h"
+#include "sysemu/gunyah_int.h"
+#include "qapi/visitor.h"
+#include "qapi/error.h"
+
+bool gunyah_allowed;
+
+static int gunyah_init(MachineState *ms)
+{
+    return gunyah_create_vm();
+}
+
+static void gunyah_accel_instance_init(Object *obj)
+{
+    GUNYAHState *s = GUNYAH_STATE(obj);
+
+    s->fd = -1;
+    s->vmfd = -1;
+}
+
+static void gunyah_accel_class_init(ObjectClass *oc, void *data)
+{
+    AccelClass *ac = ACCEL_CLASS(oc);
+
+    ac->name = "GUNYAH";
+    ac->init_machine = gunyah_init;
+    ac->allowed = &gunyah_allowed;
+}
+
+static const TypeInfo gunyah_accel_type = {
+    .name = TYPE_GUNYAH_ACCEL,
+    .parent = TYPE_ACCEL,
+    .instance_init = gunyah_accel_instance_init,
+    .class_init = gunyah_accel_class_init,
+    .instance_size = sizeof(GUNYAHState),
+};
+
+static void gunyah_type_init(void)
+{
+    type_register_static(&gunyah_accel_type);
+}
+type_init(gunyah_type_init);
+
+static void gunyah_start_vcpu_thread(CPUState *cpu)
+{
+    char thread_name[VCPU_THREAD_NAME_SIZE];
+
+    cpu->thread = g_malloc0(sizeof(QemuThread));
+    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+    qemu_cond_init(cpu->halt_cond);
+
+    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/Gunyah",
+             cpu->cpu_index);
+    qemu_thread_create(cpu->thread, thread_name, gunyah_cpu_thread_fn,
+                       cpu, QEMU_THREAD_JOINABLE);
+}
+
+static void gunyah_kick_vcpu_thread(CPUState *cpu)
+{
+    cpus_kick_thread(cpu);
+}
+
+static void gunyah_accel_ops_class_init(ObjectClass *oc, void *data)
+{
+    AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
+
+    ops->create_vcpu_thread = gunyah_start_vcpu_thread;
+    ops->kick_vcpu_thread = gunyah_kick_vcpu_thread;
+};
+
+static const TypeInfo gunyah_accel_ops_type = {
+    .name = ACCEL_OPS_NAME("gunyah"),
+    .parent = TYPE_ACCEL_OPS,
+    .class_init = gunyah_accel_ops_class_init,
+    .abstract = true,
+};
+
+static void gunyah_accel_ops_register_types(void)
+{
+    type_register_static(&gunyah_accel_ops_type);
+}
+
+type_init(gunyah_accel_ops_register_types);
diff --git a/accel/gunyah/gunyah-all.c b/accel/gunyah/gunyah-all.c
new file mode 100644
index 0000000000..370add75f9
--- /dev/null
+++ b/accel/gunyah/gunyah-all.c
@@ -0,0 +1,70 @@
+/*
+ * QEMU Gunyah hypervisor support
+ *
+ * (based on KVM accelerator code structure)
+ *
+ * Copyright 2008 IBM Corporation
+ *           2008 Red Hat, Inc.
+ *
+ * Copyright(c) 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/ioctl.h>
+#include "qemu/osdep.h"
+#include "qemu/typedefs.h"
+#include "hw/core/cpu.h"
+#include "sysemu/cpus.h"
+#include "sysemu/gunyah.h"
+#include "sysemu/gunyah_int.h"
+#include "linux-headers/linux/gunyah.h"
+#include "qemu/error-report.h"
+
+static int gunyah_ioctl(int type, ...)
+{
+    void *arg;
+    va_list ap;
+    GUNYAHState *s = GUNYAH_STATE(current_accel());
+
+    assert(s->fd);
+
+    va_start(ap, type);
+    arg = va_arg(ap, void *);
+    va_end(ap);
+
+    return ioctl(s->fd, type, arg);
+}
+
+int gunyah_create_vm(void)
+{
+    GUNYAHState *s;
+
+    s = GUNYAH_STATE(current_accel());
+
+    s->fd = qemu_open_old("/dev/gunyah", O_RDWR);
+    if (s->fd == -1) {
+        error_report("Could not access Gunyah kernel module at /dev/gunyah: %s",
+                                strerror(errno));
+        exit(1);
+    }
+
+    s->vmfd = gunyah_ioctl(GH_CREATE_VM, 0);
+    if (s->vmfd < 0) {
+        error_report("Could not create VM: %s", strerror(errno));
+        exit(1);
+    }
+
+    return 0;
+}
+
+void *gunyah_cpu_thread_fn(void *arg)
+{
+    CPUState *cpu = arg;
+
+    do {
+        /* Do nothing */
+    } while (!cpu->unplug || cpu_can_run(cpu));
+
+    return NULL;
+}
diff --git a/accel/gunyah/meson.build b/accel/gunyah/meson.build
new file mode 100644
index 0000000000..226eea0f2c
--- /dev/null
+++ b/accel/gunyah/meson.build
@@ -0,0 +1,7 @@
+gunyah_ss = ss.source_set()
+gunyah_ss.add(files(
+  'gunyah-all.c',
+  'gunyah-accel-ops.c',
+))
+
+specific_ss.add_all(when: 'CONFIG_GUNYAH', if_true: gunyah_ss)
diff --git a/accel/meson.build b/accel/meson.build
index 638a9a03ba..e2b87f74b0 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -9,6 +9,7 @@ if have_system
   subdir('kvm')
   subdir('xen')
   subdir('stubs')
+  subdir('gunyah')
 endif
 
 # qtest
diff --git a/accel/stubs/gunyah-stub.c b/accel/stubs/gunyah-stub.c
new file mode 100644
index 0000000000..d515469c01
--- /dev/null
+++ b/accel/stubs/gunyah-stub.c
@@ -0,0 +1,13 @@
+/*
+ * QEMU Gunyah stub
+ *
+ * Copyright(c) 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "sysemu/gunyah.h"
+#include "sysemu/gunyah_int.h"
+
+bool gunyah_allowed;
diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index f7a9486e06..4f594e09de 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -3,5 +3,6 @@ sysemu_stubs_ss.add(when: 'CONFIG_HAX', if_false: files('hax-stub.c'))
 sysemu_stubs_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
 sysemu_stubs_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 sysemu_stubs_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
+sysemu_stubs_ss.add(when: 'CONFIG_GUNYAH', if_false: files('gunyah-stub.c'))
 
 specific_ss.add_all(when: ['CONFIG_SYSTEM_ONLY'], if_true: sysemu_stubs_ss)
diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index 0e2cb9e770..5a3e241f1a 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -40,7 +40,7 @@ Those hosts are officially supported, with various accelerators:
    * - CPU Architecture
      - Accelerators
    * - Arm
-     - kvm (64 bit only), tcg, xen
+     - kvm (64 bit only), tcg, xen, gunyah (64 bit only)
    * - MIPS (little endian only)
      - kvm, tcg
    * - PPC
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b55d5c7282..4222183eb5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -80,6 +80,7 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/char/pl011.h"
 #include "qemu/guest-random.h"
+#include "sysemu/gunyah.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -1623,6 +1624,8 @@ static void virt_build_smbios(VirtMachineState *vms)
 
     if (kvm_enabled()) {
         product = "KVM Virtual Machine";
+    } else if (gunyah_enabled()) {
+        product = "Gunyah Virtual Machine";
     }
 
     smbios_set_defaults("QEMU", product,
diff --git a/include/sysemu/gunyah.h b/include/sysemu/gunyah.h
new file mode 100644
index 0000000000..aded49cdf6
--- /dev/null
+++ b/include/sysemu/gunyah.h
@@ -0,0 +1,43 @@
+/*
+ * QEMU Gunyah hypervisor support
+ *
+ * Copyright(c) 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/* header to be included in non-Gunyah-specific code */
+
+#ifndef QEMU_GUNYAH_H
+#define QEMU_GUNYAH_H
+
+#include "qemu/accel.h"
+#include "qom/object.h"
+
+#ifdef NEED_CPU_H
+#include "cpu.h"
+#ifdef CONFIG_GUNYAH
+# define CONFIG_GUNYAH_IS_POSSIBLE
+#endif
+#else
+# define CONFIG_GUNYAH_IS_POSSIBLE
+#endif
+
+#ifdef CONFIG_GUNYAH_IS_POSSIBLE
+
+extern bool gunyah_allowed;
+
+#define gunyah_enabled() (gunyah_allowed)
+
+#define TYPE_GUNYAH_ACCEL ACCEL_CLASS_NAME("gunyah")
+typedef struct GUNYAHState GUNYAHState;
+DECLARE_INSTANCE_CHECKER(GUNYAHState, GUNYAH_STATE,
+                         TYPE_GUNYAH_ACCEL)
+
+#else   /* CONFIG_GUNYAH_IS_POSSIBLE */
+
+#define gunyah_enabled()    0
+
+#endif  /* CONFIG_GUNYAH_IS_POSSIBLE */
+
+#endif  /* QEMU_GUNYAH_H */
diff --git a/include/sysemu/gunyah_int.h b/include/sysemu/gunyah_int.h
new file mode 100644
index 0000000000..37de628b37
--- /dev/null
+++ b/include/sysemu/gunyah_int.h
@@ -0,0 +1,27 @@
+/*
+ * QEMU Gunyah hypervisor support
+ *
+ * Copyright(c) 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/* header to be included in Gunyah-specific code */
+
+#ifndef GUNYAH_INT_H
+#define GUNYAH_INT_H
+
+#include "qemu/accel.h"
+#include "qemu/typedefs.h"
+
+struct GUNYAHState {
+    AccelState parent_obj;
+
+    int fd;
+    int vmfd;
+};
+
+int gunyah_create_vm(void);
+void *gunyah_cpu_thread_fn(void *arg);
+
+#endif    /* GUNYAH_INT_H */
diff --git a/meson.build b/meson.build
index 98e68ef0b1..ca46b51c55 100644
--- a/meson.build
+++ b/meson.build
@@ -136,6 +136,7 @@ if cpu in ['x86', 'x86_64', 'arm', 'aarch64']
   # i386 emulator provides xenpv machine type for multiple architectures
   accelerator_targets += {
     'CONFIG_XEN': ['i386-softmmu', 'x86_64-softmmu', 'aarch64-softmmu'],
+    'CONFIG_GUNYAH': ['aarch64-softmmu']
   }
 endif
 if cpu in ['x86', 'x86_64']
@@ -608,6 +609,7 @@ iokit = []
 emulator_link_args = []
 nvmm =not_found
 hvf = not_found
+gunyah = not_found
 midl = not_found
 widl = not_found
 pathcch = not_found
@@ -668,6 +670,9 @@ if get_option('hax').allowed()
     accelerators += 'CONFIG_HAX'
   endif
 endif
+if get_option('gunyah').allowed()
+    accelerators += 'CONFIG_GUNYAH'
+endif
 if targetos == 'netbsd'
   nvmm = cc.find_library('nvmm', required: get_option('nvmm'))
   if nvmm.found()
@@ -718,6 +723,9 @@ endif
 if 'CONFIG_WHPX' not in accelerators and get_option('whpx').enabled()
   error('WHPX not available on this platform')
 endif
+if 'CONFIG_GUNYAH' not in accelerators and get_option('gunyah').enabled()
+  error('Gunyah not available on this platform')
+endif
 
 ################
 # Dependencies #
@@ -4149,6 +4157,7 @@ if have_system
     summary_info += {'xen ctrl version':  xen.version()}
   endif
   summary_info += {'Xen emulation':     config_all.has_key('CONFIG_XEN_EMU')}
+  summary_info += {'Gunyah support':    config_all.has_key('CONFIG_GUNYAH')}
 endif
 summary_info += {'TCG support':       config_all.has_key('CONFIG_TCG')}
 if config_all.has_key('CONFIG_TCG')
diff --git a/meson_options.txt b/meson_options.txt
index aaea5ddd77..b914f0e853 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -105,6 +105,8 @@ option('dbus_display', type: 'feature', value: 'auto',
        description: '-display dbus support')
 option('tpm', type : 'feature', value : 'auto',
        description: 'TPM support')
+option('gunyah', type: 'feature', value: 'auto',
+       description: 'Gunyah acceleration support')
 
 # Do not enable it by default even for Mingw32, because it doesn't
 # work on Wine.
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 9da3fe299b..0c95f79645 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -112,6 +112,7 @@ meson_options_help() {
   printf "%s\n" '  guest-agent-msi Build MSI package for the QEMU Guest Agent'
   printf "%s\n" '  hax             HAX acceleration support'
   printf "%s\n" '  hvf             HVF acceleration support'
+  printf "%s\n" '  gunyah          Gunyah acceleration support'
   printf "%s\n" '  iconv           Font glyph conversion support'
   printf "%s\n" '  jack            JACK sound support'
   printf "%s\n" '  keyring         Linux keyring support'
@@ -312,6 +313,8 @@ _meson_option_parse() {
     --disable-guest-agent) printf "%s" -Dguest_agent=disabled ;;
     --enable-guest-agent-msi) printf "%s" -Dguest_agent_msi=enabled ;;
     --disable-guest-agent-msi) printf "%s" -Dguest_agent_msi=disabled ;;
+    --enable-gunyah) printf "%s" -Dgunyah=enabled ;;
+    --disable-gunyah) printf "%s" -Dgunyah=disabled ;;
     --enable-hax) printf "%s" -Dhax=enabled ;;
     --disable-hax) printf "%s" -Dhax=disabled ;;
     --enable-hexagon-idef-parser) printf "%s" -Dhexagon_idef_parser=true ;;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 96158093cc..a712f1a3b3 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -33,6 +33,7 @@
 #include "hw/qdev-properties.h"
 #include "internals.h"
 #include "cpregs.h"
+#include "sysemu/gunyah.h"
 
 void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
 {
@@ -686,7 +687,7 @@ static void aarch64_host_initfn(Object *obj)
 
 static void aarch64_max_initfn(Object *obj)
 {
-    if (kvm_enabled() || hvf_enabled()) {
+    if (kvm_enabled() || hvf_enabled() || gunyah_enabled()) {
         /* With KVM or HVF, '-cpu max' is identical to '-cpu host' */
         aarch64_host_initfn(obj);
         return;
@@ -706,7 +707,7 @@ static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
     { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
     { .name = "max",                .initfn = aarch64_max_initfn },
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
+#if defined(CONFIG_KVM) || defined(CONFIG_HVF) || defined(CONFIG_GUNYAH)
     { .name = "host",               .initfn = aarch64_host_initfn },
 #endif
 };
-- 
2.25.1


