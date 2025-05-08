Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E11AAFEA0
	for <lists+qemu-devel@lfdr.de>; Thu,  8 May 2025 17:12:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2q8-0004uv-En; Thu, 08 May 2025 11:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2py-0004kH-CA
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:07:02 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2pv-0007RW-AP
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746716819; x=1778252819;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x2kqyFzDP0o/tEqatbnmXsZt2N2+iX3e/6TbvOqfIEk=;
 b=UamlupPjcVaUopw3vwmH4Hze1fdIZ+oEM4sDR9r1SfsjThIRmUz8huFz
 FVU6FeTgeiYAN6he7cWv7JVbo2ENKub2k1W+tRYeW000t0hyZH8o2YVys
 QxpLeM9SZKk60unWojh6h34HX7l7YgyryBhxR/A+lsPXC9w1kjmXFCNjW
 J7PlKXGmxmex3m0xSrRhPNMWLWFC25IaRkHPjRwHFDvwhVMy3okWou9S0
 bMRdFJzGFF2zoGKIqV6vUdfNVWSEA+JbdlDn4+i/5nZcgvNY6GwnDXxt4
 7xsnkCqevFYMDAPx/+6eIX3+9EFrNhNI+4+8hMOEtQatGfajLWrZicG4W Q==;
X-CSE-ConnectionGUID: n1ztRmSVToyGnSb8rFS5gA==
X-CSE-MsgGUID: H4FQGsgBQUW1ifVezjW1/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="73888257"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="73888257"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 08:06:25 -0700
X-CSE-ConnectionGUID: Vr7n9L7NRqyuur7/B4JFbw==
X-CSE-MsgGUID: XcQMzW4kRk2d38QSx5dvGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="141440109"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 08 May 2025 08:06:22 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v9 29/55] i386/tdx: Wire TDX_REPORT_FATAL_ERROR with
 GuestPanic facility
Date: Thu,  8 May 2025 10:59:35 -0400
Message-ID: <20250508150002.689633-30-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508150002.689633-1-xiaoyao.li@intel.com>
References: <20250508150002.689633-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Integrate TDX's TDX_REPORT_FATAL_ERROR into QEMU GuestPanic facility

Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes in v9:
- move the MACRO definition of TDX_REPORT_FATAL_ERROR_GPA_VALID out of
  the function; (Zhao Liu)

Changes in v8:
- use g_strdup() for copy string;
- use the new data ABI of KVM_SYSTEM_EVENT_TDX_FATAL to grab gpa info;

Changes in v6:
- change error_code of GuestPanicInformationTdx from uint64_t to
  uint32_t, to only contains the bit 31:0 returned in r12.

Changes in v5:
- mention additional error information in gpa when it presents;
- refine the documentation; (Markus)

Changes in v4:
- refine the documentation; (Markus)

Changes in v3:
- Add docmentation of new type and struct; (Daniel)
- refine the error message handling; (Daniel)
---
 qapi/run-state.json   | 31 +++++++++++++++++++--
 system/runstate.c     | 65 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/kvm/tdx.c | 25 ++++++++++++++++-
 3 files changed, 118 insertions(+), 3 deletions(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index ce95cfa46b73..ee11adc50889 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -501,10 +501,12 @@
 #
 # @s390: s390 guest panic information type (Since: 2.12)
 #
+# @tdx: tdx guest panic information type (Since: 10.1)
+#
 # Since: 2.9
 ##
 { 'enum': 'GuestPanicInformationType',
-  'data': [ 'hyper-v', 's390' ] }
+  'data': [ 'hyper-v', 's390', 'tdx' ] }
 
 ##
 # @GuestPanicInformation:
@@ -519,7 +521,8 @@
  'base': {'type': 'GuestPanicInformationType'},
  'discriminator': 'type',
  'data': {'hyper-v': 'GuestPanicInformationHyperV',
-          's390': 'GuestPanicInformationS390'}}
+          's390': 'GuestPanicInformationS390',
+          'tdx' : 'GuestPanicInformationTdx'}}
 
 ##
 # @GuestPanicInformationHyperV:
@@ -598,6 +601,30 @@
           'psw-addr': 'uint64',
           'reason': 'S390CrashReason'}}
 
+##
+# @GuestPanicInformationTdx:
+#
+# TDX Guest panic information specific to TDX, as specified in the
+# "Guest-Hypervisor Communication Interface (GHCI) Specification",
+# section TDG.VP.VMCALL<ReportFatalError>.
+#
+# @error-code: TD-specific error code
+#
+# @message: Human-readable error message provided by the guest. Not
+#     to be trusted.
+#
+# @gpa: guest-physical address of a page that contains more verbose
+#     error information, as zero-terminated string.  Present when the
+#     "GPA valid" bit (bit 63) is set in @error-code.
+#
+#
+# Since: 10.1
+##
+{'struct': 'GuestPanicInformationTdx',
+ 'data': {'error-code': 'uint32',
+          'message': 'str',
+          '*gpa': 'uint64'}}
+
 ##
 # @MEMORY_FAILURE:
 #
diff --git a/system/runstate.c b/system/runstate.c
index 272801d30769..e9d5d7505b4a 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -565,6 +565,58 @@ static void qemu_system_wakeup(void)
     }
 }
 
+static char *tdx_parse_panic_message(char *message)
+{
+    bool printable = false;
+    char *buf = NULL;
+    int len = 0, i;
+
+    /*
+     * Although message is defined as a json string, we shouldn't
+     * unconditionally treat it as is because the guest generated it and
+     * it's not necessarily trustable.
+     */
+    if (message) {
+        /* The caller guarantees the NULL-terminated string. */
+        len = strlen(message);
+
+        printable = len > 0;
+        for (i = 0; i < len; i++) {
+            if (!(0x20 <= message[i] && message[i] <= 0x7e)) {
+                printable = false;
+                break;
+            }
+        }
+    }
+
+    if (len == 0) {
+        buf = g_malloc(1);
+        buf[0] = '\0';
+    } else {
+        if (!printable) {
+            /* 3 = length of "%02x " */
+            buf = g_malloc(len * 3);
+            for (i = 0; i < len; i++) {
+                if (message[i] == '\0') {
+                    break;
+                } else {
+                    sprintf(buf + 3 * i, "%02x ", message[i]);
+                }
+            }
+            if (i > 0) {
+                /* replace the last ' '(space) to NULL */
+                buf[i * 3 - 1] = '\0';
+            } else {
+                buf[0] = '\0';
+            }
+        } else {
+            buf = g_strdup(message);
+        }
+    }
+
+    return buf;
+}
+
 void qemu_system_guest_panicked(GuestPanicInformation *info)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "Guest crashed");
@@ -606,7 +658,20 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
                           S390CrashReason_str(info->u.s390.reason),
                           info->u.s390.psw_mask,
                           info->u.s390.psw_addr);
+        } else if (info->type == GUEST_PANIC_INFORMATION_TYPE_TDX) {
+            char *message = tdx_parse_panic_message(info->u.tdx.message);
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "\nTDX guest reports fatal error."
+                          " error code: 0x%" PRIx32 " error message:\"%s\"\n",
+                          info->u.tdx.error_code, message);
+            g_free(message);
+            if (info->u.tdx.gpa != -1ull) {
+                qemu_log_mask(LOG_GUEST_ERROR, "Additional error information "
+                              "can be found at gpa page: 0x%" PRIx64 "\n",
+                              info->u.tdx.gpa);
+            }
         }
+
         qapi_free_GuestPanicInformation(info);
     }
 }
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 5a140e88eb92..e80586feb704 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -16,6 +16,7 @@
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
 #include "crypto/hash.h"
+#include "system/runstate.h"
 #include "system/system.h"
 #include "exec/ramblock.h"
 
@@ -622,18 +623,35 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
     return tdvf_parse_metadata(&tdx_guest->tdvf, flash_ptr, size);
 }
 
+static void tdx_panicked_on_fatal_error(X86CPU *cpu, uint64_t error_code,
+                                        char *message, uint64_t gpa)
+{
+    GuestPanicInformation *panic_info;
+
+    panic_info = g_new0(GuestPanicInformation, 1);
+    panic_info->type = GUEST_PANIC_INFORMATION_TYPE_TDX;
+    panic_info->u.tdx.error_code = (uint32_t) error_code;
+    panic_info->u.tdx.message = message;
+    panic_info->u.tdx.gpa = gpa;
+
+    qemu_system_guest_panicked(panic_info);
+}
+
 /*
  * Only 8 registers can contain valid ASCII byte stream to form the fatal
  * message, and their sequence is: R14, R15, RBX, RDI, RSI, R8, R9, RDX
  */
 #define TDX_FATAL_MESSAGE_MAX        64
 
+#define TDX_REPORT_FATAL_ERROR_GPA_VALID    BIT_ULL(63)
+
 int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
 {
     uint64_t error_code = run->system_event.data[R_R12];
     uint64_t reg_mask = run->system_event.data[R_ECX];
     char *message = NULL;
     uint64_t *tmp;
+    uint64_t gpa = -1ull;
 
     if (error_code & 0xffff) {
         error_report("TDX: REPORT_FATAL_ERROR: invalid error code: 0x%lx",
@@ -664,7 +682,12 @@ int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
     }
 #undef COPY_REG
 
-    error_report("TD guest reports fatal error. %s", message ? : "");
+    if (error_code & TDX_REPORT_FATAL_ERROR_GPA_VALID) {
+        gpa = run->system_event.data[R_R13];
+    }
+
+    tdx_panicked_on_fatal_error(cpu, error_code, message, gpa);
+
     return -1;
 }
 
-- 
2.43.0


