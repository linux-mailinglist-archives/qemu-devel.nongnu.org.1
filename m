Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7BB7EBD83
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 08:17:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3A93-0006R4-W8; Wed, 15 Nov 2023 02:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3A8Z-00060o-Jz
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:16:40 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3A8W-0002AL-2K
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700032592; x=1731568592;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=I+Zt4PPlUf4SBKG5BHDSP7VkS1LcDTzb79bbPWPOk4I=;
 b=cdm6QWEmSA8eMsfLMD1xGXCeVJlqjLjaRjpHuRhf9+4cJsP0qjeYBs9O
 KdtNaeVYGIEQfHXKb/drK3IjVbZb2eL8XjqobkbjqZCX40JCZ6+DZeB78
 PTjFAsEb9HP1fVe3iLAhhLSn2fctaiuydS5EqKYK6RDXlGJ9Y5Dce1vRo
 OgGUg1u8DVAtz/VXBIY1gIotLTVoxP5w0zlb+iHw/5GdbNfmv88BTsXsb
 Xv3TJ0SAoq/tgBwGXUywn9Aro/XA9bgXDwzmrdJ3Wmph+DXAi+F5rOl6x
 3zaUz/2eOgVx1gsOBb5kVu3BvgDG4cY4TWWBpTYRDhpqiBYNQalmgsv5I Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390622194"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="390622194"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 23:16:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="714797046"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="714797046"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orsmga003.jf.intel.com with ESMTP; 14 Nov 2023 23:16:16 -0800
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
Subject: [PATCH v3 07/70] physmem: Relax the alignment check of host_startaddr
 in ram_block_discard_range()
Date: Wed, 15 Nov 2023 02:14:16 -0500
Message-Id: <20231115071519.2864957-8-xiaoyao.li@intel.com>
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

Commit d3a5038c461 ("exec: ram_block_discard_range") introduced
ram_block_discard_range() which grabs some code from
ram_discard_range(). However, during code movement, it changed alignment
check of host_startaddr from qemu_host_page_size to rb->page_size.

When ramblock is back'ed by hugepage, it requires the startaddr to be
huge page size aligned, which is a overkill. e.g., TDX's private-shared
page conversion is done at 4KB granularity. Shared page is discarded
when it gets converts to private and when shared page back'ed by
hugepage it is going to fail on this check.

So change to alignment check back to qemu_host_page_size.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v3:
 - Newly added in v3;
---
 system/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index c56b17e44df6..8a4e42c7cf60 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3532,7 +3532,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
 
     uint8_t *host_startaddr = rb->host + start;
 
-    if (!QEMU_PTR_IS_ALIGNED(host_startaddr, rb->page_size)) {
+    if (!QEMU_PTR_IS_ALIGNED(host_startaddr, qemu_host_page_size)) {
         error_report("ram_block_discard_range: Unaligned start address: %p",
                      host_startaddr);
         goto err;
-- 
2.34.1


