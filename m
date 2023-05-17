Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBF3706FD1
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:46:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLDk-00075f-I1; Wed, 17 May 2023 13:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDb-000727-M8
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDY-00041j-Jv
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M+LJ4nMmE0UUrO9wa4oiwOT/ScyWbCv2g8woZUrOBQQ=;
 b=DD+65PJhpx11k0s8ijBiEQvVTZYokvW1ndZqWjkomgZ6/7WuN8aU5zbWCRr6zAJS/nQxCN
 KGszOQQe2q9fJFAKMHq23G9iCkfmbkrOB3ecuiL5GuggM+GRifVFHoDhxEmL3XhEHU8LwX
 mV5cvd3kcw8J3s01S3YNFHkzhsRT1l4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-c-RbPZFQONaAfBtnXBR8jA-1; Wed, 17 May 2023 13:45:37 -0400
X-MC-Unique: c-RbPZFQONaAfBtnXBR8jA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f421cfb4beso4797495e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345535; x=1686937535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M+LJ4nMmE0UUrO9wa4oiwOT/ScyWbCv2g8woZUrOBQQ=;
 b=Dj/GTyelBoliH8ZapnHUvHj+uJ4LeiZhtZhSZwlQHq7R+25TnTZgXthk54djvpxo/j
 Roq46NhVyexvI9aWcJN/grt2pBSePSZ1sO6n7jFpKOcLj3qAiVMkD/cQ1cVqGUKQ/a5+
 //UaBBxhqvIUKG9BXe6b9hvDaL6rz9Hdo/91Y2dxx5P+Cu3VobzaEEw9Tt/VylzI7hzw
 zLm+tQ9kAwzPP3MaSPWiroHN4r+7xFNxLrXbhcTf7LNGQ/NhprGdyz4m1tclAcDgsGYx
 l8QvyAEJkUgcFDw0Xk58i+mWz9oPgOq2AlePDmqRtEeYewxWlX95KRdzXoXHwpG1T/vI
 ouqA==
X-Gm-Message-State: AC+VfDwaJQeYZ2JDDAThiydeZKnJ8Br0sGNGhzoakSdW6CRYKGs5RHIV
 39qkVmpk/f6wHOaZefme7+WrjBSNxQ2mbzcqldztUTRFuH8yw+tfb3HGJ/8CIQ8UUoTgOk9++/g
 1PKSf8bHHsgWtdR1y0UD6/ZeT9SzmrosMYjecwpo5/DBLk1V1Ixiodk9344k4qgk8HEMCALLysG
 Y=
X-Received: by 2002:a05:600c:b42:b0:3f4:f0c2:125 with SMTP id
 k2-20020a05600c0b4200b003f4f0c20125mr14058388wmr.23.1684345534712; 
 Wed, 17 May 2023 10:45:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4iLNlKhenAyeibHEILjoFWvJU/Yn+hOIx5/rHBWVfgnHydzb7U2tKmwYXDlcrlJhAhoeKLvg==
X-Received: by 2002:a05:600c:b42:b0:3f4:f0c2:125 with SMTP id
 k2-20020a05600c0b4200b003f4f0c20125mr14058375wmr.23.1684345534351; 
 Wed, 17 May 2023 10:45:34 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a05600c224300b003f17848673fsm2868969wmm.27.2023.05.17.10.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:45:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ricky Zhou <ricky@rzhou.org>
Subject: [PULL 07/68] target/i386: Fix exception classes for SSE/AVX
 instructions.
Date: Wed, 17 May 2023 19:44:19 +0200
Message-Id: <20230517174520.887405-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
---
 target/i386/tcg/decode-new.c.inc | 46 ++++++++++++++++----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index e0f25e7fd8ed..1a789201f740 100644
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
2.40.1


