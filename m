Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 045B3BA9E58
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Sep 2025 17:57:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G9h-0001UE-Da; Mon, 29 Sep 2025 11:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G9C-00012u-Is
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8t-0000bP-6f
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759161014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6xM/ox5jvRdTn+yGMrz0OpMCK/hH4jqDMxHh4/RbrLg=;
 b=DG4NzbMPyeGY33uzz8zX1ej7j9wm1XLFkIhfEI253kZSvUPgZU4nbU5jXhNPpbkOuixvlD
 zenkoZly4Bf01aXm2WrD9+Zy3puUUFBdI1R798+SgPSbGF/k55kkrFJehdN8s7Bo0R1KMc
 i2bb6j3K4kICsmffmWxQF3lXwkN0l2U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-wTFxkoA_Mhqia6KXs_pmDQ-1; Mon, 29 Sep 2025 11:50:12 -0400
X-MC-Unique: wTFxkoA_Mhqia6KXs_pmDQ-1
X-Mimecast-MFC-AGG-ID: wTFxkoA_Mhqia6KXs_pmDQ_1759161011
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-62fd1b03d74so6099968a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759161010; x=1759765810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6xM/ox5jvRdTn+yGMrz0OpMCK/hH4jqDMxHh4/RbrLg=;
 b=N6GEMG/iBaTROUcRsqzpCR1j/IFWXKPSMzsWPh9pqrI0clD9jhSjGCXST5CoBstZUe
 ml6XKGNKD/tmb6EpNvCXtyZD6MqY6K1T4OJO7hDb4cSjTrl5VYkehaPFtds/iH7v8TgK
 xlN30kzHSTbleFiQwItHSzNGCcnhTh8AclasqLoUgkdqJ4HrN4lb1dZHWaF+EB/ojcbQ
 Z7kgHWbQoiAuK9ufKnMipWO5W8ebIm66UcGjmC4tgrGs/sjL0JFw6p7LNrXi++LnY2LB
 SPsrVcQme3geTg5e9G/MbixYFjsQcybrkGKj6k351wzKrfrgVrnZ1sABjW8bN6S81IsA
 uePw==
X-Gm-Message-State: AOJu0Yx76GiOTTWcCbDU4Rb4Y+DHFHsuvOpbbjAhymqokslIVlOT8f+A
 Corfz0BNfo7eIZbSwSb9de4JgPgr9G/mRSuIJJUv06mExjuO9uxIBBCLgvz5y86dRDm/Zev1Qqu
 3T1PrS1e83MtGZyY6bD1xgbwwb+aquhJDY3CdRyqArFL6OyEugENDJVP3CPiKnB9ubdaiPKVwIr
 Rqkw5OXASxQZrKLO+3yfiXRVSnDQGb8gNViAgnyqfa
X-Gm-Gg: ASbGnctiP6HalgpOXjJLqMLHxSYU6JF7NYVVpwX+zm5QomUaiVea5yOpUJbYURWxzNP
 wdq9tZuudwDlEtdAEd4rLod7LsRFK4dniwiekRMsKGQnpj+zCIPEri/atgvD54zTIC1WxNRTfwC
 cQdkfCdGQW/e1dhHQQLvbccEkiJzdLN33U+7/O+UVDaN6CNqi4Ds4J8yJFI0xGj0NhNdZZ/T1au
 +nuiUzfHRaDr3TUrhhR7WkkY9+MYdC2vHSZR/AhnRVa91RowRfHCzSreYdcW4Na65vFV+ducaue
 4k6VULJkiSTbKxNAhpuOrRIbc25yVvNfnlgCJ8qam4foGE9YEqILlskHmH4ntbPNrxpJ113QRyO
 husSou1aWuiBp/kgJKEV2E9XWNaa4aXBhq4YFEbY/5GRF5g==
X-Received: by 2002:a05:6402:1806:b0:634:5381:530b with SMTP id
 4fb4d7f45d1cf-6349f9e69d2mr11729359a12.13.1759161009900; 
 Mon, 29 Sep 2025 08:50:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVnmIw0jUoeyvBAr7W+rxG6zzqBZgzWS/rdEuDiMTI1qjGzsXgi9zf2/bTcStUy2ivrAkSxw==
X-Received: by 2002:a05:6402:1806:b0:634:5381:530b with SMTP id
 4fb4d7f45d1cf-6349f9e69d2mr11729323a12.13.1759161009325; 
 Mon, 29 Sep 2025 08:50:09 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-634a3629badsm7845552a12.9.2025.09.29.08.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:50:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-rust@nongnu.org
Subject: [PATCH 11/16] rust: pl011: add tracepoints
Date: Mon, 29 Sep 2025 17:49:33 +0200
Message-ID: <20250929154938.594389-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929154938.594389-1-pbonzini@redhat.com>
References: <20250929154938.594389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Finally bring parity between C and Rust versions of the PL011 device model.
Changing some types of the arguments makes for nicer Rust code; C does not
care. :)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/trace-events             | 14 ++++----
 rust/Cargo.lock                  |  1 +
 rust/hw/char/pl011/Cargo.toml    |  1 +
 rust/hw/char/pl011/meson.build   |  1 +
 rust/hw/char/pl011/src/device.rs | 57 ++++++++++++++++++++++----------
 5 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/hw/char/trace-events b/hw/char/trace-events
index 05a33036c12..9e74be2c14f 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -58,15 +58,15 @@ imx_serial_write(const char *chrname, uint64_t addr, uint64_t value) "%s:[0x%03"
 imx_serial_put_data(const char *chrname, uint32_t value) "%s: 0x%" PRIx32
 
 # pl011.c
-pl011_irq_state(int level) "irq state %d"
-pl011_read(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x value 0x%08x reg %s"
-pl011_read_fifo(unsigned rx_fifo_used, size_t rx_fifo_depth) "RX FIFO read, used %u/%zu"
-pl011_write(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x value 0x%08x reg %s"
-pl011_can_receive(uint32_t lcr, unsigned rx_fifo_used, size_t rx_fifo_depth, unsigned rx_fifo_available) "LCR 0x%02x, RX FIFO used %u/%zu, can_receive %u chars"
-pl011_fifo_rx_put(uint32_t c, unsigned read_count, size_t rx_fifo_depth) "RX FIFO push char [0x%02x] %d/%zu depth used"
+pl011_irq_state(bool level) "irq state %d"
+pl011_read(uint64_t addr, uint32_t value, const char *regname) "addr 0x%03" PRIx64 " value 0x%08x reg %s"
+pl011_read_fifo(unsigned rx_fifo_used, unsigned rx_fifo_depth) "RX FIFO read, used %u/%u"
+pl011_write(uint64_t addr, uint32_t value, const char *regname) "addr 0x%03" PRIx64 " value 0x%08x reg %s"
+pl011_can_receive(uint32_t lcr, unsigned rx_fifo_used, unsigned rx_fifo_depth, unsigned rx_fifo_available) "LCR 0x%02x, RX FIFO used %u/%u, can_receive %u chars"
+pl011_fifo_rx_put(uint32_t c, unsigned read_count, unsigned rx_fifo_depth) "RX FIFO push char [0x%02x] %d/%u depth used"
 pl011_fifo_rx_full(void) "RX FIFO now full, RXFF set"
 pl011_baudrate_change(unsigned int baudrate, uint64_t clock, uint32_t ibrd, uint32_t fbrd) "new baudrate %u (clk: %" PRIu64 "hz, ibrd: %" PRIu32 ", fbrd: %" PRIu32 ")"
-pl011_receive(int size) "recv %d chars"
+pl011_receive(size_t size) "recv %zd chars"
 
 # cmsdk-apb-uart.c
 cmsdk_apb_uart_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB UART read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 3428dbaf0b3..f84a3dd0764 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -159,6 +159,7 @@ dependencies = [
  "migration",
  "qom",
  "system",
+ "trace",
  "util",
 ]
 
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index b2418abc4bf..dc41d0e499e 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -24,6 +24,7 @@ qom = { path = "../../../qom" }
 chardev = { path = "../../../chardev" }
 system = { path = "../../../system" }
 hwcore = { path = "../../../hw/core" }
+trace = { path = "../../../trace" }
 
 [lints]
 workspace = true
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index ffdc8af53f1..ed28b158add 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -39,6 +39,7 @@ _libpl011_rs = static_library(
     chardev_rs,
     system_rs,
     hwcore_rs,
+    trace_rs
   ],
 )
 
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 1b4587d5f60..8889d6e54fb 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -21,6 +21,8 @@
 
 use crate::registers::{self, Interrupt, RegisterOffset};
 
+::trace::include_trace!("hw_char");
+
 // TODO: You must disable the UART before any of the control registers are
 // reprogrammed. When the UART is disabled in the middle of transmission or
 // reception, it completes the current character before stopping
@@ -208,13 +210,7 @@ pub(self) fn read(&mut self, offset: RegisterOffset) -> (bool, u32) {
         (update, result)
     }
 
-    pub(self) fn write(
-        &mut self,
-        offset: RegisterOffset,
-        value: u32,
-        char_backend: &CharBackend,
-    ) -> bool {
-        // eprintln!("write offset {offset} value {value}");
+    pub(self) fn write(&mut self, offset: RegisterOffset, value: u32, device: &PL011State) -> bool {
         use RegisterOffset::*;
         match offset {
             DR => return self.write_data_register(value),
@@ -229,9 +225,11 @@ pub(self) fn write(
             }
             IBRD => {
                 self.ibrd = value;
+                device.trace_baudrate_change(self.ibrd, self.fbrd);
             }
             FBRD => {
                 self.fbrd = value;
+                device.trace_baudrate_change(self.ibrd, self.fbrd);
             }
             LCR_H => {
                 let new_val: registers::LineControl = value.into();
@@ -242,7 +240,7 @@ pub(self) fn write(
                 }
                 let update = (self.line_control.send_break() != new_val.send_break()) && {
                     let break_enable = new_val.send_break();
-                    let _ = char_backend.send_break(break_enable);
+                    let _ = device.char_backend.send_break(break_enable);
                     self.loopback_break(break_enable)
                 };
                 self.line_control = new_val;
@@ -279,12 +277,13 @@ pub(self) fn write(
     }
 
     fn read_data_register(&mut self, update: &mut bool) -> u32 {
+        let depth = self.fifo_depth();
         self.flags.set_receive_fifo_full(false);
         let c = self.read_fifo[self.read_pos];
 
         if self.read_count > 0 {
             self.read_count -= 1;
-            self.read_pos = (self.read_pos + 1) & (self.fifo_depth() - 1);
+            self.read_pos = (self.read_pos + 1) & (depth - 1);
         }
         if self.read_count == 0 {
             self.flags.set_receive_fifo_empty(true);
@@ -292,6 +291,7 @@ fn read_data_register(&mut self, update: &mut bool) -> u32 {
         if self.read_count + 1 == self.read_trigger {
             self.int_level &= !Interrupt::RX;
         }
+        trace::trace_pl011_read_fifo(self.read_count, depth);
         self.receive_status_error_clear.set_from_data(c);
         *update = true;
         u32::from(c)
@@ -447,7 +447,9 @@ pub fn fifo_rx_put(&mut self, value: registers::Data) -> bool {
         self.read_fifo[slot] = value;
         self.read_count += 1;
         self.flags.set_receive_fifo_empty(false);
+        trace::trace_pl011_fifo_rx_put(value.into(), self.read_count, depth);
         if self.read_count == depth {
+            trace::trace_pl011_fifo_rx_full();
             self.flags.set_receive_fifo_full(true);
         }
 
@@ -516,8 +518,21 @@ unsafe fn init(mut this: ParentInit<Self>) {
         uninit_field_mut!(*this, clock).write(clock);
     }
 
-    const fn clock_update(&self, _event: ClockEvent) {
-        /* pl011_trace_baudrate_change(s); */
+    pub fn trace_baudrate_change(&self, ibrd: u32, fbrd: u32) {
+        let divider = 4.0 / f64::from(ibrd * (FBRD_MASK + 1) + fbrd);
+        let hz = self.clock.hz();
+        let rate = if ibrd == 0 {
+            0
+        } else {
+            ((hz as f64) * divider) as u32
+        };
+        trace::trace_pl011_baudrate_change(rate, hz, ibrd, fbrd);
+    }
+
+    fn clock_update(&self, _event: ClockEvent) {
+        let regs = self.regs.borrow();
+        let (ibrd, fbrd) = (regs.ibrd, regs.fbrd);
+        self.trace_baudrate_change(ibrd, fbrd)
     }
 
     pub fn clock_needed(&self) -> bool {
@@ -543,6 +558,7 @@ fn read(&self, offset: hwaddr, _size: u32) -> u64 {
             }
             Ok(field) => {
                 let (update_irq, result) = self.regs.borrow_mut().read(field);
+                trace::trace_pl011_read(offset, result, c"");
                 if update_irq {
                     self.update();
                     self.char_backend.accept_input();
@@ -557,6 +573,7 @@ fn write(&self, offset: hwaddr, value: u64, _size: u32) {
         if let Ok(field) = RegisterOffset::try_from(offset) {
             // qemu_chr_fe_write_all() calls into the can_receive
             // callback, so handle writes before entering PL011Registers.
+            trace::trace_pl011_write(offset, value as u32, c"");
             if field == RegisterOffset::DR {
                 // ??? Check if transmitter is enabled.
                 let ch: [u8; 1] = [value as u8];
@@ -565,10 +582,7 @@ fn write(&self, offset: hwaddr, value: u64, _size: u32) {
                 let _ = self.char_backend.write_all(&ch);
             }
 
-            update_irq = self
-                .regs
-                .borrow_mut()
-                .write(field, value as u32, &self.char_backend);
+            update_irq = self.regs.borrow_mut().write(field, value as u32, self);
         } else {
             log_mask_ln!(
                 Log::GuestError,
@@ -582,11 +596,19 @@ fn write(&self, offset: hwaddr, value: u64, _size: u32) {
 
     fn can_receive(&self) -> u32 {
         let regs = self.regs.borrow();
-        // trace_pl011_can_receive(s->lcr, s->read_count, r);
-        regs.fifo_depth() - regs.read_count
+        let fifo_available = regs.fifo_depth() - regs.read_count;
+        trace::trace_pl011_can_receive(
+            regs.line_control.into(),
+            regs.read_count,
+            regs.fifo_depth(),
+            fifo_available,
+        );
+        fifo_available
     }
 
     fn receive(&self, buf: &[u8]) {
+        trace::trace_pl011_receive(buf.len());
+
         let mut regs = self.regs.borrow_mut();
         if regs.loopback_enabled() {
             // In loopback mode, the RX input signal is internally disconnected
@@ -635,6 +657,7 @@ fn reset_hold(&self, _type: ResetType) {
     fn update(&self) {
         let regs = self.regs.borrow();
         let flags = regs.int_level & regs.int_enabled;
+        trace::trace_pl011_irq_state(flags != 0);
         for (irq, i) in self.interrupts.iter().zip(IRQMASK) {
             irq.set(flags.any_set(i));
         }
-- 
2.51.0


