Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D740772B14
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:36:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT3DJ-0005WC-Gm; Mon, 07 Aug 2023 12:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qT3D7-0005UF-5w; Mon, 07 Aug 2023 12:36:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qT3D4-0002Nt-JC; Mon, 07 Aug 2023 12:36:00 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 377GVJIp008655; Mon, 7 Aug 2023 16:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=M+ISArOuJHx9ilVsC/OuUekII88Dkpf5V/zhJ/7T9Ow=;
 b=P1tOM6g67K8A0OHR47ErF31Jp61jyjxHeI9H4bbUspB02tDFptD6esV5BcFrmsDZc+E2
 zGmjkxfqCvZPYpfcsU3PatX8f8WyOHSEQ39Goe7e/KRgZNYE7ehIHd/gWcBOH6cSfNcm
 MGbXJzFlryfNRVpskQPxFb3aggexVXXmF/GID//6ZJdyYOjuaiROQHpSXy08hbwY8y0s
 dwMQU1sN08xijeQY4sxuCEPLmi0KBq+0Z48lZzsBlSep6SSKRYYiv+v/VnWW1vrXhwuX
 0MgzXgoNg+dC8GyVNRO69xoBINnmidQ7BD2/t91i9UftY/jfVErx7s/kgT1dF5sS4BPz vA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sb46w06bw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 16:35:55 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 377GWZiI013834;
 Mon, 7 Aug 2023 16:35:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sb46w067j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 16:35:54 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 377FEPmY000373; Mon, 7 Aug 2023 16:35:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa28k6jen-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 16:35:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 377GZoID58327362
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Aug 2023 16:35:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5891A20043;
 Mon,  7 Aug 2023 16:35:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAE4320040;
 Mon,  7 Aug 2023 16:35:49 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.26.52])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  7 Aug 2023 16:35:49 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH 1/2] target/s390x: Use a 16-bit immediate in VREP
Date: Mon,  7 Aug 2023 18:34:31 +0200
Message-ID: <20230807163459.849766-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ype2AmCexr_6ADGznu27nI6frlaTSzsj
X-Proofpoint-GUID: qY29k2R8H2L1JjUaS6UGXUYYyzmKrqGy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_17,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070153
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
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

Unlike most other instructions that contain an immediate element index,
VREP's one is 16-bit, and not 4-bit. The code uses only 8 bits, so
using, e.g., 0x101 does not lead to a specification exception.

Fix by checking all 16 bits.

Cc: qemu-stable@nongnu.org
Fixes: 28d08731b1d8 ("s390x/tcg: Implement VECTOR REPLICATE")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/translate_vx.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/tcg/translate_vx.c.inc b/target/s390x/tcg/translate_vx.c.inc
index f8df121d3d3..a6d840d4065 100644
--- a/target/s390x/tcg/translate_vx.c.inc
+++ b/target/s390x/tcg/translate_vx.c.inc
@@ -57,7 +57,7 @@
 #define FPF_LONG        3
 #define FPF_EXT         4
 
-static inline bool valid_vec_element(uint8_t enr, MemOp es)
+static inline bool valid_vec_element(uint16_t enr, MemOp es)
 {
     return !(enr & ~(NUM_VEC_ELEMENTS(es) - 1));
 }
@@ -964,7 +964,7 @@ static DisasJumpType op_vpdi(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_vrep(DisasContext *s, DisasOps *o)
 {
-    const uint8_t enr = get_field(s, i2);
+    const uint16_t enr = get_field(s, i2);
     const uint8_t es = get_field(s, m4);
 
     if (es > ES_64 || !valid_vec_element(enr, es)) {
-- 
2.41.0


