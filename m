Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C5179987A
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:16:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexgZ-0002QS-DL; Sat, 09 Sep 2023 09:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexgT-00029z-D8; Sat, 09 Sep 2023 09:07:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexgO-0003jk-Jq; Sat, 09 Sep 2023 09:07:33 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AA2BB205E6;
 Sat,  9 Sep 2023 16:06:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7316326E39;
 Sat,  9 Sep 2023 16:05:17 +0300 (MSK)
Received: (nullmailer pid 354336 invoked by uid 1000);
 Sat, 09 Sep 2023 13:05:12 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Niklas Cassel <niklas.cassel@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.6 25/37] hw/ide/core: set ERR_STAT in unsupported command
 completion
Date: Sat,  9 Sep 2023 16:04:55 +0300
Message-Id: <20230909130511.354171-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.6-20230909160328@cover.tls.msk.ru>
References: <qemu-stable-7.2.6-20230909160328@cover.tls.msk.ru>
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

Currently, the first time sending an unsupported command
(e.g. READ LOG DMA EXT) will not have ERR_STAT set in the completion.
Sending the unsupported command again, will correctly have ERR_STAT set.

When ide_cmd_permitted() returns false, it calls ide_abort_command().
ide_abort_command() first calls ide_transfer_stop(), which will call
ide_transfer_halt() and ide_cmd_done(), after that ide_abort_command()
sets ERR_STAT in status.

ide_cmd_done() for AHCI will call ahci_write_fis_d2h() which writes the
current status in the FIS, and raises an IRQ. (The status here will not
have ERR_STAT set!).

Thus, we cannot call ide_transfer_stop() before setting ERR_STAT, as
ide_transfer_stop() will result in the FIS being written and an IRQ
being raised.

The reason why it works the second time, is that ERR_STAT will still
be set from the previous command, so when writing the FIS, the
completion will correctly have ERR_STAT set.

Set ERR_STAT before writing the FIS (calling cmd_done), so that we will
raise an error IRQ correctly when receiving an unsupported command.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230609140844.202795-3-nks@flawful.org
Signed-off-by: John Snow <jsnow@redhat.com>
(cherry picked from commit c3461c6264a7c8ca15b117e91fe5da786924a784)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 39afdc0006..79c5529975 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -530,9 +530,9 @@ BlockAIOCB *ide_issue_trim(
 
 void ide_abort_command(IDEState *s)
 {
-    ide_transfer_stop(s);
     s->status = READY_STAT | ERR_STAT;
     s->error = ABRT_ERR;
+    ide_transfer_stop(s);
 }
 
 static void ide_set_retry(IDEState *s)
-- 
2.39.2


