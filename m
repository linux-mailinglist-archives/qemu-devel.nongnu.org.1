Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82850AA6F84
	for <lists+qemu-devel@lfdr.de>; Fri,  2 May 2025 12:24:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAnYj-0001HL-S8; Fri, 02 May 2025 06:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAnYd-0001GV-Ql
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:23:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAnYY-0000jF-R2
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746181426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sB1RxFzinWPdmNZOEcfcnJ1bFCbF+VuYIyWhiTfLYVU=;
 b=fxCVNQ5zFXylYoW2HoC4EKMBUgbR3jCJZ4kiYqLc0ioVOcnWIm3ceBCfhbRNQsthgnZSoO
 +R5vkyA6OASdqRtntMEE/vl7DxmRKaMciAIfqB0HE8zuHt5O56auiSdYVtekpixftAEdsu
 xjKXCvBWHv9IZKnKZlmB8buc4+HikJ0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-DwNg-fv6PMijqhY-XR6hJw-1; Fri, 02 May 2025 06:23:45 -0400
X-MC-Unique: DwNg-fv6PMijqhY-XR6hJw-1
X-Mimecast-MFC-AGG-ID: DwNg-fv6PMijqhY-XR6hJw_1746181424
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43e9b0fd00cso7759325e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 03:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746181423; x=1746786223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sB1RxFzinWPdmNZOEcfcnJ1bFCbF+VuYIyWhiTfLYVU=;
 b=Ya9zDYVa8a56ii5M8I7c+lJ1yOhRzrHEAma+5rYk+KYJTA51FVQ86DIb8ns9rAMdng
 pWmJuBbBdGyl++tXW0cWrfPysN5FY3HbeR/HszB9pZgk2+MmNMhsgX8RfyOj/3iIBNoA
 CgtGTph5j8X9oT4MAJ8/9BetlcvOMtpvpr7j4BYvg3de8YA97k1vJ/KCVl6uK3++Lwsq
 IkCVnXfTULaKVBa5n7JUTtFl5ZY2hlXzBe1wlYDkOUiONx1GfpxQCdWhJh/SVAfPDBWp
 PJ475CQzcPiDL7DywfAxIugYeBX2UK7bSg2BJiUuOZd65UXyMMDY4gxnZ0NWQHPxt735
 eDDg==
X-Gm-Message-State: AOJu0YytPVjV1IEe+v2Eeaj8lJwf62afzpTbFQ/+lz8ciFWyf0Un7LmW
 AayLNp1wLITN66/fKQB9758TDFlBRAiIRrmc+TQV3/3DS0hpc8h0McEuV8CTKxMRyZI6IIvqbtB
 OthjVP47b/B2twlZSI6Qbfk2/pX74qWb6n4/PQMj3ChEHEA8ol/LvCJZ39SLR2MY4GTyBPY+xyp
 FCfKA2KfTAyV8vNCcvhbut/n28arKJXzxGQgiz
X-Gm-Gg: ASbGncu3opn2bKDtxFQsn8jaQIAo16tXxdiElt7X/FI3EIDhdCuuaGWvF6a3wdPrT3/
 xbRAT3pQ/jepW0Qt0zAeiYI46ZfHIKvVSjwSdQvpgIPAXMvwQytqj6DfueJ6946LylmMs7/DSJz
 2wSeinrcGfoqBAG2CbGm0lG1hWADdSSGKwxfdwExL6xvN9k2rohDansPwkzy6ddEpRPOhFoT0kB
 idtHC+cF4w4oiP0vhm6XPPcPz0HD6hGgqFEru9J9SLj1JS6S0/i+rxUVedsyRaHtDChYUL8P3zm
 BTZIob93mxA0/1I=
X-Received: by 2002:a05:600c:1c8f:b0:439:4c1e:d810 with SMTP id
 5b1f17b1804b1-441bb856814mr17472105e9.9.1746181422691; 
 Fri, 02 May 2025 03:23:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo/CB01mjIxY+wHYXz92ytwjkhlH+lKUIXyo63UxM/+IAjbZkIZl18HA1DOVK5f16XQhYkFA==
X-Received: by 2002:a05:600c:1c8f:b0:439:4c1e:d810 with SMTP id
 5b1f17b1804b1-441bb856814mr17471845e9.9.1746181422163; 
 Fri, 02 May 2025 03:23:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b0ff8esm1735567f8f.79.2025.05.02.03.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 03:23:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 7/9] rust: replace c_str! with c"" literals
Date: Fri,  2 May 2025 12:23:20 +0200
Message-ID: <20250502102323.104815-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502102323.104815-1-pbonzini@redhat.com>
References: <20250502102323.104815-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst                    |  8 +---
 rust/Cargo.lock                        |  1 -
 rust/hw/char/pl011/src/device_class.rs | 11 +++--
 rust/hw/char/pl011/src/lib.rs          |  6 +--
 rust/hw/timer/hpet/src/hpet.rs         | 19 ++++----
 rust/hw/timer/hpet/src/lib.rs          |  4 +-
 rust/qemu-api/meson.build              |  1 -
 rust/qemu-api/src/c_str.rs             | 61 --------------------------
 rust/qemu-api/src/cell.rs              |  4 +-
 rust/qemu-api/src/lib.rs               |  1 -
 rust/qemu-api/src/vmstate.rs           |  2 +-
 rust/qemu-api/tests/tests.rs           |  9 ++--
 rust/qemu-api/tests/vmstate_tests.rs   | 15 +++----
 13 files changed, 32 insertions(+), 110 deletions(-)
 delete mode 100644 rust/qemu-api/src/c_str.rs

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 8dad90fdf98..cae2634a2e9 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -78,14 +78,9 @@ are missing:
 
 * Generic Associated Types (1.65.0)
 
-* ``CStr::from_bytes_with_nul()`` as a ``const`` function (1.72.0).
-
 * "Return position ``impl Trait`` in Traits" (1.75.0, blocker for including
   the pinned-init create).
 
-* ``c"" literals`` (stable in 1.77.0).  QEMU provides a ``c_str!()`` macro
-  to define ``CStr`` constants easily
-
 * inline const expression (stable in 1.79.0), currently worked around with
   associated constants in the ``FnCall`` trait.
 
@@ -168,7 +163,6 @@ module           status
 ``bitops``       complete
 ``callbacks``    complete
 ``cell``         stable
-``c_str``        complete
 ``errno``        complete
 ``irq``          complete
 ``memory``       stable
@@ -425,7 +419,7 @@ Adding dependencies
 Generally, the set of dependent crates is kept small.  Think twice before
 adding a new external crate, especially if it comes with a large set of
 dependencies itself.  Sometimes QEMU only needs a small subset of the
-functionality; see for example QEMU's ``assertions`` or ``c_str`` modules.
+functionality; see for example QEMU's ``assertions`` module.
 
 On top of this recommendation, adding external crates to QEMU is a
 slightly complicated process, mostly due to the need to teach Meson how
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 2ebf0a11ea4..13d580c693b 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -108,7 +108,6 @@ version = "0.1.0"
 dependencies = [
  "libc",
  "qemu_api_macros",
- "version_check",
 ]
 
 [[package]]
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index cd2dc33c207..d328d846323 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -9,7 +9,6 @@
 
 use qemu_api::{
     bindings::{qdev_prop_bool, qdev_prop_chr},
-    c_str,
     prelude::*,
     vmstate::VMStateDescription,
     vmstate_clock, vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_unused,
@@ -25,7 +24,7 @@ extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
 
 /// Migration subsection for [`PL011State`] clock.
 static VMSTATE_PL011_CLOCK: VMStateDescription = VMStateDescription {
-    name: c_str!("pl011/clock").as_ptr(),
+    name: c"pl011/clock".as_ptr(),
     version_id: 1,
     minimum_version_id: 1,
     needed: Some(pl011_clock_needed),
@@ -46,7 +45,7 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
 }
 
 static VMSTATE_PL011_REGS: VMStateDescription = VMStateDescription {
-    name: c_str!("pl011/regs").as_ptr(),
+    name: c"pl011/regs".as_ptr(),
     version_id: 2,
     minimum_version_id: 2,
     fields: vmstate_fields! {
@@ -70,7 +69,7 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
 };
 
 pub static VMSTATE_PL011: VMStateDescription = VMStateDescription {
-    name: c_str!("pl011").as_ptr(),
+    name: c"pl011".as_ptr(),
     version_id: 2,
     minimum_version_id: 2,
     post_load: Some(pl011_post_load),
@@ -87,14 +86,14 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
 qemu_api::declare_properties! {
     PL011_PROPERTIES,
     qemu_api::define_property!(
-        c_str!("chardev"),
+        c"chardev",
         PL011State,
         char_backend,
         unsafe { &qdev_prop_chr },
         CharBackend
     ),
     qemu_api::define_property!(
-        c_str!("migrate-clk"),
+        c"migrate-clk",
         PL011State,
         migrate_clock,
         unsafe { &qdev_prop_bool },
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index dbae76991c9..5c4fbc9d148 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -12,13 +12,11 @@
 //! See [`PL011State`](crate::device::PL011State) for the device model type and
 //! the [`registers`] module for register types.
 
-use qemu_api::c_str;
-
 mod device;
 mod device_class;
 mod registers;
 
 pub use device::pl011_create;
 
-pub const TYPE_PL011: &::std::ffi::CStr = c_str!("pl011");
-pub const TYPE_PL011_LUMINARY: &::std::ffi::CStr = c_str!("pl011_luminary");
+pub const TYPE_PL011: &::std::ffi::CStr = c"pl011";
+pub const TYPE_PL011_LUMINARY: &::std::ffi::CStr = c"pl011_luminary";
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 72609c31f44..6afef083a57 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -14,7 +14,6 @@
         address_space_memory, address_space_stl_le, qdev_prop_bit, qdev_prop_bool,
         qdev_prop_uint32, qdev_prop_uint8,
     },
-    c_str,
     cell::{BqlCell, BqlRefCell},
     irq::InterruptSource,
     memory::{
@@ -908,7 +907,7 @@ impl ObjectImpl for HPETState {
 qemu_api::declare_properties! {
     HPET_PROPERTIES,
     qemu_api::define_property!(
-        c_str!("timers"),
+        c"timers",
         HPETState,
         num_timers,
         unsafe { &qdev_prop_uint8 },
@@ -916,7 +915,7 @@ impl ObjectImpl for HPETState {
         default = HPET_MIN_TIMERS
     ),
     qemu_api::define_property!(
-        c_str!("msi"),
+        c"msi",
         HPETState,
         flags,
         unsafe { &qdev_prop_bit },
@@ -925,7 +924,7 @@ impl ObjectImpl for HPETState {
         default = false,
     ),
     qemu_api::define_property!(
-        c_str!("hpet-intcap"),
+        c"hpet-intcap",
         HPETState,
         int_route_cap,
         unsafe { &qdev_prop_uint32 },
@@ -933,7 +932,7 @@ impl ObjectImpl for HPETState {
         default = 0
     ),
     qemu_api::define_property!(
-        c_str!("hpet-offset-saved"),
+        c"hpet-offset-saved",
         HPETState,
         hpet_offset_saved,
         unsafe { &qdev_prop_bool },
@@ -974,7 +973,7 @@ impl ObjectImpl for HPETState {
 }
 
 static VMSTATE_HPET_RTC_IRQ_LEVEL: VMStateDescription = VMStateDescription {
-    name: c_str!("hpet/rtc_irq_level").as_ptr(),
+    name: c"hpet/rtc_irq_level".as_ptr(),
     version_id: 1,
     minimum_version_id: 1,
     needed: Some(hpet_rtc_irq_level_needed),
@@ -985,7 +984,7 @@ impl ObjectImpl for HPETState {
 };
 
 static VMSTATE_HPET_OFFSET: VMStateDescription = VMStateDescription {
-    name: c_str!("hpet/offset").as_ptr(),
+    name: c"hpet/offset".as_ptr(),
     version_id: 1,
     minimum_version_id: 1,
     needed: Some(hpet_offset_needed),
@@ -996,7 +995,7 @@ impl ObjectImpl for HPETState {
 };
 
 static VMSTATE_HPET_TIMER: VMStateDescription = VMStateDescription {
-    name: c_str!("hpet_timer").as_ptr(),
+    name: c"hpet_timer".as_ptr(),
     version_id: 1,
     minimum_version_id: 1,
     fields: vmstate_fields! {
@@ -1011,10 +1010,10 @@ impl ObjectImpl for HPETState {
     ..Zeroable::ZERO
 };
 
-const VALIDATE_TIMERS_NAME: &CStr = c_str!("num_timers must match");
+const VALIDATE_TIMERS_NAME: &CStr = c"num_timers must match";
 
 static VMSTATE_HPET: VMStateDescription = VMStateDescription {
-    name: c_str!("hpet").as_ptr(),
+    name: c"hpet".as_ptr(),
     version_id: 2,
     minimum_version_id: 1,
     pre_save: Some(hpet_pre_save),
diff --git a/rust/hw/timer/hpet/src/lib.rs b/rust/hw/timer/hpet/src/lib.rs
index 5e7c961c289..1954584a87e 100644
--- a/rust/hw/timer/hpet/src/lib.rs
+++ b/rust/hw/timer/hpet/src/lib.rs
@@ -7,9 +7,7 @@
 //! This library implements a device model for the IA-PC HPET (High
 //! Precision Event Timers) device in QEMU.
 
-use qemu_api::c_str;
-
 pub mod fw_cfg;
 pub mod hpet;
 
-pub const TYPE_HPET: &::std::ffi::CStr = c_str!("hpet");
+pub const TYPE_HPET: &::std::ffi::CStr = c"hpet";
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 95e65643ae1..1696df705bf 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -20,7 +20,6 @@ _qemu_api_rs = static_library(
       'src/callbacks.rs',
       'src/cell.rs',
       'src/chardev.rs',
-      'src/c_str.rs',
       'src/errno.rs',
       'src/irq.rs',
       'src/memory.rs',
diff --git a/rust/qemu-api/src/c_str.rs b/rust/qemu-api/src/c_str.rs
deleted file mode 100644
index 3fa61b59c76..00000000000
--- a/rust/qemu-api/src/c_str.rs
+++ /dev/null
@@ -1,61 +0,0 @@
-// Copyright 2024 Red Hat, Inc.
-// Author(s): Paolo Bonzini <pbonzini@redhat.com>
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-#![doc(hidden)]
-//! This module provides a macro to define a constant of type
-//! [`CStr`](std::ffi::CStr), for compatibility with versions of
-//! Rust that lack `c""` literals.
-//!
-//! Documentation is hidden because it only exposes macros, which
-//! are exported directly from `qemu_api`.
-
-#[macro_export]
-/// Given a string constant _without_ embedded or trailing NULs, return
-/// a `CStr`.
-///
-/// Needed for compatibility with Rust <1.77.
-macro_rules! c_str {
-    ($str:expr) => {{
-        const STRING: &str = concat!($str, "\0");
-        const BYTES: &[u8] = STRING.as_bytes();
-
-        // "for" is not allowed in const context... oh well,
-        // everybody loves some lisp.  This could be turned into
-        // a procedural macro if this is a problem; alternatively
-        // Rust 1.72 makes CStr::from_bytes_with_nul a const function.
-        const fn f(b: &[u8], i: usize) {
-            if i == b.len() - 1 {
-            } else if b[i] == 0 {
-                panic!("c_str argument contains NUL")
-            } else {
-                f(b, i + 1)
-            }
-        }
-        f(BYTES, 0);
-
-        // SAFETY: absence of NULs apart from the final byte was checked above
-        unsafe { std::ffi::CStr::from_bytes_with_nul_unchecked(BYTES) }
-    }};
-}
-
-#[cfg(test)]
-mod tests {
-    use std::ffi::CStr;
-
-    use crate::c_str;
-
-    #[test]
-    fn test_cstr_macro() {
-        let good = c_str!("🦀");
-        let good_bytes = b"\xf0\x9f\xa6\x80\0";
-        assert_eq!(good.to_bytes_with_nul(), good_bytes);
-    }
-
-    #[test]
-    fn test_cstr_macro_const() {
-        const GOOD: &CStr = c_str!("🦀");
-        const GOOD_BYTES: &[u8] = b"\xf0\x9f\xa6\x80\0";
-        assert_eq!(GOOD.to_bytes_with_nul(), GOOD_BYTES);
-    }
-}
diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
index ab0785a2692..b35d19723f6 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -77,13 +77,13 @@
 //!
 //! ```
 //! # use qemu_api::prelude::*;
-//! # use qemu_api::{c_str, cell::BqlRefCell, irq::InterruptSource, irq::IRQState};
+//! # use qemu_api::{cell::BqlRefCell, irq::InterruptSource, irq::IRQState};
 //! # use qemu_api::{sysbus::SysBusDevice, qom::Owned, qom::ParentField};
 //! # const N_GPIOS: usize = 8;
 //! # struct PL061Registers { /* ... */ }
 //! # unsafe impl ObjectType for PL061State {
 //! #     type Class = <SysBusDevice as ObjectType>::Class;
-//! #     const TYPE_NAME: &'static std::ffi::CStr = c_str!("pl061");
+//! #     const TYPE_NAME: &'static std::ffi::CStr = c"pl061";
 //! # }
 //! struct PL061State {
 //!     parent_obj: ParentField<SysBusDevice>,
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 90c19636660..234a94e3c29 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -15,7 +15,6 @@
 
 pub mod assertions;
 pub mod bitops;
-pub mod c_str;
 pub mod callbacks;
 pub mod cell;
 pub mod chardev;
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 9a6e6b734b9..389f1a6f62a 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -426,7 +426,7 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 macro_rules! vmstate_unused {
     ($size:expr) => {{
         $crate::bindings::VMStateField {
-            name: $crate::c_str!("unused").as_ptr(),
+            name: c"unused".as_ptr(),
             size: $size,
             info: unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_info_unused_buffer) },
             flags: $crate::bindings::VMStateFlags::VMS_BUFFER,
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index d045808c3a8..a658a49fcfd 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -6,7 +6,6 @@
 
 use qemu_api::{
     bindings::{module_call_init, module_init_type, qdev_prop_bool},
-    c_str,
     cell::{self, BqlCell},
     declare_properties, define_property,
     prelude::*,
@@ -21,7 +20,7 @@
 
 // Test that macros can compile.
 pub static VMSTATE: VMStateDescription = VMStateDescription {
-    name: c_str!("name").as_ptr(),
+    name: c"name".as_ptr(),
     unmigratable: true,
     ..Zeroable::ZERO
 };
@@ -48,7 +47,7 @@ pub fn class_init<T: DeviceImpl>(self: &mut DummyClass) {
 declare_properties! {
     DUMMY_PROPERTIES,
         define_property!(
-            c_str!("migrate-clk"),
+            c"migrate-clk",
             DummyState,
             migrate_clock,
             unsafe { &qdev_prop_bool },
@@ -58,7 +57,7 @@ pub fn class_init<T: DeviceImpl>(self: &mut DummyClass) {
 
 unsafe impl ObjectType for DummyState {
     type Class = DummyClass;
-    const TYPE_NAME: &'static CStr = c_str!("dummy");
+    const TYPE_NAME: &'static CStr = c"dummy";
 }
 
 impl ObjectImpl for DummyState {
@@ -92,7 +91,7 @@ pub struct DummyChildClass {
 
 unsafe impl ObjectType for DummyChildState {
     type Class = DummyChildClass;
-    const TYPE_NAME: &'static CStr = c_str!("dummy_child");
+    const TYPE_NAME: &'static CStr = c"dummy_child";
 }
 
 impl ObjectImpl for DummyChildState {
diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index cc3527a9b6a..ad0fc5cd5dd 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -14,7 +14,6 @@
         vmstate_info_bool, vmstate_info_int32, vmstate_info_int64, vmstate_info_int8,
         vmstate_info_uint64, vmstate_info_uint8, vmstate_info_unused_buffer, VMStateFlags,
     },
-    c_str,
     cell::{BqlCell, Opaque},
     impl_vmstate_forward,
     vmstate::{VMStateDescription, VMStateField},
@@ -43,7 +42,7 @@ struct FooA {
 }
 
 static VMSTATE_FOOA: VMStateDescription = VMStateDescription {
-    name: c_str!("foo_a").as_ptr(),
+    name: c"foo_a".as_ptr(),
     version_id: 1,
     minimum_version_id: 1,
     fields: vmstate_fields! {
@@ -173,7 +172,7 @@ fn validate_foob(_state: &FooB, _version_id: u8) -> bool {
 }
 
 static VMSTATE_FOOB: VMStateDescription = VMStateDescription {
-    name: c_str!("foo_b").as_ptr(),
+    name: c"foo_b".as_ptr(),
     version_id: 2,
     minimum_version_id: 1,
     fields: vmstate_fields! {
@@ -337,7 +336,7 @@ struct FooC {
 }
 
 static VMSTATE_FOOC: VMStateDescription = VMStateDescription {
-    name: c_str!("foo_c").as_ptr(),
+    name: c"foo_c".as_ptr(),
     version_id: 3,
     minimum_version_id: 1,
     fields: vmstate_fields! {
@@ -452,13 +451,13 @@ fn validate_food_2(_state: &FooD, _version_id: u8) -> bool {
 }
 
 static VMSTATE_FOOD: VMStateDescription = VMStateDescription {
-    name: c_str!("foo_d").as_ptr(),
+    name: c"foo_d".as_ptr(),
     version_id: 3,
     minimum_version_id: 1,
     fields: vmstate_fields! {
-        vmstate_validate!(FooD, c_str!("foo_d_0"), FooD::validate_food_0),
-        vmstate_validate!(FooD, c_str!("foo_d_1"), FooD::validate_food_1),
-        vmstate_validate!(FooD, c_str!("foo_d_2"), validate_food_2),
+        vmstate_validate!(FooD, c"foo_d_0", FooD::validate_food_0),
+        vmstate_validate!(FooD, c"foo_d_1", FooD::validate_food_1),
+        vmstate_validate!(FooD, c"foo_d_2", validate_food_2),
     },
     ..Zeroable::ZERO
 };
-- 
2.49.0


