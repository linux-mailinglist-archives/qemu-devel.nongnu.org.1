Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 603857AB575
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 18:04:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjiZD-00019t-6j; Fri, 22 Sep 2023 11:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=/LOp=FG=kaod.org=clg@ozlabs.org>)
 id 1qjiZA-00018p-QL; Fri, 22 Sep 2023 11:59:40 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=/LOp=FG=kaod.org=clg@ozlabs.org>)
 id 1qjiZ8-00063T-VM; Fri, 22 Sep 2023 11:59:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RscQv0sdCz4wZJ;
 Sat, 23 Sep 2023 01:59:35 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RscQs0bnxz4x3G;
 Sat, 23 Sep 2023 01:59:32 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 1/4] aspeed/i2c: Clean up local variable shadowing
Date: Fri, 22 Sep 2023 17:59:21 +0200
Message-ID: <20230922155924.1172019-2-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922155924.1172019-1-clg@kaod.org>
References: <20230922155924.1172019-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=/LOp=FG=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
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

Remove superfluous local 'data' variable and use the one define at the
top of the routine. This fixes :

  ../hw/i2c/aspeed_i2c.c: In function ‘aspeed_i2c_bus_recv’:
  ../hw/i2c/aspeed_i2c.c:315:17: warning: declaration of ‘data’ shadows a previous local [-Wshadow=compatible-local]
    315 |         uint8_t data;
        |                 ^~~~
  ../hw/i2c/aspeed_i2c.c:288:13: note: shadowed declaration is here
    288 |     uint8_t data;
        |             ^~~~

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/i2c/aspeed_i2c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 7275d40749a9..1037c22b2f79 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -312,7 +312,6 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
         SHARED_ARRAY_FIELD_DP32(bus->regs, reg_pool_ctrl, RX_COUNT, i & 0xff);
         SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, RX_BUFF_EN, 0);
     } else if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, RX_DMA_EN)) {
-        uint8_t data;
         /* In new mode, clear how many bytes we RXed */
         if (aspeed_i2c_is_new_mode(bus->controller)) {
             ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, RX_LEN, 0);
-- 
2.41.0


