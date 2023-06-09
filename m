Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AED7C729F88
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 18:02:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7cpd-0003dU-PB; Fri, 09 Jun 2023 10:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7cpN-0003Mj-8X; Fri, 09 Jun 2023 10:10:58 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7cpJ-0000er-4U; Fri, 09 Jun 2023 10:10:56 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4f6370ddd27so2287320e87.0; 
 Fri, 09 Jun 2023 07:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686319851; x=1688911851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PVw/nyOLjJlLuDJ2e/yg0k3IjWpVDFSyPCJAnZ8lUhs=;
 b=SOGW5HwoE6nkueX2d9wdpNNlmlqxmLS4ITX+frV+yjwyuRhgWz0rxHfxjZfG/4+j/z
 HigFPybM7W+rY4wn88HnAUjgsp8ADftByCE7p471kip+1C19NlacWeUygSlgLcV8bnqi
 rnNZZsGRs8GXoFrL9prtNPpu6x+n50bT7QXa1Pm+DbdPawupXn//WQ1mQbL5FHJcwIXi
 +MJQpTEYAKiWcBCV+hM8wNZgHm0VyghRbBcDJopL66ztKJQ8VHke59lqiD5K6EuDJLgI
 cjcSjUeejojo43sASxAExDo+e1mzm0xzC8wwdQGJt7YdtBv26WD6+QK51JGH77IOF8Jr
 yx9A==
X-Gm-Message-State: AC+VfDx4k4k+y9yVAkRDxQFV1JQFZINr2HJXlQYKh52218LGx29Vam+r
 AUf7IOUPIIOTAMyCYgiiotXMKeLH3qXzION1
X-Google-Smtp-Source: ACHHUZ6Jk2aWM8GegvH70eJVpQ96V0lUHvi2o9+Xo7dRblieYOleCDw+nbb5kOfx5inZLjowrWf2sg==
X-Received: by 2002:ac2:4db2:0:b0:4f4:d83e:4140 with SMTP id
 h18-20020ac24db2000000b004f4d83e4140mr1007070lfe.34.1686319850882; 
 Fri, 09 Jun 2023 07:10:50 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.240.245]) by smtp.gmail.com with ESMTPSA id
 u5-20020ac248a5000000b004f5a548820asm554580lfg.156.2023.06.09.07.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 07:10:50 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id 327A319A5; Fri,  9 Jun 2023 16:10:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686319849; bh=EJ3qj6IemNXqj29g+yvQ2KmLufYZrgZ147654xg75oY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SVR84AatxXa8T6LTcHrRblIsdsyhl8qaTap78iLaasV5TkvUzm8T92LtUsI2NUN5T
 I6BaezhnNkY6abOr0Mba75aD2F5CaYuzP/uWiz1Txkof01mdtOZ5kEGwmoM1UKCTVd
 6KwN/CzBcGT6wrPbxnIHspFRgxHLF2iQyeLQFsSY=
Received: from x1-carbon.lan (unknown [129.253.182.58])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id 646001A81;
 Fri,  9 Jun 2023 16:09:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686319786; bh=EJ3qj6IemNXqj29g+yvQ2KmLufYZrgZ147654xg75oY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DdYRO2HMw2nuQPRgTOhKOfXMzg2ZBXJ9k7NVUn7zWIOwKI9NmUxVxox2Plk+yyweF
 jI45ZXIwHCK6t7b2Ov2m3pooYIwcyNPQq3JayNCuATbdDFRYbF5e+sN8y6g2t/8Qx8
 Lh6B7/g6KlocKBb2/g5XEjGx45rpFrdBDbLE0sYg=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v3 7/8] hw/ide/ahci: fix ahci_write_fis_sdb()
Date: Fri,  9 Jun 2023 16:08:43 +0200
Message-Id: <20230609140844.202795-8-nks@flawful.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609140844.202795-1-nks@flawful.org>
References: <20230609140844.202795-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=nks.gnu@gmail.com; helo=mail-lf1-x131.google.com
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

When there is an error, we need to raise a TFES error irq, see AHCI 1.3.1,
5.3.13.1 SDB:Entry.

If ERR_STAT is set, we jump to state ERR:FatalTaskfile, which will raise
a TFES IRQ unconditionally, regardless if the I bit is set in the FIS or
not.

Thus, we should never raise a normal IRQ after having sent an error IRQ.

It is valid to signal successfully completed commands as finished in the
same SDB FIS that generates the error IRQ. The important thing is that
commands that did not complete successfully (e.g. commands that were
aborted, do not get the finished bit set).

Before this commit, there was never a TFES IRQ raised on NCQ error.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 hw/ide/ahci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 12aaadc554..ef6c9fc378 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -806,8 +806,14 @@ static void ahci_write_fis_sdb(AHCIState *s, NCQTransferState *ncq_tfs)
     pr->scr_act &= ~ad->finished;
     ad->finished = 0;
 
-    /* Trigger IRQ if interrupt bit is set (which currently, it always is) */
-    if (sdb_fis->flags & 0x40) {
+    /*
+     * TFES IRQ is always raised if ERR_STAT is set, regardless of I bit.
+     * If ERR_STAT is not set, trigger SDBS IRQ if interrupt bit is set
+     * (which currently, it always is).
+     */
+    if (sdb_fis->status & ERR_STAT) {
+        ahci_trigger_irq(s, ad, AHCI_PORT_IRQ_BIT_TFES);
+    } else if (sdb_fis->flags & 0x40) {
         ahci_trigger_irq(s, ad, AHCI_PORT_IRQ_BIT_SDBS);
     }
 }
-- 
2.40.1


