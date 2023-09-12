Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D54379DB16
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 23:44:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgBAf-00086E-Qs; Tue, 12 Sep 2023 17:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qgBAc-00083o-U4; Tue, 12 Sep 2023 17:43:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qgBAa-0002sa-9i; Tue, 12 Sep 2023 17:43:42 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38CKNHxd031018; Tue, 12 Sep 2023 20:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ty2i6N8zZdRbCSNJodS5nxJuLTl4coCL+W4QZr42REg=;
 b=bMIWiQsVsoDXJd4KLAWXgCtCADCfUlU3yPsC6XPpQLQX6ojThewMhltEDeK2RkCEjM/K
 VbLr/MJVss/w453G9ad01/kVk/zJAYJVaKZf8bFn9ygXNMt5ukOlcneVXdJK0ZxXcTUA
 Ono1CW9E9/NMq2Fl/EWkLaQZj4vcXNE5Y1OSrVp1dGdZT97WTxhcs06CcMOLc8wMmhUK
 d2tJMk4l6ing6QM6HXbD5JI4ZkymYJETDF9ERKrG/B3o0TZ/oyEe1/EEmxSeY33RhtrG
 86M81RHpneps9DZzprzLNr9ZQLPJ/lOZMva4Fa5XRkGW7/DEMTZtmnspqu1YMWDoP0Rq TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2xyt00rq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Sep 2023 20:25:22 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38CKOfXr002655;
 Tue, 12 Sep 2023 20:25:22 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2xyt00rg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Sep 2023 20:25:22 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38CIwPaG002362; Tue, 12 Sep 2023 20:25:21 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t158k5k0r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Sep 2023 20:25:20 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38CKPK8060096774
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Sep 2023 20:25:20 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AEDCD5805D;
 Tue, 12 Sep 2023 20:25:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D12458060;
 Tue, 12 Sep 2023 20:25:19 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 12 Sep 2023 20:25:19 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (localhost [127.0.0.1])
 by mamboa4.aus.stglabs.ibm.com (Postfix) with ESMTPS id 1D64916A073D;
 Tue, 12 Sep 2023 15:25:19 -0500 (CDT)
Received: (from mglenn@localhost)
 by mamboa4.aus.stglabs.ibm.com (8.15.2/8.15.2/Submit) id 38CKPJZs3382667;
 Tue, 12 Sep 2023 15:25:19 -0500
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [PATCH 4/4] target/ppc: Add migration support for BHRB
Date: Tue, 12 Sep 2023 15:25:14 -0500
Message-Id: <20230912202514.3382619-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230912192144.3330174-1-milesg@linux.vnet.ibm.com>
References: <20230912192144.3330174-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OM8iAr0ZEYP_zqC8o2Xakj0nIC1RuEJt
X-Proofpoint-GUID: Xg8v63JE_eo2Kk6oWNF9xk_QwypTzWYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=808
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120169
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=mglenn@mamboa4.aus.stglabs.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Adds migration support for Branch History Rolling
Buffer (BHRB) internal state.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---
 target/ppc/machine.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index b195fb4dc8..89146969c8 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -314,6 +314,7 @@ static int cpu_post_load(void *opaque, int version_id)
 
     if (tcg_enabled()) {
         pmu_mmcr01a_updated(env);
+        hreg_bhrb_filter_update(env);
     }
 
     return 0;
@@ -670,6 +671,27 @@ static const VMStateDescription vmstate_compat = {
     }
 };
 
+#ifdef TARGET_PPC64
+static bool bhrb_needed(void *opaque)
+{
+    PowerPCCPU *cpu = opaque;
+    return (cpu->env.flags & POWERPC_FLAG_BHRB) != 0;
+}
+
+static const VMStateDescription vmstate_bhrb = {
+    .name = "cpu/bhrb",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = bhrb_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINTTL(env.bhrb_num_entries, PowerPCCPU),
+        VMSTATE_UINTTL(env.bhrb_offset, PowerPCCPU),
+        VMSTATE_UINT64_ARRAY(env.bhrb, PowerPCCPU, BHRB_MAX_NUM_ENTRIES),
+        VMSTATE_END_OF_LIST()
+    }
+};
+#endif
+
 const VMStateDescription vmstate_ppc_cpu = {
     .name = "cpu",
     .version_id = 5,
@@ -716,6 +738,7 @@ const VMStateDescription vmstate_ppc_cpu = {
 #ifdef TARGET_PPC64
         &vmstate_tm,
         &vmstate_slb,
+        &vmstate_bhrb,
 #endif /* TARGET_PPC64 */
         &vmstate_tlb6xx,
         &vmstate_tlbemb,
-- 
2.31.1


