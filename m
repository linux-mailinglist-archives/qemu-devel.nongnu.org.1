Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E79C746036
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 17:58:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGLwb-0002ky-Po; Mon, 03 Jul 2023 11:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGLwa-0002jA-3v; Mon, 03 Jul 2023 11:58:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGLwY-0004iP-LO; Mon, 03 Jul 2023 11:58:27 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 363Fqoqg009106; Mon, 3 Jul 2023 15:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=w8bxAgKTp/VILNbU/B8PXQrB3yTDnc4YJ1nYEUsplUw=;
 b=auTEcTKU8Crd8nqVM7QHFBSnC2jGQADPKujhXtnUaG4dtvigzDrmL7cZkQIYQMapP8Lt
 fb5LnkIoROow17Y2wMOLJK5ErVSuosHUtRY20uMKwlt7XFC0Vur7Vrpwp+o4KgyhUgW3
 8V/rd2iZAgLMwugoFnXYc1vzk+fyQN3Ih0HMfWzxQpA5nxaNz05yTI1wJZ1CpyohHSTr
 N0e+vZdo4QFfW4n53v9nRXRA2bsyJJbqUo7/7V8lWtPVFnNbwP7IDgO+4+VZ8oEzedUF
 XWJBAcghxjWzxwxc17Fi6TXX8zNOgesN+8ox1L/XobLzi4Cy+QPNIyPVccH8pI/oeyVQ sw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm1bur39s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:24 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 363FqoOT009092;
 Mon, 3 Jul 2023 15:58:24 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm1bur39b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:24 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 363DbCiY021446;
 Mon, 3 Jul 2023 15:58:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3rjbs4s1eb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:22 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 363FwJ3B16646682
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Jul 2023 15:58:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8E1620043;
 Mon,  3 Jul 2023 15:58:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 947AE20040;
 Mon,  3 Jul 2023 15:58:19 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Jul 2023 15:58:19 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 06/12] target/s390x: Fix LRA when DAT is off
Date: Mon,  3 Jul 2023 17:50:32 +0200
Message-ID: <20230703155801.179167-7-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703155801.179167-1-iii@linux.ibm.com>
References: <20230703155801.179167-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7o7rP8RfeBeAK5nm57SxGNWJ0WKz-xlU
X-Proofpoint-ORIG-GUID: 1LNxH9JJC44Y6Xolkk-d3ZsbDAo-HaV0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=952
 malwarescore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307030141
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

LRA should perform DAT regardless of whether it's on or off.
Disable DAT check for MMU_S390_LRA.

Fixes: defb0e3157af ("s390x: Implement opcode helpers")
Cc: qemu-stable@nongnu.org
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


