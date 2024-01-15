Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B6582E1C8
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 21:24:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPTUk-0002o3-OS; Mon, 15 Jan 2024 15:23:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rPTUT-0002ga-3u; Mon, 15 Jan 2024 15:23:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rPTUP-0000b2-Rf; Mon, 15 Jan 2024 15:23:24 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40FIvZ1m011434; Mon, 15 Jan 2024 20:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=gbPImPBRGxJliuo02hWoisZawB8F20EbNzt0bGccovU=;
 b=V8AW12SrQpj1IDasYhH9k4L78uaFFD+Qag/7GQgsCYXGJU7ebsvRXUK3QUXIB8A4ZYfa
 t8IVdNHpr9rdEV05R8eT+l1qUsFUnOkuj4ZkDa/xszdkH8mK9Ovy1UpfPkJldNbFpX6N
 m3XUCEk/9XXoaEuS8iAB7qYiRW/gJo7e7kDgVrcE6nYsZodQsNIl/EHxPC23Vckxeliv
 pJ2nWknBdiVgGI8qDpyx1yEe47QZz8U+RW3TFTbVR3s8cH331UqjX3Mq/mGCF2lSlREk
 dHDWbW8HqvDp5RdkW1Ru8xY3mWzQIMa5BXspAA/ugAymhs1OZI5d4aBFWVDPtvQisRBI Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vnaec9jqh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 20:23:16 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40FKKYqA027091;
 Mon, 15 Jan 2024 20:23:15 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vnaec9jpx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 20:23:15 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40FHhMsN018660; Mon, 15 Jan 2024 20:23:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm5unadcp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 20:23:14 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40FKNC0u45613632
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jan 2024 20:23:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 834BE20049;
 Mon, 15 Jan 2024 20:23:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B60320040;
 Mon, 15 Jan 2024 20:23:12 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.75.248])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Jan 2024 20:23:11 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Ido Plat <Ido.Plat@ibm.com>
Subject: [PATCH 1/2] target/s390x: Emulate CVDG
Date: Mon, 15 Jan 2024 21:21:03 +0100
Message-ID: <20240115202308.1930675-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115202308.1930675-1-iii@linux.ibm.com>
References: <20240115202308.1930675-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JyVfUUdY08l8Ve2Ui2aY6VYtQhkPkrfu
X-Proofpoint-ORIG-GUID: a05D1ZVs9GI2SJR0drdivbFjrVA0Wbed
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-15_13,2024-01-15_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxlogscore=676
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401150150
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

CVDG is the same as CVD, except that it converts 64 bits into 128,
rather than 32 into 64. Use larger data types in the CVD helper and
reuse it.

Reported-by: Ido Plat <Ido.Plat@ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/helper.h            |  1 +
 target/s390x/tcg/insn-data.h.inc |  1 +
 target/s390x/tcg/int_helper.c    | 11 ++++++++---
 target/s390x/tcg/translate.c     |  8 ++++++++
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 05102578fc9..332a9a9c632 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -89,6 +89,7 @@ DEF_HELPER_FLAGS_2(sqeb, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(sqdb, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(sqxb, TCG_CALL_NO_WG, i128, env, i128)
 DEF_HELPER_FLAGS_1(cvd, TCG_CALL_NO_RWG_SE, i64, s32)
+DEF_HELPER_FLAGS_1(cvdg, TCG_CALL_NO_RWG_SE, i128, s64)
 DEF_HELPER_FLAGS_4(pack, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(pka, TCG_CALL_NO_WG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_4(pku, TCG_CALL_NO_WG, void, env, i64, i64, i32)
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 2f07f39d9cb..388dcb8dbbc 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -296,6 +296,7 @@
 /* CONVERT TO DECIMAL */
     C(0x4e00, CVD,     RX_a,  Z,   r1_o, a2, 0, 0, cvd, 0)
     C(0xe326, CVDY,    RXY_a, LD,  r1_o, a2, 0, 0, cvd, 0)
+    C(0xe32e, CVDG,    RXY_a, Z,   r1_o, a2, 0, 0, cvdg, 0)
 /* CONVERT TO FIXED */
     F(0xb398, CFEBR,   RRF_e, Z,   0, e2, new, r1_32, cfeb, 0, IF_BFP)
     F(0xb399, CFDBR,   RRF_e, Z,   0, f2, new, r1_32, cfdb, 0, IF_BFP)
diff --git a/target/s390x/tcg/int_helper.c b/target/s390x/tcg/int_helper.c
index eb8e6dd1b57..defb8fc7681 100644
--- a/target/s390x/tcg/int_helper.c
+++ b/target/s390x/tcg/int_helper.c
@@ -99,10 +99,15 @@ Int128 HELPER(divu64)(CPUS390XState *env, uint64_t ah, uint64_t al, uint64_t b)
 }
 
 uint64_t HELPER(cvd)(int32_t reg)
+{
+    return helper_cvdg(reg);
+}
+
+Int128 HELPER(cvdg)(int64_t reg)
 {
     /* positive 0 */
-    uint64_t dec = 0x0c;
-    int64_t bin = reg;
+    Int128 dec = 0x0c;
+    Int128 bin = reg;
     int shift;
 
     if (bin < 0) {
@@ -110,7 +115,7 @@ uint64_t HELPER(cvd)(int32_t reg)
         dec = 0x0d;
     }
 
-    for (shift = 4; (shift < 64) && bin; shift += 4) {
+    for (shift = 4; (shift < 128) && bin; shift += 4) {
         dec |= (bin % 10) << shift;
         bin /= 10;
     }
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 8df00b7df9f..2d417337695 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2233,6 +2233,14 @@ static DisasJumpType op_cvd(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
+static DisasJumpType op_cvdg(DisasContext *s, DisasOps *o)
+{
+    TCGv_i128 t = tcg_temp_new_i128();
+    gen_helper_cvdg(t, o->in1);
+    tcg_gen_qemu_st_i128(t, o->in2, get_mem_index(s), MO_TE | MO_128);
+    return DISAS_NEXT;
+}
+
 static DisasJumpType op_ct(DisasContext *s, DisasOps *o)
 {
     int m3 = get_field(s, m3);
-- 
2.43.0


