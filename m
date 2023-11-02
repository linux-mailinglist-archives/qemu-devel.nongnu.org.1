Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B06C37DEA6A
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:51:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMeV-00076P-Bv; Wed, 01 Nov 2023 21:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMeO-0006UG-Eu
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:37:36 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMeM-0004N5-6H
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:37:36 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3b2f28caab9so262963b6e.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698889052; x=1699493852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pp6zfL97EYv9sP49urhM/V8BoPWbAzzDBRAX05BVoII=;
 b=vzeeO8lkCdfCUvY8wfa8wteguJdhzHa8tK3HRju6R0eGLM0V2A3A08sQp12jZmv80h
 52tWvkDkul2UkKp8vquHKKmi9azWVE/n6+kaj+WXhTrqqrEVlD5rHb22Au/u8QmFb5Ds
 78MEQj2sNV2TKo5tR2+ml9K2dS5ZdPBH77Rl7P/+gyd5y3BguuzQC8LkwDJiodu2auIE
 ZbEfVaVPKWbVAtn6B3tSp0tmN9Y36TxUZvTWO+jm0/rI0gkLGOTLkI7efAqLmE+ZqSf2
 eeg+R7eW8dFlIGHqBNylvVohwftPnXYpUPZoD3xp+7VKER5lmzggectd0tTfJcCMI4fu
 85YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698889052; x=1699493852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pp6zfL97EYv9sP49urhM/V8BoPWbAzzDBRAX05BVoII=;
 b=nzbWkFeqX5Keh4TKZYMj1i5a86OEVOvYHqtP8+6PpwFun7nf0O8x6iYfnDl5HVla2e
 kxQ1aakO3ploHcUJ1+T0Kg9VdKdIZ7VQcwSfZmOR7WKJJxeexnuuf9muwPd6TUzsvmso
 aocN2cNyJ1ZmfyI+Wl0NsAxq/5jk+18XoAkN2rIWZJBHMGbzgk9jO+tmDyvjhAgYSXFQ
 C2OZ+wG6/LMBpKOJq/qXDhXo9kMpvjrtRMBr0MdRHZbwfGXLB67sSlCAqV5jz1RbncrV
 AIbzleSMJD/1pTSvXO3CzC3mP65iENCOFhc4lVFz+CelgBAByL23DLBcuaIoDvc67PbR
 P/8A==
X-Gm-Message-State: AOJu0YymzW8n75Hfjw48/LqH7ApwFMw4CohFxjWaD9RJaSIUkhXSlNeq
 kjTgS/micGg+ImKhxBoX7wEnkGKgLMw2Sg/YkPA=
X-Google-Smtp-Source: AGHT+IEDyVklVQWhaRM7bRXhjUSt3FD1HSgJNC/tP+GVp7fSuZFlUfannmjDvnAmeHXuwdq7LEdKkQ==
X-Received: by 2002:a05:6808:3084:b0:3b5:75ec:44fd with SMTP id
 bl4-20020a056808308400b003b575ec44fdmr5916939oib.13.1698889052163; 
 Wed, 01 Nov 2023 18:37:32 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v20-20020aa78514000000b006934e7ceb79sm1800230pfn.32.2023.11.01.18.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:37:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 88/88] hw/hppa: Map PDC ROM and I/O memory area into lower
 memory
Date: Wed,  1 Nov 2023 18:30:16 -0700
Message-Id: <20231102013016.369010-89-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

From: Helge Deller <deller@gmx.de>

When running a 64-bit CPU in 32-bit mode (e.g. when using a
32-bit kernel) the PDC ROM and I/O area has to be accessible
in the 0xf0000000 memory region.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index a3222d3a96..e488914bba 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -603,6 +603,7 @@ static void machine_HP_C3700_init(MachineState *machine)
     AstroState *astro;
     DeviceState *astro_dev;
     MemoryRegion *addr_space = get_system_memory();
+    MemoryRegion *io_low_alias = g_new(MemoryRegion, 2);
     TranslateFn *translate;
 
     /* Create CPUs and RAM.  */
@@ -614,6 +615,20 @@ static void machine_HP_C3700_init(MachineState *machine)
         exit(1);
     }
 
+    /* map PDC ROM into lower memory region, needed if PSW.W=0 */
+    memory_region_init_alias(&io_low_alias[0], NULL, "firmware-alias",
+                             addr_space, translate(NULL, FIRMWARE_START),
+                             FIRMWARE_END - FIRMWARE_START);
+    memory_region_add_subregion(addr_space, (uint32_t) FIRMWARE_START,
+                             &io_low_alias[0]);
+
+    /* map all of I/O area into lower memory region, needed if PSW.W=0 */
+    memory_region_init_alias(&io_low_alias[1], NULL, "iomem-alias",
+                             addr_space, translate(NULL, 0xf1000000UL),
+                             0xf000000UL);
+    memory_region_add_subregion(addr_space, (uint32_t) 0xf1000000UL,
+                             &io_low_alias[1]);
+
     /* Init Astro and the Elroys (PCI host bus chips).  */
     astro = astro_init();
     astro_dev = DEVICE(astro);
-- 
2.34.1


