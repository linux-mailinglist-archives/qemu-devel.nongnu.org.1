Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC797C5D58
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 21:02:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqeRY-0001QK-Uv; Wed, 11 Oct 2023 15:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqeRV-0001Mr-7i
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 15:00:25 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqeRS-00074I-Js
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 15:00:24 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31f71b25a99so149650f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 12:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697050821; x=1697655621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86EtloM2wmtdVgnAFS0+ABlwjRMBULfnIB1IMEYHyFk=;
 b=Ihe9aOSPe72bUZQ5mALMbUcZ/CdRxJdjBMZQECjSjJvB7LwubsuQu46h99Hjpwgcx3
 DhXjE6tEWgfdeMdziqd/vJ1AjmSiLqP74+JM1LmGGjlnTaPogJnz1FQqhTCN+FyKL071
 YhzhGZ3doUA4C9t/lNfNkd6BNa7Ocm/a1ScnY7SRKlknjFWAXmojgQ1yk1UtmNXff0Qc
 IKVU3xQYSPOomDxbogKZ1s5znm8koh08P8xBvCHlEF0KuqvpprOGZQIjldZYSaPr2ejK
 PQTmIqUN51eE6Rt61HAjMoFrvq2IXYD49sATrlyQLN8R1dqDvg+wIQQ+KT6AuvLOdYhO
 YYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697050821; x=1697655621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=86EtloM2wmtdVgnAFS0+ABlwjRMBULfnIB1IMEYHyFk=;
 b=JG2bfKu2RdQIu0U57HwZL4h7j2PBLRCe67BQT7MQ1tupJuBVwjEUdqAGfxTljVCjsy
 hNH6NgL1Ke3QkYW+DDJQW+eVu6+RrBborTR9tYW6oftVyBei1ZxLsd7qzHRFSRDKXYq5
 aM4hkCylVezIfN3Nf0gHnQBi6oTrGC0zT3WjH4e5FtQH6XTw8TYh2m5UEZu/9H8r5U+w
 dBK+k4mI+qThrCGymRW5YcIkQeODUe32yOconfHVe+C081kpe/1ujQP+iTYYtw38hxfb
 ToGYPxPce5g+TIwVe9ae0Xf0ClGeW81uyNd8BP0DN2DQiItfyqU7bNF6MxEHLYIJfPjk
 Xirg==
X-Gm-Message-State: AOJu0YxepK8jJqXN4G9ZYv+2t5J57JK66JrZX8BShSq/zrCjOLna6CwR
 XNC9aQcq99/D04E5uLxHW5H60VW9VZqUjBbo8rg=
X-Google-Smtp-Source: AGHT+IEMjLX8HYSKM+C5ANZWmjRWKrX6j9BnoMz1b1xVr6nF5RC5qDmsk3tLsdKTPkn6jouJGYyKZQ==
X-Received: by 2002:adf:db09:0:b0:324:8839:cdf6 with SMTP id
 s9-20020adfdb09000000b003248839cdf6mr20048110wri.53.1697050820990; 
 Wed, 11 Oct 2023 12:00:20 -0700 (PDT)
Received: from m1x-phil.lan (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 d13-20020a056402400d00b0053def18ee8bsm633090eda.20.2023.10.11.12.00.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Oct 2023 12:00:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 4/4] hw/sparc64/ebus: Access memory regions via
 pci_address_space_io()
Date: Wed, 11 Oct 2023 20:59:54 +0200
Message-ID: <20231011185954.10337-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011185954.10337-1-philmd@linaro.org>
References: <20231011185954.10337-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

PCI functions are plugged on a PCI bus. They can only access
external memory regions via the bus.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sparc64/sun4u.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index d908a38f73..c871170378 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -360,11 +360,11 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
     pci_dev->config[0x09] = 0x00; // programming i/f
     pci_dev->config[0x0D] = 0x0a; // latency_timer
 
-    memory_region_init_alias(&s->bar0, OBJECT(s), "bar0", get_system_io(),
-                             0, 0x1000000);
+    memory_region_init_alias(&s->bar0, OBJECT(s), "bar0",
+                             pci_address_space_io(pci_dev), 0, 0x1000000);
     pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->bar0);
-    memory_region_init_alias(&s->bar1, OBJECT(s), "bar1", get_system_io(),
-                             0, 0x8000);
+    memory_region_init_alias(&s->bar1, OBJECT(s), "bar1",
+                             pci_address_space_io(pci_dev), 0, 0x8000);
     pci_register_bar(pci_dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->bar1);
 }
 
-- 
2.41.0


