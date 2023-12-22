Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7127E81CE64
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:20:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGk4s-00018P-Co; Fri, 22 Dec 2023 13:16:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4U-0000yp-Cl
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4S-0006Bo-8U
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703268987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hzKk/J2M9yyXPE2PbgbVyaLavaa9gmxtcGmrHFxYkNA=;
 b=gmmn97HIJaCyEZ92pR132eu1Q0EOMFnm2b7bCth+r3lYOKFblrK/St56uiAD55l+Hk8vUx
 9NtTF9b3MKgzQ/50prS3fhiNbfnSV+T2IZuIaSmvUbky06JJyNBHhAf9d0x26aKlCAiukL
 rAmeSJSjGZDRYtfkN9JuOO3MuAATcjc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-43xoXPMlPxy68R2LKmTChQ-1; Fri, 22 Dec 2023 13:16:25 -0500
X-MC-Unique: 43xoXPMlPxy68R2LKmTChQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5545ab4864aso417465a12.0
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:16:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703268984; x=1703873784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hzKk/J2M9yyXPE2PbgbVyaLavaa9gmxtcGmrHFxYkNA=;
 b=Gh8wbwZGo1T3spIEiofHfSKAUC067oDdfg+ZK0Cyjp9SWZYFmeDjQMeemZwAxexWJ4
 e/4sZ1HmNxlVSyI0v9Z1vRoHk4aCgUTrckaX2m0wCuVAFvXuDQ41pp7FBuf3eleL/6+y
 UK/W5HY1RfuRBZ4hRfjkM8KZy4Ibq7J7ufxgEY2TIAaTnLOp20kqFZluDRLDOB08uopG
 eKmEPea5cR5kowTIPwXtKvjsLa9WMCzkxnOXQO+w0a4t62BIUQzdmDrETlfnJlFOG0HP
 LeDV748cgcYIBy5PuooUhZGjnnbpag48163ol1lCs2+sQPlkiVdoFqkXUp+o1i77FNC3
 /uJQ==
X-Gm-Message-State: AOJu0Ywwx1wUcPURea0zQBNGOVf/CzOV9L193ZKknbtJlvhmVqM5Btj2
 DA7zCEnGHHwZI4mQSkVph4+OlJh1upi9MOXsLpYUlK0NCvIDea1s2E2Dq4+SqrhXXXvnji1y5bV
 fPHa8YclWVkLKnhh0k2d+odCSkIT2tcsM690CnHGJFktZikA8LrLwFeit7kt9yhTorW0xAnpB5l
 N+6EUsHpY=
X-Received: by 2002:a50:8e5d:0:b0:552:7433:23ee with SMTP id
 29-20020a508e5d000000b00552743323eemr919403edx.0.1703268983808; 
 Fri, 22 Dec 2023 10:16:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHz5UMtXNWJ6NUBBIabT956j0XDN0h+gYkaV8Wd9msEmcveeZuzDehlXjT9kNlhW22s4Qn03g==
X-Received: by 2002:a50:8e5d:0:b0:552:7433:23ee with SMTP id
 29-20020a508e5d000000b00552743323eemr919397edx.0.1703268983523; 
 Fri, 22 Dec 2023 10:16:23 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 o6-20020a056402444600b0055473af90a6sm404752edb.0.2023.12.22.10.16.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:16:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/22] target/i386: rename zext0/zext2 and make them closer to
 the manual
Date: Fri, 22 Dec 2023 19:15:50 +0100
Message-ID: <20231222181603.174137-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222181603.174137-1-pbonzini@redhat.com>
References: <20231222181603.174137-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

X86_SPECIAL_ZExtOp0 and X86_SPECIAL_ZExtOp2 are poorly named; they are a hack
that is needed by scalar insertion and extraction instructions, and not really
related to zero extension: for PEXTR the zero extension is done by the generation
functions, for PINSR the high bits are not used at all and in fact are *not*
filled with zeroes when loaded into s->T1.

Rename the values to match the effect described in the manual, and explain
better in the comments.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 16 ++++++++--------
 target/i386/tcg/decode-new.h     | 17 +++++++++++++----
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 5eb2e9d0224..00fdb243857 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -153,8 +153,8 @@
 #define xchg .special = X86_SPECIAL_Locked,
 #define lock .special = X86_SPECIAL_HasLock,
 #define mmx .special = X86_SPECIAL_MMX,
-#define zext0 .special = X86_SPECIAL_ZExtOp0,
-#define zext2 .special = X86_SPECIAL_ZExtOp2,
+#define op0_Rd .special = X86_SPECIAL_Op0_Rd,
+#define op2_Ry .special = X86_SPECIAL_Op2_Ry,
 #define avx_movx .special = X86_SPECIAL_AVXExtMov,
 
 #define vex1 .vex_class = 1,
@@ -632,13 +632,13 @@ static const X86OpEntry opcodes_0F3A[256] = {
     [0x05] = X86_OP_ENTRY3(VPERMILPD_i, V,x,  W,x,  I,b,  vex6 chk(W0) cpuid(AVX) p_66),
     [0x06] = X86_OP_ENTRY4(VPERM2x128,  V,qq, H,qq, W,qq, vex6 chk(W0) cpuid(AVX) p_66),
 
-    [0x14] = X86_OP_ENTRY3(PEXTRB,     E,b,  V,dq, I,b,  vex5 cpuid(SSE41) zext0 p_66),
-    [0x15] = X86_OP_ENTRY3(PEXTRW,     E,w,  V,dq, I,b,  vex5 cpuid(SSE41) zext0 p_66),
+    [0x14] = X86_OP_ENTRY3(PEXTRB,     E,b,  V,dq, I,b,  vex5 cpuid(SSE41) op0_Rd p_66),
+    [0x15] = X86_OP_ENTRY3(PEXTRW,     E,w,  V,dq, I,b,  vex5 cpuid(SSE41) op0_Rd p_66),
     [0x16] = X86_OP_ENTRY3(PEXTR,      E,y,  V,dq, I,b,  vex5 cpuid(SSE41) p_66),
     [0x17] = X86_OP_ENTRY3(VEXTRACTPS, E,d,  V,dq, I,b,  vex5 cpuid(SSE41) p_66),
     [0x1d] = X86_OP_ENTRY3(VCVTPS2PH,  W,xh, V,x,  I,b,  vex11 chk(W0) cpuid(F16C) p_66),
 
-    [0x20] = X86_OP_ENTRY4(PINSRB,     V,dq, H,dq, E,b,  vex5 cpuid(SSE41) zext2 p_66),
+    [0x20] = X86_OP_ENTRY4(PINSRB,     V,dq, H,dq, E,b,  vex5 cpuid(SSE41) op2_Ry p_66),
     [0x21] = X86_OP_GROUP0(VINSERTPS),
     [0x22] = X86_OP_ENTRY4(PINSR,      V,dq, H,dq, E,y,  vex5 cpuid(SSE41) p_66),
 
@@ -1883,17 +1883,17 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
     case X86_SPECIAL_HasLock:
         break;
 
-    case X86_SPECIAL_ZExtOp0:
+    case X86_SPECIAL_Op0_Rd:
         assert(decode.op[0].unit == X86_OP_INT);
         if (!decode.op[0].has_ea) {
             decode.op[0].ot = MO_32;
         }
         break;
 
-    case X86_SPECIAL_ZExtOp2:
+    case X86_SPECIAL_Op2_Ry:
         assert(decode.op[2].unit == X86_OP_INT);
         if (!decode.op[2].has_ea) {
-            decode.op[2].ot = MO_32;
+            decode.op[2].ot = s->dflag == MO_16 ? MO_32 : s->dflag;
         }
         break;
 
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 611bfddd957..b253f7457ae 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -165,11 +165,20 @@ typedef enum X86InsnSpecial {
     X86_SPECIAL_Locked,
 
     /*
-     * Register operand 0/2 is zero extended to 32 bits.  Rd/Mb or Rd/Mw
-     * in the manual.
+     * Rd/Mb or Rd/Mw in the manual: register operand 0 is treated as 32 bits
+     * (and writeback zero-extends it to 64 bits if applicable).  PREFIX_DATA
+     * does not trigger 16-bit writeback and, as a side effect, high-byte
+     * registers are never used.
      */
-    X86_SPECIAL_ZExtOp0,
-    X86_SPECIAL_ZExtOp2,
+    X86_SPECIAL_Op0_Rd,
+
+    /*
+     * Ry/Mb in the manual (PINSRB).  However, the high bits are never used by
+     * the instruction in either the register or memory cases; the *real* effect
+     * of this modifier is that high-byte registers are never used, even without
+     * a REX prefix.  Therefore, PINSRW does not need it despite having Ry/Mw.
+     */
+    X86_SPECIAL_Op2_Ry,
 
     /*
      * Register operand 2 is extended to full width, while a memory operand
-- 
2.43.0


