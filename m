Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF27728373
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 17:16:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7HN0-0008HC-AU; Thu, 08 Jun 2023 11:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7HMv-0008Gk-BO; Thu, 08 Jun 2023 11:16:09 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7HMt-0000Jz-Ou; Thu, 08 Jun 2023 11:16:09 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b1c910ee19so6791591fa.3; 
 Thu, 08 Jun 2023 08:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686237365; x=1688829365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kRMmHUe1Qjih4D9kHHf6AsQ95F5OKGHC2631HMk3eBE=;
 b=L1vNRW2J+kMI7OiwgMAAUtduWXdIEojccnEbq/rYZZbk2qpC1FByp3l6bMwT0nzezl
 nMuXtQlgKUXLvA82OjLqIdrD9/nTqUz4bpxISGCxTOFtuxGC8igTMTMHMIno02iN+Ci9
 lu3A9Pb76buYkE0CBBQ5nRUxGf4bwo42TW/CwaLMrEcoK9ue35B/ZtrxJJCS1fqiicaq
 mGozomNlakWwjyPQ2ZmdcQ2S1eW1btKWGcSvMZ6QOk0/kXEg5fBDELX/e8gA9UKZhIve
 53e6KHbihz1stWemRsHhGq4XfTMoJngwMmQwPldNsCR/BtbmDwe+0+/5HI2zHVdpRMUq
 6l/g==
X-Gm-Message-State: AC+VfDyLFHryWdleV35EFVFcuy+a762wyWQTigzkEJC1tLYTTDJFIyNr
 +7cedNPD/Gv/3fHTGhitFAzzVxgQns4jX5xAs40=
X-Google-Smtp-Source: ACHHUZ5vfVINX6+zGErOndhbsJlBKZYjTI6v4AR08JqCBmHmYvNOOtt13dzefvLPFpstd5+LTW40+Q==
X-Received: by 2002:a2e:8048:0:b0:2ad:ae71:4f21 with SMTP id
 p8-20020a2e8048000000b002adae714f21mr3537555ljg.48.1686237365319; 
 Thu, 08 Jun 2023 08:16:05 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.240.245]) by smtp.gmail.com with ESMTPSA id
 t5-20020a2e9c45000000b002b1a872c826sm276682ljj.61.2023.06.08.08.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 08:16:04 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id D682B1543; Thu,  8 Jun 2023 17:16:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686237363; bh=JupprQojrdw2iPIgmo9yMMB9PX3VO+98r8Mxh4PDiQU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=t3B8yXXm7fVRz/sdfVhpWDgWNjaeSokDIpyzoe7zRniH9x19GGRoVycWBKsVUOEXV
 3ULlPTHm71VRQAOkVLQbijrbecwURU1vbjD3caQhCWkyzv/Au6k/4nWEj4096rFci6
 zvjaSjsE8chpX9rMvRdNOKxUv8H9DGhDhORBkW9E=
Received: from x1-carbon.wireless.wdc (unknown [129.253.182.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id D9CED12C6;
 Thu,  8 Jun 2023 17:15:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686237346; bh=JupprQojrdw2iPIgmo9yMMB9PX3VO+98r8Mxh4PDiQU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y0vRrpXZMiMiNGORwSSIHFvFdmofbqzYKD3RrZ47PnZTE8E0R/OaPgjfM2NWaO7t7
 IRAD0ZuKx3N6husDgruxDf0wTJN3E70zivx/cOju3X9m0JvxaTt/mOLm9t106dALaY
 yOmn4TsjzyjgGcjnyWwliTLu6Khg9Use/TcO0FzI=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH 1/5] libqos/ahci: fix ahci_command_wait()
Date: Thu,  8 Jun 2023 17:15:24 +0200
Message-Id: <20230608151528.143950-2-nks@flawful.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230608151528.143950-1-nks@flawful.org>
References: <20230608151528.143950-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=nks.gnu@gmail.com; helo=mail-lj1-x236.google.com
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

A command that has ERR_STAT set, does not get to clear PxCI.
See AHCI 1.3.1, section 5.3.8, states RegFIS:Entry and RegFIS:ClearCI,
and 5.3.16.5 ERR:FatalTaskfile.

Some tests, e.g. test_atapi_tray() call ahci_atapi_test_ready() with
ready == false, intentionally sending a command that will cause an error.

Thus, ahci_command_wait() cannot simply wait indefinitely for PxCI to be
cleared, it also has to take ERR_STAT into account.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 tests/qtest/libqos/ahci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index f53f12aa99..c1d571e477 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -1207,9 +1207,10 @@ void ahci_command_wait(AHCIQState *ahci, AHCICommand *cmd)
 
 #define RSET(REG, MASK) (BITSET(ahci_px_rreg(ahci, cmd->port, (REG)), (MASK)))
 
-    while (RSET(AHCI_PX_TFD, AHCI_PX_TFD_STS_BSY) ||
-           RSET(AHCI_PX_CI, 1 << cmd->slot) ||
-           (cmd->props->ncq && RSET(AHCI_PX_SACT, 1 << cmd->slot))) {
+    while (!RSET(AHCI_PX_TFD, AHCI_PX_TFD_STS_ERR) &&
+           (RSET(AHCI_PX_TFD, AHCI_PX_TFD_STS_BSY) ||
+            RSET(AHCI_PX_CI, 1 << cmd->slot) ||
+            (cmd->props->ncq && RSET(AHCI_PX_SACT, 1 << cmd->slot)))) {
         usleep(50);
     }
 
-- 
2.40.1


