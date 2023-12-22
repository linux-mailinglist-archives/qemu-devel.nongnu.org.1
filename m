Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D9E81CE61
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:18:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGk4n-00014M-J4; Fri, 22 Dec 2023 13:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4Y-0000zY-Ku
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4X-0006CW-2i
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703268992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W+zAEPxTPoHgI3wNLPUXZsJ18c3pQ0NulFoTZrQPHS4=;
 b=RCWm8XdL+tPjaqo77S9S9LN9nE9KqLn0dOSTkvIAXyClUXVktjHAbGCugjq6w5jTISoXuO
 pQ46lT0iroD528XuVgO0aiCQoOD/VdrKIx0gDhiYfVGGSeuTKFTgqK7zy09rv6lZxzf1PT
 p+jwzWENffs0/ZECIViWDbzlysie4WU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-p5YlmMSpOnmRo6ow65JalQ-1; Fri, 22 Dec 2023 13:16:30 -0500
X-MC-Unique: p5YlmMSpOnmRo6ow65JalQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a2359549fc0so75867566b.0
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:16:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703268989; x=1703873789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W+zAEPxTPoHgI3wNLPUXZsJ18c3pQ0NulFoTZrQPHS4=;
 b=wb4izta800qyuqs4yk5PE2CKRScxfPzK18K3BPJ4/+54nbH7h66PgOFx8p9zliGbq4
 kt68QlnSKNA+8f5dj8Luu9kblnIivCEE5q8AprI0MkbJ3GM3FGEN8LeMIGZPX5pxyXpC
 RqyNE2zn9gRE2//bLp6l5Z5wgYyONYuoYwR2HrzC3M5m73TskZRzx3EhuiFnqHb6CoUW
 +OEn5Lca+1tjuKVR2UiST3DWW1ToIbviS2CL1uUzvOfdetziZlTJu9acMOomkAe+1fiL
 P/WftpTcrX4do1O87UFJzSzJwartgoClJbFCWSr+mWVZDxUvySacd2znH1WwmGRQ2SlY
 489A==
X-Gm-Message-State: AOJu0Yz0Hu6VDHx2aUx8D6ylrmfA3CRQJVR1LuNhqr5J/CG6hrJr4pr6
 XabrUFWua0eOJsTwxTUWF29D7A4xHkcDhkmMA74tO+9f5kY0x0rNdSQ5pJdopUZjmzebOLL9YAg
 k3S5EV2my90NrmKWMhfmYYlb4ZfFZiiW00LPsh7ClXqt3coiEcphb95CaJCRI60nn6U40kMbiPj
 AxWjz1Koo=
X-Received: by 2002:a05:6402:78e:b0:554:1252:2d53 with SMTP id
 d14-20020a056402078e00b0055412522d53mr1096776edy.70.1703268988922; 
 Fri, 22 Dec 2023 10:16:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQoNLi+maI+8jLeMr1Ddum/V0wwry9fzFpMV/sJm9pmtNCjIC2gfbRzu84rNPFW5fl8gINLw==
X-Received: by 2002:a05:6402:78e:b0:554:1252:2d53 with SMTP id
 d14-20020a056402078e00b0055412522d53mr1096772edy.70.1703268988645; 
 Fri, 22 Dec 2023 10:16:28 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 i21-20020a0564020f1500b0055344b92fb6sm2883082eda.75.2023.12.22.10.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:16:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 12/22] target/i386: do not clobber A0 in POP translation
Date: Fri, 22 Dec 2023 19:15:53 +0100
Message-ID: <20231222181603.174137-13-pbonzini@redhat.com>
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


