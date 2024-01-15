Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB8482E28D
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 23:26:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPVPF-0000j7-3A; Mon, 15 Jan 2024 17:26:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPVPD-0000h1-OZ
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:26:07 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPVPB-000676-NJ
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:26:07 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3bd7c15a745so927979b6e.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 14:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705357564; x=1705962364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MWHeHV4OEo1q9eMddE57J21tzGp1rowPk1kJmzHf7hA=;
 b=MY6hUzKy9+VxM7KrQuRWWCCJXH+8lMlNj3mE2lydrqikejPL0vtTKLEU5ufCpSIEvp
 nUMfsmlPzHiTuS7Y/Q/YEmJByg5NoECgt8R6qekuQAWNePOuJ9x3SyAsZhECnCe+TurY
 vBsxhcpwhs5nD3V6jx2GDnNefN9WwJihs0KLM4vRtVvZNaPGl4hrEmcX1ialSYCx4MYL
 6ZpqrztIpF+rNVsbo6WbO9S+tIT4+uPhI5YcNJXoNB/FPzo0f+xwoG6WXK2uZ07TjVGk
 iUQDstPc8IfvksLX+1Pn+5Nwt2Vw6rqleBqumtLYYzr/beSS96MbQP1E9J1hUL5ggXiL
 vYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705357564; x=1705962364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MWHeHV4OEo1q9eMddE57J21tzGp1rowPk1kJmzHf7hA=;
 b=dfEu9+gEtj3Dsr+EJ2VHLLxJX5XoAEXsNvxY2XvjbIwWEucNjRx9eCuaIw9a6pYP5Q
 N73lk/djfTL6toE3vi5315AYSYp53rbUyHqIW22MifpvwTDBFbxurx29gLZUKTJFY2FF
 xE7L+btrMxWaM67Hm7pfcNwBjFs/FwOJ3dq348rqQmbup8Op4eySsmaw5q07SAMRPphV
 bDrIeXPGv3MANVtSzAKp0UPQ1AAC+OPocbW08FTQCYB3UHYStHlzbbGnR+BevUYo8RGw
 tOdxONUth0m+52izHS93vXI/7Y56PEjPmS97v4TDKoflghbTVZJM+K5MxR4UDgtguaA6
 krAQ==
X-Gm-Message-State: AOJu0YwuFvXZVnat93xdwnf8MZ+WeFS6tTwLFa7tEDUQsBqOnPVB+Bo2
 fD/T8bLJIHBH7AiZUoyloruu1fKj/aqqmgHlrhlE0ATbghe9Cg==
X-Google-Smtp-Source: AGHT+IEGdJgc9ja1YZyF5ojj0Trd8JIRYj/XLhDl5SjeUXNIS6UWh2Vg/2yB2dLImkdaBg+dLr5l3w==
X-Received: by 2002:a05:6808:1a09:b0:3bd:5fb3:7f5c with SMTP id
 bk9-20020a0568081a0900b003bd5fb37f5cmr7882913oib.89.1705357563938; 
 Mon, 15 Jan 2024 14:26:03 -0800 (PST)
Received: from grind.. ([152.234.123.64]) by smtp.gmail.com with ESMTPSA id
 ks19-20020a056a004b9300b006d977f70cd5sm8125940pfb.23.2024.01.15.14.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 14:26:03 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 09/12] target/riscv/cpu.h: use 'vlenb' in vext_get_vlmax()
Date: Mon, 15 Jan 2024 19:25:25 -0300
Message-ID: <20240115222528.257342-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115222528.257342-1-dbarboza@ventanamicro.com>
References: <20240115222528.257342-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22e.google.com
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

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 11df226a00..7304e478c2 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -692,7 +692,11 @@ static inline uint32_t vext_get_vlmax(RISCVCPU *cpu, target_ulong vtype)
 {
     uint8_t sew = FIELD_EX64(vtype, VTYPE, VSEW);
     int8_t lmul = sextract32(FIELD_EX64(vtype, VTYPE, VLMUL), 0, 3);
-    return cpu->cfg.vlen >> (sew + 3 - lmul);
+    /*
+     * vlmax = vlen >> (sew + 3 - lmul). With vlenb,
+     * 3 less shifts: vlenb >> (sew + 3 - 3 - lmul)
+     */
+    return cpu->cfg.vlenb >> (sew - lmul);
 }
 
 void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
-- 
2.43.0


