Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B77874D584
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:33:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq44-0007eS-6Q; Mon, 10 Jul 2023 08:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq42-0007ds-3D
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:32:26 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq40-0002W9-Kq
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:32:25 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6b74faaac3bso3438880a34.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992343; x=1691584343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XTDP2PG48KWqsuK9vRwIb1bIWG5ubnW3ot9jxTLFPLA=;
 b=XsLL8Ze3pnb6Zlw/1W4kpFvEQodtchpuyLR8krWDFrV70CPY3Ss/42rcj7Bp3HogP+
 88PFqN+l2vuHwwa7r2Q61Q7L5h0+UatfIunwcsLtqDyMZMZ5CcT/OmOWUSE/wXOSKr/D
 +BWU3ZPmOGwJKYcPzDU2cnbUlB9vhq5U2DL0XxUgyTq2agaIOBVfk05y3eNLSQjhH9QF
 az/ey6/1RN2bOmlz/Lkf+X66wlwGeMPscNoFRa5OnYg3XYQRtDHVZJeYstvFnCTUeiDE
 +tegPoaHepHcDsdsMyXaXVgnftobyw+fJE/b2X39haFyWJlKhEpVX0pz8STferZnx+lg
 JRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992343; x=1691584343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XTDP2PG48KWqsuK9vRwIb1bIWG5ubnW3ot9jxTLFPLA=;
 b=DTfbFVh4C8D1RDnqpTtnySnLFiPor9+kg/HBbc8NoDbvTeW5qLhYd4bsh408LkJ+w1
 8JycGm2yj4nu3jtwHaGCT0xIJXYEOTl0pMqGozymuQMgD5JFX1madQPu2QWLQe/YUeua
 UHIpbszeMNjdffRtqv4ejBf/MkOT89BSFcAWYpaWNSnCz2gXsRRSGYBdXTJ6Uv++DvV/
 6U6wL5ESp+UoQnN0izFLei9UoJDwiDOF4yW28Dol+hoV1996PE/IOpWu9BC413+3z4uo
 fqQfhgFYhBXCWaJ2H3RAuf57MZVqFzQTkA+j2C01s1pisqIAxO2d6GI75UUBx4U26fzi
 CRmA==
X-Gm-Message-State: ABy/qLbx1Qyoh7+LpOuY8Hyc+W9f8ph40dw/lhZDc3paxPuEvxnughQn
 OK746XBI7mq7Jan/kCYZRR/4oWl6iW6jAg==
X-Google-Smtp-Source: APBJJlGgsYcY9fgBjezwx3TSOAvYU7mHdbgnU01KVYfaVN7Ulx+cY4K63xR5VyFMP3SGz/IpHF6Pyw==
X-Received: by 2002:a05:6830:144d:b0:6b9:6680:ad82 with SMTP id
 w13-20020a056830144d00b006b96680ad82mr2159270otp.23.1688992343110; 
 Mon, 10 Jul 2023 05:32:23 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:32:22 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [PULL 01/54] target/riscv: Use xl instead of mxl for disassemble
Date: Mon, 10 Jul 2023 22:31:12 +1000
Message-Id: <20230710123205.2441106-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Message-Id: <20230612111034.3955227-2-christoph.muellner@vrull.eu>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4035fe0e62..3faf703131 100644
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


