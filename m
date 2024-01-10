Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF72C82A508
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 00:44:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNiDj-0007QX-8k; Wed, 10 Jan 2024 18:42:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3dSufZQwKCnwsfgnmjxyjkfslttlqj.htrvjrz-ij0jqstslsz.twl@flex--nabihestefan.bounces.google.com>)
 id 1rNiDh-0007OV-JI
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 18:42:49 -0500
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3dSufZQwKCnwsfgnmjxyjkfslttlqj.htrvjrz-ij0jqstslsz.twl@flex--nabihestefan.bounces.google.com>)
 id 1rNiDf-0006ZK-EN
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 18:42:49 -0500
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5f8ec09e595so63100057b3.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 15:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1704930165; x=1705534965; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=AXBqU4mNthcXJuu2Vz0y7+PRtT106hxra4GrEYCdiAU=;
 b=ZwTjL3ARLVX8F/pdHhzhwoOAkhjypLmpC+bjdLAAyOqAnZ4bghDM89MuOxIYcJWTuo
 3A/MXHtrxeJCroK/4/3KpeLf4PcGagIbuBUyBIa248SoHcrR8aH2VIwm/qHLygl59X46
 OwWJ4f+V9CTJhzXpxXqr/hCCyc8kxYl9+d2jhk0KyTCvBr775wdA0Od5r6sb8CBYiVh4
 msbmI4CftGhMP+7JA3fBClKv+7V9ovHRHJhqzIrCcKogf9I3R2iYEjmOVpNHiLPnTF30
 zjDS0coANFBKyPr4WC6P/z1aE/ISXzFVLMcKWKoPj1uqu60txxA3dlV8/MPMGai5MoSD
 cRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704930165; x=1705534965;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AXBqU4mNthcXJuu2Vz0y7+PRtT106hxra4GrEYCdiAU=;
 b=hWCRwF/RA13SMD7x9/WN4kTybd6Yh7/wcvehEpk3SLZcPK84emsGNlV+zztc0s7Lfi
 TSQnQrnwFC8CNOe1bfjIRBnpbibjScUjezLwDrL7motahV6fdg79oWxP4cMhpasUDmjW
 3Sz92QhkWwdh3F42QJu6uYyw0aDSFD5KFq+A7hS80Ze8n6eBC+/08Vxke/w5rVz06Qgv
 Dlw2JOa0qVINdR01u2LH4JJxAuGMTmsnCa+r2nOytxfQw8Je+viHknEMyn97XzTvm1LG
 2rvRll5czaOaB2PCcrbSfewRppEQSgFbtN0H+QoEs75A/q0FygPbfh3FK87rEPppzdFm
 n/lQ==
X-Gm-Message-State: AOJu0YzaKJVgHw9fIWGgFBlUto99+jI5jxuQLb4UTxlbvgRmu6UIoO4B
 JpYwho0+qyyQaDTJzy4RWkCoW1z2UpANBUxL8lc4uxda+g==
X-Google-Smtp-Source: AGHT+IEEbwL8Fri2BlzEho/gX/hwbhy81sFcNwsZS2NCJrk4GErrBSKbcy4A6Iv1slWKwXVD5Ce7FtWQ1rplWDvKV2Q=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a81:6c83:0:b0:5d8:eec5:f57c with SMTP
 id h125-20020a816c83000000b005d8eec5f57cmr264459ywc.4.1704930165590; Wed, 10
 Jan 2024 15:42:45 -0800 (PST)
Date: Wed, 10 Jan 2024 23:42:24 +0000
In-Reply-To: <20240110234232.4116804-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240110234232.4116804-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240110234232.4116804-3-nabihestefan@google.com>
Subject: [PATCH v12 02/10] hw/arm: Add PCI mailbox module to Nuvoton SoC
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3dSufZQwKCnwsfgnmjxyjkfslttlqj.htrvjrz-ij0jqstslsz.twl@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Change-Id: I14c42c628258804030f0583889882842bde0d972
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
2.43.0.275.g3460e3d667-goog


