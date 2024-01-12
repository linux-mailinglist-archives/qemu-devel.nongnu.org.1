Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EE782C6CB
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 22:39:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOPEW-0003pA-JW; Fri, 12 Jan 2024 16:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rOPES-0003of-A9
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 16:38:28 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rOPEQ-0001Zp-Pt
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 16:38:28 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d3e8a51e6bso56040555ad.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 13:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705095505; x=1705700305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UUTQ4hAGbR/U7aTocUntatBO3/zQ0lq0rhjwH747sgA=;
 b=ohEhrgH0Bw/CJUw32M7COVDAV+uqLx6W6iqhOdAVUn2DGqtl9a7u8peAtrs+z2ZgXQ
 KzlJU/jvVu0C/22U21wXrNyS94M8LnG/edLb7JCuJpPXRtBMazg2YuRTJ+eRbiJHJFzu
 HOJnhOzBLwfChbYZiiia9SqEeC7iztDC7pWWooV4ytsBlhwC7ocwc/5iGEtexM7kTxTh
 j1O0281WwYbQgf+hkHL8OFvXwAGBGlpCzZSdM+BMYGUK/MLzwY8mlEG/fdp6yGshh3DP
 gkJfnnKPG+4+AY+G7Q8EuiUtMNvJZtLABYpTxySSUmqcDKIm+hpKfyMsJemI2qyxO2s7
 adnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705095505; x=1705700305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UUTQ4hAGbR/U7aTocUntatBO3/zQ0lq0rhjwH747sgA=;
 b=dYsIvzVP3T57FpmpBNLykBGwUUC7eJmyGPQ7Y0GZan2A/866EnYEcqFwYzwaWnWcq/
 4H356KVFZxrh1E3u7xxknoZKM7XF82RLj26lt0Mivb7mWyiQtkaTN5dqQ7l2CYcRYiHN
 hWLpBRMoXAO2cAD9IVErhCnUVNMfxdvJiBHiTki0b58zJnCm9+8mSlnRRSlz1sWQL0UH
 lh9VlPzx0LIZ6+cdcnM/HCm07AKkKIrVk5J0ln2VgK4N3QEbSjZdKLGGRgiGRDgaksOF
 3Dfnz632EgjIAHULt7ZfmkERZvoNwmHZQLC/YSZzSrWNcoZy5DuXKEQQgwlvwpQ99yal
 VTZA==
X-Gm-Message-State: AOJu0Yy0AhkURoHiTBoQPqg9Stwpi2bv1IYBkgY8V2mkWv7ZmNGNKlop
 oGIPto0rKAEO3cjuO4cVPX3CVkPKJTd4n/sFjeyaeuOt7EO7sw==
X-Google-Smtp-Source: AGHT+IGVMvaPWsjzUP5rbqhIMiLR5Jn2zPjmcDw5h4AnON92FO9+vZNankMld87ZH5hiJiSGIfnkyQ==
X-Received: by 2002:a17:902:c701:b0:1d4:6dea:9adc with SMTP id
 p1-20020a170902c70100b001d46dea9adcmr1452634plp.9.1705095504828; 
 Fri, 12 Jan 2024 13:38:24 -0800 (PST)
Received: from grind.. ([152.234.123.64]) by smtp.gmail.com with ESMTPSA id
 lf8-20020a170902fb4800b001d5b2967d00sm364727plb.290.2024.01.12.13.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 13:38:24 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 02/13] target/riscv/csr.c: use 'vlenb' instead of 'vlen'
Date: Fri, 12 Jan 2024 18:38:01 -0300
Message-ID: <20240112213812.173521-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112213812.173521-1-dbarboza@ventanamicro.com>
References: <20240112213812.173521-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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

As a bonus, we're being more idiomatic using cpu->cfg.vlenb when
reading CSR_VLENB.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/csr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 674ea075a4..5c8d22452b 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -683,7 +683,7 @@ static RISCVException read_vl(CPURISCVState *env, int csrno,
 
 static int read_vlenb(CPURISCVState *env, int csrno, target_ulong *val)
 {
-    *val = riscv_cpu_cfg(env)->vlen >> 3;
+    *val = riscv_cpu_cfg(env)->vlenb;
     return RISCV_EXCP_NONE;
 }
 
@@ -738,7 +738,7 @@ static RISCVException write_vstart(CPURISCVState *env, int csrno,
      * The vstart CSR is defined to have only enough writable bits
      * to hold the largest element index, i.e. lg2(VLEN) bits.
      */
-    env->vstart = val & ~(~0ULL << ctzl(riscv_cpu_cfg(env)->vlen));
+    env->vstart = val & ~(~0ULL << ctzl(riscv_cpu_cfg(env)->vlenb << 3));
     return RISCV_EXCP_NONE;
 }
 
-- 
2.43.0


