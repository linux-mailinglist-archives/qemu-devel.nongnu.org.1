Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B88F820A75
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:46:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrRt-0004CI-Ug; Sun, 31 Dec 2023 03:45:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrRr-0004BM-6P
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrRp-0000ib-Hq
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1kMhOD0w1s7qjHiwnekeESNBiKPUesI43vYWlltEI8=;
 b=YibOhIt8X1hDdNlTXMwvZMxyEIP6ETJwCNdWOSvwFnX9b2oi8OXjXSn6plHvlOykZs8qXV
 xmYoW37H4u7Ps49vNWPKxSYpylQW8ORQaay6X17eOylrkWGouD0heNxJRQ+cJKFejrujCX
 bghvdqVXHFCwmq3M22HR0jcHzhfUR/s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-Ra2HH6h1PqiQQ8rI6L-h1A-1; Sun, 31 Dec 2023 03:45:27 -0500
X-MC-Unique: Ra2HH6h1PqiQQ8rI6L-h1A-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a2765a07d3eso86563666b.2
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:45:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012325; x=1704617125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1kMhOD0w1s7qjHiwnekeESNBiKPUesI43vYWlltEI8=;
 b=qbvvcw4QYJ6E9DmF62/QDDpmCmuv8+0cBuSwrk1WfoFVZ0txsJxYF4QJ74U/BKnj/N
 eV/KsMjgKU9ZvSIgMpHy3nJkGodahiUGb+ZHdFA+lDciEjkQDFN7dHofGbupYZ3YKolq
 kCn3NkLtsL/5Om1AdxyjMGqy1o5hfob8w/xv7fQ4iGZYO06xftE/bQG86hob0awlVGce
 je4q7MA+uSOYN7SD4bpG/5nYX+XrFQsKUcEvDT5X32tsmi3XWf0RxRbCjwaOg3cArKP4
 BzP1XzgADJ+CkXTp2R2Wvbl2xayOk3OA259T2oD7a9kRKjuZrWS6W57qqR1eF/2DmiKA
 Avcg==
X-Gm-Message-State: AOJu0YzjEWztWXQumo/P5QLAtpZKkig8BVVQ1Xs2jsOMIuX/QzhPH1cG
 PMtd+/9SU5aiERercMM/OU+G7phy+N32AtDa1q+Es/DCr0vQwhhJuGNbTdpOgabcDTh9Pmbg6sM
 Og3QYTX1vFGihQS9fpKQt2YyHs/9FG+7yrzVThECuuGet1yJ7vhMIdQbRfDeGGk8R3fHsAPrLfn
 kPVnCyLoA=
X-Received: by 2002:a50:d4c1:0:b0:54d:740c:6bd9 with SMTP id
 e1-20020a50d4c1000000b0054d740c6bd9mr8820104edj.70.1704012325245; 
 Sun, 31 Dec 2023 00:45:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQBxghtScOwif8HtEP6IcwyTvmW+X/TjwPGsPUWWnRQ3GkmizjRHc2wXYzHjAp6oRSPW5CkQ==
X-Received: by 2002:a50:d4c1:0:b0:54d:740c:6bd9 with SMTP id
 e1-20020a50d4c1000000b0054d740c6bd9mr8820101edj.70.1704012325006; 
 Sun, 31 Dec 2023 00:45:25 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a50fe85000000b0054cb88a353dsm13186333edt.14.2023.12.31.00.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:45:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/46] target/i386: reimplement check for validity of LOCK
 prefix
Date: Sun, 31 Dec 2023 09:44:24 +0100
Message-ID: <20231231084502.235366-9-pbonzini@redhat.com>
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

The previous check erroneously allowed CMP to be modified with LOCK.
Instead, tag explicitly the instructions that do support LOCK.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 17 ++++++++++-------
 target/i386/tcg/decode-new.h     |  3 +++
 target/i386/tcg/emit.c.inc       |  5 -----
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 232c6a45c96..5eb2e9d0224 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -151,6 +151,7 @@
 
 #define cpuid(feat) .cpuid = X86_FEAT_##feat,
 #define xchg .special = X86_SPECIAL_Locked,
+#define lock .special = X86_SPECIAL_HasLock,
 #define mmx .special = X86_SPECIAL_MMX,
 #define zext0 .special = X86_SPECIAL_ZExtOp0,
 #define zext2 .special = X86_SPECIAL_ZExtOp2,
@@ -1103,10 +1104,6 @@ static int decode_modrm(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
 {
     int modrm = get_modrm(s, env);
     if ((modrm >> 6) == 3) {
-        if (s->prefix & PREFIX_LOCK) {
-            decode->e.gen = gen_illegal;
-            return 0xff;
-        }
         op->n = (modrm & 7);
         if (type != X86_TYPE_Q && type != X86_TYPE_N) {
             op->n |= REX_B(s);
@@ -1881,6 +1878,9 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
         if (decode.op[0].has_ea) {
             s->prefix |= PREFIX_LOCK;
         }
+        decode.e.special = X86_SPECIAL_HasLock;
+        /* fallthrough */
+    case X86_SPECIAL_HasLock:
         break;
 
     case X86_SPECIAL_ZExtOp0:
@@ -1909,6 +1909,12 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
         break;
     }
 
+    if (s->prefix & PREFIX_LOCK) {
+        if (decode.e.special != X86_SPECIAL_HasLock || !decode.op[0].has_ea) {
+            goto illegal_op;
+        }
+    }
+
     if (!validate_vex(s, &decode)) {
         return;
     }
@@ -1952,9 +1958,6 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
         gen_load_ea(s, &decode.mem, decode.e.vex_class == 12);
     }
     if (s->prefix & PREFIX_LOCK) {
-        if (decode.op[0].unit != X86_OP_INT || !decode.op[0].has_ea) {
-            goto illegal_op;
-        }
         gen_load(s, &decode, 2, s->T1);
         decode.e.gen(s, env, &decode);
     } else {
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index e6c904a3192..611bfddd957 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -158,6 +158,9 @@ typedef enum X86InsnCheck {
 typedef enum X86InsnSpecial {
     X86_SPECIAL_None,
 
+    /* Accepts LOCK prefix; LOCKed operations do not load or writeback operand 0 */
+    X86_SPECIAL_HasLock,
+
     /* Always locked if it has a memory operand (XCHG) */
     X86_SPECIAL_Locked,
 
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index d444d83e534..98c4c9569ef 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -55,11 +55,6 @@ static void gen_NM_exception(DisasContext *s)
     gen_exception(s, EXCP07_PREX);
 }
 
-static void gen_illegal(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
-{
-    gen_illegal_opcode(s);
-}
-
 static void gen_load_ea(DisasContext *s, AddressParts *mem, bool is_vsib)
 {
     TCGv ea = gen_lea_modrm_1(s, *mem, is_vsib);
-- 
2.43.0


