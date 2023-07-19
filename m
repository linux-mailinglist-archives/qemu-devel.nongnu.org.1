Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A16E075A187
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 00:14:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMFQJ-0006zY-LK; Wed, 19 Jul 2023 18:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qMFQF-0006xj-AZ; Wed, 19 Jul 2023 18:13:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qMFQB-0002BZ-IQ; Wed, 19 Jul 2023 18:13:26 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36JLiu4K018565; Wed, 19 Jul 2023 22:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ykrc4dOZQALD3J5jf6KaeY3bcelzmaap4L3nT7ClW4o=;
 b=FTbqA9EdtQIpx5kDzf7GQAjMZioTWGUMuFp2GBNGclAk5GjAsIaAx2fLl5j9xPQ712Xn
 c1iSt2EUSgXSOW0in48Yo8yOl8x1j4ICExuwB4gAzVfSIz2kDqUfa/ScZhX3evevXNyP
 WXX4DhrT/SbpquTW6gOka3K0EXFdLToHxfHCvL4P8ADIspZt2M1JwEddowslS/RDbecm
 1TUdtmvn3l8gG/Vpb0l45utOF1H4wFT1EIqxP3Q70voG4inUY7Xbp5BGObHa7igMSYvg
 gKj1Pr2RrD/CbxL+q/q0cgJhOdxkf0I0QN+uhtyDIwXt8YkbEpSmKC/hAv2jpw4tFwkQ cw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxjx97u1f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 22:13:20 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36JM7wer015782;
 Wed, 19 Jul 2023 22:13:20 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxjx97u18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 22:13:20 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36JL9EcP004156; Wed, 19 Jul 2023 22:13:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv8g14hhq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 22:13:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36JMDHfD1901142
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jul 2023 22:13:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9363520065;
 Wed, 19 Jul 2023 22:13:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06D792005A;
 Wed, 19 Jul 2023 22:13:17 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.5.152])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Jul 2023 22:13:16 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v3 05/14] target/s390x: Make MC raise specification exception
 when class >= 16
Date: Thu, 20 Jul 2023 00:11:17 +0200
Message-ID: <20230719221310.1968845-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719221310.1968845-1-iii@linux.ibm.com>
References: <20230719221310.1968845-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PPpGg8V-Z7eoYhYjWHRSLpf-Ip7I2cS-
X-Proofpoint-ORIG-GUID: 8Fb6UT3Fztz3StHr8jndLo-49sVTtbIN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 mlxlogscore=967 priorityscore=1501 impostorscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190199
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

MC requires bit positions 8-11 (upper 4 bits of class) to be zeros,
otherwise it must raise a specification exception.

Cc: qemu-stable@nongnu.org
Fixes: 20d143e2cab8 ("s390x/tcg: Implement MONITOR CALL")
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/excp_helper.c | 2 +-
 target/s390x/tcg/translate.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 228aa9f2373..3da337f7c72 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -639,7 +639,7 @@ void monitor_event(CPUS390XState *env,
 void HELPER(monitor_call)(CPUS390XState *env, uint64_t monitor_code,
                           uint32_t monitor_class)
 {
-    g_assert(monitor_class <= 0xff);
+    g_assert(monitor_class <= 0xf);
 
     if (env->cregs[8] & (0x8000 >> monitor_class)) {
         monitor_event(env, monitor_code, monitor_class, GETPC());
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 2f193339709..9a4fd3d8911 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -3184,9 +3184,9 @@ static DisasJumpType op_lcbb(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_mc(DisasContext *s, DisasOps *o)
 {
-    const uint16_t monitor_class = get_field(s, i2);
+    const uint8_t monitor_class = get_field(s, i2);
 
-    if (monitor_class & 0xff00) {
+    if (monitor_class & 0xf0) {
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
-- 
2.41.0


