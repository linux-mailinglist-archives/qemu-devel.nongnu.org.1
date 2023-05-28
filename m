Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 736007139CA
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 15:59:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3GuH-0007q7-9x; Sun, 28 May 2023 09:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3GuE-0007oi-Vz
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:57:59 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3Gu9-00009k-N8
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:57:58 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 757D374638A;
 Sun, 28 May 2023 15:57:50 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4145574633D; Sun, 28 May 2023 15:57:50 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] hw/acpi: Fix PM control register access
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael S. Tsirkin <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Message-Id: <20230528135750.4145574633D@zero.eik.bme.hu>
Date: Sun, 28 May 2023 15:57:50 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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


On pegasos2 which has ACPI as part of VT8231 south bridge the board
firmware writes PM control register by accessing the second byte so
addr will be 1. This wasn't handled correctly and the write went to
addr 0 instead. This fixes ACPI shutdown with pegasos2 firmware.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
This is replacing the previous attempt which changed enduanness to
NATIVE_ENDIAN that was found to be wrong. I'm still not sure what's
happening as these functions are called with addr = 1 and size = 2 but
maybe the guest really does word access to addr 1 when wanting to
write 1 byte. This fixes the problem and should not break anything
else but please review.

 hw/acpi/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 6da275c599..bbc599a252 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -593,13 +593,13 @@ void acpi_pm1_cnt_update(ACPIREGS *ar,
 static uint64_t acpi_pm_cnt_read(void *opaque, hwaddr addr, unsigned width)
 {
     ACPIREGS *ar = opaque;
-    return ar->pm1.cnt.cnt;
+    return ar->pm1.cnt.cnt >> addr * 8;
 }
 
 static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
                               unsigned width)
 {
-    acpi_pm1_cnt_write(opaque, val);
+    acpi_pm1_cnt_write(opaque, val << addr * 8);
 }
 
 static const MemoryRegionOps acpi_pm_cnt_ops = {
-- 
2.30.9


