Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9468974D58D
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:34:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq4f-0000nK-ML; Mon, 10 Jul 2023 08:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4d-0000hZ-Os
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:03 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4c-0003YQ-3P
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:03 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3a36b30aa7bso3021495b6e.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992381; x=1691584381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=joPnt+UvwpmwJxWO4/HjjxeCw9U3iocczRA90Bda9C0=;
 b=SKK+R+gDExHbWKk1lh137SbFfHPbxUkabRB9oiBP4qfzf/JnuEWQtLSKBbTkP7Rkvk
 0Sl9QowJc07WD3V1PXLfPh6ujI4fBJ7M5/TnRJehMVw87xbhxN4cLSqEEwXszpw+F1kg
 nvssrNbfEDN7G49t2ixNMLInxZlbi4C4n+GlhH1Oi/7xOAvSurwuWhpw/I/k4v717ZiG
 qC+TvwrS7Ov03tPBeLuqro54g5JzoiFiFvLFMgdC1jtNOVKkNbygtT5MHfpR1NuqKwIq
 1ag5hiPxuN9w4S75rSitvsoMGcl3js13ehyKscPAv//m3cVxtgoFKvAm9n7MHLjC0oIm
 PFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992381; x=1691584381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=joPnt+UvwpmwJxWO4/HjjxeCw9U3iocczRA90Bda9C0=;
 b=FQE4/2Xup2qCVq+N7uH1iYDfhiDZB0Y9WP1yP9HjanUdky/JLo/ojQGR3pjM+iqbcp
 KGWG4tmczl31hX37VU7mTuUXe8mfvHk3dPbZ3X8Gd19Qz/1lKDX+2yHbe7Q6LE/IDDQQ
 Pf4ytT3XEonEBeBZUyF3WqerdH2talABDBDdXPaX+DwpBE+0AmvFC8uURz+Co/X/QP/6
 +UFia4nL4PIDqM9tquqEm0hzbXgfeD2U1K3GPI/cNSA/ntD7DPxyJszZT5xs/JK/qEb9
 Z8Mcz4zBvvQzDaimMQCkk+72yrswEJhstgT/Ij7rvNCMu0PC1CmFCtGenDu5RHcrT6Fd
 KNBA==
X-Gm-Message-State: ABy/qLYhNjijNxPnuMeMBAWDfhJds6iDCEa4hI2wfvlxTKxRSdoiOHhQ
 8sdVJd6w9Ap62RygCY8GkM1Et3TSTn6JYA==
X-Google-Smtp-Source: APBJJlH/icLIle3jVHZFZLZjG4EbdQKxqXcS8AKnHEjmekfqCgyfUGhPXHoHVlYAMFMUr5UNvECuag==
X-Received: by 2002:a05:6808:ecd:b0:3a3:5f8c:ac0f with SMTP id
 q13-20020a0568080ecd00b003a35f8cac0fmr10527621oiv.19.1688992380799; 
 Mon, 10 Jul 2023 05:33:00 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:33:00 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 12/54] target/riscv/cpu.c: fix veyron-v1 CPU properties
Date: Mon, 10 Jul 2023 22:31:23 +1000
Message-Id: <20230710123205.2441106-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x231.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Commit 7f0bdfb5bfc2 ("target/riscv/cpu.c: remove cfg setup from
riscv_cpu_init()") removed code that was enabling mmu, pmp, ext_ifencei
and ext_icsr from riscv_cpu_init(), the init() function of
TYPE_RISCV_CPU, parent type of all RISC-V CPUss. This was done to force
CPUs to explictly enable all extensions and features it requires,
without any 'magic values' that were inherited by the parent type.

This commit failed to make appropriate changes in the 'veyron-v1' CPU,
added earlier by commit e1d084a8524a. The result is that the veyron-v1
CPU has ext_ifencei, ext_icsr and pmp set to 'false', which is not the
case.

The reason why it took this long to notice (thanks LIU Zhiwei for
reporting it) is because Linux doesn't mind 'ifencei' and 'icsr' being
absent in the 'riscv,isa' DT, implying that they're both present if the
'i' extension is enabled. OpenSBI also doesn't error out or warns about
the lack of 'pmp', it'll just not protect memory pages.

Fix it by setting them to 'true' in rv64_veyron_v1_cpu_init() like
7f0bdfb5bfc2 already did with other CPUs.

Reported-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Fixes: 7f0bdfb5bfc2 ("target/riscv/cpu.c: remove cfg setup from riscv_cpu_init()")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-Id: <20230620152443.137079-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3faf703131..b9b3879281 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -444,6 +444,9 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
 
     /* Enable ISA extensions */
     cpu->cfg.mmu = true;
+    cpu->cfg.ext_ifencei = true;
+    cpu->cfg.ext_icsr = true;
+    cpu->cfg.pmp = true;
     cpu->cfg.ext_icbom = true;
     cpu->cfg.cbom_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
-- 
2.40.1


