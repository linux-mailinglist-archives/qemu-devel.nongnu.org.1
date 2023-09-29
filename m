Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD8D7B2EA9
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:57:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9DX-00053D-5X; Fri, 29 Sep 2023 04:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DK-0004xL-6U
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DA-0005bd-Dy
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oTfBkhZ+AkKmfYBoreBoF3jgEy3JllYH6NEQgZ8yaMM=;
 b=Aq1osLUdM5pkvmOJs1uN4JEbgeajWZa5pIHjJEuyQWhlqncZKTR9pcem2f9Tsh7XiN9RgQ
 4i1PUiSzoVhCdIPW7hzOQEVwJwZCyrYSR4QP17Q0tVWUt2PiwMMzjuBogbAjJC7vnnsKkh
 NyHD95UxXnUviqeCFL/+HxS05ZGtIo8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-u7304ZHvO2OA3DKAAeGKlA-1; Fri, 29 Sep 2023 04:50:57 -0400
X-MC-Unique: u7304ZHvO2OA3DKAAeGKlA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 987B03C025C7;
 Fri, 29 Sep 2023 08:50:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7661540C6EC0;
 Fri, 29 Sep 2023 08:50:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8682421E6883; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/56] hw/nios2: Clean up local variable shadowing
Date: Fri, 29 Sep 2023 10:50:16 +0200
Message-ID: <20230929085053.2789105-20-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Fix:

  hw/nios2/10m50_devboard.c: In function ‘nios2_10m50_ghrd_init’:
  hw/nios2/10m50_devboard.c:101:22: warning: declaration of ‘dev’ shadows a previous local [-Wshadow=compatible-local]
    101 |         DeviceState *dev = qdev_new(TYPE_NIOS2_VIC);
        |                      ^~~
  hw/nios2/10m50_devboard.c:60:18: note: shadowed declaration is here
     60 |     DeviceState *dev;
        |                  ^~~

  hw/nios2/10m50_devboard.c:110:18: warning: declaration of ‘i’ shadows a previous local [-Wshadow=compatible-local]
    110 |         for (int i = 0; i < 32; i++) {
        |                  ^
  hw/nios2/10m50_devboard.c:67:9: note: shadowed declaration is here
     67 |     int i;
        |         ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904161235.84651-15-philmd@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/nios2/10m50_devboard.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
index 91383fb097..952a0dc33e 100644
--- a/hw/nios2/10m50_devboard.c
+++ b/hw/nios2/10m50_devboard.c
@@ -98,7 +98,7 @@ static void nios2_10m50_ghrd_init(MachineState *machine)
     qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
 
     if (nms->vic) {
-        DeviceState *dev = qdev_new(TYPE_NIOS2_VIC);
+        dev = qdev_new(TYPE_NIOS2_VIC);
         MemoryRegion *dev_mr;
         qemu_irq cpu_irq;
 
@@ -107,7 +107,7 @@ static void nios2_10m50_ghrd_init(MachineState *machine)
 
         cpu_irq = qdev_get_gpio_in_named(DEVICE(cpu), "EIC", 0);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irq);
-        for (int i = 0; i < 32; i++) {
+        for (i = 0; i < 32; i++) {
             irq[i] = qdev_get_gpio_in(dev, i);
         }
 
-- 
2.41.0


