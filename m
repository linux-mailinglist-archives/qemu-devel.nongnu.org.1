Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18803A1C330
	for <lists+qemu-devel@lfdr.de>; Sat, 25 Jan 2025 13:33:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbfLJ-0008Js-Lq; Sat, 25 Jan 2025 07:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tbfLH-0008Ih-Ci; Sat, 25 Jan 2025 07:32:51 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tbfLE-0005Un-Gu; Sat, 25 Jan 2025 07:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737808368; x=1769344368;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fqfSLQpyG5tZ78FAZYRkF+oxY5k+vZ+Sgwe8jmgI7p4=;
 b=cw6K4/PWn4lzsfMkXDLdM+3GOUqabS2p/L+t+npO3oMsCdeb35PT01T9
 LHdh2QAKkxtu2far8+yuHQDKfZ/eg5tCHhFIf5D1bXVNFPUcfsly5dt44
 l/rzYTDfeAeLkhBzhnFqsALXvrb/ah8k5esKwjrKevXgqS7LFXbi48HXg
 Jd8X4GZciLfC++Ivre0ZFfRuddvEnGpcS/Jx+v44CxD8vL1T1RTv30jli
 bn1lICKJXI72do5fk5MDD/hsKf1MlEOiC9I8FnHUC1e6ZjpfofliWnQdF
 wlZL6+OZknYo52jO8PuyPRBrXRWv8Ey7u6z6MWxkv6RfJ+wJFQ3Wzosoz g==;
X-CSE-ConnectionGUID: lLLSd/0WScCej9tnqJJjPw==
X-CSE-MsgGUID: KRhJziZrQTyM+wdYHHtkAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38434730"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="38434730"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2025 04:32:47 -0800
X-CSE-ConnectionGUID: x4Hlx754QeWhVCOblbiTpQ==
X-CSE-MsgGUID: R8j0cuhMS9Wv/d+2eRTDKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,234,1732608000"; d="scan'208";a="107897756"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 25 Jan 2025 04:32:44 -0800
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
Subject: [PATCH 08/10] rust/timer/hpet: add basic HPET timer and HPETState
Date: Sat, 25 Jan 2025 20:51:35 +0800
Message-Id: <20250125125137.1223277-9-zhao1.liu@intel.com>
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

Add the HPETTimer and HPETState (HPET timer block), along with their
basic methods and register definitions.

This is in preparation for supporting the QAPI interfaces.

Note, wrap all items in HPETState that may be changed in the callback
called by C code into the BqlCell/BqlRefCell.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since RFC:
 * Don't wrap HPETState.flags in a BqlCell.
 * Consolidate inmutable &self and QOM casting.
 * Prefer timer iterator over loop.
 * Use BqlRefCell<HPETTimer> directly to store timers in HPETState.
---
 rust/hw/timer/hpet/src/hpet.rs | 633 +++++++++++++++++++++++++++++++++
 rust/hw/timer/hpet/src/lib.rs  |   1 +
 rust/wrapper.h                 |   1 +
 3 files changed, 635 insertions(+)
 create mode 100644 rust/hw/timer/hpet/src/hpet.rs

diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
new file mode 100644
index 000000000000..0884a2ac73c4
--- /dev/null
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -0,0 +1,633 @@
+// Copyright (C) 2024 Intel Corporation.
+// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#![allow(dead_code)]
+
+use core::ptr::{null_mut, NonNull};
+
+use qemu_api::{
+    bindings::{address_space_memory, address_space_stl_le, MemoryRegion, SCALE_NS},
+    cell::{BqlCell, BqlRefCell},
+    irq::InterruptSource,
+    memory::MEMTXATTRS_UNSPECIFIED,
+    prelude::*,
+    qom::ParentField,
+    sysbus::SysBusDevice,
+    timer::{QEMUTimer, CLOCK_VIRTUAL},
+};
+
+// Register space for each timer block. (HPET_BASE isn't defined here.)
+const HPET_REG_SPACE_LEN: u64 = 0x400; // 1024 bytes
+
+const HPET_MIN_TIMERS: usize = 3; // Minimum recommended hardware implementation.
+const HPET_MAX_TIMERS: usize = 32; // Maximum timers in each timer block.
+
+// Flags that HPETState.flags supports.
+const HPET_FLAG_MSI_SUPPORT_SHIFT: usize = 0;
+
+const HPET_NUM_IRQ_ROUTES: usize = 32;
+const HPET_LEGACY_PIT_INT: u32 = 0; // HPET_LEGACY_RTC_INT isn't defined here.
+const RTC_ISA_IRQ: usize = 8;
+
+const HPET_CLK_PERIOD: u64 = 10; // 10 ns
+const FS_PER_NS: u64 = 1000000; // 1000000 femtoseconds == 1 ns
+
+// General Capabilities and ID Register
+const HPET_CAP_REG: u64 = 0x000;
+// Revision ID (bits 0:7)
+const HPET_CAP_REV_ID_VALUE: u64 = 0x1; // Revision 1 is implemented (refer to v1.0a spec).
+const HPET_CAP_REV_ID_SHIFT: usize = 0;
+// Number of Timers (bits 8:12)
+const HPET_CAP_NUM_TIM_SHIFT: usize = 8;
+// Counter Size (bit 13)
+const HPET_CAP_COUNT_SIZE_CAP_SHIFT: usize = 13;
+// LegacyReplacement Route Capable (bit 15)
+const HPET_CAP_LEG_RT_CAP_SHIFT: usize = 15;
+// Vendor ID (bits 16:31)
+const HPET_CAP_VENDER_ID_VALUE: u64 = 0x8086;
+const HPET_CAP_VENDER_ID_SHIFT: usize = 16;
+// Main Counter Tick Period (bits 32:63)
+const HPET_CAP_CNT_CLK_PERIOD_SHIFT: usize = 32;
+
+// General Configuration Register
+const HPET_CFG_REG: u64 = 0x010;
+// Overall Enable (bit 0)
+const HPET_CFG_ENABLE_SHIFT: usize = 0;
+// LegacyReplacement Route (bit 1)
+const HPET_CFG_LEG_RT_SHIFT: usize = 1;
+// Other bits are reserved.
+const HPET_CFG_WRITE_MASK: u64 = 0x003;
+
+// General Interrupt Status Register
+const HPET_INT_STATUS_REG: u64 = 0x020;
+
+// Main Counter Value Register
+const HPET_COUNTER_REG: u64 = 0x0f0;
+
+// Timer N Configuration and Capability Register (masked by 0x18)
+const HPET_TN_CFG_REG: u64 = 0x000;
+// bit 0, 7, and bits 16:31 are reserved.
+// bit 4, 5, 15, and bits 32:64 are read-only.
+const HPET_TN_CFG_WRITE_MASK: u64 = 0x7f4e;
+// Timer N Interrupt Type (bit 1)
+const HPET_TN_CFG_INT_TYPE_SHIFT: usize = 1;
+// Timer N Interrupt Enable (bit 2)
+const HPET_TN_CFG_INT_ENABLE_SHIFT: usize = 2;
+// Timer N Type (Periodic enabled or not, bit 3)
+const HPET_TN_CFG_PERIODIC_SHIFT: usize = 3;
+// Timer N Periodic Interrupt Capable (support Periodic or not, bit 4)
+const HPET_TN_CFG_PERIODIC_CAP_SHIFT: usize = 4;
+// Timer N Size (timer size is 64-bits or 32 bits, bit 5)
+const HPET_TN_CFG_SIZE_CAP_SHIFT: usize = 5;
+// Timer N Value Set (bit 6)
+const HPET_TN_CFG_SETVAL_SHIFT: usize = 6;
+// Timer N 32-bit Mode (bit 8)
+const HPET_TN_CFG_32BIT_SHIFT: usize = 8;
+// Timer N Interrupt Rout (bits 9:13)
+const HPET_TN_CFG_INT_ROUTE_MASK: u64 = 0x3e00;
+const HPET_TN_CFG_INT_ROUTE_SHIFT: usize = 9;
+// Timer N FSB Interrupt Enable (bit 14)
+const HPET_TN_CFG_FSB_ENABLE_SHIFT: usize = 14;
+// Timer N FSB Interrupt Delivery (bit 15)
+const HPET_TN_CFG_FSB_CAP_SHIFT: usize = 15;
+// Timer N Interrupt Routing Capability (bits 32:63)
+const HPET_TN_CFG_INT_ROUTE_CAP_SHIFT: usize = 32;
+
+// Timer N Comparator Value Register (masked by 0x18)
+const HPET_TN_CMP_REG: u64 = 0x008;
+
+// Timer N FSB Interrupt Route Register (masked by 0x18)
+const HPET_TN_FSB_ROUTE_REG: u64 = 0x010;
+
+fn hpet_next_wrap(cur_tick: u64) -> u64 {
+    (cur_tick | 0xffffffff) + 1
+}
+
+fn hpet_time_after(a: u64, b: u64) -> bool {
+    ((b - a) as i64) < 0
+}
+
+fn ticks_to_ns(value: u64) -> u64 {
+    value * HPET_CLK_PERIOD
+}
+
+fn ns_to_ticks(value: u64) -> u64 {
+    value / HPET_CLK_PERIOD
+}
+
+// Avoid touching the bits that cannot be written.
+fn hpet_fixup_reg(new: u64, old: u64, mask: u64) -> u64 {
+    (new & mask) | (old & !mask)
+}
+
+fn activating_bit(old: u64, new: u64, shift: usize) -> bool {
+    let mask: u64 = 1 << shift;
+    (old & mask == 0) && (new & mask != 0)
+}
+
+fn deactivating_bit(old: u64, new: u64, shift: usize) -> bool {
+    let mask: u64 = 1 << shift;
+    (old & mask != 0) && (new & mask == 0)
+}
+
+fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
+    timer_cell.borrow_mut().callback()
+}
+
+/// HPET Timer Abstraction
+#[repr(C)]
+#[derive(Debug, Default, qemu_api_macros::offsets)]
+pub struct HPETTimer {
+    /// timer N index within the timer block (HPETState)
+    #[doc(alias = "tn")]
+    index: usize,
+    qemu_timer: Option<Box<QEMUTimer>>,
+    /// timer block abstraction containing this timer
+    state: Option<NonNull<HPETState>>,
+
+    /// Memory-mapped, software visible timer registers
+
+    /// Timer N Configuration and Capability Register
+    config: u64,
+    /// Timer N Comparator Value Register
+    cmp: u64,
+    /// Timer N FSB Interrupt Route Register
+    fsb: u64,
+
+    /// Hidden register state
+
+    /// comparator (extended to counter width)
+    cmp64: u64,
+    /// Last value written to comparator
+    period: u64,
+    /// timer pop will indicate wrap for one-shot 32-bit
+    /// mode. Next pop will be actual timer expiration.
+    wrap_flag: u8,
+    /// last value armed, to avoid timer storms
+    last: u64,
+}
+
+impl HPETTimer {
+    fn init(&mut self, index: usize, state_ptr: *mut HPETState) -> &mut Self {
+        *self = HPETTimer::default();
+        self.index = index;
+        self.state = NonNull::new(state_ptr);
+        self
+    }
+
+    fn init_timer_with_state(&mut self) {
+        self.qemu_timer = Some(Box::new({
+            let mut t = QEMUTimer::new();
+            t.timer_init_full(
+                None,
+                CLOCK_VIRTUAL.id,
+                SCALE_NS,
+                0,
+                timer_handler,
+                &self.get_state().timers[self.index],
+            );
+            t
+        }));
+    }
+
+    fn get_state(&self) -> &HPETState {
+        // SAFETY:
+        // the pointer is convertible to a reference
+        unsafe { self.state.unwrap().as_ref() }
+    }
+
+    fn is_int_active(&self) -> bool {
+        self.get_state().is_timer_int_active(self.index)
+    }
+
+    fn is_fsb_route_enabled(&self) -> bool {
+        self.config & 1 << HPET_TN_CFG_FSB_ENABLE_SHIFT != 0
+    }
+
+    fn is_periodic(&self) -> bool {
+        self.config & 1 << HPET_TN_CFG_PERIODIC_SHIFT != 0
+    }
+
+    fn is_int_enabled(&self) -> bool {
+        self.config & 1 << HPET_TN_CFG_INT_ENABLE_SHIFT != 0
+    }
+
+    fn is_32bit_mod(&self) -> bool {
+        self.config & 1 << HPET_TN_CFG_32BIT_SHIFT != 0
+    }
+
+    fn is_valset_enabled(&self) -> bool {
+        self.config & 1 << HPET_TN_CFG_SETVAL_SHIFT != 0
+    }
+
+    fn clear_valset(&mut self) {
+        self.config &= !(1 << HPET_TN_CFG_SETVAL_SHIFT);
+    }
+
+    /// True if timer interrupt is level triggered; otherwise, edge triggered.
+    fn is_int_level_triggered(&self) -> bool {
+        self.config & 1 << HPET_TN_CFG_INT_TYPE_SHIFT != 0
+    }
+
+    /// calculate next value of the general counter that matches the
+    /// target (either entirely, or the low 32-bit only depending on
+    /// the timer mode).
+    fn calculate_cmp64(&self, cur_tick: u64, target: u64) -> u64 {
+        if self.is_32bit_mod() {
+            let mut result: u64 = cur_tick.deposit(0, 32, target);
+            if result < cur_tick {
+                result += 0x100000000;
+            }
+            result
+        } else {
+            target
+        }
+    }
+
+    fn get_individual_route(&self) -> usize {
+        ((self.config & HPET_TN_CFG_INT_ROUTE_MASK) >> HPET_TN_CFG_INT_ROUTE_SHIFT) as usize
+    }
+
+    fn get_int_route(&self) -> usize {
+        if self.index <= 1 && self.get_state().is_legacy_mode() {
+            // If LegacyReplacement Route bit is set, HPET specification requires
+            // timer0 be routed to IRQ0 in NON-APIC or IRQ2 in the I/O APIC,
+            // timer1 be routed to IRQ8 in NON-APIC or IRQ8 in the I/O APIC.
+            //
+            // If the LegacyReplacement Route bit is set, the individual routing
+            // bits for timers 0 and 1 (APIC or FSB) will have no impact.
+            //
+            // FIXME: Consider I/O APIC case.
+            if self.index == 0 {
+                0
+            } else {
+                RTC_ISA_IRQ
+            }
+        } else {
+            // (If the LegacyReplacement Route bit is set) Timer 2-n will be
+            // routed as per the routing in the timer n config registers.
+            // ...
+            // If the LegacyReplacement Route bit is not set, the individual
+            // routing bits for each of the timers are used.
+            self.get_individual_route()
+        }
+    }
+
+    fn set_irq(&mut self, set: bool) {
+        let route = self.get_int_route();
+
+        if set && self.is_int_enabled() && self.get_state().is_hpet_enabled() {
+            if self.is_fsb_route_enabled() {
+                // SAFETY:
+                // the parameters are valid.
+                unsafe {
+                    address_space_stl_le(
+                        &mut address_space_memory,
+                        self.fsb >> 32,  // Timer N FSB int addr
+                        self.fsb as u32, // Timer N FSB int value, truncate!
+                        MEMTXATTRS_UNSPECIFIED,
+                        null_mut(),
+                    );
+                }
+            } else if self.is_int_level_triggered() {
+                self.get_state().irqs[route].raise();
+            } else {
+                self.get_state().irqs[route].pulse();
+            }
+        } else if !self.is_fsb_route_enabled() {
+            self.get_state().irqs[route].lower();
+        }
+    }
+
+    fn update_irq(&mut self, set: bool) {
+        // If Timer N Interrupt Enable bit is 0, "the timer will
+        // still operate and generate appropriate status bits, but
+        // will not cause an interrupt"
+        self.get_state()
+            .update_int_status(self.index as u32, set && self.is_int_level_triggered());
+        self.set_irq(set);
+    }
+
+    fn arm_timer(&mut self, tick: u64) {
+        let mut ns = self.get_state().get_ns(tick);
+
+        // Clamp period to reasonable min value (1 us)
+        if self.is_periodic() && ns - self.last < 1000 {
+            ns = self.last + 1000;
+        }
+
+        self.last = ns;
+        if let Some(timer) = self.qemu_timer.as_mut() {
+            timer.timer_mod(self.last);
+        }
+    }
+
+    fn set_timer(&mut self) {
+        let cur_tick: u64 = self.get_state().get_ticks();
+
+        self.wrap_flag = 0;
+        self.cmp64 = self.calculate_cmp64(cur_tick, self.cmp);
+        if self.is_32bit_mod() {
+            // HPET spec says in one-shot 32-bit mode, generate an interrupt when
+            // counter wraps in addition to an interrupt with comparator match.
+            if !self.is_periodic() && self.cmp64 > hpet_next_wrap(cur_tick) {
+                self.wrap_flag = 1;
+                self.arm_timer(hpet_next_wrap(cur_tick));
+                return;
+            }
+        }
+        self.arm_timer(self.cmp64);
+    }
+
+    fn del_timer(&mut self) {
+        if let Some(timer) = self.qemu_timer.take() {
+            std::mem::drop(timer);
+        }
+
+        if self.is_int_active() {
+            // For level-triggered interrupt, this leaves interrupt status
+            // register set but lowers irq.
+            self.update_irq(true);
+        }
+    }
+
+    // Configuration and Capability Register
+    fn set_tn_cfg_reg(&mut self, shift: u32, len: u32, val: u64) {
+        // TODO: Add trace point - trace_hpet_ram_write_tn_cfg(addr & 4)
+        let old_val: u64 = self.config;
+        let mut new_val: u64 = old_val.deposit(shift, len, val);
+        new_val = hpet_fixup_reg(new_val, old_val, HPET_TN_CFG_WRITE_MASK);
+
+        // Switch level-type interrupt to edge-type.
+        if deactivating_bit(old_val, new_val, HPET_TN_CFG_INT_TYPE_SHIFT) {
+            // Do this before changing timer.config; otherwise, if
+            // HPET_TN_FSB is set, update_irq will not lower the qemu_irq.
+            self.update_irq(false);
+        }
+
+        self.config = new_val;
+
+        if activating_bit(old_val, new_val, HPET_TN_CFG_INT_ENABLE_SHIFT) && self.is_int_active() {
+            self.update_irq(true);
+        }
+
+        if self.is_32bit_mod() {
+            self.cmp = self.cmp as u32 as u64; // truncate!
+            self.period = self.period as u32 as u64; // truncate!
+        }
+
+        if self.get_state().is_hpet_enabled() {
+            self.set_timer();
+        }
+    }
+
+    /// Comparator Value Register
+    fn set_tn_cmp_reg(&mut self, shift: u32, len: u32, val: u64) {
+        let mut length = len;
+        let mut value = val;
+
+        // TODO: Add trace point - trace_hpet_ram_write_tn_cmp(addr & 4)
+        if self.is_32bit_mod() {
+            // High 32-bits are zero, leave them untouched.
+            if shift != 0 {
+                // TODO: Add trace point - trace_hpet_ram_write_invalid_tn_cmp()
+                return;
+            }
+            length = 64;
+            value = value as u32 as u64; // truncate!
+        }
+
+        if !self.is_periodic() || self.is_valset_enabled() {
+            self.cmp = self.cmp.deposit(shift, length, value);
+        }
+
+        if self.is_periodic() {
+            self.period = self.period.deposit(shift, length, value);
+        }
+
+        self.clear_valset();
+        if self.get_state().is_hpet_enabled() {
+            self.set_timer();
+        }
+    }
+
+    /// FSB Interrupt Route Register
+    fn set_tn_fsb_route_reg(&mut self, shift: u32, len: u32, val: u64) {
+        self.fsb = self.fsb.deposit(shift, len, val);
+    }
+
+    fn reset(&mut self) {
+        self.del_timer();
+        self.cmp = u64::MAX; // Comparator Match Registers reset to all 1's.
+        self.config = 1 << HPET_TN_CFG_PERIODIC_CAP_SHIFT | 1 << HPET_TN_CFG_SIZE_CAP_SHIFT;
+        if self.get_state().has_msi_flag() {
+            self.config |= 1 << HPET_TN_CFG_FSB_CAP_SHIFT;
+        }
+        // advertise availability of ioapic int
+        self.config |= (self.get_state().int_route_cap as u64) << HPET_TN_CFG_INT_ROUTE_CAP_SHIFT;
+        self.period = 0;
+        self.wrap_flag = 0;
+    }
+
+    /// timer expiration callback
+    fn callback(&mut self) {
+        let period: u64 = self.period;
+        let cur_tick: u64 = self.get_state().get_ticks();
+
+        if self.is_periodic() && period != 0 {
+            while hpet_time_after(cur_tick, self.cmp64) {
+                self.cmp64 += period;
+            }
+            if self.is_32bit_mod() {
+                self.cmp = self.cmp64 as u32 as u64;
+            } else {
+                self.cmp = self.cmp64;
+            }
+            self.arm_timer(self.cmp64);
+        } else if self.wrap_flag != 0 {
+            self.wrap_flag = 0;
+            self.arm_timer(self.cmp64);
+        }
+        self.update_irq(true);
+    }
+}
+
+/// HPET Event Timer Block Abstraction
+/// Note: Wrap all items that may be changed in the callback called by C
+/// into the BqlCell/BqlRefCell.
+#[repr(C)]
+#[derive(qemu_api_macros::offsets)]
+pub struct HPETState {
+    parent_obj: ParentField<SysBusDevice>,
+    iomem: MemoryRegion,
+
+    /// HPET block Registers: Memory-mapped, software visible registers
+
+    /// General Capabilities and ID Register
+    capability: BqlCell<u64>,
+    ///  General Configuration Register
+    config: BqlCell<u64>,
+    /// General Interrupt Status Register
+    #[doc(alias = "isr")]
+    int_status: BqlCell<u64>,
+    /// Main Counter Value Register
+    #[doc(alias = "hpet_counter")]
+    counter: BqlCell<u64>,
+
+    /// Internal state
+
+    /// Capabilities that QEMU HPET supports.
+    /// bit 0: MSI (or FSB) support.
+    flags: u32,
+
+    /// Offset of main counter relative to qemu clock.
+    hpet_offset: BqlCell<u64>,
+    hpet_offset_saved: bool,
+
+    irqs: [InterruptSource; HPET_NUM_IRQ_ROUTES],
+    rtc_irq_level: BqlCell<u32>,
+    pit_enabled: InterruptSource,
+
+    /// Interrupt Routing Capability.
+    /// This field indicates to which interrupts in the I/O (x) APIC
+    /// the timers' interrupt can be routed, and is encoded in the
+    /// bits 32:64 of timer N's config register:
+    #[doc(alias = "intcap")]
+    int_route_cap: u32,
+
+    /// HPET timer array managed by this timer block.
+    #[doc(alias = "timer")]
+    timers: [BqlRefCell<HPETTimer>; HPET_MAX_TIMERS],
+    num_timers: BqlCell<usize>,
+
+    /// Instance id (HPET timer block ID).
+    hpet_id: BqlCell<usize>,
+}
+
+impl HPETState {
+    fn has_msi_flag(&self) -> bool {
+        self.flags & 1 << HPET_FLAG_MSI_SUPPORT_SHIFT != 0
+    }
+
+    fn is_legacy_mode(&self) -> bool {
+        self.config.get() & 1 << HPET_CFG_LEG_RT_SHIFT != 0
+    }
+
+    fn is_hpet_enabled(&self) -> bool {
+        self.config.get() & 1 << HPET_CFG_ENABLE_SHIFT != 0
+    }
+
+    fn is_timer_int_active(&self, index: usize) -> bool {
+        self.int_status.get() & 1 << index != 0
+    }
+
+    fn get_ticks(&self) -> u64 {
+        ns_to_ticks(CLOCK_VIRTUAL.get_ns() + self.hpet_offset.get())
+    }
+
+    fn get_ns(&self, tick: u64) -> u64 {
+        ticks_to_ns(tick) - self.hpet_offset.get()
+    }
+
+    fn handle_legacy_irq(&self, irq: u32, level: u32) {
+        if irq == HPET_LEGACY_PIT_INT {
+            if !self.is_legacy_mode() {
+                self.irqs[0].set(level != 0);
+            }
+        } else {
+            self.rtc_irq_level.set(level);
+            if !self.is_legacy_mode() {
+                self.irqs[RTC_ISA_IRQ].set(level != 0);
+            }
+        }
+    }
+
+    fn init_timer(&self) {
+        let raw_ptr: *mut HPETState = self as *const HPETState as *mut HPETState;
+
+        for (index, timer) in self.timers.iter().enumerate() {
+            timer
+                .borrow_mut()
+                .init(index, raw_ptr)
+                .init_timer_with_state();
+        }
+    }
+
+    fn update_int_status(&self, index: u32, level: bool) {
+        self.int_status
+            .set(self.int_status.get().deposit(index, 1, level as u64));
+    }
+
+    /// General Configuration Register
+    fn set_cfg_reg(&self, shift: u32, len: u32, val: u64) {
+        let old_val = self.config.get();
+        let mut new_val = old_val.deposit(shift, len, val);
+
+        new_val = hpet_fixup_reg(new_val, old_val, HPET_CFG_WRITE_MASK);
+        self.config.set(new_val);
+
+        if activating_bit(old_val, new_val, HPET_CFG_ENABLE_SHIFT) {
+            // Enable main counter and interrupt generation.
+            self.hpet_offset
+                .set(ticks_to_ns(self.counter.get()) - CLOCK_VIRTUAL.get_ns());
+
+            for timer in self.timers.iter().take(self.num_timers.get()) {
+                let mut t = timer.borrow_mut();
+
+                if t.is_int_enabled() && t.is_int_active() {
+                    t.update_irq(true);
+                }
+                t.set_timer();
+            }
+        } else if deactivating_bit(old_val, new_val, HPET_CFG_ENABLE_SHIFT) {
+            // Halt main counter and disable interrupt generation.
+            self.counter.set(self.get_ticks());
+
+            for timer in self.timers.iter().take(self.num_timers.get()) {
+                timer.borrow_mut().del_timer();
+            }
+        }
+
+        // i8254 and RTC output pins are disabled when HPET is in legacy mode
+        if activating_bit(old_val, new_val, HPET_CFG_LEG_RT_SHIFT) {
+            self.pit_enabled.set(false);
+            self.irqs[0].lower();
+            self.irqs[RTC_ISA_IRQ].lower();
+        } else if deactivating_bit(old_val, new_val, HPET_CFG_LEG_RT_SHIFT) {
+            // TODO: Add irq binding: qemu_irq_lower(s->irqs[0])
+            self.irqs[0].lower();
+            self.pit_enabled.set(true);
+            self.irqs[RTC_ISA_IRQ].set(self.rtc_irq_level.get() != 0);
+        }
+    }
+
+    /// General Interrupt Status Register: Read/Write Clear
+    fn set_int_status_reg(&self, shift: u32, _len: u32, val: u64) {
+        let new_val = val << shift;
+        let cleared = new_val & self.int_status.get();
+
+        for (index, timer) in self.timers.iter().take(self.num_timers.get()).enumerate() {
+            if cleared & 1 << index != 0 {
+                timer.borrow_mut().update_irq(false);
+            }
+        }
+    }
+
+    /// Main Counter Value Register
+    fn set_counter_reg(&self, shift: u32, len: u32, val: u64) {
+        if self.is_hpet_enabled() {
+            // TODO: Add trace point -
+            // trace_hpet_ram_write_counter_write_while_enabled()
+            //
+            // HPET spec says that writes to this register should only be
+            // done while the counter is halted. So this is an undefined
+            // behavior. There's no need to forbid it, but when HPET is
+            // enabled, the changed counter value will not affect the
+            // tick count (i.e., the previously calculated offset will
+            // not be changed as well).
+        }
+        self.counter
+            .set(self.counter.get().deposit(shift, len, val));
+    }
+}
diff --git a/rust/hw/timer/hpet/src/lib.rs b/rust/hw/timer/hpet/src/lib.rs
index c2b9c64d0bfe..027f7f83349a 100644
--- a/rust/hw/timer/hpet/src/lib.rs
+++ b/rust/hw/timer/hpet/src/lib.rs
@@ -11,3 +11,4 @@
 #![deny(unsafe_op_in_unsafe_fn)]
 
 pub mod fw_cfg;
+pub mod hpet;
diff --git a/rust/wrapper.h b/rust/wrapper.h
index a35bfbd1760d..d927ad6799da 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -64,3 +64,4 @@ typedef enum memory_order {
 #include "chardev/char-serial.h"
 #include "exec/memattrs.h"
 #include "qemu/timer.h"
+#include "exec/address-spaces.h"
-- 
2.34.1


