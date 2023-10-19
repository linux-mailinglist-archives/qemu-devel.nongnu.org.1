Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4737D03D2
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:23:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaSQ-0001Lb-2A; Thu, 19 Oct 2023 17:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaSL-0001Gc-Go
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:21:26 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaSI-0006MM-IZ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:21:25 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31fa15f4cc6so102235f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750476; x=1698355276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJy63F2Y201nxV5c/iu+pbyPejqWGhQMq+Ig4NcSxhc=;
 b=ezq+9gKjbreK17jkciDT3qwR9FXiK2WpCpVX4Z59wGCma84onKJgq/dPJHttdBpXfP
 w/k19ZwSbvyjYXKxay+EkbHKS2mqsFahrEWy+GSvZPtdgEBze8A77seQO+FYO3DItFvf
 uos8G7wgZ3S0sd7CWa4uOtjQPSUHQaFtHG2haFePlMJua8dxwsNhNuXQyAc4da4ZP6U5
 7q/H4p1ER1I9IHJqgTZ1bDpXKoEprLE2UGwsn8dq4xSC10nC6oHvTTHAvhU52Npzf/SC
 23Mtg4kBrp2cy932HqH/9Ud3TShfKxjh4xhC2FYyfCb2S98cs18x8H7iJY7VBEDVXVs5
 ueqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750476; x=1698355276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cJy63F2Y201nxV5c/iu+pbyPejqWGhQMq+Ig4NcSxhc=;
 b=ERuytQm41Z541feIWrAddHZAwIyULO1A+fm9JJtg1TBJGzyWZw999yXkIWEEcyhcon
 Zzg+rpvOr2mNTZYMmUx8kOb3z9/ilfaU1H8L9uNmty1M2a1T7AR2mzYNL2bfUSHgGS7h
 8e52zZ/TRtH4KEDMbisfUBlKOEHmiGl67A84eo961xYfL8EsYIt2edj8GIwTz6MG65Cu
 CBUFp3XrkiKbrFucgnPd4AanBpdYJitw1sED1Dzp3dddbL+wP+35xkwUsew/JQH4fl+d
 H5xJ+NM13tVX1qn1EKX5ig7eHRu1tUyX3rXdcYwWtpupwL3PhJn6NqJfArF0rkWCPJUQ
 BgCw==
X-Gm-Message-State: AOJu0Yy5IoVrN1/7C8wXdMHhiJAGfwx3tFKFZksS/S45rVKdC17pJ68O
 lo3HOz7K9YnvuEIhIFl00WOrcnsaxqzvvBFZljib9Q==
X-Google-Smtp-Source: AGHT+IEOWe3rxfDLA6ssBL42Q672Z8/PvDEtHk3hTCO0fXmewHyMJ1DrkAfLIx4jyDodSE/qiizMxw==
X-Received: by 2002:adf:e80e:0:b0:32d:a98c:aa20 with SMTP id
 o14-20020adfe80e000000b0032da98caa20mr2342791wrm.59.1697750476607; 
 Thu, 19 Oct 2023 14:21:16 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 w11-20020a5d608b000000b0032008f99216sm213341wrt.96.2023.10.19.14.21.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:21:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PULL 27/46] hw/ppc/pnv: Do not use SysBus API to map local MMIO
 region
Date: Thu, 19 Oct 2023 23:17:52 +0200
Message-ID: <20231019211814.30576-28-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

There is no point in exposing an internal MMIO region via
SysBus and directly mapping it in the very same device.

Just map it without using the SysBus API.

Transformation done using the following coccinelle script:

  @@
  expression sbdev;
  expression index;
  expression addr;
  expression subregion;
  @@
  -    sysbus_init_mmio(sbdev, subregion);
       ... when != sbdev
  -    sysbus_mmio_map(sbdev, index, addr);
  +    memory_region_add_subregion(get_system_memory(), addr, subregion);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20231019131647.19690-6-philmd@linaro.org>
---
 hw/ppc/pnv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 10158f7684..c0e34fffbc 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1217,10 +1217,9 @@ static void pnv_chip_icp_realize(Pnv8Chip *chip8, Error **errp)
 
     name = g_strdup_printf("icp-%x", chip->chip_id);
     memory_region_init(&chip8->icp_mmio, OBJECT(chip), name, PNV_ICP_SIZE);
-    sysbus_init_mmio(SYS_BUS_DEVICE(chip), &chip8->icp_mmio);
     g_free(name);
-
-    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 1, PNV_ICP_BASE(chip));
+    memory_region_add_subregion(get_system_memory(), PNV_ICP_BASE(chip),
+                                &chip8->icp_mmio);
 
     /* Map the ICP registers for each thread */
     for (i = 0; i < chip->nr_cores; i++) {
-- 
2.41.0


