Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C7371EEE0
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:27:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4l7o-0003k3-6v; Thu, 01 Jun 2023 12:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q4l7k-0003bK-Ro; Thu, 01 Jun 2023 12:26:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q4l7h-00066X-VD; Thu, 01 Jun 2023 12:26:04 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 351GPD17019287; Thu, 1 Jun 2023 16:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=AebpaopUxRz1TlZoHuaRg05fUD2N67PSzJwMozudzrU=;
 b=Z0Dg7oR4CkV8zWmxWej+O55A/8SZ1BO1uRhkteNsl8SO8qSeTjjOhdiy3pWlW8+bFtCf
 Uctg3aGCW0KWBiWuycFq/LnPCMSqrgtwqMrKWrY0WnCf8knIyTMB5vK3UHJpFDAdbXBd
 i2byMmrSWxI4ML0jdjfE5YcWQ55yQypcIcyrLLjOBFWFqE4n6jv/dKjN6TdilnP/zz2C
 1rG8BBc2xX+30HRGIom0MvTD57w2uUIvQZ4A54McXxMZDta99/i5STzCsi22fg6x0wKn
 P/blEmdkrf2QDMJalErEP9WtpCXJgPYjKEoVwsRdlHzC2R803E13ixR9qzeyFvzoL3zX rA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxx81s3m5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 16:25:57 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 351G7I2d022405;
 Thu, 1 Jun 2023 16:25:57 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxx81s3jt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 16:25:57 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3513vaCs022654;
 Thu, 1 Jun 2023 16:25:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3qu9g526pa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 16:25:54 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 351GPqwe18416138
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Jun 2023 16:25:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2079D20043;
 Thu,  1 Jun 2023 16:25:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0B232004B;
 Thu,  1 Jun 2023 16:25:51 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.86.130])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Jun 2023 16:25:51 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 3/4] linux-user/elfload: Introduce elf_hwcap_str() on s390x
Date: Thu,  1 Jun 2023 18:25:40 +0200
Message-Id: <20230601162541.689621-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601162541.689621-1-iii@linux.ibm.com>
References: <20230601162541.689621-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hlVSEysLu8fevxL5VCrrTQYiUkB5V1tB
X-Proofpoint-GUID: YlY1oJ1XiHTkilQV8yq5wXmbo1REs-Ub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1015 mlxlogscore=999 malwarescore=0 impostorscore=0 mlxscore=0
 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010139
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

It is required for implementing /proc/cpuinfo emulation.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/elfload.c | 27 +++++++++++++++++++++++++++
 linux-user/loader.h  |  1 +
 2 files changed, 28 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 49ec9ccc944..d80d68484b6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1605,6 +1605,33 @@ uint32_t get_elf_hwcap(void)
     return hwcap;
 }
 
+const char *elf_hwcap_str(uint32_t bit)
+{
+    static const char *hwcap_str[] = {
+        [HWCAP_S390_ESAN3]     = "esan3",
+        [HWCAP_S390_ZARCH]     = "zarch",
+        [HWCAP_S390_STFLE]     = "stfle",
+        [HWCAP_S390_MSA]       = "msa",
+        [HWCAP_S390_LDISP]     = "ldisp",
+        [HWCAP_S390_EIMM]      = "eimm",
+        [HWCAP_S390_DFP]       = "dfp",
+        [HWCAP_S390_HPAGE]     = "edat",
+        [HWCAP_S390_ETF3EH]    = "etf3eh",
+        [HWCAP_S390_HIGH_GPRS] = "highgprs",
+        [HWCAP_S390_TE]        = "te",
+        [HWCAP_S390_VXRS]      = "vx",
+        [HWCAP_S390_VXRS_BCD]  = "vxd",
+        [HWCAP_S390_VXRS_EXT]  = "vxe",
+        [HWCAP_S390_GS]        = "gs",
+        [HWCAP_S390_VXRS_EXT2] = "vxe2",
+        [HWCAP_S390_VXRS_PDE]  = "vxp",
+        [HWCAP_S390_SORT]      = "sort",
+        [HWCAP_S390_DFLT]      = "dflt",
+    };
+
+    return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
+}
+
 static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
 {
     regs->psw.addr = infop->entry;
diff --git a/linux-user/loader.h b/linux-user/loader.h
index ad6ca9dbe35..59cbeacf24f 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -58,6 +58,7 @@ extern unsigned long guest_stack_size;
 
 #ifdef TARGET_S390X
 uint32_t get_elf_hwcap(void);
+const char *elf_hwcap_str(uint32_t bit);
 #endif
 
 #endif /* LINUX_USER_LOADER_H */
-- 
2.40.1


