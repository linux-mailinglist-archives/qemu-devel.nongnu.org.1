Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFBD7D7897
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:31:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnHq-0001W5-Mx; Wed, 25 Oct 2023 19:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHm-0001Ui-CO
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHj-0004sD-C4
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZdRK/WWqi9wA0FxLGgTM0gvdLPEiIAVsBNDTlVOWnvE=;
 b=GCuggslokDdx/gww6S9g/ehLXnsCYw1XB1K94KDnW1+L34lkezGEx2DaASUYO5hvuPOCty
 xdytkKfowQ3ZLS+bfzSPuo1Wusgl4daj2yaJ+w/e1P1uIr+iRR1lYw0PY/K/mVFcmKIVrN
 577fN1/R8sf1alGUMWFlbRJUFgiwKis=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-OnMzlsYDM4KXksk2iPCy-Q-1; Wed, 25 Oct 2023 19:27:33 -0400
X-MC-Unique: OnMzlsYDM4KXksk2iPCy-Q-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-41cdbdbd8a5so4276911cf.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276452; x=1698881252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZdRK/WWqi9wA0FxLGgTM0gvdLPEiIAVsBNDTlVOWnvE=;
 b=Yh+bzc9XbbVq3lsYqQYISE3LuVAC9yTXfRlHhgoEHy82F6o4J55ceMOWlDQ4pFt72t
 HtkGpuifZY2oD3rwAxCnOBsb+HG7YmCJq8+rj1byvI1pphbK2eux3/Nh6MgaoR8ZeMaz
 qwi/ru6U0AWeNrSUcCTSPyzhZigg7xiZncvuWfEb15wnSziNTF8yXsmXRy1f7+38Zkoa
 Ki9IpyGmAA8CrgOli4JDwLC0W7YFNz+zF3aLc4daLU09Ik7d4DIFa+P1dbwWkpbf7GFg
 C6hBEjfN2Jjnm2Ip5xYU9LpZGKS8Xarweiwn7+AmUHKJZhueZqhZqGyPJo+pxvgC827M
 fd7g==
X-Gm-Message-State: AOJu0YzKkq1snLhN55K5qTrW7xNNkVX/EB0ZwRPClXW8BGX/bQdenq3c
 CG+0G/cz8n8qVniyHGjSYByk1ZZPf7XumRjMvyPxxZ0eYjRcizsH1YL4iNF/LN/5fITTM5WNN+Z
 2kCZrhXrhmWj/WiuSX4ELriy6I5wrRSZaAO3Ocw9Jz1MsavpcYBLe5GJT5PN+i4Qxe+5fdIjvOp
 s=
X-Received: by 2002:ac8:5ad5:0:b0:41c:d846:4eb with SMTP id
 d21-20020ac85ad5000000b0041cd84604ebmr21641281qtd.49.1698276451803; 
 Wed, 25 Oct 2023 16:27:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiJB9wNFC4j3vGbDoLm9le3oschKWjBWbcfvv13KGS32k4QhYfcEgedDJltcUWYhDNIkFi9Q==
X-Received: by 2002:ac8:5ad5:0:b0:41c:d846:4eb with SMTP id
 d21-20020ac85ad5000000b0041cd84604ebmr21641255qtd.49.1698276451303; 
 Wed, 25 Oct 2023 16:27:31 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 q4-20020ac87344000000b0041b12d5fd91sm4600978qtp.55.2023.10.25.16.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:27:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/24] target/i386: validate VEX.W for AVX instructions
Date: Thu, 26 Oct 2023 01:26:59 +0200
Message-ID: <20231025232718.89428-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025232718.89428-1-pbonzini@redhat.com>
References: <20231025232718.89428-1-pbonzini@redhat.com>
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

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 142 ++++++++++++++++++++++---------
 target/i386/tcg/decode-new.h     |   6 ++
 2 files changed, 107 insertions(+), 41 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 25c1dae55a4..2bdbb1bba0f 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -23,7 +23,11 @@
  * The decoder is mostly based on tables copied from the Intel SDM.  As
  * a result, most operand load and writeback is done entirely in common
  * table-driven code using the same operand type (X86_TYPE_*) and
- * size (X86_SIZE_*) codes used in the manual.
+ * size (X86_SIZE_*) codes used in the manual.  There are a few differences
+ * though.
+ *
+ * Vector operands
+ * ---------------
  *
  * The main difference is that the V, U and W types are extended to
  * cover MMX as well; if an instruction is like
@@ -43,6 +47,50 @@
  * There are a couple cases in which instructions (e.g. MOVD) write the
  * whole XMM or MM register but are established incorrectly in the manual
  * as "d" or "q".  These have to be fixed for the decoder to work correctly.
+ *
+ * VEX exception classes
+ * ---------------------
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
@@ -338,11 +386,11 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
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
@@ -363,14 +411,14 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
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
@@ -392,14 +440,15 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
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
@@ -408,11 +457,11 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
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
@@ -423,12 +472,13 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
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
@@ -562,18 +612,18 @@ static const X86OpEntry opcodes_0F3A[256] = {
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
@@ -583,7 +633,7 @@ static const X86OpEntry opcodes_0F3A[256] = {
     [0x41] = X86_OP_ENTRY4(VDDPD,      V,dq, H,dq, W,dq, vex2 cpuid(SSE41) p_66),
     [0x42] = X86_OP_ENTRY4(VMPSADBW,   V,x,  H,x,  W,x,  vex2 cpuid(SSE41) avx2_256 p_66),
     [0x44] = X86_OP_ENTRY4(PCLMULQDQ,  V,dq, H,dq, W,dq, vex4 cpuid(PCLMULQDQ) p_66),
-    [0x46] = X86_OP_ENTRY4(VPERM2x128, V,qq, H,qq, W,qq, vex6 cpuid(AVX2) p_66),
+    [0x46] = X86_OP_ENTRY4(VPERM2x128, V,qq, H,qq, W,qq, vex6 chk(W0) cpuid(AVX2) p_66),
 
     [0x60] = X86_OP_ENTRY4(PCMPESTRM,  None,None, V,dq, W,dq, vex4_unal cpuid(SSE42) p_66),
     [0x61] = X86_OP_ENTRY4(PCMPESTRI,  None,None, V,dq, W,dq, vex4_unal cpuid(SSE42) p_66),
@@ -606,16 +656,16 @@ static const X86OpEntry opcodes_0F3A[256] = {
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
 
     [0xcc] = X86_OP_ENTRY3(SHA1RNDS4,  V,dq, W,dq, I,b,  cpuid(SHA_NI)),
 
@@ -1505,8 +1555,6 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
         }
     }
 
-    /* TODO: instructions that require VEX.W=0 (Table 2-16) */
-
     switch (e->vex_class) {
     case 0:
         if (s->prefix & PREFIX_VEX) {
@@ -1592,9 +1640,21 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
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
index bbc9aea940d..e6c904a3192 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -147,6 +147,12 @@ typedef enum X86InsnCheck {
 
     /* Fault if VEX.L=1 */
     X86_CHECK_VEX128 = 64,
+
+    /* Fault if VEX.W=1 */
+    X86_CHECK_W0 = 128,
+
+    /* Fault if VEX.W=0 */
+    X86_CHECK_W1 = 256,
 } X86InsnCheck;
 
 typedef enum X86InsnSpecial {
-- 
2.41.0


