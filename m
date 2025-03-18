Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E74BA67426
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Mar 2025 13:43:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWHW-00088a-02; Tue, 18 Mar 2025 08:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWH7-0007qv-GO; Tue, 18 Mar 2025 08:42:30 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWH3-0002we-Q6; Tue, 18 Mar 2025 08:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742301746; x=1773837746;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AJ9pLJabRD2fMSQ7De1Zod0j1WnZ3dKpbCNMa8ACBf8=;
 b=dSuc7Z6kiLorhyvXsqRgCABzoCczeZrdnVaUj4qc0e/BJyLVGwlrux/O
 rnKjgoIMROpSZPf2RWpuBxUKr/cXs0D8Bx2ZLhdHbpCaxZ28IMbyx71dT
 NaT40+FhSqosMKakUN9G6B/CEyjIkTEJSrrAgKegGofCthYG0lfL1OS9W
 x927x5gYidVXPfvm5gLawPNjwt+prWDXtWAXEKaZaDMKvLGUKJ/Z1F84G
 xsHui8mWmdv/RUeo6BK3gVSnlRBnB0gGs3iG+yWaWPD7SxlyDRMurSjvl
 v1/sq1qoHVz1AMlIxrLqzSykD6RVVz0ZlnRvnknnT2zZIsgpWla13kk8q g==;
X-CSE-ConnectionGUID: rtP3JjA8SaeVrSA0kgIFCA==
X-CSE-MsgGUID: UfrMxvXASxCL1nwge8JyFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54824574"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="54824574"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 05:42:17 -0700
X-CSE-ConnectionGUID: 4FXcNxZWQ9mxA0WoInmt+Q==
X-CSE-MsgGUID: 47KK16V1QXyU1QsLU4UZMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="121980448"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 18 Mar 2025 05:42:15 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 06/15] rust/vmstate: Fix "cannot infer type" error in
 vmstate_struct
Date: Tue, 18 Mar 2025 21:02:10 +0800
Message-Id: <20250318130219.1799170-7-zhao1.liu@intel.com>
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

Rust cannot infer the type (it should be VMStateField) after
Zeroable::ZERO, which cause the compiling error.

To fix this error, call with_varray_flag() after VMStateField's
initialization.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/vmstate.rs | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 9d9cdda993ce..3be3a7260fe9 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -453,13 +453,15 @@ macro_rules! vmstate_struct {
             size: ::core::mem::size_of::<$type>(),
             flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
             vmsd: $vmsd,
-            ..$crate::zeroable::Zeroable::ZERO $(
-                .with_varray_flag($crate::call_func_with_field!(
-                    $crate::vmstate::vmstate_varray_flag,
-                    $struct_name,
-                    $num))
-               $(.with_varray_multiply($factor))?)?
-        }
+            ..$crate::zeroable::Zeroable::ZERO
+         } $(.with_varray_flag(
+                  $crate::call_func_with_field!(
+                      $crate::vmstate::vmstate_varray_flag,
+                      $struct_name,
+                      $num
+                  )
+              )
+           $(.with_varray_multiply($factor))?)?
     };
 }
 
-- 
2.34.1


