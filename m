Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E6A827BFB
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 01:28:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMzxG-0001RE-Ex; Mon, 08 Jan 2024 19:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rMzxE-0001QI-RM
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 19:26:52 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rMzxC-0001ZS-CA
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 19:26:52 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-204ec50010eso1315790fac.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 16:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704760006; x=1705364806;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ApE7CLYzLqgoD1C9KPKGqQyHZO2Lh1Vk/eQTUlTrEVg=;
 b=HwCh7HbKz7eCm1GM3+uKqEFe8DiRyD2Zv7F7ecW+4jXJIvz9OmJxengcWgNEkhsUrg
 Q+5to87d5Iawydf/gDOFr4Rl3PJv2NheFWFGPY86k4X4x6oikzYJPPRHOhe0Uk7fmoAQ
 on0b5o5wVAtAPm4ASk5vqyvtotKpD5/A3IMDfGwPLAaOYwq+xjF3PnQyTdFjCaGbRAf2
 uE7e/tPjyZ+ndmN0i17LGmOZkl/7Gd3yeiRvpinZZviNBB1VAD3m7Jr6e7HDDo+5GcS8
 fnfPhez0VE9FlscPoai2k0+3+OabLc5URAX+thhMYfwMHuiuVoHt5kUmg0C+0excV9EI
 owIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704760006; x=1705364806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ApE7CLYzLqgoD1C9KPKGqQyHZO2Lh1Vk/eQTUlTrEVg=;
 b=UGB6aXlgAbkJzTnCYajZFFfWlRiQg6vN1j1WWqyYbuq+0x8ZlS9HH2PfJnfQgNaxWR
 OEzJTgA0T3nbAmaKMimBH32vJxfbVx4N4IL3ES4duVGiu2dHYjth5AIyRBX+qMBw3RpF
 zaewcoYjEJ6GWKCL4sE+edi61oKlyrE5lN76FJZ9o4bzDtTZB/BAri4+/e2U7Kq8sey4
 NXoNYoWqka8sP7Tq6dxhBIOYn9ohKpHI4HBITWSJnlPSA4XuErfl5RQeGuO+jIShkmpv
 J5rFwafV1xHan1zxPsHc2Lo3pX5n95/oQEfHMz5oZlB0k4lVlSkK6mht+9QLi1wzSMN6
 GzzA==
X-Gm-Message-State: AOJu0YwWqItloPPtLP47L8D3Gl9aEzUjX6mgLrZWIerIwSrx+TFws4lS
 XmWGL2nqIAI6PwmpGH7yuCZwj5nR3sl0Ww==
X-Google-Smtp-Source: AGHT+IGiGYOS68NrDaZ9vJBFDY275Xb6E7550V7MOeD+OAG1hhB0pqmwlOw8AYfQoTIDgsZ53tlydQ==
X-Received: by 2002:a05:6870:4611:b0:1fb:75b:99ba with SMTP id
 z17-20020a056870461100b001fb075b99bamr5477105oao.105.1704760006434; 
 Mon, 08 Jan 2024 16:26:46 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 wp12-20020a056871a9cc00b002042cafdc52sm219917oab.2.2024.01.08.16.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 16:26:46 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: 
Cc: Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 kaiwenxue1@gmail.com
Subject: [PATCH v4 0/5] Add ISA extension smcntrpmf support 
Date: Mon,  8 Jan 2024 16:25:49 -0800
Message-Id: <20240109002554.646572-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=atishp@rivosinc.com; helo=mail-oa1-x2f.google.com
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

This patch series adds the support for RISC-V ISA extension smcntrpmf (cycle and
privilege mode filtering) [1]. It is based on Kevin's earlier work but improves
it by actually implement privilege mode filtering by tracking the privilege
mode switches. This enables the privilege mode filtering for mhpmcounters as
well. However, Smcntrpmf/Sscofpmf must be enabled to leverage this. This series
also modified to report the raw instruction count instead of virtual cpu time
based on the instruction count when icount is enabled. The former seems to be
the preferred approach for instruction count for other architectures as well.

Please let me know if anybody thinks that's incorrect.

The series is also available at

Changes from v3->v4:
1. Fixed the ordering of the ISA extension names in isa_edata_arr.
2. Added RB tags.

Changes from v2->v3:
1. Fixed the rebasing error in PATCH2.
2. Added RB tags.
3. Addressed other review comments. 

Changes from v1->v2:
1. Implemented actual mode filtering for both icount and host ticks mode.
1. Addressed comments in v1.
2. Added Kevin's personal email address.

[1] https://github.com/riscv/riscv-smcntrpmf
[2] https://github.com/atishp04/qemu/tree/smcntrpmf_v3

Atish Patra (2):
target/riscv: Fix the predicate functions for mhpmeventhX CSRs
target/riscv: Implement privilege mode filtering for cycle/instret

Kaiwen Xue (3):
target/riscv: Add cycle & instret privilege mode filtering properties
target/riscv: Add cycle & instret privilege mode filtering definitions
target/riscv: Add cycle & instret privilege mode filtering support

target/riscv/cpu.c        |   2 +
target/riscv/cpu.h        |  17 +++
target/riscv/cpu_bits.h   |  29 +++++
target/riscv/cpu_cfg.h    |   1 +
target/riscv/cpu_helper.c |   9 +-
target/riscv/csr.c        | 242 ++++++++++++++++++++++++++++++--------
target/riscv/pmu.c        |  43 +++++++
target/riscv/pmu.h        |   2 +
8 files changed, 292 insertions(+), 53 deletions(-)

--
2.34.1


