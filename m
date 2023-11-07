Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBC27E48B4
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:50:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0R6P-0004cH-Bw; Tue, 07 Nov 2023 13:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5u-00046E-Ft
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5s-0001Y5-Tk
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699382791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FwHUC7S3Z5nYb5gUNIYR3N7FkjaPlVamBaOvDLLfJ6w=;
 b=ho6Ce3raTg1H4NqpJvlhgzc0VM2Wr7AQUFmSfnzKcUskcmHf4RAMFkhdFbZKAmP2UutE4w
 9f7/kSvlLDobwZS48ADIirKRbW6mhdxgOaDAUblp5oqVzEzZ6stggRGOTXrfw89MlVqYus
 ZNbGWsHB1qHPNu9cdJdnoFGcvEnQiqg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-zOuXovR6Ow6sJ_3LN3Vd0Q-1; Tue, 07 Nov 2023 13:46:26 -0500
X-MC-Unique: zOuXovR6Ow6sJ_3LN3Vd0Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 613FE83BA87
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 18:46:26 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E10E3C1290F;
 Tue,  7 Nov 2023 18:46:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com
Subject: [PULL 25/25] hw/ide/ahci: trigger either error IRQ or regular IRQ,
 not both
Date: Tue,  7 Nov 2023 19:46:05 +0100
Message-ID: <20231107184605.236540-26-kwolf@redhat.com>
In-Reply-To: <20231107184605.236540-1-kwolf@redhat.com>
References: <20231107184605.236540-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Niklas Cassel <niklas.cassel@wdc.com>

According to AHCI 1.3.1, 5.3.8.1 RegFIS:Entry, if ERR_STAT is set,
we jump to state ERR:FatalTaskfile, which will raise a TFES IRQ
unconditionally, regardless if the I bit is set in the FIS or not.

Thus, we should never raise a normal IRQ after having sent an error
IRQ.

NOTE: for QEMU platforms that use SeaBIOS, this patch depends on QEMU
commit 784155cdcb02 ("seabios: update submodule to git snapshot"), and
QEMU commit 14f5a7bae4cb ("seabios: update binaries to git snapshot"),
which update SeaBIOS to a version that contains SeaBIOS commit 1281e340
("ahci: handle TFES irq correctly").

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Message-ID: <20231011131220.1992064-1-nks@flawful.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/ide/ahci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index fcc5476e9e..7676e2d871 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -897,11 +897,10 @@ static bool ahci_write_fis_d2h(AHCIDevice *ad, bool d2h_fis_i)
     pr->tfdata = (ad->port.ifs[0].error << 8) |
         ad->port.ifs[0].status;
 
+    /* TFES IRQ is always raised if ERR_STAT is set, regardless of I bit. */
     if (d2h_fis[2] & ERR_STAT) {
         ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_TFES);
-    }
-
-    if (d2h_fis_i) {
+    } else if (d2h_fis_i) {
         ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_DHRS);
     }
 
-- 
2.41.0


