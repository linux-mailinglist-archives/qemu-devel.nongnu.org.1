Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AE071EED6
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:26:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4l7k-0003XX-0L; Thu, 01 Jun 2023 12:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q4l7f-0003UD-Ev; Thu, 01 Jun 2023 12:26:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q4l7c-00062C-LC; Thu, 01 Jun 2023 12:25:59 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 351GELGF030680; Thu, 1 Jun 2023 16:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=grDo/rhldMf7MtETJfVDpiwIhxhJY26o1W8IPAVQ/GE=;
 b=RGNWMOrbzDJz2IPiCHhcSBx2ssxbkmRdU1rncGOOjiwjV0XMHDWWEYU82RKhtcnehlsG
 Oi/xMXV1TlsmB+grRWtnHJrUQaZdI2iwwn94vnq7rjBsaC/wlZXVVRGOinkTqg4kkiiW
 jaL5cSChiqRkv8xIKwiFnEdZbpJ5CcNwFeYhO1PkDLI433GsLfo4bqkTfTu5mTFUYn4P
 sGND9ir4LdMp43ygPG6JPukoy+0ypn6t3htfs/I4T8Yl/Shl65cbePX1KGl8YEdvhuKc
 cjRhNmVRieQUGUazgdtl+Oy3S+KeLElO2wYC1FpVJwfsyZHGnWjAd1bA1K2UWhpGYnmf mA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxxp10akp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 16:25:53 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 351GFc5o001654;
 Thu, 1 Jun 2023 16:25:53 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxxp10aju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 16:25:53 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3510vbbQ006682;
 Thu, 1 Jun 2023 16:25:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qu94e2mju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 16:25:51 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 351GPnWP43450804
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Jun 2023 16:25:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09FFD2004D;
 Thu,  1 Jun 2023 16:25:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9155F20040;
 Thu,  1 Jun 2023 16:25:48 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.86.130])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Jun 2023 16:25:48 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/4] s390x/tcg: Fix CPU address returned by STIDP
Date: Thu,  1 Jun 2023 18:25:38 +0200
Message-Id: <20230601162541.689621-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601162541.689621-1-iii@linux.ibm.com>
References: <20230601162541.689621-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cE1pggHTdAI76k9diCW24_Sr8flRPXQU
X-Proofpoint-ORIG-GUID: qGAWVzpBVuOyuIFKmu_p2Cf-gcq5LBnC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=828 phishscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010139
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

    cpu number      : 0
    identification  : 000000

    cpu number      : 1
    identification  : 400000

The highest nibble is supposed to contain the CPU address, but it's off
by 2 bits. Fix the shift value and provide a symbolic constant for it.

Fixes: 076d4d39b65f ("s390x/cpumodel: wire up cpu type + id for TCG")
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


