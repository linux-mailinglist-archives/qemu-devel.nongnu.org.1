Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC3B7E4A1C
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 21:50:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0T00-0006cu-Cl; Tue, 07 Nov 2023 15:48:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0Szu-0006aW-6W; Tue, 07 Nov 2023 15:48:30 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0Szs-0006Sx-4E; Tue, 07 Nov 2023 15:48:29 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-41e1974783cso38560111cf.3; 
 Tue, 07 Nov 2023 12:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699390106; x=1699994906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iUcEwOhRQn+FA51Xd0pAqqI8AsQQNXtH2TgPu8rbPhc=;
 b=FNKW0dVwdJ3wor+upaXPJMUJhuiokdH/9VYhnOD2RAJH5qfR6A9vq/De4he86MRY0x
 /6KG0RjY6y45WtQHYg3BJqZmJzHbfpD9Q5R2Lks7QxtmU6pn7eRAeCqDsDkvSKVTFvP8
 R9ceA3ucnuePRl9m2EpZQKcQjUguPN7hq1fP9I6ne7WNjsWlePmRk7KkPtKhn+2pX/Or
 u+kKu3aES2rQ6BlJmf943RLR0GF1TEXpyJ/HFGnCMmCxVy16s5p+w27BI2j1YhvaEkPK
 KtpXiA+dWW26gFvvdtUHfbwVVQwzHE33MjIhhuRsYHUfh9AXwhjmYmZRkybfp9MlvIpf
 ND+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699390106; x=1699994906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iUcEwOhRQn+FA51Xd0pAqqI8AsQQNXtH2TgPu8rbPhc=;
 b=T//WbAY4XkCe852n7HfwuW27pJB8+m/FQ+wVkQNToKQ3AF4W9cOkl96tCCd5KnT/yG
 n1GSOvUy5O96uy5nIssiH5Msck7XuiPHxBSys33RBfxtza0Xt/TwgtximlFCnfL1oWdm
 s4Qma1rtcS0FCR1d+wGj/jcCADRZSOavmrxeaLM1UEjNsK62EQuQupA8STFicGfwejkR
 Nms9P/Ld9EyzlVpf2WSW/Aq0iagoUcAjDovtTX2BiC1PkFwgMtw6PEKaLV0I3aKRwwya
 hllpKTRppjQ3IChDBMz4UfkGL/3uS2pmEf8ohc0fEuYtUFLfrRdBmqcQJKwRMxJ29RsL
 U3eQ==
X-Gm-Message-State: AOJu0YyK729+KClpCOcVFZw2SVLo/qTbNaOmO5zxuxMeOMvRZPB3weTu
 qanzM+D1rTpPrjhsILnfkbzxS74ApBI=
X-Google-Smtp-Source: AGHT+IHArDYyyPE7KOGaqcUxIrwEwh6GAqgQYPD0K+bmFwsc2xHaCrCONWueIrnlk9HVjG3b3tH50A==
X-Received: by 2002:a05:622a:1791:b0:417:9962:4de9 with SMTP id
 s17-20020a05622a179100b0041799624de9mr12993qtk.1.1699390106542; 
 Tue, 07 Nov 2023 12:48:26 -0800 (PST)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 d13-20020ac8544d000000b0041eb13a8195sm48946qtq.61.2023.11.07.12.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 12:48:26 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 Saif Abrar <saif.abrar@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 8/9] hw/pci-host: Update PHB5 XSCOM registers
Date: Tue,  7 Nov 2023 17:48:05 -0300
Message-ID: <20231107204806.8507-9-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107204806.8507-1-danielhb413@gmail.com>
References: <20231107204806.8507-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x82f.google.com
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

From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>

Add new XSCOM registers introduced in PHB5.
Apply bit-masks within xscom-write methods.
Bit-masks specified using PPC_BITMASK macro.

Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-ID: <20231016175948.10869-1-saif.abrar@linux.vnet.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/pci-host/pnv_phb4.c              | 46 ++++++++++++++++++-----------
 hw/pci-host/pnv_phb4_pec.c          | 33 +++++++++++++++++----
 include/hw/pci-host/pnv_phb4.h      |  2 +-
 include/hw/pci-host/pnv_phb4_regs.h |  4 ++-
 4 files changed, 60 insertions(+), 25 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 37c7afc18c..075499d36d 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -855,7 +855,7 @@ static uint64_t pnv_pec_stk_nest_xscom_read(void *opaque, hwaddr addr,
     PnvPHB4 *phb = PNV_PHB4(opaque);
     uint32_t reg = addr >> 3;
 
-    /* TODO: add list of allowed registers and error out if not */
+    /* All registers are read-able */
     return phb->nest_regs[reg];
 }
 
@@ -1000,7 +1000,7 @@ static void pnv_pec_stk_nest_xscom_write(void *opaque, hwaddr addr,
 
     switch (reg) {
     case PEC_NEST_STK_PCI_NEST_FIR:
-        phb->nest_regs[PEC_NEST_STK_PCI_NEST_FIR] = val;
+        phb->nest_regs[PEC_NEST_STK_PCI_NEST_FIR] = val & PPC_BITMASK(0, 27);
         break;
     case PEC_NEST_STK_PCI_NEST_FIR_CLR:
         phb->nest_regs[PEC_NEST_STK_PCI_NEST_FIR] &= val;
@@ -1009,7 +1009,8 @@ static void pnv_pec_stk_nest_xscom_write(void *opaque, hwaddr addr,
         phb->nest_regs[PEC_NEST_STK_PCI_NEST_FIR] |= val;
         break;
     case PEC_NEST_STK_PCI_NEST_FIR_MSK:
-        phb->nest_regs[PEC_NEST_STK_PCI_NEST_FIR_MSK] = val;
+        phb->nest_regs[PEC_NEST_STK_PCI_NEST_FIR_MSK] = val &
+                                                        PPC_BITMASK(0, 27);
         break;
     case PEC_NEST_STK_PCI_NEST_FIR_MSKC:
         phb->nest_regs[PEC_NEST_STK_PCI_NEST_FIR_MSK] &= val;
@@ -1019,7 +1020,7 @@ static void pnv_pec_stk_nest_xscom_write(void *opaque, hwaddr addr,
         break;
     case PEC_NEST_STK_PCI_NEST_FIR_ACT0:
     case PEC_NEST_STK_PCI_NEST_FIR_ACT1:
-        phb->nest_regs[reg] = val;
+        phb->nest_regs[reg] = val & PPC_BITMASK(0, 27);
         break;
     case PEC_NEST_STK_PCI_NEST_FIR_WOF:
         phb->nest_regs[reg] = 0;
@@ -1030,7 +1031,7 @@ static void pnv_pec_stk_nest_xscom_write(void *opaque, hwaddr addr,
         /* Flag error ? */
         break;
     case PEC_NEST_STK_PBCQ_MODE:
-        phb->nest_regs[reg] = val & 0xff00000000000000ull;
+        phb->nest_regs[reg] = val & PPC_BITMASK(0, 7);
         break;
     case PEC_NEST_STK_MMIO_BAR0:
     case PEC_NEST_STK_MMIO_BAR0_MASK:
@@ -1041,28 +1042,33 @@ static void pnv_pec_stk_nest_xscom_write(void *opaque, hwaddr addr,
              PEC_NEST_STK_BAR_EN_MMIO1)) {
             phb_pec_error(pec, "Changing enabled BAR unsupported");
         }
-        phb->nest_regs[reg] = val & 0xffffffffff000000ull;
+        phb->nest_regs[reg] = val & PPC_BITMASK(0, 39);
         break;
     case PEC_NEST_STK_PHB_REGS_BAR:
         if (phb->nest_regs[PEC_NEST_STK_BAR_EN] & PEC_NEST_STK_BAR_EN_PHB) {
             phb_pec_error(pec, "Changing enabled BAR unsupported");
         }
-        phb->nest_regs[reg] = val & 0xffffffffffc00000ull;
+        phb->nest_regs[reg] = val & PPC_BITMASK(0, 41);
         break;
     case PEC_NEST_STK_INT_BAR:
         if (phb->nest_regs[PEC_NEST_STK_BAR_EN] & PEC_NEST_STK_BAR_EN_INT) {
             phb_pec_error(pec, "Changing enabled BAR unsupported");
         }
-        phb->nest_regs[reg] = val & 0xfffffff000000000ull;
+        phb->nest_regs[reg] = val & PPC_BITMASK(0, 27);
         break;
     case PEC_NEST_STK_BAR_EN:
-        phb->nest_regs[reg] = val & 0xf000000000000000ull;
+        phb->nest_regs[reg] = val & PPC_BITMASK(0, 3);
         pnv_pec_phb_update_map(phb);
         break;
     case PEC_NEST_STK_DATA_FRZ_TYPE:
-    case PEC_NEST_STK_PBCQ_TUN_BAR:
         /* Not used for now */
-        phb->nest_regs[reg] = val;
+        phb->nest_regs[reg] = val & PPC_BITMASK(0, 27);
+        break;
+    case PEC_NEST_STK_PBCQ_SPARSE_PAGE:
+        phb->nest_regs[reg] = val & PPC_BITMASK(3, 5);
+        break;
+    case PEC_NEST_STK_PBCQ_CACHE_INJ:
+        phb->nest_regs[reg] = val & PPC_BITMASK(0, 7);
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "phb4_pec: nest_xscom_write 0x%"HWADDR_PRIx
@@ -1086,7 +1092,7 @@ static uint64_t pnv_pec_stk_pci_xscom_read(void *opaque, hwaddr addr,
     PnvPHB4 *phb = PNV_PHB4(opaque);
     uint32_t reg = addr >> 3;
 
-    /* TODO: add list of allowed registers and error out if not */
+    /* All registers are read-able */
     return phb->pci_regs[reg];
 }
 
@@ -1095,10 +1101,9 @@ static void pnv_pec_stk_pci_xscom_write(void *opaque, hwaddr addr,
 {
     PnvPHB4 *phb = PNV_PHB4(opaque);
     uint32_t reg = addr >> 3;
-
     switch (reg) {
     case PEC_PCI_STK_PCI_FIR:
-        phb->pci_regs[reg] = val;
+        phb->pci_regs[reg] = val & PPC_BITMASK(0, 5);
         break;
     case PEC_PCI_STK_PCI_FIR_CLR:
         phb->pci_regs[PEC_PCI_STK_PCI_FIR] &= val;
@@ -1107,7 +1112,7 @@ static void pnv_pec_stk_pci_xscom_write(void *opaque, hwaddr addr,
         phb->pci_regs[PEC_PCI_STK_PCI_FIR] |= val;
         break;
     case PEC_PCI_STK_PCI_FIR_MSK:
-        phb->pci_regs[reg] = val;
+        phb->pci_regs[reg] = val & PPC_BITMASK(0, 5);
         break;
     case PEC_PCI_STK_PCI_FIR_MSKC:
         phb->pci_regs[PEC_PCI_STK_PCI_FIR_MSK] &= val;
@@ -1117,20 +1122,25 @@ static void pnv_pec_stk_pci_xscom_write(void *opaque, hwaddr addr,
         break;
     case PEC_PCI_STK_PCI_FIR_ACT0:
     case PEC_PCI_STK_PCI_FIR_ACT1:
-        phb->pci_regs[reg] = val;
+        phb->pci_regs[reg] = val & PPC_BITMASK(0, 5);
         break;
     case PEC_PCI_STK_PCI_FIR_WOF:
         phb->pci_regs[reg] = 0;
         break;
     case PEC_PCI_STK_ETU_RESET:
-        phb->pci_regs[reg] = val & 0x8000000000000000ull;
+        phb->pci_regs[reg] = val & PPC_BIT(0);
         /* TODO: Implement reset */
         break;
     case PEC_PCI_STK_PBAIB_ERR_REPORT:
         break;
     case PEC_PCI_STK_PBAIB_TX_CMD_CRED:
+        phb->pci_regs[reg] = val &
+                                 ((PPC_BITMASK(0, 2) | PPC_BITMASK(10, 18)
+                                   | PPC_BITMASK(26, 34) | PPC_BITMASK(41, 50)
+                                   | PPC_BITMASK(58, 63)));
+        break;
     case PEC_PCI_STK_PBAIB_TX_DAT_CRED:
-        phb->pci_regs[reg] = val;
+        phb->pci_regs[reg] = val & (PPC_BITMASK(33, 34) | PPC_BITMASK(44, 47));
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "phb4_pec_stk: pci_xscom_write 0x%"HWADDR_PRIx
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index 3b2850f7a3..ce8e228f98 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -34,7 +34,7 @@ static uint64_t pnv_pec_nest_xscom_read(void *opaque, hwaddr addr,
     PnvPhb4PecState *pec = PNV_PHB4_PEC(opaque);
     uint32_t reg = addr >> 3;
 
-    /* TODO: add list of allowed registers and error out if not */
+    /* All registers are readable */
     return pec->nest_regs[reg];
 }
 
@@ -45,18 +45,36 @@ static void pnv_pec_nest_xscom_write(void *opaque, hwaddr addr,
     uint32_t reg = addr >> 3;
 
     switch (reg) {
-    case PEC_NEST_PBCQ_HW_CONFIG:
     case PEC_NEST_DROP_PRIO_CTRL:
+        pec->nest_regs[reg] = val & PPC_BITMASK(0, 25);
+        break;
     case PEC_NEST_PBCQ_ERR_INJECT:
+        pec->nest_regs[reg] = val & PPC_BITMASK(0, 11);
+        break;
     case PEC_NEST_PCI_NEST_CLK_TRACE_CTL:
+        pec->nest_regs[reg] = val & PPC_BITMASK(0, 16);
+        break;
     case PEC_NEST_PBCQ_PMON_CTRL:
+        pec->nest_regs[reg] = val & PPC_BITMASK(0, 37);
+        break;
     case PEC_NEST_PBCQ_PBUS_ADDR_EXT:
+        pec->nest_regs[reg] = val & PPC_BITMASK(0, 6);
+        break;
     case PEC_NEST_PBCQ_PRED_VEC_TIMEOUT:
-    case PEC_NEST_CAPP_CTRL:
+        pec->nest_regs[reg] = val & PPC_BITMASK(0, 15);
+        break;
     case PEC_NEST_PBCQ_READ_STK_OVR:
+        pec->nest_regs[reg] = val & PPC_BITMASK(0, 48);
+        break;
     case PEC_NEST_PBCQ_WRITE_STK_OVR:
     case PEC_NEST_PBCQ_STORE_STK_OVR:
+        pec->nest_regs[reg] = val & PPC_BITMASK(0, 24);
+        break;
     case PEC_NEST_PBCQ_RETRY_BKOFF_CTRL:
+        pec->nest_regs[reg] = val & PPC_BITMASK(0, 41);
+        break;
+    case PEC_NEST_PBCQ_HW_CONFIG:
+    case PEC_NEST_CAPP_CTRL:
         pec->nest_regs[reg] = val;
         break;
     default:
@@ -81,7 +99,7 @@ static uint64_t pnv_pec_pci_xscom_read(void *opaque, hwaddr addr,
     PnvPhb4PecState *pec = PNV_PHB4_PEC(opaque);
     uint32_t reg = addr >> 3;
 
-    /* TODO: add list of allowed registers and error out if not */
+    /* All registers are readable */
     return pec->pci_regs[reg];
 }
 
@@ -93,8 +111,13 @@ static void pnv_pec_pci_xscom_write(void *opaque, hwaddr addr,
 
     switch (reg) {
     case PEC_PCI_PBAIB_HW_CONFIG:
+        pec->pci_regs[reg] = val & PPC_BITMASK(0, 42);
+        break;
+    case PEC_PCI_PBAIB_HW_OVR:
+        pec->pci_regs[reg] = val & PPC_BITMASK(0, 15);
+        break;
     case PEC_PCI_PBAIB_READ_STK_OVR:
-        pec->pci_regs[reg] = val;
+        pec->pci_regs[reg] = val & PPC_BITMASK(0, 48);
         break;
     default:
         phb_pec_error(pec, "%s @0x%"HWADDR_PRIx"=%"PRIx64"\n", __func__,
diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
index 2d026db9a3..3212e68160 100644
--- a/include/hw/pci-host/pnv_phb4.h
+++ b/include/hw/pci-host/pnv_phb4.h
@@ -117,7 +117,7 @@ struct PnvPHB4 {
     MemoryRegion pci_regs_mr;
 
     /* Nest registers */
-#define PHB4_PEC_NEST_STK_REGS_COUNT  0x17
+#define PHB4_PEC_NEST_STK_REGS_COUNT  0x18
     uint64_t nest_regs[PHB4_PEC_NEST_STK_REGS_COUNT];
     MemoryRegion nest_regs_mr;
 
diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
index 4a0d3b28ef..bea96f4d91 100644
--- a/include/hw/pci-host/pnv_phb4_regs.h
+++ b/include/hw/pci-host/pnv_phb4_regs.h
@@ -77,10 +77,12 @@
 #define   PEC_NEST_STK_BAR_EN_PHB               PPC_BIT(2)
 #define   PEC_NEST_STK_BAR_EN_INT               PPC_BIT(3)
 #define PEC_NEST_STK_DATA_FRZ_TYPE      0x15
-#define PEC_NEST_STK_PBCQ_TUN_BAR       0x16
+#define PEC_NEST_STK_PBCQ_SPARSE_PAGE   0x16 /* P10 */
+#define PEC_NEST_STK_PBCQ_CACHE_INJ     0x17 /* P10 */
 
 /* XSCOM PCI global registers */
 #define PEC_PCI_PBAIB_HW_CONFIG         0x00
+#define PEC_PCI_PBAIB_HW_OVR            0x01
 #define PEC_PCI_PBAIB_READ_STK_OVR      0x02
 
 /* XSCOM PCI per-stack registers */
-- 
2.41.0


