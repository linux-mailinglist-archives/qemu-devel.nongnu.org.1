Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 674B372B160
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 12:35:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8IP4-0006T2-GG; Sun, 11 Jun 2023 06:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IP0-0006SA-8q
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:30 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IOy-0008Ir-PU
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:30 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5149e65c244so4641446a12.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 03:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686479667; x=1689071667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K/UlJY6HPA2REvS10KvEAVpxLgAlwY2AgE1bWGrN/CU=;
 b=aeKT8c5wcuEh9gwpvl7tgvyU1CMVi/T66evsYajfNiRerIx59vfVU0+RLjuncYXknC
 mvJ9gl3VibYsPt53Ib6qJYWA59jX4TC5+AIcm8M2GFCconW5rGexkCZByXcntn18H5lb
 rY/yeG8STnTtV69xyu6/iClPhFP2rjlSyZFVOpDWrI2CxJ49yfVD+eJNCknXTSK8Fgai
 +FfX6khcV/elOLFPJxJb6g85gpFN1GgRUjMlneTZ6DK65IotCysO8Ve3NxcsOZz9vLow
 ycjCwDRfXBvnn6/46VBq4dQdLyMHOMgpb+AbcRV7Ca2LtMy/YKwHnrn11T66aLGOaPIz
 w4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686479667; x=1689071667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K/UlJY6HPA2REvS10KvEAVpxLgAlwY2AgE1bWGrN/CU=;
 b=UaHDW/cdnKTfv6jSAC78sq8MFocM3p8ctojzkWFZFqPO17FiSBgk6InQh68PRG0GFE
 OEOh+JgLnj6twW9MgsUaRSBKcoa4MKtmNitA3LByPPzlREiJ9/0s5sc8kCPWhMDEE/Bc
 X5o54iQX+1f5xMk5mhMZ2LZMn4zgD3a+Qt7B02lM3g9lR/KNGqHGNoAzSOqklEPGxaPC
 xIDhSw8Br4s/4UTM8z9aUUevcd8TwOunO7Z0PFCMn6V9zxBW/+PLCbBLaprSTQ1A+ujy
 pXG2CYmEHdaU9Q0Os5e9uj/QW5jqxJ2Paj7rruLPoiIj0RSbF79XHT19hmK+Ar7u6BeF
 ibyQ==
X-Gm-Message-State: AC+VfDxOBLgfUb/h93B/nIq0sP/zGURXq5JiYcbpEUGhjumXLqO2OuwP
 oDNG92ilG4Pigmi2HkQIebGq360mP7A=
X-Google-Smtp-Source: ACHHUZ5BHMFxJvsvbUOokNyR5SPi+/egm8DNHkkzrFnjW9e9RON88f8g1Ktg7bTSaRHRV5OpRq8KQg==
X-Received: by 2002:aa7:c68c:0:b0:514:9914:b879 with SMTP id
 n12-20020aa7c68c000000b005149914b879mr2620816edq.21.1686479667068; 
 Sun, 11 Jun 2023 03:34:27 -0700 (PDT)
Received: from archlinux.. (ip5f5bd7c0.dynamic.kabel-deutschland.de.
 [95.91.215.192]) by smtp.gmail.com with ESMTPSA id
 m8-20020a056402050800b005149cb5ee2dsm3794314edv.82.2023.06.11.03.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 03:34:26 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 07/15] hw/pci-host/i440fx: Replace magic values by existing
 constants
Date: Sun, 11 Jun 2023 12:34:04 +0200
Message-ID: <20230611103412.12109-8-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230611103412.12109-1-shentey@gmail.com>
References: <20230611103412.12109-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/pci-host/i440fx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 61e7b97ff4..daa4d11104 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -277,8 +277,8 @@ PCIBus *i440fx_init(const char *pci_type,
 
     /* if *disabled* show SMRAM to all CPUs */
     memory_region_init_alias(&f->smram_region, OBJECT(d), "smram-region",
-                             f->pci_address_space, 0xa0000, 0x20000);
-    memory_region_add_subregion_overlap(f->system_memory, 0xa0000,
+                             f->pci_address_space, SMRAM_C_BASE, SMRAM_C_SIZE);
+    memory_region_add_subregion_overlap(f->system_memory, SMRAM_C_BASE,
                                         &f->smram_region, 1);
     memory_region_set_enabled(&f->smram_region, true);
 
@@ -286,9 +286,9 @@ PCIBus *i440fx_init(const char *pci_type,
     memory_region_init(&f->smram, OBJECT(d), "smram", 4 * GiB);
     memory_region_set_enabled(&f->smram, true);
     memory_region_init_alias(&f->low_smram, OBJECT(d), "smram-low",
-                             f->ram_memory, 0xa0000, 0x20000);
+                             f->ram_memory, SMRAM_C_BASE, SMRAM_C_SIZE);
     memory_region_set_enabled(&f->low_smram, true);
-    memory_region_add_subregion(&f->smram, 0xa0000, &f->low_smram);
+    memory_region_add_subregion(&f->smram, SMRAM_C_BASE, &f->low_smram);
     object_property_add_const_link(qdev_get_machine(), "smram",
                                    OBJECT(&f->smram));
 
-- 
2.41.0


