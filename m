Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A10AB78C9F6
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:54:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1yP-0002rO-3R; Tue, 29 Aug 2023 12:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qb1xu-0002ps-GR
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:53:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qb1xq-0002zv-Co
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693327993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QxYaDWJwA3ZsqeqTvkgL7faOR43INvEVDPD5ENQy8I0=;
 b=HCJrj5AhjF4UZkzqmXq5IfIT63CXn0aqXRor3oGr9KqhFuNKGnZ7kKf818JTV54BjwLJwA
 MYMdUJkdCQT88cidMDpwvgMZvDflRUi8RjgAzvzFsRrXksCLIrzCsa/S4fe/RGb2vVr77u
 cFc6iNQKNgmD33CyDSGd1rZTfBhQo/A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-xtktc21oNsaEHq-0ogWcLw-1; Tue, 29 Aug 2023 12:53:11 -0400
X-MC-Unique: xtktc21oNsaEHq-0ogWcLw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-401b8089339so28187135e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 09:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693327990; x=1693932790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QxYaDWJwA3ZsqeqTvkgL7faOR43INvEVDPD5ENQy8I0=;
 b=BZ7iaKJ8KcPXa0ZLCR5ztoDjd7fZj3lfZ0KjWIvDLCjsFwL21SYDrqqlCBkxJqEEQ6
 faht7Tu+pFSx6fPu64p0dK2tyz88K/MWdDVwl7bJMcn5Qoc/YGeSX9g9JqrnPyN59Gyd
 ur9qr5cIWY110XCTCrkcLLnM7SSqvqOE2ajxQAwtOgiHpC6iU2W5wLyu2isre4GYSTqw
 QDN3cjrISQAPVEx197iY5fq5b3ZWilYXWwY7uT3Cqy5Ojyo6mI1FJXmD28GVI+pFXFu4
 LlTvUwKDo2IXLLhI+PsB6xK2xzeIOE2UZK2ImUH3X9ELp5mime/Lr3six+HA9bWtbzSm
 0SvQ==
X-Gm-Message-State: AOJu0YwMu/XlSUAY+mbCye7k6jkzcxHVuyjXDUzXkLxfwGrVwP1P2Drv
 1/W8nWJ1Ad80HLgwG5JEUi86fLk9EXyuTR7OK6nkEzbppaSNfh6ZvANFiRymYcIb/gUA1IoMaKy
 7FgUPZD28do7ngBqEr2eIQj9CT2iuWTJMs2VVleDWVbO5aMbWq2TlMIWoVxq8gq9dkwR8z22OHI
 Y=
X-Received: by 2002:a05:600c:255:b0:3fe:90f:8496 with SMTP id
 21-20020a05600c025500b003fe090f8496mr21794461wmj.1.1693327990087; 
 Tue, 29 Aug 2023 09:53:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFWjQSQyVnZ8N3k23rtbbGYtyJTfnwZrtU9HuX7xLD28h0hBZokLrQ5s41175wYZ+1XyC1sA==
X-Received: by 2002:a05:600c:255:b0:3fe:90f:8496 with SMTP id
 21-20020a05600c025500b003fe090f8496mr21794444wmj.1.1693327989667; 
 Tue, 29 Aug 2023 09:53:09 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 y24-20020a1c4b18000000b003fc01189b0dsm14399870wma.42.2023.08.29.09.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 09:53:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 2/2] target/i386: fix memory operand size for CVTPS2PD
Date: Tue, 29 Aug 2023 18:53:04 +0200
Message-ID: <20230829165304.114948-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829165304.114948-1-pbonzini@redhat.com>
References: <20230829165304.114948-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

CVTPS2PD only loads a half-register for memory, unlike the other
operations under 0x0F 0x5A.  "Unpack" the group into separate
emission functions instead of using gen_unary_fp_sse.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1377
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 14 ++++++++++++--
 target/i386/tcg/emit.c.inc       | 30 +++++++++++++++++++++++++-----
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 43c39aad2aa..0db19cda3b7 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -805,10 +805,20 @@ static void decode_sse_unary(DisasContext *s, CPUX86State *env, X86OpEntry *entr
     case 0x51: entry->gen = gen_VSQRT; break;
     case 0x52: entry->gen = gen_VRSQRT; break;
     case 0x53: entry->gen = gen_VRCP; break;
-    case 0x5A: entry->gen = gen_VCVTfp2fp; break;
     }
 }
 
+static void decode_0F5A(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    static const X86OpEntry opcodes_0F5A[4] = {
+        X86_OP_ENTRY2(VCVTPS2PD,  V,x,       W,xh, vex2),      /* VCVTPS2PD */
+        X86_OP_ENTRY2(VCVTPD2PS,  V,x,       W,x,  vex2),      /* VCVTPD2PS */
+        X86_OP_ENTRY3(VCVTSS2SD,  V,x,  H,x, W,x,  vex2_rep3), /* VCVTSS2SD */
+        X86_OP_ENTRY3(VCVTSD2SS,  V,x,  H,x, W,x,  vex2_rep3), /* VCVTSD2SS */
+    };
+    *entry = *decode_by_prefix(s, opcodes_0F5A);
+}
+
 static void decode_0F5B(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
     static const X86OpEntry opcodes_0F5B[4] = {
@@ -891,7 +901,7 @@ static const X86OpEntry opcodes_0F[256] = {
 
     [0x58] = X86_OP_ENTRY3(VADD,       V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2),
     [0x59] = X86_OP_ENTRY3(VMUL,       V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2),
-    [0x5a] = X86_OP_GROUP3(sse_unary,  V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2), /* CVTPS2PD */
+    [0x5a] = X86_OP_GROUP0(0F5A),
     [0x5b] = X86_OP_GROUP0(0F5B),
     [0x5c] = X86_OP_ENTRY3(VSUB,       V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2),
     [0x5d] = X86_OP_ENTRY3(VMIN,       V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2),
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 4fe8dec4274..45a3e55cbfb 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1914,12 +1914,22 @@ static void gen_VCOMI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     set_cc_op(s, CC_OP_EFLAGS);
 }
 
-static void gen_VCVTfp2fp(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+static void gen_VCVTPD2PS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
-    gen_unary_fp_sse(s, env, decode,
-                     gen_helper_cvtpd2ps_xmm, gen_helper_cvtps2pd_xmm,
-                     gen_helper_cvtpd2ps_ymm, gen_helper_cvtps2pd_ymm,
-                     gen_helper_cvtsd2ss, gen_helper_cvtss2sd);
+    if (s->vex_l) {
+        gen_helper_cvtpd2ps_ymm(cpu_env, OP_PTR0, OP_PTR2);
+    } else {
+        gen_helper_cvtpd2ps_xmm(cpu_env, OP_PTR0, OP_PTR2);
+    }
+}
+
+static void gen_VCVTPS2PD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    if (s->vex_l) {
+        gen_helper_cvtps2pd_ymm(cpu_env, OP_PTR0, OP_PTR2);
+    } else {
+        gen_helper_cvtps2pd_xmm(cpu_env, OP_PTR0, OP_PTR2);
+    }
 }
 
 static void gen_VCVTPS2PH(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
@@ -1936,6 +1946,16 @@ static void gen_VCVTPS2PH(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     }
 }
 
+static void gen_VCVTSD2SS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_helper_cvtsd2ss(cpu_env, OP_PTR0, OP_PTR1, OP_PTR2);
+}
+
+static void gen_VCVTSS2SD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_helper_cvtss2sd(cpu_env, OP_PTR0, OP_PTR1, OP_PTR2);
+}
+
 static void gen_VCVTSI2Sx(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     int vec_len = vector_len(s, decode);
-- 
2.41.0


