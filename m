Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C2A729F11
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 17:48:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7cpL-0003JL-2Y; Fri, 09 Jun 2023 10:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7cp1-0003GN-Qt; Fri, 09 Jun 2023 10:10:40 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7cov-0000dY-TL; Fri, 09 Jun 2023 10:10:33 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2b1b66a8fd5so20146011fa.0; 
 Fri, 09 Jun 2023 07:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686319825; x=1688911825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nTPYZzbPBWQnltn+rjRZCiQSk+YmkRCKklq606/aWiM=;
 b=O0K/zoN9QXWNnBKoybmrP3lLkIaJabhSkiTM37WJCZskMZl5WSdrgCyNfrSchwkQn9
 Gz+rJwViYQD7624MdwlfZ9zdxQEkqLq5NRhFuJxxvTS2gtAU1Adx1Fz2SejF1VLk3djC
 T3xYSwEjIrhIScPsxiuJRd7Lpz5f73DjOUz3qk6HeX7zvfXagwGdaDHThtOJF/36MUKY
 15SCpxrgVdClqiLzWcRLsskKu5/yCdkknFMbNw5RRXsMNXwdGbr0oQ22GanN0lHkdecV
 8FyRxlMTKYQyTdn5PrCxMwQeMmpk31EyVtGLC/EBCDGQFxc5PCkbQvHyqj/5nIXIp1kY
 QPFQ==
X-Gm-Message-State: AC+VfDwWEu2vD3OjFKBHZZhCnE/ZgkuZ6CkoEIqwN04ZpTOnJJd31Kqo
 7GOzR45WBfUUSO1yJ9gccm9beDnI1Z6fc0LY
X-Google-Smtp-Source: ACHHUZ4sAijVqfMiv/ASfnhNKm3ngycCaCnnOHHu82D6aDsBnLv+4cgj1wsrwgeaBz7Mx2PZV25rog==
X-Received: by 2002:a2e:360e:0:b0:2af:29d2:2ffe with SMTP id
 d14-20020a2e360e000000b002af29d22ffemr1128952lja.15.1686319825166; 
 Fri, 09 Jun 2023 07:10:25 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.240.245]) by smtp.gmail.com with ESMTPSA id
 v7-20020a2e9f47000000b002b20058ecf9sm405479ljk.32.2023.06.09.07.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 07:10:24 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id 7EA4417AD; Fri,  9 Jun 2023 16:10:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686319823; bh=4uJviMPFEwnIcHq2YXftAn5at7cFfEl+tvwWCuj/ojI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R8+XNoD/57wmvo75XMUH8cR2dty6aZGQoXBxp9RI7Tvrbd5AQ4Xf5wYlMa996KJy3
 nP/ixk0Of3RWBSwp2K/jdlF4mF4/CrNnQj89CwYRpRULyY9Khh12BeIYPMAleQpMw7
 fkagYrCPniiGxZo0rMyEbMSf1GkcrCzzKhlq9fuk=
Received: from x1-carbon.lan (unknown [129.253.182.58])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id C5EEC19A5;
 Fri,  9 Jun 2023 16:09:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686319770; bh=4uJviMPFEwnIcHq2YXftAn5at7cFfEl+tvwWCuj/ojI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PROkTmNW3QyggNBHVtI6hNcn26mH6s3QquJRZ4E9PcoqhCxAc/NW8DDyc8PWQk9V1
 LtrpiAznnwW7vlw+qJizWgi/IrOHvnZwry8reeqWZ3etUnvAEOXTE6GZSh5H6ccTz0
 9Le3W+V33y+x5i4W1dVc3vkGUY6ofZTJm/Vemw3Y=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v3 5/8] hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST
 is cleared
Date: Fri,  9 Jun 2023 16:08:41 +0200
Message-Id: <20230609140844.202795-6-nks@flawful.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609140844.202795-1-nks@flawful.org>
References: <20230609140844.202795-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=nks.gnu@gmail.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

According to AHCI 1.3.1 definition of PxSACT:
This field is cleared when PxCMD.ST is written from a '1' to a '0' by
software. This field is not cleared by a COMRESET or a software reset.

According to AHCI 1.3.1 definition of PxCI:
This field is also cleared when PxCMD.ST is written from a '1' to a '0'
by software.

Clearing PxCMD.ST is part of the error recovery procedure, see
AHCI 1.3.1, section "6.2 Error Recovery".

If we don't clear PxCI on error recovery, the previous command will
incorrectly still be marked as pending after error recovery.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 hw/ide/ahci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 3deaf01add..a31e6fa65e 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -329,6 +329,11 @@ static void ahci_port_write(AHCIState *s, int port, int offset, uint32_t val)
         ahci_check_irq(s);
         break;
     case AHCI_PORT_REG_CMD:
+        if ((pr->cmd & PORT_CMD_START) && !(val & PORT_CMD_START)) {
+            pr->scr_act = 0;
+            pr->cmd_issue = 0;
+        }
+
         /* Block any Read-only fields from being set;
          * including LIST_ON and FIS_ON.
          * The spec requires to set ICC bits to zero after the ICC change
-- 
2.40.1


