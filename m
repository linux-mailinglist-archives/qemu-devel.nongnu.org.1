Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D547CF5AE
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:49:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQYX-0006YB-TG; Thu, 19 Oct 2023 06:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYU-0006P2-Rd
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYT-0006DI-6s
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697712424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mjv64jVCOuqPeYMYCBxNq/eHVS7qvoiEDFreWLDNaaU=;
 b=h/AdOhuxBbhVwNLMH9qvWAu8iSceTMawLtcj7sLdBwxNlpQy7fjnOoPpabgz0Jpj40h1WL
 5s+LDCT9dbtovK3Vc8SBSo3FiltqVEv1DlSKQRUR429HqJUbuP11h2JKIlZV8SEc8dGWPY
 U9pMm1JHhe6yplvmnO/qMVe0OK+cgW0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-DS79yMYBPKWTDIi0ITZfLg-1; Thu, 19 Oct 2023 06:47:02 -0400
X-MC-Unique: DS79yMYBPKWTDIi0ITZfLg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9b9ecd8c351so540333366b.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697712421; x=1698317221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mjv64jVCOuqPeYMYCBxNq/eHVS7qvoiEDFreWLDNaaU=;
 b=jHaBnc8hTBoKHNqsM2v0UvFY/SL97ZBUbxZpQtK8paMOjW/LwkRpJsIzUAigc60l4R
 HghuSgHXg7LazXsb6rr39Zkodqzhjmg0NZ61fQEUEavr5Vgs4/kmaSlNvMmS6GLMtt+a
 Mx/BH2fJlqzndPdcoQtzCqUughBkXya1gnz0pDOhumyjMXzd2Vrp6cMG+/MXwGr6XRTX
 Vmeq70QgyRk1czpegQq+ayfnO1QirqCi2Gc2/WlkJelwD81x+2lRyIIML1sIl5ripuGW
 h83HN5n7DIK39LVubTcwzRKH1MZshgqCH1hMZ3NjZEAO9A8y1ERQ8oU+Z6WnCXkWDJNR
 8Idw==
X-Gm-Message-State: AOJu0YyvSDWdvjV3R2XhHXC4BycQcshtzybAR8zdQhpQeO4JpFFRX6TD
 k75XfuttChWXJh+i+ykwjviufBPyIb4ce+QprZ9yqahI/mFGtyOQZkcmOJvmUmTi/yWxFKUw84n
 ZfA3EwCGEktqTj9ljrKCeVQS94Yn7gwrPjKMgRHVOMDAalxtfHKIvQsg5hQ/ZkMG9OublgPj1St
 Q=
X-Received: by 2002:a17:907:97c3:b0:9c3:87ff:67b8 with SMTP id
 js3-20020a17090797c300b009c387ff67b8mr1621777ejc.2.1697712421230; 
 Thu, 19 Oct 2023 03:47:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH9SdduFAXh6+GboKOMKn4MG67ftjAUZv8iJoxjdDXF0BKljXa1FoRUdKCgl9BCbieZPP55A==
X-Received: by 2002:a17:907:97c3:b0:9c3:87ff:67b8 with SMTP id
 js3-20020a17090797c300b009c387ff67b8mr1621765ejc.2.1697712420882; 
 Thu, 19 Oct 2023 03:47:00 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 1-20020a170906014100b009bf7a4d591csm3384263ejh.11.2023.10.19.03.46.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:46:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/19] target/i386: accept full MemOp in gen_ext_tl
Date: Thu, 19 Oct 2023 12:46:35 +0200
Message-ID: <20231019104648.389942-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019104648.389942-1-pbonzini@redhat.com>
References: <20231019104648.389942-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Use MO_SIGN to indicate signed vs. unsigned extension, and filter out
bits other than MO_SIGN and MO_SIZE.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 4f6f9fa7e52..d7d6c85877d 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -699,18 +699,18 @@ static inline void gen_op_movl_T0_Dshift(DisasContext *s, MemOp ot)
     tcg_gen_shli_tl(s->T0, s->T0, ot);
 };
 
-static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)
+static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp ot)
 {
-    switch (size) {
+    switch (ot & MO_SIZE) {
     case MO_8:
-        if (sign) {
+        if (ot & MO_SIGN) {
             tcg_gen_ext8s_tl(dst, src);
         } else {
             tcg_gen_ext8u_tl(dst, src);
         }
         return dst;
     case MO_16:
-        if (sign) {
+        if (ot & MO_SIGN) {
             tcg_gen_ext16s_tl(dst, src);
         } else {
             tcg_gen_ext16u_tl(dst, src);
@@ -718,7 +718,7 @@ static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)
         return dst;
 #ifdef TARGET_X86_64
     case MO_32:
-        if (sign) {
+        if (ot & MO_SIGN) {
             tcg_gen_ext32s_tl(dst, src);
         } else {
             tcg_gen_ext32u_tl(dst, src);
@@ -732,12 +732,12 @@ static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)
 
 static void gen_extu(MemOp ot, TCGv reg)
 {
-    gen_ext_tl(reg, reg, ot, false);
+    gen_ext_tl(reg, reg, ot);
 }
 
 static void gen_exts(MemOp ot, TCGv reg)
 {
-    gen_ext_tl(reg, reg, ot, true);
+    gen_ext_tl(reg, reg, ot | MO_SIGN);
 }
 
 static void gen_op_j_ecx(DisasContext *s, TCGCond cond, TCGLabel *label1)
@@ -926,7 +926,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
     case CC_OP_SUBB ... CC_OP_SUBQ:
         /* (DATA_TYPE)CC_SRCT < (DATA_TYPE)CC_SRC */
         size = s->cc_op - CC_OP_SUBB;
-        t1 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
+        t1 = gen_ext_tl(s->tmp0, cpu_cc_src, size);
         /* If no temporary was used, be careful not to alias t1 and t0.  */
         t0 = t1 == cpu_cc_src ? s->tmp0 : reg;
         tcg_gen_mov_tl(t0, s->cc_srcT);
@@ -936,8 +936,8 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
     case CC_OP_ADDB ... CC_OP_ADDQ:
         /* (DATA_TYPE)CC_DST < (DATA_TYPE)CC_SRC */
         size = s->cc_op - CC_OP_ADDB;
-        t1 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
-        t0 = gen_ext_tl(reg, cpu_cc_dst, size, false);
+        t1 = gen_ext_tl(s->tmp0, cpu_cc_src, size);
+        t0 = gen_ext_tl(reg, cpu_cc_dst, size);
     add_sub:
         return (CCPrepare) { .cond = TCG_COND_LTU, .reg = t0,
                              .reg2 = t1, .mask = -1, .use_reg2 = true };
@@ -965,7 +965,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 
     case CC_OP_BMILGB ... CC_OP_BMILGQ:
         size = s->cc_op - CC_OP_BMILGB;
-        t0 = gen_ext_tl(reg, cpu_cc_src, size, false);
+        t0 = gen_ext_tl(reg, cpu_cc_src, size);
         return (CCPrepare) { .cond = TCG_COND_EQ, .reg = t0, .mask = -1 };
 
     case CC_OP_ADCX:
@@ -1017,7 +1017,7 @@ static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
     default:
         {
             MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
-            TCGv t0 = gen_ext_tl(reg, cpu_cc_dst, size, true);
+            TCGv t0 = gen_ext_tl(reg, cpu_cc_dst, size | MO_SIGN);
             return (CCPrepare) { .cond = TCG_COND_LT, .reg = t0, .mask = -1 };
         }
     }
@@ -1062,7 +1062,7 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
     default:
         {
             MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
-            TCGv t0 = gen_ext_tl(reg, cpu_cc_dst, size, false);
+            TCGv t0 = gen_ext_tl(reg, cpu_cc_dst, size);
             return (CCPrepare) { .cond = TCG_COND_EQ, .reg = t0, .mask = -1 };
         }
     }
@@ -1088,7 +1088,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         case JCC_BE:
             tcg_gen_mov_tl(s->tmp4, s->cc_srcT);
             gen_extu(size, s->tmp4);
-            t0 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
+            t0 = gen_ext_tl(s->tmp0, cpu_cc_src, size);
             cc = (CCPrepare) { .cond = TCG_COND_LEU, .reg = s->tmp4,
                                .reg2 = t0, .mask = -1, .use_reg2 = true };
             break;
@@ -1101,7 +1101,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         fast_jcc_l:
             tcg_gen_mov_tl(s->tmp4, s->cc_srcT);
             gen_exts(size, s->tmp4);
-            t0 = gen_ext_tl(s->tmp0, cpu_cc_src, size, true);
+            t0 = gen_ext_tl(s->tmp0, cpu_cc_src, size | MO_SIGN);
             cc = (CCPrepare) { .cond = cond, .reg = s->tmp4,
                                .reg2 = t0, .mask = -1, .use_reg2 = true };
             break;
-- 
2.41.0


