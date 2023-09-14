Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8271379F920
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 05:52:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgdOW-0005np-KJ; Wed, 13 Sep 2023 23:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qgdOT-0005ne-Ob
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:51:53 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qgdOR-0000r7-V9
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694663511; x=1726199511;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nXW61my95eNNBPjniGhuCSrvIHpi6M9elto/Cof61xQ=;
 b=Tr08YD+kckJ5qvZDg7gO2p2K0gzOBJ/D/OvKq7w49LExeoy2tjoN2efW
 G4GrKAYgHunjVn15IufJgFPEaYE7FX3IaUfPKDnJ7CKAke4zSfnqndjMR
 uInDvOp4MvN+hZllA8FrK3Vlkx+MSvUpWbk0Owgn5B+9D2ZvbhKbxNlI7
 aQC38Ag2d/3glrSCNiCK6WeqsMyy2Lg+YxwIl1jdAUTMweAR392A1pwZr
 lLDHT19OO6WFfu4IubGv8+B5+gRQGr296MLQfJX2gtV5ORpFdiYnWcsxJ
 5afr7Lu/jSLIF/lVIbm6kOfsHrqZMtIsOd9x0gvqNJO9Zy+48kH5cmRjj A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="381528360"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; d="scan'208";a="381528360"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2023 20:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="814500581"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; d="scan'208";a="814500581"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmsmga004.fm.intel.com with ESMTP; 13 Sep 2023 20:51:46 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, xiaoyao.li@intel.com,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>
Subject: [RFC PATCH v2 06/21] i386: Add support for sw-protected-vm object
Date: Wed, 13 Sep 2023 23:51:02 -0400
Message-Id: <20230914035117.3285885-7-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914035117.3285885-1-xiaoyao.li@intel.com>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.24; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Introduce sw-protected-vm object which implements the interface of
CONFIDENTIAL_GUEST_SUPPORT, and will be used to create
X86_SW_PROTECTED_VM via

  $qemu -machine ...,confidential-guest-support=sp-vm0	\
        -object sw-protected-vm,id=sp-vm0

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 qapi/qom.json                     |  1 +
 target/i386/kvm/meson.build       |  1 +
 target/i386/kvm/sw-protected-vm.c | 35 +++++++++++++++++++++++++++++++
 target/i386/kvm/sw-protected-vm.h | 17 +++++++++++++++
 4 files changed, 54 insertions(+)
 create mode 100644 target/i386/kvm/sw-protected-vm.c
 create mode 100644 target/i386/kvm/sw-protected-vm.h

diff --git a/qapi/qom.json b/qapi/qom.json
index d28c5403bc0f..be054ee2f348 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -944,6 +944,7 @@
       'if': 'CONFIG_SECRET_KEYRING' },
     'sev-guest',
     'thread-context',
+    'sw-protected-vm',
     's390-pv-guest',
     'throttle-group',
     'tls-creds-anon',
diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
index 40fbde96cac6..a31e760b3f19 100644
--- a/target/i386/kvm/meson.build
+++ b/target/i386/kvm/meson.build
@@ -5,6 +5,7 @@ i386_softmmu_kvm_ss = ss.source_set()
 i386_softmmu_kvm_ss.add(files(
   'kvm.c',
   'kvm-cpu.c',
+  'sw-protected-vm.c',
 ))
 
 i386_softmmu_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files('xen-emu.c'))
diff --git a/target/i386/kvm/sw-protected-vm.c b/target/i386/kvm/sw-protected-vm.c
new file mode 100644
index 000000000000..62a1d3d5d3fe
--- /dev/null
+++ b/target/i386/kvm/sw-protected-vm.c
@@ -0,0 +1,35 @@
+/*
+ * QEMU X86_SW_PROTECTED_VM SUPPORT
+ *
+ * Author:
+ *      Xiaoyao Li <xiaoyao.li@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qom/object_interfaces.h"
+
+#include "sw-protected-vm.h"
+
+/* x86-sw-protected-vm */
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(SwProtectedVm,
+                                   sw_protected_vm,
+                                   SW_PROTECTED_VM,
+                                   CONFIDENTIAL_GUEST_SUPPORT,
+                                   { TYPE_USER_CREATABLE },
+                                   { NULL })
+
+static void sw_protected_vm_init(Object *obj)
+{
+}
+
+static void sw_protected_vm_finalize(Object *obj)
+{
+}
+
+static void sw_protected_vm_class_init(ObjectClass *oc, void *data)
+{
+}
diff --git a/target/i386/kvm/sw-protected-vm.h b/target/i386/kvm/sw-protected-vm.h
new file mode 100644
index 000000000000..db192a81c75e
--- /dev/null
+++ b/target/i386/kvm/sw-protected-vm.h
@@ -0,0 +1,17 @@
+#ifndef QEMU_I386_SW_PROTECTED_VM_H
+#define QEMU_I386_SW_PROTECTED_VM_H
+
+#include "exec/confidential-guest-support.h"
+
+#define TYPE_SW_PROTECTED_VM    "sw-protected-vm"
+#define SW_PROTECTED_VM(obj)    OBJECT_CHECK(SwProtectedVm, (obj), TYPE_SW_PROTECTED_VM)
+
+typedef struct SwProtectedVmClass {
+    ConfidentialGuestSupportClass parent_class;
+} SwProtectedVmClass;
+
+typedef struct SwProtectedVm {
+    ConfidentialGuestSupport parent_obj;
+} SwProtectedVm;
+
+#endif /* QEMU_I386_SW_PROTECTED_VM_H */
-- 
2.34.1


