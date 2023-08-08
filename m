Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 968F4773917
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 10:36:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTIBa-0004Gq-9j; Tue, 08 Aug 2023 04:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qTIBW-0004EY-K5; Tue, 08 Aug 2023 04:35:22 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qTIBU-0004NZ-SU; Tue, 08 Aug 2023 04:35:22 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bb9e6c2a90so47333175ad.1; 
 Tue, 08 Aug 2023 01:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691483719; x=1692088519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MWMOGoc8MASPMcsU31cUu07Cy8VS8fV2qqbIFZ8ZRM4=;
 b=O7I2GHz3pePM5KHN3n6+EDN3VIVAzU9mzShvCm4se3bzh1fsuySNKsHGXTnrN0n54W
 udkDvCs2LHTuFtWEuDFNe4MEEIp7yUEbADKN9sm4LdAj2c1PzHELSM9MCFIK67sqR8ea
 U3SsSPQMbgZBIzEdCjo8FwpboRSbwBVWsygVkTFPjuguHzcrrVKjKXaK1g5p56SXGrGu
 tWMt5zAs8rfLg7JdmtotxhZDrPOanaUop5VUUhrskXOE8Fp8J4eFWVsXPpurLrKcdLHE
 bb4GnUOrDGYJ1INSNI0pzSkAzSgRNpqvPS4uF3zwKqol/8ZV9nHSU4bmF8X1qA0+Wd/3
 VW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691483719; x=1692088519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MWMOGoc8MASPMcsU31cUu07Cy8VS8fV2qqbIFZ8ZRM4=;
 b=ZS/wfjo23pDbuD/rN1WmISjYiDOgMwdhZBKGQLP/4R0P+CkpOkaSkF7nTxgKfhVUeN
 shaieziXvlcif4mv9sDb8G5iSgm8OqjA4d/BdBLQyYPWTThP+dLqyEyop/DWULEvbZ4N
 RqiiWKhWltlDEaCeNHwcImmRpWeu7a8QUyfq+53lflYFJRVE212scv877vTQwy3mHibS
 LjCvtU0NEhJS9eeOuoFMo2ZvzA1BuXfEWUzJfjDjnSQY3QC4vvc3w23HctcPsTPNP/v6
 psl7jFXegsWi+DPNotJh2rwevktt9jpIwyOzhSyeePEEk83hpQGBj+h3h1/Q8TjEvL3A
 85Tg==
X-Gm-Message-State: AOJu0Yxlp1kU0T5HAgUBPv+ELhuMusnm3wQCqdaxd02L0J4LBqS2t00I
 ylMXST6saX/nIJLP+bR1/WA=
X-Google-Smtp-Source: AGHT+IG59e9fus6Zmhixy7PaaeyZ5/iOnVQp4Ehx2vr6gdKH1VB/oLYe7sD/PLJ0CxU/7caNcXDmnA==
X-Received: by 2002:a17:902:c952:b0:1ac:5717:fd5 with SMTP id
 i18-20020a170902c95200b001ac57170fd5mr15884799pla.60.1691483719130; 
 Tue, 08 Aug 2023 01:35:19 -0700 (PDT)
Received: from voyager.lan ([45.124.203.19]) by smtp.gmail.com with ESMTPSA id
 n9-20020a170902e54900b001b8062c1db3sm8368112plf.82.2023.08.08.01.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 01:35:18 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-8.2 1/3] pnv/lpc: Place mmio regs in their own memory
 region
Date: Tue,  8 Aug 2023 18:04:43 +0930
Message-Id: <20230808083445.4613-2-joel@jms.id.au>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808083445.4613-1-joel@jms.id.au>
References: <20230808083445.4613-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The P9 and P10 models re-used the xscom_regs memory region for the mmio
access, which is confusing.

Add a separate memory region in preparation for enabling both xscom and
mmio access.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/ppc/pnv_lpc.h | 3 ++-
 hw/ppc/pnv.c             | 4 ++--
 hw/ppc/pnv_lpc.c         | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index 5d22c4557041..3000964f8999 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -81,8 +81,9 @@ struct PnvLpcController {
     uint32_t lpc_hc_irqstat;
     uint32_t lpc_hc_error_addr;
 
-    /* XSCOM registers */
+    /* Registers */
     MemoryRegion xscom_regs;
+    MemoryRegion mmio_regs;
 
     /* PSI to generate interrupts */
     qemu_irq psi_irq;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index eb54f93986df..afdaa25c2b26 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1565,7 +1565,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
         return;
     }
     memory_region_add_subregion(get_system_memory(), PNV9_LPCM_BASE(chip),
-                                &chip9->lpc.xscom_regs);
+                                &chip9->lpc.mmio_regs);
 
     chip->fw_mr = &chip9->lpc.isa_fw;
     chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
@@ -1784,7 +1784,7 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
         return;
     }
     memory_region_add_subregion(get_system_memory(), PNV10_LPCM_BASE(chip),
-                                &chip10->lpc.xscom_regs);
+                                &chip10->lpc.mmio_regs);
 
     chip->fw_mr = &chip10->lpc.isa_fw;
     chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index d692858bee78..caf5e10a5f96 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -664,7 +664,7 @@ static void pnv_lpc_power9_realize(DeviceState *dev, Error **errp)
     }
 
     /* P9 uses a MMIO region */
-    memory_region_init_io(&lpc->xscom_regs, OBJECT(lpc), &pnv_lpc_mmio_ops,
+    memory_region_init_io(&lpc->mmio_regs, OBJECT(lpc), &pnv_lpc_mmio_ops,
                           lpc, "lpcm", PNV9_LPCM_SIZE);
 }
 
-- 
2.40.1


