Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CAE729EEF
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 17:44:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7coU-0002gV-Ew; Fri, 09 Jun 2023 10:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7coS-0002b4-D3; Fri, 09 Jun 2023 10:10:00 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7coQ-0000JM-Og; Fri, 09 Jun 2023 10:10:00 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4f640e48bc3so2260929e87.2; 
 Fri, 09 Jun 2023 07:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686319787; x=1688911787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cy91cBRqAqiwy9cOS34w2pZldiLcmYPrCZe3pVyd0X4=;
 b=YGE28Gx9zoJeQJbCbJ76ETmliBa961tRsu5jtPlMH1J/2MeCmHOatnreYwkSkSpjF1
 bEV4Kd5BG28S4nuryPZZZH3Vw5ZUU/l2F0ENH8GFRAiCgEbRnVtzBK+4cAvZ58yTVVsm
 5PBPrHKQ4btewSAndVIs056tyQePZ6kXCaxq5cWxD3IRj+TSOBBphSjE69iShRL9u9ga
 fXDaDTErvfBU+n87yoiakcuWxHPTxgVnNESxXv5MBTdMUi+Uus57Nq4fSkC2RYPXY+By
 14a8OGp+AGwBVVPQSTDu2iDJT4r8A+tVcFkpIRP9Dr28p1QdathGO/jkm/VuZVCirTU0
 ROlw==
X-Gm-Message-State: AC+VfDyHgmzA6Dqkyg35qWyl33Lp35I2NiejqFfTgL48cXvgdCIwXyc3
 RyNeydnnZKtwn5qQlplVQtUfnBjXgI+jHIMX
X-Google-Smtp-Source: ACHHUZ7lXc4/8vJ7V723jHNjEFo00sD34psLVyqNRdq34CLlnTJxkn0K3F1E/+vWh5YNR7xMFUb7cQ==
X-Received: by 2002:ac2:520e:0:b0:4f5:fbf6:7de with SMTP id
 a14-20020ac2520e000000b004f5fbf607demr943735lfl.6.1686319787128; 
 Fri, 09 Jun 2023 07:09:47 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.240.245]) by smtp.gmail.com with ESMTPSA id
 y22-20020ac255b6000000b004f1406b059asm552996lfg.219.2023.06.09.07.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 07:09:46 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id 2B60019C2; Fri,  9 Jun 2023 16:09:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686319785; bh=DZ5fMdq9LwskNjWpW+fDBE+ZAvAUizJvqdAFmYrDvXM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ajuqm82uw73JaKXakTxxsdONmJAJBKJoNYqLVlPFfMcYfImd26sDjL/WSmXdemGLd
 pt8wDvHAOHjB1Myf2lUtTNQKgmM90rH7CdbPzdswAxrOwlS9l1YdAEd3LTFUpIGj7t
 B2FQx7fP64e0rrWo0OGssWhY7F51ID7Ioq5qo0Y4=
Received: from x1-carbon.lan (unknown [129.253.182.58])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id 051C41763;
 Fri,  9 Jun 2023 16:09:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686319752; bh=DZ5fMdq9LwskNjWpW+fDBE+ZAvAUizJvqdAFmYrDvXM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=L2UhMoRdTAmrdVe5oc8Bmh56QWN1ff9ovw5DwtbJO5chRA4V74GLNz7v57mu+8IG/
 fLKHvqDyimHTcAVmTMrak8KCpMIin5lyuemBOcuVQ/WhrrE4AG+MFO3viYVBQsng63
 3UUhUrnuH1kpO2PG8UuUAH7BCVh6lXN8ShWFG8VA=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v3 2/8] hw/ide/core: set ERR_STAT in unsupported command
 completion
Date: Fri,  9 Jun 2023 16:08:38 +0200
Message-Id: <20230609140844.202795-3-nks@flawful.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609140844.202795-1-nks@flawful.org>
References: <20230609140844.202795-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=nks.gnu@gmail.com; helo=mail-lf1-x133.google.com
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
---
 hw/ide/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index de48ff9f86..07971c0218 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -533,9 +533,9 @@ BlockAIOCB *ide_issue_trim(
 
 void ide_abort_command(IDEState *s)
 {
-    ide_transfer_stop(s);
     s->status = READY_STAT | ERR_STAT;
     s->error = ABRT_ERR;
+    ide_transfer_stop(s);
 }
 
 static void ide_set_retry(IDEState *s)
-- 
2.40.1


