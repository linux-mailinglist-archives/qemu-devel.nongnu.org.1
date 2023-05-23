Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D74A970D547
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:37:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MY3-0004a9-U7; Tue, 23 May 2023 03:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MXb-0004EU-Ie
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MXS-0004P2-QB
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H9gZU6XaUiADEesbmCoa8+EF67M+ir8R784JmXrE7pU=;
 b=ZW4wGPZdmlcQt9skU3Z1KQj52vU5BgGf1A/5cGcVDMdVcuttvsTwbS3rz0zeQRcZ6FT1NC
 GVl9qGJy5RjDvPpIJyLmFVDUzlu3tNa0D2amvxjlUSNWpopziwCYAY7B7NqG/VuIQV76cx
 8kzA1P7DImHYHWwsVJPWjVU2SQiFsgg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-wAqTfZixNu6bgSMHwqL3_A-1; Tue, 23 May 2023 03:34:29 -0400
X-MC-Unique: wAqTfZixNu6bgSMHwqL3_A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFB9A3806705;
 Tue, 23 May 2023 07:34:28 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 723092166B25;
 Tue, 23 May 2023 07:34:26 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 35/50] igb: Implement MSI-X single vector mode
Date: Tue, 23 May 2023 15:32:23 +0800
Message-Id: <20230523073238.54236-36-jasowang@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/igb_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index c954369..6d55b43 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -1873,7 +1873,7 @@ igb_update_interrupt_state(IGBCore *core)
 
     icr = core->mac[ICR] & core->mac[IMS];
 
-    if (msix_enabled(core->owner)) {
+    if (core->mac[GPIE] & E1000_GPIE_MSIX_MODE) {
         if (icr) {
             causes = 0;
             if (icr & E1000_ICR_DRSTA) {
@@ -1908,7 +1908,12 @@ igb_update_interrupt_state(IGBCore *core)
         trace_e1000e_irq_pending_interrupts(core->mac[ICR] & core->mac[IMS],
                                             core->mac[ICR], core->mac[IMS]);
 
-        if (msi_enabled(core->owner)) {
+        if (msix_enabled(core->owner)) {
+            if (icr) {
+                trace_e1000e_irq_msix_notify_vec(0);
+                msix_notify(core->owner, 0);
+            }
+        } else if (msi_enabled(core->owner)) {
             if (icr) {
                 msi_notify(core->owner, 0);
             }
-- 
2.7.4


