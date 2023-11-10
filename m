Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D796F7E7A79
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 10:09:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1NUV-0005yd-LN; Fri, 10 Nov 2023 04:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1r1NUS-0005yF-PK
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:07:48 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1r1NUO-0000r0-0u
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:07:46 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507bd64814fso2509599e87.1
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 01:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699607261; x=1700212061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EzWAd4i8SfrnOVX1XV2s9b3+InPfyVDmDF/a6BICHBE=;
 b=elfKYo5sfA+dHJSFEjHuVknPtwRegB0+YWVERW8Sxiq9jw1f4D3+c4mbb+pcbOzhIi
 QA4aRI3tdlYQN5k7FrNsT2gwkQkclD9DuEwfRcf42BghRFDv6YqwbLTvNOcBTTTGl9Sh
 blmS/RPKzEdh9b5iDe2uXhK4Kd/XfIXi2mIpZsX/Rkvs79aFxN2igUW304KFzzkd4HJQ
 RDjqvMzOD1+PgKiu6kibZdr6ZL9vD2Kb8OiB4xQrFCx/Ow59WAOhs2rbclrLQE7eFNWT
 qc3Tf8bGgMmCobJ32wWIlDJMvXktGlr8qTpD6PzFoSEQdrIzSWGpyJddm+6OJwKSERxC
 74ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699607261; x=1700212061;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EzWAd4i8SfrnOVX1XV2s9b3+InPfyVDmDF/a6BICHBE=;
 b=CB8F+veMXRJwNJKExeWqKnmHRaVwd68p+jzmKs9C/MJIuvOsmMdH5K5Xz147a+1HN4
 mnN7yls0qDwDM+5keJMqRMlLXtxMxNSIpuhDAD9q28OH+YOyKoPFjSfy7rAUjJOxPSY2
 r87XWGv1kUzopPgDrISC7VKQolb8Mgp97dkiS9+wOWKfJb/aNVtR0utsPegwFQPjiqPy
 lkPpzRIG0o9W8/RQDA13bCAtfnD391QHy0HaW1eGLXSP8XKH1Rmm0hqoQ3Vj3zKi7rZ2
 cb+rz6l3oaRLdQCKsnylS+baqtq9ZnJUqtnof1avIx+DpvLEFQCFNuzxATbgrPMu7V4l
 4v+w==
X-Gm-Message-State: AOJu0YxqvyY4Fd1eTVJ0ftSNvXuJVcHf1NPQbtKK3w4gZq/paSihCP71
 HJPPvsWnW3zhyBd+PzFQBDDtiQ==
X-Google-Smtp-Source: AGHT+IHsnoIQc227pduT9sUgfkSjsUR1F55mBRat9+peuDdECm0KUhvOxZ2tkmbxF1xfWNvxfbqbTw==
X-Received: by 2002:a2e:92d7:0:b0:2c5:1f57:1ef5 with SMTP id
 k23-20020a2e92d7000000b002c51f571ef5mr6588095ljh.39.1699607260695; 
 Fri, 10 Nov 2023 01:07:40 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a05600c138800b004075d5664basm4631372wmf.8.2023.11.10.01.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 01:07:40 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] hw/arm/virt: fix GIC maintenance IRQ registration
Date: Fri, 10 Nov 2023 09:05:58 +0000
Message-ID: <20231110090557.3219206-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=jean-philippe@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Since commit 9036e917f8 ("{include/}hw/arm: refactor virt PPI logic"),
GIC maintenance IRQ registration fails on arm64:

[    0.979743] kvm [1]: Cannot register interrupt 9

That commit re-defined VIRTUAL_PMU_IRQ to be a INTID but missed a case
where the maintenance IRQ is actually referred by its PPI index. Just
like commit fa68ecb330db ("hw/arm/virt: fix PMU IRQ registration"), use
INITID_TO_PPI(). A search of "GIC_FDT_IRQ_TYPE_PPI" indicates that there
shouldn't be more similar issues.

Fixes: 9036e917f8 ("{include/}hw/arm: refactor virt PPI logic")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 hw/arm/virt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 783d71a1b3..f5e685b060 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -591,7 +591,8 @@ static void fdt_add_gic_node(VirtMachineState *vms)
 
         if (vms->virt) {
             qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
-                                   GIC_FDT_IRQ_TYPE_PPI, ARCH_GIC_MAINT_IRQ,
+                                   GIC_FDT_IRQ_TYPE_PPI,
+                                   INTID_TO_PPI(ARCH_GIC_MAINT_IRQ),
                                    GIC_FDT_IRQ_FLAGS_LEVEL_HI);
         }
     } else {
@@ -615,7 +616,8 @@ static void fdt_add_gic_node(VirtMachineState *vms)
                                          2, vms->memmap[VIRT_GIC_VCPU].base,
                                          2, vms->memmap[VIRT_GIC_VCPU].size);
             qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
-                                   GIC_FDT_IRQ_TYPE_PPI, ARCH_GIC_MAINT_IRQ,
+                                   GIC_FDT_IRQ_TYPE_PPI,
+                                   INTID_TO_PPI(ARCH_GIC_MAINT_IRQ),
                                    GIC_FDT_IRQ_FLAGS_LEVEL_HI);
         }
     }
-- 
2.42.0


