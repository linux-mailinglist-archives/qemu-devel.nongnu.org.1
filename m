Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA1C820A8D
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:51:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrSI-0004GR-96; Sun, 31 Dec 2023 03:45:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSE-0004Ew-Fo
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrS6-0000jk-Bf
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W+zAEPxTPoHgI3wNLPUXZsJ18c3pQ0NulFoTZrQPHS4=;
 b=Tl/GVvFDxBhC2G0mzp7faFNDrcPw1TOv/1EI16MlyIidgaTVrkMWJVt3cefQSNfkCncuuW
 JPYVCkcXBRqnCyllflRmDkSKWPYBqYVQqm2yCos1RYq5g+c6eie29a6QPcpRWQmgqLXppw
 6C6ncjqaAj1o4XZT9ex3r82883sxSCQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-a2Acz6KjM2GtAVJoYIcfFA-1; Sun, 31 Dec 2023 03:45:42 -0500
X-MC-Unique: a2Acz6KjM2GtAVJoYIcfFA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a2351094960so842074566b.1
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012341; x=1704617141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W+zAEPxTPoHgI3wNLPUXZsJ18c3pQ0NulFoTZrQPHS4=;
 b=ChfV9wbAvqFfwubJMEPpm+vu6YfzwBE6nRpJXAO8+jLQUcdX8czV9pqUGEr7ShL2M1
 q3D2j9JmtoX87k9vVrLfL6T6Aix6NfoWmRuMRvJvws+R+vq3muzC06RKSgP+WPEY3atk
 bgBJK9ZGEw1BIDFKsvHKki7s67nIpjaXu8N5cdN7t6bTsmxywIHKvZuMIG3mYRfOp5yr
 vLRZ2xz+YVIVolN51ZBHWjMEHYKus4J1sCu9HUzchWc4dLgsPXKxpU3KOSr6kkwSpeN9
 2nZacNET1B+3eFdY+FCB5VEjw3NqFZ5OzKEVERhz9P1Azjw0vRpyfBVRoFCFtYqWHJYx
 Y05A==
X-Gm-Message-State: AOJu0YzspIc/313N3BlJ6xJznaFbG4OrNi1e4uyKi/aonXEMIKecvf8i
 vUBwAvNem6R7V6F+zPujr6e6mi5Z+dhGFz5Ua8UTehfOel72CNXWxEBFkm5W88Vo5QBR1k2ttVB
 p1tgncb2HD2Dmcp2jqBE60UvPodtS/IuFeDtcM517vDiwk/9F4ONHuJiLlRxbff+E+lXo/dSkqG
 gQEYCugSM=
X-Received: by 2002:a17:906:6a05:b0:a26:f7ea:7cb6 with SMTP id
 qw5-20020a1709066a0500b00a26f7ea7cb6mr10841961ejc.16.1704012340865; 
 Sun, 31 Dec 2023 00:45:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEE4N5iehDXpUhhaSYiyoYNs/FIUhDplBYFNSVvUi2hcbp2Pecnz1AcOv1rXQcct3bV8+7vSg==
X-Received: by 2002:a17:906:6a05:b0:a26:f7ea:7cb6 with SMTP id
 qw5-20020a1709066a0500b00a26f7ea7cb6mr10841956ejc.16.1704012340579; 
 Sun, 31 Dec 2023 00:45:40 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 r9-20020aa7cb89000000b005550844cd1dsm7183482edt.30.2023.12.31.00.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:45:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/46] target/i386: do not clobber A0 in POP translation
Date: Sun, 31 Dec 2023 09:44:29 +0100
Message-ID: <20231231084502.235366-14-pbonzini@redhat.com>
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

The new decoder likes to compute the address in A0 very early, so the
gen_lea_v_seg in gen_pop_T0 would clobber the address of the memory
operand.  Instead use T0 since it is already available and will be
overwritten immediately after.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 73b83e07e23..efef4e74d4c 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -635,17 +635,17 @@ static TCGv eip_cur_tl(DisasContext *s)
     }
 }
 
-/* Compute SEG:REG into A0.  SEG is selected from the override segment
+/* Compute SEG:REG into DEST.  SEG is selected from the override segment
    (OVR_SEG) and the default segment (DEF_SEG).  OVR_SEG may be -1 to
    indicate no override.  */
-static void gen_lea_v_seg(DisasContext *s, MemOp aflag, TCGv a0,
-                          int def_seg, int ovr_seg)
+static void gen_lea_v_seg_dest(DisasContext *s, MemOp aflag, TCGv dest, TCGv a0,
+                               int def_seg, int ovr_seg)
 {
     switch (aflag) {
 #ifdef TARGET_X86_64
     case MO_64:
         if (ovr_seg < 0) {
-            tcg_gen_mov_tl(s->A0, a0);
+            tcg_gen_mov_tl(dest, a0);
             return;
         }
         break;
@@ -656,14 +656,14 @@ static void gen_lea_v_seg(DisasContext *s, MemOp aflag, TCGv a0,
             ovr_seg = def_seg;
         }
         if (ovr_seg < 0) {
-            tcg_gen_ext32u_tl(s->A0, a0);
+            tcg_gen_ext32u_tl(dest, a0);
             return;
         }
         break;
     case MO_16:
         /* 16 bit address */
-        tcg_gen_ext16u_tl(s->A0, a0);
-        a0 = s->A0;
+        tcg_gen_ext16u_tl(dest, a0);
+        a0 = dest;
         if (ovr_seg < 0) {
             if (ADDSEG(s)) {
                 ovr_seg = def_seg;
@@ -680,17 +680,23 @@ static void gen_lea_v_seg(DisasContext *s, MemOp aflag, TCGv a0,
         TCGv seg = cpu_seg_base[ovr_seg];
 
         if (aflag == MO_64) {
-            tcg_gen_add_tl(s->A0, a0, seg);
+            tcg_gen_add_tl(dest, a0, seg);
         } else if (CODE64(s)) {
-            tcg_gen_ext32u_tl(s->A0, a0);
-            tcg_gen_add_tl(s->A0, s->A0, seg);
+            tcg_gen_ext32u_tl(dest, a0);
+            tcg_gen_add_tl(dest, dest, seg);
         } else {
-            tcg_gen_add_tl(s->A0, a0, seg);
-            tcg_gen_ext32u_tl(s->A0, s->A0);
+            tcg_gen_add_tl(dest, a0, seg);
+            tcg_gen_ext32u_tl(dest, dest);
         }
     }
 }
 
+static void gen_lea_v_seg(DisasContext *s, MemOp aflag, TCGv a0,
+                          int def_seg, int ovr_seg)
+{
+    gen_lea_v_seg_dest(s, aflag, s->A0, a0, def_seg, ovr_seg);
+}
+
 static inline void gen_string_movl_A0_ESI(DisasContext *s)
 {
     gen_lea_v_seg(s, s->aflag, cpu_regs[R_ESI], R_DS, s->override);
@@ -2576,8 +2582,8 @@ static MemOp gen_pop_T0(DisasContext *s)
 {
     MemOp d_ot = mo_pushpop(s, s->dflag);
 
-    gen_lea_v_seg(s, mo_stacksize(s), cpu_regs[R_ESP], R_SS, -1);
-    gen_op_ld_v(s, d_ot, s->T0, s->A0);
+    gen_lea_v_seg_dest(s, mo_stacksize(s), s->T0, cpu_regs[R_ESP], R_SS, -1);
+    gen_op_ld_v(s, d_ot, s->T0, s->T0);
 
     return d_ot;
 }
-- 
2.43.0


