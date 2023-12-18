Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AD7816F1F
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 13:59:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFD98-0003Xm-GE; Mon, 18 Dec 2023 07:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD96-0003Wp-Mu
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:54:56 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD95-00051p-3V
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:54:56 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d3c21a95e6so2546665ad.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 04:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702904093; x=1703508893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UnBstXEWPsZBvnTlfKasRccBMizhKErBnke26+HNPGk=;
 b=S60uZqYjcrh/YSHkTbGUGcnEmJjaByteVMOUd9S2VUSn3k+i3LgVtTndIcMHZtR/CC
 g5FAHGpgUcxoiCmUhkledg0LiOS5TYrCm7d53g8cS4ADP3axkd2ZX9UHgkLtmu5zlKQt
 EsVCyAIFDQI3lNT1g6NaNFQXa+nmuiSXaWNs9ACMgkPu9h7p5eggdSC8PQEH9kybkp0M
 VqyWINJpVKlVUuttyeHOPEBaBl9JHZxXwKX5cP1Ff640qRGkA2OuXXGKoA/t09gRAD+M
 QhZhPusbfcjzrJWMTesPBjx6Y8UqVHcRWWoRw8oimVW09dMECR+fn4At7KXU9gmDl8Kw
 F/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702904093; x=1703508893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UnBstXEWPsZBvnTlfKasRccBMizhKErBnke26+HNPGk=;
 b=IBIB7z0u9QM+QE1ZtedRNj08r8Y1twnX0JoAQz4+/bU4asmOoxVqetBAG9DSkVlf3e
 kv3aS81Bd17VGQaS8NBsNhPPHXYOr7X5QFl0DOmCF63RwP8jddN/lg2wGcg/PmS9ZeD8
 kcSBzGyv2OL8YFEw+P+CCaiiqyjaWcCjNuoWHPJnbnklOjIOpwjjkpIqzpaXhDsLrzyY
 sI6XXNdihrlTxJ6nQughxrwdR+qByK8YJKjSwKOL5WVo6b1G4dfX5S+DJggn1cIJFQRr
 VXRLNogrKh4vopRvzS1qfrKFqwhGfQ4GUA1XMIbc3oElz1kekpisL4CbYDToteh7kRNo
 NQnA==
X-Gm-Message-State: AOJu0YxVjDvFsdd3dE0Px1Cc0eniouVDctsSonSu0Sq6ThQC1KAjebd6
 aIwQ0z1IrFKsVlCvfutuTp4PsQaslGgBY2r2rwo=
X-Google-Smtp-Source: AGHT+IGAX6+zayiVuUDuC3aZrMibDP47eDQY2jV0Dq+hf7x31f/yReC5fL1mudtDW+XuFIQ/YfnwMQ==
X-Received: by 2002:a17:902:cece:b0:1d3:6c64:8352 with SMTP id
 d14-20020a170902cece00b001d36c648352mr3574976plg.29.1702904093504; 
 Mon, 18 Dec 2023 04:54:53 -0800 (PST)
Received: from grind.. ([179.93.21.205]) by smtp.gmail.com with ESMTPSA id
 c2-20020a170902848200b001d09c539c96sm7494897plo.229.2023.12.18.04.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 04:54:53 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v13 22/26] target/riscv/cpu.c: add riscv_cpu_is_32bit()
Date: Mon, 18 Dec 2023 09:53:30 -0300
Message-ID: <20231218125334.37184-23-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218125334.37184-1-dbarboza@ventanamicro.com>
References: <20231218125334.37184-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.c | 7 ++++++-
 target/riscv/cpu.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6af1148cf5..1dea5db52d 100644
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
2.43.0


