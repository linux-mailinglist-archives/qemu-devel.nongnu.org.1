Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5359C799756
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 12:31:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qevEb-0005BK-7d; Sat, 09 Sep 2023 06:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qevEG-0004u5-MK; Sat, 09 Sep 2023 06:30:16 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qevEA-0004es-W8; Sat, 09 Sep 2023 06:30:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 10DB9204AE;
 Sat,  9 Sep 2023 13:29:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1654826D0C;
 Sat,  9 Sep 2023 13:28:20 +0300 (MSK)
Received: (nullmailer pid 346720 invoked by uid 1000);
 Sat, 09 Sep 2023 10:28:17 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Niklas Cassel <niklas.cassel@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.1 27/34] hw/ide/ahci: fix ahci_write_fis_sdb()
Date: Sat,  9 Sep 2023 13:27:20 +0300
Message-Id: <20230909102747.346522-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.1-20230909131531@cover.tls.msk.ru>
References: <qemu-stable-8.1.1-20230909131531@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When there is an error, we need to raise a TFES error irq, see AHCI 1.3.1,
5.3.13.1 SDB:Entry.

If ERR_STAT is set, we jump to state ERR:FatalTaskfile, which will raise
a TFES IRQ unconditionally, regardless if the I bit is set in the FIS or
not.

Thus, we should never raise a normal IRQ after having sent an error IRQ.

It is valid to signal successfully completed commands as finished in the
same SDB FIS that generates the error IRQ. The important thing is that
commands that did not complete successfully (e.g. commands that were
aborted, do not get the finished bit set).

Before this commit, there was never a TFES IRQ raised on NCQ error.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230609140844.202795-8-nks@flawful.org
Signed-off-by: John Snow <jsnow@redhat.com>
(cherry picked from commit 7e85cb0db4c693b4e084a00e66fe73a22ed1688a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 12aaadc554..ef6c9fc378 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -806,8 +806,14 @@ static void ahci_write_fis_sdb(AHCIState *s, NCQTransferState *ncq_tfs)
     pr->scr_act &= ~ad->finished;
     ad->finished = 0;
 
-    /* Trigger IRQ if interrupt bit is set (which currently, it always is) */
-    if (sdb_fis->flags & 0x40) {
+    /*
+     * TFES IRQ is always raised if ERR_STAT is set, regardless of I bit.
+     * If ERR_STAT is not set, trigger SDBS IRQ if interrupt bit is set
+     * (which currently, it always is).
+     */
+    if (sdb_fis->status & ERR_STAT) {
+        ahci_trigger_irq(s, ad, AHCI_PORT_IRQ_BIT_TFES);
+    } else if (sdb_fis->flags & 0x40) {
         ahci_trigger_irq(s, ad, AHCI_PORT_IRQ_BIT_SDBS);
     }
 }
-- 
2.39.2


