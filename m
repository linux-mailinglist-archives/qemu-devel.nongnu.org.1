Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD73D81CE5F
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:18:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGk4p-00016B-MM; Fri, 22 Dec 2023 13:16:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4l-00013X-Qh
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4j-0006EI-Bd
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703269004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y5+MDI+XKw+yOLFVrtp1LkMUsL0OWC+rrUzJzVKEQtI=;
 b=QdFiqT1GnMZj4NXwbrWAU3Fpq0aI3zMRbDtpZZc8dsqQyUEW+uTC2KUvVrKZRnGWMe/liC
 po3FuSpVZqwUdLQIAd3Di68Xyz6vTsZ6+MebAQ/SfLizyDJU5TzlvGPWr1N0EHFSqo52lB
 S7zsDli3B3cmczJH6CoPd7ioHqlhXw0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-7lQujzHiNEWLkUfWqYUZVA-1; Fri, 22 Dec 2023 13:16:43 -0500
X-MC-Unique: 7lQujzHiNEWLkUfWqYUZVA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a1fa0ed205fso109691166b.2
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:16:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703269001; x=1703873801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y5+MDI+XKw+yOLFVrtp1LkMUsL0OWC+rrUzJzVKEQtI=;
 b=ZLVLAvAvMNUQUaBM/1H+OEQn9VG/Xuf8YmyXO5I7DUnFz8x27Vaw2YRr7XvmnR7pgd
 K8vdz1f3KMPNcrxQQO70/3erHbcrnP0ybVHLldhyJjnOOe6SZ6aYqUpNCi+JiWbcfFSY
 cqRVjw8qNHuuLxEjJzr7kWOspdzsuJ663MH6O1ZHU209JEoBb3V829u4tXirFPvRhOxu
 eYRymkWtN1GVf9RxCT0NecBbgXzvxcP2xc+L3Q3RJRichLAzm7GgqKj7vcyiLyucjG1y
 /xar2CHJBDsaw6T75ktfZyC8l+ueiZcCzdQ9RN6bw6abbm2abMQn2oD3/p4z5BBqjjFi
 XkrA==
X-Gm-Message-State: AOJu0YyYJfgyxbPIekCvWFKan9somdMb/PE6emfSCELtkpz4cl6uLrze
 0SAWYq+GVAwyKldoL/WyqZGtFnbs7MTnxW6CeWYebyvK5EiwQV7MMG2BVj2ZQzmtdhF8KOOELqp
 xR9SeROniugw4uy5UIhlH0cz4F/cnvte4ShdrbDve46QKDqH0yqXfgI6aNCRTQMmg5HOhPkRpzf
 plUknbZuM=
X-Received: by 2002:a17:906:134a:b0:a26:8683:bc6c with SMTP id
 x10-20020a170906134a00b00a268683bc6cmr848526ejb.36.1703269001645; 
 Fri, 22 Dec 2023 10:16:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFC4h9xa/Y2QQjtdjcEM7D8NZnor89RIpndHnqIiNPqreCBNcYvR0K0HaIvg1km2Q9V+Nx8qw==
X-Received: by 2002:a17:906:134a:b0:a26:8683:bc6c with SMTP id
 x10-20020a170906134a00b00a268683bc6cmr848523ejb.36.1703269001336; 
 Fri, 22 Dec 2023 10:16:41 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 p9-20020a1709060dc900b00a236193fe3dsm2273848eji.182.2023.12.22.10.16.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:16:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/22] target/i386: move operand load and writeback out of
 gen_cmovcc1
Date: Fri, 22 Dec 2023 19:16:00 +0100
Message-ID: <20231222181603.174137-20-pbonzini@redhat.com>
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

Similar to gen_setcc1, make gen_cmovcc1 receive TCGv.  This is more friendly
to simultaneous implementation in the old and the new decoder.

A small wart is that s->T0 of CMOV is currently the *second* argument (which
would ordinarily be in T1).  Therefore, the condition has to be inverted in
order to overwrite s->T0 with cpu_regs[reg] if the MOV is not performed.

This only applies to the old decoder, and this code will go away soon.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index c7d48088418..53b98d5e6ac 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2500,14 +2500,10 @@ static void gen_jcc(DisasContext *s, int b, int diff)
     gen_jmp_rel(s, s->dflag, diff, 0);
 }
 
-static void gen_cmovcc1(CPUX86State *env, DisasContext *s, MemOp ot, int b,
-                        int modrm, int reg)
+static void gen_cmovcc1(DisasContext *s, int b, TCGv dest, TCGv src)
 {
-    CCPrepare cc;
+    CCPrepare cc = gen_prepare_cc(s, b, s->T1);
 
-    gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
-
-    cc = gen_prepare_cc(s, b, s->T1);
     if (cc.mask != -1) {
         TCGv t0 = tcg_temp_new();
         tcg_gen_andi_tl(t0, cc.reg, cc.mask);
@@ -2517,9 +2513,7 @@ static void gen_cmovcc1(CPUX86State *env, DisasContext *s, MemOp ot, int b,
         cc.reg2 = tcg_constant_tl(cc.imm);
     }
 
-    tcg_gen_movcond_tl(cc.cond, s->T0, cc.reg, cc.reg2,
-                       s->T0, cpu_regs[reg]);
-    gen_op_mov_reg_v(s, ot, reg, s->T0);
+    tcg_gen_movcond_tl(cc.cond, dest, cc.reg, cc.reg2, src, dest);
 }
 
 static inline void gen_op_movl_T0_seg(DisasContext *s, X86Seg seg_reg)
@@ -5238,7 +5232,9 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         ot = dflag;
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
-        gen_cmovcc1(env, s, ot, b, modrm, reg);
+        gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
+        gen_cmovcc1(s, b ^ 1, s->T0, cpu_regs[reg]);
+        gen_op_mov_reg_v(s, ot, reg, s->T0);
         break;
 
         /************************/
-- 
2.43.0


