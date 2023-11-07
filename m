Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B5E7E41B8
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:21:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0MxE-0000vN-EZ; Tue, 07 Nov 2023 09:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1r0MxA-0000sr-K4; Tue, 07 Nov 2023 09:21:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1r0Mx7-00071D-JZ; Tue, 07 Nov 2023 09:21:16 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A7EAag1013532; Tue, 7 Nov 2023 14:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=LObvxQEWeax/0iuezMdYjyLPQkqRrr64HBuZvDf4PxU=;
 b=WNBOE85xkvyXkI+gfX08bSUW/IvR5rmNG5EMirkAU0LL1jj0/nGjI3Gyy2W7y2Yx5+Qn
 H2C70fLBJOVQ2VuGEWOzPgf8QKs+nULPwHEth24xMoZXmtuzdqApVRHbtfB6wZ6sVcFe
 appSitqQOl97ksa19OgJWtNp61vhylp/jmr1aaRYJqCPN7c1TIbd1cMWf6n+QVTiNI7W
 ALLyq/Cg9rd/Hdt9uRIOlv48qOjkKpebqYZ4GxZAYMB9Quc6EthJ0foIP59oUg8lyCLI
 lV6zdN2JMUuwqFuIUhdNdAQA4SJ2LmVXlAXa4Fz7LN6AAOv/isN94CgxIG9GK7+bqtrv Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7ps4gp7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 14:21:10 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A7EBGVH018848;
 Tue, 7 Nov 2023 14:21:10 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7ps4gp70-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 14:21:10 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A7D97Al025652; Tue, 7 Nov 2023 14:21:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u619nh3vd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 14:21:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A7EL7kH43123082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Nov 2023 14:21:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5928720040;
 Tue,  7 Nov 2023 14:21:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E9B42004F;
 Tue,  7 Nov 2023 14:21:07 +0000 (GMT)
Received: from a46lp67.. (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Nov 2023 14:21:07 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com,
 imbrenda@linux.ibm.com
Subject: [PATCH 4/4] target/s390x/arch_dump: Add arch cleanup function for PV
 dumps
Date: Tue,  7 Nov 2023 14:20:48 +0000
Message-Id: <20231107142048.22422-5-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107142048.22422-1-frankja@linux.ibm.com>
References: <20231107142048.22422-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9jx0cTenXqvFZxs_DTjmy3iS7AKnvEBt
X-Proofpoint-ORIG-GUID: 1v6rBE2cHUiqodTgasB-vJH8Dm64RWoI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_05,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 phishscore=0 impostorscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070118
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

PV dumps block vcpu runs until dump end is reached. If there's an
error between PV dump init and PV dump end the vm will never be able
to run again. One example of such an error is insufficient disk space
for the dump file.

Let's add a cleanup function that tries to do a dump end. The dump
completion data is discarded but there's no point in writing it to a
file anyway if there's a possibility that other PV dump data is
missing.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 target/s390x/arch_dump.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index bdb0bfa0e7..70146d7e84 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -433,6 +433,22 @@ static int arch_sections_write(DumpState *s, uint8_t *buff)
     return 0;
 }
 
+static void arch_cleanup(DumpState *s)
+{
+    uint8_t *buff = g_malloc(kvm_s390_pv_dmp_get_size_completion_data());
+    int rc;
+
+    if (!pv_dump_initialized || !buff) {
+        return;
+    }
+
+    rc = kvm_s390_dump_completion_data(buff);
+    if (!rc) {
+            pv_dump_initialized = false;
+    }
+    g_free(buff);
+}
+
 int cpu_get_dump_info(ArchDumpInfo *info,
                       const struct GuestPhysBlockList *guest_phys_blocks)
 {
@@ -448,6 +464,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
         info->arch_sections_add_fn = *arch_sections_add;
         info->arch_sections_write_hdr_fn = *arch_sections_write_hdr;
         info->arch_sections_write_fn = *arch_sections_write;
+        info->arch_cleanup_fn = *arch_cleanup;
     }
     return 0;
 }
-- 
2.34.1


