Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A5881FC40
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 01:48:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJ12L-0003QQ-9g; Thu, 28 Dec 2023 19:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rJ12I-0003Q3-UF
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 19:47:39 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rJ12H-0002uW-1C
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 19:47:38 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d480c6342dso12955055ad.2
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 16:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703810853; x=1704415653;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=gvkcXGMKJhei6A4C5VxcjXDsgHP4Nqs2chK3cpMCHlw=;
 b=Tg+wKIfOLm9V9IPY5EQEoqECEow5lk+Mrw4B/F5cm4GMv9z304DgQ891mJGDawCV4A
 u1CRbZ7AMWALK/aYI29lvwRhA5BLSSiRgQuBGxcPnyNmSFXKXEmLapOWNUG1VLreehMA
 YOlljAE7p44FItey4M4isqhH+puqeq3MGF2WdiOp38Zuj12xdN1ZG2r8Il+bDbliLWY9
 to5Rht0MVTz+cpGvzqgpqIi5CR4kQ4Rqh0dDxUqzffwJaMODPB6u7UwyoPv/vTbZVXCF
 u5l+Sv3VnC6RXJtVLisxezv23rRVMThxQMtCs91A49Wwnt476xtLLZHjqb61JrkDN2RE
 8QBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703810853; x=1704415653;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gvkcXGMKJhei6A4C5VxcjXDsgHP4Nqs2chK3cpMCHlw=;
 b=R+p08dnn43XjazH028FcT8Rpndn9ZE+hejq7rI6qWlzWK/lPeS4pAtMlPB+pBPI9j5
 AzVxtYstAKoL5UaZi6dyKS1pbobcwNArC10DjrUHsWfnN2Qo4xi9Y+FswJ8FatzdkRYS
 4a3KwGDri+JyqSwgw++bs59pdRvFstyiLHvP6IV7ZOrw1R5Wsc+8gA9rnoJ2NEDbZ+YT
 6pIFqFcmdiYT5aB4OqL2rGOCClsc9OUP/yNFf3WfRhHSLV/BJiDpSZGEP6iWGGoaaFb7
 phifTbtE/D/Im+Cy1n1H1JwdJD6n1G2i0JU4uEPpjaxKheYPsgVEo0f5D1X/pe92tkSH
 DaJQ==
X-Gm-Message-State: AOJu0Yx1+zqxSaEc9f0sAhav9OGENLaorxPXcK7YZ1QgBgZwg7hDhKPa
 pxN5rqFoYJmbEvpNINxXNY8t/0lxgrq/mUxIog6BhVFJP5k=
X-Google-Smtp-Source: AGHT+IHSiVU4k73fsPIHnbRgnjVB6VsJkH3qV0wILwOqTyTawxm4p8HP0YHUZb4JyXA6WRAFdd0lXg==
X-Received: by 2002:a17:902:c944:b0:1d4:4a66:dace with SMTP id
 i4-20020a170902c94400b001d44a66dacemr9785864pla.10.1703810853371; 
 Thu, 28 Dec 2023 16:47:33 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 z3-20020a170902ee0300b001d3561680aasm14393949plb.82.2023.12.28.16.47.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 16:47:32 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: qemu-devel@nongnu.org
Subject: [v2 0/5] Add ISA extension smcntrpmf support 
Date: Thu, 28 Dec 2023 16:47:26 -0800
Message-Id: <20231229004731.3841550-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x62c.google.com
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


