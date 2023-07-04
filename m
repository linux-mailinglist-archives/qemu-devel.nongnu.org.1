Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 297C5746BA5
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:16:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbC2-0003OD-6f; Tue, 04 Jul 2023 04:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGbBy-0003KS-Ny; Tue, 04 Jul 2023 04:15:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGbBw-0002W4-F2; Tue, 04 Jul 2023 04:15:21 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 364889jK001131; Tue, 4 Jul 2023 08:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6puM50WbbeB4PsqZ9dfUPfZ4UR2fwSjrmPNvZy2i1yk=;
 b=VvmGoAyRVurxGsGkRAGwKEdv5HDU3L4SIBfZHLKf5ub+HdfLlam/GAmczIuI2lDyC8fN
 yoffzG9Ri6l5yYHZxNGhXRcgVqdeECjYDBsDITpgM8X9pwwWFv+/HuEO56k1GSagMyJq
 eDf8h5RfZCxV+KZKe2DY2HzQZ+l3Z8OI2R0fJM1Sf1jmhshoSoQDbyoXrJBFqaqk67+n
 oCbNBBjH9whR5skGgPuqWXty0Meqmv5Mopmw162/bpTUYdTZ9RhzsS9JPJiCwhBdVJBO
 V5JeISlPX5l8pSHvdqpCa5y+BK6V9fyY2QEe7wn4n/rdLzpwZIj//p86aLZ+sKfzWNOK UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmfdt8e83-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:15:18 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36488DZl001551;
 Tue, 4 Jul 2023 08:15:17 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmfdt8e6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:15:17 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3645s7Bg032565;
 Tue, 4 Jul 2023 08:15:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4swca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:15:15 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3648FDrY18023146
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Jul 2023 08:15:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F0992004B;
 Tue,  4 Jul 2023 08:15:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A206520043;
 Tue,  4 Jul 2023 08:15:12 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.30.217])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Jul 2023 08:15:12 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 01/12] linux-user: elfload: Add more initial s390x PSW bits
Date: Tue,  4 Jul 2023 10:12:25 +0200
Message-ID: <20230704081506.276055-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704081506.276055-1-iii@linux.ibm.com>
References: <20230704081506.276055-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7H9vg9W-X0-20Gg0gIubS-g17Nt2yInD
X-Proofpoint-GUID: J_xisY1t9HL5MbNc-HKMjCJVt9_4vjZH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_04,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307040065
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

Make the PSW look more similar to the real s390x userspace PSW.
Except for being there, the newly added bits should not affect the
userspace code execution.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/elfload.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 6900974c373..7935110bff4 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1635,7 +1635,9 @@ const char *elf_hwcap_str(uint32_t bit)
 static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
 {
     regs->psw.addr = infop->entry;
-    regs->psw.mask = PSW_MASK_64 | PSW_MASK_32;
+    regs->psw.mask = PSW_MASK_DAT | PSW_MASK_IO | PSW_MASK_EXT | \
+                     PSW_MASK_MCHECK | PSW_MASK_PSTATE | PSW_MASK_64 | \
+                     PSW_MASK_32;
     regs->gprs[15] = infop->start_stack;
 }
 
-- 
2.41.0


