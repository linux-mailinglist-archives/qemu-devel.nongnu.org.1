Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFD9ABD6DA
	for <lists+qemu-devel@lfdr.de>; Tue, 20 May 2025 13:32:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHLC1-00085V-31; Tue, 20 May 2025 07:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uHLBy-000859-P0
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:31:30 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uHLBu-0001F4-Ao
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:31:30 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (unknown [172.201.77.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id BD3AA201DB29;
 Tue, 20 May 2025 04:31:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BD3AA201DB29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747740684;
 bh=5fhvTgIqkHQJ7lke+Wu9fGFg8IVS2eOzmuc8VuprAcs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=I0WIRGdisa77EpsyOJxBFk95jx4QJxfnXR9CyeiShcr6JIHtvimmd2LFk/8DEEx4T
 qLbSaYhv0CZV6tmdZmP5vquKNzPb55TCCkxllIarFtXkK+u1/t1cCVcvyYeZKCQSeY
 XdbFuVD7FO+Ai/ZiVxsWXceHqBOViRvJ9ir0AtYI=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: magnuskulke@microsoft.com,
	qemu-devel@nongnu.org,
	liuwe@microsoft.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 05/25] include/hw/hyperv: Add MSHV ABI header definitions
Date: Tue, 20 May 2025 13:29:58 +0200
Message-Id: <20250520113018.49569-6-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
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

Introduce headers for the Microsoft Hypervisor (MSHV) userspace ABI,
including IOCTLs and structures used to interface with the hypervisor.

These definitions are based on the upstream Linux MSHV interface and
will be used by the MSHV accelerator backend in later patches.

Note that for the time being the header `linux-mshv.h` is also being
included to allow building on machines that do not ship the header yet.
The header will be available in kernel 6.15 (at the time of writing
we're at -rc6) we will probably drop it in later revisions of the
patch set.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 include/hw/hyperv/hvgdk.h      |   20 +
 include/hw/hyperv/hvhdk.h      |  165 +++++
 include/hw/hyperv/hvhdk_mini.h |  106 ++++
 include/hw/hyperv/linux-mshv.h | 1038 ++++++++++++++++++++++++++++++++
 4 files changed, 1329 insertions(+)
 create mode 100644 include/hw/hyperv/hvgdk.h
 create mode 100644 include/hw/hyperv/hvhdk.h
 create mode 100644 include/hw/hyperv/hvhdk_mini.h
 create mode 100644 include/hw/hyperv/linux-mshv.h

diff --git a/include/hw/hyperv/hvgdk.h b/include/hw/hyperv/hvgdk.h
new file mode 100644
index 0000000000..b03868d152
--- /dev/null
+++ b/include/hw/hyperv/hvgdk.h
@@ -0,0 +1,20 @@
+/*
+ * Type definitions for the mshv guest interface.
+ *
+ * Copyright Microsoft, Corp. 2025
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#ifndef _HVGDK_H
+#define _HVGDK_H
+
+#define HVGDK_H_VERSION         (25125)
+
+enum hv_unimplemented_msr_action {
+    HV_UNIMPLEMENTED_MSR_ACTION_FAULT = 0,
+    HV_UNIMPLEMENTED_MSR_ACTION_IGNORE_WRITE_READ_ZERO = 1,
+    HV_UNIMPLEMENTED_MSR_ACTION_COUNT = 2,
+};
+
+#endif /* _HVGDK_H */
diff --git a/include/hw/hyperv/hvhdk.h b/include/hw/hyperv/hvhdk.h
new file mode 100644
index 0000000000..7896f49d10
--- /dev/null
+++ b/include/hw/hyperv/hvhdk.h
@@ -0,0 +1,165 @@
+/*
+ * Type definitions for the mshv host.
+ *
+ * Copyright Microsoft, Corp. 2025
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_HYPERV_HVHDK_H
+#define HW_HYPERV_HVHDK_H
+
+#define HV_PARTITION_SYNTHETIC_PROCESSOR_FEATURES_BANKS 1
+
+struct hv_input_set_partition_property {
+    __u64 partition_id;
+    __u32 property_code; /* enum hv_partition_property_code */
+    __u32 padding;
+    __u64 property_value;
+};
+
+union hv_partition_synthetic_processor_features {
+    __u64 as_uint64[HV_PARTITION_SYNTHETIC_PROCESSOR_FEATURES_BANKS];
+
+    struct {
+        /*
+         * Report a hypervisor is present. CPUID leaves
+         * 0x40000000 and 0x40000001 are supported.
+         */
+        __u64 hypervisor_present:1;
+
+        /*
+         * Features associated with HV#1:
+         */
+
+        /* Report support for Hv1 (CPUID leaves 0x40000000 - 0x40000006). */
+        __u64 hv1:1;
+
+        /*
+         * Access to HV_X64_MSR_VP_RUNTIME.
+         * Corresponds to access_vp_run_time_reg privilege.
+         */
+        __u64 access_vp_run_time_reg:1;
+
+        /*
+         * Access to HV_X64_MSR_TIME_REF_COUNT.
+         * Corresponds to access_partition_reference_counter privilege.
+         */
+        __u64 access_partition_reference_counter:1;
+
+        /*
+         * Access to SINT-related registers (HV_X64_MSR_SCONTROL through
+         * HV_X64_MSR_EOM and HV_X64_MSR_SINT0 through HV_X64_MSR_SINT15).
+         * Corresponds to access_synic_regs privilege.
+         */
+        __u64 access_synic_regs:1;
+
+        /*
+         * Access to synthetic timers and associated MSRs
+         * (HV_X64_MSR_STIMER0_CONFIG through HV_X64_MSR_STIMER3_COUNT).
+         * Corresponds to access_synthetic_timer_regs privilege.
+         */
+        __u64 access_synthetic_timer_regs:1;
+
+        /*
+         * Access to APIC MSRs (HV_X64_MSR_EOI, HV_X64_MSR_ICR and
+         * HV_X64_MSR_TPR) as well as the VP assist page.
+         * Corresponds to access_intr_ctrl_regs privilege.
+         */
+        __u64 access_intr_ctrl_regs:1;
+
+        /*
+         * Access to registers associated with hypercalls
+         * (HV_X64_MSR_GUEST_OS_ID and HV_X64_MSR_HYPERCALL).
+         * Corresponds to access_hypercall_msrs privilege.
+         */
+        __u64 access_hypercall_regs:1;
+
+        /* VP index can be queried. corresponds to access_vp_index privilege. */
+        __u64 access_vp_index:1;
+
+        /*
+         * Access to the reference TSC. Corresponds to
+         * access_partition_reference_tsc privilege.
+         */
+        __u64 access_partition_reference_tsc:1;
+
+        /*
+         * Partition has access to the guest idle reg. Corresponds to
+         * access_guest_idle_reg privilege.
+         */
+        __u64 access_guest_idle_reg:1;
+
+        /*
+         * Partition has access to frequency regs. corresponds to
+         * access_frequency_regs privilege.
+         */
+        __u64 access_frequency_regs:1;
+
+        __u64 reserved_z12:1; /* Reserved for access_reenlightenment_controls */
+        __u64 reserved_z13:1; /* Reserved for access_root_scheduler_reg */
+        __u64 reserved_z14:1; /* Reserved for access_tsc_invariant_controls */
+
+        /*
+         * Extended GVA ranges for HvCallFlushVirtualAddressList hypercall.
+         * Corresponds to privilege.
+         */
+        __u64 enable_extended_gva_ranges_for_flush_virtual_address_list:1;
+
+        __u64 reserved_z16:1; /* Reserved for access_vsm. */
+        __u64 reserved_z17:1; /* Reserved for access_vp_registers. */
+
+        /* Use fast hypercall output. Corresponds to privilege. */
+        __u64 fast_hypercall_output:1;
+
+        __u64 reserved_z19:1; /* Reserved for enable_extended_hypercalls. */
+
+        /*
+         * HvStartVirtualProcessor can be used to start virtual processors.
+         * Corresponds to privilege.
+         */
+        __u64 start_virtual_processor:1;
+
+        __u64 reserved_z21:1; /* Reserved for Isolation. */
+
+        /* Synthetic timers in direct mode. */
+        __u64 direct_synthetic_timers:1;
+
+        __u64 reserved_z23:1; /* Reserved for synthetic time unhalted timer */
+
+        /* Use extended processor masks. */
+        __u64 extended_processor_masks:1;
+
+        /*
+         * HvCallFlushVirtualAddressSpace / HvCallFlushVirtualAddressList are
+         * supported.
+         */
+        __u64 tb_flush_hypercalls:1;
+
+        /* HvCallSendSyntheticClusterIpi is supported. */
+        __u64 synthetic_cluster_ipi:1;
+
+        /* HvCallNotifyLongSpinWait is supported. */
+        __u64 notify_long_spin_wait:1;
+
+        /* HvCallQueryNumaDistance is supported. */
+        __u64 query_numa_distance:1;
+
+        /* HvCallSignalEvent is supported. Corresponds to privilege. */
+        __u64 signal_events:1;
+
+        /* HvCallRetargetDeviceInterrupt is supported. */
+        __u64 retarget_device_interrupt:1;
+
+        /* HvCallRestorePartitionTime is supported. */
+        __u64 restore_time:1;
+
+        /* EnlightenedVmcs nested enlightenment is supported. */
+        __u64 enlightened_vmcs:1;
+
+        __u64 reserved:30;
+    };
+};
+
+#endif
diff --git a/include/hw/hyperv/hvhdk_mini.h b/include/hw/hyperv/hvhdk_mini.h
new file mode 100644
index 0000000000..3231af1f5a
--- /dev/null
+++ b/include/hw/hyperv/hvhdk_mini.h
@@ -0,0 +1,106 @@
+/*
+ * Type definitions for the mshv host interface.
+ *
+ * Copyright Microsoft, Corp. 2025
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#ifndef _HVHDK_MINI_H
+#define _HVHDK_MINI_H
+
+#define HVHVK_MINI_VERSION (25294)
+
+/* Each generic set contains 64 elements */
+#define HV_GENERIC_SET_SHIFT (6)
+#define HV_GENERIC_SET_MASK  (63)
+
+#define HVCALL_GET_PARTITION_PROPERTY   0x0044
+#define HVCALL_SET_PARTITION_PROPERTY   0x0045
+#define HVCALL_ASSERT_VIRTUAL_INTERRUPT 0x0094
+
+enum hv_generic_set_format {
+    HV_GENERIC_SET_SPARSE_4K,
+    HV_GENERIC_SET_ALL,
+};
+
+enum hv_partition_property_code {
+    /* Privilege properties */
+    HV_PARTITION_PROPERTY_PRIVILEGE_FLAGS         = 0x00010000,
+    HV_PARTITION_PROPERTY_SYNTHETIC_PROC_FEATURES = 0x00010001,
+
+    /* Scheduling properties */
+    HV_PARTITION_PROPERTY_SUSPEND      = 0x00020000,
+    HV_PARTITION_PROPERTY_CPU_RESERVE  = 0x00020001,
+    HV_PARTITION_PROPERTY_CPU_CAP      = 0x00020002,
+    HV_PARTITION_PROPERTY_CPU_WEIGHT   = 0x00020003,
+    HV_PARTITION_PROPERTY_CPU_GROUP_ID = 0x00020004,
+
+    /* Time properties */
+    HV_PARTITION_PROPERTY_TIME_FREEZE    = 0x00030003,
+    HV_PARTITION_PROPERTY_REFERENCE_TIME = 0x00030005,
+
+    /* Debugging properties */
+    HV_PARTITION_PROPERTY_DEBUG_CHANNEL_ID = 0x00040000,
+
+    /* Resource properties */
+    HV_PARTITION_PROPERTY_VIRTUAL_TLB_PAGE_COUNT                 = 0x00050000,
+    HV_PARTITION_PROPERTY_VSM_CONFIG                             = 0x00050001,
+    HV_PARTITION_PROPERTY_ZERO_MEMORY_ON_RESET                   = 0x00050002,
+    HV_PARTITION_PROPERTY_PROCESSORS_PER_SOCKET                  = 0x00050003,
+    HV_PARTITION_PROPERTY_NESTED_TLB_SIZE                        = 0x00050004,
+    HV_PARTITION_PROPERTY_GPA_PAGE_ACCESS_TRACKING               = 0x00050005,
+    HV_PARTITION_PROPERTY_VSM_PERMISSIONS_DIRTY_SINCE_LAST_QUERY = 0x00050006,
+    HV_PARTITION_PROPERTY_SGX_LAUNCH_CONTROL_CONFIG              = 0x00050007,
+    HV_PARTITION_PROPERTY_DEFAULT_SGX_LAUNCH_CONTROL0            = 0x00050008,
+    HV_PARTITION_PROPERTY_DEFAULT_SGX_LAUNCH_CONTROL1            = 0x00050009,
+    HV_PARTITION_PROPERTY_DEFAULT_SGX_LAUNCH_CONTROL2            = 0x0005000a,
+    HV_PARTITION_PROPERTY_DEFAULT_SGX_LAUNCH_CONTROL3            = 0x0005000b,
+    HV_PARTITION_PROPERTY_ISOLATION_STATE                        = 0x0005000c,
+    HV_PARTITION_PROPERTY_ISOLATION_CONTROL                      = 0x0005000d,
+    HV_PARTITION_PROPERTY_ALLOCATION_ID                          = 0x0005000e,
+    HV_PARTITION_PROPERTY_MONITORING_ID                          = 0x0005000f,
+    HV_PARTITION_PROPERTY_IMPLEMENTED_PHYSICAL_ADDRESS_BITS      = 0x00050010,
+    HV_PARTITION_PROPERTY_NON_ARCHITECTURAL_CORE_SHARING         = 0x00050011,
+    HV_PARTITION_PROPERTY_HYPERCALL_DOORBELL_PAGE                = 0x00050012,
+    HV_PARTITION_PROPERTY_ISOLATION_POLICY                       = 0x00050014,
+    HV_PARTITION_PROPERTY_UNIMPLEMENTED_MSR_ACTION               = 0x00050017,
+    HV_PARTITION_PROPERTY_SEV_VMGEXIT_OFFLOADS                   = 0x00050022,
+
+    /* Compatibility properties */
+    HV_PARTITION_PROPERTY_PROCESSOR_VENDOR              = 0x00060000,
+    HV_PARTITION_PROPERTY_PROCESSOR_FEATURES_DEPRECATED = 0x00060001,
+    HV_PARTITION_PROPERTY_PROCESSOR_XSAVE_FEATURES      = 0x00060002,
+    HV_PARTITION_PROPERTY_PROCESSOR_CL_FLUSH_SIZE       = 0x00060003,
+    HV_PARTITION_PROPERTY_ENLIGHTENMENT_MODIFICATIONS   = 0x00060004,
+    HV_PARTITION_PROPERTY_COMPATIBILITY_VERSION         = 0x00060005,
+    HV_PARTITION_PROPERTY_PHYSICAL_ADDRESS_WIDTH        = 0x00060006,
+    HV_PARTITION_PROPERTY_XSAVE_STATES                  = 0x00060007,
+    HV_PARTITION_PROPERTY_MAX_XSAVE_DATA_SIZE           = 0x00060008,
+    HV_PARTITION_PROPERTY_PROCESSOR_CLOCK_FREQUENCY     = 0x00060009,
+    HV_PARTITION_PROPERTY_PROCESSOR_FEATURES0           = 0x0006000a,
+    HV_PARTITION_PROPERTY_PROCESSOR_FEATURES1           = 0x0006000b,
+
+    /* Guest software properties */
+    HV_PARTITION_PROPERTY_GUEST_OS_ID = 0x00070000,
+
+    /* Nested virtualization properties */
+    HV_PARTITION_PROPERTY_PROCESSOR_VIRTUALIZATION_FEATURES = 0x00080000,
+};
+
+/* HV Map GPA (Guest Physical Address) Flags */
+#define HV_MAP_GPA_PERMISSIONS_NONE        0x0
+#define HV_MAP_GPA_READABLE                0x1
+#define HV_MAP_GPA_WRITABLE                0x2
+#define HV_MAP_GPA_KERNEL_EXECUTABLE       0x4
+#define HV_MAP_GPA_USER_EXECUTABLE         0x8
+#define HV_MAP_GPA_EXECUTABLE              0xC
+#define HV_MAP_GPA_PERMISSIONS_MASK        0xF
+#define HV_MAP_GPA_ADJUSTABLE           0x8000
+#define HV_MAP_GPA_NO_ACCESS           0x10000
+#define HV_MAP_GPA_NOT_CACHED         0x200000
+#define HV_MAP_GPA_LARGE_PAGE       0x80000000
+
+#define HV_PFN_RNG_PAGEBITS 24  /* HV_SPA_PAGE_RANGE_ADDITIONAL_PAGES_BITS */
+
+#endif /* _HVHDK_MINI_H */
diff --git a/include/hw/hyperv/linux-mshv.h b/include/hw/hyperv/linux-mshv.h
new file mode 100644
index 0000000000..9b1e1f7ce1
--- /dev/null
+++ b/include/hw/hyperv/linux-mshv.h
@@ -0,0 +1,1038 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Userspace interfaces for /dev/mshv* devices and derived fds
+ * Includes:
+ * - VMM APIs for parent (nested/baremetal root) partition APIs
+ * - VMM APIs for VTL0 APIs
+ * - Debug and performance metrics APIs
+ *
+ * This file is divided into sections containing data structures and IOCTLs for
+ * a particular set of related devices or derived file descriptors.
+ *
+ * The IOCTL definitions are at the end of each section. They are grouped by
+ * device/fd, so that new IOCTLs can easily be added with a monotonically
+ * increasing number.
+ */
+
+#ifndef HW_HYPERV_LINUX_MSHV_H
+#define HW_HYPERV_LINUX_MSHV_H
+
+#include <linux/types.h>
+#include <stdint.h>
+
+#define MSHV_IOCTL	0xB8
+
+typedef enum hv_register_name {
+	/* Pending Interruption Register */
+	HV_REGISTER_PENDING_INTERRUPTION = 0x00010002,
+
+	/* X64 User-Mode Registers */
+	HV_X64_REGISTER_RAX		= 0x00020000,
+	HV_X64_REGISTER_RCX		= 0x00020001,
+	HV_X64_REGISTER_RDX		= 0x00020002,
+	HV_X64_REGISTER_RBX		= 0x00020003,
+	HV_X64_REGISTER_RSP		= 0x00020004,
+	HV_X64_REGISTER_RBP		= 0x00020005,
+	HV_X64_REGISTER_RSI		= 0x00020006,
+	HV_X64_REGISTER_RDI		= 0x00020007,
+	HV_X64_REGISTER_R8		= 0x00020008,
+	HV_X64_REGISTER_R9		= 0x00020009,
+	HV_X64_REGISTER_R10		= 0x0002000A,
+	HV_X64_REGISTER_R11		= 0x0002000B,
+	HV_X64_REGISTER_R12		= 0x0002000C,
+	HV_X64_REGISTER_R13		= 0x0002000D,
+	HV_X64_REGISTER_R14		= 0x0002000E,
+	HV_X64_REGISTER_R15		= 0x0002000F,
+	HV_X64_REGISTER_RIP		= 0x00020010,
+	HV_X64_REGISTER_RFLAGS	= 0x00020011,
+
+	/* X64 Floating Point and Vector Registers */
+	HV_X64_REGISTER_XMM0				= 0x00030000,
+	HV_X64_REGISTER_XMM1				= 0x00030001,
+	HV_X64_REGISTER_XMM2				= 0x00030002,
+	HV_X64_REGISTER_XMM3				= 0x00030003,
+	HV_X64_REGISTER_XMM4				= 0x00030004,
+	HV_X64_REGISTER_XMM5				= 0x00030005,
+	HV_X64_REGISTER_XMM6				= 0x00030006,
+	HV_X64_REGISTER_XMM7				= 0x00030007,
+	HV_X64_REGISTER_XMM8				= 0x00030008,
+	HV_X64_REGISTER_XMM9				= 0x00030009,
+	HV_X64_REGISTER_XMM10				= 0x0003000A,
+	HV_X64_REGISTER_XMM11				= 0x0003000B,
+	HV_X64_REGISTER_XMM12				= 0x0003000C,
+	HV_X64_REGISTER_XMM13				= 0x0003000D,
+	HV_X64_REGISTER_XMM14				= 0x0003000E,
+	HV_X64_REGISTER_XMM15				= 0x0003000F,
+	HV_X64_REGISTER_FP_MMX0				= 0x00030010,
+	HV_X64_REGISTER_FP_MMX1				= 0x00030011,
+	HV_X64_REGISTER_FP_MMX2				= 0x00030012,
+	HV_X64_REGISTER_FP_MMX3				= 0x00030013,
+	HV_X64_REGISTER_FP_MMX4				= 0x00030014,
+	HV_X64_REGISTER_FP_MMX5				= 0x00030015,
+	HV_X64_REGISTER_FP_MMX6				= 0x00030016,
+	HV_X64_REGISTER_FP_MMX7				= 0x00030017,
+	HV_X64_REGISTER_FP_CONTROL_STATUS	= 0x00030018,
+	HV_X64_REGISTER_XMM_CONTROL_STATUS	= 0x00030019,
+
+	/* X64 Control Registers */
+	HV_X64_REGISTER_CR0		= 0x00040000,
+	HV_X64_REGISTER_CR2		= 0x00040001,
+	HV_X64_REGISTER_CR3		= 0x00040002,
+	HV_X64_REGISTER_CR4		= 0x00040003,
+	HV_X64_REGISTER_CR8		= 0x00040004,
+	HV_X64_REGISTER_XFEM	= 0x00040005,
+
+	/* X64 Segment Registers */
+	HV_X64_REGISTER_ES		= 0x00060000,
+	HV_X64_REGISTER_CS		= 0x00060001,
+	HV_X64_REGISTER_SS		= 0x00060002,
+	HV_X64_REGISTER_DS		= 0x00060003,
+	HV_X64_REGISTER_FS		= 0x00060004,
+	HV_X64_REGISTER_GS		= 0x00060005,
+	HV_X64_REGISTER_LDTR	= 0x00060006,
+	HV_X64_REGISTER_TR		= 0x00060007,
+
+	/* X64 Table Registers */
+	HV_X64_REGISTER_IDTR	= 0x00070000,
+	HV_X64_REGISTER_GDTR	= 0x00070001,
+
+	/* X64 Virtualized MSRs */
+	HV_X64_REGISTER_TSC				= 0x00080000,
+	HV_X64_REGISTER_EFER			= 0x00080001,
+	HV_X64_REGISTER_KERNEL_GS_BASE	= 0x00080002,
+	HV_X64_REGISTER_APIC_BASE		= 0x00080003,
+	HV_X64_REGISTER_PAT				= 0x00080004,
+	HV_X64_REGISTER_SYSENTER_CS		= 0x00080005,
+	HV_X64_REGISTER_SYSENTER_EIP	= 0x00080006,
+	HV_X64_REGISTER_SYSENTER_ESP	= 0x00080007,
+	HV_X64_REGISTER_STAR			= 0x00080008,
+	HV_X64_REGISTER_LSTAR			= 0x00080009,
+	HV_X64_REGISTER_CSTAR			= 0x0008000A,
+	HV_X64_REGISTER_SFMASK			= 0x0008000B,
+	HV_X64_REGISTER_INITIAL_APIC_ID	= 0x0008000C,
+
+	/* X64 Cache control MSRs */
+	HV_X64_REGISTER_MSR_MTRR_CAP			= 0x0008000D,
+	HV_X64_REGISTER_MSR_MTRR_DEF_TYPE		= 0x0008000E,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0		= 0x00080010,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1		= 0x00080011,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2		= 0x00080012,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3		= 0x00080013,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4		= 0x00080014,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5		= 0x00080015,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6		= 0x00080016,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7		= 0x00080017,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE8		= 0x00080018,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE9		= 0x00080019,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEA		= 0x0008001A,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEB		= 0x0008001B,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEC		= 0x0008001C,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASED		= 0x0008001D,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEE		= 0x0008001E,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEF		= 0x0008001F,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0		= 0x00080040,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1		= 0x00080041,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2		= 0x00080042,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3		= 0x00080043,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4		= 0x00080044,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5		= 0x00080045,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6		= 0x00080046,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7		= 0x00080047,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK8		= 0x00080048,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK9		= 0x00080049,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKA		= 0x0008004A,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB		= 0x0008004B,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKC		= 0x0008004C,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKD		= 0x0008004D,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKE		= 0x0008004E,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKF		= 0x0008004F,
+	HV_X64_REGISTER_MSR_MTRR_FIX64K00000	= 0x00080070,
+	HV_X64_REGISTER_MSR_MTRR_FIX16K80000	= 0x00080071,
+	HV_X64_REGISTER_MSR_MTRR_FIX16KA0000	= 0x00080072,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KC0000		= 0x00080073,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KC8000		= 0x00080074,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KD0000		= 0x00080075,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KD8000		= 0x00080076,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KE0000		= 0x00080077,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KE8000		= 0x00080078,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KF0000		= 0x00080079,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KF8000		= 0x0008007A,
+
+	HV_X64_REGISTER_TSC_AUX		= 0x0008007B,
+	HV_X64_REGISTER_BNDCFGS		= 0x0008007C,
+	HV_X64_REGISTER_DEBUG_CTL	= 0x0008007D,
+
+	/* Available */
+
+	HV_X64_REGISTER_SPEC_CTRL		= 0x00080084,
+	HV_X64_REGISTER_TSC_ADJUST	    = 0x00080096,
+
+	/* Other MSRs */
+	HV_X64_REGISTER_MSR_IA32_MISC_ENABLE = 0x000800A0,
+
+	/* Misc */
+	HV_REGISTER_GUEST_OS_ID			= 0x00090002,
+	HV_REGISTER_REFERENCE_TSC		= 0x00090017,
+
+	/* Hypervisor-defined Registers (Synic) */
+	HV_REGISTER_SINT0		= 0x000A0000,
+	HV_REGISTER_SINT1		= 0x000A0001,
+	HV_REGISTER_SINT2		= 0x000A0002,
+	HV_REGISTER_SINT3		= 0x000A0003,
+	HV_REGISTER_SINT4		= 0x000A0004,
+	HV_REGISTER_SINT5		= 0x000A0005,
+	HV_REGISTER_SINT6		= 0x000A0006,
+	HV_REGISTER_SINT7		= 0x000A0007,
+	HV_REGISTER_SINT8		= 0x000A0008,
+	HV_REGISTER_SINT9		= 0x000A0009,
+	HV_REGISTER_SINT10		= 0x000A000A,
+	HV_REGISTER_SINT11		= 0x000A000B,
+	HV_REGISTER_SINT12		= 0x000A000C,
+	HV_REGISTER_SINT13		= 0x000A000D,
+	HV_REGISTER_SINT14		= 0x000A000E,
+	HV_REGISTER_SINT15		= 0x000A000F,
+	HV_REGISTER_SCONTROL	= 0x000A0010,
+	HV_REGISTER_SVERSION	= 0x000A0011,
+	HV_REGISTER_SIEFP		= 0x000A0012,
+	HV_REGISTER_SIMP		= 0x000A0013,
+	HV_REGISTER_EOM			= 0x000A0014,
+	HV_REGISTER_SIRBP		= 0x000A0015,
+} hv_register_name;
+
+enum hv_intercept_type {
+	HV_INTERCEPT_TYPE_X64_IO_PORT		= 0X00000000,
+	HV_INTERCEPT_TYPE_X64_MSR			= 0X00000001,
+	HV_INTERCEPT_TYPE_X64_CPUID			= 0X00000002,
+	HV_INTERCEPT_TYPE_EXCEPTION			= 0X00000003,
+
+	/* Used to be HV_INTERCEPT_TYPE_REGISTER */
+	HV_INTERCEPT_TYPE_RESERVED0			= 0X00000004,
+	HV_INTERCEPT_TYPE_MMIO				= 0X00000005,
+	HV_INTERCEPT_TYPE_X64_GLOBAL_CPUID	= 0X00000006,
+	HV_INTERCEPT_TYPE_X64_APIC_SMI		= 0X00000007,
+	HV_INTERCEPT_TYPE_HYPERCALL			= 0X00000008,
+
+	HV_INTERCEPT_TYPE_X64_APIC_INIT_SIPI		= 0X00000009,
+	HV_INTERCEPT_MC_UPDATE_PATCH_LEVEL_MSR_READ	= 0X0000000A,
+
+	HV_INTERCEPT_TYPE_X64_APIC_WRITE		= 0X0000000B,
+	HV_INTERCEPT_TYPE_X64_MSR_INDEX			= 0X0000000C,
+	HV_INTERCEPT_TYPE_MAX,
+	HV_INTERCEPT_TYPE_INVALID			    = 0XFFFFFFFF,
+};
+
+struct hv_u128 {
+	__u64 low_part;
+	__u64 high_part;
+};
+
+union hv_x64_xmm_control_status_register {
+	struct hv_u128 as_uint128;
+	struct {
+		union {
+			/* long mode */
+			__u64 last_fp_rdp;
+			/* 32 bit mode */
+			struct {
+				__u32 last_fp_dp;
+				__u16 last_fp_ds;
+				__u16 padding;
+			};
+		};
+		__u32 xmm_status_control;
+		__u32 xmm_status_control_mask;
+	};
+};
+
+union hv_x64_fp_register {
+	struct hv_u128 as_uint128;
+	struct {
+		__u64 mantissa;
+		__u64 biased_exponent : 15;
+		__u64 sign : 1;
+		__u64 reserved : 48;
+	};
+};
+
+union hv_x64_pending_exception_event {
+	__u64 as_uint64[2];
+	struct {
+		__u32 event_pending : 1;
+		__u32 event_type : 3;
+		__u32 reserved0 : 4;
+		__u32 deliver_error_code : 1;
+		__u32 reserved1 : 7;
+		__u32 vector : 16;
+		__u32 error_code;
+		__u64 exception_parameter;
+	};
+};
+
+union hv_x64_pending_virtualization_fault_event {
+	__u64 as_uint64[2];
+	struct {
+		__u32 event_pending : 1;
+		__u32 event_type : 3;
+		__u32 reserved0 : 4;
+		__u32 reserved1 : 8;
+		__u32 parameter0 : 16;
+		__u32 code;
+		__u64 parameter1;
+	};
+};
+
+union hv_x64_pending_interruption_register {
+	__u64 as_uint64;
+	struct {
+		__u32 interruption_pending : 1;
+		__u32 interruption_type : 3;
+		__u32 deliver_error_code : 1;
+		__u32 instruction_length : 4;
+		__u32 nested_event : 1;
+		__u32 reserved : 6;
+		__u32 interruption_vector : 16;
+		__u32 error_code;
+	};
+};
+
+union hv_x64_register_sev_control {
+	__u64 as_uint64;
+	struct {
+		__u64 enable_encrypted_state : 1;
+		__u64 reserved_z : 11;
+		__u64 vmsa_gpa_page_number : 52;
+	};
+};
+
+union hv_x64_msr_npiep_config_contents {
+	__u64 as_uint64;
+	struct {
+		/*
+		 * These bits enable instruction execution prevention for
+		 * specific instructions.
+		 */
+		__u64 prevents_gdt : 1;
+		__u64 prevents_idt : 1;
+		__u64 prevents_ldt : 1;
+		__u64 prevents_tr : 1;
+
+		/* The reserved bits must always be 0. */
+		__u64 reserved : 60;
+	};
+};
+
+typedef struct hv_x64_segment_register {
+	__u64 base;
+	__u32 limit;
+	__u16 selector;
+	union {
+		struct {
+			__u16 segment_type : 4;
+			__u16 non_system_segment : 1;
+			__u16 descriptor_privilege_level : 2;
+			__u16 present : 1;
+			__u16 reserved : 4;
+			__u16 available : 1;
+			__u16 _long : 1;
+			__u16 _default : 1;
+			__u16 granularity : 1;
+		};
+		__u16 attributes;
+	};
+} hv_x64_segment_register;
+
+typedef struct hv_x64_table_register {
+	__u16 pad[3];
+	__u16 limit;
+	__u64 base;
+} hv_x64_table_register;
+
+union hv_x64_fp_control_status_register {
+	struct hv_u128 as_uint128;
+	struct {
+		__u16 fp_control;
+		__u16 fp_status;
+		__u8 fp_tag;
+		__u8 reserved;
+		__u16 last_fp_op;
+		union {
+			/* long mode */
+			__u64 last_fp_rip;
+			/* 32 bit mode */
+			struct {
+				__u32 last_fp_eip;
+				__u16 last_fp_cs;
+				__u16 padding;
+			};
+		};
+	};
+};
+
+/* General Hypervisor Register Content Definitions */
+
+union hv_explicit_suspend_register {
+	__u64 as_uint64;
+	struct {
+		__u64 suspended : 1;
+		__u64 reserved : 63;
+	};
+};
+
+union hv_internal_activity_register {
+	__u64 as_uint64;
+
+	struct {
+		__u64 startup_suspend : 1;
+		__u64 halt_suspend : 1;
+		__u64 idle_suspend : 1;
+		__u64 rsvd_z : 61;
+	};
+};
+
+union hv_x64_interrupt_state_register {
+	__u64 as_uint64;
+	struct {
+		__u64 interrupt_shadow : 1;
+		__u64 nmi_masked : 1;
+		__u64 reserved : 62;
+	};
+};
+
+union hv_intercept_suspend_register {
+	__u64 as_uint64;
+	struct {
+		__u64 suspended : 1;
+		__u64 reserved : 63;
+	};
+};
+
+union hv_register_value {
+	struct hv_u128 reg128;
+	__u64 reg64;
+	__u32 reg32;
+	__u16 reg16;
+	__u8 reg8;
+	union hv_x64_fp_register fp;
+	union hv_x64_fp_control_status_register fp_control_status;
+	union hv_x64_xmm_control_status_register xmm_control_status;
+	struct hv_x64_segment_register segment;
+	struct hv_x64_table_register table;
+	union hv_explicit_suspend_register explicit_suspend;
+	union hv_intercept_suspend_register intercept_suspend;
+	union hv_internal_activity_register internal_activity;
+	union hv_x64_interrupt_state_register interrupt_state;
+	union hv_x64_pending_interruption_register pending_interruption;
+	union hv_x64_msr_npiep_config_contents npiep_config;
+	union hv_x64_pending_exception_event pending_exception_event;
+	union hv_x64_pending_virtualization_fault_event
+		pending_virtualization_fault_event;
+	union hv_x64_register_sev_control sev_control;
+};
+
+typedef struct hv_register_assoc {
+	__u32 name;			/* enum hv_register_name */
+	__u32 reserved1;
+	__u64 reserved2;
+	union hv_register_value value;
+} hv_register_assoc;
+
+#define MSHV_VP_MAX_REGISTERS	128
+
+struct mshv_vp_registers {
+	int count; /* at most MSHV_VP_MAX_REGISTERS */
+	struct hv_register_assoc *regs;
+};
+
+/**
+ * struct mshv_user_mem_region - arguments for MSHV_SET_GUEST_MEMORY
+ * @size: Size of the memory region (bytes). Must be aligned to PAGE_SIZE
+ * @guest_pfn: Base guest page number to map
+ * @userspace_addr: Base address of userspace memory. Must be aligned to
+ *                  PAGE_SIZE
+ * @flags: Bitmask of 1 << MSHV_SET_MEM_BIT_*. If (1 << MSHV_SET_MEM_BIT_UNMAP)
+ *         is set, ignore other bits.
+ * @rsvd: MBZ
+ *
+ * Map or unmap a region of userspace memory to Guest Physical Addresses (GPA).
+ * Mappings can't overlap in GPA space or userspace.
+ * To unmap, these fields must match an existing mapping.
+ */
+typedef struct mshv_user_mem_region {
+	__u64 size;
+	__u64 guest_pfn;
+	__u64 userspace_addr;
+	__u8 flags;
+	__u8 rsvd[7];
+} mshv_user_mem_region;
+
+enum {
+	MSHV_SET_MEM_BIT_WRITABLE,
+	MSHV_SET_MEM_BIT_EXECUTABLE,
+	MSHV_SET_MEM_BIT_UNMAP,
+	MSHV_SET_MEM_BIT_COUNT
+};
+#define MSHV_SET_MEM_FLAGS_MASK ((1 << MSHV_SET_MEM_BIT_COUNT) - 1)
+
+enum {
+	MSHV_PT_BIT_LAPIC,
+	MSHV_PT_BIT_X2APIC,
+	MSHV_PT_BIT_GPA_SUPER_PAGES,
+	MSHV_PT_BIT_COUNT,
+};
+#define MSHV_PT_FLAGS_MASK ((1 << MSHV_PT_BIT_COUNT) - 1)
+
+enum {
+	MSHV_PT_ISOLATION_NONE,
+	MSHV_PT_ISOLATION_SNP,
+	MSHV_PT_ISOLATION_COUNT,
+};
+
+enum {
+	MSHV_IOEVENTFD_BIT_DATAMATCH,
+	MSHV_IOEVENTFD_BIT_PIO,
+	MSHV_IOEVENTFD_BIT_DEASSIGN,
+	MSHV_IOEVENTFD_BIT_COUNT,
+};
+#define MSHV_IOEVENTFD_FLAGS_MASK	((1 << MSHV_IOEVENTFD_BIT_COUNT) - 1)
+
+union hv_interrupt_control {
+	__u64 as_uint64;
+	struct {
+		__u32 interrupt_type; /* enum hv_interrupt type */
+		__u32 level_triggered : 1;
+		__u32 logical_dest_mode : 1;
+		__u32 rsvd : 30;
+	};
+};
+
+struct hv_input_assert_virtual_interrupt {
+	__u64 partition_id;
+	union hv_interrupt_control control;
+	__u64 dest_addr; /* cpu's apic id */
+	__u32 vector;
+	__u8 target_vtl;
+	__u8 rsvd_z0;
+	__u16 rsvd_z1;
+};
+
+struct hv_register_x64_cpuid_result_parameters {
+	struct {
+		__u32 eax;
+		__u32 ecx;
+		__u8 subleaf_specific;
+		__u8 always_override;
+		__u16 padding;
+	} input;
+	struct {
+		__u32 eax;
+		__u32 eax_mask;
+		__u32 ebx;
+		__u32 ebx_mask;
+		__u32 ecx;
+		__u32 ecx_mask;
+		__u32 edx;
+		__u32 edx_mask;
+	} result;
+};
+
+struct hv_register_x64_msr_result_parameters {
+	__u32 msr_index;
+	__u32 access_type;
+	__u32 action; /* enum hv_unimplemented_msr_action */
+};
+
+union hv_register_intercept_result_parameters {
+	struct hv_register_x64_cpuid_result_parameters cpuid;
+	struct hv_register_x64_msr_result_parameters msr;
+};
+
+struct mshv_register_intercept_result {
+	__u32 intercept_type; /* enum hv_intercept_type */
+	union hv_register_intercept_result_parameters parameters;
+};
+
+typedef struct mshv_user_ioeventfd {
+	__u64 datamatch;
+	__u64 addr;	   /* legal pio/mmio address */
+	__u32 len;	   /* 1, 2, 4, or 8 bytes    */
+	__s32 fd;
+	__u32 flags;
+	__u8  rsvd[4];
+} mshv_user_ioeventfd;
+
+typedef struct mshv_user_irq_entry {
+	__u32 gsi;
+	__u32 address_lo;
+	__u32 address_hi;
+	__u32 data;
+} mshv_user_irq_entry;
+
+struct mshv_user_irq_table {
+	__u32 nr;
+	__u32 rsvd; /* MBZ */
+	struct mshv_user_irq_entry entries[0];
+};
+
+enum {
+	MSHV_IRQFD_BIT_DEASSIGN,
+	MSHV_IRQFD_BIT_RESAMPLE,
+	MSHV_IRQFD_BIT_COUNT,
+};
+#define MSHV_IRQFD_FLAGS_MASK	((1 << MSHV_IRQFD_BIT_COUNT) - 1)
+
+struct mshv_user_irqfd {
+	__s32 fd;
+	__s32 resamplefd;
+	__u32 gsi;
+	__u32 flags;
+};
+
+/**
+ * struct mshv_create_partition - arguments for MSHV_CREATE_PARTITION
+ * @pt_flags: Bitmask of 1 << MSHV_PT_BIT_*
+ * @pt_isolation: MSHV_PT_ISOLATION_*
+ *
+ * Returns a file descriptor to act as a handle to a guest partition.
+ * At this point the partition is not yet initialized in the hypervisor.
+ * Some operations must be done with the partition in this state, e.g. setting
+ * so-called "early" partition properties. The partition can then be
+ * initialized with MSHV_INITIALIZE_PARTITION.
+ */
+struct mshv_create_partition {
+	__u64 pt_flags;
+	__u64 pt_isolation;
+};
+
+struct mshv_create_vp {
+	__u32 vp_index;
+};
+
+enum hv_translate_gva_result_code {
+	HV_TRANSLATE_GVA_SUCCESS					= 0,
+
+	/* Translation failures. */
+	HV_TRANSLATE_GVA_PAGE_NOT_PRESENT			= 1,
+	HV_TRANSLATE_GVA_PRIVILEGE_VIOLATION		= 2,
+	HV_TRANSLATE_GVA_INVALIDE_PAGE_TABLE_FLAGS	= 3,
+
+	/* GPA access failures. */
+	HV_TRANSLATE_GVA_GPA_UNMAPPED				= 4,
+	HV_TRANSLATE_GVA_GPA_NO_READ_ACCESS			= 5,
+	HV_TRANSLATE_GVA_GPA_NO_WRITE_ACCESS		= 6,
+	HV_TRANSLATE_GVA_GPA_ILLEGAL_OVERLAY_ACCESS	= 7,
+
+	/*
+	 * Intercept for memory access by either
+	 *  - a higher VTL
+	 *  - a nested hypervisor (due to a violation of the nested page table)
+	 */
+	HV_TRANSLATE_GVA_INTERCEPT					= 8,
+
+	HV_TRANSLATE_GVA_GPA_UNACCEPTED				= 9,
+};
+
+union hv_translate_gva_result {
+	__u64 as_uint64;
+	struct {
+		__u32 result_code; /* enum hv_translate_hva_result_code */
+		__u32 cache_type : 8;
+		__u32 overlay_page : 1;
+		__u32 reserved : 23;
+	};
+};
+
+typedef struct mshv_translate_gva {
+	__u64 gva;
+	__u64 flags;
+	union hv_translate_gva_result *result;
+	__u64 *gpa;
+} mshv_translate_gva;
+
+/* /dev/mshv */
+#define MSHV_CREATE_PARTITION	_IOW(MSHV_IOCTL, 0x00, struct mshv_create_partition)
+#define MSHV_CREATE_VP			_IOW(MSHV_IOCTL, 0x01, struct mshv_create_vp)
+
+/* Partition fds created with MSHV_CREATE_PARTITION */
+#define MSHV_INITIALIZE_PARTITION	_IO(MSHV_IOCTL, 0x00)
+#define MSHV_SET_GUEST_MEMORY		_IOW(MSHV_IOCTL, 0x02, struct mshv_user_mem_region)
+#define MSHV_IRQFD					_IOW(MSHV_IOCTL, 0x03, struct mshv_user_irqfd)
+#define MSHV_IOEVENTFD			    _IOW(MSHV_IOCTL, 0x04, struct mshv_user_ioeventfd)
+#define MSHV_SET_MSI_ROUTING		_IOW(MSHV_IOCTL, 0x05, struct mshv_user_irq_table)
+
+/* TODO: replace with ROOT_HVCALL */
+#define MSHV_GET_VP_REGISTERS		_IOWR(MSHV_IOCTL, 0xF0, struct mshv_vp_registers)
+#define MSHV_SET_VP_REGISTERS		_IOW(MSHV_IOCTL, 0xF1, struct mshv_vp_registers)
+#define MSHV_TRANSLATE_GVA			_IOWR(MSHV_IOCTL, 0xF2, struct mshv_translate_gva)
+
+#define MSHV_VP_REGISTER_INTERCEPT_RESULT _IOW(MSHV_IOCTL, 0xF3, struct mshv_register_intercept_result)
+
+/*
+ ********************************
+ * VP APIs for child partitions *
+ ********************************
+ */
+
+enum {
+	MSHV_VP_STATE_LAPIC = 0,
+	MSHV_VP_STATE_XSAVE, /* XSAVE data in compacted form */
+	MSHV_VP_STATE_SIMP,
+	MSHV_VP_STATE_SIEFP,
+	MSHV_VP_STATE_SYNTHETIC_TIMERS,
+	MSHV_VP_STATE_COUNT,
+};
+
+typedef struct mshv_get_set_vp_state {
+	__u8 type;	/* MSHV_VP_STATE_* */
+	__u8 rsvd[3];	/* MBZ */
+	__u32 buf_sz;	/* in - 4k page-aligned size of buffer.
+			 * out - actual size of data.
+			 * On EINVAL, check this to see if buffer was too small
+			 */
+	__u64 buf_ptr;	/* 4k page-aligned data buffer. */
+} mshv_get_set_vp_state;
+
+struct hv_local_interrupt_controller_state {
+	/* HV_X64_INTERRUPT_CONTROLLER_STATE */
+	__u32 apic_id;
+	__u32 apic_version;
+	__u32 apic_ldr;
+	__u32 apic_dfr;
+	__u32 apic_spurious;
+	__u32 apic_isr[8];
+	__u32 apic_tmr[8];
+	__u32 apic_irr[8];
+	__u32 apic_esr;
+	__u32 apic_icr_high;
+	__u32 apic_icr_low;
+	__u32 apic_lvt_timer;
+	__u32 apic_lvt_thermal;
+	__u32 apic_lvt_perfmon;
+	__u32 apic_lvt_lint0;
+	__u32 apic_lvt_lint1;
+	__u32 apic_lvt_error;
+	__u32 apic_lvt_cmci;
+	__u32 apic_error_status;
+	__u32 apic_initial_count;
+	__u32 apic_counter_value;
+	__u32 apic_divide_configuration;
+	__u32 apic_remote_read;
+};
+
+#define MSHV_RUN_VP_BUF_SZ 256
+
+struct mshv_run_vp {
+	__u8 msg_buf[MSHV_RUN_VP_BUF_SZ];
+};
+
+#define MSHV_RUN_VP			    _IOR(MSHV_IOCTL, 0x00, struct mshv_run_vp)
+#define MSHV_GET_VP_STATE		_IOWR(MSHV_IOCTL, 0x01, struct mshv_get_set_vp_state)
+#define MSHV_SET_VP_STATE		_IOWR(MSHV_IOCTL, 0x02, struct mshv_get_set_vp_state)
+
+/**
+ * struct mshv_root_hvcall - arguments for MSHV_ROOT_HVCALL
+ * @code: Hypercall code (HVCALL_*)
+ * @reps: in: Rep count ('repcount')
+ *	  out: Reps completed ('repcomp'). MBZ unless rep hvcall
+ * @in_sz: Size of input incl rep data. <= HV_HYP_PAGE_SIZE
+ * @out_sz: Size of output buffer. <= HV_HYP_PAGE_SIZE. MBZ if out_ptr is 0
+ * @status: in: MBZ
+ *	    out: HV_STATUS_* from hypercall
+ * @rsvd: MBZ
+ * @in_ptr: Input data buffer (struct hv_input_*). If used with partition or
+ *	    vp fd, partition id field is added by kernel.
+ * @out_ptr: Output data buffer (optional)
+ */
+struct mshv_root_hvcall {
+	__u16 code;
+	__u16 reps;
+	__u16 in_sz;
+	__u16 out_sz;
+	__u16 status;
+	__u8 rsvd[6];
+	__u64 in_ptr;
+	__u64 out_ptr;
+};
+
+/* Generic hypercall */
+#define MSHV_ROOT_HVCALL		_IOWR(MSHV_IOCTL, 0x07, struct mshv_root_hvcall)
+
+/* From hvgdk_mini.h */
+
+#define HV_X64_MSR_GUEST_OS_ID		0x40000000
+#define HV_X64_MSR_SINT0			0x40000090
+#define HV_X64_MSR_SINT1			0x40000091
+#define HV_X64_MSR_SINT2			0x40000092
+#define HV_X64_MSR_SINT3			0x40000093
+#define HV_X64_MSR_SINT4			0x40000094
+#define HV_X64_MSR_SINT5			0x40000095
+#define HV_X64_MSR_SINT6			0x40000096
+#define HV_X64_MSR_SINT7			0x40000097
+#define HV_X64_MSR_SINT8			0x40000098
+#define HV_X64_MSR_SINT9			0x40000099
+#define HV_X64_MSR_SINT10			0x4000009A
+#define HV_X64_MSR_SINT11			0x4000009B
+#define HV_X64_MSR_SINT12			0x4000009C
+#define HV_X64_MSR_SINT13			0x4000009D
+#define HV_X64_MSR_SINT14			0x4000009E
+#define HV_X64_MSR_SINT15			0x4000009F
+#define HV_X64_MSR_SCONTROL			0x40000080
+#define HV_X64_MSR_SIEFP			0x40000082
+#define HV_X64_MSR_SIMP				0x40000083
+#define HV_X64_MSR_REFERENCE_TSC	0x40000021
+#define HV_X64_MSR_EOM				0x40000084
+
+/* Define port identifier type. */
+union hv_port_id {
+	__u32 as__u32;
+	struct {
+		__u32 id : 24;
+		__u32 reserved : 8;
+	};
+};
+
+#define HV_MESSAGE_SIZE			        (256)
+#define HV_MESSAGE_PAYLOAD_BYTE_COUNT	(240)
+#define HV_MESSAGE_PAYLOAD_QWORD_COUNT	(30)
+
+/* Define hypervisor message types. */
+enum hv_message_type {
+	HVMSG_NONE							= 0x00000000,
+
+	/* Memory access messages. */
+	HVMSG_UNMAPPED_GPA					= 0x80000000,
+	HVMSG_GPA_INTERCEPT					= 0x80000001,
+	HVMSG_UNACCEPTED_GPA				= 0x80000003,
+	HVMSG_GPA_ATTRIBUTE_INTERCEPT		= 0x80000004,
+
+	/* Timer notification messages. */
+	HVMSG_TIMER_EXPIRED					= 0x80000010,
+
+	/* Error messages. */
+	HVMSG_INVALID_VP_REGISTER_VALUE		= 0x80000020,
+	HVMSG_UNRECOVERABLE_EXCEPTION		= 0x80000021,
+	HVMSG_UNSUPPORTED_FEATURE			= 0x80000022,
+
+	/*
+	 * Opaque intercept message. The original intercept message is only
+	 * accessible from the mapped intercept message page.
+	 */
+	HVMSG_OPAQUE_INTERCEPT				= 0x8000003F,
+
+	/* Trace buffer complete messages. */
+	HVMSG_EVENTLOG_BUFFERCOMPLETE		= 0x80000040,
+
+	/* Hypercall intercept */
+	HVMSG_HYPERCALL_INTERCEPT			= 0x80000050,
+
+	/* SynIC intercepts */
+	HVMSG_SYNIC_EVENT_INTERCEPT			= 0x80000060,
+	HVMSG_SYNIC_SINT_INTERCEPT			= 0x80000061,
+	HVMSG_SYNIC_SINT_DELIVERABLE		= 0x80000062,
+
+	/* Async call completion intercept */
+	HVMSG_ASYNC_CALL_COMPLETION			= 0x80000070,
+
+	/* Root scheduler messages */
+	HVMSG_SCHEDULER_VP_SIGNAL_BITSE		= 0x80000100,
+	HVMSG_SCHEDULER_VP_SIGNAL_PAIR		= 0x80000101,
+
+	/* Platform-specific processor intercept messages. */
+	HVMSG_X64_IO_PORT_INTERCEPT			= 0x80010000,
+	HVMSG_X64_MSR_INTERCEPT				= 0x80010001,
+	HVMSG_X64_CPUID_INTERCEPT			= 0x80010002,
+	HVMSG_X64_EXCEPTION_INTERCEPT		= 0x80010003,
+	HVMSG_X64_APIC_EOI					= 0x80010004,
+	HVMSG_X64_LEGACY_FP_ERROR			= 0x80010005,
+	HVMSG_X64_IOMMU_PRQ					= 0x80010006,
+	HVMSG_X64_HALT						= 0x80010007,
+	HVMSG_X64_INTERRUPTION_DELIVERABLE	= 0x80010008,
+	HVMSG_X64_SIPI_INTERCEPT			= 0x80010009,
+	HVMSG_X64_SEV_VMGEXIT_INTERCEPT		= 0x80010013,
+};
+
+union hv_x64_vp_execution_state {
+	__u16 as_uint16;
+	struct {
+		__u16 cpl:2;
+		__u16 cr0_pe:1;
+		__u16 cr0_am:1;
+		__u16 efer_lma:1;
+		__u16 debug_active:1;
+		__u16 interruption_pending:1;
+		__u16 vtl:4;
+		__u16 enclave_mode:1;
+		__u16 interrupt_shadow:1;
+		__u16 virtualization_fault_active:1;
+		__u16 reserved:2;
+	};
+};
+
+/* From openvmm::hvdef */
+enum hv_x64_intercept_access_type {
+	HV_X64_INTERCEPT_ACCESS_TYPE_READ = 0,
+	HV_X64_INTERCEPT_ACCESS_TYPE_WRITE = 1,
+	HV_X64_INTERCEPT_ACCESS_TYPE_EXECUTE = 2,
+};
+
+struct hv_x64_intercept_message_header {
+	__u32 vp_index;
+	__u8 instruction_length:4;
+	__u8 cr8:4; /* Only set for exo partitions */
+	__u8 intercept_access_type;
+	union hv_x64_vp_execution_state execution_state;
+	struct hv_x64_segment_register cs_segment;
+	__u64 rip;
+	__u64 rflags;
+};
+
+union hv_x64_io_port_access_info {
+	__u8 as_uint8;
+	struct {
+		__u8 access_size:3;
+		__u8 string_op:1;
+		__u8 rep_prefix:1;
+		__u8 reserved:3;
+	};
+};
+
+typedef struct hv_x64_io_port_intercept_message {
+	struct hv_x64_intercept_message_header header;
+	__u16 port_number;
+	union hv_x64_io_port_access_info access_info;
+	__u8 instruction_byte_count;
+	__u32 reserved;
+	__u64 rax;
+	__u8 instruction_bytes[16];
+	struct hv_x64_segment_register ds_segment;
+	struct hv_x64_segment_register es_segment;
+	__u64 rcx;
+	__u64 rsi;
+	__u64 rdi;
+} hv_x64_io_port_intercept_message;
+
+union hv_x64_memory_access_info {
+	__u8 as_uint8;
+	struct {
+		__u8 gva_valid:1;
+		__u8 gva_gpa_valid:1;
+		__u8 hypercall_output_pending:1;
+		__u8 tlb_locked_no_overlay:1;
+		__u8 reserved:4;
+	};
+};
+
+struct hv_x64_memory_intercept_message {
+	struct hv_x64_intercept_message_header header;
+	__u32 cache_type; /* enum hv_cache_type */
+	__u8 instruction_byte_count;
+	union hv_x64_memory_access_info memory_access_info;
+	__u8 tpr_priority;
+	__u8 reserved1;
+	__u64 guest_virtual_address;
+	__u64 guest_physical_address;
+	__u8 instruction_bytes[16];
+};
+
+union hv_message_flags {
+	__u8 asu8;
+	struct {
+		__u8 msg_pending : 1;
+		__u8 reserved : 7;
+	};
+};
+
+struct hv_message_header {
+	__u32 message_type;
+	__u8 payload_size;
+	union hv_message_flags message_flags;
+	__u8 reserved[2];
+	union {
+		__u64 sender;
+		union hv_port_id port;
+	};
+};
+
+struct hv_message {
+	struct hv_message_header header;
+	union {
+		__u64 payload[HV_MESSAGE_PAYLOAD_QWORD_COUNT];
+	} u;
+};
+
+/* From  github.com/rust-vmm/mshv-bindings/src/x86_64/regs.rs */
+
+struct hv_cpuid_entry {
+	uint32_t function;
+	uint32_t index;
+	uint32_t flags;
+	uint32_t eax;
+	uint32_t ebx;
+	uint32_t ecx;
+	uint32_t edx;
+	uint32_t padding[3];
+};
+
+struct hv_cpuid {
+	uint32_t nent;
+	uint32_t padding;
+	struct hv_cpuid_entry entries[0];
+};
+
+#define IA32_MSR_TSC 			0x00000010
+#define IA32_MSR_EFER 			0xC0000080
+#define IA32_MSR_KERNEL_GS_BASE 0xC0000102
+#define IA32_MSR_APIC_BASE 		0x0000001B
+#define IA32_MSR_PAT 			0x0277
+#define IA32_MSR_SYSENTER_CS 	0x00000174
+#define IA32_MSR_SYSENTER_ESP 	0x00000175
+#define IA32_MSR_SYSENTER_EIP 	0x00000176
+#define IA32_MSR_STAR 			0xC0000081
+#define IA32_MSR_LSTAR 			0xC0000082
+#define IA32_MSR_CSTAR 			0xC0000083
+#define IA32_MSR_SFMASK 		0xC0000084
+
+#define IA32_MSR_MTRR_CAP 		0x00FE
+#define IA32_MSR_MTRR_DEF_TYPE 	0x02FF
+#define IA32_MSR_MTRR_PHYSBASE0 0x0200
+#define IA32_MSR_MTRR_PHYSMASK0 0x0201
+#define IA32_MSR_MTRR_PHYSBASE1 0x0202
+#define IA32_MSR_MTRR_PHYSMASK1 0x0203
+#define IA32_MSR_MTRR_PHYSBASE2 0x0204
+#define IA32_MSR_MTRR_PHYSMASK2 0x0205
+#define IA32_MSR_MTRR_PHYSBASE3 0x0206
+#define IA32_MSR_MTRR_PHYSMASK3 0x0207
+#define IA32_MSR_MTRR_PHYSBASE4 0x0208
+#define IA32_MSR_MTRR_PHYSMASK4 0x0209
+#define IA32_MSR_MTRR_PHYSBASE5 0x020A
+#define IA32_MSR_MTRR_PHYSMASK5 0x020B
+#define IA32_MSR_MTRR_PHYSBASE6 0x020C
+#define IA32_MSR_MTRR_PHYSMASK6 0x020D
+#define IA32_MSR_MTRR_PHYSBASE7 0x020E
+#define IA32_MSR_MTRR_PHYSMASK7 0x020F
+
+#define IA32_MSR_MTRR_FIX64K_00000 0x0250
+#define IA32_MSR_MTRR_FIX16K_80000 0x0258
+#define IA32_MSR_MTRR_FIX16K_A0000 0x0259
+#define IA32_MSR_MTRR_FIX4K_C0000 0x0268
+#define IA32_MSR_MTRR_FIX4K_C8000 0x0269
+#define IA32_MSR_MTRR_FIX4K_D0000 0x026A
+#define IA32_MSR_MTRR_FIX4K_D8000 0x026B
+#define IA32_MSR_MTRR_FIX4K_E0000 0x026C
+#define IA32_MSR_MTRR_FIX4K_E8000 0x026D
+#define IA32_MSR_MTRR_FIX4K_F0000 0x026E
+#define IA32_MSR_MTRR_FIX4K_F8000 0x026F
+
+#define IA32_MSR_TSC_AUX 		  0xC0000103
+#define IA32_MSR_BNDCFGS 		  0x00000d90
+#define IA32_MSR_DEBUG_CTL 		  0x1D9
+#define IA32_MSR_SPEC_CTRL        0x00000048
+#define IA32_MSR_TSC_ADJUST 	  0x0000003b
+
+#define IA32_MSR_MISC_ENABLE 0x000001a0
+
+
+#define HV_TRANSLATE_GVA_VALIDATE_READ	     (0x0001)
+#define HV_TRANSLATE_GVA_VALIDATE_WRITE      (0x0002)
+#define HV_TRANSLATE_GVA_VALIDATE_EXECUTE    (0x0004)
+
+#endif
-- 
2.34.1


