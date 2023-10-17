Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAF17CC7E0
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:48:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsmHm-00060a-Ug; Tue, 17 Oct 2023 11:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qsmHj-00060K-Dl
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:47:07 -0400
Received: from ams.source.kernel.org ([145.40.68.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qsmHh-00035T-Sw
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:47:07 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 9B494B81EBE;
 Tue, 17 Oct 2023 15:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4092C433C8;
 Tue, 17 Oct 2023 15:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697557623;
 bh=K3xSc/7RTRI4DvpjgVUNFVWoF5tBPp4AfN8pButzZZs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TvnGV4GhO+BbDwjYH5SB9GsWex8DmRrxGzU6s5bLY+l/FCbuNnePGtv8NsU/4skES
 oh3lyWWcRYFMsJV8t9gy+LU8xzQ48S6GHL9LgQEwbsvIdfxX/nr97/W5769BBdAwmj
 n0eb8zdIY697xPbmks67+z16/sq828criB0Gt741vuaRwajWXNE8QbIWSOKt8wndnk
 dEHw0tET0tMvqLNixIAXclxiS7g61OCxqpY+k3JZJVldpFSNy7IEvYJEJtJ9cfvRne
 qyuPFwtFCZneaEgsUsiAiQyk25PFlfMy6tTI+eWJ/F6KPtk64NT+X7dvhORA8d+WiK
 TtusKFNtcxf2w==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Helge Deller <deller@gmx.de>
Subject: [PATCH v2 07/11] hw/hppa: Require at least SeaBIOS-hppa version 10
Date: Tue, 17 Oct 2023 17:46:41 +0200
Message-ID: <20231017154645.95844-8-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017154645.95844-1-deller@kernel.org>
References: <20231017154645.95844-1-deller@kernel.org>
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


