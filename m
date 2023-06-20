Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEA473721D
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 18:51:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBeZV-0003b2-UI; Tue, 20 Jun 2023 12:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1qBeZQ-0003Zn-Au
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:51:11 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1qBeZO-00056a-70
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687279866; x=1718815866;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ov8MzoXr/p5mEMM+H44/SCTYTlU5W8ddjIdxYhmAHNk=;
 b=GzcLPTjBxYvIkgB68uuCCFAgr7y9D14Ig96nbQkiUmu3mf4sXPHkO9g2
 UTxJCqmR3c20adrAXUBdHbiGxguiRASqjCPayMqIYnNhKCL/r+CZ9hMQ9
 7egMEx7d8/Df296whzqhyGn8ybUJdtTNW19GI0Sq/fVmnkPKVDKyE4VKA
 SxKiLaD3D74r+DdBF5HrwYaetkXOkRF7I8WkpIAo1rE357vtPhNUmlKIe
 kjapJP/CnXOmLZ8UI7y6B4jBNm/45Lrvorc5+GEE+9uiAYr5vl0tGkQBH
 aQGzpu9s8UH7wrYuEDy78eeDjxqHHnumLwptH1ew3ZlphHo7RolBOFK3e A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="389218042"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; d="scan'208";a="389218042"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 09:50:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="691499963"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; d="scan'208";a="691499963"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 09:50:56 -0700
From: Isaku Yamahata <isaku.yamahata@intel.com>
To: qemu-devel@nongnu.org
Cc: Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [PATCH 3/3] exec/memory: Add symbol for the min value of memory
 listener priority
Date: Tue, 20 Jun 2023 09:50:49 -0700
Message-Id: <29f88477fe82eb774bcfcae7f65ea21995f865f2.1687279702.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687279702.git.isaku.yamahata@intel.com>
References: <cover.1687279702.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.88;
 envelope-from=isaku.yamahata@intel.com; helo=mga01.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add MEMORY_LISTNER_PRIORITY_MIN for the symbolic value for the min value of
the memory listener instead of the hard-coded magic value 0.  Add explicit
initialization.

No functional change intended.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 accel/kvm/kvm-all.c   | 1 +
 include/exec/memory.h | 1 +
 target/arm/kvm.c      | 1 +
 3 files changed, 3 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index ae6ecf8326d1..026859a59cd7 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1103,6 +1103,7 @@ static MemoryListener kvm_coalesced_pio_listener = {
     .name = "kvm-coalesced-pio",
     .coalesced_io_add = kvm_coalesce_pio_add,
     .coalesced_io_del = kvm_coalesce_pio_del,
+    .priority = MEMORY_LISTENER_PRIORITY_MIN,
 };
 
 int kvm_check_extension(KVMState *s, unsigned int extension)
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 5c9e04bf1208..dc6daa8364e5 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -811,6 +811,7 @@ struct IOMMUMemoryRegion {
 #define IOMMU_NOTIFIER_FOREACH(n, mr) \
     QLIST_FOREACH((n), &(mr)->iommu_notify, node)
 
+#define MEMORY_LISTENER_PRIORITY_MIN            0
 #define MEMORY_LISTENER_PRIORITY_ACCEL          10
 #define MEMORY_LISTENER_PRIORITY_DEV_BAKCNED    10
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 84da49332c4b..14fbf786897d 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -341,6 +341,7 @@ static MemoryListener devlistener = {
     .name = "kvm-arm",
     .region_add = kvm_arm_devlistener_add,
     .region_del = kvm_arm_devlistener_del,
+    .priority =MEMORY_LISTENER_PRIORITY_MIN,
 };
 
 static void kvm_arm_set_device_addr(KVMDevice *kd)
-- 
2.25.1


