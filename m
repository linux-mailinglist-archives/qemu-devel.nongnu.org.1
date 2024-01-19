Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9DF8328FF
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:41:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQnBf-0006Zh-FN; Fri, 19 Jan 2024 06:37:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnBc-0006Fj-96
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:37:24 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnBZ-00030u-2R
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:37:23 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40e913e3f03so7593235e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705664239; x=1706269039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dFDI//XvTpn1St0hBV0sdqL1iHcD9DD5+xWDU4qjjTU=;
 b=pdGn9JtO76ViFOkGKsvfbXZ4CWo1qTx3bP39Kqzb9rUhmPkIPIgGISZl/OR85c3ZLB
 aw3A8+20jAS5p49HNSu7Y8f860kaNvQY//Xs8uG7+yPgOqu94HHPZFEw2KONo3fhG/QA
 ztyjOcX3oyODeAJfmdbmPLRwAmae/xVbbOd7VjeMqgJlkN2p52XimtI6u7meeu3KCIoB
 3lieDp8R2VeAuXJcVG8D+d/h0o5Ei6Cvwkmtlq3IvFWIox3CvivMXOQNAgBfy3q/m1Qe
 MSnGyXDHmwwm1yqsCKX/SxvAooIvccs80g2TBOWZjh/9OZVxrksr/xUgPAZhzHimYJ6R
 C1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705664239; x=1706269039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dFDI//XvTpn1St0hBV0sdqL1iHcD9DD5+xWDU4qjjTU=;
 b=XGbHnLcjeHCaSIv1yJazXqIqmc8QPVDOUEq+OwUnVdn1GbnmShyx4Vu3UmDfZKe2Ob
 foz0AfJ1YzN+zgF7PiBZlLcYlGidDZfgicoCY8NccKKo6FMkFb4i4V5kAyH6D8HNWyhP
 ev1cL0gO9jlFaxXX4LRXO/ky1OKZEedp7ikRLhgZG1URgz8GkOhnlsChCEke1a9d2uwL
 jZUGhzIPSu/m/gMLjSyndhPqkvGpM0QmSQ0zOMIyrq48OKd0FE5YPb1QF5Xh53mDgJiJ
 GcNYKxwg+VQgKJZ/28azxBQhLIl3tjDMVox3xXjepPe85a1C8yTBo+e1un7Q7reQi5dh
 0MTg==
X-Gm-Message-State: AOJu0YynKuICgFfg2KB3Nl3o2bpT+Ud9Ax82Di2MurmD06ydJxiQV8Lz
 Wfjc9QKE1C0OTbvna0kCu9t7M11ke2oV5lMwDMUGgxf1A0wFTgntCYPv5BtUO7dalLSQnSG8zTO
 WrS6e0A==
X-Google-Smtp-Source: AGHT+IHBsxGhiqOP2J59pw5V3ykjU+IqxuY7VADRv+9nsJGvb8/ST9tgkWcz/EcfCnUH1vMUyB5rCQ==
X-Received: by 2002:a7b:c311:0:b0:40e:4252:e26 with SMTP id
 k17-20020a7bc311000000b0040e42520e26mr1417146wmj.69.1705664239333; 
 Fri, 19 Jan 2024 03:37:19 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 c11-20020a05600c0a4b00b0040d53588d94sm32738791wmq.46.2024.01.19.03.37.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 03:37:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL 29/36] hw/scsi/esp-pci: use correct address register for PCI
 DMA transfers
Date: Fri, 19 Jan 2024 12:34:58 +0100
Message-ID: <20240119113507.31951-30-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119113507.31951-1-philmd@linaro.org>
References: <20240119113507.31951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The current code in esp_pci_dma_memory_rw() sets the DMA address to the value
of the DMA_SPA (Starting Physical Address) register which is incorrect: this
means that for each callback from the SCSI layer the DMA address is set back
to the starting address.

In the case where only a single SCSI callback occurs (currently for transfer
lengths < 128kB) this works fine, however for larger transfers the DMA address
wraps back to the initial starting address, corrupting the buffer holding the
data transferred to the guest.

Fix esp_pci_dma_memory_rw() to use the DMA_WAC (Working Address Counter) for
the DMA address which is correctly incremented across multiple SCSI layer
transfers.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20240112131529.515642-2-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/esp-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 93b3429e0f..7117725371 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -275,7 +275,7 @@ static void esp_pci_dma_memory_rw(PCIESPState *pci, uint8_t *buf, int len,
         qemu_log_mask(LOG_UNIMP, "am53c974: MDL transfer not implemented\n");
     }
 
-    addr = pci->dma_regs[DMA_SPA];
+    addr = pci->dma_regs[DMA_WAC];
     if (pci->dma_regs[DMA_WBC] < len) {
         len = pci->dma_regs[DMA_WBC];
     }
-- 
2.41.0


