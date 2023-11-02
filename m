Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0551C7DEF79
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:07:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyUaN-0001ns-MJ; Thu, 02 Nov 2023 06:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyUaK-0001n7-RY
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:05:56 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyUaJ-0003G6-CB
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:05:56 -0400
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-9d274222b5dso113710966b.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 03:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698919554; x=1699524354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HHTnDGBwSfNOPSScc4QpqW/YOvwGN4xwgsL/sR4G1s0=;
 b=GTOU9+B5K6gI8OOjDpK21RGIySp6dHrry34g2BLZzrWvywghh1st0hLYabTRhbQ4zl
 ro7QTh3war/dLA0PyLfmQRJ+no2QJkIteC21y0yDmEFOcstofxvpQVA92bI+UsZh/BYm
 K1Fl9vOPBK5fmiFlm7CM3wIeQlhjJuzLno5KnP/EaSUmFX6ZOimjelitBCGUzeRbGGnf
 QkpOWvoKTstEuAsDp5OtitX11nDFTUCq0uG5BfW3VaMjm8qG5PBPFfkNWUAAas0r8cpl
 baR+EWZieHpBFohMDStzdFGmy6sEPJqVoERw/9ebtR9KfnyyIpByHoqZsq5xzBDXZNzw
 FwoQ==
X-Gm-Message-State: AOJu0YwLJH3PFXH0M3n3ASOfBi0FLWz32qBRgyVt8tiHQpZ2PEjq2cbM
 ee4Bi/brWpfziUxwhNf4IKw2Fz0liBo=
X-Google-Smtp-Source: AGHT+IGzckBwBGe862aCd5akMk2Xj7rAjutFjmZD55tzzq3NmkQ8wBkJ+0GhH9MrlOiC4+C4hFLYGA==
X-Received: by 2002:a17:907:3601:b0:9c6:c987:4434 with SMTP id
 bk1-20020a170907360100b009c6c9874434mr3536547ejc.45.1698919553890; 
 Thu, 02 Nov 2023 03:05:53 -0700 (PDT)
Received: from localhost.localdomain (ip-109-42-115-39.web.vodafone.de.
 [109.42.115.39]) by smtp.gmail.com with ESMTPSA id
 o21-20020a170906359500b009b97d9ae329sm927236ejb.198.2023.11.02.03.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 03:05:53 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/10] hw/m68k/mcf_intc: Expose MMIO region via SysBus API
Date: Thu,  2 Nov 2023 11:05:36 +0100
Message-ID: <20231102100543.4875-4-huth@tuxfamily.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102100543.4875-1-huth@tuxfamily.org>
References: <20231102100543.4875-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.43; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f43.google.com
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

QOM objects shouldn't access each other internals fields
except using the QOM API.

Here the caller of mcf_intc_init() access the MMIO region from
the MCF_INTC state. Avoid that by exposing that region via
sysbus_init_mmio(), then get it with sysbus_mmio_get_region().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20231024083010.12453-4-philmd@linaro.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
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


