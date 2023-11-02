Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A82967DEF76
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:07:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyUaS-0001pg-2N; Thu, 02 Nov 2023 06:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyUaP-0001of-OT
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:06:01 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyUaN-0003I7-KW
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:06:01 -0400
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-9d242846194so107643266b.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 03:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698919557; x=1699524357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dmbBzGtCdH6WgFZlHcRHMhoK0u8/EdFxfTPO8UY1JO4=;
 b=RCZq5IXvIgB/oSYDJZV0TsJ9MZFXo5xfYxSuXckKCoU1wm903LPOXfbcoGDRfoIaE4
 mNnEo1wykp+vnjXNHy0OwQwexoVpHFAy6NSUNslDwtpfR6V923T98QTZ8rGnwsxJWvpE
 9+NwiIMIxeIXotppduan3TGfKnvH6I/6bREZb9ldKGZ7YhkyDG0UfvthittE5xdL3mPN
 DhJkgwnRwHVCimRt6jhoblld34KYnuIh0lBjNvMwK4TkXXlLNupEfiQQ/Y8ygxHZBGfW
 qYY7VVlXW3eYOKy4NHAJRyFoVhGMKdzLWtRVt3bYHtoU5LN/2hn77CedTo4/gbM2sbjp
 UhjQ==
X-Gm-Message-State: AOJu0Yygbh/5e/S8yQp5bXSrAct8/iRErRAFq32y0YGZ/BAGGxHZGzcV
 zm3b0Sminwx+2wp+3eDyHBfaA+Zhizs=
X-Google-Smtp-Source: AGHT+IEvMm/UJKWPHhlHhR/Bo1B6a8sj9lni4zQCEf9yFh+c/CpoakZgCgxFZc0xHEgrpDd3hid64w==
X-Received: by 2002:a17:906:db01:b0:9b2:a96c:9290 with SMTP id
 xj1-20020a170906db0100b009b2a96c9290mr3402597ejb.33.1698919556962; 
 Thu, 02 Nov 2023 03:05:56 -0700 (PDT)
Received: from localhost.localdomain (ip-109-42-115-39.web.vodafone.de.
 [109.42.115.39]) by smtp.gmail.com with ESMTPSA id
 o21-20020a170906359500b009b97d9ae329sm927236ejb.198.2023.11.02.03.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 03:05:56 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/10] hw/m68k/virt: Do not open-code sysbus_create_simple()
Date: Thu,  2 Nov 2023 11:05:39 +0100
Message-ID: <20231102100543.4875-7-huth@tuxfamily.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102100543.4875-1-huth@tuxfamily.org>
References: <20231102100543.4875-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.47; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f47.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20231024083010.12453-7-philmd@linaro.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/virt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index e7dc188855..2e49e262ee 100644
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


