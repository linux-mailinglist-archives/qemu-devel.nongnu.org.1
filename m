Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C11780967
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 12:00:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWwC1-0003x0-Nc; Fri, 18 Aug 2023 05:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwBy-0003wl-Pm
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:54:54 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwBw-0007V6-3e
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692352492; x=1723888492;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wfq2PaWbc9fbQ7uIuISP5p0awFJImI3phjNkL+qK1rQ=;
 b=l1RzehZPQmax5thrNyyWbDDqQoKLBodpibkQ/XGjYlg1crUIRPlYMJnB
 jNxA6OaDegrjDtPRyTqfFenlFCCVtutOThpEcuDcXZ7Hte9LvRnmh7qpz
 lLKLIedQAoAS4+nPmZCiag6cz5O8dW5+lo9JhAiNkbhoj+5wbRrtz5iqL
 EHIq0C8YLFSgPKXDroqBk2dYPBwBqOkNfyMxvmFslnPm8MskXx3PLQsDh
 zNfuLmtSkcNJ0hU7VTpHk1uXNCVNTavKPscVJ9c59UMtSee3Erendz605
 8XRNjnCki6owAEz8xLroKltHe7FH8HIoAJg/4GWgYdcBTPvmV1D6X7OkN g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371965623"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="371965623"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2023 02:54:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="849234807"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="849234807"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2023 02:54:46 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Laszlo Ersek <lersek@redhat.com>,
 xiaoyao.li@intel.com, Isaku Yamahata <isaku.yamahata@gmail.com>,
 erdemaktas@google.com, Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PATCH v2 05/58] i386/tdx: Implement tdx_kvm_init() to initialize TDX
 VM context
Date: Fri, 18 Aug 2023 05:49:48 -0400
Message-Id: <20230818095041.1973309-6-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818095041.1973309-1-xiaoyao.li@intel.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

Introduce tdx_kvm_init() and invoke it in kvm_confidential_guest_init()
if it's a TDX VM. More initialization will be added later.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
 target/i386/kvm/kvm.c       | 15 ++++++---------
 target/i386/kvm/meson.build |  2 +-
 target/i386/kvm/tdx-stub.c  |  8 ++++++++
 target/i386/kvm/tdx.c       |  7 +++++++
 target/i386/kvm/tdx.h       |  2 ++
 5 files changed, 24 insertions(+), 10 deletions(-)
 create mode 100644 target/i386/kvm/tdx-stub.c

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 051307437ecd..d6b988d6c2d1 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -63,6 +63,7 @@
 #include "migration/blocker.h"
 #include "exec/memattrs.h"
 #include "trace.h"
+#include "tdx.h"
 
 #include CONFIG_DEVICES
 
@@ -2637,6 +2638,8 @@ static int kvm_confidential_guest_init(MachineState *ms, Error **errp)
 {
     if (object_dynamic_cast(OBJECT(ms->cgs), TYPE_SEV_GUEST)) {
         return sev_kvm_init(ms->cgs, errp);
+    } else if (object_dynamic_cast(OBJECT(ms->cgs), TYPE_TDX_GUEST)) {
+        return tdx_kvm_init(ms, errp);
     }
 
     return 0;
@@ -2652,16 +2655,10 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     Error *local_err = NULL;
 
     /*
-     * Initialize SEV context, if required
+     * Initialize confidential guest (SEV/TDX) context, if required
      *
-     * If no memory encryption is requested (ms->cgs == NULL) this is
-     * a no-op.
-     *
-     * It's also a no-op if a non-SEV confidential guest support
-     * mechanism is selected.  SEV is the only mechanism available to
-     * select on x86 at present, so this doesn't arise, but if new
-     * mechanisms are supported in future (e.g. TDX), they'll need
-     * their own initialization either here or elsewhere.
+     * It's a no-op if a non-SEV/non-tdx confidential guest support
+     * mechanism is selected, i.e., ms->cgs == NULL
      */
     ret = kvm_confidential_guest_init(ms, &local_err);
     if (ret < 0) {
diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
index 21ab03fe1349..876350a387aa 100644
--- a/target/i386/kvm/meson.build
+++ b/target/i386/kvm/meson.build
@@ -11,7 +11,7 @@ i386_softmmu_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files('xen-emu.c'))
 
 i386_softmmu_kvm_ss.add(when: 'CONFIG_SEV', if_false: files('sev-stub.c'))
 
-i386_softmmu_kvm_ss.add(when: 'CONFIG_TDX', if_true: files('tdx.c'))
+i386_softmmu_kvm_ss.add(when: 'CONFIG_TDX', if_true: files('tdx.c'), if_false: files('tdx-stub.c'))
 
 i386_system_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'), if_false: files('hyperv-stub.c'))
 
diff --git a/target/i386/kvm/tdx-stub.c b/target/i386/kvm/tdx-stub.c
new file mode 100644
index 000000000000..1d866d5496bf
--- /dev/null
+++ b/target/i386/kvm/tdx-stub.c
@@ -0,0 +1,8 @@
+#include "qemu/osdep.h"
+
+#include "tdx.h"
+
+int tdx_kvm_init(MachineState *ms, Error **errp)
+{
+    return -EINVAL;
+}
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index d3792d4a3d56..77e33ae01147 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -12,10 +12,17 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qom/object_interfaces.h"
 
+#include "hw/i386/x86.h"
 #include "tdx.h"
 
+int tdx_kvm_init(MachineState *ms, Error **errp)
+{
+    return 0;
+}
+
 /* tdx guest */
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
                                    tdx_guest,
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 415aeb5af746..c8a23d95258d 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -16,4 +16,6 @@ typedef struct TdxGuest {
     uint64_t attributes;    /* TD attributes */
 } TdxGuest;
 
+int tdx_kvm_init(MachineState *ms, Error **errp);
+
 #endif /* QEMU_I386_TDX_H */
-- 
2.34.1


