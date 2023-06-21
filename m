Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C9F737DD7
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:55:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBtbw-0001zP-9T; Wed, 21 Jun 2023 04:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbt-0001z1-U0
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:54:41 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbs-0004Wd-Cs
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G5t5ipRhnuU7HWC3tuyTy5Ua/29wM49HI5NqUNxvl9o=; b=IMStdqkDFjQwq1skdYU34M0Yqp
 zKkFmQv3HHzNE41nYqcZlO3t6Sdewp8RNWPiX9gpNdeOO7aKHrsphSolBIyMtiRhVMnt6WRV0sJez
 DeA5pZRve5NjtafWiZaJsQgJk8rSOEsinwY0hZPD46qDdrKMeX7NrBtMbNYZuyycUdJoVBdXp+o4o
 6XbvXxRxgCPDMT6juIHUvHFR5Tz0LwQ12PQIFXavdRlOEX0JA+zsI8MgfoBh+j5i/RLfEKF8FpQme
 wwYUfp4vxdg7+BpDbgmD7gq71AMrm55OEdx/Zap7+xhcaigMAqLFVryhMsrqM7Yl3pmNHr9x8imXc
 445qzTRNAUXitOh1pmssYIX75puoFTcWKCJ1drfwoIXu+sfTIznq9777OIvkQYgV+qoNKw2zcKpIZ
 Za0tEJx8gNrBnUTKN4+HHjIJNc7rfxyyI1kNnQTSxSwaoqqzOKv+ypdxUAl/CXyL8+8ubxUxPDLhv
 qVDHubtmvUOrvi658IexKmwPSdalB5nJKGQQzi1mY/s+nFRL5evGmQuDNdKKIhxGtjYKvFJCRhb0h
 AKjgELTc59HrPe2sqIX5w5I/rujlOD7RxCX+SAE8vNOBpLBC0qhUFRlheCwpxSlibtg8OhonDqHLN
 EXXHiG2j8nG15FkBZRjTaVFZdcW9rn7aruusqk9WE=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbg-0001ZB-Qn; Wed, 21 Jun 2023 09:54:32 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 21 Jun 2023 09:53:39 +0100
Message-Id: <20230621085353.113233-11-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 10/24] q800: introduce mac-io container memory region
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Move all devices from the IO region to within the container in preparation
for updating the IO aliasing mechanism.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/q800.c         | 6 ++++++
 include/hw/m68k/q800.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 505e50d4af..359bdf3443 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -177,6 +177,12 @@ static void q800_machine_init(MachineState *machine)
     /* RAM */
     memory_region_add_subregion(get_system_memory(), 0, machine->ram);
 
+    /*
+     * Create container for all IO devices
+     */
+    memory_region_init(&m->macio, OBJECT(machine), "mac-io", IO_SLICE);
+    memory_region_add_subregion(get_system_memory(), IO_BASE, &m->macio);
+
     /*
      * Memory from IO_BASE to IO_BASE + IO_SLICE is repeated
      * from IO_BASE + IO_SLICE to IO_BASE + IO_SIZE
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index fda42e0a1c..17067dfad7 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -39,6 +39,7 @@ struct Q800MachineState {
     M68kCPU cpu;
     MemoryRegion rom;
     GLUEState glue;
+    MemoryRegion macio;
 };
 
 #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
-- 
2.30.2


