Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1959E4D60
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Dec 2024 06:50:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ4k3-0006Et-Iz; Thu, 05 Dec 2024 00:49:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4k0-0006DQ-Qx; Thu, 05 Dec 2024 00:49:33 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4jz-00079o-4S; Thu, 05 Dec 2024 00:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733377771; x=1764913771;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VCKCuXFNdAEeiFHD7bZV0Fz0m6rEj3nJ8quOxmRRxzg=;
 b=JwBbuuzhPvnD7lqDEGm41o3OhvOpO7cFp/RDnNyQ+HsNkynXa0z2OqwG
 X8F6w4y0f2N+JtrixhcqrEnB7CjfFe4mAbkeqy6vXgQn/M2neq6bASm5R
 4ls6a62kbVxOCBxzvBl+n1LO4r6QXsknZ/gtYG4q0uSXPC+PMtwna2Y4u
 jNcdknLkcu+B94pX2FjKSXs6VJtpSRSKdBCLxOI10IAb7btvgOCXcJs4B
 s1/HEFpyUEj4tZ2beIaIDBWLIdHBhbUcE09EPDTWwGBYepVcCA6jTl+zb
 GN0RgS8VOyWJIMFBvjLrVolrcAyRwyzxa08UP+YwzMJmhtj8/H1rXI3Rv A==;
X-CSE-ConnectionGUID: EEEcpT4VRYuFMyKZi1fljg==
X-CSE-MsgGUID: /kG7pm4GSFWHsM0ZED7JpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33815638"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33815638"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2024 21:49:29 -0800
X-CSE-ConnectionGUID: TYQryDhBQkqY1/OhFauqSA==
X-CSE-MsgGUID: PTQz4QFMSeak1YBlHB0Nsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94454991"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 04 Dec 2024 21:49:27 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 05/13] rust: add a bit operation binding for deposit64
Date: Thu,  5 Dec 2024 14:07:06 +0800
Message-Id: <20241205060714.256270-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205060714.256270-1-zhao1.liu@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

The bindgen supports `static inline` function binding since v0.64.0 as
an experimental feature (`--wrap-static-fns`), and stabilizes it after
v0.70.0.

But the oldest version of bindgen supported by QEMU is v0.60.1, so
there's no way to generate the binding for deposit64() which is `static
inline` (in include/qemu/bitops.h).

Manually implement a binding. Since it only involves bit operations,
fortunately, the Rust version of deposit64() is almost identical to the
original C version.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/meson.build   |  1 +
 rust/qemu-api/src/bitops.rs | 11 +++++++++++
 rust/qemu-api/src/lib.rs    |  1 +
 3 files changed, 13 insertions(+)
 create mode 100644 rust/qemu-api/src/bitops.rs

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 3ac69cbc76c4..00e86a679d8a 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -16,6 +16,7 @@ _qemu_api_rs = static_library(
     [
       'src/lib.rs',
       'src/bindings.rs',
+      'src/bitops.rs',
       'src/cell.rs',
       'src/c_str.rs',
       'src/irq.rs',
diff --git a/rust/qemu-api/src/bitops.rs b/rust/qemu-api/src/bitops.rs
new file mode 100644
index 000000000000..a11a07fb8830
--- /dev/null
+++ b/rust/qemu-api/src/bitops.rs
@@ -0,0 +1,11 @@
+// Copyright (C) 2024 Intel Corporation.
+// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+pub fn deposit64(value: u64, start: usize, length: usize, fieldval: u64) -> u64 {
+    /* FIXME: Implement a more elegant check with error handling support? */
+    assert!(length > 0 && length <= 64 - start);
+
+    let mask = (u64::MAX >> (64 - length)) << start;
+    (value & !mask) | ((fieldval << start) & mask)
+}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 0d46b372c6bb..009906c907e7 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -7,6 +7,7 @@
 #[rustfmt::skip]
 pub mod bindings;
 
+pub mod bitops;
 pub mod c_str;
 pub mod cell;
 pub mod irq;
-- 
2.34.1


