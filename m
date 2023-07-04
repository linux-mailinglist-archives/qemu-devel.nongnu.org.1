Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55957746BAC
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:16:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbCc-0003Z8-O6; Tue, 04 Jul 2023 04:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGbCH-0003TP-8Y; Tue, 04 Jul 2023 04:15:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGbCE-0002eq-JR; Tue, 04 Jul 2023 04:15:40 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36487Wf5012224; Tue, 4 Jul 2023 08:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wD2lJ9kt2eU5qLvJHqe321hjvV9uFhdYk/Bn8qdy5nE=;
 b=h4aSgJ+8ph0v2yRtADgzNjL7xVj8dWeSet3QThWNrTxlJWrsnM+XBBIaL/x1uFR2dius
 HuW0ukyJVsoAS06iFrDxBS6CGOWJ1j9bN4GGUgXAsmqoEjY3+q3dWSyjXsZyE46nuyC+
 kG18Y1SRnFiftvoVsGjqVf17+7ow1dy+bo4OM8oRrqsOarVJnUtTKgvQFgwnR8XDQrOR
 di7tyRvXs9q3qr8rZybVoubywjh29Q0iaZ9xjsiYwBOHrSIBaJ5muUbUAl2elWUUNyjI
 l6FVa0Qceg2Qs+gE85e2Ejg18iCDBwuc4VYMDXag/Y+pGbcaq0Wgn21xMwgVXZDb3Jqw +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmfbb8jkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:15:33 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36489dUO020998;
 Tue, 4 Jul 2023 08:15:32 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmfbb8jgj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:15:32 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3644V0VZ014180;
 Tue, 4 Jul 2023 08:15:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3rjbs51cms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:15:28 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3648FQr619595782
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Jul 2023 08:15:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31DB020043;
 Tue,  4 Jul 2023 08:15:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BA9320040;
 Tue,  4 Jul 2023 08:15:25 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.30.217])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Jul 2023 08:15:25 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 05/12] target/s390x: Fix LRA overwriting the top 32 bits on
 DAT error
Date: Tue,  4 Jul 2023 10:12:29 +0200
Message-ID: <20230704081506.276055-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704081506.276055-1-iii@linux.ibm.com>
References: <20230704081506.276055-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z61TYlPHD-gs5zA14gH-i51Qd9tMSnPp
X-Proofpoint-ORIG-GUID: 2RfbP_l73bnxzYKzKHeUpL247dLOe8tP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_04,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 mlxlogscore=822 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040065
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
index 84ad85212c9..f417fb1183c 100644
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
+        ret = (r1 & 0xFFFFFFFF00000000ULL) | exc | 0x80000000;
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


