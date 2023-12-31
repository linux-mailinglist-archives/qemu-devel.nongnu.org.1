Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E6D820A7D
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:46:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrSC-0004EQ-LM; Sun, 31 Dec 2023 03:45:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrS5-0004DN-29
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrS2-0000jX-2u
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SirnMEhuqYrN4igU2tW7xrG60TqRnOc694vKKDUSL/4=;
 b=R7Z3VOlckTyxpvTJmXhPxnRfyooPw2YfdrbvTjHbHBkeefdQID59w+LNLjNH8HDjgWOp4k
 18YKw+kfHglcwhGCnebP63X0i7gHG1d107zDzLOAK3EdUkvkQ6kiAoPPoZa0NhyF3dIDvm
 wqKWQDPmCLEkUkiDicFNRP6hXVd+HVM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-vReF9Y93OEOfkV5-hx4gMQ-1; Sun, 31 Dec 2023 03:45:33 -0500
X-MC-Unique: vReF9Y93OEOfkV5-hx4gMQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a0c510419caso420023566b.1
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:45:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012332; x=1704617132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SirnMEhuqYrN4igU2tW7xrG60TqRnOc694vKKDUSL/4=;
 b=JTZKYWAR0TUCuWz7uGPzdHuyCechaxYuFVQT/F6arvVNH2IpqInKMCmCEFCz2tp5w3
 6yL+PxapWAim9rH1mTC8635sU30iPIm57/9YVJksc/aLSug2VFJcW7In7kv19nCUZxwT
 wbZAxMS8sFarDtE6CZqzocuf/ztoN/J9LdUjrN7XUn6VPG3EJgT3PeCLCcxxcUJxhw72
 3BlA6N8tq28zd5vJIQj/ob4YpJ+DusDqErg8eXhtws7AZqvRA7x7hAH8gfTVIRT9i3Cl
 zgN7P5/HUtxOlo+zeNi9oiNz7Rm713CLUZnBzxYNqpSRMT5Zdol6RPGuOT4Nvzgjca1c
 1dEQ==
X-Gm-Message-State: AOJu0YwCi8vJOoq1k01wbEnfbMDuFr2+82U/r81ROI/D32ZrQeOT9DtF
 OPqSP+4ZxAMF1ygZ33TKTaqBAMeCFNCJtwZjbm2yMfnMG96k+jK2pGgNTklBwA0J1Pb/6neHNKh
 p4rqPhsz/JfyUueXwp8XDwpihoigS4ypPomt9Jblg69+jRiH1nNHnQCE1vABb7g0FbTlLLn2FRC
 ARWbSM1Bg=
X-Received: by 2002:a17:906:51d3:b0:a27:ed07:ce9 with SMTP id
 v19-20020a17090651d300b00a27ed070ce9mr198993ejk.33.1704012331929; 
 Sun, 31 Dec 2023 00:45:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVfZ88wTeWbgb8p2X8Wk8NytsuNDwNlRWBScu5vUsYiUOxeBfaeDgl7hLEFJMF1xr+XDCTFQ==
X-Received: by 2002:a17:906:51d3:b0:a27:ed07:ce9 with SMTP id
 v19-20020a17090651d300b00a27ed070ce9mr198989ejk.33.1704012331656; 
 Sun, 31 Dec 2023 00:45:31 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 s4-20020a1709062ec400b00a234585cc79sm9851712eji.188.2023.12.31.00.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:45:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/46] target/i386: rename zext0/zext2 and make them closer to
 the manual
Date: Sun, 31 Dec 2023 09:44:26 +0100
Message-ID: <20231231084502.235366-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


