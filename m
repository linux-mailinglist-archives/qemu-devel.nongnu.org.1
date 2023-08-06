Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B69F477137B
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 05:41:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSUa3-0003bg-5C; Sat, 05 Aug 2023 23:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUa1-0003Zg-CH
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:21 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUZz-0007Vu-4o
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:21 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-564ef63a010so150985a12.0
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 20:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691293038; x=1691897838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LfPki53EL/QBw74uxGxQNslYkA1KygGupPOLIF7ZjvY=;
 b=DSJXV8cKp+mzujFEPHcOXlZzqvDsNdUj7y66MHQTtFEyhzhenQti4o7JkHjvdrbRE8
 bXKhkuiTaxWIEwJVEiDg4+r7WfsKioo5cvIbeVs3wGXrokcpESLSKEg7A1wderNIIuZq
 fTMQ/IHpiAknB/pjnSjsOb51xF0FwhDajRlZayUyLvNC3jXHDoneTqGv7s/TM0LggXgD
 Cx1KN/4DYpH9eVt7gPrY8x2INGBxeg3CgghWFXK2u4VwYuOUFbTVFpC3ONaWkLdaAhsj
 HVCrera2RQcwy35eJmW7gynROn70NIPx6YDF43W+tFsUKNgOsbOq5T6PK4VrKaM+azLq
 2Q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691293038; x=1691897838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LfPki53EL/QBw74uxGxQNslYkA1KygGupPOLIF7ZjvY=;
 b=T+o18K75AMuiPrRl6u5AcRhvEJk7aXc3GhTpBzRHGsNYRZgz7+IAJT+dfbWjFD3eHc
 8wshXFUZfM4yeRVh/kypoI4Uy1S1Ox7mljiHiULXL6oo3VhCqaXM3ReBPCBKlEOMAFws
 51rEdX7jiny/4jXhLB/kQhQWyjA22/N4ulv/os63+jPCJf6ggmUkxpnpOahjC6I7JD3V
 FpSecL/h/KGoMmlPuNsT2YmL6Ly9nAIP5raOm8iTgWaCt3aBNo+1BLAqLfSVkTI7EfjD
 siRWI2nZruQQV9E+G3nYc/xi/pJKh+m/WKVXY3tP8Lu2kAcXBUOq55JQPnCjTKYEI9IZ
 Obqw==
X-Gm-Message-State: AOJu0YwkD+a6lA2V8Qi5uqynoG3nPRf4E+sz68A5v6g+taRK5dUahWDA
 UPR1/Zc5ybZrbTGs6P4wqMnFeE1/X6Hse+VMonw=
X-Google-Smtp-Source: AGHT+IGUGEh2ILa7r4X6Kl6o7qmfVNeGM8y8UXVA9FDpt6VmPcPRgAGTdWoEIQyHiurEJeeA0yn9vQ==
X-Received: by 2002:a17:90b:4b42:b0:268:2f6:61c4 with SMTP id
 mi2-20020a17090b4b4200b0026802f661c4mr4672210pjb.12.1691293037802; 
 Sat, 05 Aug 2023 20:37:17 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a17090a740500b00262e604724dsm6306451pjg.50.2023.08.05.20.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Aug 2023 20:37:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/24] accel/tcg: Issue wider aligned i/o in do_{ld,st}_mmio_*
Date: Sat,  5 Aug 2023 20:36:53 -0700
Message-Id: <20230806033715.244648-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806033715.244648-1-richard.henderson@linaro.org>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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


