Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 324E97CDEA3
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:13:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7Hl-0006lE-T9; Wed, 18 Oct 2023 10:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt7Hk-0006km-Gc
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:12:32 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt7Hi-0004ph-1E
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:12:32 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9be7e3fa1daso728907366b.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 07:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697638347; x=1698243147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U5zian4RrM8OBn3rj31JdRNyc5wh1SA22kx5TYn7Hao=;
 b=B3URizAA0sNJB5/H0eeDF8cIO7XCncVZNMCsDuRKCO6uX+jqTYyqqgV5H+eySIClKM
 SuBtfxWvXx1GW2XeTw+PdB8Vu+3flEkcEYsJ+twiyQ5nb2mTlddNgwSa7ynRpHBquKx7
 y39UP9gK8L5znYdS4wzyb8ixr7C5781fOs2I8VXIEziunfMtUtKCboQt+Q3MCUN89zJu
 U1fmgwTHAPwzrSIjRX+r1tax/orRWJCKLSXaNrbhmrwudN01wxe9+05gs8/a5Q7mqTxK
 VNk8zV2uDDgke8NHrNliejfBTyC9GZD3SC5yWCGmVzMiUgjjlMEXflFcu1CmZEjC2tjI
 PELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697638347; x=1698243147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U5zian4RrM8OBn3rj31JdRNyc5wh1SA22kx5TYn7Hao=;
 b=e2sISf7Ru5ydG3nJ5JB2mSjY7s0E6QOaGAxQfMb16SejMQtoTFUDBCJslnSWNfAJK/
 MmXAzfKOb2f1YepiBVUULco9rCyxN76Nyv/AtYhobHHMxQRZgd3tet+2eOTi9Cu3nJfb
 x05cPQb3b/LY7+S/9o6XJ/M82zjSgaSibFZVt2v2QrV+ZHN0FK/LZhmlyW/rTfFtzRY1
 HWtLiiY8Lwwhi+eCR8J4YnTeo4gt9r0HlLTjs4fpYgRHEgrGYV5Ytbzi1nEXTnXOh40l
 1SKVU9/ekOTDydcZv5z7CQVFeKlAhy7evR06DCSzxW5AVqFSDhtf6PY3l1Az7VTd7V0E
 rRmw==
X-Gm-Message-State: AOJu0YwpPQx6e++WsHK7RtyeaB7reVCcMD9PsWx/43LR0iuebbtOJmH5
 1vbsVkM8kY0LDBicsQW+O6yHHBsS4cGEqj2nnzc=
X-Google-Smtp-Source: AGHT+IHYCSEUQKVZcas0DvgTW2/YKlCfbIArdhMOhM9c5+/Xb4vaTJ8qHwuuGAtkVGLFdv4jyAn+8g==
X-Received: by 2002:a17:907:25c1:b0:9be:ef46:6b9c with SMTP id
 ae1-20020a17090725c100b009beef466b9cmr4047074ejc.70.1697638347467; 
 Wed, 18 Oct 2023 07:12:27 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 q20-20020a170906145400b009c387ff67bdsm1795642ejc.22.2023.10.18.07.12.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 07:12:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 04/12] hw/misc/allwinner-dramc: Do not use SysBus API to map
 local MMIO region
Date: Wed, 18 Oct 2023 16:11:42 +0200
Message-ID: <20231018141151.87466-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018141151.87466-1-philmd@linaro.org>
References: <20231018141151.87466-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/allwinner-r40-dramc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/misc/allwinner-r40-dramc.c b/hw/misc/allwinner-r40-dramc.c
index 2cc0254a55..3d81ddb2e1 100644
--- a/hw/misc/allwinner-r40-dramc.c
+++ b/hw/misc/allwinner-r40-dramc.c
@@ -414,7 +414,6 @@ static void allwinner_r40_dramc_reset(DeviceState *dev)
 static void allwinner_r40_dramc_realize(DeviceState *dev, Error **errp)
 {
     AwR40DramCtlState *s = AW_R40_DRAMC(dev);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
     if (!get_match_ddr(s->ram_size)) {
         error_report("%s: ram-size %u MiB is not supported",
@@ -422,23 +421,23 @@ static void allwinner_r40_dramc_realize(DeviceState *dev, Error **errp)
         exit(1);
     }
 
-    /* R40 support max 2G memory but we only support up to 1G now. index 3 */
+    /* R40 support max 2G memory but we only support up to 1G now. */
     memory_region_init_io(&s->detect_cells, OBJECT(s),
                           &allwinner_r40_detect_ops, s,
                           "DRAMCELLS", 1 * GiB);
-    sysbus_init_mmio(sbd, &s->detect_cells);
-    sysbus_mmio_map_overlap(sbd, 3, s->ram_addr, 10);
+    memory_region_add_subregion_overlap(get_system_memory(), s->ram_addr,
+                                        &s->detect_cells, 10);
     memory_region_set_enabled(&s->detect_cells, false);
 
     /*
      * We only support DRAM size up to 1G now, so prepare a high memory page
-     * after 1G for dualrank detect. index = 4
+     * after 1G for dualrank detect.
      */
     memory_region_init_io(&s->dram_high, OBJECT(s),
                             &allwinner_r40_dualrank_detect_ops, s,
                             "DRAMHIGH", KiB);
-    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->dram_high);
-    sysbus_mmio_map(SYS_BUS_DEVICE(s), 4, s->ram_addr + GiB);
+    memory_region_add_subregion(get_system_memory(), s->ram_addr + GiB,
+                                &s->dram_high);
 }
 
 static void allwinner_r40_dramc_init(Object *obj)
-- 
2.41.0


