Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E21B8B49A99
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Sep 2025 22:03:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvi3U-0001nb-6n; Mon, 08 Sep 2025 16:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uvi3R-0001mm-5h; Mon, 08 Sep 2025 16:01:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uvi3O-0006tQ-VX; Mon, 08 Sep 2025 16:01:32 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588J5vL4030018;
 Mon, 8 Sep 2025 20:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ZxrZpsIH/cZNyxirG
 J9eYD0u2tv0u7H9eYN85zUAfU0=; b=OS03U+wxF2Sksw3YWg8lpHo+yScBskFyB
 +OjHdMDsJI1oVuSZ/vHgLPj4BGofPRWBeOxum9O8xn0NXGTPW/n31/oZtsicqX9m
 kMb3Ne9gmMPutpc4M5ZNiFXJ6kL+UiPXCfJuO3SMccHH9OXmNxk8UJnJIFhqrbBg
 h5hRdDMsINLOQNPI9NjHbQyGvGftnuw9uMFeIZo8z4spqxXLmE7qqXH1x3juhMyJ
 11ahxuuaDOWR3HJDiHZZ8X3EdrhIa5oJWM5e27Y3MtGBuMnBoItFPKKqKR7qv+o/
 LfzqvHvc1FgyCjN0Gpy0Vu6MIYmg6l0iXJZDKyEtlBW1NoKs5u5tw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cff3pyb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Sep 2025 20:01:26 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 588Jx9PE000586;
 Mon, 8 Sep 2025 20:01:26 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cff3py7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Sep 2025 20:01:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 588I2RA8001155;
 Mon, 8 Sep 2025 20:01:25 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4912037dy8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Sep 2025 20:01:25 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 588K1OMx21561890
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Sep 2025 20:01:24 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CC9D5805D;
 Mon,  8 Sep 2025 20:01:24 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E7ED5805B;
 Mon,  8 Sep 2025 20:01:23 +0000 (GMT)
Received: from mglenn-KVM.. (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Sep 2025 20:01:23 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, clg@redhat.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, thuth@redhat.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org
Subject: [PATCH v3 3/9] target/ppc: IBM PPE42 exception flags and regs
Date: Mon,  8 Sep 2025 15:00:13 -0500
Message-ID: <20250908200028.115789-4-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908200028.115789-1-milesg@linux.ibm.com>
References: <20250908200028.115789-1-milesg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e8LtuTNngVHSRFIMtuapXVGY9iLfolOH
X-Proofpoint-GUID: wbRTTrZfDx80Vzt3xCm4DM5hzIVcPaXF
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68bf3617 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=kP3OWSx2Bt75d2xkwRIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX1Yn4wSJUMyqP
 3mV/9qoKccaKOHOrONkyzF63pmH/33rvbfyE81LzZpglwSawq/F0crWIAL8uPpnvuqWNK9vNzUh
 3fluAyw6tFdLZ6/brhzPdJ++YJfTAdv7CJe9aBVYbATCiV7Zp8RCB3jKXa9RhoNjXHK4w2vntPQ
 kLod1rUnxwjzOwtEv4Cg+qYMGTkjPHmELTLuNAAXWDJ+w9AZI/nrspO64zM4orYanMmF3lzeCvN
 azY9Hh1suLCJf4zxk2Cr9TV4YE6Fg1RDailqSTRvzEvZrUeoCgSyALc1wUsWhhIf5zNoRp1gTbP
 I8/+XJnd3OnjHsmMeUfCb5hQqlgkQ6yXsprychHhQWD+F+ko569kO3kYh8ENPqsxBJ96awdO9HX
 g8eERy3t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduces flags and register definitions needed
for the IBM PPE42 exception model.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
---

Changes from v2:
  - Split exception flags and registers from v2 patch 1

 target/ppc/cpu.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 81a0e16641..c68dd4f141 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -220,6 +220,8 @@ typedef enum powerpc_excp_t {
     POWERPC_EXCP_POWER10,
     /* POWER11 exception model           */
     POWERPC_EXCP_POWER11,
+    /* PPE42 exception model            */
+    POWERPC_EXCP_PPE42,
 } powerpc_excp_t;
 
 /*****************************************************************************/
@@ -760,6 +762,31 @@ FIELD(MSR, SIBRCA, MSR_SIBRCA7, 8)
 #define ESR_VLEMI PPC_BIT(58) /* VLE operation                          */
 #define ESR_MIF   PPC_BIT(62) /* Misaligned instruction (VLE)           */
 
+/* PPE42 Interrupt Status Register bits */
+#define PPE42_ISR_SRSMS0  PPC_BIT_NR(48) /* Sys Reset State Machine State 0   */
+#define PPE42_ISR_SRSMS1  PPC_BIT_NR(49) /* Sys Reset State Machine State 1   */
+#define PPE42_ISR_SRSMS2  PPC_BIT_NR(50) /* Sys Reset State Machine State 2   */
+#define PPE42_ISR_SRSMS3  PPC_BIT_NR(51) /* Sys Reset State Machine State 3   */
+#define PPE42_ISR_EP      PPC_BIT_NR(53) /* MSR[EE] Maskable Event Pending    */
+#define PPE42_ISR_PTR     PPC_BIT_NR(56) /* Program Interrupt from trap       */
+#define PPE42_ISR_ST      PPC_BIT_NR(57) /* Data Interrupt caused by store    */
+#define PPE42_ISR_MFE     PPC_BIT_NR(60) /* Multiple Fault Error              */
+#define PPE42_ISR_MCS0    PPC_BIT_NR(61) /* Machine Check Status bit0         */
+#define PPE42_ISR_MCS1    PPC_BIT_NR(62) /* Machine Check Status bit1         */
+#define PPE42_ISR_MCS2    PPC_BIT_NR(63) /* Machine Check Status bit2         */
+FIELD(PPE42_ISR, SRSMS, PPE42_ISR_SRSMS3, 4)
+FIELD(PPE42_ISR, MCS, PPE42_ISR_MCS2, 3)
+
+/* PPE42 Machine Check Status field values */
+#define PPE42_ISR_MCS_INSTRUCTION             0
+#define PPE42_ISR_MCS_DATA_LOAD               1
+#define PPE42_ISR_MCS_DATA_PRECISE_STORE      2
+#define PPE42_ISR_MCS_DATA_IMPRECISE_STORE    3
+#define PPE42_ISR_MCS_PROGRAM                 4
+#define PPE42_ISR_MCS_ISI                     5
+#define PPE42_ISR_MCS_ALIGNMENT               6
+#define PPE42_ISR_MCS_DSI                     7
+
 /* Transaction EXception And Summary Register bits                           */
 #define TEXASR_FAILURE_PERSISTENT                (63 - 7)
 #define TEXASR_DISALLOWED                        (63 - 8)
-- 
2.43.0


