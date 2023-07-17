Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F13756359
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 14:54:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLNhX-0002Z3-3e; Mon, 17 Jul 2023 08:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLNdu-0008Ti-9X
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:48:03 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLNdp-0008TT-6c
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:47:57 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-316f589549cso1815919f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689598070; x=1692190070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=edbJjO1yTMsccjp+1Oi4Tpx97oGTrv0Dg957zzrUT/c=;
 b=P0wB2kGqlRahKS5nj+YO0xzESU/X7CEd+dj4vYEVMdHuFBD1JUKoqYxzczfFOuxx1B
 SHOBTYGRUW0YfyLuBXEOVprOH5UjiAqiMn377pNhQ/pu65bXIrxlt39Z0GZ11Biyn8a8
 oYa43mag87FReeVPeseWbVmFGbjb9hH88DzvUPOdubwQAgyaiau6pD+rxUCBaxKIOkTT
 4R8pWMzkF5FPXeIJ5cBlRdKb/Ig/4s9YEZgIRTUyk+UXaKzQ0vvnwKqffBsZSvtrufsO
 qKoMIxnM/2/5Yqz14nzwru/syR1K5gZwgN6+A9TCtxysmNRryxhymLAWsng5qFFr3UgL
 uMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689598070; x=1692190070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=edbJjO1yTMsccjp+1Oi4Tpx97oGTrv0Dg957zzrUT/c=;
 b=hY4aqKlRsV+FV4oh1IJVYH3Aj+1qgIkTFz0nKQPGd685Dx4+lggv/u0MGBjFl1gliq
 U2LQ6NniYkKvj7m3vva0AbhUk0OGH4u5Y0I7rK7DvhH2rb8Z1DJuuyePbJEOWk0nCKt9
 8tIGqLbWdI4UsCu7EtSSgfgLXqUiW3ZaIGUQW8Eeh93MmXDT8UJkERut6L+kdPO9+neq
 V33jaFqyKfcyy/bI3q1mjhCDkhwxWrhxcX3e7c4ZVNKew86rcG6rIFY1U27R8Px5ZgIP
 qt1/cAccTJ5l7vlIfhtJIt7RQvqSs0Z3/Tx2eVnJmV8W9l2f3/f1+Zyd+b4B9FxukwDq
 oNvg==
X-Gm-Message-State: ABy/qLaR7g4s66VnxSyznDqZjkh2eBQgITCj+6jRL3se6GotvKVGHASb
 i5xsqgBMDvTFjSupjiNl37IefSfpS1r5Bm8Gci8=
X-Google-Smtp-Source: APBJJlHiOyi3ts1gBI8CYYSAHCCfkPvmswl3HQRZDea0dfkH/TVD7faKsiPX7DYaryKTnDQ6YaKraw==
X-Received: by 2002:a5d:4e46:0:b0:313:e8bf:a77 with SMTP id
 r6-20020a5d4e46000000b00313e8bf0a77mr9476225wrt.5.1689598070470; 
 Mon, 17 Jul 2023 05:47:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a5d6790000000b003112ab916cdsm19337737wru.73.2023.07.17.05.47.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 05:47:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/7] accel/tcg: Zero-pad PC in TCG CPU exec trace lines
Date: Mon, 17 Jul 2023 13:47:45 +0100
Message-Id: <20230717124746.759085-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717124746.759085-1-peter.maydell@linaro.org>
References: <20230717124746.759085-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

In commit f0a08b0913befbd we changed the type of the PC from
target_ulong to vaddr.  In doing so we inadvertently dropped the
zero-padding on the PC in trace lines (the second item inside the []
in these lines).  They used to look like this on AArch64, for
instance:

Trace 0: 0x7f2260000100 [00000000/0000000040000000/00000061/ff200000]

and now they look like this:
Trace 0: 0x7f4f50000100 [00000000/40000000/00000061/ff200000]

and if the PC happens to be somewhere low like 0x5000
then the field is shown as /5000/.

This is because TARGET_FMT_lx is a "%08x" or "%016x" specifier,
depending on TARGET_LONG_SIZE, whereas VADDR_PRIx is just PRIx64
with no width specifier.

Restore the zero-padding by adding an 016 width specifier to
this tracing and a couple of others that were similarly recently
changed to use VADDR_PRIx without a width specifier.

We can't unfortunately restore the "32-bit guests are padded to
8 hex digits and 64-bit guests to 16 hex digits" behaviour so
easily.

Fixes: f0a08b0913befbd ("accel/tcg/cpu-exec.c: Widen pc to vaddr")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-id: 20230711165434.4123674-1-peter.maydell@linaro.org
---
 accel/tcg/cpu-exec.c      | 4 ++--
 accel/tcg/translate-all.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index fdd6d3e0e44..e2c494e75ef 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -298,7 +298,7 @@ static void log_cpu_exec(vaddr pc, CPUState *cpu,
     if (qemu_log_in_addr_range(pc)) {
         qemu_log_mask(CPU_LOG_EXEC,
                       "Trace %d: %p [%08" PRIx64
-                      "/%" VADDR_PRIx "/%08x/%08x] %s\n",
+                      "/%016" VADDR_PRIx "/%08x/%08x] %s\n",
                       cpu->cpu_index, tb->tc.ptr, tb->cs_base, pc,
                       tb->flags, tb->cflags, lookup_symbol(pc));
 
@@ -487,7 +487,7 @@ cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
         if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
             vaddr pc = log_pc(cpu, last_tb);
             if (qemu_log_in_addr_range(pc)) {
-                qemu_log("Stopped execution of TB chain before %p [%"
+                qemu_log("Stopped execution of TB chain before %p [%016"
                          VADDR_PRIx "] %s\n",
                          last_tb->tc.ptr, pc, lookup_symbol(pc));
             }
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 4c17474fa22..a1782db5dd7 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -637,7 +637,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
         vaddr pc = log_pc(cpu, tb);
         if (qemu_log_in_addr_range(pc)) {
-            qemu_log("cpu_io_recompile: rewound execution of TB to %"
+            qemu_log("cpu_io_recompile: rewound execution of TB to %016"
                      VADDR_PRIx "\n", pc);
         }
     }
-- 
2.34.1


