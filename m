Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CC5B48AE0
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Sep 2025 13:01:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZSf-0006Ag-Qq; Mon, 08 Sep 2025 06:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSY-00067O-7s
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:50:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSI-000604-I3
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757328628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kdCkDQsW/IWpZoK1t5qLNlMlJI3HAL7+sHDe6qRvLs4=;
 b=CMJGlnIb1wQ4ItTM82RZK1KeaPFbSuYxm2XUJPQuFb4N/TjVBHzGqWnuQA2Al1bJiUZwuG
 Rzg5+TW7bD1NM7/Zobxn5LDhvb+CeB6mDYiDdWjaCm5stY43F69nGyS/z6G6AxX2ZzWkio
 KIDWL1KpmmpX4vVnW09b+AKRhFZJzf4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-SsESdCYpN5C3BgfiisHEhw-1; Mon, 08 Sep 2025 06:50:27 -0400
X-MC-Unique: SsESdCYpN5C3BgfiisHEhw-1
X-Mimecast-MFC-AGG-ID: SsESdCYpN5C3BgfiisHEhw_1757328626
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3df9f185c7cso3176955f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757328625; x=1757933425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kdCkDQsW/IWpZoK1t5qLNlMlJI3HAL7+sHDe6qRvLs4=;
 b=YyBtnkborEr2slwmQ0o3ILs1LO/fjeRzrbigR0jEQ7vuncqDoby30WLCv6MzyCnzpK
 NJ7OxFLWr1izlAYrdki3jxvd+DcrWzIlkmgD/oax3aXF90rvMUGr0Q2XkIyU+znbvDfw
 7Xlr8/HvGy5HPMtHaInK/FhRFvX4BskVwYh5/NOy8E8SkJReVnL/to74q0LOWPBuwWFF
 MfuBIQdQ9pKpxJWPFqKNzBNMkXp4F35a9m1xtFRkdsJq3nMbUHo3UHBf2NonqZwDJvjF
 +jeXgUsbHKPICwctb/1O3tf6YgGuLrhkzJaoNMyiLpJirWK+o0mm2LA3smHYBEbs99hA
 R18Q==
X-Gm-Message-State: AOJu0Yz6tAIdoAGQ2U2P7vHJ9XPy4Riq6hp1pRi27wf+bT6/HzEEYKqe
 XzcfUbA8/IsITAjeMpiapLknPeP+fumkzzcqahU1ee6QG+G8ZxzWFlFqTi9R5mYENtSGenjTRnJ
 CHVUJHjBRTUOR/6ue8EjG/c6rU7wUootmWsmPH+n9cThMSatRs/5MKoO/UEOn5fERj/lDC+eSb/
 89IE2sukyiAr13DPk661s213iHdnn0kBpJJoSZEi83
X-Gm-Gg: ASbGncu2K4Pvvw963ge3smXPmiXEpOaeGbdyZ1dHVyU6xBZwnmvBjTkc9Jq7+guGt3y
 tX7KP7B0+0xknzPaN0duhhk5YNlZLxynsD2xMBcvfZH5uk7XLhoCjUQ1szIFpLvTkvhoBBUK5qC
 jr6/3TRlbmf34VCDLQVNc6V1+DP5gzMlZOGrBKqtutk1o/UvN895goDwSST8A62cLhrIBwnLM8T
 Z684wXLkj3FGDAUVKSYpX+SQKPITtu/PpzMJf3Qw6YtnMnHd2B9bDFkQVL/jO2XgLBsHsGR+kaZ
 0kQQ05IOEpqvDShitBjKv8fogVk/rvyP4654qkVMdSfrNyKp6xDkTcgvC0VB7N/BIPazSR2hCV2
 BRSa5e3adTp+7cIlLEGwPQd+xEaEaaRnHshmekaOzGD0=
X-Received: by 2002:a05:6000:438a:b0:3e3:61ba:696f with SMTP id
 ffacd0b85a97d-3e63736d06dmr4972029f8f.2.1757328624875; 
 Mon, 08 Sep 2025 03:50:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFG8BjbVMKvfumK3Tkb+RJiqqn8co+hIzyMd7EuVbcvlu0hOWng1zc3He58WQ+fsp3l2bH7uA==
X-Received: by 2002:a05:6000:438a:b0:3e3:61ba:696f with SMTP id
 ffacd0b85a97d-3e63736d06dmr4971981f8f.2.1757328623913; 
 Mon, 08 Sep 2025 03:50:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45de15de2b7sm79491605e9.14.2025.09.08.03.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:50:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 07/33] rust: vmstate: convert to use builder pattern
Date: Mon,  8 Sep 2025 12:49:39 +0200
Message-ID: <20250908105005.2119297-8-pbonzini@redhat.com>
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

From: Zhao Liu <zhao1.liu@intel.com>

Similar to MemoryRegionOps, the builder pattern has two advantages:
1) it makes it possible to build a VMStateDescription that knows which
types it will be invoked on; 2) it provides a way to wrap the callbacks
and let devices avoid "unsafe".

Unfortunately, building a static VMStateDescription requires the
builder methods to be "const", and because the VMStateFields are
*also* static, this requires const_refs_static.  So this requires
Rust 1.83.0.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst                  |   2 +-
 rust/hw/char/pl011/src/device.rs     | 131 +++++++--------
 rust/hw/timer/hpet/src/device.rs     | 162 ++++++++----------
 rust/qemu-api/src/errno.rs           |  11 +-
 rust/qemu-api/src/qdev.rs            |   6 +-
 rust/qemu-api/src/vmstate.rs         | 242 ++++++++++++++++++++++++++-
 rust/qemu-api/tests/tests.rs         |  16 +-
 rust/qemu-api/tests/vmstate_tests.rs | 124 +++++++-------
 8 files changed, 450 insertions(+), 244 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 98e3a33a3ce..aca29e55c05 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -162,7 +162,7 @@ module           status
 ``qom``          stable
 ``sysbus``       stable
 ``timer``        stable
-``vmstate``      proof of concept
+``vmstate``      stable
 ``zeroable``     stable
 ================ ======================
 
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 37944635202..21611d9c099 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -3,9 +3,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use std::{
-    ffi::{c_int, c_void, CStr},
-    mem::size_of,
-    ptr::NonNull,
+    ffi::CStr,
+    mem::size_of
 };
 
 use qemu_api::{
@@ -21,9 +20,8 @@
     static_assert,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
     uninit_field_mut,
-    vmstate::VMStateDescription,
+    vmstate::{self, VMStateDescription, VMStateDescriptionBuilder},
     vmstate_clock, vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_unused,
-    zeroable::Zeroable,
 };
 
 use crate::registers::{self, Interrupt, RegisterOffset};
@@ -177,8 +175,8 @@ impl ObjectImpl for PL011State {
 }
 
 impl DeviceImpl for PL011State {
-    fn vmsd() -> Option<&'static VMStateDescription> {
-        Some(&VMSTATE_PL011)
+    fn vmsd() -> Option<VMStateDescription<Self>> {
+        Some(VMSTATE_PL011)
     }
     const REALIZE: Option<fn(&Self) -> qemu_api::Result<()>> = Some(Self::realize);
 }
@@ -467,10 +465,10 @@ pub fn fifo_rx_put(&mut self, value: registers::Data) -> bool {
         false
     }
 
-    pub fn post_load(&mut self) -> Result<(), ()> {
+    pub fn post_load(&mut self) -> Result<(), vmstate::InvalidError> {
         /* Sanity-check input state */
         if self.read_pos >= self.read_fifo.len() || self.read_count > self.read_fifo.len() {
-            return Err(());
+            return Err(vmstate::InvalidError);
         }
 
         if !self.fifo_enabled() && self.read_count > 0 && self.read_pos > 0 {
@@ -529,6 +527,10 @@ const fn clock_update(&self, _event: ClockEvent) {
         /* pl011_trace_baudrate_change(s); */
     }
 
+    pub fn clock_needed(&self) -> bool {
+        self.migrate_clock
+    }
+
     fn post_init(&self) {
         self.init_mmio(&self.iomem);
         for irq in self.interrupts.iter() {
@@ -645,7 +647,7 @@ fn update(&self) {
         }
     }
 
-    pub fn post_load(&self, _version_id: u32) -> Result<(), ()> {
+    pub fn post_load(&self, _version_id: u8) -> Result<(), vmstate::InvalidError> {
         self.regs.borrow_mut().post_load()
     }
 }
@@ -715,68 +717,53 @@ impl DeviceImpl for PL011Luminary {}
 impl ResettablePhasesImpl for PL011Luminary {}
 impl SysBusDeviceImpl for PL011Luminary {}
 
-extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
-    let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
-    unsafe { state.as_ref().migrate_clock }
-}
-
 /// Migration subsection for [`PL011State`] clock.
-static VMSTATE_PL011_CLOCK: VMStateDescription = VMStateDescription {
-    name: c"pl011/clock".as_ptr(),
-    version_id: 1,
-    minimum_version_id: 1,
-    needed: Some(pl011_clock_needed),
-    fields: vmstate_fields! {
-        vmstate_clock!(PL011State, clock),
-    },
-    ..Zeroable::ZERO
-};
+static VMSTATE_PL011_CLOCK: VMStateDescription<PL011State> =
+    VMStateDescriptionBuilder::<PL011State>::new()
+        .name(c"pl011/clock")
+        .version_id(1)
+        .minimum_version_id(1)
+        .needed(&PL011State::clock_needed)
+        .fields(vmstate_fields! {
+             vmstate_clock!(PL011State, clock),
+        })
+        .build();
 
-extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
-    let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
-    let result = unsafe { state.as_ref().post_load(version_id as u32) };
-    if result.is_err() {
-        -1
-    } else {
-        0
-    }
-}
+static VMSTATE_PL011_REGS: VMStateDescription<PL011Registers> =
+    VMStateDescriptionBuilder::<PL011Registers>::new()
+        .name(c"pl011/regs")
+        .version_id(2)
+        .minimum_version_id(2)
+        .fields(vmstate_fields! {
+            vmstate_of!(PL011Registers, flags),
+            vmstate_of!(PL011Registers, line_control),
+            vmstate_of!(PL011Registers, receive_status_error_clear),
+            vmstate_of!(PL011Registers, control),
+            vmstate_of!(PL011Registers, dmacr),
+            vmstate_of!(PL011Registers, int_enabled),
+            vmstate_of!(PL011Registers, int_level),
+            vmstate_of!(PL011Registers, read_fifo),
+            vmstate_of!(PL011Registers, ilpr),
+            vmstate_of!(PL011Registers, ibrd),
+            vmstate_of!(PL011Registers, fbrd),
+            vmstate_of!(PL011Registers, ifl),
+            vmstate_of!(PL011Registers, read_pos),
+            vmstate_of!(PL011Registers, read_count),
+            vmstate_of!(PL011Registers, read_trigger),
+        })
+        .build();
 
-static VMSTATE_PL011_REGS: VMStateDescription = VMStateDescription {
-    name: c"pl011/regs".as_ptr(),
-    version_id: 2,
-    minimum_version_id: 2,
-    fields: vmstate_fields! {
-        vmstate_of!(PL011Registers, flags),
-        vmstate_of!(PL011Registers, line_control),
-        vmstate_of!(PL011Registers, receive_status_error_clear),
-        vmstate_of!(PL011Registers, control),
-        vmstate_of!(PL011Registers, dmacr),
-        vmstate_of!(PL011Registers, int_enabled),
-        vmstate_of!(PL011Registers, int_level),
-        vmstate_of!(PL011Registers, read_fifo),
-        vmstate_of!(PL011Registers, ilpr),
-        vmstate_of!(PL011Registers, ibrd),
-        vmstate_of!(PL011Registers, fbrd),
-        vmstate_of!(PL011Registers, ifl),
-        vmstate_of!(PL011Registers, read_pos),
-        vmstate_of!(PL011Registers, read_count),
-        vmstate_of!(PL011Registers, read_trigger),
-    },
-    ..Zeroable::ZERO
-};
-
-pub static VMSTATE_PL011: VMStateDescription = VMStateDescription {
-    name: c"pl011".as_ptr(),
-    version_id: 2,
-    minimum_version_id: 2,
-    post_load: Some(pl011_post_load),
-    fields: vmstate_fields! {
-        vmstate_unused!(core::mem::size_of::<u32>()),
-        vmstate_struct!(PL011State, regs, &VMSTATE_PL011_REGS, BqlRefCell<PL011Registers>),
-    },
-    subsections: vmstate_subsections! {
-        VMSTATE_PL011_CLOCK
-    },
-    ..Zeroable::ZERO
-};
+pub const VMSTATE_PL011: VMStateDescription<PL011State> =
+    VMStateDescriptionBuilder::<PL011State>::new()
+        .name(c"pl011")
+        .version_id(2)
+        .minimum_version_id(2)
+        .post_load(&PL011State::post_load)
+        .fields(vmstate_fields! {
+            vmstate_unused!(core::mem::size_of::<u32>()),
+            vmstate_struct!(PL011State, regs, &VMSTATE_PL011_REGS, BqlRefCell<PL011Registers>),
+        })
+        .subsections(vmstate_subsections! {
+             VMSTATE_PL011_CLOCK
+        })
+        .build();
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 01d5a0dd70c..955cf869ff6 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -3,7 +3,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use std::{
-    ffi::{c_int, c_void, CStr},
+    ffi::CStr,
     mem::MaybeUninit,
     pin::Pin,
     ptr::{addr_of_mut, null_mut, NonNull},
@@ -27,9 +27,8 @@
     sysbus::{SysBusDevice, SysBusDeviceImpl},
     timer::{Timer, CLOCK_VIRTUAL, NANOSECONDS_PER_SECOND},
     uninit_field_mut,
-    vmstate::VMStateDescription,
+    vmstate::{self, VMStateDescription, VMStateDescriptionBuilder},
     vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_validate,
-    zeroable::Zeroable,
 };
 
 use crate::fw_cfg::HPETFwConfig;
@@ -213,6 +212,10 @@ pub struct HPETTimer {
     last: u64,
 }
 
+// SAFETY: Sync is not automatically derived due to the `state` field,
+// which is always dereferenced to a shared reference.
+unsafe impl Sync for HPETTimer {}
+
 impl HPETTimer {
     fn new(index: u8, state: *const HPETState) -> HPETTimer {
         HPETTimer {
@@ -841,7 +844,7 @@ fn write(&self, addr: hwaddr, value: u64, size: u32) {
         }
     }
 
-    fn pre_save(&self) -> i32 {
+    fn pre_save(&self) -> Result<(), vmstate::Infallible> {
         if self.is_hpet_enabled() {
             self.counter.set(self.get_ticks());
         }
@@ -852,10 +855,10 @@ fn pre_save(&self) -> i32 {
          * that was configured.
          */
         self.num_timers_save.set(self.num_timers as u8);
-        0
+        Ok(())
     }
 
-    fn post_load(&self, _version_id: u8) -> i32 {
+    fn post_load(&self, _version_id: u8) -> Result<(), vmstate::Infallible> {
         for timer in self.timers.iter().take(self.num_timers) {
             let mut t = timer.borrow_mut();
 
@@ -869,7 +872,7 @@ fn post_load(&self, _version_id: u8) -> i32 {
                 .set(ticks_to_ns(self.counter.get()) - CLOCK_VIRTUAL.get_ns());
         }
 
-        0
+        Ok(())
     }
 
     fn is_rtc_irq_level_needed(&self) -> bool {
@@ -939,97 +942,66 @@ impl ObjectImpl for HPETState {
     ),
 }
 
-unsafe extern "C" fn hpet_rtc_irq_level_needed(opaque: *mut c_void) -> bool {
-    // SAFETY:
-    // the pointer is convertible to a reference
-    let state: &HPETState = unsafe { NonNull::new(opaque.cast::<HPETState>()).unwrap().as_ref() };
-    state.is_rtc_irq_level_needed()
-}
+static VMSTATE_HPET_RTC_IRQ_LEVEL: VMStateDescription<HPETState> =
+    VMStateDescriptionBuilder::<HPETState>::new()
+        .name(c"hpet/rtc_irq_level")
+        .version_id(1)
+        .minimum_version_id(1)
+        .needed(&HPETState::is_rtc_irq_level_needed)
+        .fields(vmstate_fields! {
+            vmstate_of!(HPETState, rtc_irq_level),
+        })
+        .build();
 
-unsafe extern "C" fn hpet_offset_needed(opaque: *mut c_void) -> bool {
-    // SAFETY:
-    // the pointer is convertible to a reference
-    let state: &HPETState = unsafe { NonNull::new(opaque.cast::<HPETState>()).unwrap().as_ref() };
-    state.is_offset_needed()
-}
+static VMSTATE_HPET_OFFSET: VMStateDescription<HPETState> =
+    VMStateDescriptionBuilder::<HPETState>::new()
+        .name(c"hpet/offset")
+        .version_id(1)
+        .minimum_version_id(1)
+        .needed(&HPETState::is_offset_needed)
+        .fields(vmstate_fields! {
+            vmstate_of!(HPETState, hpet_offset),
+        })
+        .build();
 
-unsafe extern "C" fn hpet_pre_save(opaque: *mut c_void) -> c_int {
-    // SAFETY:
-    // the pointer is convertible to a reference
-    let state: &mut HPETState =
-        unsafe { NonNull::new(opaque.cast::<HPETState>()).unwrap().as_mut() };
-    state.pre_save() as c_int
-}
-
-unsafe extern "C" fn hpet_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
-    // SAFETY:
-    // the pointer is convertible to a reference
-    let state: &mut HPETState =
-        unsafe { NonNull::new(opaque.cast::<HPETState>()).unwrap().as_mut() };
-    let version: u8 = version_id.try_into().unwrap();
-    state.post_load(version) as c_int
-}
-
-static VMSTATE_HPET_RTC_IRQ_LEVEL: VMStateDescription = VMStateDescription {
-    name: c"hpet/rtc_irq_level".as_ptr(),
-    version_id: 1,
-    minimum_version_id: 1,
-    needed: Some(hpet_rtc_irq_level_needed),
-    fields: vmstate_fields! {
-        vmstate_of!(HPETState, rtc_irq_level),
-    },
-    ..Zeroable::ZERO
-};
-
-static VMSTATE_HPET_OFFSET: VMStateDescription = VMStateDescription {
-    name: c"hpet/offset".as_ptr(),
-    version_id: 1,
-    minimum_version_id: 1,
-    needed: Some(hpet_offset_needed),
-    fields: vmstate_fields! {
-        vmstate_of!(HPETState, hpet_offset),
-    },
-    ..Zeroable::ZERO
-};
-
-static VMSTATE_HPET_TIMER: VMStateDescription = VMStateDescription {
-    name: c"hpet_timer".as_ptr(),
-    version_id: 1,
-    minimum_version_id: 1,
-    fields: vmstate_fields! {
-        vmstate_of!(HPETTimer, index),
-        vmstate_of!(HPETTimer, config),
-        vmstate_of!(HPETTimer, cmp),
-        vmstate_of!(HPETTimer, fsb),
-        vmstate_of!(HPETTimer, period),
-        vmstate_of!(HPETTimer, wrap_flag),
-        vmstate_of!(HPETTimer, qemu_timer),
-    },
-    ..Zeroable::ZERO
-};
+static VMSTATE_HPET_TIMER: VMStateDescription<HPETTimer> =
+    VMStateDescriptionBuilder::<HPETTimer>::new()
+        .name(c"hpet_timer")
+        .version_id(1)
+        .minimum_version_id(1)
+        .fields(vmstate_fields! {
+            vmstate_of!(HPETTimer, index),
+            vmstate_of!(HPETTimer, config),
+            vmstate_of!(HPETTimer, cmp),
+            vmstate_of!(HPETTimer, fsb),
+            vmstate_of!(HPETTimer, period),
+            vmstate_of!(HPETTimer, wrap_flag),
+            vmstate_of!(HPETTimer, qemu_timer),
+        })
+        .build();
 
 const VALIDATE_TIMERS_NAME: &CStr = c"num_timers must match";
 
-static VMSTATE_HPET: VMStateDescription = VMStateDescription {
-    name: c"hpet".as_ptr(),
-    version_id: 2,
-    minimum_version_id: 2,
-    pre_save: Some(hpet_pre_save),
-    post_load: Some(hpet_post_load),
-    fields: vmstate_fields! {
-        vmstate_of!(HPETState, config),
-        vmstate_of!(HPETState, int_status),
-        vmstate_of!(HPETState, counter),
-        vmstate_of!(HPETState, num_timers_save),
-        vmstate_validate!(HPETState, VALIDATE_TIMERS_NAME, HPETState::validate_num_timers),
-        vmstate_struct!(HPETState, timers[0 .. num_timers_save], &VMSTATE_HPET_TIMER, BqlRefCell<HPETTimer>, HPETState::validate_num_timers).with_version_id(0),
-    },
-    subsections: vmstate_subsections! {
-        VMSTATE_HPET_RTC_IRQ_LEVEL,
-        VMSTATE_HPET_OFFSET,
-    },
-    ..Zeroable::ZERO
-};
+const VMSTATE_HPET: VMStateDescription<HPETState> =
+    VMStateDescriptionBuilder::<HPETState>::new()
+        .name(c"hpet")
+        .version_id(2)
+        .minimum_version_id(2)
+        .pre_save(&HPETState::pre_save)
+        .post_load(&HPETState::post_load)
+        .fields(vmstate_fields! {
+            vmstate_of!(HPETState, config),
+            vmstate_of!(HPETState, int_status),
+            vmstate_of!(HPETState, counter),
+            vmstate_of!(HPETState, num_timers_save),
+            vmstate_validate!(HPETState, VALIDATE_TIMERS_NAME, HPETState::validate_num_timers),
+            vmstate_struct!(HPETState, timers[0 .. num_timers_save], &VMSTATE_HPET_TIMER, BqlRefCell<HPETTimer>, HPETState::validate_num_timers).with_version_id(0),
+        })
+        .subsections(vmstate_subsections!(
+            VMSTATE_HPET_RTC_IRQ_LEVEL,
+            VMSTATE_HPET_OFFSET,
+        ))
+        .build();
 
 // SAFETY: HPET_PROPERTIES is a valid Property array constructed with the
 // qemu_api::declare_properties macro.
@@ -1040,8 +1012,8 @@ fn properties() -> &'static [Property] {
 }
 
 impl DeviceImpl for HPETState {
-    fn vmsd() -> Option<&'static VMStateDescription> {
-        Some(&VMSTATE_HPET)
+    fn vmsd() -> Option<VMStateDescription<Self>> {
+        Some(VMSTATE_HPET)
     }
 
     const REALIZE: Option<fn(&Self) -> qemu_api::Result<()>> = Some(Self::realize);
diff --git a/rust/qemu-api/src/errno.rs b/rust/qemu-api/src/errno.rs
index 18d101448b9..507850fe33c 100644
--- a/rust/qemu-api/src/errno.rs
+++ b/rust/qemu-api/src/errno.rs
@@ -7,7 +7,10 @@
 //! convention.  This module provides functions to portably convert an integer
 //! into an [`io::Result`] and back.
 
-use std::{convert::TryFrom, io, io::ErrorKind};
+use std::{
+    convert::{self, TryFrom},
+    io::{self, ErrorKind},
+};
 
 /// An `errno` value that can be converted into an [`io::Error`]
 pub struct Errno(pub u16);
@@ -99,6 +102,12 @@ fn from(value: io::Error) -> Errno {
     }
 }
 
+impl From<convert::Infallible> for Errno {
+    fn from(_value: convert::Infallible) -> Errno {
+        panic!("unreachable")
+    }
+}
+
 /// Internal traits; used to enable [`into_io_result`] and [`into_neg_errno`]
 /// for the "right" set of types.
 mod traits {
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 6a58a00e3fc..4dda8c81131 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -173,7 +173,7 @@ pub trait DeviceImpl:
     /// A `VMStateDescription` providing the migration format for the device
     /// Not a `const` because referencing statics in constants is unstable
     /// until Rust 1.83.0.
-    fn vmsd() -> Option<&'static VMStateDescription> {
+    fn vmsd() -> Option<VMStateDescription<Self>> {
         None
     }
 }
@@ -225,7 +225,9 @@ pub fn class_init<T: DeviceImpl>(&mut self) {
             self.realize = Some(rust_realize_fn::<T>);
         }
         if let Some(vmsd) = <T as DeviceImpl>::vmsd() {
-            self.vmsd = vmsd;
+            // Give a 'static lifetime to the return value of vmsd().
+            // Temporary until vmsd() can be changed into a const.
+            self.vmsd = Box::leak(Box::new(vmsd.get()));
         }
         let prop = <T as DevicePropertiesImpl>::properties();
         if !prop.is_empty() {
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 8515e382135..f5f1ea5590f 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -24,12 +24,24 @@
 //!   `include/migration/vmstate.h`. These are not type-safe and only provide
 //!   functionality that is missing from `vmstate_of!`.
 
-use core::{marker::PhantomData, mem, ptr::NonNull};
-use std::ffi::{c_int, c_void};
+pub use std::convert::Infallible;
+use std::{
+    error::Error,
+    ffi::{c_int, c_void, CStr},
+    fmt, io,
+    marker::PhantomData,
+    mem,
+    ptr::NonNull,
+};
 
-pub use crate::bindings::{VMStateDescription, VMStateField};
+pub use crate::bindings::{MigrationPriority, VMStateField};
 use crate::{
-    bindings::VMStateFlags, callbacks::FnCall, prelude::*, qom::Owned, zeroable::Zeroable,
+    bindings::{self, VMStateFlags},
+    callbacks::FnCall,
+    errno::{into_neg_errno, Errno},
+    prelude::*,
+    qom::Owned,
+    zeroable::Zeroable,
 };
 
 /// This macro is used to call a function with a generic argument bound
@@ -440,7 +452,7 @@ pub extern "C" fn rust_vms_test_field_exists<T, F: for<'a> FnCall<(&'a T, u8), b
     opaque: *mut c_void,
     version_id: c_int,
 ) -> bool {
-    // SAFETY: the opaque was passed as a reference to `T`.
+    // SAFETY: assumes vmstate_struct! is used correctly
     let owner: &T = unsafe { &*(opaque.cast::<T>()) };
     let version: u8 = version_id.try_into().unwrap();
     F::call((owner, version))
@@ -490,7 +502,7 @@ macro_rules! vmstate_struct {
             },
             size: ::core::mem::size_of::<$type>(),
             flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
-            vmsd: $vmsd,
+            vmsd: $vmsd.as_ref(),
             $(field_exists: $crate::vmstate_exist_fn!($struct_name, $test_fn),)?
             ..$crate::zeroable::Zeroable::ZERO
          } $(.with_varray_flag_unchecked(
@@ -594,11 +606,225 @@ macro_rules! vmstate_subsections {
     ($($subsection:expr),*$(,)*) => {{
         static _SUBSECTIONS: $crate::vmstate::VMStateSubsectionsWrapper = $crate::vmstate::VMStateSubsectionsWrapper(&[
             $({
-                static _SUBSECTION: $crate::bindings::VMStateDescription = $subsection;
+                static _SUBSECTION: $crate::bindings::VMStateDescription = $subsection.get();
                 ::core::ptr::addr_of!(_SUBSECTION)
             }),*,
             ::core::ptr::null()
         ]);
-        _SUBSECTIONS.0.as_ptr()
+        &_SUBSECTIONS
     }}
 }
+
+pub struct VMStateDescription<T>(bindings::VMStateDescription, PhantomData<fn(&T)>);
+
+// SAFETY: When a *const T is passed to the callbacks, the call itself
+// is done in a thread-safe manner.  The invocation is okay as long as
+// T itself is `Sync`.
+unsafe impl<T: Sync> Sync for VMStateDescription<T> {}
+
+#[derive(Clone)]
+pub struct VMStateDescriptionBuilder<T>(bindings::VMStateDescription, PhantomData<fn(&T)>);
+
+#[derive(Debug)]
+pub struct InvalidError;
+
+impl Error for InvalidError {}
+
+impl std::fmt::Display for InvalidError {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        write!(f, "invalid migration data")
+    }
+}
+
+impl From<InvalidError> for Errno {
+    fn from(_value: InvalidError) -> Errno {
+        io::ErrorKind::InvalidInput.into()
+    }
+}
+
+unsafe extern "C" fn vmstate_no_version_cb<
+    T,
+    F: for<'a> FnCall<(&'a T,), Result<(), impl Into<Errno>>>,
+>(
+    opaque: *mut c_void,
+) -> c_int {
+    // SAFETY: assumes vmstate_struct! is used correctly
+    let result = F::call((unsafe { &*(opaque.cast::<T>()) },));
+    into_neg_errno(result)
+}
+
+unsafe extern "C" fn vmstate_post_load_cb<
+    T,
+    F: for<'a> FnCall<(&'a T, u8), Result<(), impl Into<Errno>>>,
+>(
+    opaque: *mut c_void,
+    version_id: c_int,
+) -> c_int {
+    // SAFETY: assumes vmstate_struct! is used correctly
+    let owner: &T = unsafe { &*(opaque.cast::<T>()) };
+    let version: u8 = version_id.try_into().unwrap();
+    let result = F::call((owner, version));
+    into_neg_errno(result)
+}
+
+unsafe extern "C" fn vmstate_needed_cb<T, F: for<'a> FnCall<(&'a T,), bool>>(
+    opaque: *mut c_void,
+) -> bool {
+    // SAFETY: assumes vmstate_struct! is used correctly
+    F::call((unsafe { &*(opaque.cast::<T>()) },))
+}
+
+unsafe extern "C" fn vmstate_dev_unplug_pending_cb<T, F: for<'a> FnCall<(&'a T,), bool>>(
+    opaque: *mut c_void,
+) -> bool {
+    // SAFETY: assumes vmstate_struct! is used correctly
+    F::call((unsafe { &*(opaque.cast::<T>()) },))
+}
+
+impl<T> VMStateDescriptionBuilder<T> {
+    #[must_use]
+    pub const fn name(mut self, name_str: &CStr) -> Self {
+        self.0.name = ::std::ffi::CStr::as_ptr(name_str);
+        self
+    }
+
+    #[must_use]
+    pub const fn unmigratable(mut self) -> Self {
+        self.0.unmigratable = true;
+        self
+    }
+
+    #[must_use]
+    pub const fn early_setup(mut self) -> Self {
+        self.0.early_setup = true;
+        self
+    }
+
+    #[must_use]
+    pub const fn version_id(mut self, version: u8) -> Self {
+        self.0.version_id = version as c_int;
+        self
+    }
+
+    #[must_use]
+    pub const fn minimum_version_id(mut self, min_version: u8) -> Self {
+        self.0.minimum_version_id = min_version as c_int;
+        self
+    }
+
+    #[must_use]
+    pub const fn priority(mut self, priority: MigrationPriority) -> Self {
+        self.0.priority = priority;
+        self
+    }
+
+    #[must_use]
+    pub const fn pre_load<F: for<'a> FnCall<(&'a T,), Result<(), impl Into<Errno>>>>(
+        mut self,
+        _f: &F,
+    ) -> Self {
+        self.0.pre_load = if F::IS_SOME {
+            Some(vmstate_no_version_cb::<T, F>)
+        } else {
+            None
+        };
+        self
+    }
+
+    #[must_use]
+    pub const fn post_load<F: for<'a> FnCall<(&'a T, u8), Result<(), impl Into<Errno>>>>(
+        mut self,
+        _f: &F,
+    ) -> Self {
+        self.0.post_load = if F::IS_SOME {
+            Some(vmstate_post_load_cb::<T, F>)
+        } else {
+            None
+        };
+        self
+    }
+
+    #[must_use]
+    pub const fn pre_save<F: for<'a> FnCall<(&'a T,), Result<(), impl Into<Errno>>>>(
+        mut self,
+        _f: &F,
+    ) -> Self {
+        self.0.pre_save = if F::IS_SOME {
+            Some(vmstate_no_version_cb::<T, F>)
+        } else {
+            None
+        };
+        self
+    }
+
+    #[must_use]
+    pub const fn post_save<F: for<'a> FnCall<(&'a T,), Result<(), impl Into<Errno>>>>(
+        mut self,
+        _f: &F,
+    ) -> Self {
+        self.0.post_save = if F::IS_SOME {
+            Some(vmstate_no_version_cb::<T, F>)
+        } else {
+            None
+        };
+        self
+    }
+
+    #[must_use]
+    pub const fn needed<F: for<'a> FnCall<(&'a T,), bool>>(mut self, _f: &F) -> Self {
+        self.0.needed = if F::IS_SOME {
+            Some(vmstate_needed_cb::<T, F>)
+        } else {
+            None
+        };
+        self
+    }
+
+    #[must_use]
+    pub const fn unplug_pending<F: for<'a> FnCall<(&'a T,), bool>>(mut self, _f: &F) -> Self {
+        self.0.dev_unplug_pending = if F::IS_SOME {
+            Some(vmstate_dev_unplug_pending_cb::<T, F>)
+        } else {
+            None
+        };
+        self
+    }
+
+    #[must_use]
+    pub const fn fields(mut self, fields: *const VMStateField) -> Self {
+        self.0.fields = fields;
+        self
+    }
+
+    #[must_use]
+    pub const fn subsections(mut self, subs: &'static VMStateSubsectionsWrapper) -> Self {
+        self.0.subsections = subs.0.as_ptr();
+        self
+    }
+
+    #[must_use]
+    pub const fn build(self) -> VMStateDescription<T> {
+        VMStateDescription::<T>(self.0, PhantomData)
+    }
+
+    #[must_use]
+    pub const fn new() -> Self {
+        Self(bindings::VMStateDescription::ZERO, PhantomData)
+    }
+}
+
+impl<T> Default for VMStateDescriptionBuilder<T> {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl<T> VMStateDescription<T> {
+    pub const fn get(&self) -> bindings::VMStateDescription {
+        self.0
+    }
+
+    pub const fn as_ref(&self) -> &bindings::VMStateDescription {
+        &self.0
+    }
+}
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index aff3eecd654..4d4e4653f38 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -11,18 +11,16 @@
     qdev::{DeviceImpl, DeviceState, ResettablePhasesImpl},
     qom::{ObjectImpl, ParentField},
     sysbus::SysBusDevice,
-    vmstate::VMStateDescription,
-    zeroable::Zeroable,
+    vmstate::{VMStateDescription, VMStateDescriptionBuilder},
 };
 
 mod vmstate_tests;
 
 // Test that macros can compile.
-pub static VMSTATE: VMStateDescription = VMStateDescription {
-    name: c"name".as_ptr(),
-    unmigratable: true,
-    ..Zeroable::ZERO
-};
+pub const VMSTATE: VMStateDescription<DummyState> = VMStateDescriptionBuilder::<DummyState>::new()
+    .name(c"name")
+    .unmigratable()
+    .build();
 
 #[repr(C)]
 #[derive(qemu_api_macros::Object, qemu_api_macros::Device)]
@@ -58,8 +56,8 @@ impl ObjectImpl for DummyState {
 impl ResettablePhasesImpl for DummyState {}
 
 impl DeviceImpl for DummyState {
-    fn vmsd() -> Option<&'static VMStateDescription> {
-        Some(&VMSTATE)
+    fn vmsd() -> Option<VMStateDescription<Self>> {
+        Some(VMSTATE)
     }
 }
 
diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index bded836eb60..8ffc2779d46 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -16,9 +16,8 @@
     },
     cell::{BqlCell, Opaque},
     impl_vmstate_forward,
-    vmstate::{VMStateDescription, VMStateField},
+    vmstate::{VMStateDescription, VMStateDescriptionBuilder, VMStateField},
     vmstate_fields, vmstate_of, vmstate_struct, vmstate_unused, vmstate_validate,
-    zeroable::Zeroable,
 };
 
 const FOO_ARRAY_MAX: usize = 3;
@@ -41,22 +40,22 @@ struct FooA {
     elem: i8,
 }
 
-static VMSTATE_FOOA: VMStateDescription = VMStateDescription {
-    name: c"foo_a".as_ptr(),
-    version_id: 1,
-    minimum_version_id: 1,
-    fields: vmstate_fields! {
+static VMSTATE_FOOA: VMStateDescription<FooA> = VMStateDescriptionBuilder::<FooA>::new()
+    .name(c"foo_a")
+    .version_id(1)
+    .minimum_version_id(1)
+    .fields(vmstate_fields! {
         vmstate_of!(FooA, elem),
         vmstate_unused!(size_of::<i64>()),
         vmstate_of!(FooA, arr[0 .. num]).with_version_id(0),
         vmstate_of!(FooA, arr_mul[0 .. num_mul * 16]),
-    },
-    ..Zeroable::ZERO
-};
+    })
+    .build();
 
 #[test]
 fn test_vmstate_uint16() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOA.fields, 5) };
+    let foo_fields: &[VMStateField] =
+        unsafe { slice::from_raw_parts(VMSTATE_FOOA.as_ref().fields, 5) };
 
     // 1st VMStateField ("elem") in VMSTATE_FOOA (corresponding to VMSTATE_UINT16)
     assert_eq!(
@@ -76,7 +75,8 @@ fn test_vmstate_uint16() {
 
 #[test]
 fn test_vmstate_unused() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOA.fields, 5) };
+    let foo_fields: &[VMStateField] =
+        unsafe { slice::from_raw_parts(VMSTATE_FOOA.as_ref().fields, 5) };
 
     // 2nd VMStateField ("unused") in VMSTATE_FOOA (corresponding to VMSTATE_UNUSED)
     assert_eq!(
@@ -96,7 +96,8 @@ fn test_vmstate_unused() {
 
 #[test]
 fn test_vmstate_varray_uint16_unsafe() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOA.fields, 5) };
+    let foo_fields: &[VMStateField] =
+        unsafe { slice::from_raw_parts(VMSTATE_FOOA.as_ref().fields, 5) };
 
     // 3rd VMStateField ("arr") in VMSTATE_FOOA (corresponding to
     // VMSTATE_VARRAY_UINT16_UNSAFE)
@@ -117,7 +118,8 @@ fn test_vmstate_varray_uint16_unsafe() {
 
 #[test]
 fn test_vmstate_varray_multiply() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOA.fields, 5) };
+    let foo_fields: &[VMStateField] =
+        unsafe { slice::from_raw_parts(VMSTATE_FOOA.as_ref().fields, 5) };
 
     // 4th VMStateField ("arr_mul") in VMSTATE_FOOA (corresponding to
     // VMSTATE_VARRAY_MULTIPLY)
@@ -171,24 +173,25 @@ fn validate_foob(_state: &FooB, _version_id: u8) -> bool {
     true
 }
 
-static VMSTATE_FOOB: VMStateDescription = VMStateDescription {
-    name: c"foo_b".as_ptr(),
-    version_id: 2,
-    minimum_version_id: 1,
-    fields: vmstate_fields! {
-        vmstate_of!(FooB, val).with_version_id(2),
-        vmstate_of!(FooB, wrap),
-        vmstate_struct!(FooB, arr_a[0 .. num_a], &VMSTATE_FOOA, FooA).with_version_id(1),
-        vmstate_struct!(FooB, arr_a_mul[0 .. num_a_mul * 32], &VMSTATE_FOOA, FooA).with_version_id(2),
-        vmstate_of!(FooB, arr_i64),
-        vmstate_struct!(FooB, arr_a_wrap[0 .. num_a_wrap], &VMSTATE_FOOA, FooA, validate_foob),
-    },
-    ..Zeroable::ZERO
-};
+static VMSTATE_FOOB: VMStateDescription<FooB> =
+    VMStateDescriptionBuilder::<FooB>::new()
+        .name(c"foo_b")
+        .version_id(2)
+        .minimum_version_id(1)
+        .fields(vmstate_fields! {
+            vmstate_of!(FooB, val).with_version_id(2),
+            vmstate_of!(FooB, wrap),
+            vmstate_struct!(FooB, arr_a[0 .. num_a], &VMSTATE_FOOA, FooA).with_version_id(1),
+            vmstate_struct!(FooB, arr_a_mul[0 .. num_a_mul * 32], &VMSTATE_FOOA, FooA).with_version_id(2),
+            vmstate_of!(FooB, arr_i64),
+            vmstate_struct!(FooB, arr_a_wrap[0 .. num_a_wrap], &VMSTATE_FOOA, FooA, validate_foob),
+        })
+        .build();
 
 #[test]
 fn test_vmstate_bool_v() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 7) };
+    let foo_fields: &[VMStateField] =
+        unsafe { slice::from_raw_parts(VMSTATE_FOOB.as_ref().fields, 7) };
 
     // 1st VMStateField ("val") in VMSTATE_FOOB (corresponding to VMSTATE_BOOL_V)
     assert_eq!(
@@ -208,7 +211,8 @@ fn test_vmstate_bool_v() {
 
 #[test]
 fn test_vmstate_uint64() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 7) };
+    let foo_fields: &[VMStateField] =
+        unsafe { slice::from_raw_parts(VMSTATE_FOOB.as_ref().fields, 7) };
 
     // 2nd VMStateField ("wrap") in VMSTATE_FOOB (corresponding to VMSTATE_U64)
     assert_eq!(
@@ -228,7 +232,8 @@ fn test_vmstate_uint64() {
 
 #[test]
 fn test_vmstate_struct_varray_uint8() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 7) };
+    let foo_fields: &[VMStateField] =
+        unsafe { slice::from_raw_parts(VMSTATE_FOOB.as_ref().fields, 7) };
 
     // 3rd VMStateField ("arr_a") in VMSTATE_FOOB (corresponding to
     // VMSTATE_STRUCT_VARRAY_UINT8)
@@ -246,13 +251,14 @@ fn test_vmstate_struct_varray_uint8() {
         foo_fields[2].flags.0,
         VMStateFlags::VMS_STRUCT.0 | VMStateFlags::VMS_VARRAY_UINT8.0
     );
-    assert_eq!(foo_fields[2].vmsd, &VMSTATE_FOOA);
+    assert_eq!(foo_fields[2].vmsd, VMSTATE_FOOA.as_ref());
     assert!(foo_fields[2].field_exists.is_none());
 }
 
 #[test]
 fn test_vmstate_struct_varray_uint32_multiply() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 7) };
+    let foo_fields: &[VMStateField] =
+        unsafe { slice::from_raw_parts(VMSTATE_FOOB.as_ref().fields, 7) };
 
     // 4th VMStateField ("arr_a_mul") in VMSTATE_FOOB (corresponding to
     // (no C version) MULTIPLY variant of VMSTATE_STRUCT_VARRAY_UINT32)
@@ -272,13 +278,14 @@ fn test_vmstate_struct_varray_uint32_multiply() {
             | VMStateFlags::VMS_VARRAY_UINT32.0
             | VMStateFlags::VMS_MULTIPLY_ELEMENTS.0
     );
-    assert_eq!(foo_fields[3].vmsd, &VMSTATE_FOOA);
+    assert_eq!(foo_fields[3].vmsd, VMSTATE_FOOA.as_ref());
     assert!(foo_fields[3].field_exists.is_none());
 }
 
 #[test]
 fn test_vmstate_macro_array() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 7) };
+    let foo_fields: &[VMStateField] =
+        unsafe { slice::from_raw_parts(VMSTATE_FOOB.as_ref().fields, 7) };
 
     // 5th VMStateField ("arr_i64") in VMSTATE_FOOB (corresponding to
     // VMSTATE_ARRAY)
@@ -299,7 +306,8 @@ fn test_vmstate_macro_array() {
 
 #[test]
 fn test_vmstate_struct_varray_uint8_wrapper() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 7) };
+    let foo_fields: &[VMStateField] =
+        unsafe { slice::from_raw_parts(VMSTATE_FOOB.as_ref().fields, 7) };
     let mut foo_b: FooB = Default::default();
     let foo_b_p = std::ptr::addr_of_mut!(foo_b).cast::<c_void>();
 
@@ -335,26 +343,28 @@ struct FooC {
     arr_ptr_wrap: FooCWrapper,
 }
 
-static VMSTATE_FOOC: VMStateDescription = VMStateDescription {
-    name: c"foo_c".as_ptr(),
-    version_id: 3,
-    minimum_version_id: 1,
-    fields: vmstate_fields! {
+unsafe impl Sync for FooC {}
+
+static VMSTATE_FOOC: VMStateDescription<FooC> = VMStateDescriptionBuilder::<FooC>::new()
+    .name(c"foo_c")
+    .version_id(3)
+    .minimum_version_id(1)
+    .fields(vmstate_fields! {
         vmstate_of!(FooC, ptr).with_version_id(2),
         // FIXME: Currently vmstate_struct doesn't support the pointer to structure.
         // VMSTATE_STRUCT_POINTER: vmstate_struct!(FooC, ptr_a, VMSTATE_FOOA, NonNull<FooA>)
         vmstate_unused!(size_of::<NonNull<FooA>>()),
         vmstate_of!(FooC, arr_ptr),
         vmstate_of!(FooC, arr_ptr_wrap),
-    },
-    ..Zeroable::ZERO
-};
+    })
+    .build();
 
 const PTR_SIZE: usize = size_of::<*mut ()>();
 
 #[test]
 fn test_vmstate_pointer() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOC.fields, 6) };
+    let foo_fields: &[VMStateField] =
+        unsafe { slice::from_raw_parts(VMSTATE_FOOC.as_ref().fields, 6) };
 
     // 1st VMStateField ("ptr") in VMSTATE_FOOC (corresponding to VMSTATE_POINTER)
     assert_eq!(
@@ -377,7 +387,8 @@ fn test_vmstate_pointer() {
 
 #[test]
 fn test_vmstate_macro_array_of_pointer() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOC.fields, 6) };
+    let foo_fields: &[VMStateField] =
+        unsafe { slice::from_raw_parts(VMSTATE_FOOC.as_ref().fields, 6) };
 
     // 3rd VMStateField ("arr_ptr") in VMSTATE_FOOC (corresponding to
     // VMSTATE_ARRAY_OF_POINTER)
@@ -401,7 +412,8 @@ fn test_vmstate_macro_array_of_pointer() {
 
 #[test]
 fn test_vmstate_macro_array_of_pointer_wrapped() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOC.fields, 6) };
+    let foo_fields: &[VMStateField] =
+        unsafe { slice::from_raw_parts(VMSTATE_FOOC.as_ref().fields, 6) };
 
     // 4th VMStateField ("arr_ptr_wrap") in VMSTATE_FOOC (corresponding to
     // VMSTATE_ARRAY_OF_POINTER)
@@ -450,21 +462,21 @@ fn validate_food_2(_state: &FooD, _version_id: u8) -> bool {
     true
 }
 
-static VMSTATE_FOOD: VMStateDescription = VMStateDescription {
-    name: c"foo_d".as_ptr(),
-    version_id: 3,
-    minimum_version_id: 1,
-    fields: vmstate_fields! {
+static VMSTATE_FOOD: VMStateDescription<FooD> = VMStateDescriptionBuilder::<FooD>::new()
+    .name(c"foo_d")
+    .version_id(3)
+    .minimum_version_id(1)
+    .fields(vmstate_fields! {
         vmstate_validate!(FooD, c"foo_d_0", FooD::validate_food_0),
         vmstate_validate!(FooD, c"foo_d_1", FooD::validate_food_1),
         vmstate_validate!(FooD, c"foo_d_2", validate_food_2),
-    },
-    ..Zeroable::ZERO
-};
+    })
+    .build();
 
 #[test]
 fn test_vmstate_validate() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOD.fields, 4) };
+    let foo_fields: &[VMStateField] =
+        unsafe { slice::from_raw_parts(VMSTATE_FOOD.as_ref().fields, 4) };
     let mut foo_d = FooD;
     let foo_d_p = std::ptr::addr_of_mut!(foo_d).cast::<c_void>();
 
-- 
2.51.0


