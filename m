Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B56B271617E
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:20:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zG8-00029b-4X; Tue, 30 May 2023 09:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q3zFc-0001zS-BF
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:19:02 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q3zFY-0006sM-8h
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:18:58 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-96f9cfa7eddso789800066b.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1685452735; x=1688044735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uMqno0siykPsS3ZNDkSpUapOggK2PTxFDdGkbme8bUM=;
 b=c8+HMQP5Bj2WCCnmRERnLHO5xuREls8b3MiJCmy9ib4dc18XyGlxvOmhxwr9phDytO
 QFWYc8j7PkiGuYnXE/6y4PA3rpZeWWB76hs2Zwa3Wg7u7H1UR3S/Ue+pLCd7jMY7nu1U
 9ZSaEDB7crfzQY+hjaBWhC28Fl4kWhP9kFnWkOOnIjONSTQ0oG1oH5RqfR+tLjvdJY9Q
 e7qjNNGgLTkDROUMHPEN1K3aTfUTziUVfkYVQH+Qv/JwKzDIGfEytMW0al9wKYKcx8I2
 tSEVqgGReChwa16aiTrcQFi5j/o6yTO4gFLIc7iw28MKGHvbBNuyQX45t5xJkB2cAazy
 covA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685452735; x=1688044735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uMqno0siykPsS3ZNDkSpUapOggK2PTxFDdGkbme8bUM=;
 b=lWFz8mkFkeIq/uS0rkZopX+d1EkeOwx8fQDSrirlbVIZIPOU4DtHvS+Y3xMBfvYJr6
 mYD+4pIBrM8slFi2Cji5tdAlHVmxsFJ6v1DAadY/TxzqZVxaUdc+bil562I4KdC7WsCX
 Fk8uGrYRpzFpTOQAccj7owCfvWzlV0HKILEgAEzyJX11Ju3YGanVAAHXSk/g5P1ZjZEW
 iFUy99XLlAPnFGY0pJkeOA1wjG62lhP0/TdB+mF+LR57+21tiFjXYnICpDXkQDAgrmo9
 XF87H3e8WFFwhvPqAz9imZlwoptbdlJH2Sl8bzy/8ThYL54lxDEkUtLmHyuLqSZ4tZex
 /D9w==
X-Gm-Message-State: AC+VfDyUbpoSlOnkPAi2SuSDkOL5VaHO6IHSZJ7Ygi5iqnVnI1Tw9yhN
 1/m8dkOVe+YtiJT4llZqO/+uBw==
X-Google-Smtp-Source: ACHHUZ58Ss1TseMMLkwOhpyNwWOTOvoX5Tn8nMQ/cLwTSMuqBJL8F3HVg7EhhpgvTY6lz6DSE4f4qw==
X-Received: by 2002:a17:907:7da4:b0:969:9fd0:7cee with SMTP id
 oz36-20020a1709077da400b009699fd07ceemr2108860ejc.10.1685452734790; 
 Tue, 30 May 2023 06:18:54 -0700 (PDT)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 le8-20020a170907170800b0096f803afbe3sm7376156ejc.66.2023.05.30.06.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:18:54 -0700 (PDT)
From: Christoph Muellner <christoph.muellner@vrull.eu>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhiwei Liu <zhiwei_liu@linux.alibaba.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 6/9] target/riscv/cpu: Share RISCVCPUConfig with disassembler
Date: Tue, 30 May 2023 15:18:40 +0200
Message-Id: <20230530131843.1186637-7-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530131843.1186637-1-christoph.muellner@vrull.eu>
References: <20230530131843.1186637-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ej1-x630.google.com
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

From: Christoph Müllner <christoph.muellner@vrull.eu>

The disassembler needs the available extensions in order
to properly decode instructions in case of overlapping
encodings (e.g. for vendor extensions).

Let's use the field 'disassemble_info::private_data' to store
our RISCVCPUConfig pointer.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 target/riscv/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5b7818dbd1..6f0cd9a0bb 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -819,6 +819,9 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 {
     RISCVCPU *cpu = RISCV_CPU(s);
     CPURISCVState *env = &cpu->env;
+    RISCVCPUConfig *cfg = &cpu->cfg;
+
+    info->private_data = cfg;
 
     switch (env->xl) {
     case MXL_RV32:
-- 
2.40.1


