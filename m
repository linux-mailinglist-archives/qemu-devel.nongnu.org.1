Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4E982E28F
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 23:27:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPVPI-0000pm-Nz; Mon, 15 Jan 2024 17:26:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPVPG-0000ob-Lv
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:26:10 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPVPF-00067p-5p
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:26:10 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3bd6581bca0so1707079b6e.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 14:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705357567; x=1705962367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jgocnB++hOS9pjEL1cmxh6V/YOdSt8orkQh5dhnvCxw=;
 b=FCzAMwffgpWf4Ym1wre+TiRkIenpe1qWvPAov5U3IbTzY9u+uc6ZKZ2Fv8Va3hp6/C
 RxghgmvH3B2+tT0hgIAtd1J2ybLnAEbWQSFev1RDg+HuRVjsRyzQ38+EJ2zPATmy6QNw
 7ZelnVe2YtOAMezWQXkO6A8TuyZaavfrJ/epNo77huSFuHz7qR7Fnhp6bZdvddxZQebZ
 OZ9AIPN6/tkDFCOr3Yxcq1c5IfXC3PcpJyXmGEZw35PGmGnxOkxrpsRvOM6cBRTMiDlB
 +C1uc3E+g5xaVO080nSeTelqc/+OHpdercJEAAO5TDllmSSlvmv/YpJA5dFIvtJsZt47
 LOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705357567; x=1705962367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jgocnB++hOS9pjEL1cmxh6V/YOdSt8orkQh5dhnvCxw=;
 b=GgZS4dfky9y7AtxeCC0Z5EcIHfsKlJsCN2ZxS6AzogZzhrJ0RB+5/EgOZbwQ31ptpF
 GUh9dpjUDPtNWVkpNi8QviTCGkeZzdVoX9UvvXCD6Liu7dFZnDTpMkaPhEgBqD8S0Ura
 1jA/maWcdkjuer4B2jazTV6atfXIUznHeGFK8mWH3vyTgEktXCcrJvmB+24wJA2tIos0
 b+FkhjVyyKSKHRld7twAwA3hhWwAQr7efdd+80xxFWWIy0fpxxRMzXfIAWHkLHJp08s2
 z56sH8yWdHiXTkdHe3suww/CiTKt5MxYZ16Nrtto8Y02y+B+WcD+fsBIMEEjKtMDliI9
 4jng==
X-Gm-Message-State: AOJu0YxXLgoNfgPjVKXrgzKbPBevRGKIr9YAUNKQ0hDt3xTU90O/Ll12
 sXUwwG6gyvfBAibRvJBj7IYWWGFBkVuAqAaVbtrGxaOIYSqcTg==
X-Google-Smtp-Source: AGHT+IHN4uXcoOeeX6dmDXK1c299Z9B3xOVmCeXOi343wRJ2tXjmE965lVNO+tF8Fm13UkOaw1Sdkw==
X-Received: by 2002:a05:6808:3848:b0:3bd:6eaf:6f67 with SMTP id
 ej8-20020a056808384800b003bd6eaf6f67mr6359464oib.113.1705357567308; 
 Mon, 15 Jan 2024 14:26:07 -0800 (PST)
Received: from grind.. ([152.234.123.64]) by smtp.gmail.com with ESMTPSA id
 ks19-20020a056a004b9300b006d977f70cd5sm8125940pfb.23.2024.01.15.14.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 14:26:06 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 10/12] target/riscv/insn_trans/trans_rvv.c.inc: use 'vlenb'
 in MAXSZ()
Date: Mon, 15 Jan 2024 19:25:26 -0300
Message-ID: <20240115222528.257342-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115222528.257342-1-dbarboza@ventanamicro.com>
References: <20240115222528.257342-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x236.google.com
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

Calculate the maximum vector size possible, 'max_sz', which is the size
in bytes 'vlenb' multiplied by the max value of LMUL (LMUL = 8, when
s->lmul = 3).

'max_sz' is then shifted right by 'scale', expressed as '3 - s->lmul',
which is clearer than doing 'scale = lmul - 3' and then using '-scale'
in the shift right.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index d743675262..b4663b6e1f 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1160,12 +1160,12 @@ GEN_LDST_WHOLE_TRANS(vs8r_v, 8, 1, true)
 /*
  * MAXSZ returns the maximum vector size can be operated in bytes,
  * which is used in GVEC IR when vl_eq_vlmax flag is set to true
- * to accerlate vector operation.
+ * to accelerate vector operation.
  */
 static inline uint32_t MAXSZ(DisasContext *s)
 {
-    int scale = s->lmul - 3;
-    return s->cfg_ptr->vlen >> -scale;
+    int max_sz = s->cfg_ptr->vlenb * 8;
+    return max_sz >> (3 - s->lmul);
 }
 
 static bool opivv_check(DisasContext *s, arg_rmrr *a)
-- 
2.43.0


