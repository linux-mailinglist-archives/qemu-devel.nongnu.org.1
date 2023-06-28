Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF9E74105E
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 13:48:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETc7-0002H3-TR; Wed, 28 Jun 2023 07:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETbq-0002C2-Pw
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:45:18 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETbp-00052F-9N
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YIOxwQr68l6I016NulUhBANENAXMZaTkyQ9T81Qvd7s=; b=kFxxsDkV8qxh81B91DnQaY6VLZ
 W6V2sFTJlIHK2/d8RVYWcabF8HIOTdVzyFTo9Bajs75u32S6qcRwxO4LcJQXk4g9gF0liZu9UEtfH
 O7J2/jtNUIbQAHm8/T8FFg7vv/cP6ddNSuH9dKAzJyHd8RnR/YhOSzGdGP1abGJ/AZmWd2Hvo0qJG
 L6DPPU6t8rb3/8suoufekz+VW7U7F3VO042+tiN/uqASV3BzFNuknhUXNCGjK71dRl2PcRJyRNHlC
 yfEX8AudR3EnQ0Wa0m/aOvWoMQazkRsXkTPxde2NI2RgTe7cbssk4tc2NgC1DV6OHN9dHgTDhPR7k
 RqlEb+MKtM8BwlC7DOlIvnaZcd7ByK5/bnFi5rO5A1vW+LecJYXxREvQcDkjigA1yGZZM7dIkqNMB
 3YFs3iaSvnVXUosx5THA5f/wQt7bc7fGW7b01OpL7wluAOWFDozdbEIHLcpgu2hUaaGxapS+D37eW
 6NhrMpjbugcu2GZUYIbeYj6asrB9HZtxhMwADg0IcU92O+7AyZdNy9O+yhOBiBKxx53K27vKRG0Rf
 5MsDXg07Oyswcn+tvyRwP6mqbS0+afV81uLw6puElQ9tIxKYv+VdirTk7KRfAuEjVwtUNLdGiDB++
 t7PSn5bjQmmgu+f4snCSSeR0EHjHhdhvTIkPBUfFk=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETbb-00007c-5X; Wed, 28 Jun 2023 12:45:07 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Date: Wed, 28 Jun 2023 12:44:55 +0100
Message-Id: <20230628114504.546265-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230628114504.546265-1-mark.cave-ayland@ilande.co.uk>
References: <20230628114504.546265-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 01/10] Revert "hw/sparc64/niagara: Use blk_name() instead of
 open-coding it"
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Markus Armbruster <armbru@redhat.com>

This reverts commit 1881f336a33a8a99cb17ab1c57ed953682e8e107.

This commit breaks "-drive if=pflash,readonly=on,file=image.iso".  It
claims to merely replace an open-coded version of blk_name() by a
call, but that's not the case.  Sorry for the inconvenience!

Reported-by: Jakub Jermář <jakub@jermar.eu>
Cc: qemu-stable@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20230515151104.1350155-1-armbru@redhat.com>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc64/niagara.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 6725cc61fd..ab3c4ec346 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "block/block_int-common.h"
 #include "qemu/units.h"
 #include "cpu.h"
 #include "hw/boards.h"
@@ -143,9 +144,10 @@ static void niagara_init(MachineState *machine)
             memory_region_add_subregion(get_system_memory(),
                                         NIAGARA_VDISK_BASE, &s->vdisk_ram);
             dinfo->is_default = 1;
-            rom_add_file_fixed(blk_name(blk), NIAGARA_VDISK_BASE, -1);
+            rom_add_file_fixed(blk_bs(blk)->filename, NIAGARA_VDISK_BASE, -1);
         } else {
-            error_report("could not load ram disk '%s'", blk_name(blk));
+            error_report("could not load ram disk '%s'",
+                         blk_bs(blk)->filename);
             exit(1);
         }
     }
-- 
2.30.2


