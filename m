Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F8397730E
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Sep 2024 22:54:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soqmH-0002r1-Va; Thu, 12 Sep 2024 16:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1soqmD-0002b6-7d; Thu, 12 Sep 2024 16:50:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1soqmB-00079U-5K; Thu, 12 Sep 2024 16:50:52 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CCIG0h016037;
 Thu, 12 Sep 2024 20:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 mHsNQeXs4PpWGsaGov1yM8HWLUtZAb/pHCepRuxKe/w=; b=U7KAy/qAWBcAhN58
 adDulneuVAu3x3nxyKD1pUr7QiUpT8XSGsuR9Mu3P1Jik50ath0Da/Kls979RHft
 6XD8t8pwFfYgryv3eGZLOxCfCLLDpJWNwCD35DI9YNTBCU67w4UIsBXqq8on5ybi
 o+VP2sI6kGJoydcBRSRPMlCtL1k19XlSMgyH3mf6HzwuXUwGOzmINa6TaUoZL9Ep
 lWUeMyoFDp8BaM/9d0flxOtERTtAGDEbet1QlwVxGg6k9A/tOXIPwKKnbN6NqQae
 +aw/r4UqHDXrL4yvfxRSKQAX4yQuASnaM/XdCKvZMyZ2bgiL0RBFyKRCV1moK3k6
 uo4nPw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8qpab2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:50:42 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48CKjjpN022500;
 Thu, 12 Sep 2024 20:50:41 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8qpaax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:50:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48CI8Fxa032099;
 Thu, 12 Sep 2024 20:50:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h2nn277w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:50:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48CKob3E34406814
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Sep 2024 20:50:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4031820049;
 Thu, 12 Sep 2024 20:50:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FAF820040;
 Thu, 12 Sep 2024 20:50:36 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Sep 2024 20:50:35 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v3 01/14] pnv/xive: TIMA patch sets pre-req alignment and
 formatting changes
Date: Thu, 12 Sep 2024 15:50:15 -0500
Message-Id: <20240912205028.15854-2-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240912205028.15854-1-kowal@linux.ibm.com>
References: <20240912205028.15854-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QAxPqBO78LrkdhUG8zx7J2yzWN8hJGfv
X-Proofpoint-ORIG-GUID: gOcjgsaqKaWQaytsnpyw3pixn2Pd3THY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_07,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 mlxlogscore=722 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120149
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Michael Kowal <kowal@linux.vnet.ibm.com>

Making some pre-requisite alignment changes ahead of the following patch
sets.  Making these changes now will ease the review of the patch sets.

Checkpatch wants the closing comment '*/' on a separate line, unless it is
on the same line as the starting comment '/*'.

There are also changes to prevent lines from spanning 80 columns.

Changed block of defines from:
   #define A 1  /* original define comment is not
                 * preferred, but not flagged... */
   #define B 2  /* Newly added define comment
                 * is flagged with a warning */
To:
   #define A 1  /* original define comment is */
                /* now fine, no warning...    */
   #define B 2  /* Newly added define comment */
                /* is fine...                 */

Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/ppc/xive_regs.h | 32 ++++++++---------
 hw/intc/xive.c             | 72 +++++++++++++++++++++++++-------------
 2 files changed, 64 insertions(+), 40 deletions(-)

diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index b9db7abc2e..9d52d464d9 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -114,23 +114,23 @@
  * Then we have all these "special" CI ops at these offset that trigger
  * all sorts of side effects:
  */
-#define TM_SPC_ACK_EBB          0x800   /* Load8 ack EBB to reg*/
-#define TM_SPC_ACK_OS_REG       0x810   /* Load16 ack OS irq to reg */
+#define TM_SPC_ACK_EBB          0x800   /* Load8 ack EBB to reg               */
+#define TM_SPC_ACK_OS_REG       0x810   /* Load16 ack OS irq to reg           */
 #define TM_SPC_PUSH_USR_CTX     0x808   /* Store32 Push/Validate user context */
-#define TM_SPC_PULL_USR_CTX     0x808   /* Load32 Pull/Invalidate user
-                                         * context */
-#define TM_SPC_SET_OS_PENDING   0x812   /* Store8 Set OS irq pending bit */
-#define TM_SPC_PULL_OS_CTX      0x818   /* Load32/Load64 Pull/Invalidate OS
-                                         * context to reg */
-#define TM_SPC_PULL_POOL_CTX    0x828   /* Load32/Load64 Pull/Invalidate Pool
-                                         * context to reg*/
-#define TM_SPC_ACK_HV_REG       0x830   /* Load16 ack HV irq to reg */
-#define TM_SPC_PULL_USR_CTX_OL  0xc08   /* Store8 Pull/Inval usr ctx to odd
-                                         * line */
-#define TM_SPC_ACK_OS_EL        0xc10   /* Store8 ack OS irq to even line */
-#define TM_SPC_ACK_HV_POOL_EL   0xc20   /* Store8 ack HV evt pool to even
-                                         * line */
-#define TM_SPC_ACK_HV_EL        0xc30   /* Store8 ack HV irq to even line */
+#define TM_SPC_PULL_USR_CTX     0x808   /* Load32 Pull/Invalidate user        */
+                                        /* context                            */
+#define TM_SPC_SET_OS_PENDING   0x812   /* Store8 Set OS irq pending bit      */
+#define TM_SPC_PULL_OS_CTX      0x818   /* Load32/Load64 Pull/Invalidate OS   */
+                                        /* context to reg                     */
+#define TM_SPC_PULL_POOL_CTX    0x828   /* Load32/Load64 Pull/Invalidate Pool */
+                                        /* context to reg                     */
+#define TM_SPC_ACK_HV_REG       0x830   /* Load16 ack HV irq to reg           */
+#define TM_SPC_PULL_USR_CTX_OL  0xc08   /* Store8 Pull/Inval usr ctx to odd   */
+                                        /* line                               */
+#define TM_SPC_ACK_OS_EL        0xc10   /* Store8 ack OS irq to even line     */
+#define TM_SPC_ACK_HV_POOL_EL   0xc20   /* Store8 ack HV evt pool to even     */
+                                        /* line                               */
+#define TM_SPC_ACK_HV_EL        0xc30   /* Store8 ack HV irq to even line     */
 /* XXX more... */
 
 /* NSR fields for the various QW ack types */
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 5a02dd8e02..2fb38e2102 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -488,20 +488,32 @@ static const XiveTmOp xive_tm_operations[] = {
      * MMIOs below 2K : raw values and special operations without side
      * effects
      */
-    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,   1, xive_tm_set_os_cppr, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,     4, xive_tm_push_os_ctx, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR, 1, xive_tm_set_hv_cppr, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL, xive_tm_vt_poll },
+    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, xive_tm_set_os_cppr,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive_tm_push_os_ctx,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive_tm_set_hv_cppr,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL,
+                                                     xive_tm_vt_poll },
 
     /* MMIOs above 2K : special operations with side effects */
-    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,     2, NULL, xive_tm_ack_os_reg },
-    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING, 1, xive_tm_set_os_pending, NULL },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,    4, NULL, xive_tm_pull_os_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,    8, NULL, xive_tm_pull_os_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,     2, NULL, xive_tm_ack_hv_reg },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,  4, NULL, xive_tm_pull_pool_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,  8, NULL, xive_tm_pull_pool_ctx },
+    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, NULL,
+                                                     xive_tm_ack_os_reg },
+    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, xive_tm_set_os_pending,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, NULL,
+                                                     xive_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        8, NULL,
+                                                     xive_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, NULL,
+                                                     xive_tm_ack_hv_reg },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, NULL,
+                                                     xive_tm_pull_pool_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
+                                                     xive_tm_pull_pool_ctx },
 };
 
 static const XiveTmOp xive2_tm_operations[] = {
@@ -509,20 +521,32 @@ static const XiveTmOp xive2_tm_operations[] = {
      * MMIOs below 2K : raw values and special operations without side
      * effects
      */
-    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,   1, xive_tm_set_os_cppr, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,  4, xive2_tm_push_os_ctx, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR, 1, xive_tm_set_hv_cppr, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL, xive_tm_vt_poll },
+    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, xive_tm_set_os_cppr,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive2_tm_push_os_ctx,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive_tm_set_hv_cppr,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL,
+                                                     xive_tm_vt_poll },
 
     /* MMIOs above 2K : special operations with side effects */
-    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,     2, NULL, xive_tm_ack_os_reg },
-    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING, 1, xive_tm_set_os_pending, NULL },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,    4, NULL, xive2_tm_pull_os_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,    8, NULL, xive2_tm_pull_os_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,     2, NULL, xive_tm_ack_hv_reg },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,  4, NULL, xive_tm_pull_pool_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,  8, NULL, xive_tm_pull_pool_ctx },
+    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, NULL,
+                                                     xive_tm_ack_os_reg },
+    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, xive_tm_set_os_pending,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, NULL,
+                                                     xive2_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        8, NULL,
+                                                     xive2_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, NULL,
+                                                     xive_tm_ack_hv_reg },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, NULL,
+                                                     xive_tm_pull_pool_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
+                                                     xive_tm_pull_pool_ctx },
 };
 
 static const XiveTmOp *xive_tm_find_op(XivePresenter *xptr, hwaddr offset,
-- 
2.43.0


