Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3257BA65ADD
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Mar 2025 18:34:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuELV-0008WD-Ec; Mon, 17 Mar 2025 13:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuEKc-0008Qc-9K
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 13:32:54 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuEKT-0002xB-R0
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 13:32:48 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-399676b7c41so723035f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 10:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742232762; x=1742837562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MeD6J6XxDjk8qOP7n6gdWWZqWtsDrdTAYr7nYyZiWOk=;
 b=YwkvV+3KFFKOZFWKsaR/wWqa1cUhqWwwUzkFBIkJsYB0lyILGSFI/K3tfk3kXNUkT/
 IbiZAg/ug6LL4X6dZaV2VQ8IHp41lt7hXeqY7Y21+ImmG4lL2SKvXIcNh8+ZYBToG7XK
 o/CH2b7QD7G9xfoyhbOhmM+imBuk+pVHE2lk+rNVwaLtLp85Q8SeuDGPHE+JObP+R9C6
 T/kEAZIx+k7Xvggq9uIZEVxsLFgINswKUo8ssGhQSGbImlxHYzGioG7Zd2XQ0NVd8KfX
 Fib25ExEc9L1uAYKkPYHO0mwswySdJoYsaLPUiPn7oZKAh0MfLSD+NoHCZXDcMNX8wPn
 LQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742232762; x=1742837562;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MeD6J6XxDjk8qOP7n6gdWWZqWtsDrdTAYr7nYyZiWOk=;
 b=U789oUnoYqc18aSCbKk5Pwbc7TNm1JDROpeBAk6FZgTu3IBpNx2c2Pp/264fxu9oBc
 CqF3sBQAToN/okfNBDp+JV+nP9XR1jyz+QPWGOpHYavxA8JmMfCDVg2epS2b5Be/+Fe9
 UlQQzzWtIn96HwmtCH3nDOmdWiY40zHwzqxcbCdsNr/pLxuG35tulNfSkVWtsaTf7njw
 2sE2S1VMeH2lmq6BuiU6JLXelOfMtIyevNp5FumZ//q2MKAdQ0qQHCq6tcQbGPMoPGjw
 z5LeQufMCZBWxIiti2oL0z3Ahq0fwOo9pdGXbFl/uuqrmpnV+6eQvNZMbfnjbqUdkyDm
 3Eqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOHRaa0etyp0eDQ94U2UKAFIayDTBxXkJyVttlzHmK45t+vkVtD/cXhAvfqbgeuR4wL02TXn1RXO8t@nongnu.org
X-Gm-Message-State: AOJu0YziJKMx0x+1LCi0zHdWHt2TH4gMyWvZLnxv9dw/3RmcVMRzXTL+
 QuOgw+JufNmoY0KBgbbYb6FOkIn8adiyTofHp+1l6B/JFOQRlI7l4VOLpclnzjA=
X-Gm-Gg: ASbGncshQyq6QS37RATpjT+VG9lUuKgyCmcMojoeFC3XATSlZk5dhen3MFhRS9EYge+
 xXSddaqQobqc020jNbWdKxE+yKGAjMZuK5y141eNOP1N3u9KJ1GG3fa8q7kkepj/vPZTLbcjERi
 gF0aAtfK/LzKY2RnIqbpvs1Um0nUsS4KqUTO2aqxeNZYemUgOUT/davLyT7ickky2kE71BgAwxT
 p0P8vBZK0g1TkYCVY6iPvzH8vZm2IKTA/dlEOig4ktc78rm48JlOb6G1Xu4ybIok19L9j6f6oY2
 AM6M47U/7+pmkMe/JvFn8VT0dxfGrlqOLSXaI4dseg8Ahq4jy88=
X-Google-Smtp-Source: AGHT+IFJwJ8DLLRsYz9LNtWpVS87MvcfpeMW2EOCtlDZdCbGaSEJsdCfk09IqDlFku/mGqSrxmUeQg==
X-Received: by 2002:a5d:47cf:0:b0:391:31c8:ba58 with SMTP id
 ffacd0b85a97d-3971d03ee20mr13129758f8f.10.1742232761716; 
 Mon, 17 Mar 2025 10:32:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c83b6a10sm15763289f8f.36.2025.03.17.10.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 10:32:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH] rust: pl011: Cut down amount of text quoted from PL011 TRM
Date: Mon, 17 Mar 2025 17:32:39 +0000
Message-ID: <20250317173239.941034-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Currently the comments in the Rust pl011 register.rs file include
large amounts of text from the PL011 TRM.  This is much more
commentary than we typically quote from a device reference manual,
and much of it is not relevant to QEMU.  Compress and rephrase the
comments so that we are not quoting such a large volume of TRM text.

We add a URL for the TRM; readers who need more detail on the
function of the register bits can find it there, presented in
context with the overall description of the hardware.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 rust/hw/char/pl011/src/registers.rs | 261 ++++++----------------------
 1 file changed, 51 insertions(+), 210 deletions(-)

diff --git a/rust/hw/char/pl011/src/registers.rs b/rust/hw/char/pl011/src/registers.rs
index cd92fa2c300..690feb63785 100644
--- a/rust/hw/char/pl011/src/registers.rs
+++ b/rust/hw/char/pl011/src/registers.rs
@@ -5,13 +5,13 @@
 //! Device registers exposed as typed structs which are backed by arbitrary
 //! integer bitmaps. [`Data`], [`Control`], [`LineControl`], etc.
 
+// For more detail see the PL011 Technical Reference Manual DDI0183:
+// https://developer.arm.com/documentation/ddi0183/latest/
+
 use bilge::prelude::*;
 use qemu_api::impl_vmstate_bitsized;
 
 /// Offset of each register from the base memory address of the device.
-///
-/// # Source
-/// ARM DDI 0183G, Table 3-1 p.3-3
 #[doc(alias = "offset")]
 #[allow(non_camel_case_types)]
 #[repr(u64)]
@@ -87,48 +87,11 @@ pub struct Errors {
     _reserved_unpredictable: u4,
 }
 
-// TODO: FIFO Mode has different semantics
 /// Data Register, `UARTDR`
 ///
-/// The `UARTDR` register is the data register.
-///
-/// For words to be transmitted:
-///
-/// - if the FIFOs are enabled, data written to this location is pushed onto the
-///   transmit
-/// FIFO
-/// - if the FIFOs are not enabled, data is stored in the transmitter holding
-///   register (the
-/// bottom word of the transmit FIFO).
-///
-/// The write operation initiates transmission from the UART. The data is
-/// prefixed with a start bit, appended with the appropriate parity bit
-/// (if parity is enabled), and a stop bit. The resultant word is then
-/// transmitted.
-///
-/// For received words:
-///
-/// - if the FIFOs are enabled, the data byte and the 4-bit status (break,
-///   frame, parity,
-/// and overrun) is pushed onto the 12-bit wide receive FIFO
-/// - if the FIFOs are not enabled, the data byte and status are stored in the
-///   receiving
-/// holding register (the bottom word of the receive FIFO).
-///
-/// The received data byte is read by performing reads from the `UARTDR`
-/// register along with the corresponding status information. The status
-/// information can also be read by a read of the `UARTRSR/UARTECR`
-/// register.
-///
-/// # Note
-///
-/// You must disable the UART before any of the control registers are
-/// reprogrammed. When the UART is disabled in the middle of
-/// transmission or reception, it completes the current character before
-/// stopping.
-///
-/// # Source
-/// ARM DDI 0183G 3.3.1 Data Register, UARTDR
+/// The `UARTDR` register is the data register; write for TX and
+/// read for RX. It is a 12-bit register, where bits 7..0 are the
+/// character and bits 11..8 are error bits.
 #[bitsize(32)]
 #[derive(Clone, Copy, Default, DebugBits, FromBits)]
 #[doc(alias = "UARTDR")]
@@ -144,30 +107,17 @@ impl Data {
     pub const BREAK: Self = Self { value: 1 << 10 };
 }
 
-// TODO: FIFO Mode has different semantics
 /// Receive Status Register / Error Clear Register, `UARTRSR/UARTECR`
 ///
-/// The UARTRSR/UARTECR register is the receive status register/error clear
-/// register. Receive status can also be read from the `UARTRSR`
-/// register. If the status is read from this register, then the status
-/// information for break, framing and parity corresponds to the
-/// data character read from the [Data register](Data), `UARTDR` prior to
-/// reading the UARTRSR register. The status information for overrun is
-/// set immediately when an overrun condition occurs.
+/// This register provides a different way to read the four receive
+/// status error bits that can be found in bits 11..8 of the UARTDR
+/// on a read. It gets updated when the guest reads UARTDR, and the
+/// status bits correspond to that character that was just read.
 ///
-///
-/// # Note
-/// The received data character must be read first from the [Data
-/// Register](Data), `UARTDR` before reading the error status associated
-/// with that data character from the `UARTRSR` register. This read
-/// sequence cannot be reversed, because the `UARTRSR` register is
-/// updated only when a read occurs from the `UARTDR` register. However,
-/// the status information can also be obtained by reading the `UARTDR`
-/// register
-///
-/// # Source
-/// ARM DDI 0183G 3.3.2 Receive Status Register/Error Clear Register,
-/// UARTRSR/UARTECR
+/// The TRM confusingly describes this offset as UARTRSR for reads
+/// and UARTECR for writes, but really it's a single error status
+/// register where writing anything to the register clears the error
+/// bits.
 #[bitsize(32)]
 #[derive(Clone, Copy, DebugBits, FromBits)]
 pub struct ReceiveStatusErrorClear {
@@ -196,54 +146,29 @@ fn default() -> Self {
 #[bitsize(32)]
 #[derive(Clone, Copy, DebugBits, FromBits)]
 /// Flag Register, `UARTFR`
+///
+/// This has the usual inbound RS232 modem-control signals, plus flags
+/// for RX and TX FIFO fill levels and a BUSY flag.
 #[doc(alias = "UARTFR")]
 pub struct Flags {
-    /// CTS Clear to send. This bit is the complement of the UART clear to
-    /// send, `nUARTCTS`, modem status input. That is, the bit is 1
-    /// when `nUARTCTS` is LOW.
+    /// CTS: Clear to send
     pub clear_to_send: bool,
-    /// DSR Data set ready. This bit is the complement of the UART data set
-    /// ready, `nUARTDSR`, modem status input. That is, the bit is 1 when
-    /// `nUARTDSR` is LOW.
+    /// DSR: Data set ready
     pub data_set_ready: bool,
-    /// DCD Data carrier detect. This bit is the complement of the UART data
-    /// carrier detect, `nUARTDCD`, modem status input. That is, the bit is
-    /// 1 when `nUARTDCD` is LOW.
+    /// DCD: Data carrier detect
     pub data_carrier_detect: bool,
-    /// BUSY UART busy. If this bit is set to 1, the UART is busy
-    /// transmitting data. This bit remains set until the complete
-    /// byte, including all the stop bits, has been sent from the
-    /// shift register. This bit is set as soon as the transmit FIFO
-    /// becomes non-empty, regardless of whether the UART is enabled
-    /// or not.
+    /// BUSY: UART busy. In real hardware, set while the UART is
+    /// busy transmitting data. QEMU's implementation never sets BUSY.
     pub busy: bool,
-    /// RXFE Receive FIFO empty. The meaning of this bit depends on the
-    /// state of the FEN bit in the UARTLCR_H register. If the FIFO
-    /// is disabled, this bit is set when the receive holding
-    /// register is empty. If the FIFO is enabled, the RXFE bit is
-    /// set when the receive FIFO is empty.
+    /// RXFE: Receive FIFO empty
     pub receive_fifo_empty: bool,
-    /// TXFF Transmit FIFO full. The meaning of this bit depends on the
-    /// state of the FEN bit in the UARTLCR_H register. If the FIFO
-    /// is disabled, this bit is set when the transmit holding
-    /// register is full. If the FIFO is enabled, the TXFF bit is
-    /// set when the transmit FIFO is full.
+    /// TXFF: Transmit FIFO full
     pub transmit_fifo_full: bool,
-    /// RXFF Receive FIFO full. The meaning of this bit depends on the state
-    /// of the FEN bit in the UARTLCR_H register. If the FIFO is
-    /// disabled, this bit is set when the receive holding register
-    /// is full. If the FIFO is enabled, the RXFF bit is set when
-    /// the receive FIFO is full.
+    /// RXFF: Receive FIFO full
     pub receive_fifo_full: bool,
-    /// Transmit FIFO empty. The meaning of this bit depends on the state of
-    /// the FEN bit in the [Line Control register](LineControl),
-    /// `UARTLCR_H`. If the FIFO is disabled, this bit is set when the
-    /// transmit holding register is empty. If the FIFO is enabled,
-    /// the TXFE bit is set when the transmit FIFO is empty. This
-    /// bit does not indicate if there is data in the transmit shift
-    /// register.
+    /// TXFE: Transmit FIFO empty
     pub transmit_fifo_empty: bool,
-    /// `RI`, is `true` when `nUARTRI` is `LOW`.
+    /// RI: Ring indicator
     pub ring_indicator: bool,
     _reserved_zero_no_modify: u23,
 }
@@ -270,54 +195,23 @@ fn default() -> Self {
 /// Line Control Register, `UARTLCR_H`
 #[doc(alias = "UARTLCR_H")]
 pub struct LineControl {
-    /// BRK Send break.
-    ///
-    /// If this bit is set to `1`, a low-level is continually output on the
-    /// `UARTTXD` output, after completing transmission of the
-    /// current character. For the proper execution of the break command,
-    /// the software must set this bit for at least two complete
-    /// frames. For normal use, this bit must be cleared to `0`.
+    /// BRK: Send break
     pub send_break: bool,
-    /// 1 PEN Parity enable:
-    ///
-    /// - 0 = parity is disabled and no parity bit added to the data frame
-    /// - 1 = parity checking and generation is enabled.
-    ///
-    /// See Table 3-11 on page 3-14 for the parity truth table.
+    /// PEN: Parity enable
     pub parity_enabled: bool,
-    /// EPS Even parity select. Controls the type of parity the UART uses
-    /// during transmission and reception:
-    /// - 0 = odd parity. The UART generates or checks for an odd number of 1s
-    ///   in the data and parity bits.
-    /// - 1 = even parity. The UART generates or checks for an even number of 1s
-    ///   in the data and parity bits.
-    /// This bit has no effect when the `PEN` bit disables parity checking
-    /// and generation. See Table 3-11 on page 3-14 for the parity
-    /// truth table.
+    /// EPS: Even parity select
     pub parity: Parity,
-    /// 3 STP2 Two stop bits select. If this bit is set to 1, two stop bits
-    /// are transmitted at the end of the frame. The receive
-    /// logic does not check for two stop bits being received.
+    /// STP2: Two stop bits select
     pub two_stops_bits: bool,
-    /// FEN Enable FIFOs:
-    /// 0 = FIFOs are disabled (character mode) that is, the FIFOs become
-    /// 1-byte-deep holding registers 1 = transmit and receive FIFO
-    /// buffers are enabled (FIFO mode).
+    /// FEN: Enable FIFOs
     pub fifos_enabled: Mode,
-    /// WLEN Word length. These bits indicate the number of data bits
-    /// transmitted or received in a frame as follows: b11 = 8 bits
+    /// WLEN: Word length in bits
+    /// b11 = 8 bits
     /// b10 = 7 bits
     /// b01 = 6 bits
     /// b00 = 5 bits.
     pub word_length: WordLength,
-    /// 7 SPS Stick parity select.
-    /// 0 = stick parity is disabled
-    /// 1 = either:
-    /// • if the EPS bit is 0 then the parity bit is transmitted and checked
-    /// as a 1 • if the EPS bit is 1 then the parity bit is
-    /// transmitted and checked as a 0. This bit has no effect when
-    /// the PEN bit disables parity checking and generation. See Table 3-11
-    /// on page 3-14 for the parity truth table.
+    /// SPS Stick parity select
     pub sticky_parity: bool,
     /// 31:8 - Reserved, do not modify, read as zero.
     _reserved_zero_no_modify: u24,
@@ -342,11 +236,7 @@ fn default() -> Self {
 /// `EPS` "Even parity select", field of [Line Control
 /// register](LineControl).
 pub enum Parity {
-    /// - 0 = odd parity. The UART generates or checks for an odd number of 1s
-    ///   in the data and parity bits.
     Odd = 0,
-    /// - 1 = even parity. The UART generates or checks for an even number of 1s
-    ///   in the data and parity bits.
     Even = 1,
 }
 
@@ -381,88 +271,39 @@ pub enum WordLength {
 
 /// Control Register, `UARTCR`
 ///
-/// The `UARTCR` register is the control register. All the bits are cleared
-/// to `0` on reset except for bits `9` and `8` that are set to `1`.
-///
-/// # Source
-/// ARM DDI 0183G, 3.3.8 Control Register, `UARTCR`, Table 3-12
+/// The `UARTCR` register is the control register. It contains various
+/// enable bits, and the bits to write to set the usual outbound RS232
+/// modem control signals. All bits reset to 0 except TXE and RXE.
 #[bitsize(32)]
 #[doc(alias = "UARTCR")]
 #[derive(Clone, Copy, DebugBits, FromBits)]
 pub struct Control {
-    /// `UARTEN` UART enable: 0 = UART is disabled. If the UART is disabled
-    /// in the middle of transmission or reception, it completes the current
-    /// character before stopping. 1 = the UART is enabled. Data
-    /// transmission and reception occurs for either UART signals or SIR
-    /// signals depending on the setting of the SIREN bit.
+    /// `UARTEN` UART enable: 0 = UART is disabled.
     pub enable_uart: bool,
-    /// `SIREN` `SIR` enable: 0 = IrDA SIR ENDEC is disabled. `nSIROUT`
-    /// remains LOW (no light pulse generated), and signal transitions on
-    /// SIRIN have no effect. 1 = IrDA SIR ENDEC is enabled. Data is
-    /// transmitted and received on nSIROUT and SIRIN. UARTTXD remains HIGH,
-    /// in the marking state. Signal transitions on UARTRXD or modem status
-    /// inputs have no effect. This bit has no effect if the UARTEN bit
-    /// disables the UART.
+    /// `SIREN` `SIR` enable: disable or enable IrDA SIR ENDEC.
+    /// QEMU does not model this.
     pub enable_sir: bool,
-    /// `SIRLP` SIR low-power IrDA mode. This bit selects the IrDA encoding
-    /// mode. If this bit is cleared to 0, low-level bits are transmitted as
-    /// an active high pulse with a width of 3/ 16th of the bit period. If
-    /// this bit is set to 1, low-level bits are transmitted with a pulse
-    /// width that is 3 times the period of the IrLPBaud16 input signal,
-    /// regardless of the selected bit rate. Setting this bit uses less
-    /// power, but might reduce transmission distances.
+    /// `SIRLP` SIR low-power IrDA mode. QEMU does not model this.
     pub sir_lowpower_irda_mode: u1,
     /// Reserved, do not modify, read as zero.
     _reserved_zero_no_modify: u4,
-    /// `LBE` Loopback enable. If this bit is set to 1 and the SIREN bit is
-    /// set to 1 and the SIRTEST bit in the Test Control register, UARTTCR
-    /// on page 4-5 is set to 1, then the nSIROUT path is inverted, and fed
-    /// through to the SIRIN path. The SIRTEST bit in the test register must
-    /// be set to 1 to override the normal half-duplex SIR operation. This
-    /// must be the requirement for accessing the test registers during
-    /// normal operation, and SIRTEST must be cleared to 0 when loopback
-    /// testing is finished. This feature reduces the amount of external
-    /// coupling required during system test. If this bit is set to 1, and
-    /// the SIRTEST bit is set to 0, the UARTTXD path is fed through to the
-    /// UARTRXD path. In either SIR mode or UART mode, when this bit is set,
-    /// the modem outputs are also fed through to the modem inputs. This bit
-    /// is cleared to 0 on reset, to disable loopback.
+    /// `LBE` Loopback enable: feed UART output back to the input
     pub enable_loopback: bool,
-    /// `TXE` Transmit enable. If this bit is set to 1, the transmit section
-    /// of the UART is enabled. Data transmission occurs for either UART
-    /// signals, or SIR signals depending on the setting of the SIREN bit.
-    /// When the UART is disabled in the middle of transmission, it
-    /// completes the current character before stopping.
+    /// `TXE` Transmit enable
     pub enable_transmit: bool,
-    /// `RXE` Receive enable. If this bit is set to 1, the receive section
-    /// of the UART is enabled. Data reception occurs for either UART
-    /// signals or SIR signals depending on the setting of the SIREN bit.
-    /// When the UART is disabled in the middle of reception, it completes
-    /// the current character before stopping.
+    /// `RXE` Receive enable
     pub enable_receive: bool,
-    /// `DTR` Data transmit ready. This bit is the complement of the UART
-    /// data transmit ready, `nUARTDTR`, modem status output. That is, when
-    /// the bit is programmed to a 1 then `nUARTDTR` is LOW.
+    /// `DTR` Data transmit ready
     pub data_transmit_ready: bool,
-    /// `RTS` Request to send. This bit is the complement of the UART
-    /// request to send, `nUARTRTS`, modem status output. That is, when the
-    /// bit is programmed to a 1 then `nUARTRTS` is LOW.
+    /// `RTS` Request to send
     pub request_to_send: bool,
-    /// `Out1` This bit is the complement of the UART Out1 (`nUARTOut1`)
-    /// modem status output. That is, when the bit is programmed to a 1 the
-    /// output is 0. For DTE this can be used as Data Carrier Detect (DCD).
+    /// `Out1` UART Out1 signal; can be used as DCD
     pub out_1: bool,
-    /// `Out2` This bit is the complement of the UART Out2 (`nUARTOut2`)
-    /// modem status output. That is, when the bit is programmed to a 1, the
-    /// output is 0. For DTE this can be used as Ring Indicator (RI).
+    /// `Out2` UART Out2 signal; can be used as RI
     pub out_2: bool,
-    /// `RTSEn` RTS hardware flow control enable. If this bit is set to 1,
-    /// RTS hardware flow control is enabled. Data is only requested when
-    /// there is space in the receive FIFO for it to be received.
+    /// `RTSEn` RTS hardware flow control enable
     pub rts_hardware_flow_control_enable: bool,
-    /// `CTSEn` CTS hardware flow control enable. If this bit is set to 1,
-    /// CTS hardware flow control is enabled. Data is only transmitted when
-    /// the `nUARTCTS` signal is asserted.
+    /// `CTSEn` CTS hardware flow control enable
     pub cts_hardware_flow_control_enable: bool,
     /// 31:16 - Reserved, do not modify, read as zero.
     _reserved_zero_no_modify2: u16,
-- 
2.43.0


