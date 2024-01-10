Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7620F8295DD
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:09:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUSM-0001kl-FN; Wed, 10 Jan 2024 04:01:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSJ-0001fQ-P2
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:59 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSH-0005CP-Qw
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:59 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6d99980b2e0so3348631b3a.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877256; x=1705482056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YVA1sFK0PhjE2ujUp8aKIMU8p8U/MGPBI/jd2QjUi9Q=;
 b=Wut/4OxuZim8mvlv9YLk23W1eyfEnQAaIdF1xR1YaXI0dxxozLz62Z6keExrhyvWIv
 X8K++rR984DWZ8Ay+8nqLsKdYWXnGJSIW27VIgalTuqhKNLn4oHR9fwi1WPOUFXcxfdv
 CT1ZyBSurDA2CY9PsWEjISOafRzyr6qJCvb38AVQnyLASqm34I7nGa+AGG6LYQh5CaWW
 JKa0xDvTf0Y9Uuz8nzEJ+4tHEuxvd2KNO0ivcwtp1DWulfPaOsX17XbSqKcWO5bTtzG+
 N9Zly+T41uql4WJNqtTO8CbejPe4kgn4f9kMUopSS0eUwKbcsIQvjWrq3ZzpUeYNu4ig
 ltsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877256; x=1705482056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YVA1sFK0PhjE2ujUp8aKIMU8p8U/MGPBI/jd2QjUi9Q=;
 b=G6h3LzQwjgBCx0ssFfHQR3Cpwh6IdqGtw5gshBz4phywYip0a5Yk/TyMitUDns9tHX
 vtU0T+kuwc08dP9JCtnNQxe6dfHvb11/kwNluE9hBYFyHjLkVetrMuWDZZdGyaBs8HN7
 mN1XEyoxCGOCvzknJYpFJ0s4Ga+W3Co7W8vhHbHDWU16gdKK5UM2r+yHRHhFOlzlbvYT
 gPoUcdbxiG3V1G/MIC98xuQJr0RoyP8FUOEDzV/DXukzljnxhvlwWt9+e6k+wAiuahUX
 Z2dQ2TmDAjpPEcw4ywpwDqCvFkUKTnTggGW5im+1KW0+pdoACLua2Fuu/9TahmvbBzgW
 adGg==
X-Gm-Message-State: AOJu0YxF0M45VDfBxtMs3dBQuwar+I/HkDIjOc2I+jwIW9JkCWWtSPzu
 SowxKVXLpLK6sQ5CAogStMDu+T6uQ+PemUeP
X-Google-Smtp-Source: AGHT+IFShsqj/r1UJ5nA2h3eQTC6AAAjy28T/y+S4IunADGMc1gFdnwp/cpwvyk141q8Xow5yYubrQ==
X-Received: by 2002:a05:6a00:bf5:b0:6d9:a96f:9865 with SMTP id
 x53-20020a056a000bf500b006d9a96f9865mr744680pfu.47.1704877255957; 
 Wed, 10 Jan 2024 01:00:55 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:00:55 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 50/65] target/riscv/cpu.c: add riscv_cpu_is_32bit()
Date: Wed, 10 Jan 2024 18:57:18 +1000
Message-ID: <20240110085733.1607526-51-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Next patch will need to retrieve if a given RISCVCPU is 32 or 64 bit.
The existing helper riscv_is_32bit() (hw/riscv/boot.c) will always check
the first CPU of a given hart array, not any given CPU.

Create a helper to retrieve the info for any given CPU, not the first
CPU of the hart array. The helper is using the same 32 bit check that
riscv_cpu_satp_mode_finalize() was doing.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231218125334.37184-23-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 1 +
 target/riscv/cpu.c | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3d1c347b71..a0f768e77d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -693,6 +693,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags);
 
 void riscv_cpu_update_mask(CPURISCVState *env);
+bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
                            target_ulong *ret_value,
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 65f69a7dd3..4d1fd7fd48 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -53,6 +53,11 @@ const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
 #define BYTE(x)   (x)
 #endif
 
+bool riscv_cpu_is_32bit(RISCVCPU *cpu)
+{
+    return riscv_cpu_mxl(&cpu->env) == MXL_RV32;
+}
+
 #define ISA_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
     {#_name, _min_ver, CPU_CFG_OFFSET(_prop)}
 
@@ -978,7 +983,7 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 #ifndef CONFIG_USER_ONLY
 static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
 {
-    bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
+    bool rv32 = riscv_cpu_is_32bit(cpu);
     uint8_t satp_mode_map_max, satp_mode_supported_max;
 
     /* The CPU wants the OS to decide which satp mode to use */
-- 
2.43.0


