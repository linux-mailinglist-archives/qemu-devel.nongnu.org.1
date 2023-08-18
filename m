Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ED3780962
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 12:00:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWwFB-0001VD-D9; Fri, 18 Aug 2023 05:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwEv-0001G3-8r
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:57:57 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwEs-0000Eg-G2
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692352674; x=1723888674;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4pumGxfrijyUn0Q5nX1dtYuXDXgLxajixMrQt/+4nDw=;
 b=aglyKzLB5UUp5oyiWkUlavq86IZ+SPQqRKIy4T3CCY30imNxAWas38uB
 Dl3y8kpeJ0CSFUf0YIU9V0/nNMI62173WFE0epHyGmFAwjrEndcPt8Wl6
 DZ3dCzf0yfPhY8n/VAIanjPHHmkE1oyrBoADGmnR++D95psdETCYp+OLs
 bt/khITGk90svpVC4jB9TwEETCeeA4mOqQzzdckBMNiiM6+hO9KzLXbiL
 U4gORbjOypM3DDkPsgdlUTOwYEY2q1lK6m1XoBL4ocEUCIRghyQ8WB1Gj
 rzt+KjmtrwvCrLJk517x4d2v5Fbh8MnfiqgJV5K8EixsGXgIq9/35epNV w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371966127"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="371966127"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2023 02:56:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="849235208"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="849235208"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2023 02:56:32 -0700
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
Subject: [PATCH v2 25/58] kvm/tdx: Don't complain when converting vMMIO region
 to shared
Date: Fri, 18 Aug 2023 05:50:08 -0400
Message-Id: <20230818095041.1973309-26-xiaoyao.li@intel.com>
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

Because vMMIO region needs to be shared region, guest TD may explicitly
convert such region from private to shared.  Don't complain such
conversion.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 accel/kvm/kvm-all.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index fceec7f2a83f..9d0aa8c97feb 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3094,8 +3094,24 @@ static int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
          */
         ram_block_convert_range(rb, offset, size, to_private);
     } else {
-        warn_report("Convert non guest-memfd backed memory region (0x%"HWADDR_PRIx" ,+ 0x%"HWADDR_PRIx") to %s",
-                    start, size, to_private ? "private" : "shared");
+        MemoryRegion *mr = section.mr;
+
+        /*
+         * Because vMMIO region must be shared, guest TD may convert vMMIO
+         * region to shared explicitly.  Don't complain such case.  See
+         * memory_region_type() for checking if the region is MMIO region.
+         */
+        if (to_private ||
+            memory_region_is_ram(mr) ||
+            memory_region_is_ram_device(mr) ||
+            memory_region_is_rom(mr) ||
+            memory_region_is_romd(mr)) {
+            warn_report("Convert non guest-memfd backed memory region (0x%"HWADDR_PRIx" ,+ 0x%"HWADDR_PRIx") of %s to %s",
+                        start, size, mr->name, to_private ? "private" : "shared");
+	    } else {
+		    ret = 0;
+	    }
+
     }
 
     memory_region_unref(section.mr);
-- 
2.34.1


