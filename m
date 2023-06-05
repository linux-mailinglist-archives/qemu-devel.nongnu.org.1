Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 076AA7224CD
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:41:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q68ZN-0008NA-AI; Mon, 05 Jun 2023 07:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q68ZA-0008Mj-Vd; Mon, 05 Jun 2023 07:40:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q68Z8-0001Lm-Qm; Mon, 05 Jun 2023 07:40:04 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 355Bd3wo007968; Mon, 5 Jun 2023 11:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8/7Ucu7bP+Bej9q4jKRvVmBuHIM33C7F/YTw5Jmu8Rg=;
 b=fl+/TA3CZt445pDPF5TWfB0itMufgpLkA6vw9vZaYtk0uWjF9NO6Y+GygIhWwgxmlnJu
 cLiaAXNQUWgokL4AnqbGGpaTBoJ7DPi/apsGdAl2RQ7MRcsLrH05SAzCbfZfAupHlU/H
 GinJ/bzaGrYZrkLrbcl1NXNgB/rkWrlB9xwo528KnQunKgplEzEJLobrLbmjCy/NXpu/
 VmsLJqzNV6+LdoJlfhDy2fM27F/vyGU3srQg/zpWurtV7u+xnEEC4osjz2DcqtV9GFYV
 y5l8LpyLneTJ8VWUJwejsHOSSahC7GNZUzZ65qJk2czY2yw3q+CWkI/oMWQKsWUWb/7i eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r1edyrqu8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jun 2023 11:39:59 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 355BdIeJ008479;
 Mon, 5 Jun 2023 11:39:58 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r1edyrqtu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jun 2023 11:39:58 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3550sWg9010031;
 Mon, 5 Jun 2023 11:39:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qyxg2ha6a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jun 2023 11:39:56 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 355Bdscm55378236
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Jun 2023 11:39:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A62FF20043;
 Mon,  5 Jun 2023 11:39:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D76B20040;
 Mon,  5 Jun 2023 11:39:54 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.209.184])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Jun 2023 11:39:54 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 1/4] s390x/tcg: Fix CPU address returned by STIDP
Date: Mon,  5 Jun 2023 13:39:47 +0200
Message-Id: <20230605113950.1169228-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605113950.1169228-1-iii@linux.ibm.com>
References: <20230605113950.1169228-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wZWao3Lx6ldQQJp4YOKyuVf8ww9dRTvt
X-Proofpoint-GUID: Q3iH101puMTQC9FZ4Z19UXWvOpzyPyfv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=923 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050103
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

In qemu-user-s390x, /proc/cpuinfo contains:

	processor 0: version = 00,  identification = 000000,  machine = 8561
	processor 1: version = 00,  identification = 400000,  machine = 8561

The highest nibble is supposed to contain the CPU address, but it's off
by 2 bits. Fix the shift value and provide a symbolic constant for it.

With the fix we get:

	processor 0: version = 00,  identification = 000000,  machine = 8561
	processor 1: version = 00,  identification = 100000,  machine = 8561

Fixes: 076d4d39b65f ("s390x/cpumodel: wire up cpu type + id for TCG")
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/cpu_models.c |  4 ++--
 target/s390x/cpu_models.h | 10 +++++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 457b5cb10c4..ae8880e81dc 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -607,8 +607,8 @@ void s390_realize_cpu_model(CPUState *cs, Error **errp)
 #if !defined(CONFIG_USER_ONLY)
     cpu->env.cpuid = s390_cpuid_from_cpu_model(cpu->model);
     if (tcg_enabled()) {
-        /* basic mode, write the cpu address into the first 4 bit of the ID */
-        cpu->env.cpuid = deposit64(cpu->env.cpuid, 54, 4, cpu->env.core_id);
+        cpu->env.cpuid = deposit64(cpu->env.cpuid, CPU_PHYS_ADDR_SHIFT,
+                                   CPU_PHYS_ADDR_BITS, cpu->env.core_id);
     }
 #endif
 }
diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index fb1adc8b210..cc7305ec213 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -96,10 +96,18 @@ static inline bool s390_known_cpu_type(uint16_t type)
 {
     return s390_get_gen_for_cpu_type(type) != 0;
 }
+#define CPU_ID_SHIFT 32
+#define CPU_ID_BITS 24
+/*
+ * When cpu_id_format is 0 (basic mode), the leftmost 4 bits of cpu_id contain
+ * the rightmost 4 bits of the physical CPU address.
+ */
+#define CPU_PHYS_ADDR_BITS 4
+#define CPU_PHYS_ADDR_SHIFT (CPU_ID_SHIFT + CPU_ID_BITS - CPU_PHYS_ADDR_BITS)
 static inline uint64_t s390_cpuid_from_cpu_model(const S390CPUModel *model)
 {
     return ((uint64_t)model->cpu_ver << 56) |
-           ((uint64_t)model->cpu_id << 32) |
+           ((uint64_t)model->cpu_id << CPU_ID_SHIFT) |
            ((uint64_t)model->def->type << 16) |
            (model->def->gen == 7 ? 0 : (uint64_t)model->cpu_id_format << 15);
 }
-- 
2.40.1


