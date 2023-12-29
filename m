Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C210081FC43
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 01:49:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJ14L-00074T-C4; Thu, 28 Dec 2023 19:49:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rJ14I-000737-47
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 19:49:42 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rJ14F-0003Xe-SG
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 19:49:41 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6dbaf9b1674so3864410a34.2
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 16:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703810978; x=1704415778;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gvkcXGMKJhei6A4C5VxcjXDsgHP4Nqs2chK3cpMCHlw=;
 b=q0abwfHTdGdCr8XVdlXfgvRhcjSOYj2kF/nKq2w35Gwr0fZsXzBK+rKPXsa0PL1Ci8
 V8WCf8lxy1/0z2BT0ofsZzXm72BOOqlvN0e2gTAHeNM/uL4rh27+AwGy7nqint+stV1f
 X703vEoBWbXX7UhI5pGZvwwBjJ62XkHM7YbE1swB55c3dnDwssnfK8rexPYbOWPWV8DL
 dgp/6/33lqtTLMJ4L9RQPy7ggoTcq4AvgfkYvxwwIGzXTbSY2nUUDVNW1F6U5Di675Ah
 qhY76KSx+iHywD2dG1us5/nKd82h0jgKGo0YjGgc1tVbc2+0psBheSlsQkuAUpKT6r7L
 RVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703810978; x=1704415778;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gvkcXGMKJhei6A4C5VxcjXDsgHP4Nqs2chK3cpMCHlw=;
 b=WmSh4WB7qlCGLPb8Utk2BmUHWT/eAIAHXKc61b08U+KMmI+ZKhonvsQGTnfWlrVvG4
 E0YdFzR3N1AU57CsU1sqjWTMQdnFNPhYbUHXGMFFPoT3e1GzYKKrew2/WFPB8ln/wRpA
 6DyJRwuYg0IhWEXJ/lKiXqzEfTxscNGywM4VJD6u0+cIJKB9qmwhwOjLfkH+I1R/g7AK
 go6xXqFzMQ8XPByb28iiuPC5/by8hbd7ZdjukvYxxRTvI0634lw1t/zuajSClSz/gk51
 UrK+p+ZMbXsfJmtYS4Tb5crh2ZIAJdtqUsznfbyZwi0m4WbkzpJgC9Zr+VulT3vnhSrb
 VMfw==
X-Gm-Message-State: AOJu0Yw6wrEcwRSOxAkJGzNoGCU1THP5UiwkCgfL5pi1W7ACogEwXWZ5
 nipGfu9b14YltLhs5roX57fQ3FiVmfhmeES8nrGbIq8UbCc=
X-Google-Smtp-Source: AGHT+IFDFsH38N4Fr6QwiwrXJhhnkFArHgjIiNHhews2+8PIMZxLWUatkO2qy50ABGGp+1pglHVwiA==
X-Received: by 2002:a05:6870:7087:b0:204:70b3:97d5 with SMTP id
 v7-20020a056870708700b0020470b397d5mr6922097oae.78.1703810977761; 
 Thu, 28 Dec 2023 16:49:37 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 ms25-20020a0568706b9900b0020463640518sm2636007oab.14.2023.12.28.16.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 16:49:37 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
Subject: [v2 0/5] Add ISA extension smcntrpmf support 
Date: Thu, 28 Dec 2023 16:49:24 -0800
Message-Id: <20231229004929.3842055-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=atishp@rivosinc.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


Changes from v1->v2:
1. Implemented actual mode filtering for both icount and host ticks mode.
1. Addressed comments in v1.
2. Added Kevin's personal email address.

[1] https://github.com/riscv/riscv-smcntrpmf
[2] https://github.com/atishp04/qemu/tree/smcntrpmf_v1

Atish Patra (2):
target/riscv: Fix the predicate functions for mhpmeventhX CSRs
target/riscv: Implement privilege mode filtering for cycle/instret

Kaiwen Xue (3):
target/riscv: Add cycle & instret privilege mode filtering properties
target/riscv: Add cycle & instret privilege mode filtering definitions
target/riscv: Add cycle & instret privilege mode filtering support

target/riscv/cpu.c        |   3 +-
target/riscv/cpu.h        |  17 +++
target/riscv/cpu_bits.h   |  29 +++++
target/riscv/cpu_cfg.h    |   1 +
target/riscv/cpu_helper.c |   9 +-
target/riscv/csr.c        | 245 ++++++++++++++++++++++++++++++--------
target/riscv/pmu.c        |  43 +++++++
target/riscv/pmu.h        |   2 +
8 files changed, 295 insertions(+), 54 deletions(-)

--
2.34.1


