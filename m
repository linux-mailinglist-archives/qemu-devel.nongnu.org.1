Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 575F77577E2
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 11:25:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLgus-00068z-OV; Tue, 18 Jul 2023 05:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qLguq-00066Y-62; Tue, 18 Jul 2023 05:22:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qLgun-0000rM-5d; Tue, 18 Jul 2023 05:22:43 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36I9CQYe020188; Tue, 18 Jul 2023 09:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KXvWGLArp2NXYnDGEg5OW+y+iic+nC3hHsAEKkLdE+Y=;
 b=hipLUCPmg3KVlGF2zKOOJuyt1dWImKtawoIT08Q60Us1ODEIZGD3LhLczU36ytJAlpjj
 PXnmX1IrtgY8cKvO+et0fQIbsLj16BwzRKW2aIxiEMTPgXcb+Dmkfh2LK9Qqk0y1fHzL
 F2QUSObllFHEGNOrcUtobzhvPtTL428ZcDdo6qOd3jf9pQPO0OI+0ZH61YDdDITA6qHu
 78gMPL6FwvZSn7TT8LI96tQ/KEzy1dvsFF2yiF3Iafgj1cYsVdnu5rOMY0Tx6ysT4YTA
 /991vOU1RUEn10Zductn0vR//XOaSx0LyOYSwqVRSpwDzr3yWZKBU0BYKGoIxWtriBv7 aA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwqw488kx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:36 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36I9CvMf021544;
 Tue, 18 Jul 2023 09:22:36 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwqw488kd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:36 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36I6xsX5029098; Tue, 18 Jul 2023 09:22:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv6smcm81-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:34 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36I9MVUx44565044
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jul 2023 09:22:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAB1120043;
 Tue, 18 Jul 2023 09:22:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B58E20040;
 Tue, 18 Jul 2023 09:22:29 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Jul 2023 09:22:29 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: mikey@neuling.org, vaibhav@linux.ibm.com, jniethe5@gmail.com,
 sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com,
 dbarboza@ventanamicro.com, npiggin@gmail.com
Subject: [PATCH 02/15] ppc: spapr: Add new/extend structs to support Nested
 PAPR API
Date: Tue, 18 Jul 2023 14:52:08 +0530
Message-Id: <20230718092221.1053686-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230718092221.1053686-1-harshpb@linux.ibm.com>
References: <20230718092221.1053686-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4aJaI_OwUpPedW5dZBJWm2g0_Ck_oCCi
X-Proofpoint-ORIG-GUID: Z2tB9ri7TNyL8C6KP6lzaS1djNLbITph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 mlxlogscore=822 malwarescore=0 mlxscore=0 impostorscore=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180082
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

This patch introduces new data structures to be used with Nested PAPR
API. Also extends kvmppc_hv_guest_state with additional set of registers
supported with nested PAPR API.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr_nested.h | 48 +++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 5cb668dd53..f8db31075b 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -189,6 +189,39 @@
 /* End of list of Guest State Buffer Element IDs */
 #define GSB_LAST                GSB_VCPU_SPR_ASDR
 
+typedef struct SpaprMachineStateNestedGuest {
+    unsigned long vcpus;
+    struct SpaprMachineStateNestedGuestVcpu *vcpu;
+    uint64_t parttbl[2];
+    uint32_t pvr_logical;
+    uint64_t tb_offset;
+} SpaprMachineStateNestedGuest;
+
+struct SpaprMachineStateNested {
+
+    uint8_t api;
+#define NESTED_API_KVM_HV  1
+#define NESTED_API_PAPR    2
+    uint64_t ptcr;
+    uint32_t lpid_max;
+    uint32_t pvr_base;
+    bool capabilities_set;
+    GHashTable *guests;
+};
+
+struct SpaprMachineStateNestedGuestVcpuRunBuf {
+    uint64_t addr;
+    uint64_t size;
+};
+
+typedef struct SpaprMachineStateNestedGuestVcpu {
+    bool enabled;
+    struct SpaprMachineStateNestedGuestVcpuRunBuf runbufin;
+    struct SpaprMachineStateNestedGuestVcpuRunBuf runbufout;
+    CPUPPCState env;
+    int64_t tb_offset;
+    int64_t dec_expiry_tb;
+} SpaprMachineStateNestedGuestVcpu;
 
 /*
  * Register state for entering a nested guest with H_ENTER_NESTED.
@@ -228,6 +261,21 @@ struct kvmppc_hv_guest_state {
     uint64_t dawr1;
     uint64_t dawrx1;
     /* Version 2 ends here */
+    uint64_t dec;
+    uint64_t fscr;
+    uint64_t fpscr;
+    uint64_t bescr;
+    uint64_t ebbhr;
+    uint64_t ebbrr;
+    uint64_t tar;
+    uint64_t dexcr;
+    uint64_t hdexcr;
+    uint64_t hashkeyr;
+    uint64_t hashpkeyr;
+    uint64_t ctrl;
+    uint64_t vscr;
+    uint64_t vrsave;
+    ppc_vsr_t vsr[64];
 };
 
 /* Latest version of hv_guest_state structure */
-- 
2.39.3


