Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BD67E1D58
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 10:39:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzw4d-00008I-PH; Mon, 06 Nov 2023 04:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qzw4b-00007C-Dv; Mon, 06 Nov 2023 04:39:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qzw4Y-0005Bo-Ur; Mon, 06 Nov 2023 04:39:09 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A69cvh5000944; Mon, 6 Nov 2023 09:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=kxR4nMD37Fqq16IvfOZUjvw7mFaK6wKOk0tlCrXuZJ4=;
 b=BZnyIJGuk1rBaCpFMIktZjXjbl6liZT/gU6uuv+iE9ON7ZcWlz8Wt06Q62hftwIgPvNB
 mT3JrqyUErZwDgmoIvi6cUbx/T3KoXZ81KgxURtu80fQ+2vSnRQLcbO8LArFAmjbYbPo
 oAE1g5ZXMjdjfH+BVlBGTzHPN2fkMzsSwIB55b7qS+qDP3yKOBcUunD63bYMLSWzj0LZ
 bgoAbxq9chGCxmq+Gvdv/BVx3Axy2dMro016AO6y2fBRTBxq49Hl2V2i2IF7fYmLZfMw
 /Ga68bbUnXIGtrSTvZjyV8exslcLW2kWO89Ufp71+cgrt0lqvBXQLKiAIpkFpgDThnqv +A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6vn5a2gx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Nov 2023 09:39:01 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A68SNvm015953;
 Mon, 6 Nov 2023 09:39:00 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6vn5a1nj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Nov 2023 09:38:59 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A67Mb7i012826; Mon, 6 Nov 2023 09:36:14 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u609sgjf1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Nov 2023 09:36:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A69aCom16581302
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Nov 2023 09:36:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49A3D2004B;
 Mon,  6 Nov 2023 09:36:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1BDF20040;
 Mon,  6 Nov 2023 09:36:11 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.47.192])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Nov 2023 09:36:11 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 1/5] target/s390x: Fix CLC corrupting cc_src
Date: Mon,  6 Nov 2023 10:31:22 +0100
Message-ID: <20231106093605.1349201-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106093605.1349201-1-iii@linux.ibm.com>
References: <20231106093605.1349201-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zjYXyQp-JI9XpuMu0TLPvG8nDvJJuXGD
X-Proofpoint-ORIG-GUID: RTer3tzea9MPdjtiT2b3Iw8r4KlYTvg1
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_07,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060082
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

CLC updates cc_src before accessing the second operand; if the latter
is inaccessible, the former ends up containing a bogus value.

Fix by reading cc_src into a temporary first.

Fixes: 4f7403d52b1c ("target-s390: Convert CLC")
Closes: https://gitlab.com/qemu-project/qemu/-/issues/1865
Cc: qemu-stable@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


