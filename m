Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC77A82F939
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 22:03:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPqWV-0004jG-3P; Tue, 16 Jan 2024 15:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPqWS-0004iF-8P
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:59:00 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPqWQ-0007dr-Dx
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:58:59 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-28e75047132so831597a91.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 12:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705438736; x=1706043536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rE0zLXcd8vBrNYvxItjrAAOz15JUtntdMBrst4Q+tr4=;
 b=YdLhIoNmrcQA5+vKaPkARGzPGbFDI1x0aZ5PimMO9NNXzL7awFTJv8ebRGbwmwVWeh
 flx4TquMKg38WKRjOerEoNUZWdKGkslEckS2ytzA63Pb700r0rfZaS5wGI2PSYVNExzl
 dInBRf8tTZ24FRNjCFOJep5nPQZEGrohNGu0842h87eM3RprMNNmdB/qT3AYdWpKDiEn
 /nuyaRd+KQrduhZl6oO/Uhh3Gd+kV/tEqh+/3xnwM+OK6atwXbbg8vnVWwRz/bEOrVDY
 mL8hmPG07n+w2BrmKZRZq4V+ZU7GdKhjSx1/dbMrJ07YTWGeUACwIBQNjMKqN3W15kZ5
 uf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705438736; x=1706043536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rE0zLXcd8vBrNYvxItjrAAOz15JUtntdMBrst4Q+tr4=;
 b=nMAMHmXTptcQ6rsBslTqpQUuGDWQcPXEXDds0wcQ3W0dcnMBnhXbCjT0TGoZughQcQ
 vMy0VH6WJMpTy4vLLH5rugcIRH2S7/4bAr64yhbW1uOxhMlf9Ke0pOt9wFD2dLkQh8sj
 gjJ2R9kic0FR33jyLWdSnHyjlKVK5JJG7tdtPB/XWR4gPCcgAWm1RM+d2evxctuHIAAb
 ax6WcenNmWbo7h6gWqyjDO/r9Zx/Q3v+Ib4mg0umMng4DzJ/sbh+D+60NUqG5H5NWfh1
 agqAqdNnw5DCgkE6/bVFCACToLLqU3TT7vMYmr4v8IfqktXjFvxShALcZVxevTc35+Hf
 4jjg==
X-Gm-Message-State: AOJu0Ywz1ZZNCK/J5Q4hkejuaMVOs+VEUDwciKiRqi41I4/fSEnxcyg8
 +RCdwXdgldrK2neAwC9wAQXwwGJM675JW3sNcZ5SFELXsrdxQA==
X-Google-Smtp-Source: AGHT+IEDOOmDettkJ4ytmxI7A387j5YZFcU1ohpHNqgdUEs4l/rQZ3ZFo0/C2Cl0GfdveTBujMjlPA==
X-Received: by 2002:a17:90a:7d0e:b0:28a:f0bc:2a9f with SMTP id
 g14-20020a17090a7d0e00b0028af0bc2a9fmr3942356pjl.21.1705438736551; 
 Tue, 16 Jan 2024 12:58:56 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([152.234.123.64])
 by smtp.gmail.com with ESMTPSA id
 sh2-20020a17090b524200b0028df5c748e4sm11326949pjb.44.2024.01.16.12.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 12:58:56 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 10/13] target/riscv/cpu.h: use 'vlenb' in vext_get_vlmax()
Date: Tue, 16 Jan 2024 17:58:14 -0300
Message-ID: <20240116205817.344178-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116205817.344178-1-dbarboza@ventanamicro.com>
References: <20240116205817.344178-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1034.google.com
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

Rename the existing 'sew' variable to 'vsew' for extra clarity.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 11df226a00..3af61e0f94 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -690,9 +690,16 @@ static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
  */
 static inline uint32_t vext_get_vlmax(RISCVCPU *cpu, target_ulong vtype)
 {
-    uint8_t sew = FIELD_EX64(vtype, VTYPE, VSEW);
+    uint8_t vsew = FIELD_EX64(vtype, VTYPE, VSEW);
     int8_t lmul = sextract32(FIELD_EX64(vtype, VTYPE, VLMUL), 0, 3);
-    return cpu->cfg.vlen >> (sew + 3 - lmul);
+    uint32_t vlen = cpu->cfg.vlenb << 3;
+
+    /*
+     * We need to use 'vlen' instead of 'vlenb' to
+     * preserve the '+ 3' in the formula. Otherwise
+     * we risk a negative shift if vsew < lmul.
+     */
+    return vlen >> (vsew + 3 - lmul);
 }
 
 void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
-- 
2.43.0


