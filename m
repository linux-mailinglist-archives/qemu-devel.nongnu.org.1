Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1883E7C5508
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:14:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZ1v-0000bK-Ix; Wed, 11 Oct 2023 09:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1qqZ1X-0000Y5-T1; Wed, 11 Oct 2023 09:13:15 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1qqZ1S-0001zi-Jp; Wed, 11 Oct 2023 09:13:14 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2b9c907bc68so79042171fa.2; 
 Wed, 11 Oct 2023 06:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697029988; x=1697634788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:dkim-signature:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5mwzT1dV+YP3RIHIShKUzgHG1gg00ryLyiH2+tisJ9g=;
 b=ZmGpUIBJF5TeTHOGRuofCBdfMOTjoQWyBb0F1RxNQqWQEorjOt9Ydf4ZOnOsqrlCQW
 Waw3kRHwlfZ7pRkXPMriC6DtkoKYs98e1B15LtMaR1Np/NVDHUtWxO3SIECySk04mTPY
 /ilkdSnMu56sRSjA4A/PWD++dNuxNuuW/bmyWmac6mV7rcyeZkfjRdjOO86ybrrcuvrU
 U5x+h1pj5GVmzrQLcHW0S/9f+7Adqbix+4TIBrLQAOUwW5hE50rGYWK/7ht68hd6Qthz
 ZAcimHSrdoj7olfSpn640wzsu3/2p2TvbR2yoo0+wjo/ZQyQnD9DX7uMZjActs8A9Brg
 1hJw==
X-Gm-Message-State: AOJu0YxS+YBEfvOca8MSKVXrklXyZGeWVtMR3hdkHxhJdgqB4MoHoUeD
 oh0TfNZ/qHfcrtDrfY/iJ7cP+uO9fX7Vqg==
X-Google-Smtp-Source: AGHT+IGSO73/cRX9gOJHu0kfwj34nfUySmiX48Ym8qC1V/vjKd0CQcms9WBMAvUyydZws7DtCnulCQ==
X-Received: by 2002:a2e:824c:0:b0:2c0:afd:e7ed with SMTP id
 j12-20020a2e824c000000b002c00afde7edmr17063287ljh.10.1697029987845; 
 Wed, 11 Oct 2023 06:13:07 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.240.245]) by smtp.gmail.com with ESMTPSA id
 e17-20020a2e8ed1000000b002c128e45245sm2985660ljl.23.2023.10.11.06.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 06:13:07 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id 845EAA80; Wed, 11 Oct 2023 15:13:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1697029986; bh=F3oQPhMsKR40wMr+CadOwsJ3tRh25XuZhDfZ/k/ChV0=;
 h=From:To:Cc:Subject:Date:From;
 b=WOPOdOdfEHZhW0Z4cbVkziSjoXQE7ib64p6ypTfZNdVKe6Zayd2i3BV0pBvv1unsT
 6WcRGZSFnCkzkKvIQD4zM3pOH6cngjslQmJ+FM8eFk/8JX2TATDjr1d5w3cAL/h6bB
 poz7EQqq9EsZQ9TYeJSWPYbgOuKTg4/aDKX0WWq4=
Received: from x1-carbon.lan (OpenWrt.lan [192.168.1.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id 52ED1A86;
 Wed, 11 Oct 2023 15:12:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1697029975; bh=F3oQPhMsKR40wMr+CadOwsJ3tRh25XuZhDfZ/k/ChV0=;
 h=From:To:Cc:Subject:Date:From;
 b=GgYe8rZHT6Rs0Uibtc3+YPIRjaAZdwhnTBktHDiV2ilj6QJsWQLjuNIl15XbYr+yy
 QskYj6Ktekv+ejeycEaEMGFVTzORyb0ikbVgbZJMHm+e6i1xpNUPtsfHMhuOwKPKMl
 v67ODL+uZxb7j43pJA7+xIC0FW0cuZDSxJR+7Xy0=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH] hw/ide/ahci: trigger either error IRQ or regular IRQ, not both
Date: Wed, 11 Oct 2023 15:12:20 +0200
Message-ID: <20231011131220.1992064-1-nks@flawful.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=nks.gnu@gmail.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

According to AHCI 1.3.1, 5.3.8.1 RegFIS:Entry, if ERR_STAT is set,
we jump to state ERR:FatalTaskfile, which will raise a TFES IRQ
unconditionally, regardless if the I bit is set in the FIS or not.

Thus, we should never raise a normal IRQ after having sent an error
IRQ.

NOTE: for QEMU platforms that use SeaBIOS, this patch depends on QEMU
commit 784155cdcb02 ("seabios: update submodule to git snapshot"), and
QEMU commit 14f5a7bae4cb ("seabios: update binaries to git snapshot").

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 hw/ide/ahci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index fcc5476e9e..7676e2d871 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -897,11 +897,10 @@ static bool ahci_write_fis_d2h(AHCIDevice *ad, bool d2h_fis_i)
     pr->tfdata = (ad->port.ifs[0].error << 8) |
         ad->port.ifs[0].status;
 
+    /* TFES IRQ is always raised if ERR_STAT is set, regardless of I bit. */
     if (d2h_fis[2] & ERR_STAT) {
         ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_TFES);
-    }
-
-    if (d2h_fis_i) {
+    } else if (d2h_fis_i) {
         ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_DHRS);
     }
 
-- 
2.41.0


