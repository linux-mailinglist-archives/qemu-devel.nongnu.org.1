Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBB1729EEE
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 17:44:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7cph-000439-QF; Fri, 09 Jun 2023 10:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7cpf-0003uk-KA; Fri, 09 Jun 2023 10:11:15 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7cpd-0000h8-UF; Fri, 09 Jun 2023 10:11:15 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2b1aecef94fso19967221fa.3; 
 Fri, 09 Jun 2023 07:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686319870; x=1688911870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vpw0xLuydvT7GFr8RIfSnERhs9PDAhGa5JWXYO3jpus=;
 b=UIOwuwZhErCneu5quKb9AJV/VDaZZ3fuDcai4rDM+Arcl8BTAXrYnjc3IUHju05mAu
 y2e5C+yJjuU62m8n08g281YQ2AOdHzfVd/P8Gwa0kI694k/v+z5o7wRYbsOGu21kcmcy
 jGfGkD1/ok/zYLTsgbs+fmaRbXIkIg+BT0D8A8FRq27N1sLuCS+m8Sup/f6re0LByE0/
 Rcprg3ugGZgmXDMjZ0PNjpzlFuPRYsnOB4LKCKBvekQcF3w7GIj6ns0QoODhwBWVJYTT
 /syX3kZFJux+mow3Hjit92VtB48XJQNkhXxNMczlbqBqDWOgZ8sOHP4cZmArxv0SigXT
 7O2A==
X-Gm-Message-State: AC+VfDxLnypWLrw5dyFq+3gyJaB4zUCbJrJ96cmYwcbMrKkpyP6W3c6B
 FVc6u4w1kJNpRnyCxn/9T6g6Udff9uMA/uym
X-Google-Smtp-Source: ACHHUZ7XrVyNzOqZ6E+NvIzKIT6PgWoWIvWZbizLuwbfr4mI5gkvw1xyHF7U424VxeKOZ4/HlcUkMw==
X-Received: by 2002:a2e:9256:0:b0:2b1:e6eb:1bbc with SMTP id
 v22-20020a2e9256000000b002b1e6eb1bbcmr1001157ljg.32.1686319870522; 
 Fri, 09 Jun 2023 07:11:10 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.240.245]) by smtp.gmail.com with ESMTPSA id
 s4-20020a2e98c4000000b002b1a8e9d728sm396323ljj.64.2023.06.09.07.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 07:11:10 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id 51A811763; Fri,  9 Jun 2023 16:11:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686319869; bh=wq7rsN/ynAZulkdl9oezyNlPiXKk6FZZrfXY0CHj0x0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=reUXXUrSEy1F7XcCoWqS8dS+3n216HXp2NASLFTFrBPSlhan89nmM8RdB3HgAOMZe
 OaMj75usJqs+xJ88d5NBSvrMDUhazFVrj+7mp63AqbjJ4SAyeQL1CrrfL8y0vgJqm6
 duhSxKvfeDk4h7E6IREyldZPm7PZ1DSUqXoGhYPo=
Received: from x1-carbon.lan (unknown [129.253.182.58])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id E6CDE1746;
 Fri,  9 Jun 2023 16:09:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686319791; bh=wq7rsN/ynAZulkdl9oezyNlPiXKk6FZZrfXY0CHj0x0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=usYoMw5F+2178HSpbL+VV0Pn+z56UYzCB3hLKeDaVbIcH0e6mSPcPChn195+Dx041
 8TOhqV3Cb3k7LWwNkWQKkJCFpSs8iQoq2aIPhCnK0NSOaI654acxyMQMe3VyiU/Ggh
 NFK/PX9NSuocIfewZVu6vsRmsG51rUtBmjhKGcoQ=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v3 8/8] hw/ide/ahci: fix broken SError handling
Date: Fri,  9 Jun 2023 16:08:44 +0200
Message-Id: <20230609140844.202795-9-nks@flawful.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609140844.202795-1-nks@flawful.org>
References: <20230609140844.202795-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=nks.gnu@gmail.com; helo=mail-lj1-x22d.google.com
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
---
 hw/ide/ahci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

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
2.40.1


