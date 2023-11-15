Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB687EC563
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 15:35:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Gxs-0005Q6-Ef; Wed, 15 Nov 2023 09:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.hsu@sifive.com>)
 id 1r3Gxl-0005Or-0j
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 09:33:53 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.hsu@sifive.com>)
 id 1r3Gxh-0000pc-JO
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 09:33:51 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6bf03b98b9bso682395b3a.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 06:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1700058828; x=1700663628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+C/VrQrhq4780YNyMmwIgAPUdeApku0KscWWMgpJMuM=;
 b=diBEyCELrPmHSeys125rARqQKeSTTolq9M5m0m3+gfe7pwqbL2/MH0gYDPK6tg2kUK
 Yd/NAIeAIE0U0uDiT6P+j/TZk1gFGchfoBBztH53f0239Orh9E2Xcm874yiLzkU2CqfU
 uENk1xkBe0cFqoaO0guKWOp47XPEj/sV03ENsPwLWZLOnsNhJW98r/WIYK4b1UTuf2Sg
 uFItzq2lq9GX4hXBkOyHujAx7SpEM0jZVQTRNgvucMqRefjawEz68ot8jRnVfjGwLF5A
 uVM7SESbeIlNdhvbhCYmgwERQf1ycXfCK0jkjmQ8dOul6XM01C7ZJB4f67GkUYjYOqcc
 mg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700058828; x=1700663628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+C/VrQrhq4780YNyMmwIgAPUdeApku0KscWWMgpJMuM=;
 b=Rw3a4QcI7voOqGTzcqM2kFuLbfBbTGypCEYsLP3V2qZ4QjshYqqzGVKF4zrbnMWkFL
 QJXAL7/Yc5w0+L3s6f1csYBEs4DKygRypGA5NgpuFAnrSee13F6UjrtiB8gCy9Pqjaa7
 6UDKu8Cs+Y+V7TtsJqILiUMzr2edpr0GCf/foSEnRuDwYyLcLG1K/aQ6dZttaOJFMWfg
 3mYMYMytmRVVX6rzRd+WALb6eCO28X5EtARcpU2ZM8jN1w/sphQLuLVdab0/fMib3FTE
 ZkoOiEhVrgm+GI6z5abjutK3H+a6KWnNomWSEHwtxpIpNrsMRTdYlflofYrgGyLFUkLM
 D2JQ==
X-Gm-Message-State: AOJu0Yz2F18uKQoieBql5T9HLu8KpmHH01+rGlsWDQXMz+BZX6YcQC9s
 gRP3+cQB+adaNJnwhoOcmIskFA==
X-Google-Smtp-Source: AGHT+IEaHbHEp/p74ca/F0dn8o5Y79ZeT4w9Wi889hS6+1Lm6mICW/dPrJwawatFk4NXoc5f0E1vDw==
X-Received: by 2002:a05:6a20:72a2:b0:187:5db4:168c with SMTP id
 o34-20020a056a2072a200b001875db4168cmr2806358pzk.31.1700058828035; 
 Wed, 15 Nov 2023 06:33:48 -0800 (PST)
Received: from maxhsu-SiFive.. (61-230-7-62.dynamic-ip.hinet.net.
 [61.230.7.62]) by smtp.gmail.com with ESMTPSA id
 r2-20020aa78b82000000b006c871f3ad1csm1443496pfd.71.2023.11.15.06.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 06:33:47 -0800 (PST)
From: Max Hsu <max.hsu@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Frank Chang <frank.chang@sifive.com>, qemu-arm@nongnu.org,
 Greentime Hu <greentime.hu@sifive.com>, qemu-devel@nongnu.org,
 Max Hsu <max.hsu@sifive.com>
Subject: [PATCH 2/2] hw/pci-host: Designware: Add outbound iATU no address
 match behavior
Date: Wed, 15 Nov 2023 22:33:41 +0800
Message-Id: <20231115143341.13068-3-max.hsu@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115143341.13068-1-max.hsu@sifive.com>
References: <20231115143341.13068-1-max.hsu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=max.hsu@sifive.com; helo=mail-pf1-x431.google.com
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

IMX6DQRM Rev4, in chapter 48.3.9.2, specifies for outbound iATU with
no address match: 'If there is no address match, then the address is
untranslated.'
The current model implementation only considers inbound occurrences,
neglecting outbound scenarios.

To address this, we introduce a new MemoryRegion to handle the behavior
of no address match in outbound transactions.

This fix has been tested with the integration of Designware PCIe RC
along with the e1000e Ethernet card, ensuring proper functioning of
network transmissions and MSI interrupts.

Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
 hw/pci-host/designware.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 83dd9b1aaf..d0be8dec68 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -499,6 +499,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
      * to have the lowest priority.
      */
     MemoryRegion *inbound_untranslated = g_new(MemoryRegion, 1);
+    MemoryRegion *outbound_untranslated = g_new(MemoryRegion, 1);
 
     memory_region_init_alias(inbound_untranslated, OBJECT(root),
                              "inbound untranslated pass",
@@ -510,6 +511,16 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
     memory_region_set_address(inbound_untranslated, 0x0ULL);
     memory_region_set_enabled(inbound_untranslated, true);
 
+    memory_region_init_alias(outbound_untranslated, OBJECT(root),
+                             "outbound untranslated pass",
+                             &host->pci.memory, dummy_offset, dummy_size);
+    memory_region_add_subregion_overlap(get_system_memory(),
+                                        dummy_offset, outbound_untranslated,
+                                        INT32_MIN);
+    memory_region_set_size(outbound_untranslated, UINT64_MAX);
+    memory_region_set_address(outbound_untranslated, 0x0ULL);
+    memory_region_set_enabled(outbound_untranslated, true);
+
     memory_region_init_io(&root->msi.iomem, OBJECT(root),
                           &designware_pci_host_msi_ops,
                           root, "pcie-msi", 0x4);
-- 
2.34.1


