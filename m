Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E66F74B01C
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:44:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjiG-00059S-2z; Fri, 07 Jul 2023 07:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHji9-0004go-5q; Fri, 07 Jul 2023 07:33:17 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHji7-0006sp-Fh; Fri, 07 Jul 2023 07:33:16 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6b8a6ca994eso1611960a34.1; 
 Fri, 07 Jul 2023 04:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729594; x=1691321594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o9qvuiwNml4DNItsKdRCuXV/BuKgusjYyUeOzlehw/I=;
 b=Al968s/r+qZXPnl0ByIq5i7OiidZc1VRX/AIkfKqTBW81HT5fFqW6M1hx6ASGAAeqE
 g7yVzjrPcSNhtahtwyh/dJHdAxiLWXXaz1QPpm3Q77ayMLY/poEWH4E9xwFAbQxY4Xtl
 uNGaft2VnZoFAhI7lJWpDvirfDj3BO4brrV0PPy+rCt9YhfO4nHmO9C0Prm1SPpyAdkD
 +8gEyQ3JvWJgaoe/u9C31rwVv692CAwpS57le/UWdQdzs5c25v99uwdTjfljaNkPnh8F
 kzORBYWSSigGp9yNKpAHyydQZp6Z0voUhctuACAkhpRf1dxCPAqAfRrZbuPDNi9VB2Dl
 qMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729594; x=1691321594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o9qvuiwNml4DNItsKdRCuXV/BuKgusjYyUeOzlehw/I=;
 b=Wy9RyNO/1lNGCUXZOwp5cWJlgpaVbp9c3uzsp/zx7XHA5RhG8s9QThb15khIXteO6w
 GFXcHhsJEq+RY6B682tug92eU1+Fywg+fuhJucWzKYq8N89korPdPLNZc9mjzVTE1RxX
 kFf9BClH/slU3IWgSwXTORlF8WRd5UvG6YQX/ocns9pF4zanpno5bbUaTUXqqIhgmzCH
 a6Kax3p3rWizR/Ht5XVy5LsHVH0ns2WO9qvw/Zam6CPjGWQDCPB5fkyxgPOPf6GaQ1k9
 EYnRUaCwACibKd7UT/WRAZHuq2poIbO8UaFenLISDkdGcjsEEG65SVxo1e87NNBOP6lK
 mR9A==
X-Gm-Message-State: ABy/qLZWDuwvauTBk49J/hodI/xUnhqJO+HvzeYPAxYSAlqvcqVSPHrT
 3YW1svhomGetKGu2VrH5J4nvjSRot8s=
X-Google-Smtp-Source: APBJJlFW/7PgudZeYSbQ/OfvWvaIH6PC07IHJdHPk//jS1YDxL4igZjlBTAy3xjnlI8Ddr/8hOBWHw==
X-Received: by 2002:a9d:6516:0:b0:6b8:3a3b:7ba5 with SMTP id
 i22-20020a9d6516000000b006b83a3b7ba5mr4985118otl.20.1688729593940; 
 Fri, 07 Jul 2023 04:33:13 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:33:13 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 44/60] ppc440_pcix: Don't use iomem for regs
Date: Fri,  7 Jul 2023 08:30:52 -0300
Message-ID: <20230707113108.7145-45-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x335.google.com
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

The iomem memory region is better used for the PCI IO space but
currently used for registers. Stop using it for that to allow this to
be cleaned up in the next patch.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <3def68f200edd4540393d6b3b03baabe15d649f2.1688586835.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/ppc440_pcix.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index f10f93c533..899558b055 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -64,6 +64,7 @@ struct PPC440PCIXState {
     MemoryRegion container;
     MemoryRegion iomem;
     MemoryRegion busmem;
+    MemoryRegion regs;
 };
 
 #define PPC440_REG_BASE     0x80000
@@ -507,11 +508,11 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
                           h, "pci-conf-idx", 4);
     memory_region_init_io(&h->data_mem, OBJECT(s), &pci_host_data_le_ops,
                           h, "pci-conf-data", 4);
-    memory_region_init_io(&s->iomem, OBJECT(s), &pci_reg_ops, s,
-                          "pci.reg", PPC440_REG_SIZE);
+    memory_region_init_io(&s->regs, OBJECT(s), &pci_reg_ops, s, "pci-reg",
+                          PPC440_REG_SIZE);
     memory_region_add_subregion(&s->container, PCIC0_CFGADDR, &h->conf_mem);
     memory_region_add_subregion(&s->container, PCIC0_CFGDATA, &h->data_mem);
-    memory_region_add_subregion(&s->container, PPC440_REG_BASE, &s->iomem);
+    memory_region_add_subregion(&s->container, PPC440_REG_BASE, &s->regs);
     sysbus_init_mmio(sbd, &s->container);
 }
 
-- 
2.41.0


