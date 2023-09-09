Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0896B799764
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 12:33:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qevEc-0005Nf-0c; Sat, 09 Sep 2023 06:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qevEF-0004qJ-Hp; Sat, 09 Sep 2023 06:30:15 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qevEC-0004vI-Pu; Sat, 09 Sep 2023 06:30:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 37748204AF;
 Sat,  9 Sep 2023 13:29:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3F22A26D0D;
 Sat,  9 Sep 2023 13:28:20 +0300 (MSK)
Received: (nullmailer pid 346723 invoked by uid 1000);
 Sat, 09 Sep 2023 10:28:17 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Niklas Cassel <niklas.cassel@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.1 28/34] hw/ide/ahci: fix broken SError handling
Date: Sat,  9 Sep 2023 13:27:21 +0300
Message-Id: <20230909102747.346522-28-mjt@tls.msk.ru>
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

When encountering an NCQ error, you should not write the NCQ tag to the
SError register. This is completely wrong.

The SError register has a clear definition, where each bit represents a
different error, see PxSERR definition in AHCI 1.3.1.

If we write a random value (like the NCQ tag) in SError, e.g. Linux will
read SError, and will trigger arbitrary error handling depending on the
NCQ tag that happened to be executing.

In case of success, ncq_cb() will call ncq_finish().
In case of error, ncq_cb() will call ncq_err() (which will clear
ncq_tfs->used), and then call ncq_finish(), thus using ncq_tfs->used is
sufficient to tell if finished should get set or not.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230609140844.202795-9-nks@flawful.org
Signed-off-by: John Snow <jsnow@redhat.com>
(cherry picked from commit 9f89423537653de07ca40c18b5ff5b70b104cc93)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index ef6c9fc378..d0a774bc17 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1012,7 +1012,6 @@ static void ncq_err(NCQTransferState *ncq_tfs)
 
     ide_state->error = ABRT_ERR;
     ide_state->status = READY_STAT | ERR_STAT;
-    ncq_tfs->drive->port_regs.scr_err |= (1 << ncq_tfs->tag);
     qemu_sglist_destroy(&ncq_tfs->sglist);
     ncq_tfs->used = 0;
 }
@@ -1022,7 +1021,7 @@ static void ncq_finish(NCQTransferState *ncq_tfs)
     /* If we didn't error out, set our finished bit. Errored commands
      * do not get a bit set for the SDB FIS ACT register, nor do they
      * clear the outstanding bit in scr_act (PxSACT). */
-    if (!(ncq_tfs->drive->port_regs.scr_err & (1 << ncq_tfs->tag))) {
+    if (ncq_tfs->used) {
         ncq_tfs->drive->finished |= (1 << ncq_tfs->tag);
     }
 
-- 
2.39.2


