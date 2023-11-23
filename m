Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC167F6702
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 20:17:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6FB7-0008VI-88; Thu, 23 Nov 2023 14:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6FB4-0008Ua-Va
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 14:15:55 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6FB2-0003nX-UW
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 14:15:54 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cf7a8ab047so9003325ad.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 11:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700766951; x=1701371751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWy/56QLcu94omNIXXSZg231kAR+qHSOzpLGfnBUle8=;
 b=MoC+sTFf67khY9ChSnhL3JIVSdnpZSZcnxPTP2FzfZsc7vLZSNLcyClO5bdCOlbCs4
 tds3bl+wDs4AsIfwZ+fMcxvE2om3d0RNM6RGGlJVOkBD0iW7+CjZST38oYpSZiWzmy9I
 vobFV/ceKY3Pu4rWhXp4g2ozhjUU4EMrmO8oQ3ntS0kRlk7cFlG5TAdFyRmhAKQzQ/jf
 vnsn+mEcAKdDmeq7/3hICrPA6wruuBYfNhkcCYNlaFRImhoWiA3c3LOYkWFKgw76hcgo
 GzoJbhgp3Z63gA+6IOtpNcf1Xpcdcqk6t8tH52Dcwp62ixMVVjJHeFjzXl815HGPcrNb
 FDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700766951; x=1701371751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oWy/56QLcu94omNIXXSZg231kAR+qHSOzpLGfnBUle8=;
 b=n2KQh60ZRk3c8C+VTbLJSBXaTUdFjm3pwwrAG8/AY4CFR2TJH77atDieaB3/WDJMxx
 wRBjHlSbNDywmKVBmiRkrKBYKjVxGyqi+4w5lSFBsEeJsuAAU23VnBN5tbko3XPc4YYI
 nsRqW7xWdvpbRxiCKTN1u/n8Ss2dpOaYQiy6yQ2KLU0auDdjDhkppRHdBeQ/A9ge+KOZ
 8FDNTVug5/IftbsEp/6RYwj/ZxNkjLA+jxzWMlK8tv5iNOW9nfhPZo5saPBIFm1vnrER
 BkRZ5kUhoVwDSK0Dq/nJNmgW2Tq96gIZIiZjjufD4ZfhaRF2Y9lgJNiYtg1SfqzxjQnT
 7JHQ==
X-Gm-Message-State: AOJu0YxlsnFr9bC1nlN0fMqXHpGItF6WLYhF+7jTiELD2Md1YfRKIH9J
 w1i9NRF+iNO2AuEhTQECvZutz+/qWSiY/b2WSFQ=
X-Google-Smtp-Source: AGHT+IEiLCBVq8YGPC3ZqKTSPYvNhFobngrWIPSgAaMMtc5cr/tKwmCTdmDcENSquS+AHZRBcrUC7w==
X-Received: by 2002:a17:902:e88a:b0:1ce:654a:81ef with SMTP id
 w10-20020a170902e88a00b001ce654a81efmr448397plg.18.1700766951000; 
 Thu, 23 Nov 2023 11:15:51 -0800 (PST)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902eed500b001bc21222e34sm1680760plb.285.2023.11.23.11.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 11:15:50 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 4/7] target/riscv/cpu: add riscv_cpu_is_32bit()
Date: Thu, 23 Nov 2023 16:15:29 -0300
Message-ID: <20231123191532.1101644-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123191532.1101644-1-dbarboza@ventanamicro.com>
References: <20231123191532.1101644-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Next patch will need to retrieve if a given RISCVCPU is 32 or 64 bit.
The existing helper riscv_is_32bit() (hw/riscv/boot.c) will always check
the first CPU of a given hart array, not any given CPU.

Create a helper to retrieve the info for any given CPU, not the first
CPU of the hart array. The helper is using the same 32 bit check that
riscv_cpu_satp_mode_finalize() was doing.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 7 ++++++-
 target/riscv/cpu.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a395c77bda..2b79fe861b 100644
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
 
@@ -980,7 +985,7 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 #ifndef CONFIG_USER_ONLY
 static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
 {
-    bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
+    bool rv32 = riscv_cpu_is_32bit(cpu);
     uint8_t satp_mode_map_max, satp_mode_supported_max;
 
     /* The CPU wants the OS to decide which satp mode to use */
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 1f34eda1e4..485d2da3c2 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -695,6 +695,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags);
 
 void riscv_cpu_update_mask(CPURISCVState *env);
+bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
                            target_ulong *ret_value,
-- 
2.41.0


