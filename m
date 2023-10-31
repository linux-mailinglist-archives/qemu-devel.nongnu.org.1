Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D350B7DC5FE
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 06:38:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxhRl-0003dD-74; Tue, 31 Oct 2023 01:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qxhRf-0003bs-3v; Tue, 31 Oct 2023 01:37:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qxhRb-00047N-NI; Tue, 31 Oct 2023 01:37:42 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39V5EhFq024348; Tue, 31 Oct 2023 05:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=qJ9n4AgAqSXM7N3Qg5ES9aYuAAlbyUZrSikXZM/JzaM=;
 b=Mp7RsJNG0fCSfKfW4nqo55gPPPQDZycH7QMavMbniQDiII/s2lIx9pdqYPdJv9/6Vtna
 8dG5zNJnR763L/6A5YiHBcYNjNcWMT+vgYqSykgJgv4QpISv6XLqbHQ4OfJySCus9aOW
 /YuYO5ph9ANxBiW4vUtC7vtNl+IADEsV8acnPt6r6uILm5+BxCaGNGoo9PNSLKtdUYAs
 7a12uteByA8FyxSjt2rT8OULv/xG/EgHcK0zUKDtCsne1zL1IZqgMYzhvJaJfIxiz2nL
 1lhUwmXNACvVK1vo7paVnQTdLxS/RdNury2k65c+XTK/xpPXX2XxTUz0aRWYS0OcdMvp qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2u8sgx64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Oct 2023 05:37:34 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39V5GC1a028858;
 Tue, 31 Oct 2023 05:37:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2u8sgwsc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Oct 2023 05:37:31 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39V5NMpV011576; Tue, 31 Oct 2023 05:37:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1e4kp30j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Oct 2023 05:37:26 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39V5bOmx21758660
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Oct 2023 05:37:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 060EA20040;
 Tue, 31 Oct 2023 05:37:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A6ED20043;
 Tue, 31 Oct 2023 05:37:23 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.47.192])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 31 Oct 2023 05:37:23 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH 1/4] target/s390x: Fix CLC corrupting cc_src
Date: Tue, 31 Oct 2023 06:32:27 +0100
Message-ID: <20231031053718.347100-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031053718.347100-1-iii@linux.ibm.com>
References: <20231031053718.347100-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7I6PLKdrsu1BB8OIN-oktsfR7-9G9WXz
X-Proofpoint-ORIG-GUID: jF9nHxDHCn0KyyMF2SIKmnAk20agoEe2
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310042
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

CLC updates cc_src before accessing the second operand; if the latter
is inaccessible, the former ends up containing a bogus value.

Fix by reading cc_src into a temporary first.

Fixes: 4f7403d52b1c ("target-s390: Convert CLC")
Closes: https://gitlab.com/qemu-project/qemu/-/issues/1865
Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/translate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 4bae1509f50..a0d6a2a35dd 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2007,6 +2007,7 @@ static DisasJumpType op_cksm(DisasContext *s, DisasOps *o)
 static DisasJumpType op_clc(DisasContext *s, DisasOps *o)
 {
     int l = get_field(s, l1);
+    TCGv_i64 src;
     TCGv_i32 vl;
     MemOp mop;
 
@@ -2016,9 +2017,11 @@ static DisasJumpType op_clc(DisasContext *s, DisasOps *o)
     case 4:
     case 8:
         mop = ctz32(l + 1) | MO_TE;
-        tcg_gen_qemu_ld_tl(cc_src, o->addr1, get_mem_index(s), mop);
+        /* Do not update cc_src yet: loading cc_dst may cause an exception. */
+        src = tcg_temp_new_i64();
+        tcg_gen_qemu_ld_tl(src, o->addr1, get_mem_index(s), mop);
         tcg_gen_qemu_ld_tl(cc_dst, o->in2, get_mem_index(s), mop);
-        gen_op_update2_cc_i64(s, CC_OP_LTUGTU_64, cc_src, cc_dst);
+        gen_op_update2_cc_i64(s, CC_OP_LTUGTU_64, src, cc_dst);
         return DISAS_NEXT;
     default:
         vl = tcg_constant_i32(l);
-- 
2.41.0


