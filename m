Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D6F7D0163
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:26:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhU-0000rz-5v; Thu, 19 Oct 2023 14:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfo-0007CE-7k
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfm-0000sr-Mt
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nKoG7nE4OqpTmQziCVVo5UYOj3kP9c6/O8kpxrPA3Qc=;
 b=iBtCFz55J78HG88ke060tUxPnyYblytKSgINKGsJdPWRI6Ln8z4HSwREd7A+PXwt6CZztX
 jm6NcZqd2aYiFEgLVD42/imZKucFAD63LYS8XXGV60GjYJXkjpTwJsVMFzJo+lIX1hdZKS
 pchV8SKuxkbUKIke3/Rs2+fRtY/Pou8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-hCEVT29BNEaQpOAW5YAhoQ-1; Thu, 19 Oct 2023 14:23:04 -0400
X-MC-Unique: hCEVT29BNEaQpOAW5YAhoQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c50ef18b04so59243831fa.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739782; x=1698344582;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nKoG7nE4OqpTmQziCVVo5UYOj3kP9c6/O8kpxrPA3Qc=;
 b=XBpj0cScZcQT3kazriFaLttLQrTraoD/pD3Kj2Hc5ofA5qZaIF7t4LQt7ujybOKTbD
 zrB+gXwo3NRXIpFaSnsITxSTJ7t+7Y5bUFlTYc0m00YblW2Tmsu4jdBx3qC5f14NJ0pa
 pEQbYppV1XE0ryJ9M6vzlG+UtlAyGas9dNzWcNGk5KkfzkIvirlZ/xWDmVnPN5tMl/Lo
 QkSnG9ykYklvILmDc3cMl5ak0vhbkbZMRjuHWQVzQJU+8EQwzFTssbLBOofdULamEMSz
 rr7G5JUTeL9wfZumnctQurEYGLcbNQjDXLDfEC8u5tdvPavV8N5g27caEIuceqvA3DEe
 TA8w==
X-Gm-Message-State: AOJu0YxWX2278x14c1InJhFtTs/7/0NafF4AWWp2xyQtgL36fnUWc4tC
 wc57072+SRzR1pNDaTrVJlbwHkCDFh2rRLkAG0M13X9ovLVmEHbkocYUuoJkDMyzjl0bL1PClOs
 Tz+/4BkDxMrO1VNQjR7revgeripRhSd5T8Lk0gW4j/6LZQtTaR6EqGuFwzLH7q3AEdftE
X-Received: by 2002:a2e:9784:0:b0:2c5:32b:28fa with SMTP id
 y4-20020a2e9784000000b002c5032b28famr2241000lji.30.1697739782451; 
 Thu, 19 Oct 2023 11:23:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7T8OEAhCRZYuMOviNFPkU63DDKl222hGyxPxSvpTZV7oUr4PttukoFldfa00CqvF6bp7X8Q==
X-Received: by 2002:a2e:9784:0:b0:2c5:32b:28fa with SMTP id
 y4-20020a2e9784000000b002c5032b28famr2240986lji.30.1697739782162; 
 Thu, 19 Oct 2023 11:23:02 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a05600c210100b004068de50c64sm187745wml.46.2023.10.19.11.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:23:01 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:22:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PULL v2 41/78] hw/isa/piix3: Resolve redundant PIIX_NUM_PIC_IRQS
Message-ID: <b2dafe19edd0658f179b3d8cf8869d5391e8d64c.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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


