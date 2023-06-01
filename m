Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EE1719EC0
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:48:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ieW-0001ga-J7; Thu, 01 Jun 2023 09:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q4idT-0000eI-Se; Thu, 01 Jun 2023 09:46:45 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q4idS-0008Od-1x; Thu, 01 Jun 2023 09:46:39 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2af1822b710so12290751fa.1; 
 Thu, 01 Jun 2023 06:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685627196; x=1688219196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lRUDXPgEIuqaCaSBtOJycBIS4yRVTfhduYGOGlOJRcw=;
 b=Fw7LPn5/BlTxtLp4z6I6QibWPBn6VKWwONVxvubijCqhuhvTQmB0AliRlJfValB3Xc
 qBxtHC5h4Kgjd5YKgesFYmVpvFJ8RaBBdqT4IwHUMbBvtSYYw4yGc/Q2NY8WOt/IzyJU
 ALXteHcgYVMvDmqyj37YDQLX4aEDKm2aAKy6DInfQayfQlCWNcixZeXlmTMra4RdqEhF
 rl8pFCLqB29k4F3gbhkhuAuBzGCSEkAWY+E85+VDBiSiSN3Ix3DUOUympCoKJg6Rn8qC
 KsUWP+JssLt2hJXSG57Dp069dP7Hzp4/UwRiAvenrC9C6BzFbLXjy4+LugnKVVgn7wWQ
 nqAA==
X-Gm-Message-State: AC+VfDwREHLIsGa5zDYWC/cNKvO45I5xfAOJwCeFOAMAhX2kWbPcrTfc
 UsjvVCMQnVAA6x4/x/+xYhUNkVAQoGH6gntd
X-Google-Smtp-Source: ACHHUZ5esnnLGzcbQ8bp2xkRGV5My+uf6LxFqF5DeiNuffXsjJ4phXtFgXvTm58TXE7nFM+oH0L3Nw==
X-Received: by 2002:a2e:9cd8:0:b0:2a8:ac69:bfe with SMTP id
 g24-20020a2e9cd8000000b002a8ac690bfemr5028881ljj.42.1685627195886; 
 Thu, 01 Jun 2023 06:46:35 -0700 (PDT)
Received: from flawful.org (c-fcf6e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.246.252]) by smtp.gmail.com with ESMTPSA id
 c10-20020a2e9d8a000000b002af03f75edasm3762243ljj.80.2023.06.01.06.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 06:46:35 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id 0844C9AF; Thu,  1 Jun 2023 15:46:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1685627194; bh=fmoGDhtmXtv2TR+hBxojsJtQ3DJAlcR2rp3dlui8BOQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ceYvwkdaShlNpo1WTWxdX5OzHe0NuxY2vX+FNJOa0UZaydSD6eM/j7JVqQNRgsMTd
 cq3PCN8WTp0QowD5eyjUn93P62ZT7S0s1GARhsrY8BIo4GIawZFYgBwTqmRopQcX+H
 HLkdPsy/DBu1D6Icths6kpEkXkYvrKMBBu35gjXQ=
Received: from x1-carbon.lan (unknown [129.253.182.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id A69E08CC;
 Thu,  1 Jun 2023 15:45:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1685627140; bh=fmoGDhtmXtv2TR+hBxojsJtQ3DJAlcR2rp3dlui8BOQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R+hsA9Cq5/4kWnsnp6kciMypYOjKl2Hr040/iqfd7W8ugCoF/uQqhe8eiDwpFo8wF
 Zp1M99pUwOGyFzgFD71gmCAXRisXNdElmCvy9k4f20hm534mS2u0Y3bB/EVsMp0alI
 DObhpCuSutimE+p6e+XHmrsdHDlX13zo2BQBkUBs=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v2 5/8] hw/ide/ahci: PxCI should not get cleared when ERR_STAT
 is set
Date: Thu,  1 Jun 2023 15:44:31 +0200
Message-Id: <20230601134434.519805-6-nks@flawful.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601134434.519805-1-nks@flawful.org>
References: <20230601134434.519805-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=nks.gnu@gmail.com; helo=mail-lj1-x233.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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

For NCQ, PxCI is cleared on command queued successfully.
For non-NCQ, PxCI is cleared on command completed successfully.
Successfully means ERR_STAT, BUSY and DRQ are all cleared.

A command that has ERR_STAT set, does not get to clear PxCI.
See AHCI 1.3.1, section 5.3.8, states RegFIS:Entry and RegFIS:ClearCI,
and 5.3.16.5 ERR:FatalTaskfile.

In the case of non-NCQ commands, not clearing PxCI is needed in order
for host software to be able to see which command slot that failed.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 hw/ide/ahci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 3deaf01add..1237f94ddc 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1518,7 +1518,8 @@ static void ahci_clear_cmd_issue(AHCIDevice *ad, uint8_t slot)
 {
     IDEState *ide_state = &ad->port.ifs[0];
 
-    if (!(ide_state->status & (BUSY_STAT | DRQ_STAT))) {
+    if (!(ide_state->status & ERR_STAT) &&
+        !(ide_state->status & (BUSY_STAT | DRQ_STAT))) {
         ad->port_regs.cmd_issue &= ~(1 << slot);
     }
 }
@@ -1527,6 +1528,7 @@ static void ahci_clear_cmd_issue(AHCIDevice *ad, uint8_t slot)
 static void ahci_cmd_done(const IDEDMA *dma)
 {
     AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
+    IDEState *ide_state = &ad->port.ifs[0];
 
     trace_ahci_cmd_done(ad->hba, ad->port_no);
 
@@ -1543,7 +1545,8 @@ static void ahci_cmd_done(const IDEDMA *dma)
      */
     ahci_write_fis_d2h(ad, true);
 
-    if (ad->port_regs.cmd_issue && !ad->check_bh) {
+    if (!(ide_state->status & ERR_STAT) &&
+        ad->port_regs.cmd_issue && !ad->check_bh) {
         ad->check_bh = qemu_bh_new_guarded(ahci_check_cmd_bh, ad,
                                            &ad->mem_reentrancy_guard);
         qemu_bh_schedule(ad->check_bh);
-- 
2.40.1


