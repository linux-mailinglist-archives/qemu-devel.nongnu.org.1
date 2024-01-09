Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D78A827BD0
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 01:04:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMzZz-0002KV-IV; Mon, 08 Jan 2024 19:02:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3II2cZQwKCt8OBCJIFTUFGBOHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--nabihestefan.bounces.google.com>)
 id 1rMzZw-0002J9-No
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 19:02:48 -0500
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3II2cZQwKCt8OBCJIFTUFGBOHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--nabihestefan.bounces.google.com>)
 id 1rMzZu-0002qR-Dz
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 19:02:48 -0500
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-5cde2b113e7so616526a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 16:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1704758561; x=1705363361; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=9qBmftjLlpxjKXWRYQwSt7KsKP2Es44SquIQV1JrY0s=;
 b=QHFNIFYkz/mBima62QUKJ+A1HOi1kSkPhCSBvVE5OIzJ6rbAWmPpsdBvi2YnFEYW4V
 /87Ec2S1aKYeDx8NiMuf91mIDVGYNXyge3YF+nTNuVYiebO1n2JRqiDGR5m9fQbJucAz
 BhL0y4cCiiteDTPQXugTE6iffQmdSU3BvUxzhHsJgJhMxw6KvtV+1tJmkTuVSjsOPeYR
 WTOyofTSVZ4XIP9d5p9RpRUklw9iV7y/6bD2ERgYQRmFJ7crjVjmD+/FAiuOhO9J8Z5t
 kg35hhSbvl9ifZyzNuxa5ABtDxe2vmic8TahQ3Y6jrDjOsNBqSjV7B6B40/5b+V0hACH
 s8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704758561; x=1705363361;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9qBmftjLlpxjKXWRYQwSt7KsKP2Es44SquIQV1JrY0s=;
 b=jaEjGkMMgp5FHAq5A0GXfOL77BODfNhx03t5xiUMDI7i5fe972BTPgLZGggLLydABa
 R4FIU2ZRKcGXVr0Q3L7crugo0T8VZZxb4iBWt2+283ovnPNRMJ35cp2EGR3IhIsu3aPG
 KlHXDsNWcnX/tHmVuNHpYGOfMSiSJes46DYRNubqZm1T90U2425gdWdeOKJGoW3qQsno
 D2M60Vt/v7mjPjPvtKbcB4h6eFQVhjloKd8t0gchPjFLiWA2eGGHYasBTRC9twK0hbjg
 hgsJiQ+LjxcvTst5l9BYipyYXdPvkkQGdLR99rz4PXJuxQiMJqSPAjyoz1vrM41IQ4oM
 CEpQ==
X-Gm-Message-State: AOJu0YxVTO1UYKnEl1Qlyp1OldDuiXX//Tf1Yyx/vLJsqXShYm9zPKrv
 q8hpOYEjC0cdvAxQCV+GD0gq1fzdA09aPWXsYocxf8i/oQ==
X-Google-Smtp-Source: AGHT+IHQv8FxFjwWBLvjlKRru07zIEo+BbHCnfsZDqeHcfhURXnpcbB32MPtSotyVP30HF1rI/GYm0pH65Z5DIiJrPM=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a65:620d:0:b0:5ce:98f:4492 with SMTP
 id d13-20020a65620d000000b005ce098f4492mr23950pgv.6.1704758560901; Mon, 08
 Jan 2024 16:02:40 -0800 (PST)
Date: Tue,  9 Jan 2024 00:02:26 +0000
In-Reply-To: <20240109000234.2799153-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240109000234.2799153-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240109000234.2799153-3-nabihestefan@google.com>
Subject: [PATCH v11 02/10] hw/arm: Add PCI mailbox module to Nuvoton SoC
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3II2cZQwKCt8OBCJIFTUFGBOHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--nabihestefan.bounces.google.com;
 helo=mail-pg1-x549.google.com
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
2.43.0.472.g3155946c3a-goog


