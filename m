Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5892673602C
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 01:38:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBOQW-0001ob-NJ; Mon, 19 Jun 2023 19:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qBOQT-0001o6-Kb; Mon, 19 Jun 2023 19:36:49 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qBOQR-0001nY-KB; Mon, 19 Jun 2023 19:36:49 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-39ecf9c3eefso1410878b6e.3; 
 Mon, 19 Jun 2023 16:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687217805; x=1689809805;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=xrObNC3Ml8hVcp3RYW86ZMmi77DHMJaEhym30Bk/0Fo=;
 b=Hg4G3wh1XgY5pOFUqHw8sHNzlTB3rO1Y3zb2fvtVoNrTsiIV2kiUWE3i5XujM6ujMs
 yBGz6L1M3wYw2/DWWlZrT4h/g2giN8nZj/XAALLayKEEeAKdMcjSoRRo0pJZ4St0ib/b
 /tCt/DDLn99AGKv2r+KxPB6SNZss5iKDd0p5F33RlXUmxBBI7d5I84dQPOMof9sDB4mv
 +wiXu6Ud3QuKUzflCK7/EBQIeC0bGkMCH5dZj2kewJcVM5nO4sE3yUnaEIOb6L85HQYS
 8ZTo7BeqnYbp/dJrgVyB+okirknaKYIQjR3YGuco7kadtWDeNJDylrJovDFnCTnLGDkF
 b/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687217805; x=1689809805;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xrObNC3Ml8hVcp3RYW86ZMmi77DHMJaEhym30Bk/0Fo=;
 b=Ki9RrRxOkxJzdUCHApdCzro5fsXUkYh/kzDkJ+/xwIRN9a8DG2zOEi9htIkOskflHA
 WIRv/s/Ug91dVhppdlI9GLredAM8skNv12deQLM7nwoQbN9pc3iy5Uh7X+AuxbDmaKd6
 sgVNOyoRdUFeAJSwRoii4+cFubnydUgc70AGsYKOgAUrZ8L/z+sm/8qH4vL2+H4JQDLO
 JQ8OiVNL4OjKs8Z05DRgiBjjA+gh/M6Jfdn6+/gL3dMamdIDKrIgWqg0frQz4sjk98Vb
 CNeiI8NSl+RemwazhNee1wS8G395ke3fcP8JkcDa89GTRJEHBsC1sBp32uld1eD2ep/0
 8wgA==
X-Gm-Message-State: AC+VfDz+MWQI70Pk7lqi9KoeFn1Qhhl40tnz5GaeK/fHcjElZkonYKs/
 gecHCHvkKYkAXVSFT0DYE6E=
X-Google-Smtp-Source: ACHHUZ4WDa/FPMlaXRHrpCYX0uLkU8R/k9YDM3OV5gaYkFxVfi2Slse7b4dDdCaoMUPziAnXRvSPXA==
X-Received: by 2002:a05:6808:2ca:b0:38c:5a32:325b with SMTP id
 a10-20020a05680802ca00b0038c5a32325bmr11381063oid.41.1687217805233; 
 Mon, 19 Jun 2023 16:36:45 -0700 (PDT)
Received: from voyager.lan ([45.124.203.15]) by smtp.gmail.com with ESMTPSA id
 z16-20020a17090ab11000b00256799877ffsm279950pjq.47.2023.06.19.16.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 16:36:44 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org
Subject: [PATCH] ppc/pnv/pci: Clean up error messages
Date: Tue, 20 Jun 2023 09:06:36 +0930
Message-Id: <20230619233636.57452-1-joel@jms.id.au>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=joel.stan@gmail.com; helo=mail-oi1-x232.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The phb error macros add a newline for you, so remove the second one to
avoid double whitespace.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/pci-host/pnv_phb4.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 542f9e293221..6232cbeee161 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -133,13 +133,13 @@ static void pnv_phb4_rc_config_write(PnvPHB4 *phb, unsigned off,
     PCIDevice *pdev;
 
     if (size != 4) {
-        phb_error(phb, "rc_config_write invalid size %d\n", size);
+        phb_error(phb, "rc_config_write invalid size %d", size);
         return;
     }
 
     pdev = pci_find_device(pci->bus, 0, 0);
     if (!pdev) {
-        phb_error(phb, "rc_config_write device not found\n");
+        phb_error(phb, "rc_config_write device not found");
         return;
     }
 
@@ -155,13 +155,13 @@ static uint64_t pnv_phb4_rc_config_read(PnvPHB4 *phb, unsigned off,
     uint64_t val;
 
     if (size != 4) {
-        phb_error(phb, "rc_config_read invalid size %d\n", size);
+        phb_error(phb, "rc_config_read invalid size %d", size);
         return ~0ull;
     }
 
     pdev = pci_find_device(pci->bus, 0, 0);
     if (!pdev) {
-        phb_error(phb, "rc_config_read device not found\n");
+        phb_error(phb, "rc_config_read device not found");
         return ~0ull;
     }
 
@@ -1039,19 +1039,19 @@ static void pnv_pec_stk_nest_xscom_write(void *opaque, hwaddr addr,
         if (phb->nest_regs[PEC_NEST_STK_BAR_EN] &
             (PEC_NEST_STK_BAR_EN_MMIO0 |
              PEC_NEST_STK_BAR_EN_MMIO1)) {
-            phb_pec_error(pec, "Changing enabled BAR unsupported\n");
+            phb_pec_error(pec, "Changing enabled BAR unsupported");
         }
         phb->nest_regs[reg] = val & 0xffffffffff000000ull;
         break;
     case PEC_NEST_STK_PHB_REGS_BAR:
         if (phb->nest_regs[PEC_NEST_STK_BAR_EN] & PEC_NEST_STK_BAR_EN_PHB) {
-            phb_pec_error(pec, "Changing enabled BAR unsupported\n");
+            phb_pec_error(pec, "Changing enabled BAR unsupported");
         }
         phb->nest_regs[reg] = val & 0xffffffffffc00000ull;
         break;
     case PEC_NEST_STK_INT_BAR:
         if (phb->nest_regs[PEC_NEST_STK_BAR_EN] & PEC_NEST_STK_BAR_EN_INT) {
-            phb_pec_error(pec, "Changing enabled BAR unsupported\n");
+            phb_pec_error(pec, "Changing enabled BAR unsupported");
         }
         phb->nest_regs[reg] = val & 0xfffffff000000000ull;
         break;
-- 
2.39.2


