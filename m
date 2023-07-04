Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CEF746BB9
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:17:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbCg-0003sO-BZ; Tue, 04 Jul 2023 04:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGbCI-0003Th-2H; Tue, 04 Jul 2023 04:15:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGbCF-0002fG-PU; Tue, 04 Jul 2023 04:15:41 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36487WW2012223; Tue, 4 Jul 2023 08:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yPkG4WpyJ6VIoQRdKvdNlIOkXdTqybwCHdN+9hWJSyg=;
 b=gCRnR69Hf8mNM6exOWbbSB93iFJ1kFhErjNyPD/W8g1QOeiCSCVA8gNvllnCRUzhoyBo
 azUo7D5JjmE4wQ15l6E9BSbrAEdQ4jb7vvhX0bpTmjeDgH138NqWM+CYbOyN+24G/T67
 JZlzDmBpdfSwKmcPXExPdrwI2GuBbcs/GHcVxhVz8s/nhrq+S4CqKteT9XsYxn8J4qfT
 dXtpfbl3IOEtq1Hg1zJToCpMrmB5PpoXerrp874ruyyO7JIZMCwtCHIHwPPwRbwmKbbb
 odAfLuaXEH/LXzAU2FDvY7QgiyxRmUp4mujmQ+qCR18geUJkzhPEt8cTpXaXzGBExE7Z jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmfbb8jne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:15:36 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36488d0P017124;
 Tue, 4 Jul 2023 08:15:35 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmfbb8jkm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:15:35 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3647vhNx004915;
 Tue, 4 Jul 2023 08:15:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3rjbs4scuj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:15:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3648FTs726477206
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Jul 2023 08:15:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3705220043;
 Tue,  4 Jul 2023 08:15:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C0BA20040;
 Tue,  4 Jul 2023 08:15:28 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.30.217])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Jul 2023 08:15:28 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 06/12] target/s390x: Fix LRA when DAT is off
Date: Tue,  4 Jul 2023 10:12:30 +0200
Message-ID: <20230704081506.276055-7-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704081506.276055-1-iii@linux.ibm.com>
References: <20230704081506.276055-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5YBNgfRwRNaaBO_2DVXAwHuFZrSKL0AM
X-Proofpoint-ORIG-GUID: oUTvVl-EdknSFEOEDt4VVJ4o_crI6CU2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_04,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040065
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

LRA should perform DAT regardless of whether it's on or off.
Disable DAT check for MMU_S390_LRA.

Fixes: defb0e3157af ("s390x: Implement opcode helpers")
Cc: qemu-stable@nongnu.org
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/mmu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index b04b57c2356..fbb2f1b4d48 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -417,7 +417,7 @@ int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
 
     vaddr &= TARGET_PAGE_MASK;
 
-    if (!(env->psw.mask & PSW_MASK_DAT)) {
+    if (rw != MMU_S390_LRA && !(env->psw.mask & PSW_MASK_DAT)) {
         *raddr = vaddr;
         goto nodat;
     }
-- 
2.41.0


