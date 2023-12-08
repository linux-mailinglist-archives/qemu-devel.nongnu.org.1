Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C4E80975B
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 01:39:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBOsi-0003ep-63; Thu, 07 Dec 2023 19:38:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rBOsf-0003eH-No
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 19:38:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rBOse-0000bL-1y
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 19:38:13 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B80COfa027110; Fri, 8 Dec 2023 00:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XeFCZ/mnNJBKJpWvAYBZTSOcL/Iwgq3RN4MGosMd/i8=;
 b=CnbAdk/TN471OhRitu/SVZ6sRXLtWGUPJ9uwF/GMIFY6/og4Dxfu74D0RLuZ8NWSW/Zj
 aSml+rCW09SYDWyT9LZtI+BG89TQgZEW9olqXZnJQOuMA1CjOndKPIM7VK6LC7TpA+Bh
 R0MYBNbLhhD4ZAsEHRKilsghv8eLY0IqeNUsu+GE3IGU3w0irRpX8n0+VoqpQEt4hinv
 3mez18Qo+8XjkOb+RNmnYR08jP6V06eSeiQjdpxLi1xYcGZ8yHrYyI21C7NQjlJwHOpx
 lRv3xLFX80fNnsVfghVJIHbAy120VzBk0swgzbNP3cAi0bCL/j2XxBD5moMVzKjGIv7p xA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uurd30ggc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 00:38:08 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B80EtlK000959;
 Fri, 8 Dec 2023 00:38:08 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uurd30gg1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 00:38:07 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7NKKoL001541; Fri, 8 Dec 2023 00:38:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3utav2pke9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 00:38:06 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3B80c4OK44564996
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Dec 2023 00:38:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AA9A2004E;
 Fri,  8 Dec 2023 00:38:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E777420040;
 Fri,  8 Dec 2023 00:38:03 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.70.26])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Dec 2023 00:38:03 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 3/4] accel/tcg: Remove #ifdef TARGET_I386 from perf.c
Date: Fri,  8 Dec 2023 01:35:35 +0100
Message-ID: <20231208003754.3688038-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208003754.3688038-1-iii@linux.ibm.com>
References: <20231208003754.3688038-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: biykHAx7wLm8HcC4uxqQWqVKjJ6vJm9H
X-Proofpoint-ORIG-GUID: YvIKy5oCoarL4b9P86BwT0ELtVxAot_a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_19,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312080003
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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
index ba75c1bbe45..68a46b1b524 100644
--- a/accel/tcg/perf.c
+++ b/accel/tcg/perf.c
@@ -337,10 +337,6 @@ void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
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
2.43.0


