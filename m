Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9699E79A3E4
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:50:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfagW-0003at-0b; Mon, 11 Sep 2023 02:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfagL-00036o-M8
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:46:03 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfagJ-0005Ev-3L
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:46:01 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68fb2e9ebbfso775086b3a.2
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414757; x=1695019557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YOggPHEkVLsqxPB2c0/QeriqcmfD3a3w+0iFBDdTsWI=;
 b=V4rAojmvoHgzbI6M8xYWQnYfG/TT6vBBR5FM2NBqJu86DahJYE8f02DQ9Mnih5nOcb
 ju64B0xXH8SAkUSIEYAukxq9dBOZUWUNpqCb1a3KQVuZNo3JKgoINkqmLgP2mqYA19Ij
 lkANUwCUuENVrFdaaHzhD5IyUgycfczh7VxwVoXnssz3+tLSpiev73VZNec9KjXN/seV
 KGJKYSn4a0m0M7CNhcUGWfIB6MONtacHzwkvjQ34a+VMGYi96e9U+afltR3mGti04arW
 8xnG2cINlvl9efQf/awI0qORUqm7g05NWqjxTKMk4O6AQroSfsVdoTex4tYm3e883K0+
 pFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414757; x=1695019557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YOggPHEkVLsqxPB2c0/QeriqcmfD3a3w+0iFBDdTsWI=;
 b=Puii3GBSL5uWEIY8AJUiBKdCUBA3jlcuDADxBdErpZAYzFZN3iXskTLmrXsgGKyY6F
 hLnLY9qvSOI+d1SKrUhmpA/K0bUlwzbNmNmRC0bsaLzlm42qr03KK4/FEycsqCm6LTYW
 UCjmq3H1kx4YLQ6E6vXSmdLJLAg2FMP8SMDmiCLpRNQgguviY2pPhXspIhDnrEhKK/hO
 Il3MV1YQ1Xzf2BvgO97xTK2cq1PjRx3NUmI4m9ah3t5or7fNQAuCZoMIeBvPKVWnKxYx
 4qgNOtTNU0HciOPZwmCIvv/RAKVcT3YSGpFv99woAHGmUtL/sCxED98Re3+51KZ9+h/x
 Yh3Q==
X-Gm-Message-State: AOJu0YwmdabrjlZNYmMaBT4ygd/78Rcr1FbCM07fh8+ffB4rsJyQqyqy
 uYyJ9mk0oXSp+rgHcz74lUzmjvW6v+ZbxA==
X-Google-Smtp-Source: AGHT+IE0+2bhCosMVjGFRzxlMlsl+I9IY2KlF7Cuahweq3vner/LBti94nk95xv6BPOjdZCtyPr6ng==
X-Received: by 2002:a05:6a00:330a:b0:68f:caaa:e6d5 with SMTP id
 cq10-20020a056a00330a00b0068fcaaae6d5mr1114528pfb.14.1694414757270; 
 Sun, 10 Sep 2023 23:45:57 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:45:56 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 36/45] target/riscv: fix satp_mode_finalize() when
 satp_mode.supported = 0
Date: Mon, 11 Sep 2023 16:43:11 +1000
Message-ID: <20230911064320.939791-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
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


