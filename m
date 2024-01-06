Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AD9826104
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 19:16:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMBCU-0006PD-S0; Sat, 06 Jan 2024 13:15:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rMBCR-0006MG-Md; Sat, 06 Jan 2024 13:15:11 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rMBCP-0001vz-S1; Sat, 06 Jan 2024 13:15:11 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by zoidberg.rfc1149.net (Postfix) with ESMTPSA id 6152A80027;
 Sat,  6 Jan 2024 19:15:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rfc1149.net; s=smtp;
 t=1704564904; bh=oUHxTnxbJvmbEvqdnnqwZEZn9kWgtC+tyGXnlDxve3k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=yLEYvFldTrVhoUyXhSBunjIXabEi7otSSKeJUDbtwa67DXed7zA3oked6YwF8Q35O
 3TvznjLfB02ciVDDx+fvglBOxguG0hlslc0yQbl6ZGfohjFi4HEJP0YIsRHtLrM/63
 TY3Xg43Ou9ig3NmXs4OVZt7zfHaCJ1FNeWtBBPaLTMwBbHk/gmSfVYMxmixBbi8B8H
 DYreBykkpctFN36ccDsdzuGE0Wlp+VzMWKgV7x/KvPlcJXaHkyCofaSUfOKspN1DrB
 bdb+lfVtWqyU2rN0+NXtwH4UdGHeDAEX+H2fMd11VcTyKy1Mql7MG4rIyLNRgnBzlu
 50YFwaTIcFaoQ==
From: Samuel Tardieu <sam@rfc1149.net>
To: qemu-devel@nongnu.org
Cc: Anton Kochkov <anton.kochkov@proton.me>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Samuel Tardieu <sam@rfc1149.net>
Subject: [PATCH v3 2/3] hw/arm/armv7m: alias the NVIC "num-prio-bits" property
Date: Sat,  6 Jan 2024 19:15:02 +0100
Message-ID: <20240106181503.1746200-3-sam@rfc1149.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240106181503.1746200-1-sam@rfc1149.net>
References: <20240106181503.1746200-1-sam@rfc1149.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.154.227.159; envelope-from=sam@rfc1149.net;
 helo=zoidberg.rfc1149.net
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

A SoC will not have a direct access to the NVIC embedded in its ARM
core. By aliasing the "num-prio-bits" property similarly to what is
done for the "num-irq" one, a SoC can easily configure it on its
armv7m instance.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/armv7m.c         | 2 ++
 include/hw/arm/armv7m.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index e39b61bc1a..1f21827773 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -256,6 +256,8 @@ static void armv7m_instance_init(Object *obj)
     object_initialize_child(obj, "nvic", &s->nvic, TYPE_NVIC);
     object_property_add_alias(obj, "num-irq",
                               OBJECT(&s->nvic), "num-irq");
+    object_property_add_alias(obj, "num-prio-bits",
+                              OBJECT(&s->nvic), "num-prio-bits");
 
     object_initialize_child(obj, "systick-reg-ns", &s->systick[M_REG_NS],
                             TYPE_SYSTICK);
diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index e2cebbd15c..5c057ab2ec 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -43,6 +43,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(ARMv7MState, ARMV7M)
  *   a qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET).
  * + Property "cpu-type": CPU type to instantiate
  * + Property "num-irq": number of external IRQ lines
+ * + Property "num-prio-bits": number of priority bits in the NVIC
  * + Property "memory": MemoryRegion defining the physical address space
  *   that CPU accesses see. (The NVIC, bitbanding and other CPU-internal
  *   devices will be automatically layered on top of this view.)
-- 
2.42.0


