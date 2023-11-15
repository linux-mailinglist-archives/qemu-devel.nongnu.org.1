Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EC57EBDE8
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 08:23:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3ADz-0005xO-7F; Wed, 15 Nov 2023 02:22:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3ADq-0005jI-9x
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:22:03 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3ADo-0005ES-0l
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:22:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700032919; x=1731568919;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5u+WKJc4+yttRr+qCCOD151Jg4QmLt+f0sR3Wiffs48=;
 b=XD0OoJ4VAOTq5fT3flepPId5p/I+EZyjFpfLWwvEpQqxmPMWDNSyFm3r
 E0W+t7jO6fLV284B0D7PG3wHxF9CUgG3KETzGa0suimDfcW798zT9lIis
 w7k9NDZTdHVaG35bKJFuqU/oc2g4Xykdk721Zdp8kr4/ktanF/VPoI55M
 a/o8D+sYRYARh5DXfEq2tXb41QuGEIuu8rKMHtooRKfd1pNl6cZ0YRL1e
 6/z/581zFecWoNfA/ifIhThUyOzoXxtqG4g6JlDszGT+1kBohmF+XkIpr
 h4Er5yF5hvRkEvjyBpLrOYB9vUY5GZnf60TccWq8wp/AMSP/eyEQwtkFA g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390623342"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="390623342"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 23:21:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="714800116"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="714800116"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orsmga003.jf.intel.com with ESMTP; 14 Nov 2023 23:21:51 -0800
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
Subject: [PATCH v3 47/70] memory: Introduce
 memory_region_init_ram_guest_memfd()
Date: Wed, 15 Nov 2023 02:14:56 -0500
Message-Id: <20231115071519.2864957-48-xiaoyao.li@intel.com>
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

Introduce memory_region_init_ram_guest_memfd() to allocate private
guset memfd on the MemoryRegion initialization. It's for the use case of
TDVF, which must be private on TDX case.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 include/exec/memory.h |  6 ++++++
 system/memory.c       | 27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index c8b0385b19ad..ca23a1a6b336 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1590,6 +1590,12 @@ void memory_region_init_ram(MemoryRegion *mr,
                             uint64_t size,
                             Error **errp);
 
+void memory_region_init_ram_guest_memfd(MemoryRegion *mr,
+                                        Object *owner,
+                                        const char *name,
+                                        uint64_t size,
+                                        Error **errp);
+
 /**
  * memory_region_init_rom: Initialize a ROM memory region.
  *
diff --git a/system/memory.c b/system/memory.c
index b0c58232b6f7..166eb9fd6f7d 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3632,6 +3632,33 @@ void memory_region_init_ram(MemoryRegion *mr,
     vmstate_register_ram(mr, owner_dev);
 }
 
+void memory_region_init_ram_guest_memfd(MemoryRegion *mr,
+                                        Object *owner,
+                                        const char *name,
+                                        uint64_t size,
+                                        Error **errp)
+{
+    DeviceState *owner_dev;
+    Error *err = NULL;
+
+    memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
+                                           RAM_GUEST_MEMFD, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
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
+
 void memory_region_init_rom(MemoryRegion *mr,
                             Object *owner,
                             const char *name,
-- 
2.34.1


