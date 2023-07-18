Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EEB7577CC
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 11:24:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLgur-00067d-Qw; Tue, 18 Jul 2023 05:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qLgup-00065W-2f; Tue, 18 Jul 2023 05:22:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qLgum-0000qI-KX; Tue, 18 Jul 2023 05:22:42 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36I9CQ8h020079; Tue, 18 Jul 2023 09:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=97q8oiwd+UAEa7pEJ3zJGU1oduZxMyoRjL/uay3ukDk=;
 b=YD+f9/f5pHpqywC37zYCn/FVOxfyDroKSPTP2/KRJROCI8AAkNRKwxVxIQqVFM5JxVKX
 5dN5pNuxEXtF2RX/+6/lGpOp/3RhdLggltSXZ9De6qpdNawnSSz2W63kPmKLmokj2GAU
 NLn6tHw3fGKigFNFDuWBfx/HAhzu2nqV0loZxSQU2tynTIJMFU+0u6FQaHowis/83mCO
 Abcm+IYhJ2c2pxx/6XS2WfizqhnLpYpUalvZp/rW0mX1QWjtEihgkB3HXcIfu5GlgGda
 PxQWpWgPebuG8CktQCUEIy8JIaP68JLlTz2HqcGfh1D11OZUKgrde/kRItDZSD1fgEsm eg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwqw488jp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:34 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36I9Dxeo025365;
 Tue, 18 Jul 2023 09:22:33 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwqw488jb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:33 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36I6o9Uc004962; Tue, 18 Jul 2023 09:22:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv65xcnfr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:32 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36I9MT3R41550390
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jul 2023 09:22:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 285532004B;
 Tue, 18 Jul 2023 09:22:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1155320040;
 Tue, 18 Jul 2023 09:22:27 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Jul 2023 09:22:26 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: mikey@neuling.org, vaibhav@linux.ibm.com, jniethe5@gmail.com,
 sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com,
 dbarboza@ventanamicro.com, npiggin@gmail.com
Subject: [PATCH 01/15] ppc: spapr: Introduce Nested PAPR API related macros
Date: Tue, 18 Jul 2023 14:52:07 +0530
Message-Id: <20230718092221.1053686-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230718092221.1053686-1-harshpb@linux.ibm.com>
References: <20230718092221.1053686-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K-6eR2qkSIF5sD6OUIzuKSrAe2__koBm
X-Proofpoint-ORIG-GUID: 3OdJ-GLt5csmDI0Yv0-dpDHXdAE_HVNH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 impostorscore=0
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

Adding new macros for the new hypercall op-codes, their return codes,
Guest State Buffer (GSB) element IDs and few registers which shall be
used in following patches to support Nested PAPR API.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h        |  23 ++++-
 include/hw/ppc/spapr_nested.h | 186 ++++++++++++++++++++++++++++++++++
 target/ppc/cpu.h              |   2 +
 3 files changed, 209 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 538b2dfb89..3990fed1d9 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -367,6 +367,16 @@ struct SpaprMachineState {
 #define H_NOOP            -63
 #define H_UNSUPPORTED     -67
 #define H_OVERLAP         -68
+#define H_STATE           -75
+#define H_INVALID_ELEMENT_ID               -79
+#define H_INVALID_ELEMENT_SIZE             -80
+#define H_INVALID_ELEMENT_VALUE            -81
+#define H_INPUT_BUFFER_NOT_DEFINED         -82
+#define H_INPUT_BUFFER_TOO_SMALL           -83
+#define H_OUTPUT_BUFFER_NOT_DEFINED        -84
+#define H_OUTPUT_BUFFER_TOO_SMALL          -85
+#define H_PARTITION_PAGE_TABLE_NOT_DEFINED -86
+#define H_GUEST_VCPU_STATE_NOT_HV_OWNED    -87
 #define H_UNSUPPORTED_FLAG -256
 #define H_MULTI_THREADS_ACTIVE -9005
 
@@ -586,8 +596,17 @@ struct SpaprMachineState {
 #define H_RPT_INVALIDATE        0x448
 #define H_SCM_FLUSH             0x44C
 #define H_WATCHDOG              0x45C
-
-#define MAX_HCALL_OPCODE        H_WATCHDOG
+#define H_GUEST_GET_CAPABILITIES 0x460
+#define H_GUEST_SET_CAPABILITIES 0x464
+#define H_GUEST_CREATE           0x470
+#define H_GUEST_CREATE_VCPU      0x474
+#define H_GUEST_GET_STATE        0x478
+#define H_GUEST_SET_STATE        0x47C
+#define H_GUEST_RUN_VCPU         0x480
+#define H_GUEST_COPY_MEMORY      0x484
+#define H_GUEST_DELETE           0x488
+
+#define MAX_HCALL_OPCODE        H_GUEST_DELETE
 
 /* The hcalls above are standardized in PAPR and implemented by pHyp
  * as well.
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index d383486476..5cb668dd53 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -4,6 +4,192 @@
 #include "qemu/osdep.h"
 #include "target/ppc/cpu.h"
 
+/* Guest State Buffer Element IDs */
+#define GSB_HV_VCPU_IGNORED_ID  0x0000 /* An element whose value is ignored */
+#define GSB_HV_VCPU_STATE_SIZE  0x0001 /* HV internal format VCPU state size */
+#define GSB_VCPU_OUT_BUF_MIN_SZ 0x0002 /* Min size of the Run VCPU o/p buffer */
+#define GSB_VCPU_LPVR           0x0003 /* Logical PVR */
+#define GSB_TB_OFFSET           0x0004 /* Timebase Offset */
+#define GSB_PART_SCOPED_PAGETBL 0x0005 /* Partition Scoped Page Table */
+#define GSB_PROCESS_TBL         0x0006 /* Process Table */
+                    /* RESERVED 0x0007 - 0x0BFF */
+#define GSB_VCPU_IN_BUFFER      0x0C00 /* Run VCPU Input Buffer */
+#define GSB_VCPU_OUT_BUFFER     0x0C01 /* Run VCPU Out Buffer */
+#define GSB_VCPU_VPA            0x0C02 /* HRA to Guest VCPU VPA */
+                    /* RESERVED 0x0C03 - 0x0FFF */
+#define GSB_VCPU_GPR0           0x1000
+#define GSB_VCPU_GPR1           0x1001
+#define GSB_VCPU_GPR2           0x1002
+#define GSB_VCPU_GPR3           0x1003
+#define GSB_VCPU_GPR4           0x1004
+#define GSB_VCPU_GPR5           0x1005
+#define GSB_VCPU_GPR6           0x1006
+#define GSB_VCPU_GPR7           0x1007
+#define GSB_VCPU_GPR8           0x1008
+#define GSB_VCPU_GPR9           0x1009
+#define GSB_VCPU_GPR10          0x100A
+#define GSB_VCPU_GPR11          0x100B
+#define GSB_VCPU_GPR12          0x100C
+#define GSB_VCPU_GPR13          0x100D
+#define GSB_VCPU_GPR14          0x100E
+#define GSB_VCPU_GPR15          0x100F
+#define GSB_VCPU_GPR16          0x1010
+#define GSB_VCPU_GPR17          0x1011
+#define GSB_VCPU_GPR18          0x1012
+#define GSB_VCPU_GPR19          0x1013
+#define GSB_VCPU_GPR20          0x1014
+#define GSB_VCPU_GPR21          0x1015
+#define GSB_VCPU_GPR22          0x1016
+#define GSB_VCPU_GPR23          0x1017
+#define GSB_VCPU_GPR24          0x1018
+#define GSB_VCPU_GPR25          0x1019
+#define GSB_VCPU_GPR26          0x101A
+#define GSB_VCPU_GPR27          0x101B
+#define GSB_VCPU_GPR28          0x101C
+#define GSB_VCPU_GPR29          0x101D
+#define GSB_VCPU_GPR30          0x101E
+#define GSB_VCPU_GPR31          0x101F
+#define GSB_VCPU_HDEC_EXPIRY_TB 0x1020
+#define GSB_VCPU_SPR_NIA        0x1021
+#define GSB_VCPU_SPR_MSR        0x1022
+#define GSB_VCPU_SPR_LR         0x1023
+#define GSB_VCPU_SPR_XER        0x1024
+#define GSB_VCPU_SPR_CTR        0x1025
+#define GSB_VCPU_SPR_CFAR       0x1026
+#define GSB_VCPU_SPR_SRR0       0x1027
+#define GSB_VCPU_SPR_SRR1       0x1028
+#define GSB_VCPU_SPR_DAR        0x1029
+#define GSB_VCPU_DEC_EXPIRE_TB  0x102A
+#define GSB_VCPU_SPR_VTB        0x102B
+#define GSB_VCPU_SPR_LPCR       0x102C
+#define GSB_VCPU_SPR_HFSCR      0x102D
+#define GSB_VCPU_SPR_FSCR       0x102E
+#define GSB_VCPU_SPR_FPSCR      0x102F
+#define GSB_VCPU_SPR_DAWR0      0x1030
+#define GSB_VCPU_SPR_DAWR1      0x1031
+#define GSB_VCPU_SPR_CIABR      0x1032
+#define GSB_VCPU_SPR_PURR       0x1033
+#define GSB_VCPU_SPR_SPURR      0x1034
+#define GSB_VCPU_SPR_IC         0x1035
+#define GSB_VCPU_SPR_SPRG0      0x1036
+#define GSB_VCPU_SPR_SPRG1      0x1037
+#define GSB_VCPU_SPR_SPRG2      0x1038
+#define GSB_VCPU_SPR_SPRG3      0x1039
+#define GSB_VCPU_SPR_PPR        0x103A
+#define GSB_VCPU_SPR_MMCR0      0x103B
+#define GSB_VCPU_SPR_MMCR1      0x103C
+#define GSB_VCPU_SPR_MMCR2      0x103D
+#define GSB_VCPU_SPR_MMCR3      0x103E
+#define GSB_VCPU_SPR_MMCRA      0x103F
+#define GSB_VCPU_SPR_SIER       0x1040
+#define GSB_VCPU_SPR_SIER2      0x1041
+#define GSB_VCPU_SPR_SIER3      0x1042
+#define GSB_VCPU_SPR_BESCR      0x1043
+#define GSB_VCPU_SPR_EBBHR      0x1044
+#define GSB_VCPU_SPR_EBBRR      0x1045
+#define GSB_VCPU_SPR_AMR        0x1046
+#define GSB_VCPU_SPR_IAMR       0x1047
+#define GSB_VCPU_SPR_AMOR       0x1048
+#define GSB_VCPU_SPR_UAMOR      0x1049
+#define GSB_VCPU_SPR_SDAR       0x104A
+#define GSB_VCPU_SPR_SIAR       0x104B
+#define GSB_VCPU_SPR_DSCR       0x104C
+#define GSB_VCPU_SPR_TAR        0x104D
+#define GSB_VCPU_SPR_DEXCR      0x104E
+#define GSB_VCPU_SPR_HDEXCR     0x104F
+#define GSB_VCPU_SPR_HASHKEYR   0x1050
+#define GSB_VCPU_SPR_HASHPKEYR  0x1051
+#define GSB_VCPU_SPR_CTRL       0x1052
+                    /* RESERVED 0x1053 - 0x1FFF */
+#define GSB_VCPU_SPR_CR         0x2000
+#define GSB_VCPU_SPR_PIDR       0x2001
+#define GSB_VCPU_SPR_DSISR      0x2002
+#define GSB_VCPU_SPR_VSCR       0x2003
+#define GSB_VCPU_SPR_VRSAVE     0x2004
+#define GSB_VCPU_SPR_DAWRX0     0x2005
+#define GSB_VCPU_SPR_DAWRX1     0x2006
+#define GSB_VCPU_SPR_PMC1       0x2007
+#define GSB_VCPU_SPR_PMC2       0x2008
+#define GSB_VCPU_SPR_PMC3       0x2009
+#define GSB_VCPU_SPR_PMC4       0x200A
+#define GSB_VCPU_SPR_PMC5       0x200B
+#define GSB_VCPU_SPR_PMC6       0x200C
+#define GSB_VCPU_SPR_WORT       0x200D
+#define GSB_VCPU_SPR_PSPB       0x200E
+                    /* RESERVED 0x200F - 0x2FFF */
+#define GSB_VCPU_SPR_VSR0       0x3000
+#define GSB_VCPU_SPR_VSR1       0x3001
+#define GSB_VCPU_SPR_VSR2       0x3002
+#define GSB_VCPU_SPR_VSR3       0x3003
+#define GSB_VCPU_SPR_VSR4       0x3004
+#define GSB_VCPU_SPR_VSR5       0x3005
+#define GSB_VCPU_SPR_VSR6       0x3006
+#define GSB_VCPU_SPR_VSR7       0x3007
+#define GSB_VCPU_SPR_VSR8       0x3008
+#define GSB_VCPU_SPR_VSR9       0x3009
+#define GSB_VCPU_SPR_VSR10      0x300A
+#define GSB_VCPU_SPR_VSR11      0x300B
+#define GSB_VCPU_SPR_VSR12      0x300C
+#define GSB_VCPU_SPR_VSR13      0x300D
+#define GSB_VCPU_SPR_VSR14      0x300E
+#define GSB_VCPU_SPR_VSR15      0x300F
+#define GSB_VCPU_SPR_VSR16      0x3010
+#define GSB_VCPU_SPR_VSR17      0x3011
+#define GSB_VCPU_SPR_VSR18      0x3012
+#define GSB_VCPU_SPR_VSR19      0x3013
+#define GSB_VCPU_SPR_VSR20      0x3014
+#define GSB_VCPU_SPR_VSR21      0x3015
+#define GSB_VCPU_SPR_VSR22      0x3016
+#define GSB_VCPU_SPR_VSR23      0x3017
+#define GSB_VCPU_SPR_VSR24      0x3018
+#define GSB_VCPU_SPR_VSR25      0x3019
+#define GSB_VCPU_SPR_VSR26      0x301A
+#define GSB_VCPU_SPR_VSR27      0x301B
+#define GSB_VCPU_SPR_VSR28      0x301C
+#define GSB_VCPU_SPR_VSR29      0x301D
+#define GSB_VCPU_SPR_VSR30      0x301E
+#define GSB_VCPU_SPR_VSR31      0x301F
+#define GSB_VCPU_SPR_VSR32      0x3020
+#define GSB_VCPU_SPR_VSR33      0x3021
+#define GSB_VCPU_SPR_VSR34      0x3022
+#define GSB_VCPU_SPR_VSR35      0x3023
+#define GSB_VCPU_SPR_VSR36      0x3024
+#define GSB_VCPU_SPR_VSR37      0x3025
+#define GSB_VCPU_SPR_VSR38      0x3026
+#define GSB_VCPU_SPR_VSR39      0x3027
+#define GSB_VCPU_SPR_VSR40      0x3028
+#define GSB_VCPU_SPR_VSR41      0x3029
+#define GSB_VCPU_SPR_VSR42      0x302A
+#define GSB_VCPU_SPR_VSR43      0x302B
+#define GSB_VCPU_SPR_VSR44      0x302C
+#define GSB_VCPU_SPR_VSR45      0x302D
+#define GSB_VCPU_SPR_VSR46      0x302E
+#define GSB_VCPU_SPR_VSR47      0x302F
+#define GSB_VCPU_SPR_VSR48      0x3030
+#define GSB_VCPU_SPR_VSR49      0x3031
+#define GSB_VCPU_SPR_VSR50      0x3032
+#define GSB_VCPU_SPR_VSR51      0x3033
+#define GSB_VCPU_SPR_VSR52      0x3034
+#define GSB_VCPU_SPR_VSR53      0x3035
+#define GSB_VCPU_SPR_VSR54      0x3036
+#define GSB_VCPU_SPR_VSR55      0x3037
+#define GSB_VCPU_SPR_VSR56      0x3038
+#define GSB_VCPU_SPR_VSR57      0x3039
+#define GSB_VCPU_SPR_VSR58      0x303A
+#define GSB_VCPU_SPR_VSR59      0x303B
+#define GSB_VCPU_SPR_VSR60      0x303C
+#define GSB_VCPU_SPR_VSR61      0x303D
+#define GSB_VCPU_SPR_VSR62      0x303E
+#define GSB_VCPU_SPR_VSR63      0x303F
+                    /* RESERVED 0x3040 - 0xEFFF */
+#define GSB_VCPU_SPR_HDAR       0xF000
+#define GSB_VCPU_SPR_HDSISR     0xF001
+#define GSB_VCPU_SPR_HEIR       0xF002
+#define GSB_VCPU_SPR_ASDR       0xF003
+/* End of list of Guest State Buffer Element IDs */
+#define GSB_LAST                GSB_VCPU_SPR_ASDR
+
+
 /*
  * Register state for entering a nested guest with H_ENTER_NESTED.
  * New member must be added at the end.
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 25fac9577a..6f7f9b9d58 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1587,9 +1587,11 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_PSPB              (0x09F)
 #define SPR_DPDES             (0x0B0)
 #define SPR_DAWR0             (0x0B4)
+#define SPR_DAWR1             (0x0B5)
 #define SPR_RPR               (0x0BA)
 #define SPR_CIABR             (0x0BB)
 #define SPR_DAWRX0            (0x0BC)
+#define SPR_DAWRX1            (0x0BD)
 #define SPR_HFSCR             (0x0BE)
 #define SPR_VRSAVE            (0x100)
 #define SPR_USPRG0            (0x100)
-- 
2.39.3


