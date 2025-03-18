Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8574A66DBD
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Mar 2025 09:15:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuS58-0002th-Qu; Tue, 18 Mar 2025 04:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuS4N-0002k0-RN; Tue, 18 Mar 2025 04:13:06 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuS4L-0001KN-53; Tue, 18 Mar 2025 04:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742285581; x=1773821581;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZPd9V5wMjDbpVJyLc2i9uB1eqHqQJo3XlnU3/4VFDfo=;
 b=Rh00BszQ0M/7vMHMzNtsSzMMpIn/M/wpzUOqbNOjHIQ5ClXM3losa8hI
 VGegRPrLWQr8wfXcjYqnZdFnsz5AET2XGjG8C5qDUWWzw2Trh2ErtdA6N
 D0GKakKF/nT2DoOeLB5MlfHpD1uwh6dE39SVePcJG56olK8R5PlrKfggY
 8j8VOzV05xIPjFUpA7VPiOwyo6N/9+aJaQFxCpxfNIxdJkRUSpYXyLLiu
 SN4V5Co0QhBYLvwBhfQ2ytmDVdW74OvmDmXy7zo/Wvmw2fjLDqkP/fSlw
 UddBEyYFlRLKZbNByZoW8GpzQoaInMQv/iBjGhaJiTRysJWoF1Y7TLGbd Q==;
X-CSE-ConnectionGUID: qc0pQ1mjTsu67ktQxnJdDQ==
X-CSE-MsgGUID: 85t3VKl7QBWURuX/dnv2xQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="53621586"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="53621586"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 01:12:57 -0700
X-CSE-ConnectionGUID: 6rPGYD7JSlC/uPaGXgNr7g==
X-CSE-MsgGUID: yOz8rGWOT6ehRrSkwdfvog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="127363246"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 18 Mar 2025 01:12:55 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 09/14] rust/vmstate: Re-implement VMState trait for timer
 binding
Date: Tue, 18 Mar 2025 16:32:43 +0800
Message-Id: <20250318083248.1402990-10-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318083248.1402990-1-zhao1.liu@intel.com>
References: <20250318083248.1402990-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

At present, Rust side has a timer binding "timer::Timer", so the vmstate
for timer should base on that binding instead of the raw
"binding::QEMUTimer".

It's possible to apply impl_vmstate_transparent for cell::Opaque and
then impl_vmstate_forward for timer::Timer. But binding::QEMUTimer
shouldn't be used directly, so that vmstate for such raw timer type is
useless.

Thus, apply impl_vmstate_scalar for timer::Timer. And since Opaque<> is
useful, apply impl_vmstate_transparent for cell::Opaque as well.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/vmstate.rs | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 0b5af1c90b11..01f06ed7379e 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -27,12 +27,7 @@
 use core::{marker::PhantomData, mem, ptr::NonNull};
 
 pub use crate::bindings::{VMStateDescription, VMStateField};
-use crate::{
-    bindings::{self, VMStateFlags},
-    prelude::*,
-    qom::Owned,
-    zeroable::Zeroable,
-};
+use crate::{bindings::VMStateFlags, prelude::*, qom::Owned, zeroable::Zeroable};
 
 /// This macro is used to call a function with a generic argument bound
 /// to the type of a field.  The function must take a
@@ -344,6 +339,7 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 impl_vmstate_transparent!(std::pin::Pin<T> where T: VMState);
 impl_vmstate_transparent!(crate::cell::BqlCell<T> where T: VMState);
 impl_vmstate_transparent!(crate::cell::BqlRefCell<T> where T: VMState);
+impl_vmstate_transparent!(crate::cell::Opaque<T> where T: VMState);
 
 #[macro_export]
 macro_rules! impl_vmstate_bitsized {
@@ -390,7 +386,7 @@ unsafe impl VMState for $type {
 impl_vmstate_scalar!(vmstate_info_uint16, u16, VMS_VARRAY_UINT16);
 impl_vmstate_scalar!(vmstate_info_uint32, u32, VMS_VARRAY_UINT32);
 impl_vmstate_scalar!(vmstate_info_uint64, u64);
-impl_vmstate_scalar!(vmstate_info_timer, bindings::QEMUTimer);
+impl_vmstate_scalar!(vmstate_info_timer, crate::timer::Timer);
 
 // Pointer types using the underlying type's VMState plus VMS_POINTER
 // Note that references are not supported, though references to cells
-- 
2.34.1


