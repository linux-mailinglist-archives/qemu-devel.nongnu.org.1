Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E71382AAD8
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 10:25:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNrIx-0000UU-MG; Thu, 11 Jan 2024 04:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rNrIm-0000P2-Ck; Thu, 11 Jan 2024 04:24:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rNrIh-0005L4-2r; Thu, 11 Jan 2024 04:24:39 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40B8q3NT002044; Thu, 11 Jan 2024 09:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=j19B33h/J67hFYtwQ5Va0l6o8N7i5Utc9+DKHkALil4=;
 b=Wj0ikitSmPgTRk5h5upH6k7lxBXXPg3NAC6RnJlly1WI0UT0qSBk4uUA5fIUPCtkRL4F
 oCBNtlnPdygbazhrHyoaDSTfgJfn7BmD+rPc/abxWY9QufV2OnoMtfeTWuluxYzuN3v/
 fTBf1REvpBlPFK0hT8zQsxFDn9iDvBotmvOToUGLqsPHhOj/9oYMA/PnAifV7AqIWTFg
 mYEtdK4B/99Nk/DDVLWlAKn4ZlsdKsHKKDTgliGpdxmKPRopXGGa2kxoqyYVPw6lYof0
 /HbD5i4ZaG1yJ+3Rm6wHtGYsAWdeZkP6nPoJeKhB09RrfggJZX1PtsQV7pxTtulbDacP 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjd6u14eu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jan 2024 09:24:31 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40B8r6pX007315;
 Thu, 11 Jan 2024 09:24:00 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjd6u12mu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jan 2024 09:24:00 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40B6rpor028052; Thu, 11 Jan 2024 09:23:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vgwfsxje7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jan 2024 09:23:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40B9NWrU21496426
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jan 2024 09:23:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 454072005A;
 Thu, 11 Jan 2024 09:23:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ABD822004E;
 Thu, 11 Jan 2024 09:23:31 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.79.56])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 11 Jan 2024 09:23:31 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Ido Plat <Ido.Plat@ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 1/2] target/s390x: Fix LAE setting a wrong access register
Date: Thu, 11 Jan 2024 10:21:26 +0100
Message-ID: <20240111092328.929421-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111092328.929421-1-iii@linux.ibm.com>
References: <20240111092328.929421-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BwmpecLFztK009BqT1P13oJIRnewoEw4
X-Proofpoint-ORIG-GUID: D4cDwYcp2UX9ci8a3qvI8Ly2WYtm8ToD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_04,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=685
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401110075
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

LAE should set the access register corresponding to the first operand,
instead, it always modifies access register 1.

Co-developed-by: Ido Plat <Ido.Plat@ibm.com>
Cc: qemu-stable@nongnu.org
Fixes: a1c7610a6879 ("target-s390x: implement LAY and LAEY instructions")
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 62ab2be8b12..8df00b7df9f 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -3221,6 +3221,7 @@ static DisasJumpType op_mov2e(DisasContext *s, DisasOps *o)
 {
     int b2 = get_field(s, b2);
     TCGv ar1 = tcg_temp_new_i64();
+    int r1 = get_field(s, r1);
 
     o->out = o->in2;
     o->in2 = NULL;
@@ -3244,7 +3245,7 @@ static DisasJumpType op_mov2e(DisasContext *s, DisasOps *o)
         break;
     }
 
-    tcg_gen_st32_i64(ar1, tcg_env, offsetof(CPUS390XState, aregs[1]));
+    tcg_gen_st32_i64(ar1, tcg_env, offsetof(CPUS390XState, aregs[r1]));
     return DISAS_NEXT;
 }
 
-- 
2.43.0


