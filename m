Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 147967972A9
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:11:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEck-0002hr-Bn; Thu, 07 Sep 2023 09:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcg-0002gZ-RC
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcd-00079k-7b
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VcQp4Nu7qms1E618oj3yKlSa39t/aiTfJUe0HGYoCPA=;
 b=WTP9WCGST0YZKQF5KT37FNktaKRqzNQEJGsuC8ELE+Gu5hy27mJrrfoS4YL2dManvcuLBf
 CFWixWM1Pe2X3uJ70+TXW3crScQVJ5rc9stas0vfNbTfrzCTbbmtYpGRu5BDNwF4DsftPW
 ieN1Qb+yGcUfzfgfr1c3LfIkpF/DwkQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-3oA6t2L5P2W8kvVmOH8Q3Q-1; Thu, 07 Sep 2023 09:00:26 -0400
X-MC-Unique: 3oA6t2L5P2W8kvVmOH8Q3Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fefea09bd0so6263385e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091617; x=1694696417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VcQp4Nu7qms1E618oj3yKlSa39t/aiTfJUe0HGYoCPA=;
 b=XddcftyT6D3eI0LO7/BaOs685pjzRqM+t4bWFWD58TtJd069VBCzSRwodoW2HvLW1Z
 rCj7OphYN1Df6U+/FCi6cvqUMo5jDKKp7HCwyr4LJt6eEiHdfPlIoPvrJ12Ec8tjBDUE
 HxqE57tUNqMEh9AwFPEnH0aMf+wVITBpMJ2vcFtEki+rJva8LV0hDBxoOvb04WkZgcp6
 WBnmkWtaRnxCxPiCEmz/s9yWXM5lvpRNtoq1mcs/Ru6LNVsRzwND7V9Ndcyhwlr/tOTH
 250XpKGzzgDlP+0qx86gWsgJ6TNPgH8am1tU7k0N9iDT/6juDrePzuK+TSPVPjr3EWAW
 nAIA==
X-Gm-Message-State: AOJu0YxpXn2ajGZ6c2oC+r7BBP9QDCgZVGtw0xfzCQErALIbhEGpV7FI
 79TCDhdrsoDGMPkjl/5OE0Tl6Fsv8sVNyjAGtAJT4c/LHfsGARH002jWUTxn9PzJbHIcDlDxGRV
 PX/VDJ3lHbcl4UKJeiH1Ee7qmz/Kb/Qxp0EtjCWYlOAp13Xsj0B2+GU7jGbMS3XkvZESyON9bsU
 U=
X-Received: by 2002:a5d:6548:0:b0:317:71bb:7ccd with SMTP id
 z8-20020a5d6548000000b0031771bb7ccdmr4750824wrv.52.1694091617314; 
 Thu, 07 Sep 2023 06:00:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8tkYMaOrZgfrRZouugKg1n/Ksvi+CNftQMS7XHjQIP05ndvrMGiBPUEjGITkYn9zYRTOwPw==
X-Received: by 2002:a5d:6548:0:b0:317:71bb:7ccd with SMTP id
 z8-20020a5d6548000000b0031771bb7ccdmr4750809wrv.52.1694091616975; 
 Thu, 07 Sep 2023 06:00:16 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 h8-20020a5d4fc8000000b0031ae8d86af4sm23106908wrw.103.2023.09.07.06.00.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:00:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/51] target/i386: fix memory operand size for CVTPS2PD
Date: Thu,  7 Sep 2023 14:59:13 +0200
Message-ID: <20230907130004.500601-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
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

CVTPS2PD only loads a half-register for memory, unlike the other
operations under 0x0F 0x5A.  "Unpack" the group into separate
emission functions instead of using gen_unary_fp_sse.

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


