Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB7A7224CB
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:41:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q68a6-0008Qx-2H; Mon, 05 Jun 2023 07:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q68ZD-0008NJ-Oq; Mon, 05 Jun 2023 07:40:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q68ZB-0001MJ-5N; Mon, 05 Jun 2023 07:40:06 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 355BNXIM004782; Mon, 5 Jun 2023 11:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ihcPcXiIidfCiPyRtX/zY5CTCGkeOzuKFNykdBgc8Pg=;
 b=SbRX+4fgpFUddc0AvYg1Pa7lx/dOPMFrh422LPDnIZlvx2HlFY8boGnAtw0rr0cOHYxi
 DA4f4tNrbjkMAKvAAEruQ0Bgd8j9eRewpX4AFQBm+lCIqAhcX0Bvp3hmlL9z9hSCPtbs
 FW+4DnZNHIX0FaWwKBbQ4HbwHSWM5DechvTbY/izaZplVrTEE9IStBIR3mCb1uemFaRU
 AFF2rupedYI+CjM7XF0aH3UtgbF+ENAYod9evI+pDn7INJQIZ5xvlYYJR8iY5BAYnOta
 4L1B1+WPXmi6XkAL+Bb2H5IsptJICTsAuO/EvcKDPxLyqqt5t7pMS00MNG3U6CHAuVkc 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r1esv8c6s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jun 2023 11:40:01 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 355BOZom009666;
 Mon, 5 Jun 2023 11:40:00 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r1esv8c65-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jun 2023 11:40:00 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3552gJ42032350;
 Mon, 5 Jun 2023 11:39:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3qyxdf91ht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jun 2023 11:39:58 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 355BduMX18809380
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Jun 2023 11:39:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4161820043;
 Mon,  5 Jun 2023 11:39:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3B4A20040;
 Mon,  5 Jun 2023 11:39:55 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.209.184])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Jun 2023 11:39:55 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 2/4] linux-user/elfload: Expose get_elf_hwcap() on s390x
Date: Mon,  5 Jun 2023 13:39:48 +0200
Message-Id: <20230605113950.1169228-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605113950.1169228-1-iii@linux.ibm.com>
References: <20230605113950.1169228-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EAZCudBK4vGkbJ4GoldAzOsV_ML_xMwb
X-Proofpoint-ORIG-GUID: cza00Rf5lrUiErCFRS23zCXV8VR3cI0-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306050103
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

It is required for implementing /proc/cpuinfo emulation.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/elfload.c | 2 +-
 linux-user/loader.h  | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 418ad92598c..49ec9ccc944 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1583,7 +1583,7 @@ static inline void init_thread(struct target_pt_regs *regs,
 #define GET_FEATURE(_feat, _hwcap) \
     do { if (s390_has_feat(_feat)) { hwcap |= _hwcap; } } while (0)
 
-static uint32_t get_elf_hwcap(void)
+uint32_t get_elf_hwcap(void)
 {
     /*
      * Let's assume we always have esan3 and zarch.
diff --git a/linux-user/loader.h b/linux-user/loader.h
index f375ee0679b..ad6ca9dbe35 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -56,4 +56,8 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src,
 
 extern unsigned long guest_stack_size;
 
+#ifdef TARGET_S390X
+uint32_t get_elf_hwcap(void);
+#endif
+
 #endif /* LINUX_USER_LOADER_H */
-- 
2.40.1


