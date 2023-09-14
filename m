Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A39579F93A
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 05:54:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgdPN-0000Am-EL; Wed, 13 Sep 2023 23:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qgdPF-0007xa-4k
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:52:42 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qgdPB-0000r7-0Y
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694663557; x=1726199557;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=C1mGXkusPnhkfU37hQJOr1iYXe1QHqcmTFhsRyRYjTI=;
 b=O4JaCnfQ/rbii/1nNX/wgeAdxvQth2uFXblgaChUbOjj5MDMpjUJgpMO
 qXC8rFA0VM0RCKOU2o5wdm+UXUIQWAV60F0akdaBSqjaewnvvYdh4KOYY
 GYzMQYL0WqU5/ohyHJj2OzGBFxRPdQyTbQkesqVLfLBfSZypAjbg7d4aQ
 RcdpInjZeOPWzZUe8I7pY76LjCqzPpuhwbkHKbNApkPfJdVvoUCi4ANEH
 T0SH1QgqqJHYvTUkDqEpCo9KgLx+8xRUQuKLzmdy5KHRuFGPwEkehUQjO
 EtwuJI8uIfPQlWotOyLmAP6iOAKI5AHGAv/GrvAp88GX57co8sIBHDujB A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="381528513"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; d="scan'208";a="381528513"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2023 20:52:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="814500677"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; d="scan'208";a="814500677"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmsmga004.fm.intel.com with ESMTP; 13 Sep 2023 20:52:31 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, xiaoyao.li@intel.com,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>
Subject: [RFC PATCH v2 16/21] physmem: Introduce ram_block_convert_range()
Date: Wed, 13 Sep 2023 23:51:12 -0400
Message-Id: <20230914035117.3285885-17-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914035117.3285885-1-xiaoyao.li@intel.com>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.24; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It's used for discarding oppsite memory after memory conversion to
shared/private.

Note, private-shared page conversion is done at 4KB granularity. Don't
check alignment with rb->page_size, instead qemu_host_page_size, which
is 4K.

Originally-from: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 include/exec/cpu-common.h |  2 ++
 softmmu/physmem.c         | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 87dc9a752c9a..558684b9f246 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -157,6 +157,8 @@ typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
 
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
 int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
+int ram_block_convert_range(RAMBlock *rb, uint64_t start, size_t length,
+                            bool shared_to_private);
 
 #endif
 
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 6ee6bc794f44..dab3247d461c 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -3733,3 +3733,39 @@ bool ram_block_discard_is_required(void)
     return qatomic_read(&ram_block_discard_required_cnt) ||
            qatomic_read(&ram_block_coordinated_discard_required_cnt);
 }
+
+int ram_block_convert_range(RAMBlock *rb, uint64_t start, size_t length,
+                            bool shared_to_private)
+{
+    int fd;
+
+    if (!rb || rb->gmem_fd < 0) {
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
+        void *host_startaddr = rb->host + start;
+
+        if (!QEMU_PTR_IS_ALIGNED(host_startaddr, qemu_host_page_size)) {
+            return -1;
+        }
+        fd = rb->fd;
+    } else {
+        fd = rb->gmem_fd;
+    }
+
+    return ram_block_discard_range_fd(rb, start, length, fd);
+}
-- 
2.34.1


