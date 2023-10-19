Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 621967CF0F8
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 09:19:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtNHQ-0005Hy-0P; Thu, 19 Oct 2023 03:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNHD-00058V-W3
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:17:04 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNHB-0003DN-Hb
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:17:03 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3296b3f03e5so6181803f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 00:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697699819; x=1698304619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XTgBuZGYkLbr0wmI8JEwCdSLvjSRDlVIxUJmeWPbI+s=;
 b=B1DK3B28ACzOYr/ul6k4jg9R9rhDsxVWWLnD6Ozk1ob/zB34o75Oc7uiKVy7yINQs5
 p0QHL0AU895qGkyE1o7UwSsulk+qNS3CwIXfHs+1w/V7o6Pahd2LXM5CI/sk1kXVp9Rz
 qQMtDQgPZ6AlElGR1Xia3Okn5/lfRfwDeYRjug8zBvpb4AbHefBB5Vlmd5u3wexXLYI4
 XKaVplk2upg57RdOsQGfH8aE1jN5XF40U80jTuRUtUksz+0xPmu+pAr+TxhIzzj6GHeR
 4n7RhONKRSllMuJeNypDwM7ofBbZYvstyqujn+cuKv83yukoN7YaDIobkyiVbuKjA4Ol
 hbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697699819; x=1698304619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XTgBuZGYkLbr0wmI8JEwCdSLvjSRDlVIxUJmeWPbI+s=;
 b=W5ER8dntl2+9uoagkNzMExa72gyAi1r5OJ5+Yu5bl3w79Jqyi/JKaAwFtUpiB8ff2Z
 R65nUroh5AR9SLLP1OSiHZvHhGBToVVLGAjxa+eBmUwnCDlGivZJzbe4UgBB51H/NHNW
 1JkEYir/EEXoBMv6I/5v4MzPmQTSP8+qWqRpZQ1pATVmYf3gnZEai23eopBuUqxCpVby
 M676EPWuJr6ip4jOzv4ktEraNn+uiult0i2/Wd8TLva4r1FfuUL/B5SDWxPvxcO/MPTO
 n+JdrebcIAmMas+V4CxLGo/plte9zqkZXBHb+935/lgCQP4t/CobPQ9zUZcKKaP1xvZt
 Yuyg==
X-Gm-Message-State: AOJu0YxsfyVOt8TKPUr4rmgSImE/+guDgdxcRfEtVENQIKTmOa6ZscCU
 cUCY+LOOkswYyzYim1MgsDCzQaDvB3nhyKCJc9N10A==
X-Google-Smtp-Source: AGHT+IFt5key9j+OHw7pjjyxACqdt9eup8EiAM9U8IKJhXlFEgUTJlDanHOo4o1bLWzjd172V1bEwQ==
X-Received: by 2002:a5d:5082:0:b0:32d:9ce0:35ae with SMTP id
 a2-20020a5d5082000000b0032d9ce035aemr788960wrt.52.1697699819245; 
 Thu, 19 Oct 2023 00:16:59 -0700 (PDT)
Received: from localhost.localdomain (92.red-88-28-12.dynamicip.rima-tde.net.
 [88.28.12.92]) by smtp.gmail.com with ESMTPSA id
 d14-20020a056000114e00b003232380ffd5sm3732348wrx.106.2023.10.19.00.16.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 00:16:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eric Farman <farman@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-s390x@nongnu.org, Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 04/12] hw/misc/allwinner-dramc: Do not use SysBus API to
 map local MMIO region
Date: Thu, 19 Oct 2023 09:16:02 +0200
Message-ID: <20231019071611.98885-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019071611.98885-1-philmd@linaro.org>
References: <20231019071611.98885-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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


