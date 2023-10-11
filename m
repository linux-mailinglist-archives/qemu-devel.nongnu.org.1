Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 081087C550A
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:14:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqYYr-0006rS-V4; Wed, 11 Oct 2023 08:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqYYk-0006kv-TU
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 08:43:31 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqYYi-0003GR-0Z
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 08:43:30 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-405417465aaso65225775e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 05:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697028206; x=1697633006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vxaAINrq3Mze6vSSQ9tfijhvvCdKsip5zQTvkm9DzJo=;
 b=Qsssc+BhXy7W/dzZ3R8wjkCkR/jTqGoWD3aR5+nOr4xUiglKPFQp+q7KGOc83+iBCA
 m6LmLfdasyAwi9mWTuaJ7xSamGeFBvdr1JbVZr8qnZ57TRFEnbVz2UHZ1SS0ib724nx8
 cjbqYsUu87VZ/mw/y0aFQ8B+pGQkspBeDZEwXJai9BFjkh0sdfprMxofvxpINk8pHUq+
 sDEsxKM/SnaXW9+ca6uWYLhG21rdVwDzAJloo7ihSlJG1RgN317SUWkRxJTFmunJ6cDW
 6+yOCVy5WM330I9rZpLw7akKtDyTiR8wqWPlPelflFTITFBqY8ec/Sz+QX8X4Gige1iY
 +rOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697028206; x=1697633006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vxaAINrq3Mze6vSSQ9tfijhvvCdKsip5zQTvkm9DzJo=;
 b=axeuMQs2wXjxWSB0aE2EZpPC/BtH/sviIhe/xEVYW5/wSSQVRw6GfCcaBiDxPxI7cV
 1Zq6w3V+DlKuMCPUv56xPYfyUppzNo9VbKL9862wikJ4ixyeBwQERV7+FkwJeoBqgYI0
 t7aNI0kbIXLm+7obwEfYkr5cBlfhqrKVCf258l89L0DcMqi/0682qRBT4yGJCQw2r2JH
 MOz4zTg/5vK0MsDfq6oxLAqKwM6je3puCU/E3sIs0xWavJkQvWztrjVarAQwb++BVtSo
 5dGaEeFkODpeJxM7H9gy2IGDFf7QyzknoUQ/Y/beB6/EfHZMrt478U77KvUSKvLVnOlQ
 y65w==
X-Gm-Message-State: AOJu0YwgYKcFuLZOaVwiNbRLlyGNr/uPvw4yZgpPwNID/7nL9BeRuf98
 nm9mQCCHXK/tl1LL4TWYEpNHRDsKcgcRthQnSpA=
X-Google-Smtp-Source: AGHT+IG7vL/ED9zPNOGfqvm80bUaGZW1AzJg6dBfzzeIlNsD+vDr1NVK9IMDEvDAQcXzv2H1Kjczeg==
X-Received: by 2002:a05:600c:3b14:b0:407:4944:76e5 with SMTP id
 m20-20020a05600c3b1400b00407494476e5mr7745351wms.22.1697028206049; 
 Wed, 11 Oct 2023 05:43:26 -0700 (PDT)
Received: from m1x-phil.lan (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 t25-20020a1c7719000000b004065daba6casm19158429wmi.46.2023.10.11.05.43.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Oct 2023 05:43:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] hw/ppc/ppc440_uc: Remove dead l2sram_update_mappings()
Date: Wed, 11 Oct 2023 14:43:12 +0200
Message-ID: <20231011124312.60476-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011124312.60476-1-philmd@linaro.org>
References: <20231011124312.60476-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Apparently l2sram_update_mappings() bit-rotted over time,
when defining MAP_L2SRAM we get:

  hw/ppc/ppc440_uc.c:83:17: error: no member named 'isarc' in 'struct ppc4xx_l2sram_t'
      if (l2sram->isarc != isarc ||
          ~~~~~~  ^
  hw/ppc/ppc440_uc.c:84:18: error: no member named 'isacntl' in 'struct ppc4xx_l2sram_t'
          (l2sram->isacntl & 0x80000000) != (isacntl & 0x80000000)) {
           ~~~~~~  ^
  hw/ppc/ppc440_uc.c:85:21: error: no member named 'isacntl' in 'struct ppc4xx_l2sram_t'
          if (l2sram->isacntl & 0x80000000) {
              ~~~~~~  ^
  hw/ppc/ppc440_uc.c:88:50: error: no member named 'isarc_ram' in 'struct ppc4xx_l2sram_t'
                                          &l2sram->isarc_ram);
                                           ~~~~~~  ^
  hw/ppc/ppc440_uc.c:93:50: error: no member named 'isarc_ram' in 'struct ppc4xx_l2sram_t'
                                          &l2sram->isarc_ram);
                                           ~~~~~~  ^
  hw/ppc/ppc440_uc.c:96:17: error: no member named 'dsarc' in 'struct ppc4xx_l2sram_t'
      if (l2sram->dsarc != dsarc ||
          ~~~~~~  ^
  hw/ppc/ppc440_uc.c:97:18: error: no member named 'dsacntl' in 'struct ppc4xx_l2sram_t'
          (l2sram->dsacntl & 0x80000000) != (dsacntl & 0x80000000)) {
           ~~~~~~  ^
  hw/ppc/ppc440_uc.c:98:21: error: no member named 'dsacntl' in 'struct ppc4xx_l2sram_t'
          if (l2sram->dsacntl & 0x80000000) {
              ~~~~~~  ^
  hw/ppc/ppc440_uc.c:100:52: error: no member named 'dsarc' in 'struct ppc4xx_l2sram_t'
              if (!(isacntl & 0x80000000) || l2sram->dsarc != isarc) {
                                             ~~~~~~  ^
  hw/ppc/ppc440_uc.c:103:54: error: no member named 'dsarc_ram' in 'struct ppc4xx_l2sram_t'
                                              &l2sram->dsarc_ram);
                                               ~~~~~~  ^
  hw/ppc/ppc440_uc.c:111:54: error: no member named 'dsarc_ram' in 'struct ppc4xx_l2sram_t'
                                              &l2sram->dsarc_ram);
                                               ~~~~~~  ^

Remove that dead code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/ppc440_uc.c | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 4181c843a8..643a79e330 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -73,46 +73,6 @@ typedef struct ppc4xx_l2sram_t {
     uint32_t isram0[11];
 } ppc4xx_l2sram_t;
 
-#ifdef MAP_L2SRAM
-static void l2sram_update_mappings(ppc4xx_l2sram_t *l2sram,
-                                   uint32_t isarc, uint32_t isacntl,
-                                   uint32_t dsarc, uint32_t dsacntl)
-{
-    if (l2sram->isarc != isarc ||
-        (l2sram->isacntl & 0x80000000) != (isacntl & 0x80000000)) {
-        if (l2sram->isacntl & 0x80000000) {
-            /* Unmap previously assigned memory region */
-            memory_region_del_subregion(get_system_memory(),
-                                        &l2sram->isarc_ram);
-        }
-        if (isacntl & 0x80000000) {
-            /* Map new instruction memory region */
-            memory_region_add_subregion(get_system_memory(), isarc,
-                                        &l2sram->isarc_ram);
-        }
-    }
-    if (l2sram->dsarc != dsarc ||
-        (l2sram->dsacntl & 0x80000000) != (dsacntl & 0x80000000)) {
-        if (l2sram->dsacntl & 0x80000000) {
-            /* Beware not to unmap the region we just mapped */
-            if (!(isacntl & 0x80000000) || l2sram->dsarc != isarc) {
-                /* Unmap previously assigned memory region */
-                memory_region_del_subregion(get_system_memory(),
-                                            &l2sram->dsarc_ram);
-            }
-        }
-        if (dsacntl & 0x80000000) {
-            /* Beware not to remap the region we just mapped */
-            if (!(isacntl & 0x80000000) || dsarc != isarc) {
-                /* Map new data memory region */
-                memory_region_add_subregion(get_system_memory(), dsarc,
-                                            &l2sram->dsarc_ram);
-            }
-        }
-    }
-}
-#endif
-
 static uint32_t dcr_read_l2sram(void *opaque, int dcrn)
 {
     ppc4xx_l2sram_t *l2sram = opaque;
-- 
2.41.0


