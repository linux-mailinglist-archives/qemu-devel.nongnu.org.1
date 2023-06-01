Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FF3719EC6
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:49:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4iec-000243-Fi; Thu, 01 Jun 2023 09:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q4ieH-0001Wg-Dn; Thu, 01 Jun 2023 09:47:40 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q4idp-0008QV-RD; Thu, 01 Jun 2023 09:47:20 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4f3b9c88af8so1065814e87.2; 
 Thu, 01 Jun 2023 06:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685627213; x=1688219213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PVw/nyOLjJlLuDJ2e/yg0k3IjWpVDFSyPCJAnZ8lUhs=;
 b=LXn/3w+zzf9b1d3FsuchT0HwxFZoCk+f9tvO6llHJh1LeR6jTnkJ7IDIUYy+RK+qlF
 c8MeZZk9DEp8UQsYjbqmra4JjFYM58VsGDc5gBNPtR9VOyOWq+lB823f2LfO0CprwqmT
 fs/pkcGJIUrfiCeGZqYeOKjVBDbslJvBkJrMN7atUlfJteXCoq+CBergkAlTDbA/6c7z
 fx//EdJqBRyqbEROvNacLfpGqXEiamdCdlNE41Ja0qYPCRWwyQ5nqXt+Aztx+fcqd8uH
 eTX7BuahSy/PsvXBKZFTcYksvT/hDHVod+6VDxxlHi0kQ7/UB8TYwspSlCEMMUB+OONO
 PZQg==
X-Gm-Message-State: AC+VfDyhvJ0zoabIUDtn5dLYbubtPEjXgOSfVKsJfvW2WL/DqpVG8cp2
 t13JplBkVeEjcmahZe7Op1GNOnFT8kf3K3cd
X-Google-Smtp-Source: ACHHUZ6m0LCf9l97hgbWzbVXGu/53nZM5uKrsrsM0+E0HKClDMULEmIKZTR77tULbG62VyGXb+27jA==
X-Received: by 2002:ac2:5318:0:b0:4f5:bc19:68dd with SMTP id
 c24-20020ac25318000000b004f5bc1968ddmr1532607lfh.53.1685627213372; 
 Thu, 01 Jun 2023 06:46:53 -0700 (PDT)
Received: from flawful.org (c-fcf6e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.246.252]) by smtp.gmail.com with ESMTPSA id
 q6-20020ac25106000000b004eb0dcc52ddsm1098438lfb.41.2023.06.01.06.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 06:46:53 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id AC0427A7; Thu,  1 Jun 2023 15:46:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1685627211; bh=EJ3qj6IemNXqj29g+yvQ2KmLufYZrgZ147654xg75oY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WJIeAxeD4PwkW8A8K5VGpwGx2Zl9ptTiQVrcJI+HyPfZfNI0xDqcSnRVfV9KN2ceX
 Nmec7L4xWyHFKC1VShRSMyFN7Y81ukw28o4DwhVkLGKIY87ydHqN6GfVw8kytLc0qt
 phvmtz4sqeZZDD5+4Qx9XuqzGxwryR2sJNw+RVCo=
Received: from x1-carbon.lan (unknown [129.253.182.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id 720844C9;
 Thu,  1 Jun 2023 15:45:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1685627150; bh=EJ3qj6IemNXqj29g+yvQ2KmLufYZrgZ147654xg75oY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tr8PWKgmftRlRQnlFWGLQjJbWh88zs8pLCUOSQKnoxcRQFikxhYXvgfbU86jyYdC8
 3Xxgc+psqqYBqX09t/IB6xEHCRicb0VuMLdPdo8WoCVv3OTVZV1059v8EeQOQzKoaY
 KARb98eKUf/TBJqvSrzUzFq0dKGsYFVDHFaKeQbQ=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v2 7/8] hw/ide/ahci: fix ahci_write_fis_sdb()
Date: Thu,  1 Jun 2023 15:44:33 +0200
Message-Id: <20230601134434.519805-8-nks@flawful.org>
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


