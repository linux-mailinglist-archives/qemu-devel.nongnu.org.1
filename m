Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE0C9EA35C
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Dec 2024 01:09:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKnmp-0005lu-9N; Mon, 09 Dec 2024 19:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlN-0004l6-G7; Mon, 09 Dec 2024 19:06:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlK-0001qc-VG; Mon, 09 Dec 2024 19:06:05 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9KQTRU019995;
 Tue, 10 Dec 2024 00:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=NouAE6G4xGfnG62tY
 r7omCwO/nRFqaLNBISCfamXsdE=; b=rkO5cpOYF4aJuzMmc05SkSnOme2zr1IYD
 NYkfJrfwVTfQj7JoXs+sZnh4hSqey7CIy1yhxQqbXIPUrmjQviUQeGM0r4rRXagz
 RU09deaaWIAqCRwN8RIbrTjqb2uzOrjvIycn2kxZ3e9XYBanZIGBBBHf3Cf3Ofr6
 5JDCV02GJ0xqV1/tNB5lluDfVHc8XuoJ6jpkD8cIbhz6iQOPpzf0Mwsq+29ay4/6
 yDnJne9x7d12Qz9VzEIHP9kCmxWAFbqNvgS8xjSTf/dKp1MlbCZkLwcOGVJG4tdF
 FJx4ofU8dmZ28MCkyHwr1Sp1gl27pRUInAFefyNyZVdUEBeQwT3iw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38m59q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:05:55 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BA05tjH016406;
 Tue, 10 Dec 2024 00:05:55 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38m59f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:05:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9Lw2qp017052;
 Tue, 10 Dec 2024 00:05:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12y16st-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:05:54 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BA05oA635127836
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2024 00:05:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 840EE20043;
 Tue, 10 Dec 2024 00:05:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2CED20040;
 Tue, 10 Dec 2024 00:05:48 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Dec 2024 00:05:48 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v2 04/14] ppc/xive2: Support group-matching when looking for
 target
Date: Mon,  9 Dec 2024 18:05:10 -0600
Message-Id: <20241210000527.9541-8-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210000527.9541-1-kowal@linux.ibm.com>
References: <20241210000527.9541-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6Hc6gU15dz_ZD2Zrnf8gNZ_d3AoRHsTq
X-Proofpoint-ORIG-GUID: 8M-dt15pNFOG53RUsMEtmyfSm38whW8j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090187
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

If an END has the 'i' bit set (ignore), then it targets a group of
VPs. The size of the group depends on the VP index of the target
(first 0 found when looking at the least significant bits of the
index) so a mask is applied on the VP index of a running thread to
know if we have a match.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 include/hw/ppc/xive.h  |  5 +++-
 include/hw/ppc/xive2.h |  7 ++---
 hw/intc/pnv_xive2.c    | 38 +++++++++++++++---------
 hw/intc/xive.c         | 56 +++++++++++++++++++++++++-----------
 hw/intc/xive2.c        | 65 ++++++++++++++++++++++++++++++------------
 5 files changed, 118 insertions(+), 53 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 4d1ce376f1..ce4eb9726b 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -422,6 +422,7 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas);
 typedef struct XiveTCTXMatch {
     XiveTCTX *tctx;
     uint8_t ring;
+    bool precluded;
 } XiveTCTXMatch;
 
 #define TYPE_XIVE_PRESENTER "xive-presenter"
@@ -450,7 +451,9 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
 bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
                            uint8_t nvt_blk, uint32_t nvt_idx,
                            bool cam_ignore, uint8_t priority,
-                           uint32_t logic_serv);
+                           uint32_t logic_serv, bool *precluded);
+
+uint32_t xive_get_vpgroup_size(uint32_t nvp_index);
 
 /*
  * XIVE Fabric (Interface between Interrupt Controller and Machine)
diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index 5bccf41159..65154f78d8 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -1,11 +1,9 @@
 /*
  * QEMU PowerPC XIVE2 interrupt controller model  (POWER10)
  *
- * Copyright (c) 2019-2022, IBM Corporation.
- *
- * This code is licensed under the GPL version 2 or later. See the
- * COPYING file in the top-level directory.
+ * Copyright (c) 2019-2024, IBM Corporation.
  *
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #ifndef PPC_XIVE2_H
@@ -121,6 +119,7 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                hwaddr offset, unsigned size);
 void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
                              hwaddr offset, uint64_t value, unsigned size);
+bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority);
 void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
                             hwaddr offset, uint64_t value, unsigned size);
 void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 834d32287b..5cdd4fdcc9 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1,10 +1,9 @@
 /*
  * QEMU PowerPC XIVE2 interrupt controller model  (POWER10)
  *
- * Copyright (c) 2019-2022, IBM Corporation.
+ * Copyright (c) 2019-2024, IBM Corporation.
  *
- * This code is licensed under the GPL version 2 or later. See the
- * COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
@@ -660,21 +659,34 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
                                                    logic_serv);
             }
 
-            /*
-             * Save the context and follow on to catch duplicates,
-             * that we don't support yet.
-             */
             if (ring != -1) {
-                if (match->tctx) {
+                /*
+                 * For VP-specific match, finding more than one is a
+                 * problem. For group notification, it's possible.
+                 */
+                if (!cam_ignore && match->tctx) {
                     qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a "
                                   "thread context NVT %x/%x\n",
                                   nvt_blk, nvt_idx);
-                    return false;
+                    /* Should set a FIR if we ever model it */
+                    return -1;
+                }
+                /*
+                 * For a group notification, we need to know if the
+                 * match is precluded first by checking the current
+                 * thread priority. If the interrupt can be delivered,
+                 * we always notify the first match (for now).
+                 */
+                if (cam_ignore &&
+                    xive2_tm_irq_precluded(tctx, ring, priority)) {
+                        match->precluded = true;
+                } else {
+                    if (!match->tctx) {
+                        match->ring = ring;
+                        match->tctx = tctx;
+                    }
+                    count++;
                 }
-
-                match->ring = ring;
-                match->tctx = tctx;
-                count++;
             }
         }
     }
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index d2690a7d10..412bb94b91 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1657,6 +1657,16 @@ static uint32_t xive_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
     return xive_nvt_cam_line(blk, 1 << 7 | (pir & 0x7f));
 }
 
+uint32_t xive_get_vpgroup_size(uint32_t nvp_index)
+{
+    /*
+     * Group size is a power of 2. The position of the first 0
+     * (starting with the least significant bits) in the NVP index
+     * gives the size of the group.
+     */
+    return 1 << (ctz32(~nvp_index) + 1);
+}
+
 static uint8_t xive_get_group_level(uint32_t nvp_index)
 {
     /* FIXME add crowd encoding */
@@ -1729,30 +1739,39 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
 /*
  * This is our simple Xive Presenter Engine model. It is merged in the
  * Router as it does not require an extra object.
- *
- * It receives notification requests sent by the IVRE to find one
- * matching NVT (or more) dispatched on the processor threads. In case
- * of a single NVT notification, the process is abbreviated and the
- * thread is signaled if a match is found. In case of a logical server
- * notification (bits ignored at the end of the NVT identifier), the
- * IVPE and IVRE select a winning thread using different filters. This
- * involves 2 or 3 exchanges on the PowerBus that the model does not
- * support.
- *
- * The parameters represent what is sent on the PowerBus
  */
 bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
                            uint8_t nvt_blk, uint32_t nvt_idx,
                            bool cam_ignore, uint8_t priority,
-                           uint32_t logic_serv)
+                           uint32_t logic_serv, bool *precluded)
 {
     XiveFabricClass *xfc = XIVE_FABRIC_GET_CLASS(xfb);
-    XiveTCTXMatch match = { .tctx = NULL, .ring = 0 };
+    XiveTCTXMatch match = { .tctx = NULL, .ring = 0, .precluded = false };
     uint8_t group_level;
     int count;
 
     /*
-     * Ask the machine to scan the interrupt controllers for a match
+     * Ask the machine to scan the interrupt controllers for a match.
+     *
+     * For VP-specific notification, we expect at most one match and
+     * one call to the presenters is all we need (abbreviated notify
+     * sequence documented by the architecture).
+     *
+     * For VP-group notification, match_nvt() is the equivalent of the
+     * "histogram" and "poll" commands sent to the power bus to the
+     * presenters. 'count' could be more than one, but we always
+     * select the first match for now. 'precluded' tells if (at least)
+     * one thread matches but can't take the interrupt now because
+     * it's running at a more favored priority. We return the
+     * information to the router so that it can take appropriate
+     * actions (backlog, escalation, broadcast, etc...)
+     *
+     * If we were to implement a better way of dispatching the
+     * interrupt in case of multiple matches (instead of the first
+     * match), we would need a heuristic to elect a thread (for
+     * example, the hardware keeps track of an 'age' in the TIMA) and
+     * a new command to the presenters (the equivalent of the "assign"
+     * power bus command in the documented full notify sequence.
      */
     count = xfc->match_nvt(xfb, format, nvt_blk, nvt_idx, cam_ignore,
                            priority, logic_serv, &match);
@@ -1765,6 +1784,8 @@ bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
         group_level = cam_ignore ? xive_get_group_level(nvt_idx) : 0;
         trace_xive_presenter_notify(nvt_blk, nvt_idx, match.ring, group_level);
         xive_tctx_pipr_update(match.tctx, match.ring, priority, group_level);
+    } else {
+        *precluded = match.precluded;
     }
 
     return !!count;
@@ -1804,7 +1825,7 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas)
     uint8_t nvt_blk;
     uint32_t nvt_idx;
     XiveNVT nvt;
-    bool found;
+    bool found, precluded;
 
     uint8_t end_blk = xive_get_field64(EAS_END_BLOCK, eas->w);
     uint32_t end_idx = xive_get_field64(EAS_END_INDEX, eas->w);
@@ -1887,8 +1908,9 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas)
     found = xive_presenter_notify(xrtr->xfb, format, nvt_blk, nvt_idx,
                           xive_get_field32(END_W7_F0_IGNORE, end.w7),
                           priority,
-                          xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.w7));
-
+                          xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.w7),
+                          &precluded);
+    /* we don't support VP-group notification on P9, so precluded is not used */
     /* TODO: Auto EOI. */
 
     if (found) {
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 54e4f784fc..cffcf3ff05 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -739,6 +739,12 @@ int xive2_router_write_nvgc(Xive2Router *xrtr, bool crowd,
    return xrc->write_nvgc(xrtr, crowd, nvgc_blk, nvgc_idx, nvgc);
 }
 
+static bool xive2_vp_match_mask(uint32_t cam1, uint32_t cam2,
+                                uint32_t vp_mask)
+{
+    return (cam1 & vp_mask) == (cam2 & vp_mask);
+}
+
 /*
  * The thread context register words are in big-endian format.
  */
@@ -753,44 +759,50 @@ int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
     uint32_t qw1w2 = xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
     uint32_t qw0w2 = xive_tctx_word2(&tctx->regs[TM_QW0_USER]);
 
-    /*
-     * TODO (PowerNV): ignore mode. The low order bits of the NVT
-     * identifier are ignored in the "CAM" match.
-     */
+    uint32_t vp_mask = 0xFFFFFFFF;
 
     if (format == 0) {
-        if (cam_ignore == true) {
-            /*
-             * F=0 & i=1: Logical server notification (bits ignored at
-             * the end of the NVT identifier)
-             */
-            qemu_log_mask(LOG_UNIMP, "XIVE: no support for LS NVT %x/%x\n",
-                          nvt_blk, nvt_idx);
-            return -1;
+        /*
+         * i=0: Specific NVT notification
+         * i=1: VP-group notification (bits ignored at the end of the
+         *      NVT identifier)
+         */
+        if (cam_ignore) {
+            vp_mask = ~(xive_get_vpgroup_size(nvt_idx) - 1);
         }
 
-        /* F=0 & i=0: Specific NVT notification */
+        /* For VP-group notifications, threads with LGS=0 are excluded */
 
         /* PHYS ring */
         if ((be32_to_cpu(qw3w2) & TM2_QW3W2_VT) &&
-            cam == xive2_tctx_hw_cam_line(xptr, tctx)) {
+            !(cam_ignore && tctx->regs[TM_QW3_HV_PHYS + TM_LGS] == 0) &&
+            xive2_vp_match_mask(cam,
+                                xive2_tctx_hw_cam_line(xptr, tctx),
+                                vp_mask)) {
             return TM_QW3_HV_PHYS;
         }
 
         /* HV POOL ring */
         if ((be32_to_cpu(qw2w2) & TM2_QW2W2_VP) &&
-            cam == xive_get_field32(TM2_QW2W2_POOL_CAM, qw2w2)) {
+            !(cam_ignore && tctx->regs[TM_QW2_HV_POOL + TM_LGS] == 0) &&
+            xive2_vp_match_mask(cam,
+                                xive_get_field32(TM2_QW2W2_POOL_CAM, qw2w2),
+                                vp_mask)) {
             return TM_QW2_HV_POOL;
         }
 
         /* OS ring */
         if ((be32_to_cpu(qw1w2) & TM2_QW1W2_VO) &&
-            cam == xive_get_field32(TM2_QW1W2_OS_CAM, qw1w2)) {
+            !(cam_ignore && tctx->regs[TM_QW1_OS + TM_LGS] == 0) &&
+            xive2_vp_match_mask(cam,
+                                xive_get_field32(TM2_QW1W2_OS_CAM, qw1w2),
+                                vp_mask)) {
             return TM_QW1_OS;
         }
     } else {
         /* F=1 : User level Event-Based Branch (EBB) notification */
 
+        /* FIXME: what if cam_ignore and LGS = 0 ? */
         /* USER ring */
         if  ((be32_to_cpu(qw1w2) & TM2_QW1W2_VO) &&
              (cam == xive_get_field32(TM2_QW1W2_OS_CAM, qw1w2)) &&
@@ -802,6 +814,22 @@ int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
     return -1;
 }
 
+bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority)
+{
+    uint8_t *regs = &tctx->regs[ring];
+
+    /*
+     * The xive2_presenter_tctx_match() above tells if there's a match
+     * but for VP-group notification, we still need to look at the
+     * priority to know if the thread can take the interrupt now or if
+     * it is precluded.
+     */
+    if (priority < regs[TM_CPPR]) {
+        return false;
+    }
+    return true;
+}
+
 static void xive2_router_realize(DeviceState *dev, Error **errp)
 {
     Xive2Router *xrtr = XIVE2_ROUTER(dev);
@@ -841,7 +869,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
     Xive2End end;
     uint8_t priority;
     uint8_t format;
-    bool found;
+    bool found, precluded;
     Xive2Nvp nvp;
     uint8_t nvp_blk;
     uint32_t nvp_idx;
@@ -922,7 +950,8 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
     found = xive_presenter_notify(xrtr->xfb, format, nvp_blk, nvp_idx,
                           xive2_end_is_ignore(&end),
                           priority,
-                          xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end.w7));
+                          xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end.w7),
+                          &precluded);
 
     /* TODO: Auto EOI. */
 
-- 
2.43.0


