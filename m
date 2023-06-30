Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 416C674434E
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 22:38:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFKsA-0008RU-6L; Fri, 30 Jun 2023 16:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qFKs4-0008QZ-37
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 16:37:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qFKs2-0006JO-HG
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 16:37:35 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UKWlKJ022943; Fri, 30 Jun 2023 20:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DfZpg3tRxwBY35ERCdfqAY9kHJIYHVo6ZGrIbknBsi0=;
 b=rrEIzzjm+8izGBOJc0fteCH3Toc+Csjmn7e/AHm9Of0UDNSwlfXycUoed/eM3cx+bclu
 I3wM+y7T0O0AxLuLjZEPMIfchTPMomI8nUjGVjnZlmyDp4FXHEV1pBGL8lPpUd7TDAlM
 lmKV6PawClRgrMVc+4YS7dzqJk0bDMNRiCTjHhZ+19dUYy/zOMD+8xnrejjh9PdmLhG6
 eZyZWqblT+LGnOLe83yVanRnZcOKMZg7METDqjA+mEub5sZkJ34+uaMVhoP0cYR3TYU2
 K+vIEaXsaDlF9YCZYFzhP4CEMiVXATlrf9UnpniKGmRqMxHf/k8Z3iE3eZwC/YM17i0H lA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj66b83jq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 20:37:32 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UKXMeX023596;
 Fri, 30 Jun 2023 20:37:31 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj66b83j1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 20:37:31 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35UJvdgv018439;
 Fri, 30 Jun 2023 20:37:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3rdr454e16-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 20:37:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35UKbRKF17760988
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 20:37:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C01120043;
 Fri, 30 Jun 2023 20:37:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D7FF20040;
 Fri, 30 Jun 2023 20:37:26 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.8.31])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jun 2023 20:37:26 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/4] tcg: Make tb_cflags() usable from target-agnostic code
Date: Fri, 30 Jun 2023 22:36:39 +0200
Message-ID: <20230630203720.528552-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630203720.528552-1-iii@linux.ibm.com>
References: <20230630203720.528552-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e5Xwq1ZdBxcs8L_bgCSPbvRW3XoN9GsF
X-Proofpoint-ORIG-GUID: 2UKPN2bpXrZxI-NR2iSIsWOl7V5EEEHU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_12,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300179
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

Currently tb_cflags() is defined in exec-all.h, which is not usable
from target-agnostic code. Move it to translation-block.h, which is.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 include/exec/exec-all.h          | 6 ------
 include/exec/translation-block.h | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 200c27eadfe..652fb9dc126 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -466,12 +466,6 @@ int probe_access_full(CPUArchState *env, vaddr addr, int size,
                       CPUTLBEntryFull **pfull, uintptr_t retaddr);
 #endif
 
-/* Hide the qatomic_read to make code a little easier on the eyes */
-static inline uint32_t tb_cflags(const TranslationBlock *tb)
-{
-    return qatomic_read(&tb->cflags);
-}
-
 static inline tb_page_addr_t tb_page_addr0(const TranslationBlock *tb)
 {
 #ifdef CONFIG_USER_ONLY
diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 5119924927e..7a7190bb30d 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -146,4 +146,10 @@ struct TranslationBlock {
 /* The alignment given to TranslationBlock during allocation. */
 #define CODE_GEN_ALIGN  16
 
+/* Hide the qatomic_read to make code a little easier on the eyes */
+static inline uint32_t tb_cflags(const TranslationBlock *tb)
+{
+    return qatomic_read(&tb->cflags);
+}
+
 #endif /* EXEC_TRANSLATION_BLOCK_H */
-- 
2.41.0


