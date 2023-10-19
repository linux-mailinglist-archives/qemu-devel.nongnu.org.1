Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4410B7D0198
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:32:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXgm-0007yg-4x; Thu, 19 Oct 2023 14:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgH-0007bV-RP
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgF-00015A-G9
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=07jjqgvNUgYjog87FAd6enRV4Ow+UHErs+Qz1yC1V50=;
 b=PqzKzcGqc2d6P/4q2IkaM/LyUKZcSoe9P0PEaGaXVO7GUhlNLSfguZCErZLryK4G8g/qYK
 zWcttOuxJeaZyTMAPW0qSYesmJ0+Mwr28bnLHmMduMk7LciUk7zqS2LkOel0SjzM8r4u6h
 ouilWDm2XcCPgYIUEYafC47LQorHGuc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-kLnomDN9Pk2tvSSgCQ7B4g-1; Thu, 19 Oct 2023 14:23:33 -0400
X-MC-Unique: kLnomDN9Pk2tvSSgCQ7B4g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32172e3679bso167f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739812; x=1698344612;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=07jjqgvNUgYjog87FAd6enRV4Ow+UHErs+Qz1yC1V50=;
 b=DjQFqUhWgt6IK/UnhNdgMahQravnw8YstS6Qmfwt22rEnAoNVaaF52vjHsQCvCTvR2
 RV2SNQaUNwDHgnNx8+AVznRqdR82pWElBaIP2dUuH4yj6ZWd2IULv6OuF0pnG3XnMDS9
 Yq/GFDt/sfAM9B7k+Vqv/xaQdnKCnPK05+1CAKmrg2b0x7l5NKzonYFmEze/HVjARyan
 JrF8KsJUc9MOYA9ZMTZlWeB3If8PS6LKrfeRaCSRW/ygbghJVr4dna2pmq/Int1Ph7v6
 TZ6BjGXb8rziff3WlsvQC6Ccj4ikMpZn4CDYLYCo088zTGrzH8g7/85uoXyWdgmbyy5u
 Vy+g==
X-Gm-Message-State: AOJu0Yzs4DtofNwoB3fiYa/2ZTFOM0gAdf2CnbkNq59Sat57h5FXdEnZ
 z+Z3cY7iWqsmO3O5N5KtM/yGuI/8mAijWo1WVS2AQSJKnr7oezrN3awydTVQjyAZ6Er3u10AYgz
 4ksJ2GIGn226CVnY4zXBv30DzfhHWPMC9cxUVl/eQJtH0Xod+flhocDHv2gRSKqYsZLWN
X-Received: by 2002:adf:fa04:0:b0:32d:a129:4f44 with SMTP id
 m4-20020adffa04000000b0032da1294f44mr1966680wrr.70.1697739812129; 
 Thu, 19 Oct 2023 11:23:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg96zUtnZOpjd7tKL9pFvkEZEZrXEmSuQjey+PM4j/Z9fPzcnE61M5n7htQHO9bLgYJGw58Q==
X-Received: by 2002:adf:fa04:0:b0:32d:a129:4f44 with SMTP id
 m4-20020adffa04000000b0032da1294f44mr1966665wrr.70.1697739811705; 
 Thu, 19 Oct 2023 11:23:31 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a5d58d2000000b003143867d2ebsm5013956wrf.63.2023.10.19.11.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:23:31 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:23:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 52/78] hw/isa/piix4: Remove unused inbound ISA interrupt
 lines
Message-ID: <b65ca9f8a3e8df22b3f94a8bf3d2f7ad73fc5733.1697739629.git.mst@redhat.com>
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


