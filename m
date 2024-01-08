Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 967478274EB
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 17:20:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMsLU-0003hd-Vy; Mon, 08 Jan 2024 11:19:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rMsLN-0003gx-Jw
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 11:19:18 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rMsLK-0007mD-Qm
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 11:19:16 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5cedfc32250so510517a12.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 08:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704730752; x=1705335552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NC8ZxDXMUOXKVvgPmJVKM8apS65XacC27+UbLDmLPLI=;
 b=Q9WmgPil7gN/C69OPaS+fAE3/kKJQ+fsNgow3J4MXsVAWO01soY/qYJmxpC8hOFrgN
 buRIAiV/75Pe0Mf03dHbpRODjDrM9H1qB+iLdh8lf1cn7EEL+THZovbMi/SYPQb4Pveg
 BeqqTIPHCZC85/0L5+rFNcdG9jk4Pj/6Xla5fxiPFYusRrKQj9NGb4KNNGyQfCcnojOd
 pgWlHIFehs87iQE+YOjQEsgb9dRjRldyu6fW400RFVqmpxkQxh+uzIbeCq4lDr/JVcVT
 +lD3YlXkm36cXriQua3QpoVBPU8bunTRA+PDmu3pqmwDiGM73Uv4cAMgeWpgRdliDfVM
 h5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704730752; x=1705335552;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NC8ZxDXMUOXKVvgPmJVKM8apS65XacC27+UbLDmLPLI=;
 b=GuWg+285zI+GIFuwAlD5Avuxgf/delXiBIWa4QvUOTJnCwepaPClz7DkBxDCYhFxvv
 usZr8L1GVNB2pcR30w5diKAE3qE0ZuAHOHWe+OceD8L5TJtQIjZPJSE5E5WnhrZgsLLZ
 4UDSzVj41ZHCK70ZGvc0LNRYtG2lTBmVH4cSnrcVe2bw2NeGBs/fs7zfm/0r5MXS28/Y
 FuEZNa+7e2XsjcxXoVg0V/FQKb+VKGfWi3RIx5C9McNsRXNEZa+rl/FRUKOqkvIyHffY
 oeuoqbzp21LTR1UkgcAbE+wrjlljiiXWJyqyb3Ktct3lagZXoX67CHsNcenQI9WFJ53k
 n9Bw==
X-Gm-Message-State: AOJu0Yy6aKADJn+pDovIxlvKXOlcABs7vDLjI+P8rNm1D8UbYAIwsb4t
 iXo3We97hYsQa2nOp9m1oClJZs43KgyFVtw3j4eKuYpPRlKsqA==
X-Google-Smtp-Source: AGHT+IEJt3fJc/NZqda1fLHxAfGp2GzESRzpW2eOiP8t8jaTwY/RtiuOeYs3Lc7ADupmeN4uob/qgg==
X-Received: by 2002:a05:6a20:6a2b:b0:199:3fde:1226 with SMTP id
 p43-20020a056a206a2b00b001993fde1226mr1506064pzk.46.1704730752602; 
 Mon, 08 Jan 2024 08:19:12 -0800 (PST)
Received: from grind.. ([189.79.22.11]) by smtp.gmail.com with ESMTPSA id
 b29-20020aa78edd000000b006db056542e6sm49151pfr.190.2024.01.08.08.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 08:19:12 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 0/2] riscv: add rv32i,rv32e and rv64e CPUs
Date: Mon,  8 Jan 2024 13:19:01 -0300
Message-ID: <20240108161903.353648-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52e.google.com
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

Hi,

This is the second version of a buried patch series:

"[PATCH for-9.0 0/6] riscv: rv32i,rv32e,rv64i and rv64e CPUs"

This version shrank to 2 patches since most of the prep work was already
done by the RVA22 profile implementation, which is now queued in
riscv-to-apply.next.

The motivation is the same as in v1 - give users a cleaner way of using
a customized CPU, from scratch, without the need to disable default
extensions.

Patches based on Alistair's riscv-to-apply.next.

Changes from v1:
- patches 1 to 4 from v1: dropped
- patches 5 and 6 from v1: merged into patch 2
- patch 1 (new):
  - add a new common cpu_init() for all bare CPUs
- v1 link: https://lore.kernel.org/qemu-riscv/20231113213904.185320-1-dbarboza@ventanamicro.com/


Daniel Henrique Barboza (2):
  target/riscv/cpu.c: add riscv_bare_cpu_init()
  target/riscv: add rv32i, rv32e and rv64e CPUs

 target/riscv/cpu-qom.h |  3 ++
 target/riscv/cpu.c     | 64 ++++++++++++++++++++++++++++++++----------
 2 files changed, 52 insertions(+), 15 deletions(-)

-- 
2.43.0


