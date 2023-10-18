Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC407CE205
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:01:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8wd-000121-6W; Wed, 18 Oct 2023 11:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8vf-00081g-JY
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8vd-0007M4-Tg
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=07jjqgvNUgYjog87FAd6enRV4Ow+UHErs+Qz1yC1V50=;
 b=DxOAmYkzJri5Lfz/Ebyl74fxZgIgAEK7vEZUWrJQNreKtbHKmn39ZP+NY3cG90Dsx6kQ1B
 kDItxKGdFszrbQZ3of4DHf/fURFyIDbX9fgKqPXRRvW6fyrTbZNTYstFRgmfSd0c0yez+Y
 3aJNsvLmClKfbMv6m9Ek6HsM5fn2voc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-grV7di7IM-q8ae2EY005pg-1; Wed, 18 Oct 2023 11:57:48 -0400
X-MC-Unique: grV7di7IM-q8ae2EY005pg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32da87eac93so2477601f8f.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644666; x=1698249466;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=07jjqgvNUgYjog87FAd6enRV4Ow+UHErs+Qz1yC1V50=;
 b=HwGMPCnrKnFvEQCn63W850g4UeZrnyeTbpoqy/4pRzdCNRJkSakKPun7QqmVhCmJDC
 RCQxmrsMeqaKNiWpgi1mDbBGxmYaYT1SO0Niw1Do7sxKD6wqqjkWl1tYuOhMLyKkGJcQ
 kda1U7sw26eQcfl9bYtExY55ZcwuwfplJnL/f8wsuUKRfcTW4zsqqq9g3XNdsjAIe2jh
 TZHZOH7pdIk1wajSKAskJnTFyu30NjD65eEJ5/DDoPRC0M4oJDaQpEKdwxpQWoz3Dowu
 l0zaPqCfxi71JB0zMuwrWP8qfHGX40fxEuY2BBH+Zn3CYPtKbQOr5xVDGVgy0bFYTKQC
 MpnA==
X-Gm-Message-State: AOJu0Ywgs/bFz7gyJSh66G1oEeRayFz8SGdrSdBby7qMklXw0FQdwgjn
 WWEQzb/SYcVpJKzCKA00NLFcTnLZXOBSkHKuPfm+BfRLukbLc3iXO5X6OmMau7jQBBwPA/ekyo9
 DJo2zvgGnvpaUwW766BgV9Gw/bTVJ48a+I9q+p1nLR6ZxMlc1coTkSyRQg7oRO+QVW7Tj2TE=
X-Received: by 2002:a5d:5612:0:b0:32d:82d8:3442 with SMTP id
 l18-20020a5d5612000000b0032d82d83442mr4405783wrv.53.1697644666109; 
 Wed, 18 Oct 2023 08:57:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7RfmysDx3cXp2nj9RS59UMYvfdklpi0Ix7+RStApIQEVhKwRUdduNRCclJTyUDZD2kqlfpQ==
X-Received: by 2002:a5d:5612:0:b0:32d:82d8:3442 with SMTP id
 l18-20020a5d5612000000b0032d82d83442mr4405768wrv.53.1697644665803; 
 Wed, 18 Oct 2023 08:57:45 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 d17-20020a5d4f91000000b0032d72f48555sm2393430wru.36.2023.10.18.08.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:57:45 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:57:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 57/83] hw/isa/piix4: Remove unused inbound ISA interrupt lines
Message-ID: <18b1a595bd0d763856c58a308aaa25bf6e1c2a80.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
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


