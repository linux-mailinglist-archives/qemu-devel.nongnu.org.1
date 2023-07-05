Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 602857482A1
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 13:01:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH0Fo-0005Jv-Ey; Wed, 05 Jul 2023 07:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qH0Fl-0005IW-Rq; Wed, 05 Jul 2023 07:00:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qH0Fj-0000WA-UM; Wed, 05 Jul 2023 07:00:57 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 365AmrIq015874; Wed, 5 Jul 2023 11:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=yAE1KZJU+vMCR32DnejA5HEDVo530z0D489GP1IoCu0=;
 b=I7fmLZ/PfestgwHXvLP6xD6KC2zYANef0+m+4mpzMdn038BP2dxzXTbn3qtzwQR7mYxn
 hL/3HD1GdZS1ZwyetAJwhFLTNQnpYjJy+IwHYPqonkrIlSH12C/ZQwnU9EGZYR/SM//h
 TbUQuM66++VgDQNwykZtmI6hM8y/Ouk1GyrShjWr9KCmNIQeIizFj7XfRVglTrT21aok
 pZnw4MlcrEw8RTKFPeH7Sg5LAbioCkLhpr7a/pLN7qI8fFgbwEBkXjGWrTTCB3AFVpbB
 Nh0NhyvHlyfJDvDzMdR8M3auVcIuaUKKXIuBj67G5eXC3FiVFw9N34gUjWunEMLLyhj2 gw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rn73e88gb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 11:00:45 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 365ApYlL023595;
 Wed, 5 Jul 2023 11:00:44 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rn73e88fa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 11:00:44 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3652BQET019448;
 Wed, 5 Jul 2023 11:00:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3rjbddsuus-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 11:00:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 365B0eKS20382346
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Jul 2023 11:00:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87F8320040;
 Wed,  5 Jul 2023 11:00:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B85220043;
 Wed,  5 Jul 2023 11:00:40 +0000 (GMT)
Received: from borneo.ibmuc.com (unknown [9.171.34.89])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Jul 2023 11:00:40 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] pnv/xive: Print CPU target in all TIMA traces
Date: Wed,  5 Jul 2023 13:00:39 +0200
Message-ID: <20230705110039.231148-1-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cT2ifrN-PyvGElHXAB9KYOVHLeSFMqcO
X-Proofpoint-ORIG-GUID: _o3I_MKaDp6EMq-AT2vX6I-4f8bKoW_9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_02,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxlogscore=981
 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050092
Received-SPF: pass client-ip=148.163.158.5; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Add the CPU target in the trace when reading/writing the TIMA
space. It was already done for other TIMA ops (notify, accept, ...),
only missing for those 2. Useful for debug and even more now that we
experiment with SMT.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 hw/intc/trace-events | 4 ++--
 hw/intc/xive.c       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 5c6094c457..36ff71f947 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -265,8 +265,8 @@ xive_source_esb_read(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64
 xive_source_esb_write(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64" IRQ 0x%x val=0x%"PRIx64
 xive_router_end_notify(uint8_t end_blk, uint32_t end_idx, uint32_t end_data) "END 0x%02x/0x%04x -> enqueue 0x%08x"
 xive_router_end_escalate(uint8_t end_blk, uint32_t end_idx, uint8_t esc_blk, uint32_t esc_idx, uint32_t end_data) "END 0x%02x/0x%04x -> escalate END 0x%02x/0x%04x data 0x%08x"
-xive_tctx_tm_write(uint64_t offset, unsigned int size, uint64_t value) "@0x%"PRIx64" sz=%d val=0x%" PRIx64
-xive_tctx_tm_read(uint64_t offset, unsigned int size, uint64_t value) "@0x%"PRIx64" sz=%d val=0x%" PRIx64
+xive_tctx_tm_write(uint32_t index, uint64_t offset, unsigned int size, uint64_t value) "target=%d @0x%"PRIx64" sz=%d val=0x%" PRIx64
+xive_tctx_tm_read(uint32_t index, uint64_t offset, unsigned int size, uint64_t value) "target=%d @0x%"PRIx64" sz=%d val=0x%" PRIx64
 xive_presenter_notify(uint8_t nvt_blk, uint32_t nvt_idx, uint8_t ring) "found NVT 0x%x/0x%x ring=0x%x"
 xive_end_source_read(uint8_t end_blk, uint32_t end_idx, uint64_t addr) "END 0x%x/0x%x @0x%"PRIx64
 
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index c014e961a4..56670b2cac 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -566,7 +566,7 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
 {
     const XiveTmOp *xto;
 
-    trace_xive_tctx_tm_write(offset, size, value);
+    trace_xive_tctx_tm_write(tctx->cs->cpu_index, offset, size, value);
 
     /*
      * TODO: check V bit in Q[0-3]W2
@@ -639,7 +639,7 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
      */
     ret = xive_tm_raw_read(tctx, offset, size);
 out:
-    trace_xive_tctx_tm_read(offset, size, ret);
+    trace_xive_tctx_tm_read(tctx->cs->cpu_index, offset, size, ret);
     return ret;
 }
 
-- 
2.41.0


