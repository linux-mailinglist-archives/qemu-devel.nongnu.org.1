Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B68B0B59FC2
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Sep 2025 19:51:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyZp9-0006vh-DG; Tue, 16 Sep 2025 13:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ZKPJaAYKCh8TP6DIUBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--yubinz.bounces.google.com>)
 id 1uyZp2-0006ul-Lz
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:50:32 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ZKPJaAYKCh8TP6DIUBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--yubinz.bounces.google.com>)
 id 1uyZp0-0008AF-Vj
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:50:32 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-2649a245f3fso22520505ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 10:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1758045029; x=1758649829; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=6Ft7L4Z2EsUSuxGgj2z6jlTxTSGTjkZ7LkB40H9DwsI=;
 b=M4bGOUS3ja3sJ2d8jXS5KbKEIkJv23JMxUyb0hK0UD89pVY6zFGZxC9ElJdA98FD0L
 v30djzETAAEkixsJtzQyH6BSkymaUYdkzUQF9F5wM6oKoyoxrLTAXQzqLTAdQQdnJ8dy
 tl1eSErGx4iz1f1ND5mgTB2fdwgcABvob9G+TRO9A6vC13dBbjNgKexGD0fAfN2uxfmY
 UIggxKnfkoxnK3LX7SW63yl+VXvYTxxIf6WKybaKdFwTq8yFUvpsnFlBLufYqJ1Yfb8D
 l5wJozsIkeCageBNG+H3VgGV15f8V79zntVCwaEU+IT6NZ9a61hlVodprb5yvXiTdNpe
 QJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045029; x=1758649829;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Ft7L4Z2EsUSuxGgj2z6jlTxTSGTjkZ7LkB40H9DwsI=;
 b=qm7zBzEp7GVYfcVp38W8Qvye/bK1+bUL1WDMZuYyqAH3lilVbS/6ezpEPAxctcwz+j
 4RMzS8bbu4v9S03OgXAF6Y4Nryu1CuQjH6fGfjDZQTBQPwMbUGeFs1PEUE5gGiMrUyD1
 raezXuA3HI6p4t57zAINCI5qu8toHNLTrPhKuf+7oGVga97o0ck9tW+aMyOUKOJHBuVx
 5dztw4WdAbrhZCv+os0P2E2eqyL95swq1IQN1es6eqDMQXJ3vuta3yljqEBVM821cKjo
 XiHai+7T4XId2v28wLnQ+tmZTbrBlOPwmwa/nQlqVr3wG3IHPBGy8Vvzsvald227g9a5
 5suA==
X-Gm-Message-State: AOJu0YxZQMGhkBvP++7wQOKSTuC4GdxNKzowmBPnKiHCm79Oy5PVf2vX
 H480Cpm4xjNcAoHT+Q639y0Hwf0Ro9B2QzcMfto2oWPtyIN3Xtqrs5f6PG2kiJtquNrj523Rvnn
 pNcAmzpS6w647cVfvXFAr36Z8hXmNDOV5hmyg9LEgm0e+yuejghr51vEdUYKeY+B4Iy9CKr5v11
 Sw22eFKIdwpDcLm8e6BP6GEMUhw7AZeuk0b0w=
X-Google-Smtp-Source: AGHT+IGGTmhB5WvdNp7Lh9h0ygewb/ia2bOMP+X79cL7unGBAnpgp1X2CqrvXK7hgSp9vtoy5lM7VCTzwmQ=
X-Received: from plfu12.prod.google.com ([2002:a17:902:e5cc:b0:234:c104:43f1])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1450:b0:24a:d213:9e74
 with SMTP id d9443c01a7336-25d27929729mr225195515ad.49.1758045028735; Tue, 16
 Sep 2025 10:50:28 -0700 (PDT)
Date: Tue, 16 Sep 2025 17:50:15 +0000
In-Reply-To: <20250916-quanta-q71l-eeproms-v1-0-3648692cc441@google.com>
Mime-Version: 1.0
References: <20250916-quanta-q71l-eeproms-v1-0-3648692cc441@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250916-quanta-q71l-eeproms-v1-1-3648692cc441@google.com>
Subject: [PATCH 1/2] hw/arm: add eeproms to quanta-q7l1 board
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Yubin Zou <yubinz@google.com>, Patrick Venture <venture@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3ZKPJaAYKCh8TP6DIUBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--yubinz.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: Patrick Venture <venture@google.com>

Adds eeprom init for aspeed helper method and adds 24c64 eeproms to the
quanta-q71l bmc board.

Tested: Booted quanta-q71l bmc firmware to userspace.
Signed-off-by: Patrick Venture <venture@google.com>
---
 hw/arm/aspeed.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index c31bbe7701381f6980e874f9fca51805ff9fb9b4..bae59ae7394882e3fc93863049a37ff5a8737ff8 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -561,14 +561,17 @@ static void quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4e);
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4f);
 
-    /* TODO: i2c-1: Add baseboard FRU eeprom@54 24c64 */
-    /* TODO: i2c-1: Add Frontpanel FRU eeprom@57 24c64 */
+    /* Baseboard FRU */
+    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x54, 8192);
+    /* Frontpanel FRU */
+    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x57, 8192);
     /* TODO: Add Memory Riser i2c mux and eeproms. */
 
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9546", 0x74);
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9548", 0x77);
 
-    /* TODO: i2c-3: Add BIOS FRU eeprom@56 24c64 */
+    /* Add BIOS FRU */
+    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 3), 0x56, 8192);
 
     /* i2c-7 */
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "pca9546", 0x70);
@@ -577,8 +580,10 @@ static void quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
     /*        - i2c@2: pmbus@58 */
     /*        - i2c@3: pmbus@59 */
 
-    /* TODO: i2c-7: Add PDB FRU eeprom@52 */
-    /* TODO: i2c-8: Add BMC FRU eeprom@50 */
+    /* PDB FRU */
+    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x52, 8192);
+    /* BMC FRU */
+    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 8), 0x50, 8192);
 }
 
 static void ast2500_evb_i2c_init(AspeedMachineState *bmc)

-- 
2.51.0.384.g4c02a37b29-goog


