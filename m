Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC13878095A
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 12:00:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWwFD-00028o-Nl; Fri, 18 Aug 2023 05:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwEs-0001FZ-9G
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:57:55 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwEp-0000Eg-6C
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692352671; x=1723888671;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7ZLBT0rG0ATJUv31+x8JWdiJhQCgvVwu5lEu9uCBHiI=;
 b=WtYvwmYWw9eVWkME20PLw9KA7dLIIGzG2BUZWuEqmpfdQeeogggRU9Gq
 sD4ytLYXkpYlqd3YtondHuGPkV4K+U1k0Zbl0dZUUk//9QndqlfnU4RR1
 zAtoNhi2dKma+9k/GXCa4gWFf99viwzaficGKHbPeC/YC7Z9t/wPBZR0r
 kAkcxRe4s2YwL0sTnh3mHyrgVTfLuHD+Dh9VRyQ/EoGsSHmMPoa1ccyAL
 +inz5et/xIZbrUKUEWAjoYdsvZM5C00UpDHNi70gFpLgeVthOPba7vSJ4
 G1n5nTrl+hLjHV2z/YxdQ5hYu4OZoNsz5ofWieozNU5oHW1AyZMtNI+6H A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371966072"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="371966072"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2023 02:56:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="849235186"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="849235186"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2023 02:56:22 -0700
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
Subject: [PATCH v2 23/58] i386/tdx: Make memory type private by default
Date: Fri, 18 Aug 2023 05:50:06 -0400
Message-Id: <20230818095041.1973309-24-xiaoyao.li@intel.com>
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

By default (due to the recent UPM change), restricted memory attribute is
shared.  Convert the memory region from shared to private at the memory
slot creation time.

add kvm region registering function to check the flag
and convert the region, and add memory listener to TDX guest code to set
the flag to the possible memory region.

Without this patch
- Secure-EPT violation on private area
- KVM_MEMORY_FAULT EXIT (kvm -> qemu)
- qemu converts the 4K page from shared to private
- Resume VCPU execution
- Secure-EPT violation again
- KVM resolves EPT Violation
This also prevents huge page because page conversion is done at 4K
granularity.  Although it's possible to merge 4K private mapping into
2M large page, it slows guest boot.

With this patch
- After memory slot creation, convert the region from private to shared
- Secure-EPT violation on private area.
- KVM resolves EPT Violation

Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/tdx.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 8a2491ed03c2..775110f8bd02 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -18,6 +18,7 @@
 #include "standard-headers/asm-x86/kvm_para.h"
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
+#include "exec/address-spaces.h"
 
 #include "hw/i386/x86.h"
 #include "kvm_i386.h"
@@ -578,6 +579,21 @@ out:
     return r;
 }
 
+static void tdx_guest_region_add(MemoryListener *listener,
+                                 MemoryRegionSection *section)
+{
+    if (memory_region_can_be_private(section->mr)) {
+        memory_region_set_default_private(section->mr);
+    }
+}
+
+static MemoryListener tdx_memory_listener = {
+    .name = TYPE_TDX_GUEST,
+    .region_add = tdx_guest_region_add,
+    /* Higher than KVM memory listener = 10. */
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL_HIGH,
+};
+
 static bool tdx_guest_get_sept_ve_disable(Object *obj, Error **errp)
 {
     TdxGuest *tdx = TDX_GUEST(obj);
@@ -607,6 +623,12 @@ OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
 static void tdx_guest_init(Object *obj)
 {
     TdxGuest *tdx = TDX_GUEST(obj);
+    static bool memory_listener_registered = false;
+
+    if (!memory_listener_registered) {
+        memory_listener_register(&tdx_memory_listener, &address_space_memory);
+        memory_listener_registered = true;
+    }
 
     qemu_mutex_init(&tdx->lock);
 
-- 
2.34.1


