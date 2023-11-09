Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7E67E6C00
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:05:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15dh-0008NR-Ky; Thu, 09 Nov 2023 09:04:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15bJ-0008Ld-Bo; Thu, 09 Nov 2023 09:01:42 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15bH-0006Dz-3y; Thu, 09 Nov 2023 09:01:41 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D8C3E31BCD;
 Thu,  9 Nov 2023 16:59:55 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E26D134506;
 Thu,  9 Nov 2023 16:59:47 +0300 (MSK)
Received: (nullmailer pid 1462847 invoked by uid 1000);
 Thu, 09 Nov 2023 13:59:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ricky Zhou <ricky@rzhou.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.7 23/62] target/i386: Fix exception classes for SSE/AVX
 instructions.
Date: Thu,  9 Nov 2023 16:58:51 +0300
Message-Id: <20231109135933.1462615-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
References: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Ricky Zhou <ricky@rzhou.org>

Fix the exception classes for some SSE/AVX instructions to match what is
documented in the Intel manual.

These changes are expected to have no functional effect on the behavior
that qemu implements (primarily >= 16-byte memory alignment checks). For
instance, since qemu does not implement the AC flag, there is no
difference in behavior between Exception Classes 4 and 5 for
instructions where the SSE version only takes <16 byte memory operands.
Message-Id: <20230501111428.95998-2-ricky@rzhou.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit cab529b0dc15746b270e87d77e1dd12c6216807c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 38eddd1adb..8c477c1bab 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -237,7 +237,7 @@ static void decode_group14(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
 static void decode_0F6F(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
     static const X86OpEntry opcodes_0F6F[4] = {
-        X86_OP_ENTRY3(MOVDQ,       P,q, None,None, Q,q, vex1 mmx),  /* movq */
+        X86_OP_ENTRY3(MOVDQ,       P,q, None,None, Q,q, vex5 mmx),  /* movq */
         X86_OP_ENTRY3(MOVDQ,       V,x, None,None, W,x, vex1),      /* movdqa */
         X86_OP_ENTRY3(MOVDQ,       V,x, None,None, W,x, vex4_unal), /* movdqu */
         {},
@@ -306,7 +306,7 @@ static void decode_0F7E(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
 static void decode_0F7F(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
     static const X86OpEntry opcodes_0F7F[4] = {
-        X86_OP_ENTRY3(MOVDQ,       W,x, None,None, V,x, vex1 mmx), /* movq */
+        X86_OP_ENTRY3(MOVDQ,       W,x, None,None, V,x, vex5 mmx), /* movq */
         X86_OP_ENTRY3(MOVDQ,       W,x, None,None, V,x, vex1), /* movdqa */
         X86_OP_ENTRY3(MOVDQ,       W,x, None,None, V,x, vex4_unal), /* movdqu */
         {},
@@ -639,15 +639,15 @@ static void decode_0F10(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     static const X86OpEntry opcodes_0F10_reg[4] = {
         X86_OP_ENTRY3(MOVDQ,   V,x,  None,None, W,x, vex4_unal), /* MOVUPS */
         X86_OP_ENTRY3(MOVDQ,   V,x,  None,None, W,x, vex4_unal), /* MOVUPD */
-        X86_OP_ENTRY3(VMOVSS,  V,x,  H,x,       W,x, vex4),
-        X86_OP_ENTRY3(VMOVLPx, V,x,  H,x,       W,x, vex4), /* MOVSD */
+        X86_OP_ENTRY3(VMOVSS,  V,x,  H,x,       W,x, vex5),
+        X86_OP_ENTRY3(VMOVLPx, V,x,  H,x,       W,x, vex5), /* MOVSD */
     };
 
     static const X86OpEntry opcodes_0F10_mem[4] = {
         X86_OP_ENTRY3(MOVDQ,      V,x,  None,None, W,x,  vex4_unal), /* MOVUPS */
         X86_OP_ENTRY3(MOVDQ,      V,x,  None,None, W,x,  vex4_unal), /* MOVUPD */
-        X86_OP_ENTRY3(VMOVSS_ld,  V,x,  H,x,       M,ss, vex4),
-        X86_OP_ENTRY3(VMOVSD_ld,  V,x,  H,x,       M,sd, vex4),
+        X86_OP_ENTRY3(VMOVSS_ld,  V,x,  H,x,       M,ss, vex5),
+        X86_OP_ENTRY3(VMOVSD_ld,  V,x,  H,x,       M,sd, vex5),
     };
 
     if ((get_modrm(s, env) >> 6) == 3) {
@@ -662,15 +662,15 @@ static void decode_0F11(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     static const X86OpEntry opcodes_0F11_reg[4] = {
         X86_OP_ENTRY3(MOVDQ,   W,x,  None,None, V,x, vex4), /* MOVUPS */
         X86_OP_ENTRY3(MOVDQ,   W,x,  None,None, V,x, vex4), /* MOVUPD */
-        X86_OP_ENTRY3(VMOVSS,  W,x,  H,x,       V,x, vex4),
-        X86_OP_ENTRY3(VMOVLPx, W,x,  H,x,       V,q, vex4), /* MOVSD */
+        X86_OP_ENTRY3(VMOVSS,  W,x,  H,x,       V,x, vex5),
+        X86_OP_ENTRY3(VMOVLPx, W,x,  H,x,       V,q, vex5), /* MOVSD */
     };
 
     static const X86OpEntry opcodes_0F11_mem[4] = {
         X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex4), /* MOVUPS */
         X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex4), /* MOVUPD */
-        X86_OP_ENTRY3(VMOVSS_st,  M,ss, None,None, V,x, vex4),
-        X86_OP_ENTRY3(VMOVLPx_st, M,sd, None,None, V,x, vex4), /* MOVSD */
+        X86_OP_ENTRY3(VMOVSS_st,  M,ss, None,None, V,x, vex5),
+        X86_OP_ENTRY3(VMOVLPx_st, M,sd, None,None, V,x, vex5), /* MOVSD */
     };
 
     if ((get_modrm(s, env) >> 6) == 3) {
@@ -687,16 +687,16 @@ static void decode_0F12(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
          * Use dq for operand for compatibility with gen_MOVSD and
          * to allow VEX128 only.
          */
-        X86_OP_ENTRY3(VMOVLPx_ld, V,dq, H,dq,      M,q, vex4), /* MOVLPS */
-        X86_OP_ENTRY3(VMOVLPx_ld, V,dq, H,dq,      M,q, vex4), /* MOVLPD */
+        X86_OP_ENTRY3(VMOVLPx_ld, V,dq, H,dq,      M,q, vex5), /* MOVLPS */
+        X86_OP_ENTRY3(VMOVLPx_ld, V,dq, H,dq,      M,q, vex5), /* MOVLPD */
         X86_OP_ENTRY3(VMOVSLDUP,  V,x,  None,None, W,x, vex4 cpuid(SSE3)),
-        X86_OP_ENTRY3(VMOVDDUP,   V,x,  None,None, WM,q, vex4 cpuid(SSE3)), /* qq if VEX.256 */
+        X86_OP_ENTRY3(VMOVDDUP,   V,x,  None,None, WM,q, vex5 cpuid(SSE3)), /* qq if VEX.256 */
     };
     static const X86OpEntry opcodes_0F12_reg[4] = {
-        X86_OP_ENTRY3(VMOVHLPS,  V,dq, H,dq,       U,dq, vex4),
-        X86_OP_ENTRY3(VMOVLPx,   W,x,  H,x,        U,q,  vex4), /* MOVLPD */
+        X86_OP_ENTRY3(VMOVHLPS,  V,dq, H,dq,       U,dq, vex7),
+        X86_OP_ENTRY3(VMOVLPx,   W,x,  H,x,        U,q,  vex5), /* MOVLPD */
         X86_OP_ENTRY3(VMOVSLDUP, V,x,  None,None,  U,x,  vex4 cpuid(SSE3)),
-        X86_OP_ENTRY3(VMOVDDUP,  V,x,  None,None,  U,x,  vex4 cpuid(SSE3)),
+        X86_OP_ENTRY3(VMOVDDUP,  V,x,  None,None,  U,x,  vex5 cpuid(SSE3)),
     };
 
     if ((get_modrm(s, env) >> 6) == 3) {
@@ -716,15 +716,15 @@ static void decode_0F16(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
          * Operand 1 technically only reads the low 64 bits, but uses dq so that
          * it is easier to check for op0 == op1 in an endianness-neutral manner.
          */
-        X86_OP_ENTRY3(VMOVHPx_ld, V,dq, H,dq,      M,q, vex4), /* MOVHPS */
-        X86_OP_ENTRY3(VMOVHPx_ld, V,dq, H,dq,      M,q, vex4), /* MOVHPD */
+        X86_OP_ENTRY3(VMOVHPx_ld, V,dq, H,dq,      M,q, vex5), /* MOVHPS */
+        X86_OP_ENTRY3(VMOVHPx_ld, V,dq, H,dq,      M,q, vex5), /* MOVHPD */
         X86_OP_ENTRY3(VMOVSHDUP,  V,x,  None,None, W,x, vex4 cpuid(SSE3)),
         {},
     };
     static const X86OpEntry opcodes_0F16_reg[4] = {
         /* Same as above, operand 1 could be Hq if it wasn't for big-endian.  */
-        X86_OP_ENTRY3(VMOVLHPS,  V,dq, H,dq,      U,q, vex4),
-        X86_OP_ENTRY3(VMOVHPx,   V,x,  H,x,       U,x, vex4), /* MOVHPD */
+        X86_OP_ENTRY3(VMOVLHPS,  V,dq, H,dq,      U,q, vex7),
+        X86_OP_ENTRY3(VMOVHPx,   V,x,  H,x,       U,x, vex5), /* MOVHPD */
         X86_OP_ENTRY3(VMOVSHDUP, V,x,  None,None, U,x, vex4 cpuid(SSE3)),
         {},
     };
@@ -824,7 +824,7 @@ static void decode_0FE6(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     static const X86OpEntry opcodes_0FE6[4] = {
         {},
         X86_OP_ENTRY2(VCVTTPD2DQ,  V,x, W,x,      vex2),
-        X86_OP_ENTRY2(VCVTDQ2PD,   V,x, W,x,      vex2),
+        X86_OP_ENTRY2(VCVTDQ2PD,   V,x, W,x,      vex5),
         X86_OP_ENTRY2(VCVTPD2DQ,   V,x, W,x,      vex2),
     };
     *entry = *decode_by_prefix(s, opcodes_0FE6);
@@ -842,12 +842,12 @@ static const X86OpEntry opcodes_0F[256] = {
     [0x10] = X86_OP_GROUP0(0F10),
     [0x11] = X86_OP_GROUP0(0F11),
     [0x12] = X86_OP_GROUP0(0F12),
-    [0x13] = X86_OP_ENTRY3(VMOVLPx_st,  M,q, None,None, V,q,  vex4 p_00_66),
+    [0x13] = X86_OP_ENTRY3(VMOVLPx_st,  M,q, None,None, V,q,  vex5 p_00_66),
     [0x14] = X86_OP_ENTRY3(VUNPCKLPx,   V,x, H,x, W,x,        vex4 p_00_66),
     [0x15] = X86_OP_ENTRY3(VUNPCKHPx,   V,x, H,x, W,x,        vex4 p_00_66),
     [0x16] = X86_OP_GROUP0(0F16),
     /* Incorrectly listed as Mq,Vq in the manual */
-    [0x17] = X86_OP_ENTRY3(VMOVHPx_st,  M,q, None,None, V,dq, vex4 p_00_66),
+    [0x17] = X86_OP_ENTRY3(VMOVHPx_st,  M,q, None,None, V,dq, vex5 p_00_66),
 
     [0x50] = X86_OP_ENTRY3(MOVMSK,     G,y, None,None, U,x, vex7 p_00_66),
     [0x51] = X86_OP_GROUP3(sse_unary,  V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2), /* sqrtps */
-- 
2.39.2


