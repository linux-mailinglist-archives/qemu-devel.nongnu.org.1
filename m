Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA0C7EBD7E
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 08:17:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3A8k-0006MV-BG; Wed, 15 Nov 2023 02:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3A8g-0006Dx-3t
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:16:42 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3A8e-0002JU-8I
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700032600; x=1731568600;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=d8m/K4WT12hdYcKmOmyFhEUCYXWBDBTjG/rXpGvxHMU=;
 b=Vs+dI9eV1xY2m+5nQpwHdgYDnbc07gph2A1y7w+BhSsvYqKSw1kT8T8b
 jwGUOBPDbjsgiwxgdllY7+X2BD70OWp34hGygeVQUyPcsR9UhvBhg1P/T
 yN1wfvCh1IFhkOfTtzvky4GHt/o6TRTeNyGv2Ho1t+6PU8tggg8y3sqMb
 MMQ5WDYdjxmG4oA3DzxZC9AIL+KbiAdlSrrp7oSOkYSKKad57edblVAzQ
 ebPFsvYSwzfBmvOTVygGAZYJcpIGj5H0KjzSbic/DSaepZPTAA6LAskpx
 JZ1pithN5QuJc2BeDWD4Qsq+tXdtlEaiUDlk3QqcAqPiDkRHhxA4BeP4z w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390622253"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="390622253"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 23:16:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="714797186"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="714797186"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orsmga003.jf.intel.com with ESMTP; 14 Nov 2023 23:16:30 -0800
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
Subject: [PATCH v3 09/70] physmem: Introduce ram_block_convert_range() for
 page conversion
Date: Wed, 15 Nov 2023 02:14:18 -0500
Message-Id: <20231115071519.2864957-10-xiaoyao.li@intel.com>
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

It's used for discarding opposite memory after memory conversion, for
confidential guest.

When page is converted from shared to private, the original shared
memory can be discarded via ram_block_discard_range();

When page is converted from private to shared, the original private
memory is back'ed by guest_memfd. Introduce
ram_block_discard_guest_memfd_range() for discarding memory in
guest_memfd.

Originally-from: Isaku Yamahata <isaku.yamahata@intel.com>
Codeveloped-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 include/exec/cpu-common.h |  2 ++
 system/physmem.c          | 50 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 41115d891940..de728a18eef2 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -175,6 +175,8 @@ typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
 
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
 int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
+int ram_block_convert_range(RAMBlock *rb, uint64_t start, size_t length,
+                            bool shared_to_private);
 
 #endif
 
diff --git a/system/physmem.c b/system/physmem.c
index ddfecddefcd6..cd6008fa09ad 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3641,6 +3641,29 @@ err:
     return ret;
 }
 
+static int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
+                                               size_t length)
+{
+    int ret = -1;
+
+#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
+    ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+                    start, length);
+
+    if (ret) {
+        ret = -errno;
+        error_report("%s: Failed to fallocate %s:%" PRIx64 " +%zx (%d)",
+                     __func__, rb->idstr, start, length, ret);
+    }
+#else
+    ret = -ENOSYS;
+    error_report("%s: fallocate not available %s:%" PRIx64 " +%zx (%d)",
+                 __func__, rb->idstr, start, length, ret);
+#endif
+
+    return ret;
+}
+
 bool ramblock_is_pmem(RAMBlock *rb)
 {
     return rb->flags & RAM_PMEM;
@@ -3828,3 +3851,30 @@ bool ram_block_discard_is_required(void)
     return qatomic_read(&ram_block_discard_required_cnt) ||
            qatomic_read(&ram_block_coordinated_discard_required_cnt);
 }
+
+int ram_block_convert_range(RAMBlock *rb, uint64_t start, size_t length,
+                            bool shared_to_private)
+{
+    if (!rb || rb->guest_memfd < 0) {
+        return -1;
+    }
+
+    if (!QEMU_PTR_IS_ALIGNED(start, qemu_host_page_size) ||
+        !QEMU_PTR_IS_ALIGNED(length, qemu_host_page_size)) {
+        return -1;
+    }
+
+    if (!length) {
+        return -1;
+    }
+
+    if (start + length > rb->max_length) {
+        return -1;
+    }
+
+    if (shared_to_private) {
+        return ram_block_discard_range(rb, start, length);
+    } else {
+        return ram_block_discard_guest_memfd_range(rb, start, length);
+    }
+}
-- 
2.34.1


