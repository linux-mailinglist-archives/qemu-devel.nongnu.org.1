Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A72873CDE9
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 04:00:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDF18-0001S4-7s; Sat, 24 Jun 2023 21:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qDF15-0001Rn-O4
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 21:58:15 -0400
Received: from bg4.exmail.qq.com ([43.155.67.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qDF11-0002eq-S4
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 21:58:15 -0400
X-QQ-mid: bizesmtp75t1687658029tcx0joxp
Received: from ubuntu.. ( [111.196.130.174]) by bizesmtp.qq.com (ESMTP) with 
 id ; Sun, 25 Jun 2023 09:53:48 +0800 (CST)
X-QQ-SSF: 01200000000000E0G000000A0000000
X-QQ-FEAT: xwvWJGGFd7Mt4VKxOO5RGdZazMIGBw2QG/966DZi815zLglo6l8sea2PZZ+nc
 083ZScVqWH5JKUqshro+Gs2/CcngZKOPi4egC56g/GDHs8ClOWfW0IlnVgx/gDVdy486/HB
 juYYqR6Zb32OrhzWhpHcfcqQ2w5gn8PYRF7BDnVGPmeH/nvvDkVfm6ZKumTnh8rGAOg76yb
 SmQoFyt0T2E9MzY2MGxBKzcOKgV6Ow8O2i7rKYwy9KavDSrYts22Pwp+Ujd2T0noRZ8c7GN
 3fP6Wyc/rkkGVRFmZqSmjVXJ20wfG9QXb8eomp5mUpMDokqGO35Q1SMX1E2NqPxkkDPVWhO
 rr9McvC6aQMGxsrvXxrtu+ozDWBwknKYq4LNB1Z9toxx2g7I9I=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13973067493610353291
From: Bin Meng <bmeng@tinylab.org>
To: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: [PATCH v7 8/9] hw/net: sunhme: Remove the logic of padding short
 frames in the receive path
Date: Sun, 25 Jun 2023 09:53:20 +0800
Message-Id: <20230625015321.77987-9-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625015321.77987-1-bmeng@tinylab.org>
References: <20230625015321.77987-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
Received-SPF: pass client-ip=43.155.67.158; envelope-from=bmeng@tinylab.org;
 helo=bg4.exmail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL=0.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Now that we have implemented unified short frames padding in the
QEMU networking codes, remove the same logic in the NIC codes.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

(no changes since v1)

 hw/net/sunhme.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index 1f3d8011ae..391d26fb82 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -714,8 +714,6 @@ static inline void sunhme_set_rx_ring_nr(SunHMEState *s, int i)
     s->erxregs[HME_ERXI_RING >> 2] = ring;
 }
 
-#define MIN_BUF_SIZE 60
-
 static ssize_t sunhme_receive(NetClientState *nc, const uint8_t *buf,
                               size_t size)
 {
@@ -724,7 +722,6 @@ static ssize_t sunhme_receive(NetClientState *nc, const uint8_t *buf,
     dma_addr_t rb, addr;
     uint32_t intstatus, status, buffer, buffersize, sum;
     uint16_t csum;
-    uint8_t buf1[60];
     int nr, cr, len, rxoffset, csum_offset;
 
     trace_sunhme_rx_incoming(size);
@@ -775,14 +772,6 @@ static ssize_t sunhme_receive(NetClientState *nc, const uint8_t *buf,
 
     trace_sunhme_rx_filter_accept();
 
-    /* If too small buffer, then expand it */
-    if (size < MIN_BUF_SIZE) {
-        memcpy(buf1, buf, size);
-        memset(buf1 + size, 0, MIN_BUF_SIZE - size);
-        buf = buf1;
-        size = MIN_BUF_SIZE;
-    }
-
     rb = s->erxregs[HME_ERXI_RING >> 2] & HME_ERXI_RING_ADDR;
     nr = sunhme_get_rx_ring_count(s);
     cr = sunhme_get_rx_ring_nr(s);
-- 
2.34.1


