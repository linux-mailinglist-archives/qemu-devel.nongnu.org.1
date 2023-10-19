Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C509C7D03FE
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:27:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaT6-00031k-FD; Thu, 19 Oct 2023 17:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaT4-0002sH-AM
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:22:10 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaT1-0008KZ-HS
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:22:10 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-507a3b8b113so164815e87.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750525; x=1698355325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mySmSJOrGLyGZadXYNDWy1G5mj7NTLtIFHeDWQ7Xcwk=;
 b=Keu3ui6XR4ZkzkIxVpOkKp0OHMU/DQvHoZx+PdCRjGDYJ9lvajma+Fjz6O25MNnZa8
 OkUP6YRyv5To2FKCwfaPVY2ZX+x0ElOKSEs7001h6k8V6PWQWkKlG/DWgg3YLv47Nv/r
 YCOWuu2ItbOapl+M/OmtYg/Fo4t8u5NbvkhS3HK13zjqpFAeJYW6V5uoLYAXYfAZXd7m
 6yQiRviel52zJ6EuUYKpl3SWiFBnsh4ARomueSocp4sR6rDne8azoy+BJvH7MjmzyCBP
 3K9V9F4pmR6TGRWmWwZCi/2mC5JZKJvn7z4zDvztUa/xqv+7svRJvekRtrxoPqytxR5Y
 fZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750525; x=1698355325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mySmSJOrGLyGZadXYNDWy1G5mj7NTLtIFHeDWQ7Xcwk=;
 b=E97zZmbxwyZ4Cak4A8BsRUVayUHMjAgZhPOP8z38vNHuMLAx/f0NaVesKQBE6aFI8p
 WC61lv5hvXMsyQJWiKchY4HxDpPJOxU3QVXS39GKPEPwfoSWuJRsbUatO4TKSSQbOvvB
 xt9dxIyxlMS7oI87kHE8gd1Utn6+jXhs3mg4CbY62YfWXaa+K7HC06Udq//E6AWappW/
 a8KvwRFA3N0GDyUgdIihabjBTmRAAhAmlCC4yHQvAkmpOa8e7WzF5zGfC2jY3T7iTtcv
 8W/vCYvNvhEo/V5/VbnedHA4OdqXd4NhHlOG6ORsdIRuRggsB+s2tFQbyZvSbakHiKSz
 NNlg==
X-Gm-Message-State: AOJu0YwliR27FtbYp0/ToW/jDEd8parC33rlaN9h3tMhRICdEUtFCXQf
 2sG/6SGTWFso93ZEKyiP2MpCGIMDvg1lzBCZNggrHg==
X-Google-Smtp-Source: AGHT+IFmboZd305PFOySmEhzqHe1CQ6fidqPUOXfmuQEy7sSgBbbWPSaV9Vbke3wmSWarCqRDTdHQg==
X-Received: by 2002:a05:6512:515:b0:507:9a8c:a8fe with SMTP id
 o21-20020a056512051500b005079a8ca8femr2261947lfb.53.1697750525429; 
 Thu, 19 Oct 2023 14:22:05 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 h12-20020adff18c000000b0032d402f816csm213757wro.98.2023.10.19.14.22.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:22:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Subject: [PULL 34/46] hw/misc/allwinner-dramc: Do not use SysBus API to map
 local MMIO region
Date: Thu, 19 Oct 2023 23:17:59 +0200
Message-ID: <20231019211814.30576-35-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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
  +    memory_region_add_subregion(get_system_memory(),
  +                                addr, subregion);

  @@
  expression priority;
  @@
  -    sysbus_init_mmio(sbdev, subregion);
       ... when != sbdev
  -    sysbus_mmio_map_overlap(sbdev, index, addr, priority);
  +    memory_region_add_subregion_overlap(get_system_memory(),
  +                                        addr,
  +                                        subregion, priority);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231019071611.98885-5-philmd@linaro.org>
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


