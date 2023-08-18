Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC7F780965
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 12:00:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWwFD-00025f-9H; Fri, 18 Aug 2023 05:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwEu-0001Fl-Nj
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:57:56 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwEq-0000Ev-QT
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692352672; x=1723888672;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XabXP6JP3sejMLekoNMw0ETqyZk6aS55bs9uwl4rtrA=;
 b=QvUygY6UYG+9OY4HQaB1r8GSdo7Jw0JVZKnQrhK/FOdV/SCRzZkZGiOu
 Fw26dE7ACTZtt9g2HTl/dxhDEb6/d5au8u01wb5K+gV0FSKj+c6zNCbWA
 D8JKQTJAIE/Y0wD9HMu8sNtxgW2yYRCRylJpwnRpvLxGnhlQo9D1jeuMC
 WJDngJhNDAy1kXYAceauCGhcTyryGP5LXT4R9wqS3gG2mcuo4G4x6f3RC
 MSjmdAesSvlATVMDNl4uaGhUd43M0xxi+t5eUkvKCPp+oWiS0E63Gg6Ac
 ex6EAkwPaCx+6/1caQ3uMu/fU5y4hUi3+ZIBkBrsSKhLXAsx/HssRbj2e g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371966107"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="371966107"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2023 02:56:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="849235196"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="849235196"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2023 02:56:27 -0700
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
Subject: [PATCH v2 24/58] i386/tdx: Create kvm gmem for TD
Date: Fri, 18 Aug 2023 05:50:07 -0400
Message-Id: <20230818095041.1973309-25-xiaoyao.li@intel.com>
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

Allocate private gmem for TD guest, if the MemoryRegion is memory
backend and has private property on.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/tdx.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 775110f8bd02..f1305191e939 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -19,6 +19,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
+#include "exec/ramblock.h"
 
 #include "hw/i386/x86.h"
 #include "kvm_i386.h"
@@ -582,8 +583,30 @@ out:
 static void tdx_guest_region_add(MemoryListener *listener,
                                  MemoryRegionSection *section)
 {
-    if (memory_region_can_be_private(section->mr)) {
-        memory_region_set_default_private(section->mr);
+    MemoryRegion *mr = section->mr;
+    Object *owner = memory_region_owner(mr);
+
+    if (owner && object_dynamic_cast(owner, TYPE_MEMORY_BACKEND) &&
+        object_property_get_bool(owner, "private", NULL) &&
+        mr->ram_block && mr->ram_block->gmem_fd < 0) {
+        struct kvm_create_guest_memfd gmem = {
+            .size = memory_region_size(mr),
+            /* TODO: add property to hostmem backend for huge pmd */
+            .flags = KVM_GUEST_MEMFD_ALLOW_HUGEPAGE,
+        };
+        int fd;
+
+        fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_GUEST_MEMFD, &gmem);
+        if (fd < 0) {
+            fprintf(stderr, "%s: error creating gmem: %s\n", __func__,
+                    strerror(-fd));
+            abort();
+        }
+        memory_region_set_gmem_fd(mr, fd);
+    }
+
+    if (memory_region_can_be_private(mr)) {
+        memory_region_set_default_private(mr);
     }
 }
 
-- 
2.34.1


