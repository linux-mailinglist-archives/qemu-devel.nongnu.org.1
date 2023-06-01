Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9553C71F5F3
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 00:31:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4qos-0004TV-Hq; Thu, 01 Jun 2023 18:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q4qoe-00041z-Mz; Thu, 01 Jun 2023 18:30:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q4qoc-0005SC-0Z; Thu, 01 Jun 2023 18:30:43 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 351MCJcV015702; Thu, 1 Jun 2023 22:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ceFunXFB+d4uVJ+AT12r24j02i71/Kn8kMDYR5Tn1J0=;
 b=oHyFGWOVe3EYFGPSIQYZOraLg+muaGau/Oj36zyY9Zf5OGNBb+hISDikvG2BUqnILT/a
 deMKecexQ0zjI5yAcwYiAVVrNMzH3wIo6X0fEzH//S/ER3Rqo96q5dqsnmzlv/M9YK4D
 Vkwii9RgimdU34B8yAgj8/ntktFD8qKi4OAxFTKezmPxrQDrS4pcx+Hd+R/ChyJl1nTY
 eRUsI7Tf793u3FdHx46meyO4LSfHMRB/SKlZlovwefi8WTUelOBu+8+iIp1fs17GZcqP
 gsu4Vu8OCIDIz+eOcb1ag/rtVFYvGA4lrzwxWVAxT6EfXOxEkdQn9r7RoIGooyRJrpQ+ 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qy3wr0aft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 22:30:39 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 351MDwiM019999;
 Thu, 1 Jun 2023 22:30:38 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qy3wr0af1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 22:30:38 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 351MIv7D028367;
 Thu, 1 Jun 2023 22:30:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3qu9g529rc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 22:30:35 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 351MUXXH8258054
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Jun 2023 22:30:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 867BA2004D;
 Thu,  1 Jun 2023 22:30:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CBCD20043;
 Thu,  1 Jun 2023 22:30:33 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.86.130])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Jun 2023 22:30:32 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Tulio Magno Quites Machado Filho <tuliom@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 1/2] target/s390x: Fix MXDB and MXDBR
Date: Fri,  2 Jun 2023 00:30:26 +0200
Message-Id: <20230601223027.795501-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601223027.795501-1-iii@linux.ibm.com>
References: <20230601223027.795501-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Taq9tTHaMglgoH5WqyfaFPxt1FGSUcGp
X-Proofpoint-ORIG-GUID: A5nhVbrqcbHPD86QQnC4z_Hb8FfPeTDI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=836 impostorscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010190
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

These instructions multiply 64 bits by 64 bits, not 128 bits by 64 bits.

Reported-by: Tulio Magno Quites Machado Filho <tuliom@redhat.com>
Fixes: 2b91240f95fd ("target/s390x: Use Int128 for passing float128")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/helper.h            | 2 +-
 target/s390x/tcg/fpu_helper.c    | 5 +++--
 target/s390x/tcg/insn-data.h.inc | 4 ++--
 target/s390x/tcg/translate.c     | 8 +-------
 4 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 7529e725f29..6bc01df73d7 100644
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
index 0bdab5bcf71..57e58292833 100644
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
index 937e18ea9d9..0a45dbbcda8 100644
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
index 3eb3708d551..3ac573dfce5 100644
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
2.40.1


