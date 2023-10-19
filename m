Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D877CF5A0
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:48:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQZ9-0006vT-7J; Thu, 19 Oct 2023 06:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYf-0006ZV-Bo
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYd-0006El-9X
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697712434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DuoXc2BU+ZIapePNKXerF9ciZjLeynT5HD0XoYbHuRI=;
 b=UibnAj5adNBbqDAhqkzdZHITNcg9drs85GF/knDzx1L8ZFgZ26jUZxt0839j1eMwgDknlQ
 VjCh+ASoXX2Bt/C7toNDDThsuEs9kcnonmzrpKJMI0q7c3IqSucS1P+DlElAr97+glY9L6
 uTdl2FUvFUAZ4ZGqaNa0VAoRIIGsEEM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-oUewJLerO8m1y_6NnY-Ppw-1; Thu, 19 Oct 2023 06:47:08 -0400
X-MC-Unique: oUewJLerO8m1y_6NnY-Ppw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507cee14477so928364e87.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697712426; x=1698317226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DuoXc2BU+ZIapePNKXerF9ciZjLeynT5HD0XoYbHuRI=;
 b=Sk1sE0vdHqi+4DR/1r1HgWoZlAgslH9fCGwfujz9hzAbh4H6hIjEnikgMlhbhIzkHJ
 hyhboZJXJvCOcKYGZsmxTOZcu6AFcOQxxxnTWPLnBa/lGkZB8CzbW5jFHO7kmsTVMh2a
 ETtzeu/2ZbPzN3NWzYZ/AgTf2OXfkdZWDCfpP0OzbJk9Y2A8lV+auV/sAGDQHq/Gl7mz
 8Ivwb7k4J51zu8W3YHeBZ7Hk581RrQBtGDM8K2aDM2febMHzpOkZuNEP8S444HyoacLX
 QT5Rh2g75ocuqt+7WkL702t9LlGIu1LVbRUHkd+RBbPuqN8AcTHTyAcC+mvFroY4FDyW
 9GHg==
X-Gm-Message-State: AOJu0YzYDSXZxGpCxnf5zKPXv75IUKFBsFgijvtsO2cTcWFrZSMZDeLC
 qtiu54P98XVBMa72APVtDjFuBXtda3jz9J/0fZVOu3Un2s7QmFiD/yOV91v6IDmEuOUqGyrJZsX
 Y/hj9k42HKFYcxbLUOp13EWeh0Y3NCblAEhTzC8SENoO/ovOUS35o/gt5/c0k5rKg+hcdPRAnko
 8=
X-Received: by 2002:ac2:5f9b:0:b0:507:b988:7c3c with SMTP id
 r27-20020ac25f9b000000b00507b9887c3cmr1081067lfe.65.1697712426608; 
 Thu, 19 Oct 2023 03:47:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCN7JquQHbRCb9Pu+7Jdj9f/4XHtpCQkbDZsvmTHPjLnONdj+IidQQ3tlEqzPJh5brZKWi/A==
X-Received: by 2002:ac2:5f9b:0:b0:507:b988:7c3c with SMTP id
 r27-20020ac25f9b000000b00507b9887c3cmr1081052lfe.65.1697712426234; 
 Thu, 19 Oct 2023 03:47:06 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 u27-20020a50a41b000000b0053dd798e38asm4293050edb.69.2023.10.19.03.47.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:47:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/19] target/i386: do not clobber A0 in POP translation
Date: Thu, 19 Oct 2023 12:46:38 +0200
Message-ID: <20231019104648.389942-10-pbonzini@redhat.com>
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

The new decoder likes to compute the address in A0 very early, so the
gen_lea_v_seg in gen_pop_T0 would clobber the address of the memory
operand.  Instead use T0 since it is already available and will be
overwritten immediately after.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 038151a8c3e..39b5752e780 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -628,17 +628,17 @@ static TCGv eip_cur_tl(DisasContext *s)
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
@@ -649,14 +649,14 @@ static void gen_lea_v_seg(DisasContext *s, MemOp aflag, TCGv a0,
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
@@ -673,17 +673,23 @@ static void gen_lea_v_seg(DisasContext *s, MemOp aflag, TCGv a0,
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
@@ -2590,8 +2596,8 @@ static MemOp gen_pop_T0(DisasContext *s)
 {
     MemOp d_ot = mo_pushpop(s, s->dflag);
 
-    gen_lea_v_seg(s, mo_stacksize(s), cpu_regs[R_ESP], R_SS, -1);
-    gen_op_ld_v(s, d_ot, s->T0, s->A0);
+    gen_lea_v_seg_dest(s, mo_stacksize(s), s->T0, cpu_regs[R_ESP], R_SS, -1);
+    gen_op_ld_v(s, d_ot, s->T0, s->T0);
 
     return d_ot;
 }
-- 
2.41.0


