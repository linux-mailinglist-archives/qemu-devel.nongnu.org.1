Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD73F7E6C43
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:14:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15hN-0000tw-CQ; Thu, 09 Nov 2023 09:07:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15fC-0004Po-BE; Thu, 09 Nov 2023 09:05:47 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15f7-0007lp-W1; Thu, 09 Nov 2023 09:05:40 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E08BE31BF7;
 Thu,  9 Nov 2023 16:59:58 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E9FB83452D;
 Thu,  9 Nov 2023 16:59:50 +0300 (MSK)
Received: (nullmailer pid 1462968 invoked by uid 1000);
 Thu, 09 Nov 2023 13:59:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Niklas Cassel <niklas.cassel@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.7 62/62] hw/ide/ahci: trigger either error IRQ or regular
 IRQ, not both
Date: Thu,  9 Nov 2023 16:59:30 +0300
Message-Id: <20231109135933.1462615-62-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
References: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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
(cherry picked from commit b523a3d54f3d031a54cd0931cc5d855608e63140)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index c5e79b6e6d..73739567ee 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -896,11 +896,10 @@ static bool ahci_write_fis_d2h(AHCIDevice *ad, bool d2h_fis_i)
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
2.39.2


