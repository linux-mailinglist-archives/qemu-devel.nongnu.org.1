Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DE082C035
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 13:58:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH4m-0000Qo-Hc; Fri, 12 Jan 2024 07:55:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4g-0000CA-V1
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:55:51 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4e-0006xn-PK
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e6mCLf/9017hCj5XWuJdYBBrxktVwOh7syFJi7T1WOs=; b=l8P9EYisGv3pw3jDivQESBQ6LJ
 jSfwYWCQhM8ZtrjzfXKaGpCEPXoCL4Q5yoJ2tjWUk7r1UA/Du2mENco+TdWzCbrmnxc5/HJkv1c0U
 C2U0L6ZF43IgLg7M948vXWhxRVGElVGXkfNcSO51156MW0iu3T7p4BywTVrBCCdNOUifjI6Eeq7UO
 yXCdZdoT0I5LAPuU09b4LUYCmtbxQarKr5m6sNE3P2KzGY/iwf/EnO8bFETiqS5ZEwJkLuIs4isLV
 6/cHoykpa1RGxTXIG8KqKptnjXO4SNkuDVq3K303T+IPVMI6FvNvLIUhX8f2NPYxozv+rChfY1Tqx
 ZzxtcLC0+Nn/vTYNUqApDbJkujflN0obWtt9f46SnAJvOx4I/9i1ySIsgH6Y+DrF9iHGYbksli2qh
 Wp3iRj9dxkqznOBwSPQ7oMGzwGLJPHTbVWe7WY7PZLXObDbQbn8Mip5gjPFKKpWrF32h9Vmi7BLQ2
 yEsncCrKODovMRRyvgzVOGfRffxA0e5wCxKrimu9dw2WjN4UlbkhWmLUwt2TdLXqmxuskfFcQgLdu
 Cv+2jkvS8Garl9GL6g9Bhj38GT5oqAg9BtJt68rMyePD4kGVtVvbWa7Rhi4jxkDwOntXZ4K6XVI+J
 reo9WsnXkN88N107m/zIDjBNtG0TRFKx4uBl1tbrc=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3r-0008jM-Px; Fri, 12 Jan 2024 12:55:03 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:09 +0000
Message-Id: <20240112125420.514425-18-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 17/88] esp.c: don't reset the TC and ESP_RSEQ state when
 executing a SCSI command
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

There is no need to manually reset these values as the ESP emulation now
correctly handles them within its existing logic.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index f41b2421f9..a4a1f41a40 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -319,10 +319,7 @@ static void do_command_phase(ESPState *s)
     s->ti_size = datalen;
     fifo8_reset(&s->cmdfifo);
     if (datalen != 0) {
-        s->rregs[ESP_RSTAT] = STAT_TC;
-        s->rregs[ESP_RSEQ] = SEQ_CD;
         s->ti_cmd = 0;
-        esp_set_tc(s, 0);
         if (datalen > 0) {
             /*
              * Switch to DATA IN phase but wait until initial data xfer is
-- 
2.39.2


