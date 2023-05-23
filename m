Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EFF70D558
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:38:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MYd-00060L-In; Tue, 23 May 2023 03:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MXz-0004c8-4g
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:35:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MXw-0004d3-VZ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jgmp+iaIdCTkSsJzGfJ7/EBoxvPShhC0BhIpSU4yFcA=;
 b=JXDe7nA+MWaYykOEz+xo9O15ZyZS2czxmdpL0s19Tk3sF0VPjwBgvGT/RhkUSlFN5O72He
 RwMOOQ81oXdVXEFaC9M2gsR6hPjb+1qCUvFJUBOYu5Z7IeKqHplPaBW+JIVhITeubZAIRf
 D5VArlJwdowj2daXLOuDsFsuYsQtwGs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-J366CIoBMQGF8AHyDVtgfA-1; Tue, 23 May 2023 03:35:02 -0400
X-MC-Unique: J366CIoBMQGF8AHyDVtgfA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2438800141;
 Tue, 23 May 2023 07:35:01 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64C412166B25;
 Tue, 23 May 2023 07:34:59 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 46/50] igb: Clear-on-read ICR when ICR.INTA is set
Date: Tue, 23 May 2023 15:32:34 +0800
Message-Id: <20230523073238.54236-47-jasowang@redhat.com>
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

For GPIE.NSICR, Section 7.3.2.1.2 says:
> ICR bits are cleared on register read. If GPIE.NSICR = 0b, then the
> clear on read occurs only if no bit is set in the IMS or at least one
> bit is set in the IMS and there is a true interrupt as reflected in
> ICR.INTA.

e1000e does similar though it checks for CTRL_EXT.IAME, which does not
exist on igb.

Suggested-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/igb_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 823dde8..d00b1ca 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -2598,6 +2598,8 @@ igb_mac_icr_read(IGBCore *core, int index)
     } else if (core->mac[IMS] == 0) {
         trace_e1000e_irq_icr_clear_zero_ims();
         igb_lower_interrupts(core, ICR, 0xffffffff);
+    } else if (core->mac[ICR] & E1000_ICR_INT_ASSERTED) {
+        igb_lower_interrupts(core, ICR, 0xffffffff);
     } else if (!msix_enabled(core->owner)) {
         trace_e1000e_irq_icr_clear_nonmsix_icr_read();
         igb_lower_interrupts(core, ICR, 0xffffffff);
-- 
2.7.4


