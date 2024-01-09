Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 297F18290CB
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 00:24:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNLRd-00044c-8e; Tue, 09 Jan 2024 18:23:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rNLRa-00044A-RL; Tue, 09 Jan 2024 18:23:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rNLRT-0005PF-SV; Tue, 09 Jan 2024 18:23:38 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 409LHe2s022678; Tue, 9 Jan 2024 23:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=gS8YcNgjQ4VogCR5HsIMsYMQmFDWq3FQ6tFrLtsVuWw=;
 b=XHm83H3obTUHyBm1SAUnEgv9RaZBjH2rbc5wPpaTKZerlGyh99QCLnI3+F1i4We5/lo5
 LT0APfCb/iJ6mOmS2Rj7IBAOstC9gCcsvqSJ1aFkvsQzk7hGcRThT6C6nFF86PLhUH4c
 RVQDICnlk8SPvWJE5/n5Mr+EtmdnpFTh0kvUjr+Or73sa+jdTNsUQYsrmgLcZ054D6Ve
 cjYKLTZgOQtGPyE+VmsQuCX1CEXajsTveZ2Gb3d7CTvvUjSpICwLXgDqVrW+7GJHnAyW
 TV1QLSoFwekWN1xICaKh8ujiRL/tc/WoFnuJEgDH9ESGuyYIMKP7+4/bauw+ivLuI9C5 XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhdx4j7vd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 23:23:26 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 409MuDVT005115;
 Tue, 9 Jan 2024 23:23:26 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhdx4j7ux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 23:23:26 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 409L0IjB027253; Tue, 9 Jan 2024 23:23:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkw21awu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 23:23:25 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 409NNN2U19202574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jan 2024 23:23:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B87B520043;
 Tue,  9 Jan 2024 23:23:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B74D20040;
 Tue,  9 Jan 2024 23:23:23 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.60.193])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jan 2024 23:23:23 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Ido Plat <Ido.Plat@ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 1/2] target/s390x: Fix LAE setting a wrong access register
Date: Wed, 10 Jan 2024 00:22:22 +0100
Message-ID: <20240109232319.600102-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109232319.600102-1-iii@linux.ibm.com>
References: <20240109232319.600102-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PPGAzUOXoH0gNRRhOjMbIWMqpcrbtuLX
X-Proofpoint-ORIG-GUID: Bb_Dwh3LbTySvwH6LDPdyMJAiW_aeVKQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_11,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 clxscore=1011 bulkscore=0 adultscore=0 mlxlogscore=605
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401090188
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


