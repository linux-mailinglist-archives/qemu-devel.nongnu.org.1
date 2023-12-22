Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C24081CE5C
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:18:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGk4o-00015J-6c; Fri, 22 Dec 2023 13:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4f-00011o-QE
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4d-0006DC-6N
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703268996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bX5EpD1s6AQveh3Ls7hMR6uubiUKHYvpM8T++Cerd1g=;
 b=AQzJ0eZIa9JpdNfY3S69WFnsZU7z0k0NOxPgTwLqjpms6Q60/qcNOcGK8RynIjZfkCZdWE
 z4GKRyzwcDbcciDn9IX/S/vSciiHWbhhEl+cOxspRbdLq0oIyB2Oov7XVH6hdCGL0M4XIZ
 SV7xITy/ju16AHiPx9O0SHHG+3ZACBA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-I2sE72LlMOCQG5kN7CB8wg-1; Fri, 22 Dec 2023 13:16:34 -0500
X-MC-Unique: I2sE72LlMOCQG5kN7CB8wg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-54caf6220c2so1254669a12.1
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:16:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703268992; x=1703873792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bX5EpD1s6AQveh3Ls7hMR6uubiUKHYvpM8T++Cerd1g=;
 b=Zp+q+YboWlSL2ps4Tk8DRg/aD/HONBs4Y7dw3XPYsvzo+06Pl1XareKb/qAZMaF/as
 wxuladrck3mh+RtlYhc6VY1b/PtuIYWPkziCsOq74BgalQEgEirmnUI8vphsxLOXtJ3F
 qye7xYvtxy80pPS0+JEtC+9zOfx6EX/FJLlPsHm70U3eQuSa40OgGxaQbmYSrZRUh3Kp
 FlfdNOlUrZjevjjF3ba6VmlZnUjDnvo3cvdVA9NCmSbnsULSKgGr5jpUycpjj+TkXSc8
 YJQ9Vzlu+xeM/s5vA35xCx9OGja+ZsmWDfDk2JrdwpadwFK9CnD2XrYFQo32ouOk0uoy
 sbjA==
X-Gm-Message-State: AOJu0YyTaprKWDDkDHYdn2F8g/8Ou/3/94gQqT/JM5TCwkxyuaDT4pav
 vjEnhgVSGamaJxzYWNw04UONsUec5/8K9QPH+zt8jAAystne7rJvfpt42BMTIoH3VdCj48HWrfC
 MYfiqgHkKKHqxe+3ifgIOLLTGTV3+TiCdmqZjnrPvZISJeT6jQB5CYC8X4piYW8odA40DB1Td1G
 B3p66p8S8=
X-Received: by 2002:a50:9f0f:0:b0:553:ee28:b97d with SMTP id
 b15-20020a509f0f000000b00553ee28b97dmr1237543edf.39.1703268992552; 
 Fri, 22 Dec 2023 10:16:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0TsfmgJLK3nD1aep0GUC5MT2PlNm3sjh4oLoo373Z1DY+0IQMXx8LjMaIJEnhzxzGX36GFw==
X-Received: by 2002:a50:9f0f:0:b0:553:ee28:b97d with SMTP id
 b15-20020a509f0f000000b00553ee28b97dmr1237536edf.39.1703268992187; 
 Fri, 22 Dec 2023 10:16:32 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a05640204cd00b00554745eca8csm404268edw.59.2023.12.22.10.16.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:16:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/22] target/i386: split eflags computation out of
 gen_compute_eflags
Date: Fri, 22 Dec 2023 19:15:55 +0100
Message-ID: <20231222181603.174137-15-pbonzini@redhat.com>
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

The new x86 decoder wants the gen_* functions to compute EFLAGS before
writeback, which can be an issue for instructions with a memory
destination such as ARPL or shifts.

Extract code to compute the EFLAGS without clobbering CC_SRC, in case
the memory write causes a fault.  The flags writeback mechanism will
take care of copying the result to CC_SRC.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 00ed0cc9a31..b79c312465b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -862,22 +862,22 @@ static void gen_op_update_neg_cc(DisasContext *s)
     tcg_gen_movi_tl(s->cc_srcT, 0);
 }
 
-/* compute all eflags to cc_src */
-static void gen_compute_eflags(DisasContext *s)
+/* compute all eflags to reg */
+static void gen_mov_eflags(DisasContext *s, TCGv reg)
 {
-    TCGv zero, dst, src1, src2;
+    TCGv dst, src1, src2;
+    TCGv_i32 cc_op;
     int live, dead;
 
     if (s->cc_op == CC_OP_EFLAGS) {
+        tcg_gen_mov_tl(reg, cpu_cc_src);
         return;
     }
     if (s->cc_op == CC_OP_CLR) {
-        tcg_gen_movi_tl(cpu_cc_src, CC_Z | CC_P);
-        set_cc_op(s, CC_OP_EFLAGS);
+        tcg_gen_movi_tl(reg, CC_Z | CC_P);
         return;
     }
 
-    zero = NULL;
     dst = cpu_cc_dst;
     src1 = cpu_cc_src;
     src2 = cpu_cc_src2;
@@ -886,7 +886,7 @@ static void gen_compute_eflags(DisasContext *s)
     live = cc_op_live[s->cc_op] & ~USES_CC_SRCT;
     dead = live ^ (USES_CC_DST | USES_CC_SRC | USES_CC_SRC2);
     if (dead) {
-        zero = tcg_constant_tl(0);
+        TCGv zero = tcg_constant_tl(0);
         if (dead & USES_CC_DST) {
             dst = zero;
         }
@@ -898,8 +898,18 @@ static void gen_compute_eflags(DisasContext *s)
         }
     }
 
-    gen_update_cc_op(s);
-    gen_helper_cc_compute_all(cpu_cc_src, dst, src1, src2, cpu_cc_op);
+    if (s->cc_op != CC_OP_DYNAMIC) {
+        cc_op = tcg_constant_i32(s->cc_op);
+    } else {
+        cc_op = cpu_cc_op;
+    }
+    gen_helper_cc_compute_all(reg, dst, src1, src2, cc_op);
+}
+
+/* compute all eflags to cc_src */
+static void gen_compute_eflags(DisasContext *s)
+{
+    gen_mov_eflags(s, cpu_cc_src);
     set_cc_op(s, CC_OP_EFLAGS);
 }
 
-- 
2.43.0


