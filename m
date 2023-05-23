Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F9D70D51B
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:34:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MXB-00033H-UC; Tue, 23 May 2023 03:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MX2-0002sn-LV
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MX0-0004K7-Oz
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+mFSeuYpKPLXZiCfjywgffxUBU/aEgQ65SUgwCjfm9M=;
 b=g/QXHJ2l67Rh/ZZd3ABUrICy2IC7iAYmh2rgBxGPJ9Wybxfgpq5nJq1Dbgt2IV566BIewi
 OyPIOH/HFyBDwkD/fhmnMIfK8chC3/Svx35b0vX87wtwVTX1W4Kql5EvtW/KxXlCe2jdRI
 afL3YbEfwikPbSCVxJEDLhv7cYlyT7M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-Z6GxgCLePoaikXhaW6c3Iw-1; Tue, 23 May 2023 03:34:04 -0400
X-MC-Unique: Z6GxgCLePoaikXhaW6c3Iw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA28B85A5A8;
 Tue, 23 May 2023 07:34:03 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D1402166B25;
 Tue, 23 May 2023 07:34:01 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 27/50] igb: Fix igb_mac_reg_init coding style alignment
Date: Tue, 23 May 2023 15:32:15 +0800
Message-Id: <20230523073238.54236-28-jasowang@redhat.com>
In-Reply-To: <20230523073238.54236-1-jasowang@redhat.com>
References: <20230523073238.54236-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/igb_core.c | 96 +++++++++++++++++++++++++++----------------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 56a5387..20645c4 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -4027,54 +4027,54 @@ static const uint32_t igb_mac_reg_init[] = {
     [VMOLR0 ... VMOLR0 + 7] = 0x2600 | E1000_VMOLR_STRCRC,
     [RPLOLR]        = E1000_RPLOLR_STRCRC,
     [RLPML]         = 0x2600,
-    [TXCTL0]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL1]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL2]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL3]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL4]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL5]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL6]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL7]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL8]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL9]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL10]      = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL11]      = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL12]      = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL13]      = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL14]      = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
-    [TXCTL15]      = E1000_DCA_TXCTRL_DATA_RRO_EN |
-                     E1000_DCA_TXCTRL_TX_WB_RO_EN |
-                     E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL0]        = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL1]        = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL2]        = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL3]        = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL4]        = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL5]        = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL6]        = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL7]        = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL8]        = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL9]        = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL10]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL11]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL12]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL13]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL14]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
+    [TXCTL15]       = E1000_DCA_TXCTRL_DATA_RRO_EN |
+                      E1000_DCA_TXCTRL_TX_WB_RO_EN |
+                      E1000_DCA_TXCTRL_DESC_RRO_EN,
 };
 
 static void igb_reset(IGBCore *core, bool sw)
-- 
2.7.4


