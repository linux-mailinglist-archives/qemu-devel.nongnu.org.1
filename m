Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D245769CCB
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 18:36:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQVpe-0002m0-1F; Mon, 31 Jul 2023 12:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVpL-00027M-Ja
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:33:06 -0400
Received: from [134.134.136.126] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVpI-000165-AD
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690821176; x=1722357176;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ta4InYtMSOxVmVlrTdpkepm14awSYjV/tD5ZIXGmuAY=;
 b=SBtgqK/5ZGjJ48UX75YmcFPr21nlGgLxipPRIGtXh5geFIANkT+wVyt/
 PXsiaFYF8sTPVGFJBceX/EWYFgUcG6vTbq0rZDZlPKZAb/gTSjSbPLo6y
 Dz1Ws4hvKRlvm9bEdUNq6cZYKBITB05TBkzSlxKBuDseoncje1guicYAA
 JFYdLjXmF3nvEmUBr1BzCENWWQgRy8d0ZBvzizTpScaBmBDkKlhdigSL2
 taN9UIAoIcPN1mMKvKuTcMkLrtCKGcV49F/OKFebt1f2FHaQbaoP8wyYJ
 FZFeop6o6j5AdCOHBwhwo39U3SGm4YObO+OJWIyU1I4ffpAi0V71HY+aT w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="353993468"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="353993468"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 09:25:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="757984187"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="757984187"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by orsmga008.jf.intel.com with ESMTP; 31 Jul 2023 09:25:24 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 xiaoyao.li@intel.com, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [RFC PATCH 08/19] HostMem: Add private property to indicate to use
 kvm gmem
Date: Mon, 31 Jul 2023 12:21:50 -0400
Message-Id: <20230731162201.271114-9-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731162201.271114-1-xiaoyao.li@intel.com>
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 134.134.136.126 (failed)
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=xiaoyao.li@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 backends/hostmem.c       | 18 ++++++++++++++++++
 include/sysemu/hostmem.h |  2 +-
 qapi/qom.json            |  4 ++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 747e7838c031..dbdbb0aafd45 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -461,6 +461,20 @@ static void host_memory_backend_set_reserve(Object *o, bool value, Error **errp)
     }
     backend->reserve = value;
 }
+
+static bool host_memory_backend_get_private(Object *o, Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(o);
+
+    return backend->private;
+}
+
+static void host_memory_backend_set_private(Object *o, bool value, Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(o);
+
+    backend->private = value;
+}
 #endif /* CONFIG_LINUX */
 
 static bool
@@ -541,6 +555,10 @@ host_memory_backend_class_init(ObjectClass *oc, void *data)
         host_memory_backend_get_reserve, host_memory_backend_set_reserve);
     object_class_property_set_description(oc, "reserve",
         "Reserve swap space (or huge pages) if applicable");
+    object_class_property_add_bool(oc, "private",
+        host_memory_backend_get_private, host_memory_backend_set_private);
+    object_class_property_set_description(oc, "private",
+        "Use KVM gmem private memory");
 #endif /* CONFIG_LINUX */
     /*
      * Do not delete/rename option. This option must be considered stable
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index 39326f1d4f9c..d88970395618 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -65,7 +65,7 @@ struct HostMemoryBackend {
     /* protected */
     uint64_t size;
     bool merge, dump, use_canonical_path;
-    bool prealloc, is_mapped, share, reserve;
+    bool prealloc, is_mapped, share, reserve, private;
     uint32_t prealloc_threads;
     ThreadContext *prealloc_context;
     DECLARE_BITMAP(host_nodes, MAX_NODES + 1);
diff --git a/qapi/qom.json b/qapi/qom.json
index 7f92ea43e8e1..e0b2044e3d20 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -605,6 +605,9 @@
 # @reserve: if true, reserve swap space (or huge pages) if applicable
 #     (default: true) (since 6.1)
 #
+# @private: if true, use KVM gmem private memory
+#           (default: false) (since 8.1)
+#
 # @size: size of the memory region in bytes
 #
 # @x-use-canonical-path-for-ramblock-id: if true, the canonical path
@@ -631,6 +634,7 @@
             '*prealloc-context': 'str',
             '*share': 'bool',
             '*reserve': 'bool',
+            '*private': 'bool',
             'size': 'size',
             '*x-use-canonical-path-for-ramblock-id': 'bool' } }
 
-- 
2.34.1


