Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 597E87D2238
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:27:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUhM-000371-4z; Sun, 22 Oct 2023 05:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUhJ-00035V-Uk
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:24:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUhI-0000b5-Ek
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=07jjqgvNUgYjog87FAd6enRV4Ow+UHErs+Qz1yC1V50=;
 b=BhPHhxtel8zP2CrVUrxlfJV7WYs5r3n1Mt/MvznVT3XRh4DFFhIMLWJs291h+iUg4D2cmF
 8mM6BpJc/PGVOT61VWcLEm86qIFIueD30olNhWSy0s9mPpIDnrTvrLk/ydjGXCBRBoYPZJ
 pcUKTcx3QuFJSCUk2VV7g04esVzgI58=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-hb_ygWoVNWWdev2HMFRZoA-1; Sun, 22 Oct 2023 05:24:34 -0400
X-MC-Unique: hb_ygWoVNWWdev2HMFRZoA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-408508aa81cso15445015e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966672; x=1698571472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=07jjqgvNUgYjog87FAd6enRV4Ow+UHErs+Qz1yC1V50=;
 b=uGWmpTOw/1eaH+dO9ilv5AMXohg1GpaVCYL71ACdLiXlhBdRwEGIAOgFl02JRFw5e6
 FwT58QjvWvsH+ufAmsMtxjPt/4qQXqZO1Yv7uh1T5s3Z4SwqezHyDGGtJ8hBrw0bObnb
 IwsFJdNQRsNONKVJKY2i/tbfqINMO3lbC8WR7afpXaYahx5fJQP1DDF2z51lw3o06Mz9
 jqgW3o3t29nvWLwbHkAgBSlR8v/w8qrvL3ZTDHmMusbWnaEoq53qUPFyGm/HxEIHXaRN
 0K6XBCMa1a1AoUTMCHCMQk5nFTEUOdTUa1NEerj2rkeyBJ+1YUk0VC/aibqqpQpTLXDN
 G0qg==
X-Gm-Message-State: AOJu0YyjYN1oL9LGwc+DqGAAE5Zj0yTOqJLrROjxkljPbnNc2ZQc716F
 CZRFuw3zWXRK5xCTSQR7xr4Zrob6OXb7JpbS82TiYP1e7U4rLMZ/wJv2bPtXBKooZmUGe3axiSO
 4weg09zS7TLw66FVSfx7+V+DUi6gnKKl3p8tXMB2PoNHPm2fgqOF/VON25AbZA6LYHkZh
X-Received: by 2002:a05:600c:4e91:b0:408:3fa9:4bb with SMTP id
 f17-20020a05600c4e9100b004083fa904bbmr4771176wmq.11.1697966672689; 
 Sun, 22 Oct 2023 02:24:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNtDLPJIYvmEecBQMPqvZ9XEjY+Kwsfg4Epin2qCbIfmvJqFUQS6lzJX1vGvi/Vh06gJFKyQ==
X-Received: by 2002:a05:600c:4e91:b0:408:3fa9:4bb with SMTP id
 f17-20020a05600c4e9100b004083fa904bbmr4771163wmq.11.1697966672396; 
 Sun, 22 Oct 2023 02:24:32 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 g13-20020a05600c4ecd00b004064ac107cfsm4501007wmq.39.2023.10.22.02.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:24:31 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:24:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v3 36/62] hw/isa/piix4: Remove unused inbound ISA interrupt
 lines
Message-ID: <06f6efefe06c7958471cbf84c56ccc87624577d8.1697966402.git.mst@redhat.com>
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

The Malta board, which is the only user of PIIX4, doesn't connect to the
exported interrupt lines. PIIX3 doesn't expose such interrupt lines
either, so remove them for PIIX4 for simplicity and consistency.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231007123843.127151-16-shentey@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/isa/piix4.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index e0b149f8eb..3c3c7a094c 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -148,12 +148,6 @@ static void piix4_request_i8259_irq(void *opaque, int irq, int level)
     qemu_set_irq(s->cpu_intr, level);
 }
 
-static void piix4_set_i8259_irq(void *opaque, int irq, int level)
-{
-    PIIX4State *s = opaque;
-    qemu_set_irq(s->isa[irq], level);
-}
-
 static void piix4_rcr_write(void *opaque, hwaddr addr, uint64_t val,
                             unsigned int len)
 {
@@ -197,8 +191,6 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
         return;
     }
 
-    qdev_init_gpio_in_named(DEVICE(dev), piix4_set_i8259_irq,
-                            "isa", ISA_NUM_IRQS);
     qdev_init_gpio_out_named(DEVICE(dev), &s->cpu_intr,
                              "intr", 1);
 
-- 
MST


