Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4593D82B39E
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 18:04:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNyQi-00047P-TS; Thu, 11 Jan 2024 12:01:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNyQU-0003qm-Q6
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:01:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNyQS-0003ZO-7J
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704992458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Q02gRkJO6TAV33QJiNFZq3YjsRE1X+PYnOjPa8di5Q=;
 b=dMXH+AQBPw8tLF+jsp/blq0v8aIjUhppWVCoBIxVS3YDr/lhMdBlPKSohINn3Q1BN50ICv
 GKlrAXcVg8o3rmIlRFi6QDvNRqeWjaFMcIgckvK8+cHUtRihDEu+b8C7cGOsVAiZoLUCdl
 PvhwFj7yTX1kiwXKtfDtZCC9PQH5/hA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-6AZKRmujNLGrjYnD_XECEA-1; Thu,
 11 Jan 2024 12:00:52 -0500
X-MC-Unique: 6AZKRmujNLGrjYnD_XECEA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE68B3816B60;
 Thu, 11 Jan 2024 17:00:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A475C51D5;
 Thu, 11 Jan 2024 17:00:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 01/17] q800: move dp8393x_prom memory region to Q800MachineState
Date: Thu, 11 Jan 2024 18:00:30 +0100
Message-ID: <20240111170047.909117-2-thuth@redhat.com>
In-Reply-To: <20240111170047.909117-1-thuth@redhat.com>
References: <20240111170047.909117-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

There is no need to dynamically allocate the memory region from the heap.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20231227210212.245106-1-mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/m68k/q800.h | 1 +
 hw/m68k/q800.c         | 7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index a9661f65f6..34365c9860 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -55,6 +55,7 @@ struct Q800MachineState {
     MOS6522Q800VIA1State via1;
     MOS6522Q800VIA2State via2;
     dp8393xState dp8393x;
+    MemoryRegion dp8393x_prom;
     ESCCState escc;
     OrIRQState escc_orgate;
     SysBusESPState esp;
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 83d1571d02..b80a3b6d5f 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -253,7 +253,6 @@ static void q800_machine_init(MachineState *machine)
     int bios_size;
     ram_addr_t initrd_base;
     int32_t initrd_size;
-    MemoryRegion *dp8393x_prom = g_new(MemoryRegion, 1);
     uint8_t *prom;
     int i, checksum;
     MacFbMode *macfb_mode;
@@ -406,13 +405,13 @@ static void q800_machine_init(MachineState *machine)
     sysbus_connect_irq(sysbus, 0,
                        qdev_get_gpio_in(DEVICE(&m->glue), GLUE_IRQ_IN_SONIC));
 
-    memory_region_init_rom(dp8393x_prom, NULL, "dp8393x-q800.prom",
+    memory_region_init_rom(&m->dp8393x_prom, NULL, "dp8393x-q800.prom",
                            SONIC_PROM_SIZE, &error_fatal);
     memory_region_add_subregion(get_system_memory(), SONIC_PROM_BASE,
-                                dp8393x_prom);
+                                &m->dp8393x_prom);
 
     /* Add MAC address with valid checksum to PROM */
-    prom = memory_region_get_ram_ptr(dp8393x_prom);
+    prom = memory_region_get_ram_ptr(&m->dp8393x_prom);
     checksum = 0;
     for (i = 0; i < 6; i++) {
         prom[i] = revbit8(nd_table[0].macaddr.a[i]);
-- 
2.43.0


