Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A713D75A188
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 00:14:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMFQK-00070u-GL; Wed, 19 Jul 2023 18:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qMFQF-0006xi-9n; Wed, 19 Jul 2023 18:13:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qMFQA-0002BB-7d; Wed, 19 Jul 2023 18:13:26 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36JM7dsG012732; Wed, 19 Jul 2023 22:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FlyOf9oq0x+iP9CBz30rO3kLhWdt/tAMRJGAuC/viog=;
 b=sU9BmxdqxGHDRUqnUtfIH5rxm/5lT712H5fp3NN6510BJnaUYTEtbxP3QYt1RxhZknXk
 vZoDxHifGPsDVzrTD1qhK2lRNm2W+ZXeVUgjmVGduH1jAuBIXNX6dXFTUBqcOIxSuSBE
 shDaq+PjciIxpZcJ6/DA1k4k5gQfYzLhdR8yA4dTndzjOADOOLAZxP1BCVaWHvGMn2jj
 P4yQFUUh1ST3+9evxvEK9MZCYv1q7pvyB2L9mgwPF4GVv4+Rzwy59PF6gwr+xYAVMmW2
 zPkvOjDMTYragAD885wQsVmfXI5Iz7b3ZkOy8E03o4//8du0MbC21rsjvaJwaYux7qIk rA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxjx97u0v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 22:13:18 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36JM7ldu013657;
 Wed, 19 Jul 2023 22:13:17 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxjx97u0q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 22:13:17 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36JJoShq017218; Wed, 19 Jul 2023 22:13:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv5srvr77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 22:13:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36JMDFRf17957458
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jul 2023 22:13:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55CF520065;
 Wed, 19 Jul 2023 22:13:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A77E32005A;
 Wed, 19 Jul 2023 22:13:14 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.5.152])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Jul 2023 22:13:14 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v3 02/14] target/s390x: Fix CLM with M3=0
Date: Thu, 20 Jul 2023 00:11:14 +0200
Message-ID: <20230719221310.1968845-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719221310.1968845-1-iii@linux.ibm.com>
References: <20230719221310.1968845-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PzeJvMm-Fi_i4IHp55RFJvbs3u5iA8ua
X-Proofpoint-ORIG-GUID: CgxKIpwfGeYc3EIVXuv7iF_ZMDzhlUcF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190199
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

When the mask is zero, access exceptions should still be recognized for
1 byte at the second-operand address. CC should be set to 0.

Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: qemu-stable@nongnu.org
Fixes: defb0e3157af ("s390x: Implement opcode helpers")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/mem_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index f417fb1183c..d6dc8b32620 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -667,6 +667,11 @@ uint32_t HELPER(clm)(CPUS390XState *env, uint32_t r1, uint32_t mask,
     HELPER_LOG("%s: r1 0x%x mask 0x%x addr 0x%" PRIx64 "\n", __func__, r1,
                mask, addr);
 
+    if (!mask) {
+        /* Recognize access exceptions for the first byte */
+        cpu_ldub_data_ra(env, addr, ra);
+    }
+
     while (mask) {
         if (mask & 8) {
             uint8_t d = cpu_ldub_data_ra(env, addr, ra);
-- 
2.41.0


