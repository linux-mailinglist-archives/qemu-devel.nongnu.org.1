Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C424583120A
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 05:12:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQJkW-000649-Dh; Wed, 17 Jan 2024 23:11:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1rQEV2-0000Om-C7; Wed, 17 Jan 2024 17:35:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1rQEUz-0005vZ-LD; Wed, 17 Jan 2024 17:35:08 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40HM7OaY011547; Wed, 17 Jan 2024 22:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ganwBGobDR51+5tVv3oDeooG03YbgetMhqLf8bCFGeQ=;
 b=cAsc1wWkAcLwDAoTq9ritFhCuAK3ezUUoRlKXZjGJZ8KNnHMVh/uROgdtlhGIFqAKU3L
 DDcKcZiOZxgwUVChdh8oixHoNkc/vrfssf9BI0h9PKjYd/UFSGYJrnfGQMPlIgYCp1GB
 S7x+q/UpGy3A6r4hMjf5CS0RBuNcBqx8GrUtryOwz0kbdypwj1Mh8ukFR032knZkfNyS
 A/BuXLEaN0l/zMRitlrz0IAMw/iC+H+lDUh2Hb3vSSOxd3vblZtY50Puip43cDbfalF6
 KVePXxtyfGrQzSKIq+JldMt6jGbbmg6YAD4j/LtPk6HJbfo7NSTnHoDfya/afxvyZkSn WA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpqdhgrs4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 22:34:56 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40HM8iEn016842;
 Wed, 17 Jan 2024 22:34:55 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpqdhgrrd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 22:34:55 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40HJeINi006878; Wed, 17 Jan 2024 22:34:54 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm7j1yfmh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 22:34:54 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40HMYr1j43713122
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jan 2024 22:34:54 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC02658056;
 Wed, 17 Jan 2024 22:34:53 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 977115803F;
 Wed, 17 Jan 2024 22:34:53 +0000 (GMT)
Received: from gfwa819.aus.stglabs.ibm.com (unknown [9.3.62.57])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jan 2024 22:34:53 +0000 (GMT)
From: dan tan <dantan@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org, qemu-ppc@nongnu.org
Subject: [PATCH]     ppc/pnv: Add PowerPC Special Purpose Registers (SPRs):
Date: Wed, 17 Jan 2024 16:34:29 -0600
Message-Id: <20240117223429.2295-2-dantan@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240117223429.2295-1-dantan@linux.vnet.ibm.com>
References: <20240117223429.2295-1-dantan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bgCUkakiYMC2jLpWf62dGJRn79NA9aAP
X-Proofpoint-GUID: IaisqOCFKfbutI-pKQFNbGR150lyrt4d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=742
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401170161
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dantan@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jan 2024 23:11:26 -0500
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

    The handling of the following SPRs are added -
        ITV1  (0x375, 885) - noop (not in Power10 ISA)
        SIER2 (0x2f0, 752) - Sampled Instruction Event Register 2
        SIER2 (0x2f1, 753) - Sampled Instruction Event Register 3
        MMCR3 (0x2f2, 754) - Performance Monitor Mode Control Register 3

    Signed-off-by: dan tan <dantan@linux.vnet.ibm.com>
---
 target/ppc/cpu.h      |  4 ++++
 target/ppc/cpu_init.c | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index f8101ff..de0af02 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1933,6 +1933,9 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_BOOKE_TLB2CFG     (0x2B2)
 #define SPR_BOOKE_TLB3CFG     (0x2B3)
 #define SPR_BOOKE_EPR         (0x2BE)
+#define SPR_POWER_SIER2       (0x2F0)
+#define SPR_POWER_SIER3       (0x2F1)
+#define SPR_POWER_MMCR3       (0x2F2)
 #define SPR_PERF0             (0x300)
 #define SPR_RCPU_MI_RBA0      (0x300)
 #define SPR_MPC_MI_CTR        (0x300)
@@ -2053,6 +2056,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_440_INV3          (0x373)
 #define SPR_440_ITV0          (0x374)
 #define SPR_440_ITV1          (0x375)
+#define SPR_ITV1              (0x375)
 #define SPR_440_ITV2          (0x376)
 #define SPR_440_ITV3          (0x377)
 #define SPR_440_CCR1          (0x378)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 40fe14a..71c46b2 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5294,6 +5294,18 @@ static void register_power8_pmu_sup_sprs(CPUPPCState *env)
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_CSIGR, 0x00000000);
+    spr_register_kvm(env, SPR_POWER_MMCR3, "MMCR3",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic,
+                     KVM_REG_PPC_MMCR3, 0x00000000);
+    spr_register_kvm(env, SPR_POWER_SIER2, "SIER2",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic,
+                     KVM_REG_PPC_SIER2, 0x00000000);
+    spr_register_kvm(env, SPR_POWER_SIER3, "SIER3",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic,
+                     KVM_REG_PPC_SIER3, 0x00000000);
 }
 
 static void register_power8_pmu_user_sprs(CPUPPCState *env)
@@ -5670,6 +5682,11 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
                  &spr_access_nop, &spr_write_generic,
                  &spr_access_nop, &spr_write_generic,
                  0x00000000);
+    spr_register_hv(env, SPR_ITV1, "ITV1",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_access_nop, &spr_write_generic,
+                 &spr_access_nop, &spr_write_generic,
+                 0x00000000);
 #endif
 }
 
-- 
1.8.3.1


