Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CFA7B68F0
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:27:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qneTH-0004wH-0k; Tue, 03 Oct 2023 08:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qneTE-0004vf-VM
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:25:49 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qneTD-0006gg-7i
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:25:48 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6907e44665bso653644b3a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 05:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1696335945; x=1696940745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bosaUuegrcxoWj3ggOi+Hiu7LSbWQp61k7fb4NEy06c=;
 b=WXUJP3BdvVToreyykn03By9KND2MNpqGBfkjr1FMoc4+AGpI87+xU2AmeMA+XEO3mk
 U574DHpvXiASrBi3cNRVKUpImdFWDDjZk2D4REOz+IvDNF27fd/jXI+XTxNzH5ulHbGK
 yTZ1kESOFcOXFGVDFSN9fH5J5I4R9JzexvNEDbDDbgGqnAoLESyScbrznj29iuaOhAo+
 d43Wikh6Ur4LSRskV1B9lTKFfPKnSSvi5k5M1C3u09nAn0pj7ran7QrYBew9fh78nYlj
 Hf3kfRZGgGDu4wADOpdMhoHkXQRasl78MULg4UmmgPkSubd3XBizyBBF3dOK95ezgTn2
 VhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696335945; x=1696940745;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bosaUuegrcxoWj3ggOi+Hiu7LSbWQp61k7fb4NEy06c=;
 b=eUwTp0QsGd0lFsGLycrxIm98KEKcq2fwYLfktgd+zMxkpUSQTQPUSiXXKYBlfCgtkp
 78aGVPMOt7EdfKhulp0L/YanOdmBFC558a0zBHNDI4G3emNZFexc1AZHWNHO3O4Zhyfe
 jKt7IoPsvBL7cZ6xTf5SXpUEtqjdmV88lAsG3tUTCqDZJgCFtiZwA3vxBA5pho/LmUcW
 arDty10O6vxhhbMdB0Mpt6RZtvndzDBFFynqBiZhdqH8nYvuR1wSNWsD7Q/Loy9msHMF
 ICS8Se2YZTSPIgorKX+7yoU8n1Dhdv5FsMzuH8wBWuGN03vmrcTARbS0IzUAoNkwhwMw
 D4+w==
X-Gm-Message-State: AOJu0Yzx134238vuX2Poi9cIJnHjRoJKpLrEW4XM8r9vUYSI7X+S2YvE
 A4T68gZqx8+39Y6FGPSN68bHwFGKADVoCFkzFgo=
X-Google-Smtp-Source: AGHT+IGyfTxLPhcm6cR/3kJauEHWB2PFmnl82xFK9A9HF9G/uXgUSmXU7IpOr1+vJ4BVZQCqtLsd5g==
X-Received: by 2002:a05:6a20:441c:b0:14d:16c:2d20 with SMTP id
 ce28-20020a056a20441c00b0014d016c2d20mr17674942pzb.44.1696335945415; 
 Tue, 03 Oct 2023 05:25:45 -0700 (PDT)
Received: from grind.. ([177.94.15.124]) by smtp.gmail.com with ESMTPSA id
 q8-20020a170902dac800b001c44c8d857esm1404450plx.120.2023.10.03.05.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 05:25:44 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Paul A . Clarke" <pclarke@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH] target/riscv/tcg: remove RVG warning
Date: Tue,  3 Oct 2023 09:25:39 -0300
Message-ID: <20231003122539.775932-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
---
 target/riscv/tcg/tcg-cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 08b806dc07..f50ce57602 100644
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


