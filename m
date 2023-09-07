Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F29A9796F57
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 05:43:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe5uk-0008TS-Sb; Wed, 06 Sep 2023 23:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qe5ue-0008QE-Of
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 23:42:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qe5uc-0007Em-7U
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 23:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694058153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9yTrKuslt0wcZT3IVrzO7h9WsjzDnuyXTYgoXfhG/RA=;
 b=Z9DRqyu0ps4KG/k2ds56QKImg12ulpxBGJ+5SWDWy+zOSwDbomdcPjCbJ9ETMaQfEeVjzt
 8zwrVZEfhf6+M0wKnDYoCLnw8inHCoGCGJ4B+7kFYet8S5FOgsDq0EPlcKPFCXo4/9tYBp
 7I7rpv+pqkmocDGndzzTdYOxzbvqV90=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-iX_4-wj6OHOtePb9QsvBnA-1; Wed, 06 Sep 2023 23:42:30 -0400
X-MC-Unique: iX_4-wj6OHOtePb9QsvBnA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA1C6802A6E;
 Thu,  7 Sep 2023 03:42:29 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F59663F6C;
 Thu,  7 Sep 2023 03:42:29 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PULL for-6.2 2/7] hw/ide/ahci: write D2H FIS when processing NCQ
 command
Date: Wed,  6 Sep 2023 23:42:23 -0400
Message-ID: <20230907034228.4054839-3-jsnow@redhat.com>
In-Reply-To: <20230907034228.4054839-1-jsnow@redhat.com>
References: <20230907034228.4054839-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Niklas Cassel <niklas.cassel@wdc.com>

The way that BUSY + PxCI is cleared for NCQ (FPDMA QUEUED) commands is
described in SATA 3.5a Gold:

11.15 FPDMA QUEUED command protocol
DFPDMAQ2: ClearInterfaceBsy
"Transmit Register Device to Host FIS with the BSY bit cleared to zero
and the DRQ bit cleared to zero and Interrupt bit cleared to zero to
mark interface ready for the next command."

PxCI is currently cleared by handle_cmd(), but we don't write the D2H
FIS to the FIS Receive Area that actually caused PxCI to be cleared.

Similar to how ahci_pio_transfer() calls ahci_write_fis_pio() with an
additional parameter to write a PIO Setup FIS without raising an IRQ,
add a parameter to ahci_write_fis_d2h() so that ahci_write_fis_d2h()
also can write the FIS to the FIS Receive Area without raising an IRQ.

Change process_ncq_command() to call ahci_write_fis_d2h() without
raising an IRQ (similar to ahci_pio_transfer()), such that the FIS
Receive Area is in sync with the PxTFD shadow register.

E.g. Linux reads status and error fields from the FIS Receive Area
directly, so it is wise to keep the FIS Receive Area and the PxTFD
shadow register in sync.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Message-id: 20230609140844.202795-4-nks@flawful.org
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 48d550f633..4b272397fd 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -43,7 +43,7 @@
 static void check_cmd(AHCIState *s, int port);
 static int handle_cmd(AHCIState *s, int port, uint8_t slot);
 static void ahci_reset_port(AHCIState *s, int port);
-static bool ahci_write_fis_d2h(AHCIDevice *ad);
+static bool ahci_write_fis_d2h(AHCIDevice *ad, bool d2h_fis_i);
 static void ahci_init_d2h(AHCIDevice *ad);
 static int ahci_dma_prepare_buf(const IDEDMA *dma, int32_t limit);
 static bool ahci_map_clb_address(AHCIDevice *ad);
@@ -618,7 +618,7 @@ static void ahci_init_d2h(AHCIDevice *ad)
         return;
     }
 
-    if (ahci_write_fis_d2h(ad)) {
+    if (ahci_write_fis_d2h(ad, true)) {
         ad->init_d2h_sent = true;
         /* We're emulating receiving the first Reg H2D Fis from the device;
          * Update the SIG register, but otherwise proceed as normal. */
@@ -850,7 +850,7 @@ static void ahci_write_fis_pio(AHCIDevice *ad, uint16_t len, bool pio_fis_i)
     }
 }
 
-static bool ahci_write_fis_d2h(AHCIDevice *ad)
+static bool ahci_write_fis_d2h(AHCIDevice *ad, bool d2h_fis_i)
 {
     AHCIPortRegs *pr = &ad->port_regs;
     uint8_t *d2h_fis;
@@ -864,7 +864,7 @@ static bool ahci_write_fis_d2h(AHCIDevice *ad)
     d2h_fis = &ad->res_fis[RES_FIS_RFIS];
 
     d2h_fis[0] = SATA_FIS_TYPE_REGISTER_D2H;
-    d2h_fis[1] = (1 << 6); /* interrupt bit */
+    d2h_fis[1] = d2h_fis_i ? (1 << 6) : 0; /* interrupt bit */
     d2h_fis[2] = s->status;
     d2h_fis[3] = s->error;
 
@@ -890,7 +890,10 @@ static bool ahci_write_fis_d2h(AHCIDevice *ad)
         ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_TFES);
     }
 
-    ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_DHRS);
+    if (d2h_fis_i) {
+        ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_DHRS);
+    }
+
     return true;
 }
 
@@ -1120,6 +1123,8 @@ static void process_ncq_command(AHCIState *s, int port, const uint8_t *cmd_fis,
         return;
     }
 
+    ahci_write_fis_d2h(ad, false);
+
     ncq_tfs->used = 1;
     ncq_tfs->drive = ad;
     ncq_tfs->slot = slot;
@@ -1506,7 +1511,7 @@ static void ahci_cmd_done(const IDEDMA *dma)
     }
 
     /* update d2h status */
-    ahci_write_fis_d2h(ad);
+    ahci_write_fis_d2h(ad, true);
 
     if (ad->port_regs.cmd_issue && !ad->check_bh) {
         ad->check_bh = qemu_bh_new_guarded(ahci_check_cmd_bh, ad,
-- 
2.41.0


