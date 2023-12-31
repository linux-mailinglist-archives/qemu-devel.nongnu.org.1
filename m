Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2BF820A79
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:46:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrRy-0004D4-Bv; Sun, 31 Dec 2023 03:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrRv-0004Ca-QF
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrRu-0000j1-3t
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=naLVVkGULG2Mew1FgU3nWncMJvzkAI/2iMH2Lx0oTW4=;
 b=HPhk1d5l+wPt8uv0r3vukevvuI77xn5kF5VnNpa75uZsSdLhEYMmo5gpvKW4vtXGCgp5Un
 4OXHFjYed9kuOXXvQGkD/DQNEnNdUHZ5Irf/9WBRSGcDsrM+AkJuBiZqXmywlf/li/EeQF
 /cjtbZ3FzDp/dXl0ldGyAYjR6pwEigE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-9hxZMplgPmuoynwmEEwvQg-1; Sun, 31 Dec 2023 03:45:31 -0500
X-MC-Unique: 9hxZMplgPmuoynwmEEwvQg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a23365478e5so434756866b.3
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:45:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012330; x=1704617130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=naLVVkGULG2Mew1FgU3nWncMJvzkAI/2iMH2Lx0oTW4=;
 b=l5FVrfCSd4OFg6UJdoc1HxcZA2OjPUMdhlDj9h1DR6zYAcBIvgk3r3zOiW3iuRRqpk
 pnpzpeyjwKDa+d7RvAn6k/z0TaDFQB4aFW08u8eDY/J3m9aazTeQpLafTElctInpXTgh
 CKNwSB2NcN1+/CI36K9hLiE40XpexYKGG3rfH0YkuQlBPTJ7uEIYcLfikTZmHkqngwv0
 xyVtcCGvWtxdbbUV6OigVD00lcLBNYlT0IlCku980U6GjSlc/LAy+zFrs1CAsKYjXbUm
 r1r+wqERfoKtElOuK/hdiyXn7/s90Ds7q6RFnu2/PzbVJJg1raHcHdOt1tXXr9rq1BKl
 4jRA==
X-Gm-Message-State: AOJu0YxshfXBT9Yk0bP+dHcoHaKrnANSYwfFTzPbS/ImtE/wjhWVhZQb
 dQf7gyJTkvVs4jlMxZVc9dYGkEv2a2ANeiGcpcfHx2Fnc9IignrBTw6AY197m56m3mzBh5bmi4k
 cRB4WK0tYTDif7d0mjqazIw0N76AMwhi6OLjpKr2WfrEbVbI/SlrLm1bYJsaDMNzXn01wNutFUd
 s/6ms1blw=
X-Received: by 2002:a17:907:84d5:b0:a27:248d:d579 with SMTP id
 oh21-20020a17090784d500b00a27248dd579mr3311731ejc.77.1704012329620; 
 Sun, 31 Dec 2023 00:45:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaFX2KnKACOEiFaikCm/IgteBFCanBREgTTC0dO+FHd3CCp/rg8Grzu8mjppE9b4vaCiQsgA==
X-Received: by 2002:a17:907:84d5:b0:a27:248d:d579 with SMTP id
 oh21-20020a17090784d500b00a27248dd579mr3311728ejc.77.1704012329353; 
 Sun, 31 Dec 2023 00:45:29 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a170906160d00b00a27051a9eb6sm5266854ejd.148.2023.12.31.00.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:45:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/46] target/i386: avoid trunc and ext for MULX and RORX
Date: Sun, 31 Dec 2023 09:44:25 +0100
Message-ID: <20231231084502.235366-10-pbonzini@redhat.com>
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

Use _tl operations for 32-bit operands on 32-bit targets, and only go
through trunc and extu ops for 64-bit targets.  While the trunc/ext
ops should be pretty much free after optimization, the optimizer also
does not like having the same temporary used in multiple EBBs.
Therefore it is nicer to not use tmpN* unless necessary.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 98c4c9569ef..f5e44117eab 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1348,7 +1348,8 @@ static void gen_MULX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 
     /* low part of result in VEX.vvvv, high in MODRM */
     switch (ot) {
-    default:
+    case MO_32:
+#ifdef TARGET_X86_64
         tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
         tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
         tcg_gen_mulu2_i32(s->tmp2_i32, s->tmp3_i32,
@@ -1356,13 +1357,15 @@ static void gen_MULX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
         tcg_gen_extu_i32_tl(cpu_regs[s->vex_v], s->tmp2_i32);
         tcg_gen_extu_i32_tl(s->T0, s->tmp3_i32);
         break;
-#ifdef TARGET_X86_64
-    case MO_64:
-        tcg_gen_mulu2_i64(cpu_regs[s->vex_v], s->T0, s->T0, s->T1);
-        break;
-#endif
-    }
 
+    case MO_64:
+#endif
+        tcg_gen_mulu2_tl(cpu_regs[s->vex_v], s->T0, s->T0, s->T1);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static void gen_PALIGNR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
@@ -1765,14 +1768,24 @@ static void gen_PSLLDQ_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *deco
 static void gen_RORX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
-    int b = decode->immediate;
+    int mask = ot == MO_64 ? 63 : 31;
+    int b = decode->immediate & mask;
 
-    if (ot == MO_64) {
-        tcg_gen_rotri_tl(s->T0, s->T0, b & 63);
-    } else {
+    switch (ot) {
+    case MO_32:
+#ifdef TARGET_X86_64
         tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-        tcg_gen_rotri_i32(s->tmp2_i32, s->tmp2_i32, b & 31);
+        tcg_gen_rotri_i32(s->tmp2_i32, s->tmp2_i32, b);
         tcg_gen_extu_i32_tl(s->T0, s->tmp2_i32);
+        break;
+
+    case MO_64:
+#endif
+        tcg_gen_rotri_tl(s->T0, s->T0, b);
+        break;
+
+    default:
+        g_assert_not_reached();
     }
 }
 
-- 
2.43.0


