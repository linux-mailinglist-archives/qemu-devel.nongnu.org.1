Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 387297EBDEB
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 08:23:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3AEs-000882-5O; Wed, 15 Nov 2023 02:23:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3AEm-0007ps-CC
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:23:01 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3AEe-0005LS-W6
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:23:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700032972; x=1731568972;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8BrgXfAQfZqcjZLSqCUCb/djRTy+aDK5w/IlCWoRec8=;
 b=PxRzCAF6WtUw5GoShCgrHkg/Wl6Ih3X9m4gGv7Xkdv6hypCzH1Xc/5Td
 aVW6BtGZHLSPIGyk7apF9xcgs1x70ljr/45A7q4tIW9ujUm98P2qBbyR5
 smItW+zMud10m//+8D6O1+TkWSrYjW7OazoRWkwSQFEtPNpDKfAxcptvZ
 AQJ5UK6gER+1V630wVkR42+l0nrJrkr4UCJNAZQrz5EzZVqL291M0mr2m
 3RP26fwrUGRgndPIFT2+V9WCBJYuCT4zJ5oo+OsDx/nnJsl2OtS5obaou
 BrL5PCEbkbA1A26cuyN8sFdxQYH+h/33ZgwBPSKBJ2qIcVbosF5pLv4nE Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390623498"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="390623498"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 23:22:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="714800309"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="714800309"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orsmga003.jf.intel.com with ESMTP; 14 Nov 2023 23:22:45 -0800
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
Subject: [PATCH v3 56/70] i386/tdx: Handle TDG.VP.VMCALL<REPORT_FATAL_ERROR>
Date: Wed, 15 Nov 2023 02:15:05 -0500
Message-Id: <20231115071519.2864957-57-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115071519.2864957-1-xiaoyao.li@intel.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.115; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

TD guest can use TDG.VP.VMCALL<REPORT_FATAL_ERROR> to request termination
with error message encoded in GPRs.

Parse and print the error message, and terminate the TD guest in the
handler.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/tdx.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 96a10b0bb190..a42b5cea36c5 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1003,6 +1003,7 @@ static void tdx_guest_class_init(ObjectClass *oc, void *data)
 
 #define TDG_VP_VMCALL_MAP_GPA                           0x10001ULL
 #define TDG_VP_VMCALL_GET_QUOTE                         0x10002ULL
+#define TDG_VP_VMCALL_REPORT_FATAL_ERROR                0x10003ULL
 #define TDG_VP_VMCALL_SETUP_EVENT_NOTIFY_INTERRUPT      0x10004ULL
 
 #define TDG_VP_VMCALL_SUCCESS           0x0000000000000000ULL
@@ -1478,6 +1479,42 @@ static void tdx_handle_get_quote(X86CPU *cpu, struct kvm_tdx_vmcall *vmcall)
     vmcall->status_code = TDG_VP_VMCALL_SUCCESS;
 }
 
+static void tdx_handle_report_fatal_error(X86CPU *cpu,
+                                          struct kvm_tdx_vmcall *vmcall)
+{
+    uint64_t error_code = vmcall->in_r12;
+    char *message = NULL;
+
+    if (error_code & 0xffff) {
+        error_report("invalid error code of TDG.VP.VMCALL<REPORT_FATAL_ERROR>\n");
+        exit(1);
+    }
+
+    /* it has optional message */
+    if (vmcall->in_r14) {
+        uint64_t * tmp;
+
+#define GUEST_PANIC_INFO_TDX_MESSAGE_MAX        64
+        message = g_malloc0(GUEST_PANIC_INFO_TDX_MESSAGE_MAX + 1);
+
+        tmp = (uint64_t *)message;
+        /* The order is defined in TDX GHCI spec */
+        *(tmp++) = cpu_to_le64(vmcall->in_r14);
+        *(tmp++) = cpu_to_le64(vmcall->in_r15);
+        *(tmp++) = cpu_to_le64(vmcall->in_rbx);
+        *(tmp++) = cpu_to_le64(vmcall->in_rdi);
+        *(tmp++) = cpu_to_le64(vmcall->in_rsi);
+        *(tmp++) = cpu_to_le64(vmcall->in_r8);
+        *(tmp++) = cpu_to_le64(vmcall->in_r9);
+        *(tmp++) = cpu_to_le64(vmcall->in_rdx);
+        message[GUEST_PANIC_INFO_TDX_MESSAGE_MAX] = '\0';
+        assert((char *)tmp == message + GUEST_PANIC_INFO_TDX_MESSAGE_MAX);
+    }
+
+    error_report("TD guest reports fatal error. %s\n", message ? : "");
+    exit(1);
+}
+
 static void tdx_handle_setup_event_notify_interrupt(X86CPU *cpu,
                                                     struct kvm_tdx_vmcall *vmcall)
 {
@@ -1512,6 +1549,9 @@ static void tdx_handle_vmcall(X86CPU *cpu, struct kvm_tdx_vmcall *vmcall)
     case TDG_VP_VMCALL_GET_QUOTE:
         tdx_handle_get_quote(cpu, vmcall);
         break;
+    case TDG_VP_VMCALL_REPORT_FATAL_ERROR:
+        tdx_handle_report_fatal_error(cpu, vmcall);
+        break;
     case TDG_VP_VMCALL_SETUP_EVENT_NOTIFY_INTERRUPT:
         tdx_handle_setup_event_notify_interrupt(cpu, vmcall);
         break;
-- 
2.34.1


