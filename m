Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8C477FABC
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 17:29:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWewA-0002iO-7K; Thu, 17 Aug 2023 11:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qWew0-0002bz-Mh
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 11:29:18 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qWevw-0006mq-Nt
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 11:29:16 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3a36b52b4a4so585958b6e.1
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 08:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692286149; x=1692890949;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gmUM5LsrJvRxFMnNYmXI0zSid4/PsHc30JEWozh2v9g=;
 b=F5ZCAKeh/uLGtXreO5tEqzzNpDo8FU+nLdFl3gfaPoInSPtL+8Y3j/kImdUa9pzAX1
 38z6tt7aESJbDL35O3Q7FTafys4zsBjbWhLV04E/YflI5ZR/ZC9qKtpE0Ls+XfFLlBRM
 sgG1pug4tNyCI4YcVd77Wm3/TeG0Lf7jSReU8eue5NSLZgTbinubLrIqyvc4xoRjm8Tj
 2hDhO73x501C/HjongpCz/6m0ylKDyzxb6ewknuWEPGS6wA5STDZCQzeE9oTJal2qOFW
 26sNNUbs3ySxTtEAt0EefXHkA+A4XZcnDhyciAXa37tcMVn16a9RBA14pWCacfTa57jL
 1bMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692286149; x=1692890949;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gmUM5LsrJvRxFMnNYmXI0zSid4/PsHc30JEWozh2v9g=;
 b=VsWzV0MO+VrplWlTsK4VdSumDh+RlBQ6nEy+4vSNazLv5NUT1No32GI5VXjRO+BzK2
 gmY4UNXnwDDwVy+tIvYqSqUrayQZM+31omHj+1P45z1l2ePZdhhrwq3pubyK/GS7hDcu
 suL4kTdb9KNcyETkfjzkIs+O/mq5ZfFAy4gxMAvgrSeDITkePXc8rXasjcEVYnBOVoZQ
 KbsRZDLJ6LMLyNeExVHKsdDJmOlV0mhOV1/owgtOZq/yCPNUMygL/A5LcVyaR2kr9eyY
 RNCbST4NUpzP8EX7xNs9SZcG5HEJ0ZG9BeO7I3ejGB8RYZpigUlSk0AkHW4Vt6kHB8Ai
 SIyA==
X-Gm-Message-State: AOJu0YxmBbDFg2gVAP2OC6aVSpR4WNJN3ObbpMP7KBPrAFRVQJK9rzND
 wVoGha2fvTMP9Df8CjHlmXPSPN8QHFKMsSrX7J0=
X-Google-Smtp-Source: AGHT+IGFDMYdPXRPi+rVI/KOIF1kdOAcI32UfvwRqNqGQTVfDZfZj8SdeqqrL+zG0k7gxsE8Lh3/vA==
X-Received: by 2002:a05:6808:1520:b0:3a7:272d:2f1c with SMTP id
 u32-20020a056808152000b003a7272d2f1cmr2264121oiw.25.1692286149513; 
 Thu, 17 Aug 2023 08:29:09 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (189-69-160-189.dial-up.telesp.net.br. [189.69.160.189])
 by smtp.gmail.com with ESMTPSA id
 a24-20020a05680804d800b003a5b027ccb2sm7606394oie.38.2023.08.17.08.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 08:29:08 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] target/riscv: fix satp_mode_finalize() when
 satp_mode.supported = 0
Date: Thu, 17 Aug 2023 12:29:03 -0300
Message-ID: <20230817152903.694926-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x235.google.com
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
---
 target/riscv/cpu.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d608026a28..86da93c7bc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -349,6 +349,17 @@ static uint8_t satp_mode_from_str(const char *satp_mode_str)
 
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
@@ -1387,9 +1398,15 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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


