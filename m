Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF21179A3D9
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:49:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfaeQ-0000CZ-RE; Mon, 11 Sep 2023 02:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfaeO-0000CR-MF
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:44:00 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfaeM-0004Ro-Db
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:44:00 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68fb98745c1so509245b3a.1
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414636; x=1695019436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6nXUs6b9Y10nxctaibQIThdXKgyxUl6sbEBr/ysALI=;
 b=rWIMesH7o52tUCqOqMGKMGaZA1gdn8YrzpPdHwNs/T/40I/oPg7G3WaWPv27Z2EhNX
 L/UiookFiHXeGvuWT5t5QYi8mifCPso4peDCYxNlGamNoldkqmTmecvXS/q3im3/+kip
 dyvdXcj3iMHR1VwuXuiSOOe7UvqwKg7UNe0Lm8jOBfdMHKUPud4nxVWSXpuiU2U9LQrz
 FuzZYjkpVrCA04iKiBJJ/IhJCfKdgQXonzDsEMeb9Xf0qMJBIOiJhteVI+/ppRU5mMko
 UkNtOyu5oaDUZgFwQVGEOx2AelZFLnLm6IwUUEWPsbPyMqkg/QLnPEXtABVshJAAyLw4
 E0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414636; x=1695019436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6nXUs6b9Y10nxctaibQIThdXKgyxUl6sbEBr/ysALI=;
 b=SvlyIPPHtn8nyqboxGbN3AZF2BYyGpE8ld6vLEIfVhjSEgPgEUI9zcgTU7xXGFf1xq
 tmEo2nH8kN+wXVvGIsmw8FN+UzkIpug9NrZxVGRFt6zj2MlWKzXp4JfBRhLuaT0of7Oh
 5ZCvoTMQQpc5/iXaeWKanSk0MwitULe/M26OMIXXTLPZAoP9TJStihbAC2hXaz8TdF3V
 b5/DIqTnMuGStZif3ipPOTYTumz/VI6ci7I1tVIRDDSGMdjswR1pmTL5Un0ZdYZitmp4
 Xgj/3clTJhbt8HOvCFOeKPJPDlZLKMlFAiNvWaakJPU/sWlJpq1XNCRkDiHncBgSkAFK
 xybw==
X-Gm-Message-State: AOJu0YyZlmO3yvdEOHJn8wvEo8TKkbnhIpH/Pu3Vh7nQ4/cJXadikSDm
 vpfJyVSPMQdXsBqPAbPbjOd7tcWVGfvxbA==
X-Google-Smtp-Source: AGHT+IHgPOtMuyPLJoQ0hpWPNcEBYmsO3xVO4wxrZLbfxzpjshTf83bLbr6YIebk9tW+0rYyjX4bSQ==
X-Received: by 2002:a05:6a00:22c2:b0:68e:2c3a:8775 with SMTP id
 f2-20020a056a0022c200b0068e2c3a8775mr8651206pfj.33.1694414636239; 
 Sun, 10 Sep 2023 23:43:56 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:43:55 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 05/45] target/riscv/cpu.c: add smepmp isa string
Date: Mon, 11 Sep 2023 16:42:40 +1000
Message-ID: <20230911064320.939791-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

The cpu->cfg.epmp extension is still experimental, but it already has a
'smepmp' riscv,isa string. Add it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230720132424.371132-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6d02e85102..921c19e6cd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -130,6 +130,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
+    ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, epmp),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
-- 
2.41.0


