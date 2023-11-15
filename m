Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE427EBDFF
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 08:24:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3AFJ-0000oG-21; Wed, 15 Nov 2023 02:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3AEn-0007rS-Uj
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:23:03 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3AEl-0005mw-Vt
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700032979; x=1731568979;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bd6HZW/Pw5TN9crVCH44/stsQg4jpEidGx7gJrLBbgM=;
 b=WT23yyvhKhTjr7faRKYSn2QrBkkRv7MvC3ol7mSZC5Gv5neew92fu6Nn
 BOqHMN3Up1kR8xmm7Qk8Jvmin2eBSPJdH1xhU2hzAsEvibEaxj8cSy1JJ
 yQPOj4rQWMDesUkE+zAXy88V79mhqYWi7FpejjIzDpCzz1spJEGhYd9/N
 D61N1n1tbRzOZcfnedKKbKC6EFBPaG4NDhdgSfJWLtfBRja/yRboD3JQQ
 ZzQw2v9lX8LEHdqm0EArEVtFDvB7QuMaUPetPEj2g8nGO8EkuMGYPPJSC
 Zb5dhWzTwPG0J2o15FUhfcKD0OeQkHSewz9mBVpqmJ6HQL/h2tFXamzx4 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390623508"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="390623508"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 23:22:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="714800322"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="714800322"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orsmga003.jf.intel.com with ESMTP; 14 Nov 2023 23:22:51 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, xiaoyao.li@intel.com,
 Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PATCH v3 57/70] i386/tdx: Wire TDX_REPORT_FATAL_ERROR with
 GuestPanic facility
Date: Wed, 15 Nov 2023 02:15:06 -0500
Message-Id: <20231115071519.2864957-58-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115071519.2864957-1-xiaoyao.li@intel.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.115; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Integrate TDX's TDX_REPORT_FATAL_ERROR into QEMU GuestPanic facility

Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes from v2:
- Add docmentation of new type and struct (Daniel)
- refine the error message handling (Daniel)
---
 qapi/run-state.json   | 27 ++++++++++++++++++++--
 system/runstate.c     | 54 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/kvm/tdx.c | 24 +++++++++++++++++--
 3 files changed, 101 insertions(+), 4 deletions(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index f216ba54ec4c..e18f62eaef77 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -496,10 +496,12 @@
 #
 # @s390: s390 guest panic information type (Since: 2.12)
 #
+# @tdx: tdx guest panic information type (Since: 8.2)
+#
 # Since: 2.9
 ##
 { 'enum': 'GuestPanicInformationType',
-  'data': [ 'hyper-v', 's390' ] }
+  'data': [ 'hyper-v', 's390', 'tdx' ] }
 
 ##
 # @GuestPanicInformation:
@@ -514,7 +516,8 @@
  'base': {'type': 'GuestPanicInformationType'},
  'discriminator': 'type',
  'data': {'hyper-v': 'GuestPanicInformationHyperV',
-          's390': 'GuestPanicInformationS390'}}
+          's390': 'GuestPanicInformationS390',
+          'tdx' : 'GuestPanicInformationTdx'}}
 
 ##
 # @GuestPanicInformationHyperV:
@@ -577,6 +580,26 @@
           'psw-addr': 'uint64',
           'reason': 'S390CrashReason'}}
 
+##
+# @GuestPanicInformationTdx:
+#
+# TDX GHCI TDG.VP.VMCALL<ReportFatalError> specific guest panic information
+#
+# @error-code: TD-specific error code
+#
+# @gpa: 4KB-aligned guest physical address of the page that containing
+#     additional error data
+#
+# @message: TD guest provided message string.  (It's not so trustable
+#     and cannot be assumed to be well formed because it comes from guest)
+#
+# Since: 8.2
+##
+{'struct': 'GuestPanicInformationTdx',
+ 'data': {'error-code': 'uint64',
+          'gpa': 'uint64',
+          'message': 'str'}}
+
 ##
 # @MEMORY_FAILURE:
 #
diff --git a/system/runstate.c b/system/runstate.c
index ea9d6c2a32a4..9275e2f265f3 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -518,6 +518,52 @@ static void qemu_system_wakeup(void)
     }
 }
 
+static char* tdx_parse_panic_message(char *message)
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
+        /* The caller guarantees the NUL-terminated string. */
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
+    if (!printable && len) {
+        /* 3 = length of "%02x " */
+        buf = g_malloc(len * 3);
+        for (i = 0; i < len; i++) {
+            if (message[i] == '\0') {
+                break;
+            } else {
+                sprintf(buf + 3 * i, "%02x ", message[i]);
+            }
+        }
+        if (i > 0)
+            /* replace the last ' '(space) to NUL */
+            buf[i * 3 - 1] = '\0';
+        else
+            buf[0] = '\0';
+
+        return buf;
+    }
+
+    return message;
+}
+
 void qemu_system_guest_panicked(GuestPanicInformation *info)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "Guest crashed");
@@ -559,7 +605,15 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
                           S390CrashReason_str(info->u.s390.reason),
                           info->u.s390.psw_mask,
                           info->u.s390.psw_addr);
+        } else if (info->type == GUEST_PANIC_INFORMATION_TYPE_TDX) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          " TDX guest reports fatal error:\"%s\""
+                          " error code: 0x%016" PRIx64 " gpa page: 0x%016" PRIx64 "\n",
+                          tdx_parse_panic_message(info->u.tdx.message),
+                          info->u.tdx.error_code,
+                          info->u.tdx.gpa);
         }
+
         qapi_free_GuestPanicInformation(info);
     }
 }
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index a42b5cea36c5..23504ba3b05e 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -20,6 +20,7 @@
 #include "qom/object_interfaces.h"
 #include "standard-headers/asm-x86/kvm_para.h"
 #include "sysemu/kvm.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 #include "exec/ramblock.h"
@@ -1479,11 +1480,26 @@ static void tdx_handle_get_quote(X86CPU *cpu, struct kvm_tdx_vmcall *vmcall)
     vmcall->status_code = TDG_VP_VMCALL_SUCCESS;
 }
 
+static void tdx_panicked_on_fatal_error(X86CPU *cpu, uint64_t error_code,
+                                        uint64_t gpa, char *message)
+{
+    GuestPanicInformation *panic_info;
+
+    panic_info = g_new0(GuestPanicInformation, 1);
+    panic_info->type = GUEST_PANIC_INFORMATION_TYPE_TDX;
+    panic_info->u.tdx.error_code = error_code;
+    panic_info->u.tdx.gpa = gpa;
+    panic_info->u.tdx.message = message;
+
+    qemu_system_guest_panicked(panic_info);
+}
+
 static void tdx_handle_report_fatal_error(X86CPU *cpu,
                                           struct kvm_tdx_vmcall *vmcall)
 {
     uint64_t error_code = vmcall->in_r12;
     char *message = NULL;
+    uint64_t gpa = -1ull;
 
     if (error_code & 0xffff) {
         error_report("invalid error code of TDG.VP.VMCALL<REPORT_FATAL_ERROR>\n");
@@ -1511,8 +1527,12 @@ static void tdx_handle_report_fatal_error(X86CPU *cpu,
         assert((char *)tmp == message + GUEST_PANIC_INFO_TDX_MESSAGE_MAX);
     }
 
-    error_report("TD guest reports fatal error. %s\n", message ? : "");
-    exit(1);
+#define TDX_REPORT_FATAL_ERROR_GPA_VALID    BIT_ULL(63)
+    if (error_code & TDX_REPORT_FATAL_ERROR_GPA_VALID) {
+        gpa = vmcall->in_r13;
+    }
+
+    tdx_panicked_on_fatal_error(cpu, error_code, gpa, message);
 }
 
 static void tdx_handle_setup_event_notify_interrupt(X86CPU *cpu,
-- 
2.34.1


