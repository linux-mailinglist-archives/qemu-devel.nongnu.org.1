Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2499819257
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 22:34:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFhih-0007Tv-JO; Tue, 19 Dec 2023 16:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3GgyCZQwKCm0YLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com>)
 id 1rFhiK-0007QY-Gp
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 16:33:20 -0500
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3GgyCZQwKCm0YLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com>)
 id 1rFhiG-0003sz-MG
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 16:33:20 -0500
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5d12853cb89so65663967b3.3
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 13:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1703021594; x=1703626394; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=BX4IdZYRgiKfdW8QDai6gKwzIL2KGGmpL9NjzBR93ME=;
 b=jn7sy/EhwHc9W3hXtnpzbXKJdI38c+DffNe2VTBnQpRZ7kBMv2evjpTiwoohS+o1Cm
 PcdUcAtnbMaOxz1oRpVdjMUv/SueUx+iePUMErTz7c+pGVWuzkQZDNEASLFc/CkB/xR2
 XCBN9Py9JnVIIsLd5mAm069x33+Uigs0W8tp0qxx2c/M/7kyiArrIadvLyaXOQpXQ6Xy
 94ZPRo0c/n/IF2hjH4NzKt09WhomJ4xqpp7i8zpBm2UNg1Um/QNkFE2OgFbxG/Q48SHn
 cBGZ3adQ3wrNxVu6Pu9i81nH7MhNkNre4lMtI9uM6sAZ/6AnOpoJuI3ehGeNUZ5SAv3x
 oa/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703021594; x=1703626394;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BX4IdZYRgiKfdW8QDai6gKwzIL2KGGmpL9NjzBR93ME=;
 b=GT4aMk+9j7j3dmN+h/pFftAPREBHxB0mhP8hfQLDyzc+6hI4YpAv1pO1dXE8CsEK3d
 48kr52lEbyJm/Zs6myVibfCyH+9s2AsdffwsAWDn2GiesMAItPvj0AnE4Ec9Jym4Pi+M
 wycCplv0H5LGd6qkudlipG0b+ntY5pY0QPUb8H6hCyjkCorepof42/XAaP6C+v0Oz68F
 3nM9Bh+ohCD+yDfvmtMojCahh2LcXdfM/2gZoIlpKwm7cNv83qW9chSsxv7fnGIZ+4lE
 h24O7x/+ChoCB5efGydpmmO3YC0F6IjSZltX4JzLrDmU7uq3B8PR/MweKrS1HkKSHoCl
 xmMQ==
X-Gm-Message-State: AOJu0Yw7yKr8Osr4Ew4RuwX9T+pLrPigg1HBTcpy2tt53qj+LskxLCRf
 Wok2O2IIxnwkPu4wwYlo8FdxgAv4zjehSiOj/bo=
X-Google-Smtp-Source: AGHT+IH3TC4hpXprK6PfbYp4QcT7gLzy+/kPi2zS3Ne64UKwaAWyrXMBAxCONIPenecUtaa6f/dwy9JhJ0JDTZUUwyM=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:690c:a90:b0:5e6:579e:65e9 with
 SMTP id ci16-20020a05690c0a9000b005e6579e65e9mr2221885ywb.2.1703021594229;
 Tue, 19 Dec 2023 13:33:14 -0800 (PST)
Date: Tue, 19 Dec 2023 21:32:47 +0000
In-Reply-To: <20231219213255.604535-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20231219213255.604535-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231219213255.604535-3-nabihestefan@google.com>
Subject: [PATCH v9 02/10] hw/arm: Add PCI mailbox module to Nuvoton SoC
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3GgyCZQwKCm0YLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: Hao Wu <wuhaotsh@google.com>

This patch wires the PCI mailbox module to Nuvoton SoC.

Signed-off-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
---
 docs/system/arm/nuvoton.rst | 2 ++
 hw/arm/npcm7xx.c            | 2 ++
 include/hw/arm/npcm7xx.h    | 1 +
 3 files changed, 5 insertions(+)

diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
index 0424cae4b0..e611099545 100644
--- a/docs/system/arm/nuvoton.rst
+++ b/docs/system/arm/nuvoton.rst
@@ -50,6 +50,8 @@ Supported devices
  * Ethernet controller (EMC)
  * Tachometer
  * Peripheral SPI controller (PSPI)
+ * BIOS POST code FIFO
+ * PCI Mailbox
 
 Missing devices
 ---------------
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 1c3634ff45..c9e87162cb 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -462,6 +462,8 @@ static void npcm7xx_init(Object *obj)
         object_initialize_child(obj, "pspi[*]", &s->pspi[i], TYPE_NPCM_PSPI);
     }
 
+    object_initialize_child(obj, "pci-mbox", &s->pci_mbox,
+                            TYPE_NPCM7XX_PCI_MBOX);
     object_initialize_child(obj, "mmc", &s->mmc, TYPE_NPCM7XX_SDHCI);
 }
 
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 273090ac60..cec3792a2e 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -105,6 +105,7 @@ struct NPCM7xxState {
     OHCISysBusState     ohci;
     NPCM7xxFIUState     fiu[2];
     NPCM7xxEMCState     emc[2];
+    NPCM7xxPCIMBoxState pci_mbox;
     NPCM7xxSDHCIState   mmc;
     NPCMPSPIState       pspi[2];
 };
-- 
2.43.0.472.g3155946c3a-goog


