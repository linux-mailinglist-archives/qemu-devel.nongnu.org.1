Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 746ED7EBDAD
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 08:19:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3ABE-0002zI-VA; Wed, 15 Nov 2023 02:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3ABA-0002xG-Oa
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:19:16 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3AB8-0003UE-Vd
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700032754; x=1731568754;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1Ay7S3rAOoskJAztEbHgo488WlUI8ejC+OUitxLNJ7s=;
 b=OophRxkVR682dZFyG5sDmwLMYqd+2+R339eks3IJhu+ZaRRDYbE3bQTP
 eCS6UUQwoBJIf81pPaK1b6am32jSVWcQf4H+v3F7jzxmv+VVvH1UabIod
 Oc4UidpfQNRHQ09Wp9nwNYfUnyKDUi/1jPdXMTLfykwp5iOr6w/k0MITE
 4CJiWbvUztx44JTi3LwBMnz1TAXvwWGKJBh3DMzs0Iq3J4iH/mQ1laHA6
 MZDuYlYHdSfK/6syEeHZ50r8qSZqcf47FhUAAWeM4+V3yJ/cKU9KjOK8E
 sHUQscdxGtKn61nrBbX0U1NNygLIfusd3PrFwoS6062UCkwiM1rLwOsXT Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390622912"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="390622912"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 23:19:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="714798957"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="714798957"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orsmga003.jf.intel.com with ESMTP; 14 Nov 2023 23:19:01 -0800
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
Subject: [PATCH v3 31/70] i386/tdx: Allows mrconfigid/mrowner/mrownerconfig
 for TDX_INIT_VM
Date: Wed, 15 Nov 2023 02:14:40 -0500
Message-Id: <20231115071519.2864957-32-xiaoyao.li@intel.com>
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

Three sha384 hash values, mrconfigid, mrowner and mrownerconfig, of a TD
can be provided for TDX attestation.

So far they were hard coded as 0. Now allow user to specify those values
via property mrconfigid, mrowner and mrownerconfig. They are all in
base64 format.

example
-object tdx-guest, \
  mrconfigid=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v,\
  mrowner=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v,\
  mrownerconfig=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v3:
 - use base64 encoding instread of hex-string;
---
 qapi/qom.json         | 11 +++++-
 target/i386/kvm/tdx.c | 85 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/kvm/tdx.h |  3 ++
 3 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 3a29659e0155..fd99aa1ff8cc 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -888,10 +888,19 @@
 #     pages.  Some guest OS (e.g., Linux TD guest) may require this to
 #     be set, otherwise they refuse to boot.
 #
+# @mrconfigid: base64 encoded MRCONFIGID SHA384 digest
+#
+# @mrowner: base64 encoded MROWNER SHA384 digest
+#
+# @mrownerconfig: base64 MROWNERCONFIG SHA384 digest
+#
 # Since: 8.2
 ##
 { 'struct': 'TdxGuestProperties',
-  'data': { '*sept-ve-disable': 'bool' } }
+  'data': { '*sept-ve-disable': 'bool',
+            '*mrconfigid': 'str',
+            '*mrowner': 'str',
+            '*mrownerconfig': 'str' } }
 
 ##
 # @ThreadContextProperties:
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 28b3c2765c86..b70efbcab738 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/base64.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
 #include "standard-headers/asm-x86/kvm_para.h"
@@ -508,6 +509,8 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
     X86CPU *x86cpu = X86_CPU(cpu);
     CPUX86State *env = &x86cpu->env;
     struct kvm_tdx_init_vm *init_vm;
+    uint8_t *data;
+    size_t data_len;
     int r = 0;
 
     qemu_mutex_lock(&tdx_guest->lock);
@@ -518,6 +521,38 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
     init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
                         sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
 
+#define SHA384_DIGEST_SIZE  48
+
+    if (tdx_guest->mrconfigid) {
+        data = qbase64_decode(tdx_guest->mrconfigid,
+                              strlen(tdx_guest->mrconfigid), &data_len, errp);
+        if (!data || data_len != SHA384_DIGEST_SIZE) {
+            error_setg(errp, "TDX: failed to decode mrconfigid");
+            return -1;
+        }
+        memcpy(init_vm->mrconfigid, data, data_len);
+    }
+
+    if (tdx_guest->mrowner) {
+        data = qbase64_decode(tdx_guest->mrowner,
+                              strlen(tdx_guest->mrowner), &data_len, errp);
+        if (!data || data_len != SHA384_DIGEST_SIZE) {
+            error_setg(errp, "TDX: failed to decode mrowner");
+            return -1;
+        }
+        memcpy(init_vm->mrowner, data, data_len);
+    }
+
+    if (tdx_guest->mrownerconfig) {
+        data = qbase64_decode(tdx_guest->mrownerconfig,
+                              strlen(tdx_guest->mrownerconfig), &data_len, errp);
+        if (!data || data_len != SHA384_DIGEST_SIZE) {
+            error_setg(errp, "TDX: failed to decode mrownerconfig");
+            return -1;
+        }
+        memcpy(init_vm->mrownerconfig, data, data_len);
+    }
+
     r = kvm_vm_enable_cap(kvm_state, KVM_CAP_MAX_VCPUS, 0, ms->smp.cpus);
     if (r < 0) {
         error_setg(errp, "Unable to set MAX VCPUS to %d", ms->smp.cpus);
@@ -567,6 +602,48 @@ static void tdx_guest_set_sept_ve_disable(Object *obj, bool value, Error **errp)
     }
 }
 
+static char * tdx_guest_get_mrconfigid(Object *obj, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    return g_strdup(tdx->mrconfigid);
+}
+
+static void tdx_guest_set_mrconfigid(Object *obj, const char *value, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    tdx->mrconfigid = g_strdup(value);
+}
+
+static char * tdx_guest_get_mrowner(Object *obj, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    return g_strdup(tdx->mrowner);
+}
+
+static void tdx_guest_set_mrowner(Object *obj, const char *value, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    tdx->mrconfigid = g_strdup(value);
+}
+
+static char * tdx_guest_get_mrownerconfig(Object *obj, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    return g_strdup(tdx->mrownerconfig);
+}
+
+static void tdx_guest_set_mrownerconfig(Object *obj, const char *value, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    tdx->mrconfigid = g_strdup(value);
+}
+
 /* tdx guest */
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
                                    tdx_guest,
@@ -586,6 +663,14 @@ static void tdx_guest_init(Object *obj)
     object_property_add_bool(obj, "sept-ve-disable",
                              tdx_guest_get_sept_ve_disable,
                              tdx_guest_set_sept_ve_disable);
+    object_property_add_str(obj, "mrconfigid",
+                            tdx_guest_get_mrconfigid,
+                            tdx_guest_set_mrconfigid);
+    object_property_add_str(obj, "mrowner",
+                            tdx_guest_get_mrowner, tdx_guest_set_mrowner);
+    object_property_add_str(obj, "mrownerconfig",
+                            tdx_guest_get_mrownerconfig,
+                            tdx_guest_set_mrownerconfig);
 }
 
 static void tdx_guest_finalize(Object *obj)
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 432077723ac5..6e39ef3bac13 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -21,6 +21,9 @@ typedef struct TdxGuest {
 
     bool initialized;
     uint64_t attributes;    /* TD attributes */
+    char *mrconfigid;       /* base64 encoded sha348 digest */
+    char *mrowner;          /* base64 encoded sha348 digest */
+    char *mrownerconfig;    /* base64 encoded sha348 digest */
 } TdxGuest;
 
 #ifdef CONFIG_TDX
-- 
2.34.1


