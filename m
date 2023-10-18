Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB94B7CE27F
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:15:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8vH-0005Lm-2R; Wed, 18 Oct 2023 11:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8ur-0004X2-Rc
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8uq-00078M-7P
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nKoG7nE4OqpTmQziCVVo5UYOj3kP9c6/O8kpxrPA3Qc=;
 b=amAMzs8+bhiRryuwM29mFqpSTZZc92FT712Mcn8FNl8KGTPa6mDKU8TrbwqT1QbJaGD8ek
 NAPrcjq7Q3pB1zQaS+e6r2roS9awIrXK6FKqsfwMm4IY+qaEBpd9tREMOeKDd+WkcQnaDi
 nwc3EagdZkw0CBDDp7PbYo/OfMbF2C8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-AmsoKaWAMc66fsiGx_oPIw-1; Wed, 18 Oct 2023 11:56:57 -0400
X-MC-Unique: AmsoKaWAMc66fsiGx_oPIw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50433324cf3so7208711e87.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644614; x=1698249414;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nKoG7nE4OqpTmQziCVVo5UYOj3kP9c6/O8kpxrPA3Qc=;
 b=GhsZLwzKvfrbS6lL38NP3osfqM/l3UzFtuO2o5o+Bx9W19JVlrcyqAsakmcNAKaSHx
 D6uenAhjE8Yt7gUOCQ77pSi0bpyq2qhjTGAs47I896vLP5FPxIYJnY1a1Zwn7SEbpYin
 jxx/DJ/fGK0SAT8woMHPDROR9ruFaoWLS0X/QVEwR0V4jcUWg4ataNPZFR9HNRDywxFg
 CODriGItlyK+pEL8ry2+DT9qBmqRbGKcN1Fx6xrMbdoSLtGQam1ZCq7QikW186ZKINGd
 SgG/GJFvz+RdEcKagHAv6Qf1J5YcH15A10pl5L8MH/pGKjgr9VlgRm6GbGILIL0K7tbN
 3jNg==
X-Gm-Message-State: AOJu0YwTNsjfmm96wsY0tX5tQpOOuCFnkl4VJFtLsyPd4XQgFTGaW6+G
 4PtdRg0yiALF2zcxOpm0zRkl3alvq8tm5EjLQa8QFd1e81YFZwetA8gYx2K+IUZOE7NB6xvglQN
 vXaesp8HkoxlMP9zX8oyYoXz4f5VyMe+1xRMl8XqgRLDDr59fpay2UBeWDv7tGhfWNwfV85U=
X-Received: by 2002:ac2:4c4b:0:b0:507:974d:80f9 with SMTP id
 o11-20020ac24c4b000000b00507974d80f9mr5545154lfk.34.1697644614520; 
 Wed, 18 Oct 2023 08:56:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzbAh6StzWo2jxEcdIlOFuLN/MpwtON0PKi8xXltTZmtuN/OsImGlttGW/iiF8rOrKGQF4JQ==
X-Received: by 2002:ac2:4c4b:0:b0:507:974d:80f9 with SMTP id
 o11-20020ac24c4b000000b00507974d80f9mr5545137lfk.34.1697644614202; 
 Wed, 18 Oct 2023 08:56:54 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a05600c4fd200b0040472ad9a3dsm2026258wmq.14.2023.10.18.08.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:56:53 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:56:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 46/83] hw/isa/piix3: Resolve redundant PIIX_NUM_PIC_IRQS
Message-ID: <79583234651968bf9f73437eb2de14a485bd398a.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

PIIX_NUM_PIC_IRQS is assumed to be the same as ISA_NUM_IRQS, otherwise
inconsistencies can occur.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231007123843.127151-5-shentey@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


