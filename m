Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D537E1D54
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 10:38:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzw2Q-0005tH-R4; Mon, 06 Nov 2023 04:36:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qzw1x-0005dN-HG; Mon, 06 Nov 2023 04:36:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qzw1v-0004ou-Bm; Mon, 06 Nov 2023 04:36:24 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A68dCFC027653; Mon, 6 Nov 2023 09:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dy3KsOft53kXBp3urbQTdpHGjTor/z1aHd65cARVF8Y=;
 b=JehQs18mFWzhVdcVS2gr/KtdmRc8RosBjxMeNlB5Jgr32x1TSDPtTfqs04OpzSFYdMIp
 soRlALuHStFUC9+/ItjMWB+ZAYpIK3mI0OYscm1UOc/lbFY9uAzXMzcJNYPMSgv2IRc5
 LKKl7NKjUshIQxYnhg7nWT33f45/fDMOMRTGeMVnoKpf/nzvFni4ZYtXKv4U8B16vaZu
 EsfaI45NBgfEalO/58tGpNq15gjgGllhauoTxSwH4oYjYQlPQctDRtkzTxWw3kDjyDKa
 7Bl9E4ZOXpQCtAfeZKMbnSvYRdPVRLgqSNu50j8tGADn+lKzhe3Q/0He+bbV2Bzlh1VS DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6vts9m4x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Nov 2023 09:36:20 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A69IefA001134;
 Mon, 6 Nov 2023 09:36:20 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6vts9m4p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Nov 2023 09:36:20 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A690GJo007971; Mon, 6 Nov 2023 09:36:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u61sk853t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Nov 2023 09:36:19 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A69aHkG22610474
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Nov 2023 09:36:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68B192004E;
 Mon,  6 Nov 2023 09:36:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D313220040;
 Mon,  6 Nov 2023 09:36:16 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.47.192])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Nov 2023 09:36:16 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 3/5] target/s390x: Fix LAALG not updating cc_src
Date: Mon,  6 Nov 2023 10:31:24 +0100
Message-ID: <20231106093605.1349201-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106093605.1349201-1-iii@linux.ibm.com>
References: <20231106093605.1349201-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EeJzL-ESeHW39D2d7muVYdZJXzczWM1p
X-Proofpoint-ORIG-GUID: bAceYrl1uJPZXp_5zl2zJCwMkjLUMuKR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_07,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=899 malwarescore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060081
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

LAALG uses op_laa() and wout_addu64(). The latter expects cc_src to be
set, but the former does not do it. This can lead to assertion failures
if something sets cc_src to neither 0 nor 1 before.

Fix by introducing op_laa_addu64(), which sets cc_src, and using it for
LAALG.

Fixes: 4dba4d6fef61 ("target/s390x: Use atomic operations for LOAD AND OP")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/insn-data.h.inc |  2 +-
 target/s390x/tcg/translate.c     | 19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 0bfd88d3c3a..2f07f39d9cb 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -442,7 +442,7 @@
     D(0xebe8, LAAG,    RSY_a, ILA, r3, a2, new, in2_r1, laa, adds64, MO_TEUQ)
 /* LOAD AND ADD LOGICAL */
     D(0xebfa, LAAL,    RSY_a, ILA, r3_32u, a2, new, in2_r1_32, laa, addu32, MO_TEUL)
-    D(0xebea, LAALG,   RSY_a, ILA, r3, a2, new, in2_r1, laa, addu64, MO_TEUQ)
+    D(0xebea, LAALG,   RSY_a, ILA, r3, a2, new, in2_r1, laa_addu64, addu64, MO_TEUQ)
 /* LOAD AND AND */
     D(0xebf4, LAN,     RSY_a, ILA, r3_32s, a2, new, in2_r1_32, lan, nz32, MO_TESL)
     D(0xebe4, LANG,    RSY_a, ILA, r3, a2, new, in2_r1, lan, nz64, MO_TEUQ)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index a0d6a2a35dd..62ab2be8b12 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2677,17 +2677,32 @@ static DisasJumpType op_kxb(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_laa(DisasContext *s, DisasOps *o)
+static DisasJumpType help_laa(DisasContext *s, DisasOps *o, bool addu64)
 {
     /* The real output is indeed the original value in memory;
        recompute the addition for the computation of CC.  */
     tcg_gen_atomic_fetch_add_i64(o->in2, o->in2, o->in1, get_mem_index(s),
                                  s->insn->data | MO_ALIGN);
     /* However, we need to recompute the addition for setting CC.  */
-    tcg_gen_add_i64(o->out, o->in1, o->in2);
+    if (addu64) {
+        tcg_gen_movi_i64(cc_src, 0);
+        tcg_gen_add2_i64(o->out, cc_src, o->in1, cc_src, o->in2, cc_src);
+    } else {
+        tcg_gen_add_i64(o->out, o->in1, o->in2);
+    }
     return DISAS_NEXT;
 }
 
+static DisasJumpType op_laa(DisasContext *s, DisasOps *o)
+{
+    return help_laa(s, o, false);
+}
+
+static DisasJumpType op_laa_addu64(DisasContext *s, DisasOps *o)
+{
+    return help_laa(s, o, true);
+}
+
 static DisasJumpType op_lan(DisasContext *s, DisasOps *o)
 {
     /* The real output is indeed the original value in memory;
-- 
2.41.0


