Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5BA97244D
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Sep 2024 23:12:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snlfH-0001G3-Ro; Mon, 09 Sep 2024 17:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1snlf7-0000ce-NI; Mon, 09 Sep 2024 17:11:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1snlf5-00026K-Fx; Mon, 09 Sep 2024 17:11:05 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489BTufv011286;
 Mon, 9 Sep 2024 21:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=UHIsp9gNf34LA
 fE60dEuuU3/w9suPoUU6fP7oYs2BZs=; b=rTkDNGF4oFejvHX/+kDhg6jfx7Yhn
 YLVYxCgHctGyc2hrHUPENBYVriBSMCIb+V1VBArjFb4E5C6wG1Y/kallClePr/1G
 LmooPmSVbrx7XhQPVwD+Di3dGnPTbI4YjNA81vlGvGE0vvJG/OK5ALKYjwF8iiQh
 9rVaUXbXF1pW2Y4Xn6b3cpS4o6nnMUdpQoO5gQSxHI2EJQphro+VwFZw4ytemS7u
 Kr+E4o3pT9aifZAg4aHHD8K4U0aCjETtZhai85fnVkDMbssvz6eMGoKi0tWPz1sf
 tjZvyXDRS2HePCEQIS8b+Q7sDy4BNx5bpljqkB9id1se1ycwCgv2aTSXw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gd8kc36f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 21:11:00 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 489LB04U000777;
 Mon, 9 Sep 2024 21:11:00 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gd8kc36c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 21:11:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 489IKZo9032504;
 Mon, 9 Sep 2024 21:10:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h1j0gdpy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 21:10:59 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 489LAtKW50069970
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Sep 2024 21:10:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF83220049;
 Mon,  9 Sep 2024 21:10:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 836A620040;
 Mon,  9 Sep 2024 21:10:54 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Sep 2024 21:10:54 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v2 06/14] ppc/xive2: Dump the VP-group and crowd tables with
 'info pic'
Date: Mon,  9 Sep 2024 16:10:30 -0500
Message-Id: <20240909211038.27440-7-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240909211038.27440-1-kowal@linux.ibm.com>
References: <20240909211038.27440-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uH8sbDTaKwUpPUcToJmyyLSW7ZODljLe
X-Proofpoint-ORIG-GUID: YTWnsxlXzMGzTl_2JKW4qU5arsw0AsMw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_10,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=640 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090166
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

The 'info pic' HMP command dumps the state of the interrupt controller.
Add the dump of the NVG and NVC tables to its output to ease debug.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 include/hw/ppc/xive2.h      | 12 ++++++++
 include/hw/ppc/xive2_regs.h |  6 ++++
 hw/intc/pnv_xive2.c         | 44 +++++++++++++++++++++++++++--
 hw/intc/xive2.c             | 55 +++++++++++++++++++++++++++++++++++++
 4 files changed, 114 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index 654f485e9b..b7a7c33ddd 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -53,6 +53,12 @@ typedef struct Xive2RouterClass {
                    Xive2Nvp *nvp);
     int (*write_nvp)(Xive2Router *xrtr, uint8_t nvp_blk, uint32_t nvp_idx,
                      Xive2Nvp *nvp, uint8_t word_number);
+    int (*get_nvgc)(Xive2Router *xrtr, bool crowd,
+                    uint8_t nvgc_blk, uint32_t nvgc_idx,
+                    Xive2Nvgc *nvgc);
+    int (*write_nvgc)(Xive2Router *xrtr, bool crowd,
+                      uint8_t nvgc_blk, uint32_t nvgc_idx,
+                      Xive2Nvgc *nvgc);
     uint8_t (*get_block_id)(Xive2Router *xrtr);
     uint32_t (*get_config)(Xive2Router *xrtr);
 } Xive2RouterClass;
@@ -67,6 +73,12 @@ int xive2_router_get_nvp(Xive2Router *xrtr, uint8_t nvp_blk, uint32_t nvp_idx,
                         Xive2Nvp *nvp);
 int xive2_router_write_nvp(Xive2Router *xrtr, uint8_t nvp_blk, uint32_t nvp_idx,
                           Xive2Nvp *nvp, uint8_t word_number);
+int xive2_router_get_nvgc(Xive2Router *xrtr, bool crowd,
+                          uint8_t nvgc_blk, uint32_t nvgc_idx,
+                          Xive2Nvgc *nvgc);
+int xive2_router_write_nvgc(Xive2Router *xrtr, bool crowd,
+                            uint8_t nvgc_blk, uint32_t nvgc_idx,
+                            Xive2Nvgc *nvgc);
 uint32_t xive2_router_get_config(Xive2Router *xrtr);
 
 void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked);
diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index d71a54f9ff..99840e88a8 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -212,6 +212,7 @@ void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx, GString *buf);
 typedef struct Xive2Nvgc {
         uint32_t        w0;
 #define NVGC2_W0_VALID             PPC_BIT32(0)
+#define NVGC2_W0_PGONEXT           PPC_BITMASK32(26, 31)
         uint32_t        w1;
         uint32_t        w2;
         uint32_t        w3;
@@ -221,4 +222,9 @@ typedef struct Xive2Nvgc {
         uint32_t        w7;
 } Xive2Nvgc;
 
+#define xive2_nvgc_is_valid(nvgc)    (be32_to_cpu((nvgc)->w0) & NVGC2_W0_VALID)
+
+void xive2_nvgc_pic_print_info(Xive2Nvgc *nvgc, uint32_t nvgc_idx,
+                               GString *buf);
+
 #endif /* PPC_XIVE2_REGS_H */
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 78609105a8..834d32287b 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -490,6 +490,23 @@ static int pnv_xive2_write_nvp(Xive2Router *xrtr, uint8_t blk, uint32_t idx,
                               word_number);
 }
 
+static int pnv_xive2_get_nvgc(Xive2Router *xrtr, bool crowd,
+                              uint8_t blk, uint32_t idx,
+                              Xive2Nvgc *nvgc)
+{
+    return pnv_xive2_vst_read(PNV_XIVE2(xrtr), crowd ? VST_NVC : VST_NVG,
+                              blk, idx, nvgc);
+}
+
+static int pnv_xive2_write_nvgc(Xive2Router *xrtr, bool crowd,
+                                uint8_t blk, uint32_t idx,
+                                Xive2Nvgc *nvgc)
+{
+    return pnv_xive2_vst_write(PNV_XIVE2(xrtr), crowd ? VST_NVC : VST_NVG,
+                               blk, idx, nvgc,
+                               XIVE_VST_WORD_ALL);
+}
+
 static int pnv_xive2_nxc_to_table_type(uint8_t nxc_type, uint32_t *table_type)
 {
     switch (nxc_type) {
@@ -2407,6 +2424,8 @@ static void pnv_xive2_class_init(ObjectClass *klass, void *data)
     xrc->write_end = pnv_xive2_write_end;
     xrc->get_nvp   = pnv_xive2_get_nvp;
     xrc->write_nvp = pnv_xive2_write_nvp;
+    xrc->get_nvgc   = pnv_xive2_get_nvgc;
+    xrc->write_nvgc = pnv_xive2_write_nvgc;
     xrc->get_config  = pnv_xive2_get_config;
     xrc->get_block_id = pnv_xive2_get_block_id;
 
@@ -2497,8 +2516,9 @@ void pnv_xive2_pic_print_info(PnvXive2 *xive, GString *buf)
     Xive2Eas eas;
     Xive2End end;
     Xive2Nvp nvp;
+    Xive2Nvgc nvgc;
     int i;
-    uint64_t xive_nvp_per_subpage;
+    uint64_t entries_per_subpage;
 
     g_string_append_printf(buf, "XIVE[%x] Source %08x .. %08x\n",
                            blk, srcno0, srcno0 + nr_esbs - 1);
@@ -2530,10 +2550,28 @@ void pnv_xive2_pic_print_info(PnvXive2 *xive, GString *buf)
 
     g_string_append_printf(buf, "XIVE[%x] #%d NVPT %08x .. %08x\n",
                            chip_id, blk, 0, XIVE2_NVP_COUNT - 1);
-    xive_nvp_per_subpage = pnv_xive2_vst_per_subpage(xive, VST_NVP);
-    for (i = 0; i < XIVE2_NVP_COUNT; i += xive_nvp_per_subpage) {
+    entries_per_subpage = pnv_xive2_vst_per_subpage(xive, VST_NVP);
+    for (i = 0; i < XIVE2_NVP_COUNT; i += entries_per_subpage) {
         while (!xive2_router_get_nvp(xrtr, blk, i, &nvp)) {
             xive2_nvp_pic_print_info(&nvp, i++, buf);
         }
     }
+
+    g_string_append_printf(buf, "XIVE[%x] #%d NVGT %08x .. %08x\n",
+                           chip_id, blk, 0, XIVE2_NVP_COUNT - 1);
+    entries_per_subpage = pnv_xive2_vst_per_subpage(xive, VST_NVG);
+    for (i = 0; i < XIVE2_NVP_COUNT; i += entries_per_subpage) {
+        while (!xive2_router_get_nvgc(xrtr, false, blk, i, &nvgc)) {
+            xive2_nvgc_pic_print_info(&nvgc, i++, buf);
+        }
+    }
+
+    g_string_append_printf(buf, "XIVE[%x] #%d NVCT %08x .. %08x\n",
+                          chip_id, blk, 0, XIVE2_NVP_COUNT - 1);
+    entries_per_subpage = pnv_xive2_vst_per_subpage(xive, VST_NVC);
+    for (i = 0; i < XIVE2_NVP_COUNT; i += entries_per_subpage) {
+        while (!xive2_router_get_nvgc(xrtr, true, blk, i, &nvgc)) {
+            xive2_nvgc_pic_print_info(&nvgc, i++, buf);
+        }
+    }
 }
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index ac581fa195..26b6e72129 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -43,6 +43,26 @@ static uint64_t xive2_nvp_reporting_addr(Xive2Nvp *nvp)
     return cache_addr;
 }
 
+static uint32_t xive2_nvgc_get_backlog(Xive2Nvgc *nvgc, uint8_t priority)
+{
+    uint32_t val = 0;
+    uint8_t *ptr, i;
+
+    if (priority > 7) {
+        return 0;
+    }
+
+    /*
+     * The per-priority backlog counters are 24-bit and the structure
+     * is stored in big endian
+     */
+    ptr = (uint8_t *)&nvgc->w2 + priority * 3;
+    for (i = 0; i < 3; i++, ptr++) {
+        val = (val << 8) + *ptr;
+    }
+    return val;
+}
+
 void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf)
 {
     if (!xive2_eas_is_valid(eas)) {
@@ -189,6 +209,23 @@ void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx, GString *buf)
     g_string_append_c(buf, '\n');
 }
 
+void xive2_nvgc_pic_print_info(Xive2Nvgc *nvgc, uint32_t nvgc_idx, GString *buf)
+{
+    uint8_t i;
+
+    if (!xive2_nvgc_is_valid(nvgc)) {
+        return;
+    }
+
+    g_string_append_printf(buf, "  %08x PGoNext:%02x bklog: ", nvgc_idx,
+                           xive_get_field32(NVGC2_W0_PGONEXT, nvgc->w0));
+    for (i = 0; i <= XIVE_PRIORITY_MAX; i++) {
+        g_string_append_printf(buf, "[%d]=0x%x ",
+                               i, xive2_nvgc_get_backlog(nvgc, i));
+    }
+    g_string_append_printf(buf, "\n");
+}
+
 static void xive2_end_enqueue(Xive2End *end, uint32_t data)
 {
     uint64_t qaddr_base = xive2_end_qaddr(end);
@@ -610,6 +647,24 @@ int xive2_router_write_nvp(Xive2Router *xrtr, uint8_t nvp_blk, uint32_t nvp_idx,
    return xrc->write_nvp(xrtr, nvp_blk, nvp_idx, nvp, word_number);
 }
 
+int xive2_router_get_nvgc(Xive2Router *xrtr, bool crowd,
+                          uint8_t nvgc_blk, uint32_t nvgc_idx,
+                          Xive2Nvgc *nvgc)
+{
+   Xive2RouterClass *xrc = XIVE2_ROUTER_GET_CLASS(xrtr);
+
+   return xrc->get_nvgc(xrtr, crowd, nvgc_blk, nvgc_idx, nvgc);
+}
+
+int xive2_router_write_nvgc(Xive2Router *xrtr, bool crowd,
+                            uint8_t nvgc_blk, uint32_t nvgc_idx,
+                            Xive2Nvgc *nvgc)
+{
+   Xive2RouterClass *xrc = XIVE2_ROUTER_GET_CLASS(xrtr);
+
+   return xrc->write_nvgc(xrtr, crowd, nvgc_blk, nvgc_idx, nvgc);
+}
+
 /*
  * The thread context register words are in big-endian format.
  */
-- 
2.43.0


