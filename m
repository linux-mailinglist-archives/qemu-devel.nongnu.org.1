Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE19B7D1236
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 17:07:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtr5p-0006Su-1j; Fri, 20 Oct 2023 11:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtr5k-0006SP-90
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:07:12 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtr5i-0001PG-GA
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:07:12 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53ebf429b4fso1383596a12.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 08:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697814428; x=1698419228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z/fRhNmq79+XHZUXC8+nvKpVzDw/8FAnvz0rAnEH2zo=;
 b=lki/Gtg0XryT53IIrqlGJWbUN2lWwFOryfaV2fRpIUm9naXiM17v9JRSbKtSMAK6Ox
 rXEBHxUh3Q7kL1yeTy8MmHYa6r/18wRazb52Iw6LlzS6+iag080jinLuyTFqaTH+Xiv1
 Pf22IUaxF59LXBKSUztyZ0jrzluSPjYugv3HTaSTWW+r/y9lruDmh0npCDL9CTSZqCDd
 arriCtSaQA4QvT+8Llsz+//NWQKQhP0RDGUaqOTYUHqArbk8EkD0y2itB8ihe/quDszj
 2GEH+a5VUuAPwIU6t9xFX0WphfOtQ5hAqjN3jbADozY3nhXGVRIdLEnUAnTY04Sclcuh
 emDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697814428; x=1698419228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z/fRhNmq79+XHZUXC8+nvKpVzDw/8FAnvz0rAnEH2zo=;
 b=cXUCoyvId4Qzs4mvzRCNjmerRjgwuoRQMn05hLDHABu/rGjpVTZDdWXPfwUyZfWwsM
 MQQW3O/IK1d/saau2JuYGtHpFpv30ImjuyAfv88hkWHiT1brSmXpu9E4fItFyfYihSgd
 iSEj+2wQXg2/kBtXG2KgFjrqWV+ge8Td2Vc1zY1EK5FzQkC/PmLvh+TmDgkbluPDQm6x
 OmANeCrMw6phIieWJloSr3362TNkTgpHt2RVi2WiAxFbellyYgHkIHjC4dUHcmR01xm7
 zhw9/Q4xC0KZXrgKF6iQfVz2V9vdOiNogB44hMruvZCO5XV3y+r7K5X6CFU6YVgN3wZE
 iKHg==
X-Gm-Message-State: AOJu0YwMIDn0LRk/0rwD62WEgZggoWDcmUe98QgqlZOp4CNOoSUlRA8i
 NclqZWVRRZ3U/jg4fkjy1eunj3M4KCElTmlmRdA=
X-Google-Smtp-Source: AGHT+IEzg7gMhvsXYBUwo183EmWt6jShB8u7ucc8N80D2uNRbtsqa32mdbXOKOm2SuIF85P7aTBbzw==
X-Received: by 2002:a50:9fc8:0:b0:52d:212d:78ee with SMTP id
 c66-20020a509fc8000000b0052d212d78eemr1644661edf.25.1697814428448; 
 Fri, 20 Oct 2023 08:07:08 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 j8-20020a50ed08000000b00533dad8a9c5sm1607276eds.38.2023.10.20.08.07.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 08:07:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/6] hw/m68k/virt: Do not open-code sysbus_create_simple()
Date: Fri, 20 Oct 2023 17:06:26 +0200
Message-ID: <20231020150627.56893-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020150627.56893-1-philmd@linaro.org>
References: <20231020150627.56893-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Mechanical change using the following coccinelle script:

  @@
  identifier dev;
  expression qom_type;
  expression addr;
  expression irq;
  @@
  -    dev = qdev_new(qom_type);
  -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
  -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
  -    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
  +    dev = sysbus_create_simple(qom_type, addr, irq);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/virt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index da35e74bd9..31038b8bb0 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -201,11 +201,8 @@ static void virt_init(MachineState *machine)
     sysbus_connect_irq(sysbus, 0, PIC_GPIO(VIRT_GF_TTY_IRQ_BASE));
 
     /* virt controller */
-    dev = qdev_new(TYPE_VIRT_CTRL);
-    sysbus = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sysbus, &error_fatal);
-    sysbus_mmio_map(sysbus, 0, VIRT_CTRL_MMIO_BASE);
-    sysbus_connect_irq(sysbus, 0, PIC_GPIO(VIRT_CTRL_IRQ_BASE));
+    dev = sysbus_create_simple(TYPE_VIRT_CTRL, VIRT_CTRL_MMIO_BASE,
+                               PIC_GPIO(VIRT_CTRL_IRQ_BASE));
 
     /* virtio-mmio */
     io_base = VIRT_VIRTIO_MMIO_BASE;
-- 
2.41.0


