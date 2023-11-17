Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9207EECD4
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 08:41:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3tT6-0006jv-D6; Fri, 17 Nov 2023 02:40:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r3tT4-0006XU-36
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 02:40:46 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r3tSz-0008K1-Gg
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 02:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700206841; x=1731742841;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ikToKF9wpTdbj9OQGEgX17iOQo/pEcuVay/x5UrQVU0=;
 b=LOY4xOd+I6fz2OrUs47Tcivq0ts+46Mp+HDgsD5cL8I6x1h4h9XZ+dNy
 d5gQXJUsGihg2fjg+eebE9UHx/PVgFp2NHTfjrlj9vVpI30FeyJzKzzPy
 VbbixDx3nDu0Q9RoJLJCnjK8/IBLqIvs4IHTn0i1+umX8AMKO2T5PIHgV
 iM8X1VvZGAgPqz7Vo7l6qXfL6rnRM/6t4V8AwJyCcqSexW8qpABMRyLyN
 lk/NjV/iz4/hIn4HB8SAsaIu+x6++rVnBlZbuPnEVNdIYdpZqaLD7V9Oe
 8mecltIOlHDmVBAs7HhSY8kYzDHNr/shFlELcyBBYzrwc9hJOeyMxDYHy Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="395180444"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; d="scan'208";a="395180444"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2023 23:40:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="883042884"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; d="scan'208";a="883042884"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga002.fm.intel.com with ESMTP; 16 Nov 2023 23:40:19 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 16/16] i386: Use CPUCacheInfo.share_level to encode
 CPUID[0x8000001D].EAX[bits 25:14]
Date: Fri, 17 Nov 2023 15:51:06 +0800
Message-Id: <20231117075106.432499-17-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117075106.432499-1-zhao1.liu@linux.intel.com>
References: <20231117075106.432499-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.65;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

CPUID[0x8000001D].EAX[bits 25:14] NumSharingCache: number of logical
processors sharing cache.

The number of logical processors sharing this cache is
NumSharingCache + 1.

After cache models have topology information, we can use
CPUCacheInfo.share_level to decide which topology level to be encoded
into CPUID[0x8000001D].EAX[bits 25:14].

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
Changes since v3:
 * Explain what "CPUID[0x8000001D].EAX[bits 25:14]" means in the commit
   message. (Babu)

Changes since v1:
 * Use cache->share_level as the parameter in
   max_processor_ids_for_cache().
---
 target/i386/cpu.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3ddedd6de120..b45d9eb74e67 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -483,20 +483,12 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
                                        uint32_t *eax, uint32_t *ebx,
                                        uint32_t *ecx, uint32_t *edx)
 {
-    uint32_t num_sharing_cache;
     assert(cache->size == cache->line_size * cache->associativity *
                           cache->partitions * cache->sets);
 
     *eax = CACHE_TYPE(cache->type) | CACHE_LEVEL(cache->level) |
                (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0);
-
-    /* L3 is shared among multiple cores */
-    if (cache->level == 3) {
-        num_sharing_cache = 1 << apicid_die_offset(topo_info);
-    } else {
-        num_sharing_cache = 1 << apicid_core_offset(topo_info);
-    }
-    *eax |= (num_sharing_cache - 1) << 14;
+    *eax |= max_processor_ids_for_cache(topo_info, cache->share_level) << 14;
 
     assert(cache->line_size > 0);
     assert(cache->partitions > 0);
-- 
2.34.1


