Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 938A1780948
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 12:00:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWwGe-0004r1-Gs; Fri, 18 Aug 2023 05:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwFb-0004TW-3A
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:58:39 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwFV-0000In-Ok
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692352714; x=1723888714;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/H6irGWQBE1Vlux9V2bGZaDyfdDjrk/4WuCDu3qovd8=;
 b=euFo9IbF4HyprARg37yYLKvMrYqE01j4DygAIKItfqDfygoPgUO8AKxX
 8r+54xkqQZVHj4lPZoviBmk4tvXmxF/2BP+ZQPCmyCHCFFPIC0aN91mrO
 72DKDnCoIKTcpq4eDeN6so2hCuRiiiwOUfGb7V7lXCa5snKD8250xl6UZ
 cJyJwi2BBbEbQF+4j8tiYDIXV5NTwS1IReTn+XV2QpAWX1YIuE8zzDr+C
 0VAPyjm6WcNt6EngaynzHEW24GaRmdsSQpHLbvX77VSwpI9FxJwqEc1aK
 ejmfcOW9dyv/dG6/+9HFn1kO5+c6IaPQZwKycyl42wisgx42GCyiuW2/8 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371966471"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="371966471"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2023 02:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="849235407"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="849235407"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2023 02:57:29 -0700
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
Subject: [PATCH v2 36/58] memory: Introduce memory_region_init_ram_gmem()
Date: Fri, 18 Aug 2023 05:50:19 -0400
Message-Id: <20230818095041.1973309-37-xiaoyao.li@intel.com>
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

Introduce memory_region_init_ram_gmem() to allocate private gmem on the
MemoryRegion initialization. It's for the usercase of TDVF, which must
be private on TDX case.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 include/exec/memory.h |  6 +++++
 softmmu/memory.c      | 52 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 759f797b6acd..127ffb6556b9 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1564,6 +1564,12 @@ void memory_region_init_ram(MemoryRegion *mr,
                             uint64_t size,
                             Error **errp);
 
+void memory_region_init_ram_gmem(MemoryRegion *mr,
+                                 Object *owner,
+                                 const char *name,
+                                 uint64_t size,
+                                 Error **errp);
+
 /**
  * memory_region_init_rom: Initialize a ROM memory region.
  *
diff --git a/softmmu/memory.c b/softmmu/memory.c
index af6aa3c1e3c9..ded44dcef1aa 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -25,6 +25,7 @@
 #include "qom/object.h"
 #include "trace.h"
 
+#include <linux/kvm.h>
 #include "exec/memory-internal.h"
 #include "exec/ram_addr.h"
 #include "sysemu/kvm.h"
@@ -3602,6 +3603,57 @@ void memory_region_init_ram(MemoryRegion *mr,
     vmstate_register_ram(mr, owner_dev);
 }
 
+#ifdef CONFIG_KVM
+void memory_region_init_ram_gmem(MemoryRegion *mr,
+                                 Object *owner,
+                                 const char *name,
+                                 uint64_t size,
+                                 Error **errp)
+{
+    DeviceState *owner_dev;
+    Error *err = NULL;
+    int priv_fd;
+
+    memory_region_init_ram_nomigrate(mr, owner, name, size, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    if (object_dynamic_cast(OBJECT(current_accel()), TYPE_KVM_ACCEL)) {
+        KVMState *s = KVM_STATE(current_accel());
+        struct kvm_create_guest_memfd gmem = {
+            .size = size,
+            /* TODO: add property to hostmem backend for huge pmd */
+            .flags = KVM_GUEST_MEMFD_ALLOW_HUGEPAGE,
+        };
+
+        priv_fd = kvm_vm_ioctl(s, KVM_CREATE_GUEST_MEMFD, &gmem);
+        if (priv_fd < 0) {
+            fprintf(stderr, "%s: error creating gmem: %s\n", __func__,
+                    strerror(-priv_fd));
+            abort();
+        }
+    } else {
+        fprintf(stderr, "%s: gmem unsupported accel: %s\n", __func__,
+                current_accel_name());
+        abort();
+    }
+
+    memory_region_set_gmem_fd(mr, priv_fd);
+    memory_region_set_default_private(mr);
+
+    /* This will assert if owner is neither NULL nor a DeviceState.
+     * We only want the owner here for the purposes of defining a
+     * unique name for migration. TODO: Ideally we should implement
+     * a naming scheme for Objects which are not DeviceStates, in
+     * which case we can relax this restriction.
+     */
+    owner_dev = DEVICE(owner);
+    vmstate_register_ram(mr, owner_dev);
+}
+#endif
+
 void memory_region_init_rom(MemoryRegion *mr,
                             Object *owner,
                             const char *name,
-- 
2.34.1


