Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 192E776BCB0
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 20:43:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQuKN-0002bC-19; Tue, 01 Aug 2023 14:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQuKC-0002Vs-4s
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:42:31 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQuK9-0008Bj-DE
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:42:27 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bbc2e1c6b2so38857325ad.3
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 11:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690915344; x=1691520144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=caWHNBRwc8hhmLqj84zcOndTTjMCqt0SmTztB0Xo6vE=;
 b=ZByVdyRMCbwSl+JgyDNfAAIX7j4d1OvhWYw/buN/Xq3WLBdoHTBnM3TgP8qWmCHe/E
 VaBZaRH4ZwwguBjipqaFeqHL2KZ9/W2BRuL3Mrb09PwsxW/FBxlm6ViKCcVyPaNWC7XZ
 PM1BfHBSR0AU2Ka5HP5QP3iNIt3S4exyIV04bglB/D8ful40LhUxKJlhBlOP7W67/8Zo
 u0te1/taqi+SiYG/oY5RFyQgcFXjSZ/jPteGtdV2Ryk5IlzUGqKrZk75SSbBI0B5w3cZ
 bifunnW7YHc0LlfLiyYctG51yyTybyapgDBjeiluryuKKfLsB+x7BUznev0e3C2bOsWl
 4ZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690915344; x=1691520144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=caWHNBRwc8hhmLqj84zcOndTTjMCqt0SmTztB0Xo6vE=;
 b=DE38m0augQGHoG0ILXfakZwi+GMBWaHFl5mt7Ej24GKOhiGduVjvvz/mAjBE1W64Zz
 ieT47BU75KEKYEKQcJ7ehifNwvLc3R8k5coWloFc0i4hR92boS3ABwfMofGMliYwESOX
 No1wKzClj49D/zFF7jo+rkgFFLzzjGdmqANCGue8331NxxLLXfYso1VaGEmAd/nWechV
 NX2kjXzw6Bg+hs5w1gwhNYQL2d8K6aPBfTxZRT018/6uBHY8tbMMjcNXoqEsgHQipTF6
 ZrM3V9j2C/GLbZlxFc7n5SlGJs2m3ILoQ4VrnKJ/nCf4PaUciMpkZJ+8mePIAmPWrV71
 BKpg==
X-Gm-Message-State: ABy/qLZT5qp2gj2iZmNo/WB6NM0l8lDAwdpKYQU4dSoGHWfuvZ+QC7VY
 lMkqOIxYKuoWDc1vaNISGg/uI5BHm3LLmmNQh5E=
X-Google-Smtp-Source: APBJJlE3LX1wyL9lKWbhvTMwltoqXyQhY/+me+BjCWl4xkepMoHtOJWiLuPnE2h3XIT1e5u+xSYmlg==
X-Received: by 2002:a17:902:e841:b0:1bb:ee1b:3cdf with SMTP id
 t1-20020a170902e84100b001bbee1b3cdfmr13310650plg.67.1690915343770; 
 Tue, 01 Aug 2023 11:42:23 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:67b4:35b2:87e2:dccc])
 by smtp.gmail.com with ESMTPSA id
 jn13-20020a170903050d00b001b80ed7b66fsm10797037plb.94.2023.08.01.11.42.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Aug 2023 11:42:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] accel/tcg: Issue wider aligned i/o in do_{ld,st}_mmio_*
Date: Tue,  1 Aug 2023 11:42:19 -0700
Message-Id: <20230801184220.75224-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801184220.75224-1-richard.henderson@linaro.org>
References: <20230801184220.75224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

If the address and size are aligned, send larger chunks
to the memory subsystem.  This will be required to make
more use of these helpers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 76 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 69 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d28606b93e..c3e1fdbf37 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2080,10 +2080,40 @@ static uint64_t do_ld_mmio_beN(CPUArchState *env, CPUTLBEntryFull *full,
                                uint64_t ret_be, vaddr addr, int size,
                                int mmu_idx, MMUAccessType type, uintptr_t ra)
 {
-    for (int i = 0; i < size; i++) {
-        uint8_t x = io_readx(env, full, mmu_idx, addr + i, ra, type, MO_UB);
-        ret_be = (ret_be << 8) | x;
-    }
+    uint64_t t;
+
+    tcg_debug_assert(size > 0 && size <= 8);
+    do {
+        /* Read aligned pieces up to 8 bytes. */
+        switch ((size | (int)addr) & 7) {
+        case 1:
+        case 3:
+        case 5:
+        case 7:
+            t = io_readx(env, full, mmu_idx, addr, ra, type, MO_UB);
+            ret_be = (ret_be << 8) | t;
+            size -= 1;
+            addr += 1;
+            break;
+        case 2:
+        case 6:
+            t = io_readx(env, full, mmu_idx, addr, ra, type, MO_BEUW);
+            ret_be = (ret_be << 16) | t;
+            size -= 2;
+            addr += 2;
+            break;
+        case 4:
+            t = io_readx(env, full, mmu_idx, addr, ra, type, MO_BEUL);
+            ret_be = (ret_be << 32) | t;
+            size -= 4;
+            addr += 4;
+            break;
+        case 0:
+            return io_readx(env, full, mmu_idx, addr, ra, type, MO_BEUQ);
+        default:
+            qemu_build_not_reached();
+        }
+    } while (size);
     return ret_be;
 }
 
@@ -2678,9 +2708,41 @@ static uint64_t do_st_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
                                uint64_t val_le, vaddr addr, int size,
                                int mmu_idx, uintptr_t ra)
 {
-    for (int i = 0; i < size; i++, val_le >>= 8) {
-        io_writex(env, full, mmu_idx, val_le, addr + i, ra, MO_UB);
-    }
+    tcg_debug_assert(size > 0 && size <= 8);
+
+    do {
+        /* Store aligned pieces up to 8 bytes. */
+        switch ((size | (int)addr) & 7) {
+        case 1:
+        case 3:
+        case 5:
+        case 7:
+            io_writex(env, full, mmu_idx, val_le, addr, ra, MO_UB);
+            val_le >>= 8;
+            size -= 1;
+            addr += 1;
+            break;
+        case 2:
+        case 6:
+            io_writex(env, full, mmu_idx, val_le, addr, ra, MO_LEUW);
+            val_le >>= 16;
+            size -= 2;
+            addr += 2;
+            break;
+        case 4:
+            io_writex(env, full, mmu_idx, val_le, addr, ra, MO_LEUL);
+            val_le >>= 32;
+            size -= 4;
+            addr += 4;
+            break;
+        case 0:
+            io_writex(env, full, mmu_idx, val_le, addr, ra, MO_LEUQ);
+            return 0;
+        default:
+            qemu_build_not_reached();
+        }
+    } while (size);
+
     return val_le;
 }
 
-- 
2.34.1


