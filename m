Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 340A27CE93C
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 22:42:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtDLc-0007Aa-AA; Wed, 18 Oct 2023 16:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qtDLa-000798-9g
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 16:40:54 -0400
Received: from ams.source.kernel.org ([145.40.68.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qtDLV-0000zh-PF
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 16:40:54 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 91841B8236E;
 Wed, 18 Oct 2023 20:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECB8C433CB;
 Wed, 18 Oct 2023 20:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697661638;
 bh=K3xSc/7RTRI4DvpjgVUNFVWoF5tBPp4AfN8pButzZZs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cTwak13tCut+sbUxjJn2w4mV4BTktbTdINR5Rp6wE+8CyqNCfaUM5gZwNOUESVyrc
 SSoa63Ja2Owm9KT2628qoLAa7bzziMhzsIZzvxqodh90LhSptmqihn03QI/4CqrmnS
 XDnupMtU/HLWuNFZ2aqITzrKJfxyLlU3UimzR01P5N8Hvdazy5wtd4YVKTHy0QFwaO
 8B6AdBmtuDTAWVUAvU+GJrR+MhFzHs8H1M3xFjwEYYD/xADZSpXbtl4jGoDGpPX4ci
 rxLWDn0Z34+YEg9BVw41JT9IoKLi1nzzL9BblnTqrGWdkGvaTnkk4g+nL6xGxGe6X+
 KLofESttxJDWw==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 02/11] hw/hppa: Require at least SeaBIOS-hppa version 10
Date: Wed, 18 Oct 2023 22:40:21 +0200
Message-ID: <20231018204030.391572-3-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018204030.391572-1-deller@kernel.org>
References: <20231018204030.391572-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.68.75; envelope-from=deller@kernel.org;
 helo=ams.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

The new SeaBIOS-hppa version 10 includes initial support
for PA2.0 CPUs.
Additionally update copyright and drop commented-out code.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index cf28cb9586..c6d8deffcf 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -1,6 +1,8 @@
 /*
  * QEMU HPPA hardware system emulator.
- * Copyright 2018 Helge Deller <deller@gmx.de>
+ * (C) Copyright 2018-2023 Helge Deller <deller@gmx.de>
+ *
+ * This work is licensed under the GNU GPL license version 2 or later.
  */
 
 #include "qemu/osdep.h"
@@ -29,7 +31,7 @@
 #include "net/net.h"
 #include "qemu/log.h"
 
-#define MIN_SEABIOS_HPPA_VERSION 6 /* require at least this fw version */
+#define MIN_SEABIOS_HPPA_VERSION 10 /* require at least this fw version */
 
 #define HPA_POWER_BUTTON (FIRMWARE_END - 0x10)
 
@@ -95,9 +97,7 @@ static ISABus *hppa_isa_bus(void)
 
     isa_bus = isa_bus_new(NULL, get_system_memory(), isa_region,
                           &error_abort);
-    isa_irqs = i8259_init(isa_bus,
-                          /* qemu_allocate_irq(dino_set_isa_irq, s, 0)); */
-                          NULL);
+    isa_irqs = i8259_init(isa_bus, NULL);
     isa_bus_register_input_irqs(isa_bus, isa_irqs);
 
     return isa_bus;
-- 
2.41.0


