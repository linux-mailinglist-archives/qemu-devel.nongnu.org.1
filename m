Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9A7758CC6
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 06:47:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLz4W-0001mr-BS; Wed, 19 Jul 2023 00:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qLz4S-0001ma-GG
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 00:45:52 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qLz4Q-0005KE-RT
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 00:45:52 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6689430d803so4384992b3a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 21:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689741949; x=1692333949;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eqUBA9KavkLdfLQfx5f9WyxMtLTmK6jJxN80LQjiiVg=;
 b=b7yeZe5Zm45TcJIqGQIVrPH3Wg0X/pTjnR7pLdjKYbR6hAJBX825f2fqZk0TS0m4Tw
 GXeg4hdwOZ27FmgYbdJwt6V6fgOlFHlc6He0YLbexOsnpwHxS83ew7S6lWjV/oA/DdeX
 GnRNjcohoT7TnJx0WVN25mIioifaQ4GMK4qTz7dKQyhLkZbgGMS1aYX15/8hKejB3oR/
 VS9Y6sZkBO2yfAZxW1xYzUWCfPjJ+BMhO0zTPy7nCBKYEWwlxmGjUEpEg5DmaT7Gzg6z
 4u+3oCIj8InVo09lv/S6lpPJub5zEiVr4E2E72MFhkn20kuXRitnkZuEKGE4ZeuxEf3P
 nBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689741949; x=1692333949;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eqUBA9KavkLdfLQfx5f9WyxMtLTmK6jJxN80LQjiiVg=;
 b=TQ8SRL7Ao+qNkuDV0DWYLlw5cXXKb1o8ef3dXaFQZyxs0xeXJyNeU93o1uPyukkqTD
 JePGwzTs9Jurc6zD8FFu7W+QMa6IDXFJOV23Kv4ChC6F1UWo5OggUbrFgSuv9ys6iV9k
 XEX+0pONlLi2jk6ySHawQjhg+q/5ZVWtQm4c20PR6NF/qGDxN/L5vJYWJzOZ9sKQyA3q
 NilutG77NZvwkGX5sIdebipgsuh1XCcemQDLAohBbvOaK5bji94HOcvXQ6bh+/d1lavo
 dnPTgnGGoRNsASCagmzDhYJMgr1fr+DIpOXFoD2tHhxW6mJkrhz/4fdY3EFyLr9sIYLg
 b6oA==
X-Gm-Message-State: ABy/qLY4MEEiCyMQya7ODjBoyNGCz4K+5nPBeXet6//1nI4wxrKw2sdS
 oCRWxSNFmYPDlw7Q2W45GsvreJGa4ElePpqV
X-Google-Smtp-Source: APBJJlFXkdZK2brniWEggUPfySZYg0hkT3RCCksQVaI51+t6tglVJou0ksLNTmOPG210+Xzugg4M9g==
X-Received: by 2002:a05:6a20:3246:b0:12d:a04c:7e8b with SMTP id
 hm6-20020a056a20324600b0012da04c7e8bmr977982pzc.40.1689741948558; 
 Tue, 18 Jul 2023 21:45:48 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001b890009634sm2731080plh.139.2023.07.18.21.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 21:45:47 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 0/5] riscv-to-apply queue
Date: Wed, 19 Jul 2023 14:45:33 +1000
Message-Id: <20230719044538.2013401-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
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

The following changes since commit 361d5397355276e3007825cc17217c1e4d4320f7:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-07-17 15:49:27 +0100)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20230719-1

for you to fetch changes up to 32be32509987fbe42cf5c2fd3cea3c2ad6eae179:

  target/riscv: Fix LMUL check to use VLEN (2023-07-19 14:37:26 +1000)

----------------------------------------------------------------
Fourth RISC-V PR for 8.1

* Fix LMUL check to use VLEN
* Fix typo field in NUMA error_report
* check priv_ver before auto-enable zca/zcd/zcf
* Fix disas output of upper immediates
* tidy CPU firmware section

----------------------------------------------------------------
Christoph Müllner (1):
      riscv/disas: Fix disas output of upper immediates

Daniel Henrique Barboza (2):
      docs/system/target-riscv.rst: tidy CPU firmware section
      target/riscv/cpu.c: check priv_ver before auto-enable zca/zcd/zcf

Rob Bradford (1):
      target/riscv: Fix LMUL check to use VLEN

Zhao Liu (1):
      hw/riscv: Fix typo field in error_report

 docs/system/target-riscv.rst | 24 ++++++++++++++++--------
 disas/riscv.h                |  2 ++
 disas/riscv.c                | 19 ++++++++++++++++---
 hw/riscv/numa.c              |  4 ++--
 target/riscv/cpu.c           |  3 ++-
 target/riscv/vector_helper.c |  4 ++--
 6 files changed, 40 insertions(+), 16 deletions(-)

