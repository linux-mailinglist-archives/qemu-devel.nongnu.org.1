Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 546318369EE
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 17:14:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRwts-0006al-AP; Mon, 22 Jan 2024 11:11:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rRwtr-0006aa-37
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:11:51 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rRwtp-0005MV-JJ
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:11:50 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2906dffd8ddso1578388a91.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 08:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705939907; x=1706544707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KcOoJBxtOmItyxwzRVxYTpNYgBui/7NGS4TVsI5tRuk=;
 b=j1P6HW0XAxPRrGGsAMHsRdbYrzzPg0CMZBtdpM4cwielvn8qCY8RhnvKBP/sTl80jb
 X0A4LPYXPKGvX27rsns7myN7cCXdwDYQRvJr2WfO6i2a+gSzh141UCnYlPSmZ6I7kj3D
 uXJK2LuuM432CWbbQixruNz9vn84LVfpJXqR4wXA5xixue0E2ejulrjE0xAY9+3g3oPD
 r0uavvgKvJtD/gD1SxWRTqJDVdiEOx3A68BtPL1HO0cyohVxwKBDQ9BXDmK8HtjOU07g
 npiIivMuJ9SWvnJBIYhVASREEQUw8IlbIvw3zAOAFUWaEAQaZtRmDhCfC4QtSNgn1eNE
 UH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705939907; x=1706544707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KcOoJBxtOmItyxwzRVxYTpNYgBui/7NGS4TVsI5tRuk=;
 b=KcOg8kiM+j/5lDcxkX+RipK55xJpF52lhyY0nPNZPmrE2/NPItQLvVJqgwSrI/5AVB
 zERoi6k2NROoSGZXFK5StreLVEoHVIJonujYq7iDmtnkAVmDsGiU076r0Z6a/YpObaT4
 t/5utBL2TCtMyI53xDD6D7Tu7h3MRCpNL5x+pdSJCiy5B7sB02ASh6DGwFGN1STGOY2n
 TLjBm9HQzoyUwnt/EGZQuc6TsOA0mZ8kZlCu07ZZay6Z6P3bCTS/ZOv+DZq/ruKQosAj
 GUhR7OsFS3IdN7HM/xRYPpp/+V1/VVyiThkrOV9O3XNriyUGzjbpesAAZU2pUiru+0CP
 TJaw==
X-Gm-Message-State: AOJu0Yz9ycvTh9+XqiGmq5WWSrZNeG447INPVqzM/xaKbfcL9/UxoaT9
 fiqBSr/Z0uteCMJWyuxfBLLfa5+kReFKzVAoFMBZZAx5OYbn6J1lK2vZ3gdcI63yIdOIdKQCELc
 r
X-Google-Smtp-Source: AGHT+IGOXZAifSExYp6cN2TXawYHcelH2S/9zYo2uKShw0Ee3l1+cHC5ZE8e1PRiM/JVtwL/Ad+GDQ==
X-Received: by 2002:a17:90a:af92:b0:290:ab28:8079 with SMTP id
 w18-20020a17090aaf9200b00290ab288079mr936507pjq.86.1705939906926; 
 Mon, 22 Jan 2024 08:11:46 -0800 (PST)
Received: from grind.. ([152.234.127.94]) by smtp.gmail.com with ESMTPSA id
 db3-20020a17090ad64300b0028e245501e7sm9866446pjb.4.2024.01.22.08.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 08:11:46 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 10/13] target/riscv/cpu.h: use 'vlenb' in vext_get_vlmax()
Date: Mon, 22 Jan 2024 13:11:04 -0300
Message-ID: <20240122161107.26737-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122161107.26737-1-dbarboza@ventanamicro.com>
References: <20240122161107.26737-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1031.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 05e83c4ac9..71696762e3 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -692,9 +692,16 @@ static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
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


