Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B77B7CF5A6
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:48:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQYW-0006X4-KR; Thu, 19 Oct 2023 06:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYP-0006FO-Uo
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYN-0006CE-99
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697712417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QFLukNUS7TwhCPaS3HQhDICPcAy2Wkea09tTCaxB9eE=;
 b=UU5wuzu3pPl6nbtKXihkHM0sn7huKlreMgBHthY4aFyX+Ri0r1tATrR+M10bN2fEYuIbpA
 BC/W3PjQeHvdRmsJNimohY2r8V1h4ELYqgZ5YpezAcyezM1JHy+FwRZBbpaym6W3vGyQHS
 D01TJLymw46gbAhsBgjW9wfQDIUXJqU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-En7GdAJlMc-SHW-j_WbPRQ-1; Thu, 19 Oct 2023 06:46:56 -0400
X-MC-Unique: En7GdAJlMc-SHW-j_WbPRQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9ba247e03aeso548530166b.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697712414; x=1698317214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QFLukNUS7TwhCPaS3HQhDICPcAy2Wkea09tTCaxB9eE=;
 b=HHtw5vGKMnkOcv5smGqODCNCAtV5boalcMB5D3FvL7DsC2gKrq9Qy1/h+irIYBlDZ2
 vvtliPEb/GaR0pFmmp6+PO4islElAGmSe4IzMf5Y8mGj/YIptp1nMYEHoGiIoAIxi50t
 Y7xFuJNUOXIUD0kAGvlYJDyrUN3+ysQilXV7wDOrB8wyrUi1+WrcsZ0hsRvLbcyK7XMM
 BeHPdO14mn2y9IAyikFiJ1dYU20+rUQn8/vGQy3V3UXQUMBvdOG8CC3/nyFzabm4g7Te
 F5l2gSc0XntP9/z/RBdxzoBxXSOelQo4vYYb/8wHs/iUeqACeD/ZCkJ6XO72UC+ly+Kh
 VZHw==
X-Gm-Message-State: AOJu0Yyc8TXAgqzM4Fw1zv1ByRzEiksC4QY3jRJrdu8uOZO5A+Dnzd+9
 PXUYi3CxPxLPdKKRbDODQsEsqMfJ6TKbu0QRBy7RXwF2uRtToPpI9XHmbVdykmMLB5rB9i/TjHj
 9CsBnaZ0OOsVFXmsBurLOlYM9OdJvrlG8ABUzKW9EtvwtcGli/zApzM2UUycwrtPUfAU4OawKL+
 U=
X-Received: by 2002:a17:907:a0b:b0:9c3:e158:316a with SMTP id
 bb11-20020a1709070a0b00b009c3e158316amr1421015ejc.68.1697712414275; 
 Thu, 19 Oct 2023 03:46:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMEykUrgLruNoEpOvG6cKU6BjQGmBhr2HT4ovXHzZPrU9xcBFHiFwn8kKjnfw89WYlr0LRBw==
X-Received: by 2002:a17:907:a0b:b0:9c3:e158:316a with SMTP id
 bb11-20020a1709070a0b00b009c3e158316amr1420988ejc.68.1697712413553; 
 Thu, 19 Oct 2023 03:46:53 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 lh22-20020a170906f8d600b009b94c545678sm3270289ejb.153.2023.10.19.03.46.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:46:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/19] target/i386: validate VEX.W for AVX instructions
Date: Thu, 19 Oct 2023 12:46:31 +0200
Message-ID: <20231019104648.389942-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019104648.389942-1-pbonzini@redhat.com>
References: <20231019104648.389942-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Instructions in VEX exception class 6 generally look at the value of
VEX.W.  Note that the manual places some instructions incorrectly in
class 4, for example VPERMQ which has no non-VEX encoding and no legacy
SSE analogue.  AMD does a mess of its own, as documented in the comment
that this patch adds.

Most of them are checked for VEX.W=0, and are listed in the manual
(though with an omission) in table 2-16; VPERMQ and VPERMPD check for
VEX.W=1, which is only listed in the instruction description.  Others,
such as VPSRLV, VPSLLV and the FMA3 instructions, use VEX.W to switch
between a 32-bit and 64-bit operation.

Fix more of the class 4/class 6 mismatches, and implement the check for
VEX.W in TCG.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 133 +++++++++++++++++++++----------
 target/i386/tcg/decode-new.h     |   6 ++
 2 files changed, 99 insertions(+), 40 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 790339eaf25..850271e0898 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -43,6 +43,47 @@
  * There are a couple cases in which instructions (e.g. MOVD) write the
  * whole XMM or MM register but are established incorrectly in the manual
  * as "d" or "q".  These have to be fixed for the decoder to work correctly.
+ *
+ * Speaking about imprecisions in the manual, the decoder treats all
+ * exception-class 4 instructions as having an optional VEX prefix, and
+ * all exception-class 6 instructions as having a mandatory VEX prefix.
+ * This is true except for a dozen instructions; these are in exception
+ * class 4 but do not ignore the VEX.W bit (which does not even exist
+ * without a VEX prefix).  These instructions are mostly listed in Intel's
+ * table 2-16, but with a few exceptions.
+ *
+ * The AMD manual has more precise subclasses for exceptions, and unlike Intel
+ * they list the VEX.W requirements in the exception classes as well (except
+ * when they don't).  AMD describes class 6 as "AVX Mixed Memory Argument"
+ * without defining what a mixed memory argument is, but still use 4 as the
+ * primary exception class... except when they don't.
+ *
+ * The summary is:
+ *                       Intel     AMD         VEX.W           note
+ * -------------------------------------------------------------------
+ * vpblendd              4         4J          0
+ * vpblendvb             4         4E-X        0               (*)
+ * vpbroadcastq          6         6D          0               (+)
+ * vpermd/vpermps        4         4H          0               (§)
+ * vpermq/vpermpd        4         4H-1        1               (§)
+ * vpermilpd/vpermilps   4         6E          0               (^)
+ * vpmaskmovd            6         4K          significant     (^)
+ * vpsllv                4         4K          significant
+ * vpsrav                4         4J          0
+ * vpsrlv                4         4K          significant
+ * vtestps/vtestpd       4         4G          0
+ *
+ *    (*)  AMD lists VPBLENDVB as related to SSE4.1 PBLENDVB, which may
+ *         explain why it is considered exception class 4.  However,
+ *         Intel says that VEX-only instructions should be in class 6...
+ *
+ *    (+)  Not found in Intel's table 2-16
+ *
+ *    (§)  4H and 4H-1 do not mention VEX.W requirements, which are
+ *         however present in the description of the instruction
+ *
+ *    (^)  these are the two cases in which Intel and AMD disagree on the
+ *         primary exception class
  */
 
 #define X86_OP_NONE { 0 },
@@ -338,11 +379,11 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
     [0x07] = X86_OP_ENTRY3(PHSUBSW,   V,x,  H,x,   W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
 
     [0x10] = X86_OP_ENTRY2(PBLENDVB,  V,x,         W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
-    [0x13] = X86_OP_ENTRY2(VCVTPH2PS, V,x,         W,xh, vex11 cpuid(F16C) p_66),
+    [0x13] = X86_OP_ENTRY2(VCVTPH2PS, V,x,         W,xh, vex11 chk(W0) cpuid(F16C) p_66),
     [0x14] = X86_OP_ENTRY2(BLENDVPS,  V,x,         W,x,  vex4 cpuid(SSE41) p_66),
     [0x15] = X86_OP_ENTRY2(BLENDVPD,  V,x,         W,x,  vex4 cpuid(SSE41) p_66),
     /* Listed incorrectly as type 4 */
-    [0x16] = X86_OP_ENTRY3(VPERMD,    V,qq, H,qq,      W,qq,  vex6 cpuid(AVX2) p_66),
+    [0x16] = X86_OP_ENTRY3(VPERMD,    V,qq, H,qq,      W,qq,  vex6 chk(W0) cpuid(AVX2) p_66), /* vpermps */
     [0x17] = X86_OP_ENTRY3(VPTEST,    None,None, V,x,  W,x,   vex4 cpuid(SSE41) p_66),
 
     /*
@@ -363,14 +404,14 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
     [0x33] = X86_OP_ENTRY3(VPMOVZXWD, V,x,  None,None, W,q,   vex5 cpuid(SSE41) avx_movx avx2_256 p_66),
     [0x34] = X86_OP_ENTRY3(VPMOVZXWQ, V,x,  None,None, W,d,   vex5 cpuid(SSE41) avx_movx avx2_256 p_66),
     [0x35] = X86_OP_ENTRY3(VPMOVZXDQ, V,x,  None,None, W,q,   vex5 cpuid(SSE41) avx_movx avx2_256 p_66),
-    [0x36] = X86_OP_ENTRY3(VPERMD,    V,qq, H,qq,      W,qq,  vex6 cpuid(AVX2) p_66),
+    [0x36] = X86_OP_ENTRY3(VPERMD,    V,qq, H,qq,      W,qq,  vex6 chk(W0) cpuid(AVX2) p_66),
     [0x37] = X86_OP_ENTRY3(PCMPGTQ,   V,x,  H,x,       W,x,   vex4 cpuid(SSE42) avx2_256 p_66),
 
     [0x40] = X86_OP_ENTRY3(PMULLD,      V,x,  H,x,       W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
     [0x41] = X86_OP_ENTRY3(VPHMINPOSUW, V,dq, None,None, W,dq, vex4 cpuid(SSE41) p_66),
     /* Listed incorrectly as type 4 */
     [0x45] = X86_OP_ENTRY3(VPSRLV,      V,x,  H,x,       W,x,  vex6 cpuid(AVX2) p_66),
-    [0x46] = X86_OP_ENTRY3(VPSRAV,      V,x,  H,x,       W,x,  vex6 cpuid(AVX2) p_66),
+    [0x46] = X86_OP_ENTRY3(VPSRAV,      V,x,  H,x,       W,x,  vex6 chk(W0) cpuid(AVX2) p_66),
     [0x47] = X86_OP_ENTRY3(VPSLLV,      V,x,  H,x,       W,x,  vex6 cpuid(AVX2) p_66),
 
     [0x90] = X86_OP_ENTRY3(VPGATHERD, V,x,  H,x,  M,d,  vex12 cpuid(AVX2) p_66), /* vpgatherdd/q */
@@ -392,14 +433,15 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
     [0x09] = X86_OP_ENTRY3(PSIGNW,    V,x,        H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
     [0x0a] = X86_OP_ENTRY3(PSIGND,    V,x,        H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
     [0x0b] = X86_OP_ENTRY3(PMULHRSW,  V,x,        H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
-    [0x0c] = X86_OP_ENTRY3(VPERMILPS, V,x,        H,x,  W,x,  vex4 cpuid(AVX) p_00_66),
-    [0x0d] = X86_OP_ENTRY3(VPERMILPD, V,x,        H,x,  W,x,  vex4 cpuid(AVX) p_66),
-    [0x0e] = X86_OP_ENTRY3(VTESTPS,   None,None,  V,x,  W,x,  vex4 cpuid(AVX) p_66),
-    [0x0f] = X86_OP_ENTRY3(VTESTPD,   None,None,  V,x,  W,x,  vex4 cpuid(AVX) p_66),
+    /* Listed incorrectly as type 4 */
+    [0x0c] = X86_OP_ENTRY3(VPERMILPS, V,x,        H,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_00_66),
+    [0x0d] = X86_OP_ENTRY3(VPERMILPD, V,x,        H,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
+    [0x0e] = X86_OP_ENTRY3(VTESTPS,   None,None,  V,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
+    [0x0f] = X86_OP_ENTRY3(VTESTPD,   None,None,  V,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
 
-    [0x18] = X86_OP_ENTRY3(VPBROADCASTD,   V,x,  None,None, W,d,  vex6 cpuid(AVX) p_66), /* vbroadcastss */
-    [0x19] = X86_OP_ENTRY3(VPBROADCASTQ,   V,qq, None,None, W,q,  vex6 cpuid(AVX) p_66), /* vbroadcastsd */
-    [0x1a] = X86_OP_ENTRY3(VBROADCASTx128, V,qq, None,None, WM,dq,vex6 cpuid(AVX) p_66),
+    [0x18] = X86_OP_ENTRY3(VPBROADCASTD,   V,x,  None,None, W,d,  vex6 chk(W0) cpuid(AVX) p_66), /* vbroadcastss */
+    [0x19] = X86_OP_ENTRY3(VPBROADCASTQ,   V,qq, None,None, W,q,  vex6 chk(W0) cpuid(AVX) p_66), /* vbroadcastsd */
+    [0x1a] = X86_OP_ENTRY3(VBROADCASTx128, V,qq, None,None, WM,dq,vex6 chk(W0) cpuid(AVX) p_66),
     [0x1c] = X86_OP_ENTRY3(PABSB,          V,x,  None,None, W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
     [0x1d] = X86_OP_ENTRY3(PABSW,          V,x,  None,None, W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
     [0x1e] = X86_OP_ENTRY3(PABSD,          V,x,  None,None, W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
@@ -408,11 +450,11 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
     [0x29] = X86_OP_ENTRY3(PCMPEQQ,       V,x, H,x,       W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
     [0x2a] = X86_OP_ENTRY3(MOVDQ,         V,x, None,None, WM,x, vex1 cpuid(SSE41) avx2_256 p_66), /* movntdqa */
     [0x2b] = X86_OP_ENTRY3(VPACKUSDW,     V,x, H,x,       W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
-    [0x2c] = X86_OP_ENTRY3(VMASKMOVPS,    V,x, H,x,       WM,x, vex6 cpuid(AVX) p_66),
-    [0x2d] = X86_OP_ENTRY3(VMASKMOVPD,    V,x, H,x,       WM,x, vex6 cpuid(AVX) p_66),
+    [0x2c] = X86_OP_ENTRY3(VMASKMOVPS,    V,x, H,x,       WM,x, vex6 chk(W0) cpuid(AVX) p_66),
+    [0x2d] = X86_OP_ENTRY3(VMASKMOVPD,    V,x, H,x,       WM,x, vex6 chk(W0) cpuid(AVX) p_66),
     /* Incorrectly listed as Mx,Hx,Vx in the manual */
-    [0x2e] = X86_OP_ENTRY3(VMASKMOVPS_st, M,x, V,x,       H,x,  vex6 cpuid(AVX) p_66),
-    [0x2f] = X86_OP_ENTRY3(VMASKMOVPD_st, M,x, V,x,       H,x,  vex6 cpuid(AVX) p_66),
+    [0x2e] = X86_OP_ENTRY3(VMASKMOVPS_st, M,x, V,x,       H,x,  vex6 chk(W0) cpuid(AVX) p_66),
+    [0x2f] = X86_OP_ENTRY3(VMASKMOVPD_st, M,x, V,x,       H,x,  vex6 chk(W0) cpuid(AVX) p_66),
 
     [0x38] = X86_OP_ENTRY3(PMINSB,        V,x,  H,x, W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
     [0x39] = X86_OP_ENTRY3(PMINSD,        V,x,  H,x, W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
@@ -423,12 +465,13 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
     [0x3e] = X86_OP_ENTRY3(PMAXUW,        V,x,  H,x, W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
     [0x3f] = X86_OP_ENTRY3(PMAXUD,        V,x,  H,x, W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
 
-    [0x58] = X86_OP_ENTRY3(VPBROADCASTD,   V,x,  None,None, W,d,  vex6 cpuid(AVX2) p_66),
-    [0x59] = X86_OP_ENTRY3(VPBROADCASTQ,   V,x,  None,None, W,q,  vex6 cpuid(AVX2) p_66),
-    [0x5a] = X86_OP_ENTRY3(VBROADCASTx128, V,qq, None,None, WM,dq,vex6 cpuid(AVX2) p_66),
+    /* VPBROADCASTQ not listed as W0 in table 2-16 */
+    [0x58] = X86_OP_ENTRY3(VPBROADCASTD,   V,x,  None,None, W,d,  vex6 chk(W0) cpuid(AVX2) p_66),
+    [0x59] = X86_OP_ENTRY3(VPBROADCASTQ,   V,x,  None,None, W,q,  vex6 chk(W0) cpuid(AVX2) p_66),
+    [0x5a] = X86_OP_ENTRY3(VBROADCASTx128, V,qq, None,None, WM,dq,vex6 chk(W0) cpuid(AVX2) p_66),
 
-    [0x78] = X86_OP_ENTRY3(VPBROADCASTB,   V,x,  None,None, W,b,  vex6 cpuid(AVX2) p_66),
-    [0x79] = X86_OP_ENTRY3(VPBROADCASTW,   V,x,  None,None, W,w,  vex6 cpuid(AVX2) p_66),
+    [0x78] = X86_OP_ENTRY3(VPBROADCASTB,   V,x,  None,None, W,b,  vex6 chk(W0) cpuid(AVX2) p_66),
+    [0x79] = X86_OP_ENTRY3(VPBROADCASTW,   V,x,  None,None, W,w,  vex6 chk(W0) cpuid(AVX2) p_66),
 
     [0x8c] = X86_OP_ENTRY3(VPMASKMOV,    V,x,  H,x, WM,x, vex6 cpuid(AVX2) p_66),
     [0x8e] = X86_OP_ENTRY3(VPMASKMOV_st, M,x,  V,x, H,x,  vex6 cpuid(AVX2) p_66),
@@ -555,18 +598,18 @@ static const X86OpEntry opcodes_0F3A[256] = {
      * Also the "qq" instructions are sometimes omitted by Table 2-17, but are VEX256
      * only.
      */
-    [0x00] = X86_OP_ENTRY3(VPERMQ,      V,qq, W,qq, I,b,  vex6 cpuid(AVX2) p_66),
-    [0x01] = X86_OP_ENTRY3(VPERMQ,      V,qq, W,qq, I,b,  vex6 cpuid(AVX2) p_66), /* VPERMPD */
-    [0x02] = X86_OP_ENTRY4(VBLENDPS,    V,x,  H,x,  W,x,  vex6 cpuid(AVX2) p_66), /* VPBLENDD */
-    [0x04] = X86_OP_ENTRY3(VPERMILPS_i, V,x,  W,x,  I,b,  vex6 cpuid(AVX) p_66),
-    [0x05] = X86_OP_ENTRY3(VPERMILPD_i, V,x,  W,x,  I,b,  vex6 cpuid(AVX) p_66),
-    [0x06] = X86_OP_ENTRY4(VPERM2x128,  V,qq, H,qq, W,qq, vex6 cpuid(AVX) p_66),
+    [0x00] = X86_OP_ENTRY3(VPERMQ,      V,qq, W,qq, I,b,  vex6 chk(W1) cpuid(AVX2) p_66),
+    [0x01] = X86_OP_ENTRY3(VPERMQ,      V,qq, W,qq, I,b,  vex6 chk(W1) cpuid(AVX2) p_66), /* VPERMPD */
+    [0x02] = X86_OP_ENTRY4(VBLENDPS,    V,x,  H,x,  W,x,  vex6 chk(W0) cpuid(AVX2) p_66), /* VPBLENDD */
+    [0x04] = X86_OP_ENTRY3(VPERMILPS_i, V,x,  W,x,  I,b,  vex6 chk(W0) cpuid(AVX) p_66),
+    [0x05] = X86_OP_ENTRY3(VPERMILPD_i, V,x,  W,x,  I,b,  vex6 chk(W0) cpuid(AVX) p_66),
+    [0x06] = X86_OP_ENTRY4(VPERM2x128,  V,qq, H,qq, W,qq, vex6 chk(W0) cpuid(AVX) p_66),
 
     [0x14] = X86_OP_ENTRY3(PEXTRB,     E,b,  V,dq, I,b,  vex5 cpuid(SSE41) zext0 p_66),
     [0x15] = X86_OP_ENTRY3(PEXTRW,     E,w,  V,dq, I,b,  vex5 cpuid(SSE41) zext0 p_66),
     [0x16] = X86_OP_ENTRY3(PEXTR,      E,y,  V,dq, I,b,  vex5 cpuid(SSE41) p_66),
     [0x17] = X86_OP_ENTRY3(VEXTRACTPS, E,d,  V,dq, I,b,  vex5 cpuid(SSE41) p_66),
-    [0x1d] = X86_OP_ENTRY3(VCVTPS2PH,  W,xh, V,x,  I,b,  vex11 cpuid(F16C) p_66),
+    [0x1d] = X86_OP_ENTRY3(VCVTPS2PH,  W,xh, V,x,  I,b,  vex11 chk(W0) cpuid(F16C) p_66),
 
     [0x20] = X86_OP_ENTRY4(PINSRB,     V,dq, H,dq, E,b,  vex5 cpuid(SSE41) zext2 p_66),
     [0x21] = X86_OP_GROUP0(VINSERTPS),
@@ -576,7 +619,7 @@ static const X86OpEntry opcodes_0F3A[256] = {
     [0x41] = X86_OP_ENTRY4(VDDPD,      V,dq, H,dq, W,dq, vex2 cpuid(SSE41) p_66),
     [0x42] = X86_OP_ENTRY4(VMPSADBW,   V,x,  H,x,  W,x,  vex2 cpuid(SSE41) avx2_256 p_66),
     [0x44] = X86_OP_ENTRY4(PCLMULQDQ,  V,dq, H,dq, W,dq, vex4 cpuid(PCLMULQDQ) p_66),
-    [0x46] = X86_OP_ENTRY4(VPERM2x128, V,qq, H,qq, W,qq, vex6 cpuid(AVX2) p_66),
+    [0x46] = X86_OP_ENTRY4(VPERM2x128, V,qq, H,qq, W,qq, vex6 chk(W0) cpuid(AVX2) p_66),
 
     [0x60] = X86_OP_ENTRY4(PCMPESTRM,  None,None, V,dq, W,dq, vex4_unal cpuid(SSE42) p_66),
     [0x61] = X86_OP_ENTRY4(PCMPESTRI,  None,None, V,dq, W,dq, vex4_unal cpuid(SSE42) p_66),
@@ -599,16 +642,16 @@ static const X86OpEntry opcodes_0F3A[256] = {
     [0x0e] = X86_OP_ENTRY4(VPBLENDW,   V,x,  H,x,  W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
     [0x0f] = X86_OP_ENTRY4(PALIGNR,    V,x,  H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
 
-    [0x18] = X86_OP_ENTRY4(VINSERTx128,  V,qq, H,qq, W,qq, vex6 cpuid(AVX) p_66),
-    [0x19] = X86_OP_ENTRY3(VEXTRACTx128, W,dq, V,qq, I,b,  vex6 cpuid(AVX) p_66),
+    [0x18] = X86_OP_ENTRY4(VINSERTx128,  V,qq, H,qq, W,qq, vex6 chk(W0) cpuid(AVX) p_66),
+    [0x19] = X86_OP_ENTRY3(VEXTRACTx128, W,dq, V,qq, I,b,  vex6 chk(W0) cpuid(AVX) p_66),
 
-    [0x38] = X86_OP_ENTRY4(VINSERTx128,  V,qq, H,qq, W,qq, vex6 cpuid(AVX2) p_66),
-    [0x39] = X86_OP_ENTRY3(VEXTRACTx128, W,dq, V,qq, I,b,  vex6 cpuid(AVX2) p_66),
+    [0x38] = X86_OP_ENTRY4(VINSERTx128,  V,qq, H,qq, W,qq, vex6 chk(W0) cpuid(AVX2) p_66),
+    [0x39] = X86_OP_ENTRY3(VEXTRACTx128, W,dq, V,qq, I,b,  vex6 chk(W0) cpuid(AVX2) p_66),
 
     /* Listed incorrectly as type 4 */
-    [0x4a] = X86_OP_ENTRY4(VBLENDVPS, V,x,  H,x,  W,x,   vex6 cpuid(AVX) p_66),
-    [0x4b] = X86_OP_ENTRY4(VBLENDVPD, V,x,  H,x,  W,x,   vex6 cpuid(AVX) p_66),
-    [0x4c] = X86_OP_ENTRY4(VPBLENDVB, V,x,  H,x,  W,x,   vex6 cpuid(AVX) p_66 avx2_256),
+    [0x4a] = X86_OP_ENTRY4(VBLENDVPS, V,x,  H,x,  W,x,   vex6 chk(W0) cpuid(AVX) p_66),
+    [0x4b] = X86_OP_ENTRY4(VBLENDVPD, V,x,  H,x,  W,x,   vex6 chk(W0) cpuid(AVX) p_66),
+    [0x4c] = X86_OP_ENTRY4(VPBLENDVB, V,x,  H,x,  W,x,   vex6 chk(W0) cpuid(AVX) p_66 avx2_256),
 
     [0xdf] = X86_OP_ENTRY3(VAESKEYGEN, V,dq, W,dq, I,b,  vex4 cpuid(AES) p_66),
 
@@ -1494,8 +1537,6 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
         }
     }
 
-    /* TODO: instructions that require VEX.W=0 (Table 2-16) */
-
     switch (e->vex_class) {
     case 0:
         if (s->prefix & PREFIX_VEX) {
@@ -1581,9 +1622,21 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
         goto illegal;
     }
 
-    if (e->check & X86_CHECK_VEX128) {
-        if (s->vex_l) {
-            goto illegal;
+    if (e->check) {
+        if (e->check & X86_CHECK_VEX128) {
+            if (s->vex_l) {
+                goto illegal;
+            }
+        }
+        if (e->check & X86_CHECK_W0) {
+            if (s->vex_w) {
+                goto illegal;
+            }
+        }
+        if (e->check & X86_CHECK_W1) {
+            if (!s->vex_w) {
+                goto illegal;
+            }
         }
     }
     return true;
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 631d39220bb..ae987dfe0ba 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -144,6 +144,12 @@ typedef enum X86InsnCheck {
 
     /* Fault if VEX.L=1 */
     X86_CHECK_VEX128 = 32,
+
+    /* Fault if VEX.W=1 */
+    X86_CHECK_W0 = 64,
+
+    /* Fault if VEX.W=0 */
+    X86_CHECK_W1 = 128,
 } X86InsnCheck;
 
 typedef enum X86InsnSpecial {
-- 
2.41.0


