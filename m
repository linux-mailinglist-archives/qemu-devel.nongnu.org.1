Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EBD82F912
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 21:59:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPqW5-0004az-P4; Tue, 16 Jan 2024 15:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPqW2-0004Zy-FL
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:58:34 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPqW0-0007a3-SN
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:58:34 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-28cf491b197so5277377a91.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 12:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705438710; x=1706043510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pOm75KyBeXm3m2Az5YBsVUeeeLNUU1hsY1So+vHclQ0=;
 b=A0XFQbT1XqKoS+rzTdNXrhMLlT7KoAuNGBYfJ9GMIwlKdwsY8RpcCLv8yhACc4EL6n
 XI7/gv8WU+blZroBCvLhsLv793xbZz5K82j1+1Hkd6+JW1c4aDxax3CiP6VWVUICrpu3
 3D3e79G/gvsA5Ef6CmsKJwCbUHiRMYAcjmc3hVg63oYtY4qYLtbDwwSqJE3rQKRTYGzF
 Vq1TLoYcwMaseXMM3KSPjm+o8RXpBM5rfJfXNFZecRUtX5Hqc4GzJ0OKRAW9OBNcQooP
 dKxoO+tncEQEzx3ooQU5svyuwS0YhvjOUpJyCNBPs9NM2izjhlYOQfrbpMx5o5aYiEZ4
 DCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705438710; x=1706043510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pOm75KyBeXm3m2Az5YBsVUeeeLNUU1hsY1So+vHclQ0=;
 b=NUFwr5ErIZDcwTb1GZDKXPNYKh3gmkZy6mtp0Tw5r5qr7GyFKrhe0ctbb8ci6bczbu
 CMDipa5XHLLS1tMifaLFe2D9KVqwDAC9ScbhF5cTPYR5D2X/wTOKwz4rP4vnAiEz4aE+
 wmCz6Nj9Wfx2QgjWCY9wNyLH1sgm8aVqh+RMUbu06xTbsGl1DLx8l4y94B10FVAqu/Kh
 YUe1P2OAdF7OcvGZ/F7RL69qljDcB4x9d6knZKQvxFs0qaSIOWOGznW8U8hXi8+IVJxW
 xVz/kotPnal2Bd42CNWZtsV6WJ+mf7j4ro3E6BEy7n653ojKz6xldpAHHYD0vSxLM9XW
 cBhA==
X-Gm-Message-State: AOJu0Yxwkyt6W6yEWdW0JL10a16GW53ctzgB4po7kOratz/vyZg9ceEy
 IhvCj9VazmBpbfNmM8wh0UkdWyS1vPNTib5ygyhZcRBWLUOr6w==
X-Google-Smtp-Source: AGHT+IF4Y4EidNyPq71szV1CUJw1IcK1ISv0JbZsyWAT3fcHpNSdnBkSn01EFZfoSFehLW+wT01Qyw==
X-Received: by 2002:a17:90a:d101:b0:28c:8eb9:3029 with SMTP id
 l1-20020a17090ad10100b0028c8eb93029mr4086106pju.50.1705438710422; 
 Tue, 16 Jan 2024 12:58:30 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([152.234.123.64])
 by smtp.gmail.com with ESMTPSA id
 sh2-20020a17090b524200b0028df5c748e4sm11326949pjb.44.2024.01.16.12.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 12:58:30 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 02/13] target/riscv/csr.c: use 'vlenb' instead of 'vlen'
Date: Tue, 16 Jan 2024 17:58:06 -0300
Message-ID: <20240116205817.344178-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116205817.344178-1-dbarboza@ventanamicro.com>
References: <20240116205817.344178-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102f.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


