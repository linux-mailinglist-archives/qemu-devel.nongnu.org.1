Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B26E57B7A5A
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:41:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxQC-0007Kf-WB; Wed, 04 Oct 2023 04:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxPx-0006q0-5u
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:39:42 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxPr-0007kw-62
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vIBVr7O9C9b85FSdLczRJGzm8rZtijmZ/GEQoWrr164=; b=x2rH3DuDkX2fNihGLbU9SYXaMh
 cnr5uBRlvkSIfwZoXEbH8sK0KBOaIHExs+bc6MeXrNeXCPtwBu0D+U7DjDNGndZ37EVhudUTArMFs
 TiQiRrYsWAyqZ9K0d6KHDtKv/nA1yGO1G0ZxMQ+gsgvSj5WrjhikmPy36OnD6NpVDQU7d5Sb0c6sg
 YyIA1D3kNDkibkJPZIzTlrkDyKKHQCSZExgbo74nKH8t4L2DBuAGWg6L8Q8KaHsefrreRZkOZXyw/
 ISCQFNSoEwKsNPQi0uGiufhKZMgKoUOyjmfiVayp1lmkup4vfMXiLbYdxvC4ybyseM+AjMqPlMz9r
 Z316hzh1pbvBEE7WeBlPabyVRw8f1ELAm7TCvhBffsbbhgI1laXLrXJJ/Iqj8dHYs9wUFXS53z+TF
 Y/bXJRJyanBvDeDzJ+zYL/ISifKdhUrZMKjcrjYq8H8ZMt4wkOxf+nJqeTMlbqb3hYPhPlEjsxlKW
 Vy8J5LvqUJNuKc52ZcVDvbIPgf39O+zGzfCRSXGWvla97zc1cRqN10Dwu8pYtKcF3EwzL5wCF/nss
 8raSBIPL99hK2fySlptufKdc6teuHOO5JcVuEuHhAOu1uMdDBCQbKh18lqcOET9ZibDwq1SZDOeDg
 EXUmSOajiSBi2aZ9s11VmpsL6n9JkeR6jWD0rOaTA=;
Received: from host86-159-123-68.range86-159.btcentralplus.com
 ([86.159.123.68] helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxPR-0006za-VT; Wed, 04 Oct 2023 09:39:14 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed,  4 Oct 2023 09:38:04 +0100
Message-Id: <20231004083806.757242-19-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004083806.757242-1-mark.cave-ayland@ilande.co.uk>
References: <20231004083806.757242-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.159.123.68
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 18/20] q800: add ESCC alias at 0xc000
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Tests on real Q800 hardware show that the ESCC is addressable at multiple locations
within the ESCC memory region - at least 0xc000, 0xc020 (as expected by the MacOS
toolbox ROM) and 0xc040.

All released NetBSD kernels before 10 use the 0xc000 address which causes a fatal
error when running the MacOS booter. Add a single memory region alias at 0xc000
to enable NetBSD kernels to start booting under QEMU.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c         | 6 ++++++
 include/hw/m68k/q800.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index ac3115d328..27a0b3c08a 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -451,6 +451,12 @@ static void q800_machine_init(MachineState *machine)
     memory_region_add_subregion(&m->macio, SCC_BASE - IO_BASE,
                                 sysbus_mmio_get_region(sysbus, 0));
 
+    /* Create alias for NetBSD */
+    memory_region_init_alias(&m->escc_alias, OBJECT(machine), "escc-alias",
+                             sysbus_mmio_get_region(sysbus, 0), 0, 0x8);
+    memory_region_add_subregion(&m->macio, SCC_BASE - IO_BASE - 0x20,
+                                &m->escc_alias);
+
     /* SCSI */
 
     object_initialize_child(OBJECT(machine), "esp", &m->esp,
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index fbaacd88bd..348eaf4703 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -67,6 +67,7 @@ struct Q800MachineState {
     MemoryRegion macio;
     MemoryRegion macio_alias;
     MemoryRegion machine_id;
+    MemoryRegion escc_alias;
 };
 
 #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
-- 
2.39.2


