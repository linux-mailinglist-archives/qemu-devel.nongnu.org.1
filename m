Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 030BD71617D
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:20:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zG5-000219-Sy; Tue, 30 May 2023 09:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q3zFW-0001xz-GB
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:18:54 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q3zFS-0006pY-M0
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:18:54 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-514ab6cb529so2487379a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1685452728; x=1688044728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6lN5eouJcfjPPZk9JC9Sc0CdKdmmbFl74Xe8HWwm7eI=;
 b=UbV+kmvIzmjGtJspyF0GeX75mHy8X19hO9LnBtl1RsrJubk5B6DXJSdwWeQnztIsOP
 FVjNOa+zzw8GWLQ4+m+FlVMBnCQ3D6Oh9jx6lDsv5hFYZ5p7DpkPy0b57Znn0ZA4P2cY
 hvwzuBdkQmW9Z4ioLeZssDpG7ydAZrpLzeAh8uJ0YtY0n4D106Ouv8NNBQdC3Db/x0S8
 CJkpJ9OU27ZpNFAJIav1fus0C9t5z45W83JHhhBTpDiivv87VDJuMD2KaY9PvXMVZSfR
 r+9674JvoTWZOTnD6UgEyMbJC8B0lC4biVUiV+NsR00Moz3dsPblQUEyKNzGAb0Tx6dX
 2Odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685452728; x=1688044728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6lN5eouJcfjPPZk9JC9Sc0CdKdmmbFl74Xe8HWwm7eI=;
 b=f9dvpt97amspc+A8tGWIALahdAeYvHsVZ/yl5udgSSPwibpcgQ7bbTEVX6Jzq+1pb1
 s79BGNnjJmIlKB+7xGj29XACIxfKmrNX/4o04a9utgNMdMa7ZxUhZSaH1V4YRzlePKIF
 /bo3VGBzN86qElczRa+Rxx/PH0ACASbLgtTP1hHWc3MTV8HedHq3EH44qGdApSIRi1x/
 EWVsNOO2JG7YkG/+EbLV4SIIsR6auFPPfvPc/yY53ztlmlU9+5ggeIXp6taIvVPkO30W
 G81fKb9DF1YONO9770gfrEEUDy2OTDqulQC1nkCY66LLW6BF5X77WwnICeq08I+kNEES
 gb1w==
X-Gm-Message-State: AC+VfDyn65+Vj/f8Ev4m6c8FGZowx7MFz4iNdEACHcuJkyuN4azs2ymZ
 kk1+g/ztt6Zbhc0Qz2Wrbv9B1Q==
X-Google-Smtp-Source: ACHHUZ7fCzVIUsAbBT518LlZVMbp7shwSapV80KMelWOKp8/6zku0vJFFHshskSI1Rvic/EZiKhvXQ==
X-Received: by 2002:a17:906:ee88:b0:96f:aed9:2520 with SMTP id
 wt8-20020a170906ee8800b0096faed92520mr1997597ejb.21.1685452728440; 
 Tue, 30 May 2023 06:18:48 -0700 (PDT)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 le8-20020a170907170800b0096f803afbe3sm7376156ejc.66.2023.05.30.06.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:18:47 -0700 (PDT)
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
Subject: [PATCH 1/9] target/riscv: Use xl instead of mxl for disassemble
Date: Tue, 30 May 2023 15:18:35 +0200
Message-Id: <20230530131843.1186637-2-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530131843.1186637-1-christoph.muellner@vrull.eu>
References: <20230530131843.1186637-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ed1-x529.google.com
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
index db0875fb43..5b7818dbd1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -818,8 +818,9 @@ static void riscv_cpu_reset_hold(Object *obj)
 static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 {
     RISCVCPU *cpu = RISCV_CPU(s);
+    CPURISCVState *env = &cpu->env;
 
-    switch (riscv_cpu_mxl(&cpu->env)) {
+    switch (env->xl) {
     case MXL_RV32:
         info->print_insn = print_insn_riscv32;
         break;
-- 
2.40.1


