Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA8C82D43A
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 07:33:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPGVq-0000Kw-CA; Mon, 15 Jan 2024 01:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rPGVo-0000KS-Md
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:31:56 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rPGVn-0005hF-81
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:31:56 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6daf9d5f111so6789566b3a.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 22:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1705300314; x=1705905114;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GbHsFPTqeVEF6MXxcuYOrP3CMgZR2bO4xbc3tDD6CnQ=;
 b=pfIjDg0cTZZQiISuZy8XrIjwocED1K4j46YJ8VZlK4jPPoqrJe72YWJ1k7qnsjnRdZ
 lsP5ijSD/f2CTlddZH0fUbTS7ETAi3qc1Hwpqs7zgfw/Zeb/UK5Aylf4qzxO96LwHOoG
 PP7kQvjrIEymeMAvR4l05hplEbJk32wgiie+oaGzkQ7ELj7EDiaxo8FYlJT9g1hnXT2l
 1sAihQo0q8EBK3tCIBJF1QC3AzsXAgmT7A85Zub6a1gdr5t5Lz+t2mXNKLMhBIiRS41h
 JO0D5qiApykYn5EcSVYgCwxdSUQbzAJbBFgTSzDglgnBDH/RPrthmkKTC0cWKyg8g36T
 0wgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705300314; x=1705905114;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GbHsFPTqeVEF6MXxcuYOrP3CMgZR2bO4xbc3tDD6CnQ=;
 b=udj59aKMNpc/SpAd4DJ22i/G/ypBsEt9Z/QoWnM2PWRsX80UsfCBFMyOfZ5kZ92TGi
 F+/ivukH5dkOdSOFyx1t1JCOOynBCVvgEfCTT1ZkUlZ6VcOK1JjmP56Bzax0IXSfff5h
 Yaox2/4b3EaoVi7Cm1c6iFxDTt+FBN/AXB38g3fgUMFSsmzr1ll6o1eDl+Kg7o0rhwuN
 i48K3P0r2jafp7igG99fJeRaehO1tqMHyx/aLQtrj4gHyfTxjWF6AZ5PWiciFogWeOf7
 jfEtlkYSETXQkBnutyDYYKyXZjhj+a62yUpHzIq6wK0vyRWAUxQsCJ6ThnETsk0kRZNk
 1ixQ==
X-Gm-Message-State: AOJu0YxTitGlyHi3YGVdYFuIO9ZddoHuGQZJk9Gm/2sYHk4SGmCBHKgB
 G1nlgUxkc6g+iB6ufTmvRhkpdn5lnAamBQ==
X-Google-Smtp-Source: AGHT+IFlwl8uWvXwgb3Julj32KhlFJRRsaSu/FVp4F3xMJc3APxz8EV4QaSrqfIfsLKqImXbFBF6YA==
X-Received: by 2002:a05:6a00:8d93:b0:6da:f1ba:a196 with SMTP id
 im19-20020a056a008d9300b006daf1baa196mr6940903pfb.37.1705300314000; 
 Sun, 14 Jan 2024 22:31:54 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 lc18-20020a056a004f5200b006d9cf4b56edsm7131375pfb.175.2024.01.14.22.31.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jan 2024 22:31:53 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 15 Jan 2024 15:31:27 +0900
Subject: [PATCH v9 2/4] target/riscv: Remove misa_mxl validation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240115-riscv-v9-2-ff171e1aedc8@daynix.com>
References: <20240115-riscv-v9-0-ff171e1aedc8@daynix.com>
In-Reply-To: <20240115-riscv-v9-0-ff171e1aedc8@daynix.com>
To: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Mikhail Tyutin <m.tyutin@yadro.com>, 
 Aleksandr Anenkov <a.anenkov@yadro.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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

It is initialized with a simple assignment and there is little room for
error. In fact, the validation is even more complex.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 14133ff66568..b85b0d036a61 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -268,7 +268,7 @@ static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
     }
 }
 
-static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
+static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
     CPUClass *cc = CPU_CLASS(mcc);
@@ -288,11 +288,6 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
     default:
         g_assert_not_reached();
     }
-
-    if (env->misa_mxl_max != env->misa_mxl) {
-        error_setg(errp, "misa_mxl_max must be equal to misa_mxl");
-        return;
-    }
 }
 
 static void riscv_cpu_validate_priv_spec(RISCVCPU *cpu, Error **errp)
@@ -932,7 +927,6 @@ static bool riscv_cpu_is_vendor(Object *cpu_obj)
 static bool tcg_cpu_realize(CPUState *cs, Error **errp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
-    Error *local_err = NULL;
 
     if (!riscv_cpu_tcg_compatible(cpu)) {
         g_autofree char *name = riscv_cpu_get_name(cpu);
@@ -941,14 +935,11 @@ static bool tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
-    riscv_cpu_validate_misa_mxl(cpu, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return false;
-    }
+    riscv_cpu_validate_misa_mxl(cpu);
 
 #ifndef CONFIG_USER_ONLY
     CPURISCVState *env = &cpu->env;
+    Error *local_err = NULL;
 
     CPU(cs)->tcg_cflags |= CF_PCREL;
 

-- 
2.43.0


