Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEE181CE57
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:18:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGk4m-00013i-UD; Fri, 22 Dec 2023 13:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4U-0000yo-8r
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4R-0006Be-Jo
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703268985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UJRyN8oLaAmplx7vhdrxTEA7wQ8C13drLYr+oj367gI=;
 b=Ak0ETECGk1Ts24SMTYfPdHlY2RgKz1fHIvFhvv19GXIKjG0DMKqqUGeut9iWiC46jrdhMF
 fXBA5YXiwOjRvFVx+I9+4VShLiqvgknhO6bGFiUD/Q7LB91hhAemUqcU0gT44zb6pcswQU
 YyDUtmN4qjczWapnQr4mS/m720eB3XI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-Q0JBC-kcPQqYJSwgTShdKA-1; Fri, 22 Dec 2023 13:16:23 -0500
X-MC-Unique: Q0JBC-kcPQqYJSwgTShdKA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40d2fa6b23eso17751675e9.2
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:16:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703268982; x=1703873782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UJRyN8oLaAmplx7vhdrxTEA7wQ8C13drLYr+oj367gI=;
 b=Tr7G0Kzyq33oRyoimXagRKXWWvZNpwxFE/ECtP0Mulmizgh615GEPruREuJfwzUesJ
 okgOROMzDiBSxSVS3gagASwbZcVpelIAn1N/bl/PaxLn73rQQZ35Jl3ZnU40YroKddxc
 1yp3lEncVGCf/+qsdvU66aCGTqTEeB4riYku4nDKfoOqTYZZ/9gfOmLUUNV29y4qyMmT
 j0pcMays2S+DZmU/CitINJpWv92khv3Ryvw8M3tXr01hBI+sNSPuQ4sKHKh0dGcBAZZ8
 kjFJXvuigp8XpIcFh5nnMdSl07OMn24Gor3mslE1MFh3Bb1AG9PDK7OiLpHuMTJDgIiq
 uI2g==
X-Gm-Message-State: AOJu0YyGfJA5WQVkTFmVMiOripFGSL2WG7zXGAHfpzEurPMQEt4fMTB6
 orBk+mRvlGB9lSHlpz4dPE5/8bJCCagley09r1V708/3lmFnE4T8J5LpMz3s/gC3glb0O6LOfk8
 vs1mF4KauQK9bfeyAsbl4YFI1Ov13QfyiHc8c1LpTIPViTLdPSpmDimmTCjOQVf5YWFVmx13ocJ
 g0OO2UnbQ=
X-Received: by 2002:a05:600c:1819:b0:40d:190c:160f with SMTP id
 n25-20020a05600c181900b0040d190c160fmr596016wmp.110.1703268981794; 
 Fri, 22 Dec 2023 10:16:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESL//jK0ImxcUNyu5VTWwIhDqefgzktP2jtXBnhwX2W/5en9YnM2hHbk8XGnlCdrV4s13Tqg==
X-Received: by 2002:a05:600c:1819:b0:40d:190c:160f with SMTP id
 n25-20020a05600c181900b0040d190c160fmr596013wmp.110.1703268981490; 
 Fri, 22 Dec 2023 10:16:21 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a05600c138400b0040c03c3289bsm7727763wmf.37.2023.12.22.10.16.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:16:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/22] target/i386: avoid trunc and ext for MULX and RORX
Date: Fri, 22 Dec 2023 19:15:49 +0100
Message-ID: <20231222181603.174137-9-pbonzini@redhat.com>
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

Use _tl operations for 32-bit operands on 32-bit targets, and only go
through trunc and extu ops for 64-bit targets.  While the trunc/ext
ops should be pretty much free after optimization, the optimizer also
does not like having the same temporary used in multiple EBBs.
Therefore it is nicer to not use tmpN* unless necessary.

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


