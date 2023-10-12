Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FBD7C63DF
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:18:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn5J-0000jN-CL; Thu, 12 Oct 2023 00:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn5H-0000br-F3
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:14:03 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn5F-0002s9-HD
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:14:03 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-577e62e2adfso378386a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697084040; x=1697688840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWtaIqGUyyKNjM4xZiYbpckNtX8oPC7/O+GFQf3dV0U=;
 b=MUsSuqWubAK65W4NABNDj54JwHwVVm8K2JV2/zbQ+C6ySqgc2r0jsIlP5vKhH/WSj8
 rSpfdII8ucJf26Fq9bKlEsbkJJXrYJqkN+U1PFRn0AKC8Q30wT9rRxRyqjOz+sClld4h
 9Lcy93f3LjmDxKMlN55hsBjjFsfXllbghPxVBD51WgbKwaD0zC/BFG/YhEuhinz3uDjU
 z3Qd+uW7m6WYuEsansM7zyQ0Lo1qqcIokdAlc7q3K2801mfDD2a0SNFlVBQMx/oPs2PT
 zZig32owSuuXauqtXxQK2QLxTpr2dmb6m+bLIVWqf05jf/Aqnx8bffZQnhSA1Zd5LDuf
 T44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697084040; x=1697688840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IWtaIqGUyyKNjM4xZiYbpckNtX8oPC7/O+GFQf3dV0U=;
 b=baMb4UwGb1ZvPxP1aBufC5ib2lOOpBsgTmeHErC0omQWQi+7GYU84RvRAPw1ZLbm6b
 Jp7t2vdWxXTpNu4FyjS5/OfmbZq8rvy9NSNtkKdAS48r48oByaQJPdxRvzN26xX6R5+h
 3MkU2kB96QcV0Qgpi2auqsDLU7Rxf6wrsfrpR1MgZb/+wn9jJ7/LmgD4VlGm39erajbJ
 feC+wbYDtGwXE5ygqnpTNW2jOm6upLxZWj56yitwOhIUz08bVtvNU1KJxOx9DZIAGzZF
 +h6NxTTAB75/EwRF+ZTC7IRyOXDbfY6o8Y7nlSzSJbhXfMamwW6c32sP8/XJ/bfP8HJ3
 a/aA==
X-Gm-Message-State: AOJu0YzJtwULH/obXLHrwsvvAG15UoghhR1afp1DBsNwoWKFaPXJBAJj
 h3udNA7+NCCbFIudMu1dydzTKxjeVXHx8g==
X-Google-Smtp-Source: AGHT+IHyFglRdRhtcI3Cs21mB9jHfeJgIBkSencId08upUcEL7ku9bj21fZV3HAFw+wvxeecV6QMIA==
X-Received: by 2002:a05:6a21:3397:b0:140:253b:b658 with SMTP id
 yy23-20020a056a21339700b00140253bb658mr24967183pzb.57.1697084039741; 
 Wed, 11 Oct 2023 21:13:59 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:13:58 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Paul A . Clarke" <pclarke@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 51/54] target/riscv/tcg: remove RVG warning
Date: Thu, 12 Oct 2023 14:10:48 +1000
Message-ID: <20231012041051.2572507-52-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
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

Vendor CPUs that set RVG are displaying user warnings about other
extensions that RVG must enable, one warning per CPU. E.g.:

$ ./build/qemu-system-riscv64 -smp 8 -M virt -cpu veyron-v1 -nographic
qemu-system-riscv64: warning: Setting G will also set IMAFD_Zicsr_Zifencei
qemu-system-riscv64: warning: Setting G will also set IMAFD_Zicsr_Zifencei
qemu-system-riscv64: warning: Setting G will also set IMAFD_Zicsr_Zifencei
qemu-system-riscv64: warning: Setting G will also set IMAFD_Zicsr_Zifencei
qemu-system-riscv64: warning: Setting G will also set IMAFD_Zicsr_Zifencei
qemu-system-riscv64: warning: Setting G will also set IMAFD_Zicsr_Zifencei
qemu-system-riscv64: warning: Setting G will also set IMAFD_Zicsr_Zifencei
qemu-system-riscv64: warning: Setting G will also set IMAFD_Zicsr_Zifencei

This happens because we decided a while ago that, for simplicity, vendor
CPUs could set RVG instead of setting each G extension individually in
their cpu_init(). Our warning isn't taking that into account, and we're
bugging users with a warning that we're causing ourselves.

In a closer look we conclude that this warning is not warranted in any
other circumstance since we're just following the ISA [1], which states
in chapter 24:

"One goal of the RISC-V project is that it be used as a stable software
development target. For this purpose, we define a combination of a base
ISA (RV32I or RV64I) plus selected standard extensions (IMAFD, Zicsr,
Zifencei) as a 'general-purpose' ISA, and we use the abbreviation G for
the IMAFDZicsr Zifencei combination of instruction-set extensions."

With this in mind, enabling IMAFD_Zicsr_Zifencei if the user explicitly
enables 'G' is an expected behavior and the warning is unneeded. Any
user caught by surprise should refer to the ISA.

Remove the warning when handling RVG.

[1] https://github.com/riscv/riscv-isa-manual/releases/download/Ratified-IMAFDQC/riscv-spec-20191213.pdf

Reported-by: Paul A. Clarke <pclarke@ventanamicro.com>
Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20231003122539.775932-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 2e462e7d11..a042bb6cda 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -293,7 +293,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
             return;
         }
 
-        warn_report("Setting G will also set IMAFD_Zicsr_Zifencei");
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_icsr), true);
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_ifencei), true);
 
-- 
2.41.0


