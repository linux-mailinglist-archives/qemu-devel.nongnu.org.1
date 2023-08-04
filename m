Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A38F4770BAF
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 00:03:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2qt-0004lS-Bl; Fri, 04 Aug 2023 18:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qg-0004Ve-48
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:44 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qe-0001f0-8H
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:41 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bba04b9df3so22273045ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 15:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691186436; x=1691791236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LfPki53EL/QBw74uxGxQNslYkA1KygGupPOLIF7ZjvY=;
 b=IefWexcHWiMP7rFoMp5f4G1FMTypOx+gjgNERFVWNiNgrYQ2gr3WXHYPPxb0OVF+Ts
 frFqn0wCk2oWIc2UyS0jALiTOnZGi+aseoBogf5aDgoeQog8Z3idX2ye5ilp2cK2S1y9
 A9q9N5ttvJAWRHh2FySK2lKTv6JDryX9H6DNam+a5inNuo3Hw5mkEBagZGJTZTQh5WeI
 y1Md2xKK10fLVlXHRsWWJ1YZX0qHP6whZaYBlhTREfq+yDMwnIACaYkz0LRVx5dg+mDQ
 JzLBoDbSDYdRrLSCPH8KCeXhoSz51VIB0c2uQumkylgoe/K1uOG3FKdTJZgvlYw/7gnV
 Lbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691186436; x=1691791236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LfPki53EL/QBw74uxGxQNslYkA1KygGupPOLIF7ZjvY=;
 b=KMyU8h+1j4Vj7VAuxzCm2d0vnHbhoodkiLW+iHRA5aPWxH19wiVrwLLQ/70oEGwUPX
 6ZLDGGRzdNp0rb/t7JwzhWMEFuNMzFbhPzrBmoBDThLYvDNs4fhRQV+xdse2MsPnsJAK
 qkmdJHtcO6xcSGousK7B2CbI7h1k4IlSgekO5Bu8UNB+Gkg5eS/1AaYeBHdA3c9FQtgV
 PDeWzeqC3cSSjMFtSWNJ8nkzQa990UXitjs9olTXn9B7tA1LulkPwfD61vbjLseiuJOq
 g5fwsUZy2c4W8LpkO6XUlMyBcsm003wQwO7/9OmiH4+0aGInHDFrigLG6bEM+zFKnKay
 aH+w==
X-Gm-Message-State: AOJu0YyOQZ3dTyttP4AbiR4HzXAZfKkRJX/GNhOhNemtOXKQNAUOpSUi
 EbKDvmLFZRO39wGNc8JWPLR7vBhB8mygamSgjFw=
X-Google-Smtp-Source: AGHT+IH8HxhXZsRQDqEB2/hwbU/evBnMN0UadASQ44VRcQ2BNfwDd2yYKmmX/Q6zaKjhAosZScQAHQ==
X-Received: by 2002:a17:902:eb42:b0:1b8:7e53:704 with SMTP id
 i2-20020a170902eb4200b001b87e530704mr3233161pli.27.1691186435704; 
 Fri, 04 Aug 2023 15:00:35 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090282c100b001bbf7fd354csm2185568plz.213.2023.08.04.15.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 15:00:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v9 02/24] accel/tcg: Issue wider aligned i/o in do_{ld,
 st}_mmio_*
Date: Fri,  4 Aug 2023 15:00:10 -0700
Message-Id: <20230804220032.295411-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804220032.295411-1-richard.henderson@linaro.org>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

If the address and size are aligned, send larger chunks
to the memory subsystem.  This will be required to make
more use of these helpers.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 76 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 69 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 23386ecfde..a308cb7534 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2081,10 +2081,40 @@ static uint64_t do_ld_mmio_beN(CPUArchState *env, CPUTLBEntryFull *full,
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
 
@@ -2680,9 +2710,41 @@ static uint64_t do_st_mmio_leN(CPUArchState *env, CPUTLBEntryFull *full,
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


