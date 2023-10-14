Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F0B7C940A
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 12:05:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrbSs-0002VG-LO; Sat, 14 Oct 2023 06:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbSr-0002Uz-Bt
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:01:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbSp-0003zP-Q1
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697277703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mjv64jVCOuqPeYMYCBxNq/eHVS7qvoiEDFreWLDNaaU=;
 b=aFB7ZJM6mmjBjyWaIkKOpkVaW6ppa5s9JCyXmXaY4rWivIolQlYhnqZl2eY05EtMB7pKXG
 wUW1PX4URmQot+jQ+svc3rm1TAqC8CddZPhB67eP2a6hsPK5o+Th7pqyDrplWnukbI/4s+
 knZXL4pIm/TkC0h4R8wUPO7SbAeCYZI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-u-JkNKD7NiSSkz0kAHmNdw-1; Sat, 14 Oct 2023 06:01:36 -0400
X-MC-Unique: u-JkNKD7NiSSkz0kAHmNdw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9b65b6bcfb7so222062566b.2
 for <qemu-devel@nongnu.org>; Sat, 14 Oct 2023 03:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697277694; x=1697882494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mjv64jVCOuqPeYMYCBxNq/eHVS7qvoiEDFreWLDNaaU=;
 b=NBgQqtmjM5DMqbdowmt+ivzGS91uY2sLKUQAHgJnGLS9zWds8lTxeHofM3d/tNTaRs
 81+FTpKXwvrqn2gS4SruEw/4C+FQKqvSpoqJ3KkzXQMZ87zvhmHLW7RMH8LziPHq/Gyj
 MtTLuqZk147o1Br8gi4i4gJ2zY7fOMhNqL0Bob7VPvp9rfwTz0sQaarcyuNMXsoehUX0
 pLmkhZnGsEznWDieR7i6sj1ZRIhROdvfvUoVcaheARc6Kq9BpAUkMIxA+PmSNDV9DT3j
 7ry6l7BsfrlZJtvXsOMEezy9egkieHks329GE9d+fBqm6RmsSiOfjxsWT87qvfkDT1il
 lcaA==
X-Gm-Message-State: AOJu0YzMfk97fCWbrr4v82c/QlmqUNhvI1M6OattctvbAFT20FQs8nBo
 Km7eruIBYpJ1s2/TkJ/r7KYK7+T+AzETFgFF2K7pdIZ/WwHS61ng91c/9YIwjGABeQQ4QC22prv
 ypCws4WXFpDjVePV47o1R/vdVcPYUPuLgwu0yG2BeVl4wqlQiUAKqWlAEHKDp6NIVKi4E9jEmKj
 Q=
X-Received: by 2002:a17:907:da6:b0:9be:c2cd:aa2f with SMTP id
 go38-20020a1709070da600b009bec2cdaa2fmr1099704ejc.66.1697277694629; 
 Sat, 14 Oct 2023 03:01:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPDTLrEC28UgaYf3KF+RwYMWF9TdVutMBcbvpYLAfWxT0rHB5CDYUAwl2qqAkMridnsTnDuw==
X-Received: by 2002:a17:907:da6:b0:9be:c2cd:aa2f with SMTP id
 go38-20020a1709070da600b009bec2cdaa2fmr1099686ejc.66.1697277694234; 
 Sat, 14 Oct 2023 03:01:34 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a170906749000b0099bd0b5a2bcsm730976ejl.101.2023.10.14.03.01.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 03:01:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/18] target/i386: accept full MemOp in gen_ext_tl
Date: Sat, 14 Oct 2023 12:01:08 +0200
Message-ID: <20231014100121.109817-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014100121.109817-1-pbonzini@redhat.com>
References: <20231014100121.109817-1-pbonzini@redhat.com>
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


