Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C26A9CDB1
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Apr 2025 18:03:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8LVh-0006PN-I9; Fri, 25 Apr 2025 12:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8LVa-0006BW-1m
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 12:02:34 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8LVX-0008Nn-90
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 12:02:33 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-306b6ae4fb3so2679090a91.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 09:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745596949; x=1746201749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqkSXWmlAzXCmkQApAbF+YpwERfG9A2hRBSgef/JTFs=;
 b=WczjmJcwMu9WGjhf/SRMJiMHM7L8cJncT7JogBqukUdY8442M71aSwGabZiHnCAdlu
 Ow1fA9yxW0Adf3dyQWJ/Z1ZuBnYCPckUsyEX3hKT+1eD3/hcR4sogsg71dEmg/DqFaoS
 AJ+RR9vR3ijPqFFg6PCf0BugASYs+ePn4Cw1hop17AIg0BZnCw0gILMIwVS6mFMxJwhq
 Gxofr9FB5grUCzaCi/59L+27vQ9wwigyiTZ5oDghAhLesqxQPXUD3aY9jVgg2tevdHsM
 I09C4IdpIO5uEVx+o7wHNJZoa3crWfK0xhR6V8ylnyHqZ48GnTiO1lPihjjKI1zWUEcd
 4m2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745596949; x=1746201749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sqkSXWmlAzXCmkQApAbF+YpwERfG9A2hRBSgef/JTFs=;
 b=E8N8oAHW5jDJxgDGhIK6TuVNnLgP/T57yMPd2a1tiHHE5PZxmWw+Hfi8C72+fYTORR
 irkZ6/vEF1HM5/9ZqLavqMMx+1bGE+43qfD+KpdaF+lrL/SC36ns/uMbPXdveToFRAYk
 nxFg01NhiCOJh1FTDVnPzZVpR/36wrVv5jMMhhATfYGIL1NnhtZIJqVfnolcr52aOUll
 nRcMoPQuzhhxaa5MsgV3QjMTtbZQA0B/v4NYkKqEHKhHjMah1ZSPp4ZWyDhJ/nngFwr2
 LOHgx/tP3J/16fP8lltysozhOM2pTmZCrUuE4apVLR3ojYHmy/HeA6+T4RbA5aLcbSgK
 2zDQ==
X-Gm-Message-State: AOJu0YyY4E4MwcijuU6FyNJJG6Z6E9lyCkvsUl7wDaw+F2urgejh/XDF
 me5hHV2GRWHa53UZj84qRaF4bgYPa9w8P5HIUezkCReYIwUBi12WwHmpaxy8x7pWKBgj6eOTaX8
 V
X-Gm-Gg: ASbGncs8KVLyFwi1KrCjTObRUX37aIA0M4DbTzcH0D/YY/gCNIAQx4mXBS5oGFrTcKB
 G4QbNICmDTN5wtfWE5vGMUJeQ20xZhNdLfkkg7/E2VqP0lt68sHVQc42yOzl+OwyLGI5NjP8nYp
 Y4KW44/g5WeqtXHVnnmlnD5OmogG1YB9gBX2xP8CijiDdV4HBSQbH/qYIFyLjQd6bw0BA2zQ3vx
 nDg8Acqh6Y9xJNfVvtytesRgRHta+LsXQPxOsWcajWIFktp0Z3U+m2RIQRIaM8St0T86j+zyL3A
 XBr1JwFJas13gcLjobLshDlEEqHQLxrrgqW0YHJeSY3plZnlR5dbycRmzWigtvirdNO4
X-Google-Smtp-Source: AGHT+IE4YYqmaEP3zJ1KrUTGfl5R4j13/d1L2SAgmq6sAAY9/xzl0Xgp4kB756Ixq6d56Qy8F7wMrw==
X-Received: by 2002:a17:90b:574d:b0:2ff:6aa6:47a3 with SMTP id
 98e67ed59e1d1-30a013b50c5mr137757a91.25.1745596949215; 
 Fri, 25 Apr 2025 09:02:29 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f774e534sm1820005a91.17.2025.04.25.09.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 09:02:28 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 7/9] target/riscv/kvm: add senvcfg CSR
Date: Fri, 25 Apr 2025 13:02:01 -0300
Message-ID: <20250425160203.2774835-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425160203.2774835-1-dbarboza@ventanamicro.com>
References: <20250425160203.2774835-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We're missing the senvcfg CSRs which is already present in the
KVM UAPI.

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 1ce747d047..5efee8adb2 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -249,6 +249,7 @@ static KVMCPUConfig kvm_csr_cfgs[] = {
     KVM_CSR_CFG("stval",      stval,      RISCV_CSR_REG(stval)),
     KVM_CSR_CFG("sip",        mip,        RISCV_CSR_REG(sip)),
     KVM_CSR_CFG("satp",       satp,       RISCV_CSR_REG(satp)),
+    KVM_CSR_CFG("senvcfg",    senvcfg,    RISCV_CSR_REG(senvcfg)),
 };
 
 static void *kvmconfig_get_env_addr(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
@@ -698,6 +699,7 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
     env->stval = 0;
     env->mip = 0;
     env->satp = 0;
+    env->senvcfg = 0;
 }
 
 static int kvm_riscv_get_regs_fp(CPUState *cs)
-- 
2.49.0


