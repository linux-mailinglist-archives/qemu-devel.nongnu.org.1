Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DC27BC7A6
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:41:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6ac-00032V-2P; Sat, 07 Oct 2023 08:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aP-0002rg-5n
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:13 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aA-0002js-CZ
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:12 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9a645e54806so532291866b.0
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682336; x=1697287136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlqrcCW6WI2SoijcsQ9BLxuEWIahgOUvgp3M1HY14Nw=;
 b=S/HCBr1m3/UUBq27TxldObKgnxTh9a5YUVdl3Qf07LiJxr3P76U2EVij8YlIyT1aDw
 wRZ25UgB3Ppj/dvKSyXPmauXXXA36hZMbqeQG9+dc9+yhbjRZ/QFyAjRXEYDOLrxAiEg
 q1QK/HWm6TtVlahD4n+vugs61BtcXjTdjA8rxaUTYjLynI6wm8RfJlMDLl6WZn+pDHo+
 LH6oVuzPB3Jpygwx8dVxYckkbns6DBFrld5HhyVsFLcZpcAaHa20nkowHaIhPXyZWsOu
 JkjGytzMED1nuLoL6dNT0YzALNB7PoIj4xXscJx422zIgDyzOxRAjlVdnbwe70kHw7hF
 Fb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682336; x=1697287136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hlqrcCW6WI2SoijcsQ9BLxuEWIahgOUvgp3M1HY14Nw=;
 b=PtEcuujKHeP9tEq1ArBd4s56r7PZ0nZhmCwAW8TbgWcxCgZVIwtzmUChmFrP6GaBVy
 regbx0ssIV61OO53YShYS/sfaY0K4pEhJ0CHDei6Pgpp89cwG2RBnSqg2YpDGS+EJOp7
 Ff5hvY3TO4pIkpqEcTZsxwHJfQfykQKm4j8D9CzmHqiKKUk8GjRPYNosl3HdgIGGsNEx
 5b0EyPsGr6Beoay3NxqUYatLRC3MPCez09dOwZczgzQllRdtKF3JajQECAuP5RzJr9lY
 XZ20mKIAnlI/2UNh8kIopx0PEkwHspcbVJQvOpYuQuaq0Te5oIhD7d8Z43WCyAL26IEf
 pwzg==
X-Gm-Message-State: AOJu0YxWlDbQUi+H90+iKwPVC5hwT38gw0u+6/Xead4AXzrqpFX9Xvcj
 quXIeWShFuBTdD65Jjod1iQgvHdsqdo=
X-Google-Smtp-Source: AGHT+IEvtyLdUJe1FtZpvq35K3jCwKZ7uOLG0Sih6L/j/k4f3eG3ekWKeuSPDZVlTp/Y+mBAbPZwww==
X-Received: by 2002:a17:906:2253:b0:9b2:6db8:e108 with SMTP id
 19-20020a170906225300b009b26db8e108mr9334359ejr.13.1696682335977; 
 Sat, 07 Oct 2023 05:38:55 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:38:55 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chuck Zmudzinski <brchuckz@aol.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v8 04/29] hw/isa/piix3: Resolve redundant PIIX_NUM_PIC_IRQS
Date: Sat,  7 Oct 2023 14:38:12 +0200
Message-ID: <20231007123843.127151-5-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

PIIX_NUM_PIC_IRQS is assumed to be the same as ISA_NUM_IRQS, otherwise
inconsistencies can occur.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/southbridge/piix.h | 5 ++---
 hw/isa/piix3.c                | 8 ++++----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index 278171752f..2317bb7974 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -27,7 +27,6 @@
  */
 #define PIIX_RCR_IOPORT 0xcf9
 
-#define PIIX_NUM_PIC_IRQS       16      /* i8259 * 2 */
 #define PIIX_NUM_PIRQS          4ULL    /* PIRQ[A-D] */
 
 struct PIIXState {
@@ -39,10 +38,10 @@ struct PIIXState {
      * So one PIC level is tracked by PIIX_NUM_PIRQS bits.
      *
      * PIRQ is mapped to PIC pins, we track it by
-     * PIIX_NUM_PIRQS * PIIX_NUM_PIC_IRQS = 64 bits with
+     * PIIX_NUM_PIRQS * ISA_NUM_IRQS = 64 bits with
      * pic_irq * PIIX_NUM_PIRQS + pirq
      */
-#if PIIX_NUM_PIC_IRQS * PIIX_NUM_PIRQS > 64
+#if ISA_NUM_IRQS * PIIX_NUM_PIRQS > 64
 #error "unable to encode pic state in 64bit in pic_levels."
 #endif
     uint64_t pic_levels;
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index 117024e450..7240c91440 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -48,7 +48,7 @@ static void piix3_set_irq_level_internal(PIIX3State *piix3, int pirq, int level)
     uint64_t mask;
 
     pic_irq = piix3->dev.config[PIIX_PIRQCA + pirq];
-    if (pic_irq >= PIIX_NUM_PIC_IRQS) {
+    if (pic_irq >= ISA_NUM_IRQS) {
         return;
     }
 
@@ -62,7 +62,7 @@ static void piix3_set_irq_level(PIIX3State *piix3, int pirq, int level)
     int pic_irq;
 
     pic_irq = piix3->dev.config[PIIX_PIRQCA + pirq];
-    if (pic_irq >= PIIX_NUM_PIC_IRQS) {
+    if (pic_irq >= ISA_NUM_IRQS) {
         return;
     }
 
@@ -83,7 +83,7 @@ static PCIINTxRoute piix3_route_intx_pin_to_irq(void *opaque, int pin)
     int irq = piix3->dev.config[PIIX_PIRQCA + pin];
     PCIINTxRoute route;
 
-    if (irq < PIIX_NUM_PIC_IRQS) {
+    if (irq < ISA_NUM_IRQS) {
         route.mode = PCI_INTX_ENABLED;
         route.irq = irq;
     } else {
@@ -115,7 +115,7 @@ static void piix3_write_config(PCIDevice *dev,
 
         pci_bus_fire_intx_routing_notifier(pci_get_bus(&piix3->dev));
         piix3_update_irq_levels(piix3);
-        for (pic_irq = 0; pic_irq < PIIX_NUM_PIC_IRQS; pic_irq++) {
+        for (pic_irq = 0; pic_irq < ISA_NUM_IRQS; pic_irq++) {
             piix3_set_irq_pic(piix3, pic_irq);
         }
     }
-- 
2.42.0


