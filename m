Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B85A81CE62
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:18:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGk4s-00018L-9T; Fri, 22 Dec 2023 13:16:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4T-0000yn-Ob
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4P-0006BZ-1J
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703268983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yq5Jlqtm77xROj7+26dNFssPKgrW3rlMl3GvEYgyhmE=;
 b=ECfsuINCrRRt68YMwyqkN7bTGYCU2n3a+TkH05s2e5OfWcidgh/dLl6PVwhfip2xkz5d+i
 lRw9TiXOzwEiUy/D1enYlEFI2xQuLRG8vNb9o/faUUgHqwjuApQvM12qcckdk+ayfNR3GP
 K7zLvYouNiCdHzQGgjY+R3H21rL+ldk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-Cosvj1m-O7SaerLdNnmsVQ-1; Fri, 22 Dec 2023 13:16:21 -0500
X-MC-Unique: Cosvj1m-O7SaerLdNnmsVQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40d39bbe215so14527345e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:16:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703268980; x=1703873780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yq5Jlqtm77xROj7+26dNFssPKgrW3rlMl3GvEYgyhmE=;
 b=ew/5z+NanuKOOCtSzjvDHLNgz60xYktVjHBfGAvdgPZtFNQruuOuD0yjRn6IxpIXKq
 x+B6aZnTA+xieWjwSwH0R3ge3pRTpdm1S/+wBFu3Sv/9eXcqSvNQVSl/MqhXGw74kYk/
 RX9hDsmN4qQZ/EYgw+z2zh+7tGntmCtzPqAOOLGanDcDN9CN0uIiHZlSipQWRME3XqfZ
 R3axcx3sG/KPkJ9XvEpL/+iy5a4ydYYoCDv79h6Q5hUzvmL7N57zCJhErS+nUajvog+r
 SV1KA7J6xRARQKqEnz3kJ18Sj0Rx1pQ1FdtfSpGNiRStAU17q3TcwEy1Hx6E2pOvBJ14
 HEAQ==
X-Gm-Message-State: AOJu0YyzvMe+b4l7BXnWgiRooNcH3Bh0ock+jxJh5sb8W0ykGPhYyHld
 py1s05j0ncxNtNWL3s4V4PLWQtxDdH6dRmvkgzDD8m3dO6ajKZiiB2RZ4K3SD80oxfcQeuVS0xx
 CzoCO1sz3gfPqI/pGdAIcoNMVLaDRP8yjaD80Oaquuc9TnofFn156xiu3WyjykAsFrFgyo5zG1c
 ROuPDiWag=
X-Received: by 2002:a05:600c:4e92:b0:40b:5e21:ec15 with SMTP id
 f18-20020a05600c4e9200b0040b5e21ec15mr901315wmq.71.1703268980251; 
 Fri, 22 Dec 2023 10:16:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH35FGyRCSLkdlwW9FUOLjlsgJ2QMioBg7cLC/EUKB0W3dzumz+LAi0nDAvLoYao0pFKcYExw==
X-Received: by 2002:a05:600c:4e92:b0:40b:5e21:ec15 with SMTP id
 f18-20020a05600c4e9200b0040b5e21ec15mr901311wmq.71.1703268979910; 
 Fri, 22 Dec 2023 10:16:19 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 bg6-20020a05600c3c8600b00405c7591b09sm7778206wmb.35.2023.12.22.10.16.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:16:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/22] target/i386: reimplement check for validity of LOCK
 prefix
Date: Fri, 22 Dec 2023 19:15:48 +0100
Message-ID: <20231222181603.174137-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222181603.174137-1-pbonzini@redhat.com>
References: <20231222181603.174137-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
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


