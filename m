Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AE57CDC3A
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 14:48:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt5vp-0007Ps-Rt; Wed, 18 Oct 2023 08:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick.rudolph@9elements.com>)
 id 1qt56O-0003w4-4v
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:52:40 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <patrick.rudolph@9elements.com>)
 id 1qt56L-0001AZ-LK
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:52:39 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40572aeb6d0so62868695e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 04:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1697629956; x=1698234756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NBsTXp99oICjo68ORVoV0GBRIxnCuf51C2Lp0GT0wiM=;
 b=efHmTLTOYGtrkQz/BqdiZ7lj3jJ+H+qIKw939zcVDok4SnDX79j5RB8qw3cFlizzG2
 xtHxEImWxwUWpzAY5sNCg6kx0RPQf6xKChCFX/3bQkxkGZ/P5GJhBcAyneS2N9whh8BD
 C5nshfMudai4MYhWOpArUsnW88rUMYOJxIjR9qqRsv2hD3nAZEWRhTRrWhSrHOGCO45U
 I6HJXChUJUSe7WuIVJ2lHa903KWT2CG3tZy/T9ASwFhUTJUfbp/An5fzpPBGusC9mhNz
 SUQggu2g+hfTzNWsfDXSLabiEiJFA4pOFUoMBNmGce/IgCkiCjVDBakASVUY3VS/sQe0
 mFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697629956; x=1698234756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NBsTXp99oICjo68ORVoV0GBRIxnCuf51C2Lp0GT0wiM=;
 b=h2xNu4VN2LOtiMydl2bBMojY6uQRdWc8Mu02oRHqpvD99Pf3JhyAvEQoPO19RTMMid
 DfKSlORbUT/KUWKiNcrh5k5678ljmGVysYnX02tPo4Rm6zapF/nSKWySTl/I5JBrA4Ud
 e+ZDxRLVFI5nLSgN9hwR3DjabwH8/MIZFtn4tFTpHjCx5CJ3z4e3+FYCJZDCeskOI98m
 KD1AK9Gq7NGSWMv+b2s+gn3G39sUp7J5TmYywpOjB37BOyPImiJn+6KEprDF0VrYqOlO
 ZmFSnR6a0DjgkA9rFKSwGIdYzgYk9v8rzu32B9AJx+KspCPb6CmzTdko4U1Ca9sqkIvp
 iAYQ==
X-Gm-Message-State: AOJu0YzawqQCZ7+n1adZIKNRV7JwRBQUzL0ttTtrw7OK3kpVO7sAw71O
 kQU4W0qxj3aw7X/2abDwSZLpQRtaGp9+Ku+6qGNGbg==
X-Google-Smtp-Source: AGHT+IEQUF7wlcJZCxT5cjm4X1ngAoXXiJuE+qUHaB3N8WuLUdWXO2AeLvb3qZ78cCnyqmKhCqcm/Q==
X-Received: by 2002:a05:600c:1ca0:b0:408:3e41:aea with SMTP id
 k32-20020a05600c1ca000b004083e410aeamr942406wms.1.1697629956453; 
 Wed, 18 Oct 2023 04:52:36 -0700 (PDT)
Received: from fedora.9e.network
 (ip-078-094-000-052.um19.pools.vodafone-ip.de. [78.94.0.52])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a05600c489100b0040776008abdsm1455303wmp.40.2023.10.18.04.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 04:52:36 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, marcel.apfelbaum@gmail.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 2/3] hw/isa/lpc_ich9: Implement SMI_STS for APMC
Date: Wed, 18 Oct 2023 13:52:30 +0200
Message-ID: <20231018115231.3547102-3-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018115231.3547102-1-patrick.rudolph@9elements.com>
References: <20231018115231.3547102-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=patrick.rudolph@9elements.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Oct 2023 08:45:43 -0400
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

The guest SMI handler wants to know the cause for the SMI, thus properly
emulate the RWC APMC and TCO bit in the SMI_STS register.

TEST: coreboot generic ICH9 SMI handler is able to determine
      the source for the SMI and will invoke the APM callback.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 hw/acpi/ich9.c                | 5 +++++
 hw/acpi/ich9_tco.c            | 5 +++++
 hw/isa/lpc_ich9.c             | 1 +
 include/hw/southbridge/ich9.h | 2 ++
 4 files changed, 13 insertions(+)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 25e2c7243e..74d1824595 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -98,6 +98,7 @@ static void ich9_smi_writel(void *opaque, hwaddr addr, uint64_t val,
     ICH9LPCPMRegs *pm = opaque;
     TCOIORegs *tr = &pm->tco_regs;
     uint64_t tco_en;
+    uint32_t mask;
 
     switch (addr) {
     case 0:
@@ -109,6 +110,10 @@ static void ich9_smi_writel(void *opaque, hwaddr addr, uint64_t val,
         pm->smi_en &= ~pm->smi_en_wmask;
         pm->smi_en |= (val & pm->smi_en_wmask);
         break;
+    case 4:
+        mask = pm->smi_sts & ~val;
+        pm->smi_sts &= ~(ICH9_PMIO_SMI_STS_TCO | ICH9_PMIO_SMI_STS_APMC);
+        pm->smi_sts |= mask & (ICH9_PMIO_SMI_STS_TCO | ICH9_PMIO_SMI_STS_APMC);
     }
 }
 
diff --git a/hw/acpi/ich9_tco.c b/hw/acpi/ich9_tco.c
index 1540f4fd46..0f1cb19864 100644
--- a/hw/acpi/ich9_tco.c
+++ b/hw/acpi/ich9_tco.c
@@ -71,6 +71,7 @@ static void tco_timer_expired(void *opaque)
     }
 
     if (pm->smi_en & ICH9_PMIO_SMI_EN_TCO_EN) {
+        lpc->pm.smi_sts |= ICH9_PMIO_SMI_STS_TCO;
         ich9_generate_smi();
     }
     tr->tco.rld = tr->tco.tmr;
@@ -139,6 +140,9 @@ static uint32_t tco_ioport_readw(TCOIORegs *tr, uint32_t addr)
 
 static void tco_ioport_writew(TCOIORegs *tr, uint32_t addr, uint32_t val)
 {
+    ICH9LPCPMRegs *pm = container_of(tr, ICH9LPCPMRegs, tco_regs);
+    ICH9LPCState *lpc = container_of(pm, ICH9LPCState, pm);
+
     trace_tco_io_write(addr, val);
     switch (addr) {
     case TCO_RLD:
@@ -153,6 +157,7 @@ static void tco_ioport_writew(TCOIORegs *tr, uint32_t addr, uint32_t val)
     case TCO_DAT_IN:
         tr->tco.din = val;
         tr->tco.sts1 |= SW_TCO_SMI;
+        lpc->pm.smi_sts |= ICH9_PMIO_SMI_STS_TCO;
         ich9_generate_smi();
         break;
     case TCO_DAT_OUT:
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 01d6a46c3d..eb25e6429e 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -471,6 +471,7 @@ static void ich9_apm_ctrl_changed(uint32_t val, void *arg)
 
     /* SMI_EN = PMBASE + 30. SMI control and enable register */
     if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN) {
+        lpc->pm.smi_sts |= ICH9_PMIO_SMI_STS_APMC;
         if (lpc->smi_negotiated_features &
             (UINT64_C(1) << ICH9_LPC_SMI_F_BROADCAST_BIT)) {
             CPUState *cs;
diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
index 1281eb654c..4f5d6cefaa 100644
--- a/include/hw/southbridge/ich9.h
+++ b/include/hw/southbridge/ich9.h
@@ -202,6 +202,8 @@ struct ICH9LPCState {
 #define ICH9_PMIO_SMI_EN_APMC_EN                (1 << 5)
 #define ICH9_PMIO_SMI_EN_TCO_EN                 (1 << 13)
 #define ICH9_PMIO_SMI_STS                       0x34
+#define ICH9_PMIO_SMI_STS_APMC                  (1 << 5)
+#define ICH9_PMIO_SMI_STS_TCO                   (1 << 13)
 #define ICH9_PMIO_TCO_RLD                       0x60
 #define ICH9_PMIO_TCO_LEN                       32
 
-- 
2.41.0


