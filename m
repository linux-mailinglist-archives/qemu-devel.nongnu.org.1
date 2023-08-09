Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0374775087
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 03:51:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTYMA-0001QU-HV; Tue, 08 Aug 2023 21:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bgray@linux.ibm.com>)
 id 1qTYM7-0001Hm-OP; Tue, 08 Aug 2023 21:51:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bgray@linux.ibm.com>)
 id 1qTYM5-0005Sk-MV; Tue, 08 Aug 2023 21:51:23 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3791o5I3026777; Wed, 9 Aug 2023 01:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=zVVwr4VtPTUY83ryHUI0AtNwfFnG/w15VLBR9rci2Hg=;
 b=TAON78Jf6y5NCFhvMmTlfWxW4+ejBoopaYLUktz5nhVXfWqLskni2O9Dr6zCUM5/iyww
 F6dzSGgkCT/rgaWCTMpkkS0v/tev9+s29ngO20u/qcYsYbFwS1z293yTfpvcnT7GXLHT
 JFKcA3E3FcL5BL8whPEswuX13tzJZhgLF12zeacLoMAKmoMZ0vMezgMmiFoW/nWAks9f
 XhhDIiMCQdCK1USYkMl6xwRn/jNSJlQ/P4MNy4tBmssNPHyq+xVBHbJW7J08puyJOMZ9
 8Reocrk1mzPI/I9Z+Hz65ZjZpWARYLHBX+yR1+ikhQLT1SZa7SQB69gj3rDziqxYryFY Xw== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sc15v8bss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Aug 2023 01:51:18 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3791V3D7007543; Wed, 9 Aug 2023 01:51:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa14yc8j4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Aug 2023 01:51:17 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3791pFA436962938
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Aug 2023 01:51:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75B612004B;
 Wed,  9 Aug 2023 01:51:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC6BB20043;
 Wed,  9 Aug 2023 01:51:14 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  9 Aug 2023 01:51:14 +0000 (GMT)
Received: from bgray-lenovo-p15.fritz.box (unknown [9.43.219.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id F2CED60113;
 Wed,  9 Aug 2023 11:51:09 +1000 (AEST)
From: Benjamin Gray <bgray@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Benjamin Gray <bgray@linux.ibm.com>
Subject: [PATCH] powerpc/spapr: Add DEXCR to device tree
Date: Wed,  9 Aug 2023 11:50:18 +1000
Message-ID: <20230809015018.44499-1-bgray@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aMS9kBfAJ2wyCJsNNNhyOr3AT6b3STXw
X-Proofpoint-ORIG-GUID: aMS9kBfAJ2wyCJsNNNhyOr3AT6b3STXw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_24,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090012
Received-SPF: pass client-ip=148.163.158.5; envelope-from=bgray@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Each DEXCR aspect is allocated a bit in the device tree, using the
68--71 byte range (inclusive). The functionality of the
[P]HASHST/[P]HASHCHK instructions is separately declared in byte 72,
bit 0 (BE).

QEMU supports these features (though the speculation aspects are just
tracked, they don't do anything), so declare this in the device tree.

Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>

---

The current design appears to duplicate the previous block and add the
new features after it. I copied that for the 3.10 features, but not sure
how well this scales, so alternatives welcome.
---
 hw/ppc/spapr.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1c8b8d57a7..df76d2dc12 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -244,6 +244,35 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
         /* 60: NM atomic, 62: RNG */
         0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
     };
+    uint8_t pa_features_310[] = { 74, 0,
+        /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: fri[nzpm]|DABRX|SPRG3|SLB0|PP110 */
+        /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, SSO, 5: LE|CFAR|EB|LSQ */
+        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0, /* 0 - 5 */
+        /* 6: DS207 */
+        0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
+        /* 16: Vector */
+        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
+        /* 18: Vec. Scalar, 20: Vec. XOR, 22: HTM */
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
+        /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
+        /* 30: MMR, 32: LE atomic, 34: EBB + ext EBB */
+        0x80, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
+        /* 36: SPR SO, 38: Copy/Paste, 40: Radix MMU */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 36 - 41 */
+        /* 42: PM, 44: PC RA, 46: SC vec'd */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
+        /* 48: SIMD, 50: QP BFP, 52: String */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
+        /* 54: DecFP, 56: DecI, 58: SHA */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
+        /* 60: NM atomic, 62: RNG */
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
+        /* 68: DEXCR */
+        0x00, 0x00, 0x9E, 0x00, 0x00, 0x00, /* 66 - 71 */
+        /* 72: [P]HASHCHK */
+        0x80, 0x00,                         /* 72 - 73 */
+    };
     uint8_t *pa_features = NULL;
     size_t pa_size;
 
@@ -259,6 +288,10 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
         pa_features = pa_features_300;
         pa_size = sizeof(pa_features_300);
     }
+    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0, cpu->compat_pvr)) {
+        pa_features = pa_features_310;
+        pa_size = sizeof(pa_features_310);
+    }
     if (!pa_features) {
         return;
     }
-- 
2.41.0


