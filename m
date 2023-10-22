Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC22D7D2229
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:24:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUgk-0008Kg-Ey; Sun, 22 Oct 2023 05:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUgh-0007vZ-MQ
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:23:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUgg-0000Rc-2U
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nKoG7nE4OqpTmQziCVVo5UYOj3kP9c6/O8kpxrPA3Qc=;
 b=gzhBv7VLbvKMIDmcrcWTdm00lmf1XVODz7/GVMe5HQr89kjJ41Pm168e+NSrsfYmikcbtg
 4gRoocQ+S2OJ93nm06M72s/42bQbdmA/KMOAexGkldidwdRrVT9bCg1Q13+7IMn5gjiGJs
 MPm1apQJB/CgrUcXHUyoD1X4eajx0hw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-IrC8FT78Ou2aqJ1s9fWxew-1; Sun, 22 Oct 2023 05:23:49 -0400
X-MC-Unique: IrC8FT78Ou2aqJ1s9fWxew-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32da8de4833so1099464f8f.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966628; x=1698571428;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nKoG7nE4OqpTmQziCVVo5UYOj3kP9c6/O8kpxrPA3Qc=;
 b=HthaN1I8PoOxn99p8gWi7gXc9xqygohJcqOZVq7bBboKuHZGAfF/m6Mqt8lxkmFx7m
 iRkdA59l4QBtw2pbR1tIisToBBGNQ+Wg5mynryegLx3pdE592g7n8Cu1ldj5cjVMJDNR
 QKqX8ob896YYKK5brQOyFusdZ3LSajLM5X1+p2UWKn6lSxm557colj7dKPz5QSvsW3ZA
 wI2G2XS6kVJB/BhxZ8okA/0p4dgJrMKi8Z+JpzVjY+hKFoPzhtmxa0nWaI1wsgDauiXV
 W5pE89tbHDHkVh4mrbaVqztVxb/xRB0t+ug9Q/tfTqCBRUOAY9OAcVEHacY0kwxuc2JU
 GBXQ==
X-Gm-Message-State: AOJu0YzH6JEydc6+tY+WgYyajxWXAmON5a8mvpeO2NZfcQUREcF9Mcn9
 ALVvY3Ek8qAaSkaa7HhA4I1HQ+wtoNxk0xsLcGk97FJC8GtPKkR2Ivuq9FBpKKLMQU50tdc4+4E
 9ijyaeipt1nuqTwyHvONyVBoVcg5gEUyDe1RxdV9MIMgxV7WOxCjrUAoBbFAtK99ahX/g
X-Received: by 2002:adf:ec47:0:b0:32d:9718:b32a with SMTP id
 w7-20020adfec47000000b0032d9718b32amr3623277wrn.0.1697966627835; 
 Sun, 22 Oct 2023 02:23:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGgeUIH0RTarnd+2Ic/on2TRxV3GzdCE7Cy6CJS8x+T9vZSMXS3ukgaw3Jwyqsw0TCVJxVQA==
X-Received: by 2002:adf:ec47:0:b0:32d:9718:b32a with SMTP id
 w7-20020adfec47000000b0032d9718b32amr3623263wrn.0.1697966627504; 
 Sun, 22 Oct 2023 02:23:47 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 l7-20020a5d6687000000b00327bf4f2f14sm5228728wru.88.2023.10.22.02.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:23:47 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:23:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>
Subject: [PULL v3 25/62] hw/isa/piix3: Resolve redundant PIIX_NUM_PIC_IRQS
Message-ID: <32f29b26ff150dba6d1c455b826e44447b9ead45.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


