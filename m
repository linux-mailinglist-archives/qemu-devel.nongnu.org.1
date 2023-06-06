Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55845723705
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 07:58:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6PgV-0004pb-QZ; Tue, 06 Jun 2023 01:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6PgT-0004pD-20
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6PgR-000499-DQ
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686031002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DfFFkSkA+sXqplJuN3OKvutC9SwvPNipO+gGQoPidik=;
 b=KXn1dL2BoRkhL9xLf0WJzGQ+eSZ8bQ0IYCHBzNKgom7Bo7ODllnh+JtP6JRG+NvtmPTU4b
 iYOXF3A2pwNwrdKmrDHSbSe6g1XDH+3w/HWSCxn9q9v7zHFCywGGll8lt+nwXFMWRUDjNS
 /C2PfsTSkwpJujhIWUkMo9aKMPZD9RM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-FXo01DxQObiBCiI6DYeqjg-1; Tue, 06 Jun 2023 01:56:37 -0400
X-MC-Unique: FXo01DxQObiBCiI6DYeqjg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5215A802355;
 Tue,  6 Jun 2023 05:56:37 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD9692166B25;
 Tue,  6 Jun 2023 05:56:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Tulio Magno Quites Machado Filho <tuliom@redhat.com>,
 qemu-stable@nongnu.org, David Hildenbrand <david@redhat.com>
Subject: [PULL 08/18] target/s390x: Fix MXDB and MXDBR
Date: Tue,  6 Jun 2023 07:56:11 +0200
Message-Id: <20230606055621.523175-9-thuth@redhat.com>
In-Reply-To: <20230606055621.523175-1-thuth@redhat.com>
References: <20230606055621.523175-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 target/s390x/helper.h            | 2 +-
 target/s390x/tcg/insn-data.h.inc | 4 ++--
 target/s390x/tcg/fpu_helper.c    | 5 +++--
 target/s390x/tcg/translate.c     | 8 +-------
 4 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 7529e725f2..6bc01df73d 100644
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
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 937e18ea9d..0a45dbbcda 100644
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
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 3eb3708d55..3ac573dfce 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -3421,7 +3421,7 @@ static DisasJumpType op_mxb(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_mxdb(DisasContext *s, DisasOps *o)
 {
-    gen_helper_mxdb(o->out_128, cpu_env, o->in1_128, o->in2);
+    gen_helper_mxdb(o->out_128, cpu_env, o->in1, o->in2);
     return DISAS_NEXT;
 }
 
@@ -5183,12 +5183,6 @@ static void prep_r1_P(DisasContext *s, DisasOps *o)
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
2.31.1


