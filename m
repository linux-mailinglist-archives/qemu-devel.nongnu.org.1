Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C45C87B2E83
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:55:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Do-0005Kk-GZ; Fri, 29 Sep 2023 04:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9Dj-0005Gr-6i
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.145.221.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DE-0005dq-Tl
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c2D2N7WlErJVlyiWJzSeQqa76674rJVo9x5Y5NUFAJc=;
 b=b+ptWj0lRnzvVKtV4HZKlAZs7V69E0aaY0p4mk+RA7Geq3cM2gL0O+Ld/DTmQ+cnyBgGyh
 hsio3mbDZBMMn0Su59yDyxmalpzU6Sjv/C5kowARpwEVqAdaNhDp0AZ0ANRiEIiR1ZG95K
 Cc70FoMXzHwTwU3Sd3aZ5JGEfNtJydw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-XnElkFbCMbKUYbTzkhwo2A-1; Fri, 29 Sep 2023 04:50:58 -0400
X-MC-Unique: XnElkFbCMbKUYbTzkhwo2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2ACB1803DBD;
 Fri, 29 Sep 2023 08:50:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08BEA10F1BE8;
 Fri, 29 Sep 2023 08:50:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D16A921E68A0; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>
Subject: [PULL 43/56] aspeed/i2c: Clean up local variable shadowing
Date: Fri, 29 Sep 2023 10:50:40 +0200
Message-ID: <20230929085053.2789105-44-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=216.145.221.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Cédric Le Goater <clg@kaod.org>

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
Message-ID: <20230922155924.1172019-2-clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/i2c/aspeed_i2c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 7275d40749..1037c22b2f 100644
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


