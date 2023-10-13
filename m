Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F20F7C7FD4
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:18:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD5s-0000lr-4A; Fri, 13 Oct 2023 04:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5Z-00089U-Dc
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:00:10 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5W-0007Tx-KS
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:00:05 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4056ce55e7eso18667715e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183999; x=1697788799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aRXl+SrRaYUhKFmfsa05hrLLvIV6bdQQSvWfsUnuYZQ=;
 b=fCK/EvG+M/SKJXrD0iu6l0LVtSyH7NvCZgz35Zidfa0unug2xoQjxQiL6br5PfsBkH
 1cbabOuWW6Pp6mpNqLIy3fBqDeRiZODpiQjKmxWgwLY80AJ2s9XuIoRleLmCa872Yhte
 QHk4NFbdLeKWiBL+lqcquMcL5tSmZD7nBvLIYUB0rf8tAPssSMkazbd4jMshDwQOTcF6
 2M0ZKb1PIfKcLo3cLsfWZ3iN5H8LrGj91IFP1ZARE6/yHboneQGjmAokGua3X3SwAZ5S
 yY58EHEZloX3y+mJjhTJeaY0CRoJh93OeRDp/RopHrwSN2ixoi3BtgSPqZ/4sMYMEaoa
 rn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183999; x=1697788799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aRXl+SrRaYUhKFmfsa05hrLLvIV6bdQQSvWfsUnuYZQ=;
 b=f4eVtSeuxX27AZUra7Zb9nJbEWLP86hhRKG1CvU/4AMOsashkCCwDaG/mLCLFc3TQW
 dLui9UJB0tOHSlfJB/2PpgywGQkBNDIrl/8/33Xa16B5zRuy3wIZFM7zg5KZLk/FYR0/
 vRU7hU7sCpTI+tJmVqh2kJtLaCaL6N6ExKyaVuAmQ31afsTtXOZakBL7lOMEN37+50C0
 MSCyBr/EcBVrp2UdcFvoyTJFU6aBG2sNf2Z+V2xSspb8cN677HKVPRbm/3+xqec9ghFK
 smCQah8E97txT3dp1UgyVRCfXtDpkKzzpTsE4BkzpDziLspCdpwa55HS96kYSppJRaF0
 6m9Q==
X-Gm-Message-State: AOJu0YwAVVpmVouJO1d2f4Q0ccGooE3xSymypE6XhtY4JqK1tFgKM/VV
 x1djr2r4crX+viSY8v2EFaz9FK75jWEavPN5EsA=
X-Google-Smtp-Source: AGHT+IFcXpkwu1tyrkKUwkEEUkMwpgvV/52qhe1onXzM4/Mc7d9KkD4ks3SA46jcA2ve8Y1Ib1pjbQ==
X-Received: by 2002:a05:600c:282:b0:406:44e7:ef93 with SMTP id
 2-20020a05600c028200b0040644e7ef93mr24141025wmk.1.1697183999659; 
 Fri, 13 Oct 2023 00:59:59 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:59:58 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Huai-Cheng Kuo <hchkuo@avery-design.com.tw>,
 Chris Browy <cbrowy@avery-design.com>
Subject: [RFC PATCH v2 68/78] hw/pci: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:35 +0300
Message-Id: <921f621c591ff8db4b881821005dabf81add5f64.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/pci/pcie_aer.c | 3 ++-
 hw/pci/pcie_doe.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index b68c7ecb49..c99ecce2a1 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -97,71 +97,72 @@ static void aer_log_clear_all_err(PCIEAERLog *aer_log)
 int pcie_aer_init(PCIDevice *dev, uint8_t cap_ver, uint16_t offset,
                   uint16_t size, Error **errp)
 {
     pcie_add_capability(dev, PCI_EXT_CAP_ID_ERR, cap_ver,
                         offset, size);
     dev->exp.aer_cap = offset;
 
     /* clip down the value to avoid unreasonable memory usage */
     if (dev->exp.aer_log.log_max > PCIE_AER_LOG_MAX_LIMIT) {
         error_setg(errp, "Invalid aer_log_max %d. The max number of aer log "
                 "is %d", dev->exp.aer_log.log_max, PCIE_AER_LOG_MAX_LIMIT);
         return -EINVAL;
     }
     dev->exp.aer_log.log = g_malloc0(sizeof dev->exp.aer_log.log[0] *
                                         dev->exp.aer_log.log_max);
 
     pci_set_long(dev->w1cmask + offset + PCI_ERR_UNCOR_STATUS,
                  PCI_ERR_UNC_SUPPORTED);
 
     if (dev->cap_present & QEMU_PCIE_ERR_UNC_MASK) {
         pci_set_long(dev->config + offset + PCI_ERR_UNCOR_MASK,
                      PCI_ERR_UNC_MASK_DEFAULT);
         pci_set_long(dev->wmask + offset + PCI_ERR_UNCOR_MASK,
                      PCI_ERR_UNC_SUPPORTED);
     }
 
     pci_set_long(dev->config + offset + PCI_ERR_UNCOR_SEVER,
                  PCI_ERR_UNC_SEVERITY_DEFAULT);
     pci_set_long(dev->wmask + offset + PCI_ERR_UNCOR_SEVER,
                  PCI_ERR_UNC_SUPPORTED);
 
     pci_long_test_and_set_mask(dev->w1cmask + offset + PCI_ERR_COR_STATUS,
                                PCI_ERR_COR_SUPPORTED);
 
     pci_set_long(dev->config + offset + PCI_ERR_COR_MASK,
                  PCI_ERR_COR_MASK_DEFAULT);
     pci_set_long(dev->wmask + offset + PCI_ERR_COR_MASK,
                  PCI_ERR_COR_SUPPORTED);
 
     /* capabilities and control. multiple header logging is supported */
     if (dev->exp.aer_log.log_max > 0) {
         pci_set_long(dev->config + offset + PCI_ERR_CAP,
                      PCI_ERR_CAP_ECRC_GENC | PCI_ERR_CAP_ECRC_CHKC |
                      PCI_ERR_CAP_MHRC);
         pci_set_long(dev->wmask + offset + PCI_ERR_CAP,
                      PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE |
                      PCI_ERR_CAP_MHRE);
     } else {
         pci_set_long(dev->config + offset + PCI_ERR_CAP,
                      PCI_ERR_CAP_ECRC_GENC | PCI_ERR_CAP_ECRC_CHKC);
         pci_set_long(dev->wmask + offset + PCI_ERR_CAP,
                      PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
     }
 
     switch (pcie_cap_get_type(dev)) {
     case PCI_EXP_TYPE_ROOT_PORT:
         /* this case will be set by pcie_aer_root_init() */
-        /* fallthrough */
+        fallthrough;
     case PCI_EXP_TYPE_DOWNSTREAM:
+        fallthrough;
     case PCI_EXP_TYPE_UPSTREAM:
         pci_word_test_and_set_mask(dev->wmask + PCI_BRIDGE_CONTROL,
                                    PCI_BRIDGE_CTL_SERR);
         pci_long_test_and_set_mask(dev->w1cmask + PCI_STATUS,
                                    PCI_SEC_STATUS_RCV_SYSTEM_ERROR);
         break;
     default:
         /* nothing */
         break;
     }
     return 0;
 }
diff --git a/hw/pci/pcie_doe.c b/hw/pci/pcie_doe.c
index 2210f86968..f04a36e664 100644
--- a/hw/pci/pcie_doe.c
+++ b/hw/pci/pcie_doe.c
@@ -295,73 +295,73 @@ bool pcie_doe_read_config(DOECap *doe_cap, uint32_t addr, int size,
 /*
  * Write to DOE config space.
  * Return if the address not within DOE_CAP range or receives an abort
  */
 void pcie_doe_write_config(DOECap *doe_cap,
                            uint32_t addr, uint32_t val, int size)
 {
     uint16_t doe_offset = doe_cap->offset;
     uint32_t shift;
 
     if (!range_covers_byte(doe_offset + PCI_EXP_DOE_CAP,
                            PCI_DOE_SIZEOF - 4, addr)) {
         return;
     }
 
     /* Process Alignment */
     shift = addr % DWORD_BYTE;
     addr -= (doe_offset + shift);
     val = deposit32(val, shift * 8, size * 8, val);
 
     switch (addr) {
     case PCI_EXP_DOE_CTRL:
         if (FIELD_EX32(val, PCI_DOE_CAP_CONTROL, DOE_ABORT)) {
             pcie_doe_set_ready(doe_cap, 0);
             pcie_doe_set_error(doe_cap, 0);
             pcie_doe_reset_mbox(doe_cap);
             return;
         }
 
         if (FIELD_EX32(val, PCI_DOE_CAP_CONTROL, DOE_GO)) {
             pcie_doe_prepare_rsp(doe_cap);
         }
 
         if (FIELD_EX32(val, PCI_DOE_CAP_CONTROL, DOE_INTR_EN)) {
             doe_cap->ctrl.intr = 1;
         /* Clear interrupt bit located within the first byte */
         } else if (shift == 0) {
             doe_cap->ctrl.intr = 0;
         }
         break;
     case PCI_EXP_DOE_STATUS:
         if (FIELD_EX32(val, PCI_DOE_CAP_STATUS, DOE_INTR_STATUS)) {
             doe_cap->status.intr = 0;
         }
         break;
     case PCI_EXP_DOE_RD_DATA_MBOX:
         /* Mailbox should be DW accessed */
         if (size != DWORD_BYTE) {
             return;
         }
         doe_cap->read_mbox_idx++;
         if (doe_cap->read_mbox_idx == doe_cap->read_mbox_len) {
             pcie_doe_reset_mbox(doe_cap);
             pcie_doe_set_ready(doe_cap, 0);
         } else if (doe_cap->read_mbox_idx > doe_cap->read_mbox_len) {
             /* Underflow */
             pcie_doe_set_error(doe_cap, 1);
         }
         break;
     case PCI_EXP_DOE_WR_DATA_MBOX:
         /* Mailbox should be DW accessed */
         if (size != DWORD_BYTE) {
             return;
         }
         doe_cap->write_mbox[doe_cap->write_mbox_len] = val;
         doe_cap->write_mbox_len++;
         break;
     case PCI_EXP_DOE_CAP:
-        /* fallthrough */
+        fallthrough;
     default:
         break;
     }
 }
-- 
2.39.2


