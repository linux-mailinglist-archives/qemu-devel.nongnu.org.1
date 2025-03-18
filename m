Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED897A6742D
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Mar 2025 13:44:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWIi-00015N-4G; Tue, 18 Mar 2025 08:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWH6-0007qo-QP; Tue, 18 Mar 2025 08:42:30 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWH4-0002wP-Al; Tue, 18 Mar 2025 08:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742301747; x=1773837747;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=usEhCMOmGCifjwNKm0zeYfxP5suOQmKgiIpvC4cOCps=;
 b=Z4PRR/Baz9A49tuV9ml9MAS4vwoZayR4VmyMkYGojnA8HzKwlmI3Y1sA
 YLByXyCMMilCvtysD9O/VS0Td5PaezcqkVRsqr4YVKO2PeKPl3YvvsEYQ
 DWu0uLQ/sJdlL3B5/mdpeQnK17/O0XXDkyq0/6q9j3v0kILeWHoXicBid
 fAjoY93z7w3zhOsfbwlzvE2nw/Gx7xzrRU4uFGbHke0sZ3NfHwx0PTcK6
 yosSTd4ys13rXwY188b4T1nSx42Jq4hZ+eMWuEWJvWLoWAX8qQNq1iPT/
 Keg6QC2j9a7qSKgVM047hzF0JiXEar2bBOoFZRZOS2UbiCuNouabrDF3g Q==;
X-CSE-ConnectionGUID: BKu/iHt6Qpqo3J5qffEyjw==
X-CSE-MsgGUID: d0vXpTg3R0SMXDQzQzjJ7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54824594"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="54824594"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 05:42:20 -0700
X-CSE-ConnectionGUID: OwZfHw0yTfWwmtAbZcwNWQ==
X-CSE-MsgGUID: lGPUSET9QTuPgtzYX9LRpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="121980457"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 18 Mar 2025 05:42:18 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 08/15] rust/vmstate: Relax array check when build varray in
 vmstate_struct
Date: Tue, 18 Mar 2025 21:02:12 +0800
Message-Id: <20250318130219.1799170-9-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318130219.1799170-1-zhao1.liu@intel.com>
References: <20250318130219.1799170-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The varry of structure created by vmstate_struct is different with
vmstate_of. This is because vmstate_struct uses the `vmsd` to traverse
the vmstates of structure's fields, rather than treating the structure
directly as a well-defined vmstate.

Therefore, there's no need to check array flag when building varray by
vmstate_struct.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/vmstate.rs | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 792a74fdfc08..0b5af1c90b11 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -275,14 +275,20 @@ pub const fn with_pointer_flag(mut self) -> Self {
     }
 
     #[must_use]
-    pub const fn with_varray_flag(mut self, flag: VMStateFlags) -> VMStateField {
-        assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) != 0);
+    pub const fn with_varray_flag_unchecked(mut self, flag: VMStateFlags) -> VMStateField {
         self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_ARRAY.0);
         self.flags = VMStateFlags(self.flags.0 | flag.0);
         self.num = 0; // varray uses num_offset instead of num.
         self
     }
 
+    #[must_use]
+    #[allow(unused_mut)]
+    pub const fn with_varray_flag(mut self, flag: VMStateFlags) -> VMStateField {
+        assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) != 0);
+        self.with_varray_flag_unchecked(flag)
+    }
+
     #[must_use]
     pub const fn with_varray_multiply(mut self, num: u32) -> VMStateField {
         assert!(num <= 0x7FFF_FFFFu32);
@@ -454,7 +460,7 @@ macro_rules! vmstate_struct {
             flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
             vmsd: $vmsd,
             ..$crate::zeroable::Zeroable::ZERO
-         } $(.with_varray_flag(
+         } $(.with_varray_flag_unchecked(
                   $crate::call_func_with_field!(
                       $crate::vmstate::vmstate_varray_flag,
                       $struct_name,
-- 
2.34.1


