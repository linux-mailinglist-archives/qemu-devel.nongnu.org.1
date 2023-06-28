Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A2F741914
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 21:54:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEbDF-0004hp-VB; Wed, 28 Jun 2023 15:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDC-0004h2-SX
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:22 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDB-0005iZ-Bu
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:22 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-991fee3a6b1so25190166b.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 12:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687981940; x=1690573940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UK0QSdymOFByub6L+Ko6+j892+Q1EOkr2A7MxnMviE4=;
 b=oBewUrNXU/c3JEPhwAnvz9PDBky7HWoDdRRJXf7CloOFM/9mPvwfBFrm5vX0lnzr31
 k4X4YZvR1/hDBz4WDtguZ9VRplE+uZHAkvZc2CjIhfOa5OgNY2T6Q14jpl3V45eXIvbi
 C7Tcv3IrM4X97DTW4gmca8lzSq9TxlPHpf5pa0N7vUBaQyGDDvMZr5hmFv77ReOt8YGA
 6phpKSrKzFPuapNAtjFbZI0W0iCXn1O9jS4MlCh2TCrHakabOSjO42J7RMKWgtRyiau3
 gjOOvq263pFIkaKNBKda8iPSrwXvoFHEtJiVdQ7m5FPhIG4K+kTTLi5sx8Azul99xB8T
 x0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687981940; x=1690573940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UK0QSdymOFByub6L+Ko6+j892+Q1EOkr2A7MxnMviE4=;
 b=aPJDrwzBARPI7/R4uybepi7EtMX2NaDRCdf49BfmvWijIo/ZBO1UN5oUjfJ40Ai3DZ
 dSacb7ZYT+vdJ61fkIRIkhcJTpRZWPyW0E6jqQOEBsIJoTMVOIi0x21ZlMt7FONDQ1cD
 lF/2sTxNoWt27qgjfse01bV2+m+MWYlYeTO5scquAz2qwVn0AswYzAmsNzLSs53uYqxb
 s9Iga5pI3cubUa6FvRIerpIMJCiYGHAjakMescVLqg1ikQCPJN33FUsunJnEZjlGDqUx
 miSijkDgiXP8leYfy5dpOCd1n5mnEjpW3hyTxGCAquYRbaPDN825dRKbw2BkGblgYCz+
 Og1Q==
X-Gm-Message-State: AC+VfDywQftMukpWNolno4LbmWdunJzvnmECn1AdXCMtqfFQxs20AVS2
 ZZBmuOOFiWM+COSamBmJin2L2AYGJDc=
X-Google-Smtp-Source: ACHHUZ5NFYXKm5XyVTIwTm5PuVeXNUAY9JKuH/EpcqBTO3fBZwaTvWn3Eu/LC0xeVlSQy6WwZSOGbw==
X-Received: by 2002:a17:907:1dec:b0:991:e3c4:c129 with SMTP id
 og44-20020a1709071dec00b00991e3c4c129mr6068124ejc.69.1687981939786; 
 Wed, 28 Jun 2023 12:52:19 -0700 (PDT)
Received: from archlinux.. (dynamic-077-191-074-208.77.191.pool.telefonica.de.
 [77.191.74.208]) by smtp.gmail.com with ESMTPSA id
 ec10-20020a170906b6ca00b00982be08a9besm6142817ejb.172.2023.06.28.12.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 12:52:19 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/16] hw/pci-host/i440fx: Replace magic values by existing
 constants
Date: Wed, 28 Jun 2023 21:51:55 +0200
Message-ID: <20230628195204.1241-8-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628195204.1241-1-shentey@gmail.com>
References: <20230628195204.1241-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


