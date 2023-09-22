Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C0D7AB57E
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 18:06:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjiZI-0001Do-6I; Fri, 22 Sep 2023 11:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=/LOp=FG=kaod.org=clg@ozlabs.org>)
 id 1qjiZE-0001Ab-C6; Fri, 22 Sep 2023 11:59:44 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=/LOp=FG=kaod.org=clg@ozlabs.org>)
 id 1qjiZC-00063y-QV; Fri, 22 Sep 2023 11:59:44 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RscR00zZ5z4x3G;
 Sat, 23 Sep 2023 01:59:40 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RscQy0rdYz4x09;
 Sat, 23 Sep 2023 01:59:37 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 3/4] aspeed/i3c: Rename variable shadowing a local
Date: Fri, 22 Sep 2023 17:59:23 +0200
Message-ID: <20230922155924.1172019-4-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922155924.1172019-1-clg@kaod.org>
References: <20230922155924.1172019-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=/LOp=FG=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

to fix warning :

  ../hw/i3c/aspeed_i3c.c: In function ‘aspeed_i3c_realize’:
  ../hw/i3c/aspeed_i3c.c:1959:17: warning: declaration of ‘dev’ shadows a parameter [-Wshadow=local]
   1959 |         Object *dev = OBJECT(&s->devices[i]);
        |                 ^~~
  ../hw/i3c/aspeed_i3c.c:1942:45: note: shadowed declaration is here
   1942 | static void aspeed_i3c_realize(DeviceState *dev, Error **errp)
        |                                ~~~~~~~~~~~~~^~~

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/misc/aspeed_i3c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/aspeed_i3c.c b/hw/misc/aspeed_i3c.c
index f54f5da522b3..d1ff61767167 100644
--- a/hw/misc/aspeed_i3c.c
+++ b/hw/misc/aspeed_i3c.c
@@ -296,13 +296,13 @@ static void aspeed_i3c_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->iomem_container, 0x0, &s->iomem);
 
     for (i = 0; i < ASPEED_I3C_NR_DEVICES; ++i) {
-        Object *dev = OBJECT(&s->devices[i]);
+        Object *i3c_dev = OBJECT(&s->devices[i]);
 
-        if (!object_property_set_uint(dev, "device-id", i, errp)) {
+        if (!object_property_set_uint(i3c_dev, "device-id", i, errp)) {
             return;
         }
 
-        if (!sysbus_realize(SYS_BUS_DEVICE(dev), errp)) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(i3c_dev), errp)) {
             return;
         }
 
-- 
2.41.0


