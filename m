Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2785A1C332
	for <lists+qemu-devel@lfdr.de>; Sat, 25 Jan 2025 13:35:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbfLE-0008G0-50; Sat, 25 Jan 2025 07:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tbfL7-0008Dm-3h; Sat, 25 Jan 2025 07:32:42 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tbfL5-0005Tn-ES; Sat, 25 Jan 2025 07:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737808359; x=1769344359;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Bv9++MIdsioOarcOj78lH/SZyI4MnsCAuILQhxiMHgE=;
 b=l/nE541tlCJwtNiTvWhu5yD7VsQuQqEgbMsbB6h/fIaaExsvoayxy3yV
 kAGFFeCHE4NAqhVh7aQkcY7kdUzzEEBr1PzyCrdQRovhoAy11T1cfucZW
 xh/4Bqs73m6NCQf8y6Lvb+g0ytb3ArGEdA6MsW2LdnhZzzlI2qJbjDicD
 fJNzGRZ5OTtgryZJVmP3ZeBHif2VqxsqnIMIHoGYydFSpmTTjFfoe8OGP
 4qLXKCgnzZIIQyIpuAOF7yNXObyfqqP+USqa7mi4krCxvN/w6a6A3ogW+
 aAqsXP3kt2Y/vLtayjW7TaahE5KH1fp/1JbNFASqUNgAq7rFHGX9RV0Qm Q==;
X-CSE-ConnectionGUID: Em5MPB/aTfaYzrVqlkJ29w==
X-CSE-MsgGUID: CGZEneUzSwyUscbmTIYfqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38434716"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="38434716"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2025 04:32:38 -0800
X-CSE-ConnectionGUID: NbjuRh2QQ8GuGU+/G6HELw==
X-CSE-MsgGUID: VaWIrpoPR5CiKHCDoDyUFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,234,1732608000"; d="scan'208";a="107897684"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 25 Jan 2025 04:32:35 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 05/10] rust: add bindings for memattrs
Date: Sat, 25 Jan 2025 20:51:32 +0800
Message-Id: <20250125125137.1223277-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250125125137.1223277-1-zhao1.liu@intel.com>
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The MemTxAttrs structure contains bitfield members, and bindgen is
unable to generate an equivalent macro definition for
MEMTXATTRS_UNSPECIFIED.

Therefore, manually define a global constant variable
MEMTXATTRS_UNSPECIFIED to support calls from Rust code.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since RFC:
 * With a boolean type unspecified field, no need to add once_cell.
 * Merge memattrs binding to memory.rs.
---
 rust/qemu-api/src/memory.rs   | 16 ++++++++++++++--
 rust/qemu-api/src/zeroable.rs |  1 +
 rust/wrapper.h                |  1 +
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/memory.rs b/rust/qemu-api/src/memory.rs
index 963d689c27d4..fff92508c68f 100644
--- a/rust/qemu-api/src/memory.rs
+++ b/rust/qemu-api/src/memory.rs
@@ -2,7 +2,7 @@
 // Author(s): Paolo Bonzini <pbonzini@redhat.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-//! Bindings for `MemoryRegion` and `MemoryRegionOps`
+//! Bindings for `MemoryRegion`, `MemoryRegionOps` and `MemTxAttrs`
 
 use std::{
     ffi::{CStr, CString},
@@ -11,7 +11,7 @@
     ptr::addr_of,
 };
 
-pub use bindings::hwaddr;
+pub use bindings::{hwaddr, MemTxAttrs};
 
 use crate::{
     bindings::{self, device_endian, memory_region_init_io},
@@ -189,3 +189,15 @@ unsafe impl ObjectType for MemoryRegion {
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_MEMORY_REGION) };
 }
 qom_isa!(MemoryRegion: Object);
+
+/// A special `MemTxAttrs` constant, used to indicate that no memary
+/// attributes are specified.
+///
+/// Bus masters which don't specify any attributes will get this,
+/// which has all attribute bits clear except the topmost one
+/// (so that we can distinguish "all attributes deliberately clear"
+/// from "didn't specify" if necessary).
+pub const MEMTXATTRS_UNSPECIFIED: MemTxAttrs = MemTxAttrs {
+    unspecified: true,
+    ..Zeroable::ZERO
+};
diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
index 75742b50d4e3..9f009606b1ab 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -101,3 +101,4 @@ fn default() -> Self {
 impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_1);
 impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_2);
 impl_zeroable!(crate::bindings::MemoryRegionOps);
+impl_zeroable!(crate::bindings::MemTxAttrs);
diff --git a/rust/wrapper.h b/rust/wrapper.h
index a9bc67af0d5f..54839ce0f510 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -62,3 +62,4 @@ typedef enum memory_order {
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "chardev/char-serial.h"
+#include "exec/memattrs.h"
-- 
2.34.1


