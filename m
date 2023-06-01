Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A34BD719EC5
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:49:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4if2-0002zh-W6; Thu, 01 Jun 2023 09:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q4ieK-0001Wq-2m; Thu, 01 Jun 2023 09:47:40 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q4ieH-00004u-Iq; Thu, 01 Jun 2023 09:47:31 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4f4b80bf93aso1059724e87.0; 
 Thu, 01 Jun 2023 06:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685627225; x=1688219225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vpw0xLuydvT7GFr8RIfSnERhs9PDAhGa5JWXYO3jpus=;
 b=ky31UTFqWAmchhdgPFH20hFYC7p6JKXw9qxMQNX292NV5nsJdJKpr0j0KkT/37alo7
 VCap6DY4q45i7wEjSSRRluSlMCCDTHzjSuTCkZ8E2Jbh9bSurVY+uoi919XKSWaaGx8z
 1IawkovElOrJ+WLxZqZSW/4URWMneJL6z12qIlsFdraWrdsIpeVkrzJJ8TOQWI+pVgkq
 +CnQsdV9sgRKDJFtiY4+w2sTChTZ5yCuYzNUNClxlFcxkVHEbuhIyA7s/Yb+t/S7IM1n
 J1Q8WOK7oBNoFD2jNW9q1502JSxEj3dXsc+fhhRikJtjctFfE5AIiqngjxByHqh6zvaw
 CvCw==
X-Gm-Message-State: AC+VfDzWCfPEEySea2lv/2HBG2MepXAEaZ8WEVucVRcbI8YWySVY2XcV
 7tJ+cHGjgGi8RHcXJ1ZMEml66mHuQq7n9h+5
X-Google-Smtp-Source: ACHHUZ5PftWmFiLdgIXZk9KAGRijf23HCno8HFOF81O80BhsfozKdE5yWJ36F9XTBXjhPnuqaWFehw==
X-Received: by 2002:ac2:548e:0:b0:4f4:7afe:c36 with SMTP id
 t14-20020ac2548e000000b004f47afe0c36mr1766690lfk.10.1685627224535; 
 Thu, 01 Jun 2023 06:47:04 -0700 (PDT)
Received: from flawful.org (c-fcf6e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.246.252]) by smtp.gmail.com with ESMTPSA id
 q10-20020ac25a0a000000b004f0199e8770sm1100184lfn.65.2023.06.01.06.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 06:47:04 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id 8E2D64E8; Thu,  1 Jun 2023 15:46:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1685627223; bh=wq7rsN/ynAZulkdl9oezyNlPiXKk6FZZrfXY0CHj0x0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HKekHvV0VbIDRnFD9w2n7wrZMVc6960Sxcdt1pOYEfmij5rrtRtvibw9rW7fjyRG0
 9MrQtszd7OdqA3PNdkDtHbrLsCxj7j82Xf8dClkrwh+rVirhao5p7JQERatd58aSvB
 Ygzm7dBHhthA3tadHA/hL0uquNXfpSeY88ysJo3o=
Received: from x1-carbon.lan (unknown [129.253.182.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id A3160781;
 Thu,  1 Jun 2023 15:45:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1685627157; bh=wq7rsN/ynAZulkdl9oezyNlPiXKk6FZZrfXY0CHj0x0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bKMjdaoculQwaKvSnLZzFSh6s52oB+ycgmva3rXKuySnf7K6NT3UuRDB2HOgnvYt7
 8f8HNmpUdIusJZIwnaN/LGWhivUN3kmuhe+f5PuUE57yi3awQz6T+H0oXi8+4d1/oq
 gIOS57GqTpmD4jI4qHhR10GBWJLF5aEtLobWfoWs=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v2 8/8] hw/ide/ahci: fix broken SError handling
Date: Thu,  1 Jun 2023 15:44:34 +0200
Message-Id: <20230601134434.519805-9-nks@flawful.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601134434.519805-1-nks@flawful.org>
References: <20230601134434.519805-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=nks.gnu@gmail.com; helo=mail-lf1-x134.google.com
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


