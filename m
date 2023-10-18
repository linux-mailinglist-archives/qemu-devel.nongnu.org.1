Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9537CDEA7
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:13:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7Hi-0006ea-9k; Wed, 18 Oct 2023 10:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt7Hc-0006bw-Ve
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:12:25 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt7Ha-0004oZ-3a
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:12:24 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9b9faf05f51so1061804766b.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 07:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697638340; x=1698243140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OG/eTeWn+OzUtyx8iBSPb0Amcuu5LlJ9K/x3TvIXfKM=;
 b=O6XBzWAGJEbDYnp9Qhkf44wboosoFezSlnL8AqWEa0PHlRXYOAcefz8acs0DWCpZI/
 mCzDQk2xfLucil+lpXTbCG6wSM2zfoatCIsVfjk2goQk8pMVtMg5Kxwm9NZmWUYChIWW
 JigeAgt+IB36yuvcRoOaInA20B9d1qIHTUZGKeEffM93+fX37G/ZI+mM1jHS4J4Vu1QU
 w/wFJws+AtB6OfG8Q8kacOC715s36oqWFPtJiEAs7ctmNs9dZI0bAuefYRboZT9ggR1B
 gOLpLdH6X2T71a8bGBe9560bYMj8buKRkGYJjN0hXwXsVZg2xuClVQ5iNtdWp4b7qIhd
 jRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697638340; x=1698243140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OG/eTeWn+OzUtyx8iBSPb0Amcuu5LlJ9K/x3TvIXfKM=;
 b=AiKcEUDCsQj0M0/qvZqRPsXshxUL2uvSOrVo1hLBLdH49I6DkTnRZ9X9uWQI4s3Nyr
 3eUpHi2bZPW3jcW/fidDSYUQHDqTLJjkqxo3Wo1gdOh6UGeYes1/+uxrw4TNcUjPpLB/
 QE0ORgMPdHaOOUGLS1cw/kDVUpMlX+ZHNuvtLxTmUQ+NWs7sHJSFc5lRnzKTeGIzRflx
 YYt5BSdMfF9YbCU/eLEsf8aVMV9w7AwJ3XZHDoxxu0Cnl0VvMybVLpzLJBNaoncHenTt
 lhgrWYS04joenD4AdAe4Fo7mvtUVUWkKJr+ZuRMGMl/vZC363M08kydEsgRiQ4BXGKFE
 ymGw==
X-Gm-Message-State: AOJu0YzxmM/4TPGJ9glcCnc4q9zxGWk6PfSY6LKvHFIKfzptYuIjYq6d
 MY7+4w2Pmiox9hfUt+yCb6363sO3QFffRlZzx+8=
X-Google-Smtp-Source: AGHT+IFFhseKzBpfBoZ5nmkWhC9OVraNp+4L/k01QPK0eJmjTN3QoKDolKoQXl81U6xmWjLdbCEuLg==
X-Received: by 2002:a17:907:98e:b0:9bd:fa48:83c5 with SMTP id
 bf14-20020a170907098e00b009bdfa4883c5mr3938988ejc.70.1697638340025; 
 Wed, 18 Oct 2023 07:12:20 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 2-20020a170906224200b009c6e58437dasm1783529ejr.37.2023.10.18.07.12.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 07:12:19 -0700 (PDT)
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
Subject: [PATCH 03/12] hw/misc/allwinner-dramc: Move sysbus_mmio_map call from
 init -> realize
Date: Wed, 18 Oct 2023 16:11:41 +0200
Message-ID: <20231018141151.87466-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018141151.87466-1-philmd@linaro.org>
References: <20231018141151.87466-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

In order to make the next commit trivial, move the sysbus_init_mmio()
call in allwinner_r40_dramc_init() just before the corresponding
sysbus_mmio_map_overlap() call in allwinner_r40_dramc_realize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/allwinner-r40-dramc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/misc/allwinner-r40-dramc.c b/hw/misc/allwinner-r40-dramc.c
index 6944f84455..2cc0254a55 100644
--- a/hw/misc/allwinner-r40-dramc.c
+++ b/hw/misc/allwinner-r40-dramc.c
@@ -414,6 +414,7 @@ static void allwinner_r40_dramc_reset(DeviceState *dev)
 static void allwinner_r40_dramc_realize(DeviceState *dev, Error **errp)
 {
     AwR40DramCtlState *s = AW_R40_DRAMC(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
     if (!get_match_ddr(s->ram_size)) {
         error_report("%s: ram-size %u MiB is not supported",
@@ -421,8 +422,12 @@ static void allwinner_r40_dramc_realize(DeviceState *dev, Error **errp)
         exit(1);
     }
 
-    /* detect_cells */
-    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s), 3, s->ram_addr, 10);
+    /* R40 support max 2G memory but we only support up to 1G now. index 3 */
+    memory_region_init_io(&s->detect_cells, OBJECT(s),
+                          &allwinner_r40_detect_ops, s,
+                          "DRAMCELLS", 1 * GiB);
+    sysbus_init_mmio(sbd, &s->detect_cells);
+    sysbus_mmio_map_overlap(sbd, 3, s->ram_addr, 10);
     memory_region_set_enabled(&s->detect_cells, false);
 
     /*
@@ -458,12 +463,6 @@ static void allwinner_r40_dramc_init(Object *obj)
                           &allwinner_r40_dramphy_ops, s,
                           "DRAMPHY", 4 * KiB);
     sysbus_init_mmio(sbd, &s->dramphy_iomem);
-
-    /* R40 support max 2G memory but we only support up to 1G now. index 3 */
-    memory_region_init_io(&s->detect_cells, OBJECT(s),
-                          &allwinner_r40_detect_ops, s,
-                          "DRAMCELLS", 1 * GiB);
-    sysbus_init_mmio(sbd, &s->detect_cells);
 }
 
 static Property allwinner_r40_dramc_properties[] = {
-- 
2.41.0


