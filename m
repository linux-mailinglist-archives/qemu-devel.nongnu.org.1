Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8739570D51D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:34:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MW7-00086i-9V; Tue, 23 May 2023 03:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MW3-00085f-SN
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:33:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MW2-00049g-G6
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HrJ+jTO+9/VKb9X63yXtVWQEnp3RSf45SXcTFKjmqGc=;
 b=E3+JoY2FkmusXraZa7LvBRxr6ej5dkyw0oCwF/jzCtYpg0naPVdBmBVrGAIDfGOG5YrgQt
 JAO6ZVozwVPodN1/fLcN9l8klDMQ38qBdMnoiVDQycsKbsEHILbuJ8baxVgpXmTsugE7PC
 R1utKXaTNZ1Ft66nVl7z7UjVvYl+MKw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-5UiTBvX5Oz6B79us-zzTPg-1; Tue, 23 May 2023 03:33:02 -0400
X-MC-Unique: 5UiTBvX5Oz6B79us-zzTPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30F361C0514E;
 Tue, 23 May 2023 07:33:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC5DA2166B25;
 Tue, 23 May 2023 07:32:59 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 06/50] igb: Do not require CTRL.VME for tx VLAN tagging
Date: Tue, 23 May 2023 15:31:54 +0800
Message-Id: <20230523073238.54236-7-jasowang@redhat.com>
In-Reply-To: <20230523073238.54236-1-jasowang@redhat.com>
References: <20230523073238.54236-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

While the datasheet of e1000e says it checks CTRL.VME for tx VLAN
tagging, igb's datasheet has no such statements. It also says for
"CTRL.VLE":
> This register only affects the VLAN Strip in Rx it does not have any
> influence in the Tx path in the 82576.
(Appendix A. Changes from the 82575)

There is no "CTRL.VLE" so it is more likely that it is a mistake of
CTRL.VME.

Fixes: fba7c3b788 ("igb: respect VMVIR and VMOLR for VLAN")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/igb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index dbd1192..96a118b 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -402,7 +402,7 @@ igb_tx_insert_vlan(IGBCore *core, uint16_t qn, struct igb_tx *tx,
         }
     }
 
-    if (insert_vlan && e1000x_vlan_enabled(core->mac)) {
+    if (insert_vlan) {
         net_tx_pkt_setup_vlan_header_ex(tx->tx_pkt, vlan,
             core->mac[VET] & 0xffff);
     }
-- 
2.7.4


