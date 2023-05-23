Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFBB70D525
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:35:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MXw-0004C5-V8; Tue, 23 May 2023 03:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MXE-0003Mi-55
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MX8-0004Ma-6S
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aGZr+UR6Mm5/IFdMVqdei/jxKCRdKA7/FfdUHnbzZgo=;
 b=UgEmr6NBDB/5WsbzR851JacNI2jRaiTbdfObBjGteO9LSzmq+Gul0+2M4u37r+EB6ohb46
 vW7NmuonAj+BfIX1MoZlXFr1t9mJjdnlEuA7GJlH5ZGHMnxCeeZeJcwQkbBWotjC4V3LsK
 QUUObHYnfZ0lljUEV+7w5KTd5dTEQRk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-bLWD80yaNku2qahLzgDWew-1; Tue, 23 May 2023 03:34:10 -0400
X-MC-Unique: bLWD80yaNku2qahLzgDWew-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 125F81C07542;
 Tue, 23 May 2023 07:34:10 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 155A62166B25;
 Tue, 23 May 2023 07:34:06 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 29/50] e1000e: Rename a variable in e1000e_receive_internal()
Date: Tue, 23 May 2023 15:32:17 +0800
Message-Id: <20230523073238.54236-30-jasowang@redhat.com>
In-Reply-To: <20230523073238.54236-1-jasowang@redhat.com>
References: <20230523073238.54236-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Rename variable "n" to "causes", which properly represents the content
of the variable.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000e_core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 7dce448..aea70b7 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1650,7 +1650,7 @@ static ssize_t
 e1000e_receive_internal(E1000ECore *core, const struct iovec *iov, int iovcnt,
                         bool has_vnet)
 {
-    uint32_t n = 0;
+    uint32_t causes = 0;
     uint8_t buf[ETH_ZLEN];
     struct iovec min_iov;
     size_t size, orig_size;
@@ -1723,32 +1723,32 @@ e1000e_receive_internal(E1000ECore *core, const struct iovec *iov, int iovcnt,
 
         /* Perform small receive detection (RSRPD) */
         if (total_size < core->mac[RSRPD]) {
-            n |= E1000_ICS_SRPD;
+            causes |= E1000_ICS_SRPD;
         }
 
         /* Perform ACK receive detection */
         if  (!(core->mac[RFCTL] & E1000_RFCTL_ACK_DIS) &&
              (e1000e_is_tcp_ack(core, core->rx_pkt))) {
-            n |= E1000_ICS_ACK;
+            causes |= E1000_ICS_ACK;
         }
 
         /* Check if receive descriptor minimum threshold hit */
         rdmts_hit = e1000e_rx_descr_threshold_hit(core, rxr.i);
-        n |= e1000e_rx_wb_interrupt_cause(core, rxr.i->idx, rdmts_hit);
+        causes |= e1000e_rx_wb_interrupt_cause(core, rxr.i->idx, rdmts_hit);
 
         trace_e1000e_rx_written_to_guest(rxr.i->idx);
     } else {
-        n |= E1000_ICS_RXO;
+        causes |= E1000_ICS_RXO;
         retval = 0;
 
         trace_e1000e_rx_not_written_to_guest(rxr.i->idx);
     }
 
-    if (!e1000e_intrmgr_delay_rx_causes(core, &n)) {
-        trace_e1000e_rx_interrupt_set(n);
-        e1000e_set_interrupt_cause(core, n);
+    if (!e1000e_intrmgr_delay_rx_causes(core, &causes)) {
+        trace_e1000e_rx_interrupt_set(causes);
+        e1000e_set_interrupt_cause(core, causes);
     } else {
-        trace_e1000e_rx_interrupt_delayed(n);
+        trace_e1000e_rx_interrupt_delayed(causes);
     }
 
     return retval;
-- 
2.7.4


