Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5057D4A18
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:31:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvCoL-0001fL-DH; Tue, 24 Oct 2023 04:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvCoJ-0001ey-KQ
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:30:47 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvCo4-0001Ag-De
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:30:47 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5079f3f3d7aso6626377e87.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 01:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698136229; x=1698741029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xfu4/2AUQ8XPD1VFcNgXAyGx5PWs1jSOc11hThF88Y4=;
 b=Z0g/pdCR8GpN7rSJzo7N7wiKYbFrAAkiG8mDec8DWBEei5Yl7Y401ac1vOvvGpLSMF
 l/CmZudLybt/riy5KSC4XntMDGCvnBs3kKocPKNoW3NT5keBq3GOb+qpYOyXvvquvAD+
 TwFy99FbpRz1vsn1nAkI1zwx0/1kQGvaDwTikt5CdZ8hrPppDzt3Cjib+BKIgrVjEgV8
 j+fkP8f7ow/6bORxqHtTYsh+LLU1hgWn8AlELAKO8ggsxsnen6eMrjYvWVfnE7eR9875
 XU98YclqnWw3pfj07mC6Jzlte5EkC+60ErFlcdSoZTkpIqDep6knipdNKZPti41Kba9j
 hLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698136229; x=1698741029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xfu4/2AUQ8XPD1VFcNgXAyGx5PWs1jSOc11hThF88Y4=;
 b=ripKM+Gb2kYnRip7pIkseEgeW1VV0/Wj1H4YJaMGmsMFoWM3/nxDjJbIW79LJJuO5K
 EM5wUoC/LEih0K9a7BKPXqcr/Zq8vOuGHSo0VOL/lQ19d3VYXVyHt113hYpcNH8FeycW
 z3feXK8EdKBuL92Hj9dL5zRktqCkRi7k2aMmMyvSrTdigDzvKkVHAgosR7PkPe0Tymjx
 mWX0tMHBRArYRfmyTAgsZP/lXyT/ZYgoN4SJ9FoMb1eRC48YQ+/wFep8foB2M7JWEBfm
 NmKf8NFwfn5S+G4YcQrCfab40pvgbe6i+M8jswkmnC0ll7h4PoXzMGNNr39qXk60VVkQ
 yzKw==
X-Gm-Message-State: AOJu0YzSDl2whaJXzCjnsj3bk4fla9OYPqJ6rMneGGIGqo1d0JJI/pPn
 lo8Ip7w7pzXiYAq3JZOj3VaGcXaLTH79fHTVCOo=
X-Google-Smtp-Source: AGHT+IFthrZukM56QE4AQ27nLFAhunEabioL0ip9WqIQPQAbrPRXnx+b1Awj9LP+4j8BE9CX5wqYfQ==
X-Received: by 2002:a19:5051:0:b0:504:7bb0:9d7e with SMTP id
 z17-20020a195051000000b005047bb09d7emr7159725lfj.27.1698136229373; 
 Tue, 24 Oct 2023 01:30:29 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 d14-20020adffd8e000000b0031984b370f2sm9365431wrr.47.2023.10.24.01.30.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 01:30:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 3/6] hw/m68k/mcf_intc: Expose MMIO region via SysBus API
Date: Tue, 24 Oct 2023 10:30:06 +0200
Message-ID: <20231024083010.12453-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024083010.12453-1-philmd@linaro.org>
References: <20231024083010.12453-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
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


