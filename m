Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9B0780969
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 12:01:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWwDW-0008IN-RY; Fri, 18 Aug 2023 05:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwDT-00084F-1a
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:56:27 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwDQ-000847-AU
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692352584; x=1723888584;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kXbz035m1UkBnkuE826SCE8I4pfJ0GU89RlTelDHwBk=;
 b=SQhv3NlWgKsaYQS91XQvb1v7C80eATSVAMEMdMgWq6PrmklIUB09++Sa
 PgHh/MQ/F/XjhWz1iwxy1OpJ+iogIlZ1Z/fYhhft8oteytFDH3u+b5gyC
 inC60FE+j5PbDPG4SIG4XlE6mf9wseRVR4Q7Kio3mi9Joh1x4yEtz2VF+
 IlzN6mUqcMXs8dNBZtTsfa2FGE7FynT4A28DSPQ9YT28SG9JRvPnpeLZu
 pXZ7LeXinGCgyiOWoTDtxw9qB65zBfrSVClxXlw6f2+s0hfy0T52YUExs
 c2W18SMBbEIB2d/NmdzsbvFmYvrPCxDGE1giMV1I7cXUnqXe8WHikSIFK g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371965970"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="371965970"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2023 02:56:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="849235160"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="849235160"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2023 02:56:06 -0700
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
Subject: [PATCH v2 20/58] i386/tdx: Allows mrconfigid/mrowner/mrownerconfig
 for TDX_INIT_VM
Date: Fri, 18 Aug 2023 05:50:03 -0400
Message-Id: <20230818095041.1973309-21-xiaoyao.li@intel.com>
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

When creating TDX vm, three sha384 hash values can be provided for
TDX attestation.

So far they were hard coded as 0. Now allow user to specify those values
via property mrconfigid, mrowner and mrownerconfig. Choose hex-encoded
string as format since it's friendly for user to input.

example
-object tdx-guest, \
  mrconfigid=0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef, \
  mrowner=fedcba9876543210fedcba9876543210fedcba9876543210fedcba9876543210fedcba9876543210fedcba9876543210, \
  mrownerconfig=0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
TODO:
 - community requests to use base64 encoding if no special reason
---
 qapi/qom.json         | 11 ++++++++++-
 target/i386/kvm/tdx.c | 13 +++++++++++++
 target/i386/kvm/tdx.h |  3 +++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index cc08b9a98df9..87c1d440f331 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -873,10 +873,19 @@
 #
 # @sept-ve-disable: bit 28 of TD attributes (default: 0)
 #
+# @mrconfigid: MRCONFIGID SHA384 hex string of 48 * 2 length (default: 0)
+#
+# @mrowner: MROWNER SHA384 hex string of 48 * 2 length (default: 0)
+#
+# @mrownerconfig: MROWNERCONFIG SHA384 hex string of 48 * 2 length (default: 0)
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
index 73da15377ec3..33d015a08c34 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -521,6 +521,13 @@ int tdx_pre_create_vcpu(CPUState *cpu)
     init_vm->cpuid.nent = kvm_x86_arch_cpuid(env, init_vm->cpuid.entries, 0);
     init_vm->attributes = tdx_guest->attributes;
 
+    QEMU_BUILD_BUG_ON(sizeof(init_vm->mrconfigid) != sizeof(tdx_guest->mrconfigid));
+    QEMU_BUILD_BUG_ON(sizeof(init_vm->mrowner) != sizeof(tdx_guest->mrowner));
+    QEMU_BUILD_BUG_ON(sizeof(init_vm->mrownerconfig) != sizeof(tdx_guest->mrownerconfig));
+    memcpy(init_vm->mrconfigid, tdx_guest->mrconfigid, sizeof(tdx_guest->mrconfigid));
+    memcpy(init_vm->mrowner, tdx_guest->mrowner, sizeof(tdx_guest->mrowner));
+    memcpy(init_vm->mrownerconfig, tdx_guest->mrownerconfig, sizeof(tdx_guest->mrownerconfig));
+
     do {
         r = tdx_vm_ioctl(KVM_TDX_INIT_VM, 0, init_vm);
     } while (r == -EAGAIN);
@@ -575,6 +582,12 @@ static void tdx_guest_init(Object *obj)
     object_property_add_bool(obj, "sept-ve-disable",
                              tdx_guest_get_sept_ve_disable,
                              tdx_guest_set_sept_ve_disable);
+    object_property_add_sha384(obj, "mrconfigid", tdx->mrconfigid,
+                               OBJ_PROP_FLAG_READWRITE);
+    object_property_add_sha384(obj, "mrowner", tdx->mrowner,
+                               OBJ_PROP_FLAG_READWRITE);
+    object_property_add_sha384(obj, "mrownerconfig", tdx->mrownerconfig,
+                               OBJ_PROP_FLAG_READWRITE);
 }
 
 static void tdx_guest_finalize(Object *obj)
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 46a24ee8c7cc..68f8327f2231 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -21,6 +21,9 @@ typedef struct TdxGuest {
 
     bool initialized;
     uint64_t attributes;    /* TD attributes */
+    uint8_t mrconfigid[48];     /* sha348 digest */
+    uint8_t mrowner[48];        /* sha348 digest */
+    uint8_t mrownerconfig[48];  /* sha348 digest */
 } TdxGuest;
 
 #ifdef CONFIG_TDX
-- 
2.34.1


