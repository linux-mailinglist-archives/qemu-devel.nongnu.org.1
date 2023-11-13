Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B59D7EA24E
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:47:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2b1R-0006yZ-KC; Mon, 13 Nov 2023 12:46:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2b1F-0006wa-Vt
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:46:42 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2b1E-0003Jl-9y
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:46:41 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c5b7764016so57170711fa.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699897598; x=1700502398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9eeFUonyZperk3WbTyB0C+tM8FT/EhmPijOJJIm8Ls0=;
 b=Ufa/7YhDWAIfz6Nt4QYenlB1xbSrIKIeeuIQVp4Sb6wVsHBX6NdRJsBVAXiqv249sL
 anqB/XcdovFY3pVTf02ByUb/CDuq8pI8nJ3k+Dt+KYYwmwhpYfLBRWuRJQrUprPfT+n8
 5w0gBo7cpwweiEeDDQelLyfKkiZaqvVJHR9FpoXnuPyig+lI3ZnlX+l6sI9Ce7Qmwmx9
 66pDRGmsoYrAf0i5P9jrV3WU3hC1WOod4LkzSQezkCBRZsGERFynws0lXKzK7qsN57AI
 4pRIy5xHuqi97KpAfEM97DNykzuklMrsjiOB/3Ou8D6pjSXeCd0wZMrWq1IeL4tHPWZJ
 F47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699897598; x=1700502398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9eeFUonyZperk3WbTyB0C+tM8FT/EhmPijOJJIm8Ls0=;
 b=C1Z7vU8MNJ/xZ5+OAIUqNibbKTun0P6S0alQ6kMqbbxNpgaOg1CpGUuC9rbcipBYNk
 2mHOzheP+CaNGQ/lZbQn78Amdh7SnTEr4EvhQFfaT3TPY0BHE/HSY9PuLGNW+L6cQ1wh
 xQrJuiCRNYD5vBUqUjXPjsLLoz5Pkl9d5xkQJJvOqSQ+ud1oHrU6tvOb5TMfD61mYgPz
 K2boP0ZflrJ91hiB74EmvAXfKVmjwkQRW9Le0zkiozg41wklkgCsJkKR20BiR9JN+/Q+
 XPhNoVwvh9nauKnaU/7GQRSerbQKvni4P13nIpy4Ckp2QhM70oC77Ks4gTGOLQioJtyV
 EbTQ==
X-Gm-Message-State: AOJu0YxqQWYrqngSUK2k2BuVqQRQ0Gk0y//cAwp//h8se9izz8aiUrNk
 +sf7i14l0Al1rDTNtiAOmP0dopN0Dchb42RHDyU=
X-Google-Smtp-Source: AGHT+IF/fnW+omGXPRwQ13zFfTpY8n478VZLaMvQ9WY9akvtSICqtPv7zgDDJucFiIDkRRpuUfWCPw==
X-Received: by 2002:a2e:2e0f:0:b0:2bc:e2bc:81ff with SMTP id
 u15-20020a2e2e0f000000b002bce2bc81ffmr5033411lju.51.1699897597676; 
 Mon, 13 Nov 2023 09:46:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05600c22c800b0040303a9965asm14391110wmg.40.2023.11.13.09.46.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 09:46:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] hw/arm/virt: fix GIC maintenance IRQ registration
Date: Mon, 13 Nov 2023 17:46:32 +0000
Message-Id: <20231113174635.2540484-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113174635.2540484-1-peter.maydell@linaro.org>
References: <20231113174635.2540484-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Since commit 9036e917f8 ("{include/}hw/arm: refactor virt PPI logic"),
GIC maintenance IRQ registration fails on arm64:

[    0.979743] kvm [1]: Cannot register interrupt 9

That commit re-defined VIRTUAL_PMU_IRQ to be a INTID but missed a case
where the maintenance IRQ is actually referred by its PPI index. Just
like commit fa68ecb330db ("hw/arm/virt: fix PMU IRQ registration"), use
INITID_TO_PPI(). A search of "GIC_FDT_IRQ_TYPE_PPI" indicates that there
shouldn't be more similar issues.

Fixes: 9036e917f8 ("{include/}hw/arm: refactor virt PPI logic")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-id: 20231110090557.3219206-2-jean-philippe@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 85e3c5ba9d2..be2856c018a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -576,7 +576,8 @@ static void fdt_add_gic_node(VirtMachineState *vms)
 
         if (vms->virt) {
             qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
-                                   GIC_FDT_IRQ_TYPE_PPI, ARCH_GIC_MAINT_IRQ,
+                                   GIC_FDT_IRQ_TYPE_PPI,
+                                   INTID_TO_PPI(ARCH_GIC_MAINT_IRQ),
                                    GIC_FDT_IRQ_FLAGS_LEVEL_HI);
         }
     } else {
@@ -600,7 +601,8 @@ static void fdt_add_gic_node(VirtMachineState *vms)
                                          2, vms->memmap[VIRT_GIC_VCPU].base,
                                          2, vms->memmap[VIRT_GIC_VCPU].size);
             qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
-                                   GIC_FDT_IRQ_TYPE_PPI, ARCH_GIC_MAINT_IRQ,
+                                   GIC_FDT_IRQ_TYPE_PPI,
+                                   INTID_TO_PPI(ARCH_GIC_MAINT_IRQ),
                                    GIC_FDT_IRQ_FLAGS_LEVEL_HI);
         }
     }
-- 
2.34.1


