Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B20CE74E122
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:31:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzLD-0003UH-Pm; Mon, 10 Jul 2023 18:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzLB-0003Ts-Oo
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:26:45 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzLA-0001jK-3b
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:26:45 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbef8ad9bbso56156615e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028002; x=1691620002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0DwXvgpuWa6bvmkF5jLlb53TLUXpVmhoMetGx+sUAQ8=;
 b=tnEHyMUU/0zJ1yEietluWgcXhnR+jpDQUWT/NeYoI9bgEfMs2lVB7tmOGXgkpaypPT
 8onUReObkcCliZ2TU7XoYftV25F6mAToBr4M9uVz6l1yXqAoLHjuU3724PMjlx1i0gxX
 FMRdQK/thSk7DmQ4VM3q9uY2pcpY7O/BdZq0AW7KLDuBRBFFYkjdjBbBu2ZwDw4iwMQl
 /3lMVTmDWfQ7YiXQfS8mQHNzNxIynXUE/pgZyA5Zj50nJvftvKEr16YpM7gf6N71ceMK
 EBaaoeJQcfh6BxsgjFFUbQ8YpJpBuITxyiAkNCDb7nBvWObbFVIMyv8bh5i/qtU84yF6
 UbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028002; x=1691620002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0DwXvgpuWa6bvmkF5jLlb53TLUXpVmhoMetGx+sUAQ8=;
 b=YereezTIrFwHf+RXXtlhKTQg5FLdDBO0TV/x1ECVPXW87Ece9ZAR7HtfSvZ605EbFC
 ZJfSOhDEtNNAU7COpjS/m6eV+DU1Ul4bnq2rQjpntA2ZYovxVSccFj3RRHcFT0in9Cc3
 rup+Gm8wA0AC+PG0lFZuRM3gOKkwww/2L9+ZSO5127XglWNqmoFfLXyZaOHwIkuKryuj
 b0TGOZDhPIDmjqZzbdNOx6iwY+eAu7sj2RhRldnfQKSo7T/m5JcCEQyuUoIMFAX/a5by
 T4werMczb48S97iPz8X+R7wH6wN5wTSeIbXHyC9Sbhk3qDw+6HcCK5u7Vi5TD7XFgQlP
 9oMA==
X-Gm-Message-State: ABy/qLZe3Z3vF1Z9WwNGYKD3FBL9cr6yDSZYAV1G3mfuqPISlJSx4ydY
 ku+kbrzo/D9Q8xU/gzUznWCylpfBmA5pN+PAKg9xpQ==
X-Google-Smtp-Source: APBJJlEGs318vxU4GMPNcE2hU9OMREJyD6PUine8YlGrrEU995CzXlbRKt65SMW7/VakFCdfaP3FNA==
X-Received: by 2002:a1c:4b0a:0:b0:3fb:d1db:545b with SMTP id
 y10-20020a1c4b0a000000b003fbd1db545bmr13812827wma.20.1689028002431; 
 Mon, 10 Jul 2023 15:26:42 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 x8-20020a05600c2a4800b003f9bd9e3226sm906042wme.7.2023.07.10.15.26.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:26:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 05/44] target/mips: Add support of two XBurst CPUs
Date: Tue, 11 Jul 2023 00:25:32 +0200
Message-Id: <20230710222611.50978-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Siarhei Volkau <lis8215@gmail.com>

XBurstR1 - is the MIPS32R1 CPU which aims to cover all Ingenic SoCs
older than JZ4770 and some newer.
XBurstR2 - is the MIPS32R2 CPU which aims to cover all Ingenic SoCs
starting from to JZ4770.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-3-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu-defs.c.inc | 46 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index 167c96cb27..05d9ec7125 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -117,6 +117,26 @@ const mips_def_t mips_defs[] =
         .insn_flags = CPU_MIPS32R1,
         .mmu_type = MMU_TYPE_R4000,
     },
+    {
+        .name = "XBurstR1",
+        .CP0_PRid = 0x1ed0024f,
+        .CP0_Config0 = MIPS_CONFIG0 | (MMU_TYPE_R4000 << CP0C0_MT),
+        .CP0_Config1 = MIPS_CONFIG1 | (15 << CP0C1_MMU) |
+                       (0 << CP0C1_IS) | (3 << CP0C1_IL) | (1 << CP0C1_IA) |
+                       (0 << CP0C1_DS) | (3 << CP0C1_DL) | (1 << CP0C1_DA) |
+                       (0 << CP0C1_CA),
+        .CP0_Config2 = MIPS_CONFIG2,
+        .CP0_Config3 = MIPS_CONFIG3,
+        .CP0_LLAddr_rw_bitmask = 0,
+        .CP0_LLAddr_shift = 4,
+        .SYNCI_Step = 32,
+        .CCRes = 2,
+        .CP0_Status_rw_bitmask = 0x1278FF17,
+        .SEGBITS = 32,
+        .PABITS = 32,
+        .insn_flags = CPU_MIPS32R1 | ASE_MXU,
+        .mmu_type = MMU_TYPE_R4000,
+    },
     {
         .name = "4KEmR1",
         .CP0_PRid = 0x00018500,
@@ -323,6 +343,32 @@ const mips_def_t mips_defs[] =
         .insn_flags = CPU_MIPS32R2 | ASE_MIPS16 | ASE_DSP | ASE_DSP_R2,
         .mmu_type = MMU_TYPE_R4000,
     },
+    {
+        .name = "XBurstR2",
+        .CP0_PRid = 0x2ed1024f,
+        .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) |
+                    (MMU_TYPE_R4000 << CP0C0_MT),
+        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) | (15 << CP0C1_MMU) |
+                       (0 << CP0C1_IS) | (3 << CP0C1_IL) | (1 << CP0C1_IA) |
+                       (0 << CP0C1_DS) | (3 << CP0C1_DL) | (1 << CP0C1_DA) |
+                       (1 << CP0C1_CA),
+        .CP0_Config2 = MIPS_CONFIG2,
+        .CP0_Config3 = MIPS_CONFIG3 | (1 << CP0C3_DSP2P) | (1 << CP0C3_DSPP) |
+                       (1 << CP0C3_VInt),
+        .CP0_LLAddr_rw_bitmask = 0,
+        .CP0_LLAddr_shift = 4,
+        .SYNCI_Step = 32,
+        .CCRes = 2,
+        .CP0_Status_rw_bitmask = 0x3778FF1F,
+        .CP1_fcr0 = (1 << FCR0_F64) | (1 << FCR0_L) | (1 << FCR0_W) |
+                    (1 << FCR0_D) | (1 << FCR0_S) | (0x93 << FCR0_PRID),
+        .CP1_fcr31 = 0,
+        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
+        .SEGBITS = 32,
+        .PABITS = 32,
+        .insn_flags = CPU_MIPS32R2 | ASE_MXU,
+        .mmu_type = MMU_TYPE_R4000,
+    },
     {
         .name = "M14K",
         .CP0_PRid = 0x00019b00,
-- 
2.38.1


