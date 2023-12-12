Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD6080F2D2
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:34:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5hh-0003yc-8v; Tue, 12 Dec 2023 11:33:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5hO-0003Sx-Vj
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:33:35 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5hN-00083C-2q
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:33:34 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40c2db2ee28so61951125e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398811; x=1703003611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejOqBltD1xTQKLI2FwnA20wzkl1UqkA3fAXzw/L3kFk=;
 b=IaDBbg9eRRzuqcShJfVqlY2iA+2LAv5oaGtY3JT6qqMGCPhQmyhgO5us9FCvDkTUk5
 yRqxl88LccdB/Z+bgGk1tNp/J9IUE74JJ31tMEe/crVQOosEbVg/k+zJ4TYDcwmDhWxZ
 rUZ7cOodgJzDiosO1aHu7+5tja+nleu1+IzPfUi7RrhUYti88LpPqmGZzas6hgcyW7q8
 Ob2LO5RPZnl7MKiMdadYMvwpxilsLmjt0LDHkcsmu7eVtMllHc9Y7tzWfwpDi1Bvw2Pj
 dFD1775b4ePgl+VDDybV2TDWt+lBCc7jpWibphiczeWHsLu4qX7soZWNaGaIXdHOHyL+
 WLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398811; x=1703003611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ejOqBltD1xTQKLI2FwnA20wzkl1UqkA3fAXzw/L3kFk=;
 b=KIgXeiZLaLih+aXcUqDUE5ZXpCO4drZMJXdVAGNyYdFvIWSOBm7Z5aJCFscEpplAWp
 Zi5mb/SrTvyLK5ZUCtWip3adu1WppWJx2/WPB+V0aECjfuDbYBTkNIot8e9DhbeGYkUX
 rUKnoXAsDvSWbQPQ3XHGw/OoXv0vLTHwBfgKif2u9MPM1D0NmY2bCPqEIHJh4j1Y6Gy9
 GbXyHv1WpgKnT11biTaiVMmQ3+UCSCN7HCLxwNrMGbwfDkLvJJtjTJFxrs3iyLB1EB4u
 z2yWhfafE0Js8CvCCdki615btgUn8IQ6cotoSXyPz3ten35DesBw6JQVs9nPqWx5+807
 owKw==
X-Gm-Message-State: AOJu0YwouJuC9vJJO7Pd+oDUYb9Ke2ph6j8bVvy1NiP8L/dsviofuj/J
 xLd9/m/sW0ZEQpSeSAKMGH5UQE/vo1/Mzeo4Kbc=
X-Google-Smtp-Source: AGHT+IHgkWlki8ql5EojYFYDQS9C+91RboiBl8Qb2//hW6OcAIW62feJ7Uh7gtJVyNUa844MjFzDFQ==
X-Received: by 2002:a05:600c:3411:b0:40b:5e59:ccb2 with SMTP id
 y17-20020a05600c341100b0040b5e59ccb2mr3422703wmp.147.1702398811326; 
 Tue, 12 Dec 2023 08:33:31 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 k40-20020a05600c1ca800b0040b45356b72sm19317706wms.33.2023.12.12.08.33.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:33:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 32/33] hw/cpu/arm: Remove 'num-cpu' property alias
Date: Tue, 12 Dec 2023 17:29:32 +0100
Message-ID: <20231212162935.42910-33-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

All callers access the 'num-cores' property.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Better to squash earlier and replace in place, so no need for alias?
---
 hw/cpu/arm11mpcore.c     | 1 -
 hw/cpu/cortex_mpcore.c   | 2 --
 hw/cpu/realview_mpcore.c | 1 -
 3 files changed, 4 deletions(-)

diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index 67c96a3a7c..32756e05e9 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -133,7 +133,6 @@ static void mpcore_priv_initfn(Object *obj)
 
 static Property mpcore_priv_properties[] = {
     DEFINE_PROP_UINT32("num-cores", ARM11MPCorePriveState, num_cpu, 1),
-    DEFINE_PROP_UINT32("num-cpu", ARM11MPCorePriveState, num_cpu, 1), /* alias */
     /* The ARM11 MPCORE TRM says the on-chip controller may have
      * anything from 0 to 224 external interrupt IRQ lines (with another
      * 32 internal). We default to 32+32, which is the number provided by
diff --git a/hw/cpu/cortex_mpcore.c b/hw/cpu/cortex_mpcore.c
index c5de6c3ae4..3cc9feef16 100644
--- a/hw/cpu/cortex_mpcore.c
+++ b/hw/cpu/cortex_mpcore.c
@@ -156,7 +156,6 @@ static void cortex_mpcore_priv_realize(DeviceState *dev, Error **errp)
 static Property cortex_mpcore_priv_properties[] = {
     DEFINE_PROP_UINT8("cluster-id", CortexMPPrivState, cluster_id, 0),
     DEFINE_PROP_UINT32("num-cores", CortexMPPrivState, num_cores, 1),
-    DEFINE_PROP_UINT32("num-cpu", CortexMPPrivState, num_cores, 1), /* alias */
 
     DEFINE_PROP_STRING("cpu-type", CortexMPPrivState, cpu_type),
     DEFINE_PROP_BOOL("cpu-has-el3", CortexMPPrivState, cpu_has_el3, true),
@@ -175,7 +174,6 @@ static Property cortex_mpcore_priv_properties[] = {
                      TYPE_MEMORY_REGION, MemoryRegion *),
 
     DEFINE_PROP_UINT32("gic-spi-num", CortexMPPrivState, gic_spi_num, 0),
-    DEFINE_PROP_UINT32("num-irq", CortexMPPrivState, gic_spi_num, 0), /* alias */
 
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index e985d230e0..4d4965126b 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -99,7 +99,6 @@ static void mpcore_rirq_init(Object *obj)
 
     object_initialize_child(obj, "a11priv", &s->priv, TYPE_ARM11MPCORE_PRIV);
     object_property_add_alias(obj, "num-cores", OBJECT(&s->priv), "num-cores");
-    object_property_add_alias(obj, "num-cpu", OBJECT(&s->priv), "num-cores");
     privbusdev = SYS_BUS_DEVICE(&s->priv);
     sysbus_init_mmio(sbd, sysbus_mmio_get_region(privbusdev, 0));
 
-- 
2.41.0


