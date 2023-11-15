Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0567EBD78
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 08:16:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3A8e-0005Pk-1R; Wed, 15 Nov 2023 02:16:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3A7y-00055K-S6
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:16:00 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3A7w-000250-GR
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700032556; x=1731568556;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qY9pdRRi3gnZ4VLEVBqiSbNccgKMU+XVba+RGctQW98=;
 b=aio2XINxksyIvJ8Wdvfvba/hmk83avjHIW320HTwQyDPx2AOkdEq6z+V
 bC/9It76Nu+qDPuQZlxjHYGjkkKalxhFzTrrH3ReDr1GZLvFezx1OuvQq
 AmdVxY3aWrLL+joczGBXx/oDTzmSKM4Md8OcV3+AuTX3T7hKBCG5Oc0+2
 GjSckCq2uXNmVltyItzO3pUWh6p1eKHAsKLWcqSRyfL/qPdXZlZr261Fh
 HSI2ajY9nrszOWqmNeU8HyUVsUqKH8F+4iujiyM8IApf5EOMnnWpBNNqq
 N3mGbOf21uGkBtHgbu7OZZIdvxukPhurfXYCI32Q4bVvzb/X8eNqS2MVp w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390622084"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="390622084"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 23:15:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="714796837"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="714796837"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orsmga003.jf.intel.com with ESMTP; 14 Nov 2023 23:15:46 -0800
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
Subject: [PATCH v3 03/70] RAMBlock/guest_memfd: Enable
 KVM_GUEST_MEMFD_ALLOW_HUGEPAGE
Date: Wed, 15 Nov 2023 02:14:12 -0500
Message-Id: <20231115071519.2864957-4-xiaoyao.li@intel.com>
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

KVM allows KVM_GUEST_MEMFD_ALLOW_HUGEPAGE for guest memfd. When the
flag is set, KVM tries to allocate memory with transparent hugeapge at
first and falls back to non-hugepage on failure.

However, KVM defines one restriction that size must be hugepage size
aligned when KVM_GUEST_MEMFD_ALLOW_HUGEPAGE is set.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
v3:
 - New one in v3.
---
 system/physmem.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 0af2213cbd9c..c56b17e44df6 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1803,6 +1803,40 @@ static void dirty_memory_extend(ram_addr_t old_ram_size,
     }
 }
 
+#ifdef CONFIG_KVM
+#define HPAGE_PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
+#define DEFAULT_PMD_SIZE (1ul << 21)
+
+static uint32_t get_thp_size(void)
+{
+    gchar *content = NULL;
+    const char *endptr;
+    static uint64_t thp_size = 0;
+    uint64_t tmp;
+
+    if (thp_size != 0) {
+        return thp_size;
+    }
+
+    if (g_file_get_contents(HPAGE_PMD_SIZE_PATH, &content, NULL, NULL) &&
+        !qemu_strtou64(content, &endptr, 0, &tmp) &&
+        (!endptr || *endptr == '\n')) {
+        /* Sanity-check the value and fallback to something reasonable. */
+        if (!tmp || !is_power_of_2(tmp)) {
+            warn_report("Read unsupported THP size: %" PRIx64, tmp);
+        } else {
+            thp_size = tmp;
+        }
+    }
+
+    if (!thp_size) {
+        thp_size = DEFAULT_PMD_SIZE;
+    }
+
+    return thp_size;
+}
+#endif
+
 static void ram_block_add(RAMBlock *new_block, Error **errp)
 {
     const bool noreserve = qemu_ram_is_noreserve(new_block);
@@ -1844,8 +1878,8 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
 #ifdef CONFIG_KVM
     if (kvm_enabled() && new_block->flags & RAM_GUEST_MEMFD &&
         new_block->guest_memfd < 0) {
-        /* TODO: to decide if KVM_GUEST_MEMFD_ALLOW_HUGEPAGE is supported */
-        uint64_t flags = 0;
+        uint64_t flags = QEMU_IS_ALIGNED(new_block->max_length, get_thp_size()) ?
+                         KVM_GUEST_MEMFD_ALLOW_HUGEPAGE : 0;
         new_block->guest_memfd = kvm_create_guest_memfd(new_block->max_length,
                                                         flags, errp);
         if (new_block->guest_memfd < 0) {
-- 
2.34.1


