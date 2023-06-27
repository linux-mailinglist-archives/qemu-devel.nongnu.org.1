Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDDF73FF65
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 17:14:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEAOS-0003BP-WF; Tue, 27 Jun 2023 11:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qEAOQ-0003Ab-5D; Tue, 27 Jun 2023 11:14:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qEAOM-00056l-Rq; Tue, 27 Jun 2023 11:14:09 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35REp47P022104; Tue, 27 Jun 2023 15:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=np7uvK9/sFpc0U/YZFwzABoV9Y8MBvzBlVG5I44G4+M=;
 b=J2Jze27jht7p6ubYdAy2UfjbrcZXdRUkfx2sd/LG+v4PhEjlZYStuwPkU1QwEq/8ajh5
 sDucZ03DQKqsanFvJkSDy8P1Q07Ez/mMOrWNKCO42jMUzP37mvuIF+5ooTjLodeJajnw
 ZGEWu/VQLJolC3bJGvLhegZ40g+RB1LXGJ7v1DhBhIuor3AotHXm3wLbjPT9On942I+z
 KzaOEUZXmdtIZ7aNYoVbcWKNYxzxTNRFFBUK04op/OZ2x4s6bYS/d5CMIotKSpR0QWcy
 2Rdqn+8urWcuQHmtl6iiyLy4Idg/jOuy7AuWB8AG/QrN3Pofqs0xZr44P6+edVD7EXSw 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rg1w0s11g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 15:14:02 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35REqlxA031037;
 Tue, 27 Jun 2023 15:14:02 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rg1w0s10c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 15:14:02 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35REx1gU018785;
 Tue, 27 Jun 2023 15:13:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3rdr451gcb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 15:13:59 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35RFDvAX57672032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jun 2023 15:13:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2AA2C20043;
 Tue, 27 Jun 2023 15:13:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0857E20040;
 Tue, 27 Jun 2023 15:13:57 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jun 2023 15:13:56 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] linux-user/elfload: Fix /proc/cpuinfo features: on s390x
Date: Tue, 27 Jun 2023 17:13:33 +0200
Message-ID: <20230627151356.273259-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: B6Xb-Z59x6B1UnebhFDvf1hayyeZGDuC
X-Proofpoint-GUID: FD23G40S9ObonQzMNC_nYE4fBWd2Bdvw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 mlxlogscore=998
 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270140
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

elf_hwcap_str() takes a bit number, but compares it for equality with
the HWCAP_S390_* masks. This causes /proc/cpuinfo to display incorrect
hwcaps.

Fix by introducing the HWCAP_S390_NR_* constants and using them in
elf_hwcap_str() instead of the HWCAP_S390_*. While at it, add the
missing nnpa, pcimio and sie hwcaps from the latest kernel.

Output before:

	features	: esan3 zarch stfle msa

Output after:

	features	: esan3 zarch stfle msa ldisp eimm etf3eh highgprs vx vxe

Fixes: e19807bee357 ("linux-user/elfload: Introduce elf_hwcap_str() on s390x")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 include/elf.h        | 66 +++++++++++++++++++++++++++++++-------------
 linux-user/elfload.c | 41 ++++++++++++++-------------
 2 files changed, 69 insertions(+), 38 deletions(-)

diff --git a/include/elf.h b/include/elf.h
index 2f4d0e56d16..ec9755e73ba 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -596,25 +596,53 @@ typedef struct {
 
 /* Bits present in AT_HWCAP for s390.  */
 
-#define HWCAP_S390_ESAN3        1
-#define HWCAP_S390_ZARCH        2
-#define HWCAP_S390_STFLE        4
-#define HWCAP_S390_MSA          8
-#define HWCAP_S390_LDISP        16
-#define HWCAP_S390_EIMM         32
-#define HWCAP_S390_DFP          64
-#define HWCAP_S390_HPAGE        128
-#define HWCAP_S390_ETF3EH       256
-#define HWCAP_S390_HIGH_GPRS    512
-#define HWCAP_S390_TE           1024
-#define HWCAP_S390_VXRS         2048
-#define HWCAP_S390_VXRS_BCD     4096
-#define HWCAP_S390_VXRS_EXT     8192
-#define HWCAP_S390_GS           16384
-#define HWCAP_S390_VXRS_EXT2    32768
-#define HWCAP_S390_VXRS_PDE     65536
-#define HWCAP_S390_SORT         131072
-#define HWCAP_S390_DFLT         262144
+#define HWCAP_S390_NR_ESAN3      0
+#define HWCAP_S390_NR_ZARCH      1
+#define HWCAP_S390_NR_STFLE      2
+#define HWCAP_S390_NR_MSA        3
+#define HWCAP_S390_NR_LDISP      4
+#define HWCAP_S390_NR_EIMM       5
+#define HWCAP_S390_NR_DFP        6
+#define HWCAP_S390_NR_HPAGE      7
+#define HWCAP_S390_NR_ETF3EH     8
+#define HWCAP_S390_NR_HIGH_GPRS  9
+#define HWCAP_S390_NR_TE        10
+#define HWCAP_S390_NR_VXRS      11
+#define HWCAP_S390_NR_VXRS_BCD  12
+#define HWCAP_S390_NR_VXRS_EXT  13
+#define HWCAP_S390_NR_GS        14
+#define HWCAP_S390_NR_VXRS_EXT2 15
+#define HWCAP_S390_NR_VXRS_PDE  16
+#define HWCAP_S390_NR_SORT      17
+#define HWCAP_S390_NR_DFLT      18
+#define HWCAP_S390_NR_VXRS_PDE2 19
+#define HWCAP_S390_NR_NNPA      20
+#define HWCAP_S390_NR_PCI_MIO   21
+#define HWCAP_S390_NR_SIE       22
+
+#define HWCAP_S390_ESAN3     (1 << HWCAP_S390_NR_ESAN3)
+#define HWCAP_S390_ZARCH     (1 << HWCAP_S390_NR_ZARCH)
+#define HWCAP_S390_STFLE     (1 << HWCAP_S390_NR_STFLE)
+#define HWCAP_S390_MSA       (1 << HWCAP_S390_NR_MSA)
+#define HWCAP_S390_LDISP     (1 << HWCAP_S390_NR_LDISP)
+#define HWCAP_S390_EIMM      (1 << HWCAP_S390_NR_EIMM)
+#define HWCAP_S390_DFP       (1 << HWCAP_S390_NR_DFP)
+#define HWCAP_S390_HPAGE     (1 << HWCAP_S390_NR_HPAGE)
+#define HWCAP_S390_ETF3EH    (1 << HWCAP_S390_NR_ETF3EH)
+#define HWCAP_S390_HIGH_GPRS (1 << HWCAP_S390_NR_HIGH_GPRS)
+#define HWCAP_S390_TE        (1 << HWCAP_S390_NR_TE)
+#define HWCAP_S390_VXRS      (1 << HWCAP_S390_NR_VXRS)
+#define HWCAP_S390_VXRS_BCD  (1 << HWCAP_S390_NR_VXRS_BCD)
+#define HWCAP_S390_VXRS_EXT  (1 << HWCAP_S390_NR_VXRS_EXT)
+#define HWCAP_S390_GS        (1 << HWCAP_S390_NR_GS)
+#define HWCAP_S390_VXRS_EXT2 (1 << HWCAP_S390_NR_VXRS_EXT2)
+#define HWCAP_S390_VXRS_PDE  (1 << HWCAP_S390_NR_VXRS_PDE)
+#define HWCAP_S390_SORT      (1 << HWCAP_S390_NR_SORT)
+#define HWCAP_S390_DFLT      (1 << HWCAP_S390_NR_DFLT)
+#define HWCAP_S390_VXRS_PDE2 (1 << HWCAP_S390_NR_VXRS_PDE2)
+#define HWCAP_S390_NNPA      (1 << HWCAP_S390_NR_NNPA)
+#define HWCAP_S390_PCI_MIO   (1 << HWCAP_S390_NR_PCI_MIO)
+#define HWCAP_S390_SIE       (1 << HWCAP_S390_NR_SIE)
 
 /* M68K specific definitions. */
 /* We use the top 24 bits to encode information about the
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 9a2ec568b09..d1807b9e4e3 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1608,25 +1608,28 @@ uint32_t get_elf_hwcap(void)
 const char *elf_hwcap_str(uint32_t bit)
 {
     static const char *hwcap_str[] = {
-        [HWCAP_S390_ESAN3]     = "esan3",
-        [HWCAP_S390_ZARCH]     = "zarch",
-        [HWCAP_S390_STFLE]     = "stfle",
-        [HWCAP_S390_MSA]       = "msa",
-        [HWCAP_S390_LDISP]     = "ldisp",
-        [HWCAP_S390_EIMM]      = "eimm",
-        [HWCAP_S390_DFP]       = "dfp",
-        [HWCAP_S390_HPAGE]     = "edat",
-        [HWCAP_S390_ETF3EH]    = "etf3eh",
-        [HWCAP_S390_HIGH_GPRS] = "highgprs",
-        [HWCAP_S390_TE]        = "te",
-        [HWCAP_S390_VXRS]      = "vx",
-        [HWCAP_S390_VXRS_BCD]  = "vxd",
-        [HWCAP_S390_VXRS_EXT]  = "vxe",
-        [HWCAP_S390_GS]        = "gs",
-        [HWCAP_S390_VXRS_EXT2] = "vxe2",
-        [HWCAP_S390_VXRS_PDE]  = "vxp",
-        [HWCAP_S390_SORT]      = "sort",
-        [HWCAP_S390_DFLT]      = "dflt",
+        [HWCAP_S390_NR_ESAN3]     = "esan3",
+        [HWCAP_S390_NR_ZARCH]     = "zarch",
+        [HWCAP_S390_NR_STFLE]     = "stfle",
+        [HWCAP_S390_NR_MSA]       = "msa",
+        [HWCAP_S390_NR_LDISP]     = "ldisp",
+        [HWCAP_S390_NR_EIMM]      = "eimm",
+        [HWCAP_S390_NR_DFP]       = "dfp",
+        [HWCAP_S390_NR_HPAGE]     = "edat",
+        [HWCAP_S390_NR_ETF3EH]    = "etf3eh",
+        [HWCAP_S390_NR_HIGH_GPRS] = "highgprs",
+        [HWCAP_S390_NR_TE]        = "te",
+        [HWCAP_S390_NR_VXRS]      = "vx",
+        [HWCAP_S390_NR_VXRS_BCD]  = "vxd",
+        [HWCAP_S390_NR_VXRS_EXT]  = "vxe",
+        [HWCAP_S390_NR_GS]        = "gs",
+        [HWCAP_S390_NR_VXRS_EXT2] = "vxe2",
+        [HWCAP_S390_NR_VXRS_PDE]  = "vxp",
+        [HWCAP_S390_NR_SORT]      = "sort",
+        [HWCAP_S390_NR_DFLT]      = "dflt",
+        [HWCAP_S390_NR_NNPA]      = "nnpa",
+        [HWCAP_S390_NR_PCI_MIO]   = "pcimio",
+        [HWCAP_S390_NR_SIE]       = "sie",
     };
 
     return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
-- 
2.41.0


