Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CF1A77D1C
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Apr 2025 16:03:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbtU-0007fl-8S; Tue, 01 Apr 2025 09:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbtM-0007Cr-PA
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:43:00 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbtK-0006ZP-IJ
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743514978; x=1775050978;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uQnxSZ38mHAiDqEFbYnrylh7HRvn06RafvKOs7toA0A=;
 b=FC/bSvXMhlNYbQzgHWr5MLlP8sNv3cWaawP9Tz3ap/f7nj6tTNnpHeSz
 JdcKp38CrnmH5xXoKNGpEXDGqEWd5DS8pOy77f5zriwfX0yOSZcB7CEcN
 Mm6jj5sUCVY5lrCaBmU83bPrhLeU5TYFwgHZGooVIPQqXXTAKqQ5kY9+t
 maUIv932BYfmd3a1n1N+YrHOR8H9eWZXbvq8lVUTtppQg/rzTsBeoe2J0
 6eePcFyDQa1ABsHgaIKx78tn1xFTpV7xdneW25MGhAHA5fNXyJOprT5u0
 W0V1zqlh6X9T2Yg7ln6cZvsbIhFx96KhOFn3aZK1HQopROX+gIyVxLPDw g==;
X-CSE-ConnectionGUID: Ju74cbOmRWKWW4iOUOpSeg==
X-CSE-MsgGUID: rzQIA41aTMSavRPupuoIbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433386"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433386"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:42:20 -0700
X-CSE-ConnectionGUID: SETJ9UdwS8KNuqE/Je8tRA==
X-CSE-MsgGUID: 9YUabaCZQSKcRJLI3B6odw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126640078"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:42:18 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v8 27/55] i386/tdx: Enable user exit on KVM_HC_MAP_GPA_RANGE
Date: Tue,  1 Apr 2025 09:01:37 -0400
Message-Id: <20250401130205.2198253-28-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401130205.2198253-1-xiaoyao.li@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

KVM translates TDG.VP.VMCALL<MapGPA> to KVM_HC_MAP_GPA_RANGE, and QEMU
needs to enable user exit on KVM_HC_MAP_GPA_RANGE in order to handle the
memory conversion requested by TD guest.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
changes in v6:
 - new patch;
---
 target/i386/kvm/tdx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 78764b1d4be4..f8953f598584 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -19,6 +19,8 @@
 #include "system/system.h"
 #include "exec/ramblock.h"
 
+#include <linux/kvm_para.h>
+
 #include "hw/i386/e820_memory_layout.h"
 #include "hw/i386/tdvf.h"
 #include "hw/i386/x86.h"
@@ -378,6 +380,11 @@ static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         }
     }
 
+    /* TDX relies on KVM_HC_MAP_GPA_RANGE to handle TDG.VP.VMCALL<MapGPA> */
+    if (!kvm_enable_hypercall(BIT_ULL(KVM_HC_MAP_GPA_RANGE))) {
+        return -EOPNOTSUPP;
+    }
+
     qemu_add_machine_init_done_notifier(&tdx_machine_done_notify);
 
     tdx_guest = tdx;
-- 
2.34.1


