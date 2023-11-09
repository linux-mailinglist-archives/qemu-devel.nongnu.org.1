Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD1A7E6A4F
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 13:05:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r13mf-0004xk-ID; Thu, 09 Nov 2023 07:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1r13mQ-0004Xs-36; Thu, 09 Nov 2023 07:05:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1r13mL-0002WP-SC; Thu, 09 Nov 2023 07:05:01 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A9C09ic012176; Thu, 9 Nov 2023 12:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0lQy95n5WPkpSfzDoVeg/I1Cmtx5niSWs63LQGRbx10=;
 b=M6KsZbraa20r0qD4gfXtmTeGb4U7qDNtbohnHVV7cXkSHVfdk4FKVFgoNrtY0ujRV5cn
 lK14bJGxyz196tytR6kC9lNN5dkXpqDus9kZ4AFhsnnRUp90YW+8hANVxP0MgFt+fQh4
 90X2X9t3Jp8PZ6iuUJR0JZA9B5WcgQlSo3uH7YkFdwftBmFsiI/FbJrcI1s4S0A+sGIg
 mgEHJQZc12kWEGOVCFM4dFEGPMTcSFd1HoqdFeHjws2C2PlP2c01UAuVL04JmCkJbS9B
 vOm0XfWpdIf1VjhKngdmStyEfDbUeiQNqwX6x42sfModds4gz/BKiGh9q3xKXvqudNbN Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8y1x05by-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 12:04:54 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A9C1S9D019682;
 Thu, 9 Nov 2023 12:04:53 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8y1x05bp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 12:04:53 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A9BV2ZW019429; Thu, 9 Nov 2023 12:04:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w243htp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 12:04:52 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A9C4pRu13501170
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Nov 2023 12:04:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A19F20040;
 Thu,  9 Nov 2023 12:04:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05C4120049;
 Thu,  9 Nov 2023 12:04:51 +0000 (GMT)
Received: from a46lp67.. (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Nov 2023 12:04:50 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com,
 imbrenda@linux.ibm.com
Subject: [PATCH v2 3/3] target/s390x/arch_dump: Add arch cleanup function for
 PV dumps
Date: Thu,  9 Nov 2023 12:04:43 +0000
Message-Id: <20231109120443.185979-4-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109120443.185979-1-frankja@linux.ibm.com>
References: <20231109120443.185979-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RnN4wKB-yHKeTFhqGN0USggsHkwy1_kD
X-Proofpoint-ORIG-GUID: TVDv9DeR3tbkSiIo4m695IRiaONuzXQj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=918 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090089
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
index bdb0bfa0e7..7e8a1b4fc0 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -433,6 +433,22 @@ static int arch_sections_write(DumpState *s, uint8_t *buff)
     return 0;
 }
 
+static void arch_cleanup(DumpState *s)
+{
+    g_autofree uint8_t *buff = NULL;
+    int rc;
+
+    if (!pv_dump_initialized) {
+        return;
+    }
+
+    buff = g_malloc(kvm_s390_pv_dmp_get_size_completion_data());
+    rc = kvm_s390_dump_completion_data(buff);
+    if (!rc) {
+            pv_dump_initialized = false;
+    }
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


