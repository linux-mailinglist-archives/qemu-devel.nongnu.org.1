Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD602832918
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:43:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQnBr-0007RX-M8; Fri, 19 Jan 2024 06:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnBo-0007PJ-Ru
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:37:36 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnBm-00037H-4Z
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:37:36 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e779f030aso4023025e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705664252; x=1706269052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8IaNDObNAqYNxlZ9PNSQWTtp9Qeox0bgAC84EDezcoU=;
 b=zk7EHrNrHwfkJ05cCktdOV2Es7vmqZ6eSiF9Bv5eyosrcE+eZRp86WzGl5kt1cp7QM
 IxJCCw4q4vnfe4nrMZo+SDRYMtaUO57aA5Kq0wYhk2mu1lzml/weaXP2u1EMvUaoxAtK
 P2a9CtyIQq9R8YyaBhe+VbhlMgbKcRlT721PKoVyCdoWJQ1/Hnp0pQo4aVzwVk/NGZ6q
 k7xXktBh8e6fN1Eict/W9HYJcWPo+HJwrCdqRiY4Yj69UUrJ6aL73dXUY67LNz2dN20w
 rRt0XEE1pihrlicjJGU4f8GGv/VKOBDlq7SE8IM3aI++nJXvoCEHa/USFNPFYOZWSOZG
 COdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705664252; x=1706269052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8IaNDObNAqYNxlZ9PNSQWTtp9Qeox0bgAC84EDezcoU=;
 b=Wm7moZ/drzqPtooDL884GizOK8oJZfBtp6q8jWx31ZYpBbOD03Ppp7fijkvXDUAgNR
 9q/N9JXydO1MhRpF0MGgjlPRWoc/nFVTNtm8Yg50ibOTWMrYHXwYmB4AwUIJtDzjVnBn
 dCr6e0xd05G7mLbHb7wSoebqGXfGIYYgKJlNZYl185oYtbjWg5F8PPLL0jCHtbueT5zh
 0/WijJYsSJuo7jfZnuCdCnCZK2xohWf5tKzdcWWHA0okm/EwChb52MbS9ox3/G0w8CeQ
 U8Eh/0oNbrypIKPOpkU66Hcu09T1cDj8mTQwXKyfWy79IPTWvcgRJg5wPeWzCLuwqUHy
 sBug==
X-Gm-Message-State: AOJu0Yy65XrE3fvrsGNImuHzmmJ7tVAY/ZLqEaOo0/HfJ6hrCaSLroeA
 XlR8nWonM0Y67LJi9hQgDpEXIsD7TRBiuewfFV5sxjtySCExKKuSvNB//o92MEXSom3M2w4GvR2
 KKOCFZQ==
X-Google-Smtp-Source: AGHT+IGME/CrHYUSCjWLKv9N7hUwo8xb1T01fsrIIY9PgyaLVNdwLW0/psrKAa/3cpDKhot/jlQmvg==
X-Received: by 2002:a05:600c:1388:b0:40e:43ba:cf3f with SMTP id
 u8-20020a05600c138800b0040e43bacf3fmr505422wmf.1.1705664252716; 
 Fri, 19 Jan 2024 03:37:32 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 j6-20020adfb306000000b00339208ecb30sm1294065wrd.68.2024.01.19.03.37.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 03:37:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL 32/36] hw/scsi/esp-pci: set DMA_STAT_BCMBLT when BLAST command
 issued
Date: Fri, 19 Jan 2024 12:35:01 +0100
Message-ID: <20240119113507.31951-33-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119113507.31951-1-philmd@linaro.org>
References: <20240119113507.31951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Even though the BLAST command isn't fully implemented in QEMU, the DMA_STAT_BCMBLT
bit should be set after the command has been issued to indicate that the command
has completed.

This fixes an issue with the DC390 DOS driver which issues the BLAST command as
part of its normal error recovery routine at startup, and otherwise sits in a
tight loop waiting for DMA_STAT_BCMBLT to be set before continuing.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20240112131529.515642-5-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/esp-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 875a49199d..42d9d2e483 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -124,6 +124,7 @@ static void esp_pci_handle_blast(PCIESPState *pci, uint32_t val)
 {
     trace_esp_pci_dma_blast(val);
     qemu_log_mask(LOG_UNIMP, "am53c974: cmd BLAST not implemented\n");
+    pci->dma_regs[DMA_STAT] |= DMA_STAT_BCMBLT;
 }
 
 static void esp_pci_handle_abort(PCIESPState *pci, uint32_t val)
-- 
2.41.0


