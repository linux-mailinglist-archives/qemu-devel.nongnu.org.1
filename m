Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DD378092A
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 11:58:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWwBm-0003ur-Rq; Fri, 18 Aug 2023 05:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwBl-0003uj-0s
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:54:41 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwBi-0007V6-Dg
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692352478; x=1723888478;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Q8IroSyDQFB+UIZbVKvgZq4Ftf6oDuiJFFspwah04SQ=;
 b=b5xRTd6NK8YcJS76j6/yc+w+DJV0fODHdr6KhGnUrUL1OBRATI7VJ5nW
 15/6aL9AcYaYf6KLOdME4KUfvMJJVlI/OLFLMaHJ6a/ITn+m3Ly/NV/yG
 8Gniu3H877Jtk7EbGG4egxZHUsy4xGt6BFcl0T/+4GjuPXaSsm+etF9MP
 zT5QvopZk4T+JeO/7TSlI/GySYqcCxH0cV+fNrwnkkqarVO69Dj9Twcmf
 3XpAatE3qH06G6GmUp6lobAxHohMqTqeZTLhfr2U9Oj/2r68Ysj8lEalJ
 qLFjjkz1MeN4zr2ASt2FckjZLT8YAEWaZIb8g/j+smg/p8gV2dLUOLBUB A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371965552"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="371965552"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2023 02:54:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="849234778"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="849234778"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2023 02:54:30 -0700
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
Subject: [PATCH v2 02/58] i386: Introduce tdx-guest object
Date: Fri, 18 Aug 2023 05:49:45 -0400
Message-Id: <20230818095041.1973309-3-xiaoyao.li@intel.com>
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

Introduce tdx-guest object which implements the interface of
CONFIDENTIAL_GUEST_SUPPORT, and will be used to create TDX VMs (TDs) by

  qemu -machine ...,confidential-guest-support=tdx0	\
       -object tdx-guset,id=tdx0

It has only one property 'attributes' with fixed value 0 and not
configurable so far.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
changes from RFC-V4
- make @attributes not user-settable
---
 configs/devices/i386-softmmu/default.mak |  1 +
 hw/i386/Kconfig                          |  5 +++
 qapi/qom.json                            | 12 +++++++
 target/i386/kvm/meson.build              |  2 ++
 target/i386/kvm/tdx.c                    | 40 ++++++++++++++++++++++++
 target/i386/kvm/tdx.h                    | 19 +++++++++++
 6 files changed, 79 insertions(+)
 create mode 100644 target/i386/kvm/tdx.c
 create mode 100644 target/i386/kvm/tdx.h

diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/i386-softmmu/default.mak
index 598c6646dfc0..9b5ec59d65b0 100644
--- a/configs/devices/i386-softmmu/default.mak
+++ b/configs/devices/i386-softmmu/default.mak
@@ -18,6 +18,7 @@
 #CONFIG_QXL=n
 #CONFIG_SEV=n
 #CONFIG_SGA=n
+#CONFIG_TDX=n
 #CONFIG_TEST_DEVICES=n
 #CONFIG_TPM_CRB=n
 #CONFIG_TPM_TIS_ISA=n
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 9051083c1e78..929f6c3f0e85 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -10,6 +10,10 @@ config SGX
     bool
     depends on KVM
 
+config TDX
+    bool
+    depends on KVM
+
 config PC
     bool
     imply APPLESMC
@@ -26,6 +30,7 @@ config PC
     imply QXL
     imply SEV
     imply SGX
+    imply TDX
     imply TEST_DEVICES
     imply TPM_CRB
     imply TPM_TIS_ISA
diff --git a/qapi/qom.json b/qapi/qom.json
index e0b2044e3d20..2ca7ce7c0da5 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -866,6 +866,16 @@
             'reduced-phys-bits': 'uint32',
             '*kernel-hashes': 'bool' } }
 
+##
+# @TdxGuestProperties:
+#
+# Properties for tdx-guest objects.
+#
+# Since: 8.2
+##
+{ 'struct': 'TdxGuestProperties',
+  'data': { }}
+
 ##
 # @ThreadContextProperties:
 #
@@ -944,6 +954,7 @@
     'sev-guest',
     'thread-context',
     's390-pv-guest',
+    'tdx-guest',
     'throttle-group',
     'tls-creds-anon',
     'tls-creds-psk',
@@ -1010,6 +1021,7 @@
       'secret_keyring':             { 'type': 'SecretKeyringProperties',
                                       'if': 'CONFIG_SECRET_KEYRING' },
       'sev-guest':                  'SevGuestProperties',
+      'tdx-guest':                  'TdxGuestProperties',
       'thread-context':             'ThreadContextProperties',
       'throttle-group':             'ThrottleGroupProperties',
       'tls-creds-anon':             'TlsCredsAnonProperties',
diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
index 40fbde96cac6..21ab03fe1349 100644
--- a/target/i386/kvm/meson.build
+++ b/target/i386/kvm/meson.build
@@ -11,6 +11,8 @@ i386_softmmu_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files('xen-emu.c'))
 
 i386_softmmu_kvm_ss.add(when: 'CONFIG_SEV', if_false: files('sev-stub.c'))
 
+i386_softmmu_kvm_ss.add(when: 'CONFIG_TDX', if_true: files('tdx.c'))
+
 i386_system_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'), if_false: files('hyperv-stub.c'))
 
 i386_system_ss.add_all(when: 'CONFIG_KVM', if_true: i386_softmmu_kvm_ss)
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
new file mode 100644
index 000000000000..d3792d4a3d56
--- /dev/null
+++ b/target/i386/kvm/tdx.c
@@ -0,0 +1,40 @@
+/*
+ * QEMU TDX support
+ *
+ * Copyright Intel
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
+#include "tdx.h"
+
+/* tdx guest */
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
+                                   tdx_guest,
+                                   TDX_GUEST,
+                                   CONFIDENTIAL_GUEST_SUPPORT,
+                                   { TYPE_USER_CREATABLE },
+                                   { NULL })
+
+static void tdx_guest_init(Object *obj)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    tdx->attributes = 0;
+}
+
+static void tdx_guest_finalize(Object *obj)
+{
+}
+
+static void tdx_guest_class_init(ObjectClass *oc, void *data)
+{
+}
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
new file mode 100644
index 000000000000..415aeb5af746
--- /dev/null
+++ b/target/i386/kvm/tdx.h
@@ -0,0 +1,19 @@
+#ifndef QEMU_I386_TDX_H
+#define QEMU_I386_TDX_H
+
+#include "exec/confidential-guest-support.h"
+
+#define TYPE_TDX_GUEST "tdx-guest"
+#define TDX_GUEST(obj)  OBJECT_CHECK(TdxGuest, (obj), TYPE_TDX_GUEST)
+
+typedef struct TdxGuestClass {
+    ConfidentialGuestSupportClass parent_class;
+} TdxGuestClass;
+
+typedef struct TdxGuest {
+    ConfidentialGuestSupport parent_obj;
+
+    uint64_t attributes;    /* TD attributes */
+} TdxGuest;
+
+#endif /* QEMU_I386_TDX_H */
-- 
2.34.1


