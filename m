Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AF477839D
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 00:27:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUE6W-0008Vj-83; Thu, 10 Aug 2023 18:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qUE6N-0008VH-Ku
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 18:25:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qUE6K-000298-Rq
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 18:25:55 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37AMJbUc022946; Thu, 10 Aug 2023 22:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hhquXspdY4VrEYbIUTTU60hH2SggNpa0d66KU7sa0Xk=;
 b=XUJof6NsOlK/sQMZgaMtR01YbKmyUNI7WJ1m54xdTpyUwKP/u55Tm4cfPfvQ3PvdsDWw
 sKPW+ZR36/VKV0XabTxsUJ16fVftjiVjsU+aXpKuNrZX/THH6sqrP36gxcYxXC14TIAJ
 +6nqo4nvFw1RZoDNPp7EO0BPGGUk+i3IOX4xR5miti0gHNDExJqCyw3r6WKIFhh2grbO
 5oyBj6Y3qTdxgDHz2/rdok6SL+0j4HJ7SF14jQeAosSXXix2lmRdO1wpIaAp78uhWYBl
 Fc9gE214PBUnkCI4bdd/95c/ZPJOxRocj0VrXkDXLCVRUB18OOuWBU8FpFKMFJ+0q0Mh Ng== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sd8k903hs-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Aug 2023 22:25:49 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37ALa7G3001802; Thu, 10 Aug 2023 21:57:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa3f2ctt4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Aug 2023 21:57:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37ALvCDR28770948
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Aug 2023 21:57:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C518B20043;
 Thu, 10 Aug 2023 21:57:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AB6820040;
 Thu, 10 Aug 2023 21:57:12 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.63.20])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Aug 2023 21:57:12 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/3] linux-user: Fix the build on systems without SOL_ALG
Date: Thu, 10 Aug 2023 23:51:31 +0200
Message-ID: <20230810215706.1394220-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810215706.1394220-1-iii@linux.ibm.com>
References: <20230810215706.1394220-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dOm0lbs9NBWjZPGIaX1T8Df29Y3GDVsa
X-Proofpoint-ORIG-GUID: dOm0lbs9NBWjZPGIaX1T8Df29Y3GDVsa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308100190
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

Building QEMU on CentOS 7 fails, because there SOL_ALG is not defined.
There already exists #if defined(SOL_ALG) in do_setsockopt(); add it to
target_to_host_cmsg() as well.

Fixes: 27404b6c15c1 ("linux-user: Implement SOL_ALG encryption support")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/syscall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 18d3107194b..42f4aed8e84 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1806,6 +1806,7 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
             __get_user(cred->pid, &target_cred->pid);
             __get_user(cred->uid, &target_cred->uid);
             __get_user(cred->gid, &target_cred->gid);
+#ifdef SOL_ALG
         } else if (cmsg->cmsg_level == SOL_ALG) {
             uint32_t *dst = (uint32_t *)data;
 
@@ -1814,6 +1815,7 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
             if (len >= sizeof(uint32_t)) {
                 *dst = tswap32(*dst);
             }
+#endif
         } else {
             qemu_log_mask(LOG_UNIMP, "Unsupported ancillary data: %d/%d\n",
                           cmsg->cmsg_level, cmsg->cmsg_type);
-- 
2.41.0


