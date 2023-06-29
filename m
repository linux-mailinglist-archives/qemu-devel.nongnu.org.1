Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDC574253E
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 14:04:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEqMi-0002NB-Bi; Thu, 29 Jun 2023 08:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEqMf-0002MM-GR
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:03:09 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEqMc-0005Gy-Sw
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:03:09 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fba545d743so6535085e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 05:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688040185; x=1690632185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z4l1J8enWAobibO9WsPypgJKzhJVu5hQ9JLx6ngTgp4=;
 b=koniqtd7SYoVw2kQ/UzeNmfGub4mnhpycYG0PglTSTIJL/724C15kLS0UUoZb8IDf9
 Ds2GPsYW4g6yzpMHvVBZVmsheYGUTp5cLOkz/Qlfk/RJnZjhRnjLHdDBnTvVpEaac184
 9wAFOPJh46B1q1LOFwcva91yZUMvdgAqydXhM5pfyPISnfJbBdZKo4EH27IegYddLsWp
 lsl5AJeXeo8e3/i6eQFZGi7NCJQBiEO+avfbGqiwQzdDllFsY654HPKbsrg/6XlZcva/
 7OlMoGslc0G3PPUuh7OZ3tbs7tP6bZ2wu2ccWPCfojk/NwHrBJ8+xZJISC1hIgWOBbBv
 YmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688040185; x=1690632185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z4l1J8enWAobibO9WsPypgJKzhJVu5hQ9JLx6ngTgp4=;
 b=C6O+Z6ZMo/1ss2cBnN95KYloQDyChfdw5SFMhtxV/wunt2WdYLzizeVQtPTyo04Ba6
 NJuLpvOVDlSgWlPdeh/ONR3Sonz0+2iak2zRZNEVzMFj6ts0UauextVgOhfSiGMpRSoE
 sYN4qkLRAiNN92M1E8XHfi37O5VGkcU+Bpuy+94nXpKW8MymEqhJVCz4ke+KpzMqMSQt
 yMBZnSKyC1HASi7uJEN9WYPoH9WOl3OTIcfH4VvfmnfTSBXmZEdiGMuZJFuc91kmEHfK
 dkFkNZQiM4TINkEiTTKiGfC80SdxGuyFmMKpdv4MdDmLf2IVO4AhKTX3HYEY7y4dmMUc
 InGg==
X-Gm-Message-State: AC+VfDzTP/XwSSyOMZVDxK476w4VwZrF9vfmbGHJPN175TZ0rzFFyNwg
 cQO5MxfM7p2PrMAF1U4Ksh7MaVtnI9IRMWyp1Yw=
X-Google-Smtp-Source: ACHHUZ7lyScE7kcYIO1HuAamPgcwqw8Ny6mb2HkXd6vxF3uQM1MptSMiYAHpCC4fBorbBQG/qesVCg==
X-Received: by 2002:a7b:c041:0:b0:3f9:b748:ff3f with SMTP id
 u1-20020a7bc041000000b003f9b748ff3fmr24245529wmc.1.1688040185160; 
 Thu, 29 Jun 2023 05:03:05 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a7bc446000000b003fba137857esm7709810wmi.14.2023.06.29.05.03.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Jun 2023 05:03:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-riscv@nongnu.org,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Palmer Dabbelt <palmer@dabbelt.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/2] target/riscv: Check for CF_PARALLEL instead of
 qemu_tcg_mttcg_enabled
Date: Thu, 29 Jun 2023 14:02:54 +0200
Message-Id: <20230629120255.85581-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230629120255.85581-1-philmd@linaro.org>
References: <20230629120255.85581-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

A CPU knows whether MTTCG is enabled or not because it is
reflected in its TCG flags via the CF_PARALLEL bit.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4035fe0e62..4dfa64af6a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -473,7 +473,7 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
 
 static void rv128_base_cpu_init(Object *obj)
 {
-    if (qemu_tcg_mttcg_enabled()) {
+    if (CPU(obj)->tcg_cflags & CF_PARALLEL) {
         /* Missing 128-bit aligned atomics */
         error_report("128-bit RISC-V currently does not work with Multi "
                      "Threaded TCG. Please use: -accel tcg,thread=single");
-- 
2.38.1


