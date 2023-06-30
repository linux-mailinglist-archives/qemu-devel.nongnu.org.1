Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A778E74455C
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 01:43:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFNlN-0008FT-Cl; Fri, 30 Jun 2023 19:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qFNlJ-0008Es-3g
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 19:42:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qFNlH-0006ib-Df
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 19:42:48 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UNc7cb008367; Fri, 30 Jun 2023 23:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=AwDwQEo/gOIwYlMLG/8WVP41Gh6hw3lcZGKXuH7pOsU=;
 b=kGJyoJ+v2s2wdSImMhqCKs/MiJrWqVFP85ZlOgQOFKHb2gnWbRwtGGb2JSrEwpv1xqil
 TNH5AOLAzcuU8Lsn5C4HBYJsDyK3MDKV87nGPjL1C/pOi2KBWufMKvajavvkuu62ys7N
 ylYnGVOmtEoDJ6cneORnduRyjFg7cb4hWNU5zkjbhGuwY5uJzSLo9bboxpIASCGH2SUZ
 oH+vHjVKAgpL1s/jEY9XvANDCHIWjKrq27CssYPSplcpVGeZd4eRXVGj1qULTjmnQxdI
 aTjol0bg/At/uz2VVdQBJF8UZtgp2wFiE5cmhRE1oJAZzSMLN5mpChzGuMgveMWLyjgj 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj8k7rcmd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 23:42:44 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UNgDMs018515;
 Fri, 30 Jun 2023 23:42:44 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj8k7rckk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 23:42:44 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35UMEOQg029944;
 Fri, 30 Jun 2023 23:42:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rdqre4fs3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 23:42:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35UNgdu219530334
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 23:42:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C2E020040;
 Fri, 30 Jun 2023 23:42:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF4092004B;
 Fri, 30 Jun 2023 23:42:38 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.8.31])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jun 2023 23:42:38 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 3/4] accel/tcg: Remove #ifdef TARGET_I386 from perf.c
Date: Sat,  1 Jul 2023 01:40:56 +0200
Message-ID: <20230630234230.596193-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630234230.596193-1-iii@linux.ibm.com>
References: <20230630234230.596193-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1mkvsAzWg9R5wssHCgbvaaGX5rGUeXqN
X-Proofpoint-GUID: IJdTDrJXJie8MymzjGxs6kBeieNPssGw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_13,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 mlxscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0 impostorscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306300206
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

Preparation for moving perf.c to tcg/.

This affects only profiling guest code, which has code in a non-0 based
segment, e.g., 16-bit code, which is not particularly important.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 accel/tcg/perf.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/accel/tcg/perf.c b/accel/tcg/perf.c
index b42742c4c0d..87583e9d8f2 100644
--- a/accel/tcg/perf.c
+++ b/accel/tcg/perf.c
@@ -336,10 +336,6 @@ void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
         q[insn].address = gen_insn_data[insn * start_words + 0];
         if (tb_cflags(tb) & CF_PCREL) {
             q[insn].address |= (guest_pc & qemu_target_page_mask());
-        } else {
-#if defined(TARGET_I386)
-            q[insn].address -= tb->cs_base;
-#endif
         }
         q[insn].flags = DEBUGINFO_SYMBOL | (jitdump ? DEBUGINFO_LINE : 0);
     }
-- 
2.41.0


