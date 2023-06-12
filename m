Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D11B72C298
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 13:12:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8fRi-0001dD-A7; Mon, 12 Jun 2023 07:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q8fRc-0001bT-0T
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:10:44 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q8fRZ-0002Ll-Tv
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:10:43 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-978863fb00fso760264666b.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 04:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1686568239; x=1689160239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKiZx/GWdoN3dJDoD5XgryFNnxIMPlMhwvvzmjLFsHE=;
 b=do0kUAhvd0mKPe/l2cw3tOttyGqS9I7UNxm0/F6gNk7Z0h4778S9tefTOPyPwFLNdV
 wXI6DDkIIDn1f1qWDXS2nwajxCquDQDYOStH9/QhGkDj7lybTRLHydUj2d7Hu06umlv/
 yRI1UZVP08kbS2/53GS4vWwhRhevOEtv8tXM8GQSeQdADzDhgkUYlwCIX8ybbqbeP3pB
 Ym3KQ+njQ2oHBiKWj5MCBRKSenqW8okf4PeKBcATp9p9LEM5l5YAXkmnqwsbQgNgKiSH
 ikUaBTW3TiGWmPFjJE0SiLIdM06MvxDO1TfG3lT3m/wJrH9iIq1M3XlgQYOUFau0JDyO
 5XWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686568239; x=1689160239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CKiZx/GWdoN3dJDoD5XgryFNnxIMPlMhwvvzmjLFsHE=;
 b=jUZy0wXxmFKSFzhKE+0XaHGLF6+ROhBXo0OkC2gpte7siJmR5e1UdGvkmODR3k2hCm
 05Sk0P8royMgXrvRr2wpISdt1QoRV57i22pK2vHYslpvaX6mEgMoJsVcCf4ce/mvFt8b
 77WeRVdLwM454C2yf2uB6CdaFLeySw0UV8Ymv5n0uAB1v1yr/gYBSKilsPPMRp06GDu/
 C9g4lT5YgqpJ7BBpYbScJTIpNWMy6NwnciVbRuNNIbam9aLBDBDJLS/Ui8b8cP8EfkIm
 CqZ2TOflgeRkxd6ozDgvMAppToSlAFyjN7FvQ+gLgJJv8qq9qFa1ymdn+lZHRnk5VJNp
 +s2w==
X-Gm-Message-State: AC+VfDwB4APkAIEegMHi6YytXXhg74RxrWRcLLeJ8PkWEvShweqHgIak
 /UMTh65GY0Ddiu4zIaDTcFgLdA==
X-Google-Smtp-Source: ACHHUZ62HWJY9DDz1qTLpEbbFwyfNY3kIchH0RLv5h05WwkOoHOpbmQsH4jEQ0cTfktYhD+nAuYSWQ==
X-Received: by 2002:a17:906:eec5:b0:969:bac4:8e22 with SMTP id
 wu5-20020a170906eec500b00969bac48e22mr9650573ejb.26.1686568239281; 
 Mon, 12 Jun 2023 04:10:39 -0700 (PDT)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 w23-20020a1709064a1700b00978723f594bsm5000948eju.101.2023.06.12.04.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 04:10:38 -0700 (PDT)
From: Christoph Muellner <christoph.muellner@vrull.eu>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhiwei Liu <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Weiwei Li <liweiwei@iscas.ac.cn>
Subject: [PATCH v2 1/8] target/riscv: Use xl instead of mxl for disassemble
Date: Mon, 12 Jun 2023 13:10:27 +0200
Message-Id: <20230612111034.3955227-2-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612111034.3955227-1-christoph.muellner@vrull.eu>
References: <20230612111034.3955227-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ej1-x631.google.com
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Disassemble function(plugin_disas, target_disas, monitor_disas) will
always call set_disas_info before disassembling instructions.

plugin_disas  and target_disas will always be called under a TB, which
has the same XLEN.

We can't ensure that monitor_disas will always be called under a TB,
but current XLEN will still be a better choice, thus we can ensure at
least the disassemble of the nearest one TB is right.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 target/riscv/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 881bddf393..63faf16499 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -858,9 +858,10 @@ static void riscv_cpu_reset_hold(Object *obj)
 static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 {
     RISCVCPU *cpu = RISCV_CPU(s);
+    CPURISCVState *env = &cpu->env;
     info->target_info = &cpu->cfg;
 
-    switch (riscv_cpu_mxl(&cpu->env)) {
+    switch (env->xl) {
     case MXL_RV32:
         info->print_insn = print_insn_riscv32;
         break;
-- 
2.40.1


