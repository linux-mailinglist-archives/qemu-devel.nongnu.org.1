Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EDDB48AAE
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Sep 2025 12:57:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZSe-00067m-3F; Mon, 08 Sep 2025 06:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSW-00066g-8e
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:50:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSE-00060R-Tn
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757328630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SuHS+NRbJx22oCL4jQrA7lQlj+2i01WSRCPXHNMOSPg=;
 b=EBBlN1JnsZwQEpgul7YqtCPgEQajLNbeadN6UYlPn6MC1Dc+pvOaFclIdRZ1Lu0f5PMQob
 5y/Rf+bCPkgvwMZp0bgyOSWJLVeZsErq4iAcB8qGUutrfXfOQx2zVbuohDXl4hiboTVT0p
 kAxVfnQav7L48kSc6j3bE4CAKzbFSoo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-Crj3Okk1N0-U-C41NzwaNQ-1; Mon, 08 Sep 2025 06:50:28 -0400
X-MC-Unique: Crj3Okk1N0-U-C41NzwaNQ-1
X-Mimecast-MFC-AGG-ID: Crj3Okk1N0-U-C41NzwaNQ_1757328627
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45dd5c1b67dso20707045e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757328627; x=1757933427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SuHS+NRbJx22oCL4jQrA7lQlj+2i01WSRCPXHNMOSPg=;
 b=d18vrHqbuRUFr4+9OuAyGsDQc91lQ42KuUB6ljXku8CYxrSUoe0Y2BXPffxmnF1RMU
 ghBfL8n3Hql24Qji7HdMJ03C0ZtOPylCUbCwNyMsN7EpYwAGyJsTnY7OmqIid9v7K4fq
 fcqX2PDdAHbwHlKkZDhqbyA3i1vk+XXDcwMac+L4nG4de+4uYufnbou1WCMRKpQBDSIO
 POGAlUZZvTUl/VLzr8oJc7+xQxTNehb+DM9iMgGoZv9wCfHaMXOWrYQldNx8XnAIo9eP
 CglykH7wd1zXJEAZOw03oiS/4Egt4xZ9e7WilttvedJaseb+QmzSOZBWD5v4ZVauuoZr
 I9Ig==
X-Gm-Message-State: AOJu0Yz8sin/hI2NaHl7YsaklA8YPcxhCV5xS+yLUsBJiUpdgPL3Da9b
 fx+o890xqI2UWMy0WBzeFERvSDyM0xx+IzFmUwsdl5oYV92e93K5baaXIxAExOujDyFcropUIVe
 89G4AFSaqfXHbXekjVvaTxSOuAByZnaV1lZBE2eGsZlzutz5N5sNMvOfxPwQT+3tpKuHAVCqoEC
 JJR3ald33CFAzm+uShPUCSn+kYhGnj2c+/HraOv4BE
X-Gm-Gg: ASbGncuhkdphWS2Ks/yKCGQfLZ5E6njwsN13P6SmIvHJhaPX3upy7VBlXPk///QCHKd
 5Aty+kVidXsDxFp3vWu9jmXejDvsHPCruyW+iOGfX0Pzvmyn4gX5b7aWr56wmbYLJqsWh1ivAJ6
 REyIEioCJiv9ie+7zHRu4XgD6ZRT0vmWzsmybkQV2KYJCHq/E9KkyGZWrhStg1Mb0JH+me/xoY1
 1mjh6W9WX+7g1nFTGM2AyBgR85pp6s5Km4/UNT0oL8uAy0qtrrCijU5+ntEQMUbdr3wUPF5Wl7J
 owFWp/eSohFT7yiXSga0A/7dTeclDRrernadWwGfRlIRSryIGJFb6YWU5uYbjPlkWaxkG7wb02C
 UAvLbPp5GdpgMk8XTBBhnIHWypDiCTcSRzGEWyPJBX5I=
X-Received: by 2002:a05:600c:1c9b:b0:45d:d5c6:97b4 with SMTP id
 5b1f17b1804b1-45ddde929camr49900365e9.9.1757328626513; 
 Mon, 08 Sep 2025 03:50:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBp0uhjcNptYXsvUDukJNTrsy1Q2aLHK+g3pIzn0qGMdUAoVjUyiCs69qW0GdZYcTutJzaRQ==
X-Received: by 2002:a05:600c:1c9b:b0:45d:d5c6:97b4 with SMTP id
 5b1f17b1804b1-45ddde929camr49899915e9.9.1757328625483; 
 Mon, 08 Sep 2025 03:50:25 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dd0869b33sm195137355e9.9.2025.09.08.03.50.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:50:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/33] rust: vmstate: use const_refs_to_static
Date: Mon,  8 Sep 2025 12:49:40 +0200
Message-ID: <20250908105005.2119297-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908105005.2119297-1-pbonzini@redhat.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The VMStateDescriptionBuilder already needs const_refs_static, so
use it to remove the need for vmstate_clock! and vmstate_struct!,
as well as to simplify the implementation for scalars.

If the consts in the VMState trait can reference to static
VMStateDescription, scalars do not need the info_enum_to_ref!
indirection and structs can implement the VMState trait themselves.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst                  |   5 -
 rust/hw/char/pl011/src/device.rs     |  19 ++-
 rust/hw/timer/hpet/src/device.rs     |   8 +-
 rust/qemu-api/src/assertions.rs      |   4 -
 rust/qemu-api/src/vmstate.rs         | 229 +++++++--------------------
 rust/qemu-api/tests/vmstate_tests.rs |  65 +++++---
 6 files changed, 113 insertions(+), 217 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index aca29e55c05..10b0590b56c 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -84,11 +84,6 @@ patches are welcome:
 
 * ``&raw`` (stable in 1.82.0).
 
-* referencing statics in constants (stable in 1.83.0).  For now use a const
-  function; this is an important limitation for QEMU's migration stream
-  architecture (VMState).  Right now, VMState lacks type safety because
-  it is hard to place the ``VMStateField`` definitions in traits.
-
 * NUL-terminated file names with ``#[track_caller]`` are scheduled for
   inclusion as ``#![feature(location_file_nul)]``, but it will be a while
   before QEMU can use them.  For now, there is special code in
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 21611d9c099..87a17716fed 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -2,14 +2,11 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::{
-    ffi::CStr,
-    mem::size_of
-};
+use std::{ffi::CStr, mem::size_of};
 
 use qemu_api::{
     chardev::{CharBackend, Chardev, Event},
-    impl_vmstate_forward,
+    impl_vmstate_forward, impl_vmstate_struct,
     irq::{IRQState, InterruptSource},
     log::Log,
     log_mask_ln,
@@ -21,7 +18,7 @@
     sysbus::{SysBusDevice, SysBusDeviceImpl},
     uninit_field_mut,
     vmstate::{self, VMStateDescription, VMStateDescriptionBuilder},
-    vmstate_clock, vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_unused,
+    vmstate_fields, vmstate_of, vmstate_subsections, vmstate_unused,
 };
 
 use crate::registers::{self, Interrupt, RegisterOffset};
@@ -725,11 +722,12 @@ impl SysBusDeviceImpl for PL011Luminary {}
         .minimum_version_id(1)
         .needed(&PL011State::clock_needed)
         .fields(vmstate_fields! {
-             vmstate_clock!(PL011State, clock),
+             vmstate_of!(PL011State, clock),
         })
         .build();
 
-static VMSTATE_PL011_REGS: VMStateDescription<PL011Registers> =
+impl_vmstate_struct!(
+    PL011Registers,
     VMStateDescriptionBuilder::<PL011Registers>::new()
         .name(c"pl011/regs")
         .version_id(2)
@@ -751,7 +749,8 @@ impl SysBusDeviceImpl for PL011Luminary {}
             vmstate_of!(PL011Registers, read_count),
             vmstate_of!(PL011Registers, read_trigger),
         })
-        .build();
+        .build()
+);
 
 pub const VMSTATE_PL011: VMStateDescription<PL011State> =
     VMStateDescriptionBuilder::<PL011State>::new()
@@ -761,7 +760,7 @@ impl SysBusDeviceImpl for PL011Luminary {}
         .post_load(&PL011State::post_load)
         .fields(vmstate_fields! {
             vmstate_unused!(core::mem::size_of::<u32>()),
-            vmstate_struct!(PL011State, regs, &VMSTATE_PL011_REGS, BqlRefCell<PL011Registers>),
+            vmstate_of!(PL011State, regs),
         })
         .subsections(vmstate_subsections! {
              VMSTATE_PL011_CLOCK
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 955cf869ff6..eb5bd042b1c 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -16,6 +16,7 @@
         qdev_prop_uint32, qdev_prop_usize,
     },
     cell::{BqlCell, BqlRefCell},
+    impl_vmstate_struct,
     irq::InterruptSource,
     memory::{
         hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder, MEMTXATTRS_UNSPECIFIED,
@@ -28,7 +29,7 @@
     timer::{Timer, CLOCK_VIRTUAL, NANOSECONDS_PER_SECOND},
     uninit_field_mut,
     vmstate::{self, VMStateDescription, VMStateDescriptionBuilder},
-    vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_validate,
+    vmstate_fields, vmstate_of, vmstate_subsections, vmstate_validate,
 };
 
 use crate::fw_cfg::HPETFwConfig;
@@ -964,7 +965,7 @@ impl ObjectImpl for HPETState {
         })
         .build();
 
-static VMSTATE_HPET_TIMER: VMStateDescription<HPETTimer> =
+const VMSTATE_HPET_TIMER: VMStateDescription<HPETTimer> =
     VMStateDescriptionBuilder::<HPETTimer>::new()
         .name(c"hpet_timer")
         .version_id(1)
@@ -979,6 +980,7 @@ impl ObjectImpl for HPETState {
             vmstate_of!(HPETTimer, qemu_timer),
         })
         .build();
+impl_vmstate_struct!(HPETTimer, VMSTATE_HPET_TIMER);
 
 const VALIDATE_TIMERS_NAME: &CStr = c"num_timers must match";
 
@@ -995,7 +997,7 @@ impl ObjectImpl for HPETState {
             vmstate_of!(HPETState, counter),
             vmstate_of!(HPETState, num_timers_save),
             vmstate_validate!(HPETState, VALIDATE_TIMERS_NAME, HPETState::validate_num_timers),
-            vmstate_struct!(HPETState, timers[0 .. num_timers_save], &VMSTATE_HPET_TIMER, BqlRefCell<HPETTimer>, HPETState::validate_num_timers).with_version_id(0),
+            vmstate_of!(HPETState, timers[0 .. num_timers_save], HPETState::validate_num_timers).with_version_id(0),
         })
         .subsections(vmstate_subsections!(
             VMSTATE_HPET_RTC_IRQ_LEVEL,
diff --git a/rust/qemu-api/src/assertions.rs b/rust/qemu-api/src/assertions.rs
index e74fa3ef826..e4fe23b674e 100644
--- a/rust/qemu-api/src/assertions.rs
+++ b/rust/qemu-api/src/assertions.rs
@@ -95,10 +95,6 @@ const fn types_must_be_equal<T, U>(_: &T)
     ($t:ty, $i:tt, $ti:ty) => {
         $crate::assert_field_type!(@internal v, $ti, $t, v.$i);
     };
-
-    ($t:ty, $i:tt, $ti:ty, num = $num:ident) => {
-        $crate::assert_field_type!(@internal v, $ti, $t, v.$i[0]);
-    };
 }
 
 /// Assert that an expression matches a pattern.  This can also be
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index f5f1ea5590f..b5c6b764fbb 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -11,10 +11,11 @@
 //!   migration format for a struct.  This is based on the [`VMState`] trait,
 //!   which is defined by all migratable types.
 //!
-//! * [`impl_vmstate_forward`](crate::impl_vmstate_forward) and
-//!   [`impl_vmstate_bitsized`](crate::impl_vmstate_bitsized), which help with
-//!   the definition of the [`VMState`] trait (respectively for transparent
-//!   structs and for `bilge`-defined types)
+//! * [`impl_vmstate_forward`](crate::impl_vmstate_forward),
+//!   [`impl_vmstate_bitsized`](crate::impl_vmstate_bitsized), and
+//!   [`impl_vmstate_struct`](crate::impl_vmstate_struct), which help with the
+//!   definition of the [`VMState`] trait (respectively for transparent structs,
+//!   nested structs and `bilge`-defined types)
 //!
 //! * helper macros to declare a device model state struct, in particular
 //!   [`vmstate_subsections`](crate::vmstate_subsections) and
@@ -31,7 +32,7 @@
     fmt, io,
     marker::PhantomData,
     mem,
-    ptr::NonNull,
+    ptr::{addr_of, NonNull},
 };
 
 pub use crate::bindings::{MigrationPriority, VMStateField};
@@ -40,6 +41,7 @@
     callbacks::FnCall,
     errno::{into_neg_errno, Errno},
     prelude::*,
+    qdev,
     qom::Owned,
     zeroable::Zeroable,
 };
@@ -81,70 +83,6 @@ const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> { ::core::marker:
     };
 }
 
-/// Workaround for lack of `const_refs_static`: references to global variables
-/// can be included in a `static`, but not in a `const`; unfortunately, this
-/// is exactly what would go in the `VMStateField`'s `info` member.
-///
-/// This enum contains the contents of the `VMStateField`'s `info` member,
-/// but as an `enum` instead of a pointer.
-#[allow(non_camel_case_types)]
-pub enum VMStateFieldType {
-    null,
-    vmstate_info_bool,
-    vmstate_info_int8,
-    vmstate_info_int16,
-    vmstate_info_int32,
-    vmstate_info_int64,
-    vmstate_info_uint8,
-    vmstate_info_uint16,
-    vmstate_info_uint32,
-    vmstate_info_uint64,
-    vmstate_info_timer,
-}
-
-/// Workaround for lack of `const_refs_static`.  Converts a `VMStateFieldType`
-/// to a `*const VMStateInfo`, for inclusion in a `VMStateField`.
-#[macro_export]
-macro_rules! info_enum_to_ref {
-    ($e:expr) => {
-        unsafe {
-            match $e {
-                $crate::vmstate::VMStateFieldType::null => ::core::ptr::null(),
-                $crate::vmstate::VMStateFieldType::vmstate_info_bool => {
-                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_bool)
-                }
-                $crate::vmstate::VMStateFieldType::vmstate_info_int8 => {
-                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_int8)
-                }
-                $crate::vmstate::VMStateFieldType::vmstate_info_int16 => {
-                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_int16)
-                }
-                $crate::vmstate::VMStateFieldType::vmstate_info_int32 => {
-                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_int32)
-                }
-                $crate::vmstate::VMStateFieldType::vmstate_info_int64 => {
-                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_int64)
-                }
-                $crate::vmstate::VMStateFieldType::vmstate_info_uint8 => {
-                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_uint8)
-                }
-                $crate::vmstate::VMStateFieldType::vmstate_info_uint16 => {
-                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_uint16)
-                }
-                $crate::vmstate::VMStateFieldType::vmstate_info_uint32 => {
-                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_uint32)
-                }
-                $crate::vmstate::VMStateFieldType::vmstate_info_uint64 => {
-                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_uint64)
-                }
-                $crate::vmstate::VMStateFieldType::vmstate_info_timer => {
-                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_timer)
-                }
-            }
-        }
-    };
-}
-
 /// A trait for types that can be included in a device's migration stream.  It
 /// provides the base contents of a `VMStateField` (minus the name and offset).
 ///
@@ -155,12 +93,6 @@ macro_rules! info_enum_to_ref {
 /// to implement it except via macros that do it for you, such as
 /// `impl_vmstate_bitsized!`.
 pub unsafe trait VMState {
-    /// The `info` member of a `VMStateField` is a pointer and as such cannot
-    /// yet be included in the [`BASE`](VMState::BASE) associated constant;
-    /// this is only allowed by Rust 1.83.0 and newer.  For now, include the
-    /// member as an enum which is stored in a separate constant.
-    const SCALAR_TYPE: VMStateFieldType = VMStateFieldType::null;
-
     /// The base contents of a `VMStateField` (minus the name and offset) for
     /// the type that is implementing the trait.
     const BASE: VMStateField;
@@ -175,12 +107,6 @@ pub unsafe trait VMState {
     };
 }
 
-/// Internal utility function to retrieve a type's `VMStateFieldType`;
-/// used by [`vmstate_of!`](crate::vmstate_of).
-pub const fn vmstate_scalar_type<T: VMState>(_: PhantomData<T>) -> VMStateFieldType {
-    T::SCALAR_TYPE
-}
-
 /// Internal utility function to retrieve a type's `VMStateField`;
 /// used by [`vmstate_of!`](crate::vmstate_of).
 pub const fn vmstate_base<T: VMState>(_: PhantomData<T>) -> VMStateField {
@@ -207,9 +133,9 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags
 /// * an array of any of the above
 ///
 /// In order to support other types, the trait `VMState` must be implemented
-/// for them.  The macros
-/// [`impl_vmstate_bitsized!`](crate::impl_vmstate_bitsized)
-/// and [`impl_vmstate_forward!`](crate::impl_vmstate_forward) help with this.
+/// for them.  The macros [`impl_vmstate_forward`](crate::impl_vmstate_forward),
+/// [`impl_vmstate_bitsized`](crate::impl_vmstate_bitsized), and
+/// [`impl_vmstate_struct`](crate::impl_vmstate_struct) help with this.
 #[macro_export]
 macro_rules! vmstate_of {
     ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])? $(, $test_fn:expr)? $(,)?) => {
@@ -222,11 +148,6 @@ macro_rules! vmstate_of {
             $(field_exists: $crate::vmstate_exist_fn!($struct_name, $test_fn),)?
             // The calls to `call_func_with_field!` are the magic that
             // computes most of the VMStateField from the type of the field.
-            info: $crate::info_enum_to_ref!($crate::call_func_with_field!(
-                $crate::vmstate::vmstate_scalar_type,
-                $struct_name,
-                $field_name
-            )),
             ..$crate::call_func_with_field!(
                 $crate::vmstate::vmstate_base,
                 $struct_name,
@@ -327,8 +248,6 @@ macro_rules! impl_vmstate_forward {
     // the first field of the tuple
     ($tuple:ty) => {
         unsafe impl $crate::vmstate::VMState for $tuple {
-            const SCALAR_TYPE: $crate::vmstate::VMStateFieldType =
-                $crate::call_func_with_field!($crate::vmstate::vmstate_scalar_type, $tuple, 0);
             const BASE: $crate::bindings::VMStateField =
                 $crate::call_func_with_field!($crate::vmstate::vmstate_base, $tuple, 0);
         }
@@ -340,7 +259,6 @@ unsafe impl $crate::vmstate::VMState for $tuple {
 macro_rules! impl_vmstate_transparent {
     ($type:ty where $base:tt: VMState $($where:tt)*) => {
         unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
-            const SCALAR_TYPE: VMStateFieldType = <$base as VMState>::SCALAR_TYPE;
             const BASE: VMStateField = VMStateField {
                 size: mem::size_of::<$type>(),
                 ..<$base as VMState>::BASE
@@ -361,10 +279,6 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 macro_rules! impl_vmstate_bitsized {
     ($type:ty) => {
         unsafe impl $crate::vmstate::VMState for $type {
-            const SCALAR_TYPE: $crate::vmstate::VMStateFieldType =
-                                        <<<$type as ::bilge::prelude::Bitsized>::ArbitraryInt
-                                          as ::bilge::prelude::Number>::UnderlyingType
-                                         as $crate::vmstate::VMState>::SCALAR_TYPE;
             const BASE: $crate::bindings::VMStateField =
                                         <<<$type as ::bilge::prelude::Bitsized>::ArbitraryInt
                                           as ::bilge::prelude::Number>::UnderlyingType
@@ -382,8 +296,8 @@ unsafe impl $crate::vmstate::VMState for $type {
 macro_rules! impl_vmstate_scalar {
     ($info:ident, $type:ty$(, $varray_flag:ident)?) => {
         unsafe impl VMState for $type {
-            const SCALAR_TYPE: VMStateFieldType = VMStateFieldType::$info;
             const BASE: VMStateField = VMStateField {
+                info: addr_of!(bindings::$info),
                 size: mem::size_of::<$type>(),
                 flags: VMStateFlags::VMS_SINGLE,
                 ..Zeroable::ZERO
@@ -404,6 +318,21 @@ unsafe impl VMState for $type {
 impl_vmstate_scalar!(vmstate_info_uint64, u64);
 impl_vmstate_scalar!(vmstate_info_timer, crate::timer::Timer);
 
+macro_rules! impl_vmstate_c_struct {
+    ($type:ty, $vmsd:expr) => {
+        unsafe impl VMState for $type {
+            const BASE: VMStateField = $crate::bindings::VMStateField {
+                vmsd: addr_of!($vmsd),
+                size: mem::size_of::<$type>(),
+                flags: VMStateFlags::VMS_STRUCT,
+                ..Zeroable::ZERO
+            };
+        }
+    };
+}
+
+impl_vmstate_c_struct!(qdev::Clock, bindings::vmstate_clock);
+
 // Pointer types using the underlying type's VMState plus VMS_POINTER
 // Note that references are not supported, though references to cells
 // could be allowed.
@@ -411,7 +340,6 @@ unsafe impl VMState for $type {
 macro_rules! impl_vmstate_pointer {
     ($type:ty where $base:tt: VMState $($where:tt)*) => {
         unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
-            const SCALAR_TYPE: VMStateFieldType = <T as VMState>::SCALAR_TYPE;
             const BASE: VMStateField = <$base as VMState>::BASE.with_pointer_flag();
         }
     };
@@ -430,7 +358,6 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 // VMS_ARRAY/VMS_ARRAY_OF_POINTER
 
 unsafe impl<T: VMState, const N: usize> VMState for [T; N] {
-    const SCALAR_TYPE: VMStateFieldType = <T as VMState>::SCALAR_TYPE;
     const BASE: VMStateField = <T as VMState>::BASE.with_array_flag(N);
 }
 
@@ -452,7 +379,7 @@ pub extern "C" fn rust_vms_test_field_exists<T, F: for<'a> FnCall<(&'a T, u8), b
     opaque: *mut c_void,
     version_id: c_int,
 ) -> bool {
-    // SAFETY: assumes vmstate_struct! is used correctly
+    // SAFETY: the function is used in T's implementation of VMState
     let owner: &T = unsafe { &*(opaque.cast::<T>()) };
     let version: u8 = version_id.try_into().unwrap();
     F::call((owner, version))
@@ -480,76 +407,6 @@ const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> {
     }};
 }
 
-// FIXME: including the `vmsd` field in a `const` is not possible without
-// the const_refs_static feature (stabilized in Rust 1.83.0).  Without it,
-// it is not possible to use VMS_STRUCT in a transparent manner using
-// `vmstate_of!`.  While VMSTATE_CLOCK can at least try to be type-safe,
-// VMSTATE_STRUCT includes $type only for documentation purposes; it
-// is checked against $field_name and $struct_name, but not against $vmsd
-// which is what really would matter.
-#[doc(alias = "VMSTATE_STRUCT")]
-#[macro_export]
-macro_rules! vmstate_struct {
-    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])?, $vmsd:expr, $type:ty $(, $test_fn:expr)? $(,)?) => {
-        $crate::bindings::VMStateField {
-            name: ::core::concat!(::core::stringify!($field_name), "\0")
-                .as_bytes()
-                .as_ptr() as *const ::std::os::raw::c_char,
-            $(num_offset: ::std::mem::offset_of!($struct_name, $num),)?
-            offset: {
-                $crate::assert_field_type!($struct_name, $field_name, $type $(, num = $num)?);
-                ::std::mem::offset_of!($struct_name, $field_name)
-            },
-            size: ::core::mem::size_of::<$type>(),
-            flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
-            vmsd: $vmsd.as_ref(),
-            $(field_exists: $crate::vmstate_exist_fn!($struct_name, $test_fn),)?
-            ..$crate::zeroable::Zeroable::ZERO
-         } $(.with_varray_flag_unchecked(
-                  $crate::call_func_with_field!(
-                      $crate::vmstate::vmstate_varray_flag,
-                      $struct_name,
-                      $num
-                  )
-              )
-           $(.with_varray_multiply($factor))?)?
-    };
-}
-
-#[doc(alias = "VMSTATE_CLOCK")]
-#[macro_export]
-macro_rules! vmstate_clock {
-    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])?) => {{
-        $crate::bindings::VMStateField {
-            name: ::core::concat!(::core::stringify!($field_name), "\0")
-                .as_bytes()
-                .as_ptr() as *const ::std::os::raw::c_char,
-            offset: {
-                $crate::assert_field_type!(
-                    $struct_name,
-                    $field_name,
-                    $crate::qom::Owned<$crate::qdev::Clock> $(, num = $num)?
-                );
-                ::std::mem::offset_of!($struct_name, $field_name)
-            },
-            size: ::core::mem::size_of::<*const $crate::qdev::Clock>(),
-            flags: $crate::bindings::VMStateFlags(
-                $crate::bindings::VMStateFlags::VMS_STRUCT.0
-                    | $crate::bindings::VMStateFlags::VMS_POINTER.0,
-            ),
-            vmsd: unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_clock) },
-            ..$crate::zeroable::Zeroable::ZERO
-         } $(.with_varray_flag_unchecked(
-                  $crate::call_func_with_field!(
-                      $crate::vmstate::vmstate_varray_flag,
-                      $struct_name,
-                      $num
-                  )
-              )
-           $(.with_varray_multiply($factor))?)?
-    }};
-}
-
 /// Helper macro to declare a list of
 /// ([`VMStateField`](`crate::bindings::VMStateField`)) into a static and return
 /// a pointer to the array of values it created.
@@ -584,6 +441,30 @@ macro_rules! vmstate_validate {
     };
 }
 
+/// Helper macro to allow using a struct in [`vmstate_of!`]
+///
+/// # Safety
+///
+/// The [`VMStateDescription`] constant `$vmsd` must be an accurate
+/// description of the struct.
+#[macro_export]
+macro_rules! impl_vmstate_struct {
+    ($type:ty, $vmsd:expr) => {
+        unsafe impl $crate::vmstate::VMState for $type {
+            const BASE: $crate::bindings::VMStateField = {
+                static VMSD: &$crate::bindings::VMStateDescription = $vmsd.as_ref();
+
+                $crate::bindings::VMStateField {
+                    vmsd: ::core::ptr::addr_of!(*VMSD),
+                    size: ::core::mem::size_of::<$type>(),
+                    flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
+                    ..$crate::zeroable::Zeroable::ZERO
+                }
+            };
+        }
+    };
+}
+
 /// A transparent wrapper type for the `subsections` field of
 /// [`VMStateDescription`].
 ///
@@ -648,7 +529,7 @@ fn from(_value: InvalidError) -> Errno {
 >(
     opaque: *mut c_void,
 ) -> c_int {
-    // SAFETY: assumes vmstate_struct! is used correctly
+    // SAFETY: the function is used in T's implementation of VMState
     let result = F::call((unsafe { &*(opaque.cast::<T>()) },));
     into_neg_errno(result)
 }
@@ -660,7 +541,7 @@ fn from(_value: InvalidError) -> Errno {
     opaque: *mut c_void,
     version_id: c_int,
 ) -> c_int {
-    // SAFETY: assumes vmstate_struct! is used correctly
+    // SAFETY: the function is used in T's implementation of VMState
     let owner: &T = unsafe { &*(opaque.cast::<T>()) };
     let version: u8 = version_id.try_into().unwrap();
     let result = F::call((owner, version));
@@ -670,14 +551,14 @@ fn from(_value: InvalidError) -> Errno {
 unsafe extern "C" fn vmstate_needed_cb<T, F: for<'a> FnCall<(&'a T,), bool>>(
     opaque: *mut c_void,
 ) -> bool {
-    // SAFETY: assumes vmstate_struct! is used correctly
+    // SAFETY: the function is used in T's implementation of VMState
     F::call((unsafe { &*(opaque.cast::<T>()) },))
 }
 
 unsafe extern "C" fn vmstate_dev_unplug_pending_cb<T, F: for<'a> FnCall<(&'a T,), bool>>(
     opaque: *mut c_void,
 ) -> bool {
-    // SAFETY: assumes vmstate_struct! is used correctly
+    // SAFETY: the function is used in T's implementation of VMState
     F::call((unsafe { &*(opaque.cast::<T>()) },))
 }
 
diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index 8ffc2779d46..2c0670ba0ee 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -15,9 +15,9 @@
         vmstate_info_uint64, vmstate_info_uint8, vmstate_info_unused_buffer, VMStateFlags,
     },
     cell::{BqlCell, Opaque},
-    impl_vmstate_forward,
+    impl_vmstate_forward, impl_vmstate_struct,
     vmstate::{VMStateDescription, VMStateDescriptionBuilder, VMStateField},
-    vmstate_fields, vmstate_of, vmstate_struct, vmstate_unused, vmstate_validate,
+    vmstate_fields, vmstate_of, vmstate_unused, vmstate_validate,
 };
 
 const FOO_ARRAY_MAX: usize = 3;
@@ -52,6 +52,8 @@ struct FooA {
     })
     .build();
 
+impl_vmstate_struct!(FooA, VMSTATE_FOOA);
+
 #[test]
 fn test_vmstate_uint16() {
     let foo_fields: &[VMStateField] =
@@ -173,20 +175,19 @@ fn validate_foob(_state: &FooB, _version_id: u8) -> bool {
     true
 }
 
-static VMSTATE_FOOB: VMStateDescription<FooB> =
-    VMStateDescriptionBuilder::<FooB>::new()
-        .name(c"foo_b")
-        .version_id(2)
-        .minimum_version_id(1)
-        .fields(vmstate_fields! {
-            vmstate_of!(FooB, val).with_version_id(2),
-            vmstate_of!(FooB, wrap),
-            vmstate_struct!(FooB, arr_a[0 .. num_a], &VMSTATE_FOOA, FooA).with_version_id(1),
-            vmstate_struct!(FooB, arr_a_mul[0 .. num_a_mul * 32], &VMSTATE_FOOA, FooA).with_version_id(2),
-            vmstate_of!(FooB, arr_i64),
-            vmstate_struct!(FooB, arr_a_wrap[0 .. num_a_wrap], &VMSTATE_FOOA, FooA, validate_foob),
-        })
-        .build();
+static VMSTATE_FOOB: VMStateDescription<FooB> = VMStateDescriptionBuilder::<FooB>::new()
+    .name(c"foo_b")
+    .version_id(2)
+    .minimum_version_id(1)
+    .fields(vmstate_fields! {
+        vmstate_of!(FooB, val).with_version_id(2),
+        vmstate_of!(FooB, wrap),
+        vmstate_of!(FooB, arr_a[0 .. num_a]).with_version_id(1),
+        vmstate_of!(FooB, arr_a_mul[0 .. num_a_mul * 32]).with_version_id(2),
+        vmstate_of!(FooB, arr_i64),
+        vmstate_of!(FooB, arr_a_wrap[0 .. num_a_wrap], validate_foob),
+    })
+    .build();
 
 #[test]
 fn test_vmstate_bool_v() {
@@ -351,9 +352,7 @@ unsafe impl Sync for FooC {}
     .minimum_version_id(1)
     .fields(vmstate_fields! {
         vmstate_of!(FooC, ptr).with_version_id(2),
-        // FIXME: Currently vmstate_struct doesn't support the pointer to structure.
-        // VMSTATE_STRUCT_POINTER: vmstate_struct!(FooC, ptr_a, VMSTATE_FOOA, NonNull<FooA>)
-        vmstate_unused!(size_of::<NonNull<FooA>>()),
+        vmstate_of!(FooC, ptr_a),
         vmstate_of!(FooC, arr_ptr),
         vmstate_of!(FooC, arr_ptr_wrap),
     })
@@ -385,6 +384,31 @@ fn test_vmstate_pointer() {
     assert!(foo_fields[0].field_exists.is_none());
 }
 
+#[test]
+fn test_vmstate_struct_pointer() {
+    let foo_fields: &[VMStateField] =
+        unsafe { slice::from_raw_parts(VMSTATE_FOOC.as_ref().fields, 6) };
+
+    // 2st VMStateField ("ptr_a") in VMSTATE_FOOC (corresponding to
+    // VMSTATE_STRUCT_POINTER)
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[1].name) }.to_bytes_with_nul(),
+        b"ptr_a\0"
+    );
+    assert_eq!(foo_fields[1].offset, PTR_SIZE);
+    assert_eq!(foo_fields[1].num_offset, 0);
+    assert_eq!(foo_fields[1].vmsd, VMSTATE_FOOA.as_ref());
+    assert_eq!(foo_fields[1].version_id, 0);
+    assert_eq!(foo_fields[1].size, size_of::<FooA>());
+    assert_eq!(foo_fields[1].num, 0);
+    assert_eq!(
+        foo_fields[1].flags.0,
+        VMStateFlags::VMS_STRUCT.0 | VMStateFlags::VMS_POINTER.0
+    );
+    assert!(foo_fields[1].info.is_null());
+    assert!(foo_fields[1].field_exists.is_none());
+}
+
 #[test]
 fn test_vmstate_macro_array_of_pointer() {
     let foo_fields: &[VMStateField] =
@@ -444,8 +468,7 @@ fn test_vmstate_macro_array_of_pointer_wrapped() {
 //   * VMSTATE_FOOD:
 //     - VMSTATE_VALIDATE
 
-// Add more member fields when vmstate_of/vmstate_struct support "test"
-// parameter.
+// Add more member fields when vmstate_of support "test" parameter.
 struct FooD;
 
 impl FooD {
-- 
2.51.0


