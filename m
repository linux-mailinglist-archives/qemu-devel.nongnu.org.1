Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 238C27ADDF0
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 19:46:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkpeg-0003ho-3m; Mon, 25 Sep 2023 13:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qkpeZ-0003gA-OJ; Mon, 25 Sep 2023 13:45:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qkpeY-0008Lf-9J; Mon, 25 Sep 2023 13:45:51 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38PHQEHd017819; Mon, 25 Sep 2023 17:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Sf6y0NMsrhXGwj848huaJWakvsIgIFJHrg9cthj5n3w=;
 b=Ar3Udw8EB9gsTg33T+SldHgh05TmsdVq5XXKc3rG5TKKMLVcGMOk5tJYspuy0/My81YJ
 2ypaiaNv0BYYhYYQfeOt7WxpNcKK3ZDsI7oYdgYKF/rOH2fv2u+0FtHUB5uGcc50Le3M
 NQ48OD+/z7qoyJAgmlNVQ+YctzesIhpKN+f2Gna4mdxxKOMF5GHbAV2fPFi89/+R41Zj
 wfOBoceKsos6uHVmiKFrPxvBcc9sZVtck2WvU6Di4ai5E0+dIdoqJMEdd778f2L0feK8
 5fn9fHW25TPF2AGSf3oxoAkufdo+3zdqCZ44RfUcOIto6l5GqwmnCsn4UOId+/PT0cKr KA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbbacxgj6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Sep 2023 17:45:30 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38PHIcld026243;
 Mon, 25 Sep 2023 17:45:29 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbbacxght-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Sep 2023 17:45:29 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38PG2s5m011003; Mon, 25 Sep 2023 17:45:29 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabuk3xe2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Sep 2023 17:45:29 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38PHjSLm5374550
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Sep 2023 17:45:29 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA0415805D;
 Mon, 25 Sep 2023 17:45:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFAE95805A;
 Mon, 25 Sep 2023 17:45:28 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 25 Sep 2023 17:45:28 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (localhost [127.0.0.1])
 by mamboa4.aus.stglabs.ibm.com (Postfix) with ESMTPS id E1BB016A065F;
 Mon, 25 Sep 2023 12:45:27 -0500 (CDT)
Received: (from mglenn@localhost)
 by mamboa4.aus.stglabs.ibm.com (8.15.2/8.15.2/Submit) id 38PHjRrH619592;
 Mon, 25 Sep 2023 12:45:27 -0500
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v3 4/4] target/ppc: Add migration support for BHRB
Date: Mon, 25 Sep 2023 12:43:51 -0500
Message-Id: <20230925174351.617891-5-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230925174351.617891-1-milesg@linux.vnet.ibm.com>
References: <20230925174351.617891-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 15tQoOvm0it8i2vI81nCR2RrryauONaQ
X-Proofpoint-GUID: N5vKkWwIVM4rLBiCwywRRpX3jF81Cr9r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_15,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=786 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309250137
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=mglenn@mamboa4.aus.stglabs.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
 target/ppc/machine.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index d42e475bfb..ba328ad5e2 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -711,6 +711,26 @@ static const VMStateDescription vmstate_reservation = {
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
@@ -756,6 +776,7 @@ const VMStateDescription vmstate_ppc_cpu = {
 #ifdef TARGET_PPC64
         &vmstate_tm,
         &vmstate_slb,
+        &vmstate_bhrb,
 #endif /* TARGET_PPC64 */
         &vmstate_tlb6xx,
         &vmstate_tlbemb,
-- 
2.31.1


