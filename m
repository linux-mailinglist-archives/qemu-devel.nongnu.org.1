Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEE274B028
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:45:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHji8-0004aw-F4; Fri, 07 Jul 2023 07:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHji5-0004LU-JZ; Fri, 07 Jul 2023 07:33:13 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHji2-0006qX-Iq; Fri, 07 Jul 2023 07:33:13 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6b5d5e6b086so1085635a34.1; 
 Fri, 07 Jul 2023 04:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729584; x=1691321584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p/GxMQMavw5Cwmp/cFEwPDkTT6/BM+6Or9w33NsKt4c=;
 b=Sc8MoUkfe+dEQ9poimAw85gHUBQPECMvspQgkizCteUrR+OVn5/pYQFEiENHv7Q7uM
 fAstc1qQeXw7A7J85hSRLaw9kbP3s9MqzNXK4Jwzw9ByKFrtMWSAKr8J+J7/EKpcI1Vg
 ftjSNiDMPnCXgWAtDJXAyUu5IuMZu7rofPmg6gJrQvvZMvFie0AqWhuH4n72MtBi8Hv5
 3ZKvdMgjx4IbmBABlBarbyy6j2+28GcfUHFLTVfjhvZqqn292OFaVdnKIwupHO+aMQ0g
 D3285QrQAD3CJD152bLX8Iqm4Dgj7ASmh0ikGaY06AaUBhWxKTazyxsHi8WWpv13H8DS
 UQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729584; x=1691321584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p/GxMQMavw5Cwmp/cFEwPDkTT6/BM+6Or9w33NsKt4c=;
 b=lN9bYLcXN1btlI6yofwvG9DRGUSEvEVkKzmbz5grah8pyhj8yaLfUFuzawIe6J4EQG
 Sjiqbj6CfV9qoOwGGeWcr6LGvgwMOK2OKK1vVETQvrwaTtceehPTVXC4ZNdgFK2YuzJS
 kbcxeBnRuN3UkOk2bpkDXzhfxn+0PJLkzMXNFc93F63W2lyeKlQNDY2dMRx7PsJZbmin
 d0SUfhigW5X4An5uA76ldYlCrrKSgze7/+9nJeAc873ZTkDa5dN+Fai2khGav0MG1CPR
 asatptamYew90g/aUAFPmTrx12NP1J2Ihqo4P1WCBmZ7CM8+3Qmp7SuAX72siF+Dg6Z1
 k+/w==
X-Gm-Message-State: ABy/qLYzTxy+9UaSft8VMXCxwXoikZaNrzcrAJ01uakXWHn6Xq1y6DF8
 zd8YE3005nP35N3KitemppXCfrShXH0=
X-Google-Smtp-Source: APBJJlHeEYHSXZF4KqHCPDcIkLCnOjVs7xWIsQjIKpYr7oQoW+JbDsFqfHskvm77VRI/aTkvIHQKOA==
X-Received: by 2002:a9d:7a97:0:b0:6b7:564d:f368 with SMTP id
 l23-20020a9d7a97000000b006b7564df368mr2574686otn.5.1688729584576; 
 Fri, 07 Jul 2023 04:33:04 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:33:04 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 40/60] ppc440: Stop using system io region for PCIe buses
Date: Fri,  7 Jul 2023 08:30:48 -0300
Message-ID: <20230707113108.7145-41-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Add separate memory regions for the mem and io spaces of the PCIe bus
to avoid different buses using the same system io region.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <b631c3a61729eee2166d899b8888164ebeb71574.1688586835.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/ppc440_uc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 5724db2702..663abf3449 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -776,6 +776,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PPC460EXPCIEState, PPC460EX_PCIE_HOST)
 struct PPC460EXPCIEState {
     PCIExpressHost parent_obj;
 
+    MemoryRegion busmem;
     MemoryRegion iomem;
     qemu_irq irq[4];
     int32_t dcrn_base;
@@ -1056,15 +1057,17 @@ static void ppc460ex_pcie_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "invalid PCIe DCRN base");
         return;
     }
+    snprintf(buf, sizeof(buf), "pcie%d-mem", id);
+    memory_region_init(&s->busmem, OBJECT(s), buf, UINT64_MAX);
     snprintf(buf, sizeof(buf), "pcie%d-io", id);
-    memory_region_init(&s->iomem, OBJECT(s), buf, UINT64_MAX);
+    memory_region_init(&s->iomem, OBJECT(s), buf, 64 * KiB);
     for (i = 0; i < 4; i++) {
         sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[i]);
     }
     snprintf(buf, sizeof(buf), "pcie.%d", id);
     pci->bus = pci_register_root_bus(DEVICE(s), buf, ppc460ex_set_irq,
-                                pci_swizzle_map_irq_fn, s, &s->iomem,
-                                get_system_io(), 0, 4, TYPE_PCIE_BUS);
+                                pci_swizzle_map_irq_fn, s, &s->busmem,
+                                &s->iomem, 0, 4, TYPE_PCIE_BUS);
     ppc460ex_pcie_register_dcrs(s);
 }
 
-- 
2.41.0


