Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBA77D1242
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 17:08:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtr5X-0005so-Qi; Fri, 20 Oct 2023 11:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtr5W-0005j1-5e
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:06:58 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtr5Q-0001Ma-AW
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:06:57 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9c75ceea588so142262666b.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 08:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697814410; x=1698419210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5z5NktVu9Z3pjJNFKKbdLfwCXi08dnJZpEWAcQaa1vg=;
 b=r1YIj93WUSMi2ovpYgFOf6NZfLwK7fczygGvAZ/3OKiTXzoQBid4lN0RWd0gfPzoFA
 UGO3ipZmYImqH0trxXAfQ/gtutuqk3eaWtWi8+g0eUujAAX40N/mlYL+W8ibzXsoc6cN
 0rrqRuLkUp6J31LZnXkEJPUXydHX3iU0zbc1cYEL6ixwGytJp7IaMZYb0KE4r5T3flQJ
 AaOlaQDMFZEaqEvCYaVWMF/5lXFvzj+StR7pb4hBMfXhE4y87WrElvgqjGH4dz9ZgcuV
 OVnkF+ZPpr6iiZ2rTGxZ8JB35fJj/f3yRdeCezywaNqC8IxhpZV1cu3bSr8Kfs/G7Zuf
 qqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697814410; x=1698419210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5z5NktVu9Z3pjJNFKKbdLfwCXi08dnJZpEWAcQaa1vg=;
 b=dm5nrPpKGZ3sAdXlvn/vXxsdrXGhf6Dqcir3nuRNiTe0NSyouiw2aJkvdklEgTCqh7
 kdQ0Nhv04clts5WWnjlM4atJdaS5wgwnkz1pFAzdRW09i7wkDqcMvdKBfTPNl0Axmh11
 cknO6TpdxfgTX25iuQNJ2k1QRTW9BP8blHp+cfLlJpeyslGgAUen/9KoC/df+/IT9inB
 Qrhp9ewVM6ObnmzC3Vxm6aItCjUSXbUEiuukROoVJRnDFhRuvmTdG5irL6rlaLMTNcWB
 6PJBfs3336AVhG5Xg90jf+85pTG0jD7BNDcUkFubVQEIXyW/vuyyrK2zkDJfo67NeZYK
 BSgA==
X-Gm-Message-State: AOJu0YyY71HUVsXqhbA9nwKEtGPp4rtRJ9/iRHeN8TJYgWCGQC0GEgzL
 2H7riAZdP/0tAD19sSgZdd4CXEj7vbddHbbbJtg=
X-Google-Smtp-Source: AGHT+IGq6+JLTNqAIQfuz3/8ppC+sJgAJ38w9hpdZhuNF+7s3+tPWebnqTxNKqdDJX8G8LjLqqOxOA==
X-Received: by 2002:a17:907:3d94:b0:9ba:fe6:225 with SMTP id
 he20-20020a1709073d9400b009ba0fe60225mr1518327ejc.55.1697814410576; 
 Fri, 20 Oct 2023 08:06:50 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 d11-20020a170906040b00b0099bd046170fsm1672198eja.104.2023.10.20.08.06.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 08:06:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/6] hw/m68k/mcf_intc: Expose MMIO region via SysBus API
Date: Fri, 20 Oct 2023 17:06:23 +0200
Message-ID: <20231020150627.56893-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020150627.56893-1-philmd@linaro.org>
References: <20231020150627.56893-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

QOM objects shouldn't access each other internals fields
except using the QOM API.

Here the caller of mcf_intc_init() access the MMIO region from
the MCF_INTC state. Avoid that by exposing that region via
sysbus_init_mmio(), then get it with sysbus_mmio_get_region().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/mcf_intc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index 4cd30188c0..1f74ea0e14 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -173,6 +173,7 @@ static void mcf_intc_instance_init(Object *obj)
     mcf_intc_state *s = MCF_INTC(obj);
 
     memory_region_init_io(&s->iomem, obj, &mcf_intc_ops, s, "mcf", 0x100);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
 }
 
 static void mcf_intc_class_init(ObjectClass *oc, void *data)
@@ -211,7 +212,8 @@ qemu_irq *mcf_intc_init(MemoryRegion *sysmem,
     s = MCF_INTC(dev);
     s->cpu = cpu;
 
-    memory_region_add_subregion(sysmem, base, &s->iomem);
+    memory_region_add_subregion(sysmem, base,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
 
     return qemu_allocate_irqs(mcf_intc_set_irq, s, 64);
 }
-- 
2.41.0


