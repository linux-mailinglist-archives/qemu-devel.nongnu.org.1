Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7162A73EA9E
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 20:56:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrK5-0007pe-9s; Mon, 26 Jun 2023 14:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrJz-0007dz-Ja; Mon, 26 Jun 2023 14:52:19 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrJx-00056l-Cs; Mon, 26 Jun 2023 14:52:19 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8F7F5EF2E;
 Mon, 26 Jun 2023 21:50:22 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1C8D3F7BD;
 Mon, 26 Jun 2023 21:50:21 +0300 (MSK)
Received: (nullmailer pid 1574027 invoked by uid 1000);
 Mon, 26 Jun 2023 18:50:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Tulio Magno Quites Machado Filho <tuliom@redhat.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 23/54] target/s390x: Fix MXDB and MXDBR
Date: Mon, 26 Jun 2023 21:49:30 +0300
Message-Id: <20230626185002.1573836-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

These instructions multiply 64 bits by 64 bits, not 128 bits by 64 bits.

Reported-by: Tulio Magno Quites Machado Filho <tuliom@redhat.com>
Fixes: 2b91240f95fd ("target/s390x: Use Int128 for passing float128")
Cc: qemu-stable@nongnu.org
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2211472
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230601223027.795501-2-iii@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit a7f4add7931ef91285fc3d89e6b3842115e09048)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 341bc51ec2..f629f0fbcf 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -50,7 +50,7 @@ DEF_HELPER_FLAGS_3(meeb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(mdeb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(mdb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(mxb, TCG_CALL_NO_WG, i128, env, i128, i128)
-DEF_HELPER_FLAGS_3(mxdb, TCG_CALL_NO_WG, i128, env, i128, i64)
+DEF_HELPER_FLAGS_3(mxdb, TCG_CALL_NO_WG, i128, env, i64, i64)
 DEF_HELPER_FLAGS_2(ldeb, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_3(ldxb, TCG_CALL_NO_WG, i64, env, i128, i32)
 DEF_HELPER_FLAGS_2(lxdb, TCG_CALL_NO_WG, i128, env, i64)
diff --git a/target/s390x/tcg/fpu_helper.c b/target/s390x/tcg/fpu_helper.c
index 0bdab5bcf7..57e5829283 100644
--- a/target/s390x/tcg/fpu_helper.c
+++ b/target/s390x/tcg/fpu_helper.c
@@ -321,10 +321,11 @@ Int128 HELPER(mxb)(CPUS390XState *env, Int128 a, Int128 b)
 }
 
 /* 128/64-bit FP multiplication */
-Int128 HELPER(mxdb)(CPUS390XState *env, Int128 a, uint64_t f2)
+Int128 HELPER(mxdb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 {
+    float128 f1_128 = float64_to_float128(f1, &env->fpu_status);
     float128 ret = float64_to_float128(f2, &env->fpu_status);
-    ret = float128_mul(ARG128(a), ret, &env->fpu_status);
+    ret = float128_mul(f1_128, ret, &env->fpu_status);
     handle_exceptions(env, false, GETPC());
     return RET128(ret);
 }
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 69de0c0a29..a586cc515b 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -668,11 +668,11 @@
     F(0xb31c, MDBR,    RRE,   Z,   f1, f2, new, f1, mdb, 0, IF_BFP)
     F(0xb34c, MXBR,    RRE,   Z,   x1, x2, new_x, x1, mxb, 0, IF_BFP)
     F(0xb30c, MDEBR,   RRE,   Z,   f1, e2, new, f1, mdeb, 0, IF_BFP)
-    F(0xb307, MXDBR,   RRE,   Z,   0, f2, x1, x1, mxdb, 0, IF_BFP)
+    F(0xb307, MXDBR,   RRE,   Z,   f1, f2, new_x, x1, mxdb, 0, IF_BFP)
     F(0xed17, MEEB,    RXE,   Z,   e1, m2_32u, new, e1, meeb, 0, IF_BFP)
     F(0xed1c, MDB,     RXE,   Z,   f1, m2_64, new, f1, mdb, 0, IF_BFP)
     F(0xed0c, MDEB,    RXE,   Z,   f1, m2_32u, new, f1, mdeb, 0, IF_BFP)
-    F(0xed07, MXDB,    RXE,   Z,   0, m2_64, x1, x1, mxdb, 0, IF_BFP)
+    F(0xed07, MXDB,    RXE,   Z,   f1, m2_64, new_x, x1, mxdb, 0, IF_BFP)
 /* MULTIPLY HALFWORD */
     C(0x4c00, MH,      RX_a,  Z,   r1_o, m2_16s, new, r1_32, mul, 0)
     C(0xe37c, MHY,     RXY_a, GIE, r1_o, m2_16s, new, r1_32, mul, 0)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 056594300a..82900f53f4 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -3439,7 +3439,7 @@ static DisasJumpType op_mxb(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_mxdb(DisasContext *s, DisasOps *o)
 {
-    gen_helper_mxdb(o->out_128, cpu_env, o->in1_128, o->in2);
+    gen_helper_mxdb(o->out_128, cpu_env, o->in1, o->in2);
     return DISAS_NEXT;
 }
 
@@ -5207,12 +5207,6 @@ static void prep_r1_P(DisasContext *s, DisasOps *o)
 }
 #define SPEC_prep_r1_P SPEC_r1_even
 
-static void prep_x1(DisasContext *s, DisasOps *o)
-{
-    o->out_128 = load_freg_128(get_field(s, r1));
-}
-#define SPEC_prep_x1 SPEC_r1_f128
-
 /* ====================================================================== */
 /* The "Write OUTput" generators.  These generally perform some non-trivial
    copy of data to TCG globals, or to main memory.  The trivial cases are
-- 
2.39.2


