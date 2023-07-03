Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5C9746039
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 17:59:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGLwa-0002is-3v; Mon, 03 Jul 2023 11:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGLwY-0002hi-Im; Mon, 03 Jul 2023 11:58:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGLwW-0004hn-TX; Mon, 03 Jul 2023 11:58:26 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 363FqS0m031441; Mon, 3 Jul 2023 15:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wQblCussiMCvhqea1FBa4KdXrBJ5oR7nwvySTNjZt08=;
 b=JSoAlGyJKD7Uu+QKwlG1UggN+9/V9kk1KgD5vHB+oJK3SynqgvcFM4W/K1sVg39C0hZs
 40oPwsxp0U7Gw30ixkLYI5MwPB/j3cdRfx776F/iU5OkQQXOZQ5ncaG1Dwdq7Nd7saNe
 8w1apZPuhDq853QAujO1DeAjIHrz90oX3DSUqphq42i2rq5r6VzozIhxJvf8+1gVGr9B
 SUqgXrHTYcCkiHbuVmIiHo192WciDuN6HK6SKAusKVsVl9xHzjp72nhusE8Oy/QmAQeD
 8XtLxRKWMQUxbQfeX2mIe8v5b8LbE1kF2xoBX0fC/ytvIojJJnQhXTKWZ2RaDmiYuWms ow== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm1bmg3g8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:22 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 363FvSSl012626;
 Mon, 3 Jul 2023 15:58:22 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm1bmg3ff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:22 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 363DlcDm003252;
 Mon, 3 Jul 2023 15:58:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3rjbs4s1ps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:20 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 363FwHZP10420816
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Jul 2023 15:58:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C153220043;
 Mon,  3 Jul 2023 15:58:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95BF120040;
 Mon,  3 Jul 2023 15:58:17 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Jul 2023 15:58:17 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 05/12] target/s390x: Fix LRA overwriting the top 32 bits on
 DAT error
Date: Mon,  3 Jul 2023 17:50:31 +0200
Message-ID: <20230703155801.179167-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703155801.179167-1-iii@linux.ibm.com>
References: <20230703155801.179167-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rMRLfV5AFNugcTHcHXtzfQ-c6ZDNqtsY
X-Proofpoint-GUID: fPoDSyVdGXkUPQBA0PILHt6o7wjcn-vu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=823 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030141
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

When a DAT error occurs, LRA is supposed to write the error information
to the bottom 32 bits of R1, and leave the top 32 bits of R1 alone.

Fix by passing the original value of R1 into helper and copying the
top 32 bits to the return value.

Fixes: d8fe4a9c284f ("target-s390: Convert LRA")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/helper.h         | 2 +-
 target/s390x/tcg/mem_helper.c | 4 ++--
 target/s390x/tcg/translate.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 6bc01df73d7..05102578fc9 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -355,7 +355,7 @@ DEF_HELPER_FLAGS_4(idte, TCG_CALL_NO_RWG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_4(ipte, TCG_CALL_NO_RWG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_1(ptlb, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_1(purge, TCG_CALL_NO_RWG, void, env)
-DEF_HELPER_2(lra, i64, env, i64)
+DEF_HELPER_3(lra, i64, env, i64, i64)
 DEF_HELPER_1(per_check_exception, void, env)
 DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_RWG, void, env, i64, i64)
 DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_RWG, void, env, i64)
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 84ad85212c9..94d93d7ea78 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -2356,7 +2356,7 @@ void HELPER(purge)(CPUS390XState *env)
 }
 
 /* load real address */
-uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
+uint64_t HELPER(lra)(CPUS390XState *env, uint64_t r1, uint64_t addr)
 {
     uint64_t asc = env->psw.mask & PSW_MASK_ASC;
     uint64_t ret, tec;
@@ -2370,7 +2370,7 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
     exc = mmu_translate(env, addr, MMU_S390_LRA, asc, &ret, &flags, &tec);
     if (exc) {
         cc = 3;
-        ret = exc | 0x80000000;
+        ret = (r1 & 0xFFFFFFFF00000000) | exc | 0x80000000;
     } else {
         cc = 0;
         ret |= addr & ~TARGET_PAGE_MASK;
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 0cef6efbef4..a6079ab7b4f 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2932,7 +2932,7 @@ static DisasJumpType op_lctlg(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_lra(DisasContext *s, DisasOps *o)
 {
-    gen_helper_lra(o->out, cpu_env, o->in2);
+    gen_helper_lra(o->out, cpu_env, o->out, o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
 }
-- 
2.41.0


