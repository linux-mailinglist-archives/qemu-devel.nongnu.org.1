Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B75C0712A95
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:25:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2aDn-0000dU-Ar; Fri, 26 May 2023 12:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1q2aDl-0000cx-1K
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:23:17 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1q2aDh-0005LR-VA
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:23:16 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f68fc6b479so10464735e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685118192; x=1687710192; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7zZkdQfndXGDq6GOJMf0VbACfEvk3LLwmZQujYfYvXE=;
 b=NQGHtC/bXFMmp7guIzpa4GesWrhqYLJIgFvKIQq9b/QrZM49s0dLT4FjCFa3hgf5pp
 NTt1L+CXrZjqBBOIlq71YpRCMvLfPQtxlV2lrqkqhN0W6P0Aj/BBn76+VwwXyyzA6Wuu
 JyFzc+/Pfc2aTj2x0ZhE8LkaN4N6sTFJ1jIYFpXhxc/Es41r/Ip4k+cw8r/mr+fMYaNa
 xBepQpTErIBMOK1kMjq2lw9m/6vcYa5/ItwFxnfnRr9YyE6+LDI6+1nkBSLW0tJDy4sO
 AbnLYGSg7WDVuY1bXfPcdJ9qtepiJM6QaU2zwdnLXtGCn6l4Y7dSYjdoP3C89bDefSC5
 lEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685118192; x=1687710192;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7zZkdQfndXGDq6GOJMf0VbACfEvk3LLwmZQujYfYvXE=;
 b=P4pUcMRq3Os2CDdJcbzAIICDPJFPRjHdfH24jPRt+JtTYzZCLgxH31i682u9CXk+0q
 cIRQdcTvBG/k8/lWkS0QXIQsvaAQuWH99v/+dDq1tTDHY8yuUUq9jBRG41D1LXcwH70m
 5Vz5oNwGl53RHaQ8ruOcijhRvTSF2Ph67pxooiOWoJhzKAc5cquWkv6U8VQAFtBIzY69
 VzT3UanzpFspkkZkbB+T7+9E/jdaiJcoNzkKcUaOGVVr4zZLjWEn78t6IXDhm7yejCm1
 v1iMzVUPo4k1vDoC05aOqc7FV1MjrSuv5xny2m03+eJvT3wSfO/5BMmd3IVT8T2x4sPE
 Wh9w==
X-Gm-Message-State: AC+VfDwGyKXfvFzbkMQjWSJvbH+7FF5OpT9PScAlzNnC9Mtw4y7u9bYn
 6y/Tg3A6sypmNXHTUU5qEjq5qg==
X-Google-Smtp-Source: ACHHUZ7uPkTZSxFKS2pThQQFU0PZo1cT2DagqoU2EuG/nDvypL7/Z0qJKnfvOAvxgjeX2jxcedoFmg==
X-Received: by 2002:a05:600c:2245:b0:3f6:cdf7:a741 with SMTP id
 a5-20020a05600c224500b003f6cdf7a741mr2082060wmm.25.1685118192064; 
 Fri, 26 May 2023 09:23:12 -0700 (PDT)
Received: from localhost.localdomain
 (cpc98982-watf12-2-0-cust57.15-2.cable.virginm.net. [82.26.13.58])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a05600c294b00b003f6129d2e30sm9312090wmd.1.2023.05.26.09.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:23:11 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com,
 rkanwal@rivosinc.com
Subject: [PATCH v2 0/6] target/riscv: Add RISC-V Virtual IRQs and IRQ
 filtering support
Date: Fri, 26 May 2023 17:23:02 +0100
Message-Id: <20230526162308.22892-1-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series adds M and HS-mode virtual interrupt and IRQ filtering support.
This allows inserting virtual interrupts from M/HS-mode into S/VS-mode
using mvien/hvien and mvip/hvip csrs. IRQ filtering is a use case of
this change, i-e M-mode can stop delegating an interrupt to S-mode and 
instead enable it in MIE and receive those interrupts in M-mode and then
selectively inject the interrupt using mvien and mvip.
            
Also, the spec doesn't mandate the interrupt to be actually supported
in hardware. Which allows M/HS-mode to assert virtual interrupts to
S/VS-mode that have no connection to any real interrupt events.
             
This is defined as part of the AIA specification [0], "5.3 Interrupt
filtering and virtual interrupts for supervisor level" and "6.3.2 Virtual
interrupts for VS level".

Most of the testing is done by hacking around OpenSBI and linux host.
The changes for those can be found at [1] and [2].

It's my first touch on RISC-V qemu IRQ subsystem. Any feedback would
be much appreciated.

The change can also be found on github [3].

TODO: This change doesn't support delegating virtual interrupts injected 
by M-mode to VS-mode by the Hypervisor. This is true for bits 13:63 only.

Thanks
Rajnesh

[0]: https://github.com/riscv/riscv-aia/releases/download/1.0-RC4/riscv-interrupts-1.0-RC4.pdf
[1]: https://github.com/rajnesh-kanwal/opensbi/tree/dev/rkanwal/irq_filter
[2]: https://github.com/rajnesh-kanwal/linux/commits/dev/rkanwal/aia_irq_filter
[3]: https://github.com/rajnesh-kanwal/qemu/tree/dev/rkanwal/riscv_irq_filter

v2:
 * Move RISCV_EXCP_SEMIHOST to switch case and remove special handling.
 * Fix linux-user build.

Rajnesh Kanwal (6):
  target/riscv: Without H-mode mask all HS mode inturrupts in mie.
  target/riscv: Check for async flag in case of RISCV_EXCP_SEMIHOST.
  target/riscv: Set VS* bits to one in mideleg when H-Ext is enabled
  target/riscv: Split interrupt logic from riscv_cpu_update_mip.
  target/riscv: Add M-mode virtual interrupt and IRQ filtering support.
  target/riscv: Add HS-mode virtual interrupt and IRQ filtering support.

 target/riscv/cpu.c        |   9 +-
 target/riscv/cpu.h        |  23 ++
 target/riscv/cpu_bits.h   |   6 +
 target/riscv/cpu_helper.c |  99 +++++---
 target/riscv/csr.c        | 477 ++++++++++++++++++++++++++++++++++----
 target/riscv/machine.c    |   6 +
 6 files changed, 546 insertions(+), 74 deletions(-)

-- 
2.25.1


