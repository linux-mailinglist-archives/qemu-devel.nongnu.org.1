Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C67DB7CE22C
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:07:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8wx-0001LL-3T; Wed, 18 Oct 2023 11:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8v7-0004Zn-Gx
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:57:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8v3-0007Fr-UX
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EV0w/juyamhfIdi/nYYRPk3ACWIP8V+WfsiMSqIQCVQ=;
 b=eCWxuHqqBJXeJMzPRKX9637cQlqARWSYnmlfMEp3AIf8phHj/FGhFmdihgOmNv13c8fuee
 sfBRuswgh7vWPvEo5skmM/4neb9U72jn1DhZwHMpzKNfYiTUMlif975DXNrjhEA3P00W1P
 QFsocUzG0mXx+kW8EhunVQze1FtYstY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-ym-Qq55sMzKWa_S4tY39aQ-1; Wed, 18 Oct 2023 11:57:11 -0400
X-MC-Unique: ym-Qq55sMzKWa_S4tY39aQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507c8a8e5d1so915150e87.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644629; x=1698249429;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EV0w/juyamhfIdi/nYYRPk3ACWIP8V+WfsiMSqIQCVQ=;
 b=l7H5zCK+UoGTj+0Gp3ednK+jUheXIx8XpHmD0hVSuDegIJ6qi6CHDj1LsvNyR5IK6Y
 mkCEtOwLZ7USTUiiNx0/y5cIlMCFNbhKbTiLCNN98hcvjE0kNGrmWMjTxE0fj2Nm+y5A
 YGIjMX+GP4N8M83UySTDZuZy+lvS2TDf1QXKJhX3MX6+mxZslCiNzs9W1Th9Di5vonl2
 no1nd0+27YNaKX2yQ3v8EaEdfhCf0Q+FzrCdcstq28V2lB0frYgOxhA0KocFNEQmRivH
 nFDuH7d0C9rr8Gr0awzUyOQ5K9dNUg1CFPCGlRwO7vytG1YljDcR1ZGJBXzgkHOt1V+G
 /Y7A==
X-Gm-Message-State: AOJu0YxVfbUbDDXkBMHk/LqEhtwalpYBf4E9XGJGyPw1ZvaoFKyVHPLm
 UiGEltxV+bj9JC09yAPq9NQgUewHccUkEdVSQI2QlO9ghbC8W0xYfPuudPJU6kr37DO+xIntj5F
 Mz6QsUsSLLjLqf4w8y3pZvIm4iPsSDrf9FpWckxiIMxqoHcgcDY2QjAE8x7POLL6SVXB65Kk=
X-Received: by 2002:a05:6512:3b90:b0:503:35bb:1e74 with SMTP id
 g16-20020a0565123b9000b0050335bb1e74mr5164358lfv.61.1697644629630; 
 Wed, 18 Oct 2023 08:57:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKG5tSMgXUUTyfIRSW8fVaTQhAUQqFbXFV+KCT0FukA3EQEB2I5XxNoskhp8cHCb+lVKgIFQ==
X-Received: by 2002:a05:6512:3b90:b0:503:35bb:1e74 with SMTP id
 g16-20020a0565123b9000b0050335bb1e74mr5164334lfv.61.1697644629193; 
 Wed, 18 Oct 2023 08:57:09 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a05600c199000b004068e09a70bsm2023905wmq.31.2023.10.18.08.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:57:08 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:57:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 49/83] hw/isa/piix3: Rename "pic" attribute to "isa_irqs_in"
Message-ID: <23926d6e3aeae32c0de63353af8b18e379b9e60c.1697644299.git.mst@redhat.com>
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

TYPE_PIIX3_DEVICE doesn't instantiate a PIC since it relies on the board to do
so. The "pic" attribute, however, suggests that there is one. Rename the
attribute to reflect that it represents ISA interrupt lines. Use the same naming
convention as in the VIA south bridges as well as in TYPE_I82378.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20231007123843.127151-8-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/southbridge/piix.h | 2 +-
 hw/isa/piix3.c                | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index bb898c6c88..b07ff6bb26 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -46,7 +46,7 @@ struct PIIXState {
 #endif
     uint64_t pic_levels;
 
-    qemu_irq pic[ISA_NUM_IRQS];
+    qemu_irq isa_irqs_in[ISA_NUM_IRQS];
 
     /* This member isn't used. Just for save/load compatibility */
     int32_t pci_irq_levels_vmstate[PIIX_NUM_PIRQS];
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index c17547a2c0..616f5418fa 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -36,7 +36,7 @@
 
 static void piix3_set_irq_pic(PIIX3State *piix3, int pic_irq)
 {
-    qemu_set_irq(piix3->pic[pic_irq],
+    qemu_set_irq(piix3->isa_irqs_in[pic_irq],
                  !!(piix3->pic_levels &
                     (((1ULL << PIIX_NUM_PIRQS) - 1) <<
                      (pic_irq * PIIX_NUM_PIRQS))));
@@ -312,7 +312,8 @@ static void pci_piix3_init(Object *obj)
 {
     PIIX3State *d = PIIX3_PCI_DEVICE(obj);
 
-    qdev_init_gpio_out_named(DEVICE(obj), d->pic, "isa-irqs", ISA_NUM_IRQS);
+    qdev_init_gpio_out_named(DEVICE(obj), d->isa_irqs_in, "isa-irqs",
+                             ISA_NUM_IRQS);
 
     object_initialize_child(obj, "rtc", &d->rtc, TYPE_MC146818_RTC);
 }
-- 
MST


