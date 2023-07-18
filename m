Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5ED75874D
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 23:37:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLsMJ-0007Kw-Gr; Tue, 18 Jul 2023 17:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qLsMH-0007IF-19; Tue, 18 Jul 2023 17:35:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qLsMF-0003FE-CE; Tue, 18 Jul 2023 17:35:48 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36ILX9Nx012468; Tue, 18 Jul 2023 21:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=C7Dq1ZVTtH/FB3gKs5xqk+gaafVUk110/O7Ntyyyg48=;
 b=S8LH6IfH3B1lR09rL2G5AVhlUimOPJnfR9CfZsTY4JH+VG1yb9XG5mbSRzxNxUBqxR8e
 VjPBsqbSF/tT5P5CoOvISwSNyVoFnS1jkXIsQXLAjiZIveaz4aWJ2lld9U2eSP1Wk0Z5
 f6jNhF8Us6uajugZ2QT5fR8qUeSgBRy/LGeCbZI0fM56bL51yWB6xKduQH3t97X/MCaq
 j4cIgUnseTEzTB7yu08r19mSZZKHAmJ+9bpUvnHpBnZ2iIIsjBOuXc519G4nCpWikGSx
 X9pKgydAgrfMTPw8FZD5x9MXQJ51hh4nm3cQJgPtjLDK3l+3wigjd4pq9Qh2CaHkntf7 CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rx2rb045p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 21:35:43 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36ILXfJl014447;
 Tue, 18 Jul 2023 21:35:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rx2rb0452-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 21:35:42 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36IJUGvf005272; Tue, 18 Jul 2023 21:35:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv65xekp0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 21:35:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36ILZdmr62783954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jul 2023 21:35:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68AD520043;
 Tue, 18 Jul 2023 21:35:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E867E2004B;
 Tue, 18 Jul 2023 21:35:38 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.14.165])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Jul 2023 21:35:38 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH 01/14] target/s390x: Make CKSM raise an exception if R2 is odd
Date: Tue, 18 Jul 2023 23:21:02 +0200
Message-ID: <20230718213531.117976-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718213531.117976-1-iii@linux.ibm.com>
References: <20230718213531.117976-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QuQ0_RBBpiAqp8bwc79RMcgJKdJrPFYO
X-Proofpoint-GUID: pfCfh_qqP2IUFp0hpYuUpok4FdCY0Hyj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_17,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=641 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180196
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

R2 designates an even-odd register pair; the instruction should raise
a specification exception when R2 is not even.

Cc: qemu-stable@nongnu.org
Fixes: e023e832d0ac ("s390x: translate engine for s390x CPU")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/translate.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 6661b27efa4..2f61e879878 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -1991,11 +1991,18 @@ static DisasJumpType op_cxlgb(DisasContext *s, DisasOps *o)
 static DisasJumpType op_cksm(DisasContext *s, DisasOps *o)
 {
     int r2 = get_field(s, r2);
-    TCGv_i128 pair = tcg_temp_new_i128();
-    TCGv_i64 len = tcg_temp_new_i64();
+    TCGv_i128 pair;
+    TCGv_i64 len;
+
+    if (r2 & 1) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
 
+    pair = tcg_temp_new_i128();
     gen_helper_cksm(pair, cpu_env, o->in1, o->in2, regs[r2 + 1]);
     set_cc_static(s);
+    len = tcg_temp_new_i64();
     tcg_gen_extr_i128_i64(o->out, len, pair);
 
     tcg_gen_add_i64(regs[r2], regs[r2], len);
-- 
2.41.0


