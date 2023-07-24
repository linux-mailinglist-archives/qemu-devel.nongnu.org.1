Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D11C675ED5F
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 10:24:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNqod-0001BN-EW; Mon, 24 Jul 2023 04:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qNqoB-00017p-SB; Mon, 24 Jul 2023 04:20:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qNqoA-0001Ml-6k; Mon, 24 Jul 2023 04:20:47 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36O87dLp027737; Mon, 24 Jul 2023 08:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=W8kDhIeXEWFJHYXL3UJyq22ZL0homVojaBrQ/P2WiM4=;
 b=M1SP+7XyZLPAN5pLTOZSIU+qbvylKpHLJM3x/+nt3LewYPrCYRrEHK5Hl6kncfg/ociM
 aK7lKRbRoxYBcYtBLIa+hzb/uqVw+BCWeaYzCWoeiiTGCS2vX2OvFnsxd1GJ2rPNynyc
 kwHztr/QypPOZSfAnbr9NHUg3X2NFLAy6UCnc4OjMX3zvQbc1gQF7NBS49PVO0rgEHjF
 ECoY0bOhoHbhe/PC9yHLQXqbsaDjmOEvGnqZz3I3lve9r7lv7JDMIHX8KOKcFhKasKmp
 566dvv3FQcFcB+ef2pFLrcCMl7soORi/5MSAhJGcpOBP7qAJTIZ0yY9W/03MQvgZ7utk pg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s1k3ukenv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Jul 2023 08:20:42 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36O8KglY014416;
 Mon, 24 Jul 2023 08:20:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s1k3uken9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Jul 2023 08:20:42 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36O8AoTk014374; Mon, 24 Jul 2023 08:20:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0stxhrxe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Jul 2023 08:20:41 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36O8KdSY28639894
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Jul 2023 08:20:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 93E6D20043;
 Mon, 24 Jul 2023 08:20:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DF9820040;
 Mon, 24 Jul 2023 08:20:39 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.11.212])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Jul 2023 08:20:38 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v4 01/14] target/s390x: Make CKSM raise an exception if R2 is
 odd
Date: Mon, 24 Jul 2023 10:15:54 +0200
Message-ID: <20230724082032.66864-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724082032.66864-1-iii@linux.ibm.com>
References: <20230724082032.66864-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JFi5ANNvErijqSLGf0xCyIBYkCta5nzl
X-Proofpoint-GUID: lw_3eBOFykBjJ0lzpex2rdznH9UuODzD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 mlxlogscore=755 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240071
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 target/s390x/tcg/insn-data.h.inc | 2 +-
 target/s390x/tcg/translate.c     | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 457ed25d2fa..86a509b0ac8 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -157,7 +157,7 @@
     C(0xb2fa, NIAI,    E,     EH,  0, 0, 0, 0, 0, 0)
 
 /* CHECKSUM */
-    C(0xb241, CKSM,    RRE,   Z,   r1_o, ra2, new, r1_32, cksm, 0)
+    C(0xb241, CKSM,    RRE,   Z,   r1_o, ra2_E, new, r1_32, cksm, 0)
 
 /* COPY SIGN */
     F(0xb372, CPSDR,   RRF_b, FPSSH, f3, f2, new, f1, cps, 0, IF_AFP1 | IF_AFP2 | IF_AFP3)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 6661b27efa4..d6e8acee995 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -5779,6 +5779,12 @@ static void in2_ra2(DisasContext *s, DisasOps *o)
 }
 #define SPEC_in2_ra2 0
 
+static void in2_ra2_E(DisasContext *s, DisasOps *o)
+{
+    return in2_ra2(s, o);
+}
+#define SPEC_in2_ra2_E SPEC_r2_even
+
 static void in2_a2(DisasContext *s, DisasOps *o)
 {
     int x2 = have_field(s, x2) ? get_field(s, x2) : 0;
-- 
2.41.0


