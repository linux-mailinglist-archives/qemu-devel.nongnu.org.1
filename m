Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 558437981FD
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:10:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUeG-0005uF-6P; Fri, 08 Sep 2023 02:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUeD-0005l8-Ph
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:17 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUeB-00079g-AL
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:17 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bc0d39b52cso13618915ad.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153233; x=1694758033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YOggPHEkVLsqxPB2c0/QeriqcmfD3a3w+0iFBDdTsWI=;
 b=qQNiAOySXxETlowiZEq7uthi1d0R7KoVjmiRB5/A+Onzmx4swX9qmIyBQRLlEfCYyi
 pr/C1XIyTbWJGFL/LQWtA92iaUWdFuwHlhKMLb5LgEdVk/NhqqPgoOrT6gZxL9MakLEZ
 Lt2pgFLCyYs6PZH/PjVwikOb1377/DYZFz13p9qcwR5zgufpnFZudrnUH4Pef18NSb6i
 aH3qnaKzERpkb82peSctv5A8PgMIn5QiLgGiLadfzcWYKz5y7gL8qnZdVYfpcdPuClio
 WBRyZIlNYub/RcJkTGTQrk/RT5ld7ERZg749aVR1Ivb6eMQtp380YtC26PRmx/EJzgTg
 xqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153233; x=1694758033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YOggPHEkVLsqxPB2c0/QeriqcmfD3a3w+0iFBDdTsWI=;
 b=iZ2BTFGnFHljFCrIxzm/cqszwvdMBSYLBfm4p1W4F6uNjuKFfjJPNENfwnJA95myxj
 66C7xEkJjZJnyQ2Pgkz/ILmoMzQysa0vwBdMeZlH5JGPgFnkCawNEH6yCkiBVsmuH4Pv
 SC6GziFLhFNwg1PO/ShloIgzMSwI8cgeiVpEW1BC/+dgUqKNJYEjGirFSO6BNxlAVTQ1
 8FcTAYhGi3xw9c/TG39S5xFi31ncUN+JmUD092Ll7LdFIsq5Tdjk6xIjNAGLe/PiTavu
 A0Npl6aR2Xd0eyJAQhU44BFen+OLWiETsE85jSq2FL7J3z/XXfpJzxBwO6nEj0rLlGdU
 g2TQ==
X-Gm-Message-State: AOJu0YzBpoi9TiLm82d8mgsSmuAVO3EEYOU3ao0I7FeCdRZvjr4wwJpj
 fKRQOEMUUa0zHdFduQ1TxmmVs5s0ykqPFfM+
X-Google-Smtp-Source: AGHT+IEFQPBB2uWMM9KfROu3u+0B50z6lbpR/Bre+27YmCBE/JcTAURSXkIQ+SCJ4Dr6ZdBkj7s5kg==
X-Received: by 2002:a17:902:d507:b0:1bf:22b7:86d with SMTP id
 b7-20020a170902d50700b001bf22b7086dmr1796584plg.3.1694153233488; 
 Thu, 07 Sep 2023 23:07:13 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:07:12 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 36/65] target/riscv: fix satp_mode_finalize() when
 satp_mode.supported = 0
Date: Fri,  8 Sep 2023 16:04:02 +1000
Message-ID: <20230908060431.1903919-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

In the same emulated RISC-V host, the 'host' KVM CPU takes 4 times
longer to boot than the 'rv64' KVM CPU.

The reason is an unintended behavior of riscv_cpu_satp_mode_finalize()
when satp_mode.supported = 0, i.e. when cpu_init() does not set
satp_mode_max_supported(). satp_mode_max_from_map(map) does:

31 - __builtin_clz(map)

This means that, if satp_mode.supported = 0, satp_mode_supported_max
wil be '31 - 32'. But this is C, so satp_mode_supported_max will gladly
set it to UINT_MAX (4294967295). After that, if the user didn't set a
satp_mode, set_satp_mode_default_map(cpu) will make

cfg.satp_mode.map = cfg.satp_mode.supported

So satp_mode.map = 0. And then satp_mode_map_max will be set to
satp_mode_max_from_map(cpu->cfg.satp_mode.map), i.e. also UINT_MAX. The
guard "satp_mode_map_max > satp_mode_supported_max" doesn't protect us
here since both are UINT_MAX.

And finally we have 2 loops:

        for (int i = satp_mode_map_max - 1; i >= 0; --i) {

Which are, in fact, 2 loops from UINT_MAX -1 to -1. This is where the
extra delay when booting the 'host' CPU is coming from.

Commit 43d1de32f8 already set a precedence for satp_mode.supported = 0
in a different manner. We're doing the same here. If supported == 0,
interpret as 'the CPU wants the OS to handle satp mode alone' and skip
satp_mode_finalize().

We'll also put a guard in satp_mode_max_from_map() to assert out if map
is 0 since the function is not ready to deal with it.

Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Fixes: 6f23aaeb9b ("riscv: Allow user to set the satp mode")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20230817152903.694926-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8071f05f15..34ac26e3ae 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -309,6 +309,17 @@ static uint8_t satp_mode_from_str(const char *satp_mode_str)
 
 uint8_t satp_mode_max_from_map(uint32_t map)
 {
+    /*
+     * 'map = 0' will make us return (31 - 32), which C will
+     * happily overflow to UINT_MAX. There's no good result to
+     * return if 'map = 0' (e.g. returning 0 will be ambiguous
+     * with the result for 'map = 1').
+     *
+     * Assert out if map = 0. Callers will have to deal with
+     * it outside of this function.
+     */
+    g_assert(map > 0);
+
     /* map here has at least one bit set, so no problem with clz */
     return 31 - __builtin_clz(map);
 }
@@ -1333,9 +1344,15 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
 static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
 {
     bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
-    uint8_t satp_mode_map_max;
-    uint8_t satp_mode_supported_max =
-                        satp_mode_max_from_map(cpu->cfg.satp_mode.supported);
+    uint8_t satp_mode_map_max, satp_mode_supported_max;
+
+    /* The CPU wants the OS to decide which satp mode to use */
+    if (cpu->cfg.satp_mode.supported == 0) {
+        return;
+    }
+
+    satp_mode_supported_max =
+                    satp_mode_max_from_map(cpu->cfg.satp_mode.supported);
 
     if (cpu->cfg.satp_mode.map == 0) {
         if (cpu->cfg.satp_mode.init == 0) {
-- 
2.41.0


