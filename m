Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9427C7F85
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:08:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD5w-00019P-NV; Fri, 13 Oct 2023 04:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5U-0007zM-4n
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:00:03 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5S-0007SZ-Ku
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:59 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-405417465aaso19409555e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183997; x=1697788797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C1368VMaP/F8gmPJiGLvz1ILNWifclUEQlInYr5UJbM=;
 b=cqoeN/ox3ktP4lpSDGZDE2rIFbJmJ9UDfb0u5EKzALTAmipHiQ8zaqtoUYSDf1cwEc
 TkrUNMyd/cBUBs6cSn+NWau+F0xzsLCju+X5teBLHx26EBCayU06XsRe+GWPfpMgnofc
 icvAgi85Q7+u2VIHe2ggxrSyzlfaev1v2teZcb41Y7umTKP8ByqJvRlS2VNt0Mk3KeqX
 nvB1R2aUNNvQQPcuZVfR/6miO54sZmbudBhVEsd71mJwuEhHH43VDgriPaCBV0ZnjOFl
 T+VHrfCCBygs9Dh8YxqbtVBVViU1yrprDq9GA77ycEzt9trZhuJx8Oj7PQXZSFsRfBCd
 M/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183997; x=1697788797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C1368VMaP/F8gmPJiGLvz1ILNWifclUEQlInYr5UJbM=;
 b=F+m7ikcGXTOKWzTKkH7SJafsdlgjEhHW3CoOyiSz7OWsMZ/lwTX4B5p6RFjSNRH0//
 iJP7RyaeP29dHFZeXvrjpplPCujxARM2K5mgtnaU4g+p22FyX+7ntOx+C1rzqD8dacCv
 Eh1WaqmPuiObuBfY80fnL4wk6K4OezIXQqsKUCb90ZiLE1FwdPB+oVxo+OfdxDUSB0jw
 n/6Ae8RexLomWgPMXUAZ+q8HxGwfq4egjLMO/m57/oibGTkz982FZmlf6AVc4kHMGOfw
 tHMG0ekxFHRZrOEi+15HRutEW7bV3meGaH+PSkudO6W04en5dXN5B/gjdctrJkivftS+
 N7/w==
X-Gm-Message-State: AOJu0Ywus4fHIDpK1s5SlCeW4Hm/1E6HI7B1rw4tsoAvwG8qSs2C8prt
 4xoV0yjZufKLhusN+3E3JHIcgBfgQTijrEmJxcM=
X-Google-Smtp-Source: AGHT+IHX8+W8L6Qr3lojg7+lZLGRIbYM8pNJF74SaHy8ejQQEO3KIhR4/GqOr0Dm4kkCmcdj8Dmnnw==
X-Received: by 2002:a1c:721a:0:b0:405:1baf:cedf with SMTP id
 n26-20020a1c721a000000b004051bafcedfmr23274087wmc.24.1697183997157; 
 Fri, 13 Oct 2023 00:59:57 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:59:56 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [RFC PATCH v2 67/78] hw/pci-host/pnv_phb3.c: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:34 +0300
Message-Id: <ad7d8e3f34287ab7c4719ce504a9c49f8c179e78.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x335.google.com
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
 hw/pci-host/pnv_phb3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index c5e58f4086..6a805d3900 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -470,121 +470,121 @@ static void pnv_phb3_update_all_msi_regions(PnvPHB3 *phb)
 void pnv_phb3_reg_write(void *opaque, hwaddr off, uint64_t val, unsigned size)
 {
     PnvPHB3 *phb = opaque;
     bool changed;
 
     /* Special case configuration data */
     if ((off & 0xfffc) == PHB_CONFIG_DATA) {
         pnv_phb3_config_write(phb, off & 0x3, size, val);
         return;
     }
 
     /* Other registers are 64-bit only */
     if (size != 8 || off & 0x7) {
         phb3_error(phb, "Invalid register access, offset: 0x%"PRIx64" size: %d",
                    off, size);
         return;
     }
 
     /* Handle masking & filtering */
     switch (off) {
     case PHB_M64_UPPER_BITS:
         val &= 0xfffc000000000000ull;
         break;
     case PHB_Q_DMA_R:
         /*
          * This is enough logic to make SW happy but we aren't actually
          * quiescing the DMAs
          */
         if (val & PHB_Q_DMA_R_AUTORESET) {
             val = 0;
         } else {
             val &= PHB_Q_DMA_R_QUIESCE_DMA;
         }
         break;
     /* LEM stuff */
     case PHB_LEM_FIR_AND_MASK:
         phb->regs[PHB_LEM_FIR_ACCUM >> 3] &= val;
         return;
     case PHB_LEM_FIR_OR_MASK:
         phb->regs[PHB_LEM_FIR_ACCUM >> 3] |= val;
         return;
     case PHB_LEM_ERROR_AND_MASK:
         phb->regs[PHB_LEM_ERROR_MASK >> 3] &= val;
         return;
     case PHB_LEM_ERROR_OR_MASK:
         phb->regs[PHB_LEM_ERROR_MASK >> 3] |= val;
         return;
     case PHB_LEM_WOF:
         val = 0;
         break;
     }
 
     /* Record whether it changed */
     changed = phb->regs[off >> 3] != val;
 
     /* Store in register cache first */
     phb->regs[off >> 3] = val;
 
     /* Handle side effects */
     switch (off) {
     case PHB_PHB3_CONFIG:
         if (changed) {
             pnv_phb3_update_all_msi_regions(phb);
         }
-        /* fall through */
+        fallthrough;
     case PHB_M32_BASE_ADDR:
     case PHB_M32_BASE_MASK:
     case PHB_M32_START_ADDR:
         if (changed) {
             pnv_phb3_check_m32(phb);
         }
         break;
     case PHB_M64_UPPER_BITS:
         if (changed) {
             pnv_phb3_check_all_m64s(phb);
         }
         break;
     case PHB_LSI_SOURCE_ID:
         if (changed) {
             pnv_phb3_lsi_src_id_write(phb, val);
         }
         break;
 
     /* IODA table accesses */
     case PHB_IODA_DATA0:
         pnv_phb3_ioda_write(phb, val);
         break;
 
     /* RTC invalidation */
     case PHB_RTC_INVALIDATE:
         pnv_phb3_rtc_invalidate(phb, val);
         break;
 
     /* FFI request */
     case PHB_FFI_REQUEST:
         pnv_phb3_msi_ffi(&phb->msis, val);
         break;
 
     /* Silent simple writes */
     case PHB_CONFIG_ADDRESS:
     case PHB_IODA_ADDR:
     case PHB_TCE_KILL:
     case PHB_TCE_SPEC_CTL:
     case PHB_PEST_BAR:
     case PHB_PELTV_BAR:
     case PHB_RTT_BAR:
     case PHB_RBA_BAR:
     case PHB_IVT_BAR:
     case PHB_FFI_LOCK:
     case PHB_LEM_FIR_ACCUM:
     case PHB_LEM_ERROR_MASK:
     case PHB_LEM_ACTION0:
     case PHB_LEM_ACTION1:
         break;
 
     /* Noise on anything else */
     default:
         qemu_log_mask(LOG_UNIMP, "phb3: reg_write 0x%"PRIx64"=%"PRIx64"\n",
                       off, val);
     }
 }
-- 
2.39.2


