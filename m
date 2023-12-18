Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AC9816F33
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 14:01:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFD86-0002Y2-5P; Mon, 18 Dec 2023 07:53:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD84-0002Xk-N0
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:53:52 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD81-0004oK-0E
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:53:51 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d2e6e14865so10376835ad.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 04:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702904026; x=1703508826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LpMJQ+/cgJo00rJY1/O13ZEMaIV4JJ4lfLy+owWo5iM=;
 b=nogELr2xYsIfBUM/iIYW4NVyws1NrBr70FD9ap1oNOjrx3K8yyh+d3MHLmYzZzUSXo
 f+WlAPrtE3JgceHk8RjfygNCheoXaMx/KLEvFV+09hh/y7NFuzeCrz3kC5DNfxvmAlZ+
 CoZLJYVnR/NZTUMn0bAU2EK7/cRVHCsgRV7fq3oW2rdmHA0dE+J+agoDYdtX1g2R9/kX
 ywHXv2wg7uOibuv3nfuJ8v5GooSC3aHE+f0I8VbAenySyi9rUI3kUADF6AaxJNjdGL4a
 Je6y5WH2+w9mIwlLGmOOupZB0CLd1oe/uHj+mhoY4oVSTT6mXqlwPFmRCvF5nDdPmsOT
 1wqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702904026; x=1703508826;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LpMJQ+/cgJo00rJY1/O13ZEMaIV4JJ4lfLy+owWo5iM=;
 b=dtyLvbpmToTKkf9EPb35ek+iCHWEEjbTFL4PyxF4lDjPQMA8BYHWD56kEypUZswwPg
 VePKGlkcAJ1svA0vc7eGcYKVHKc85HYA+897/eUyyvZaxgGpS/yHLEUGXLSYDBk1/Q5k
 lrlZuLp3ydvp6OXHFuLKPPBD1SKOi/bCmtD8QtY1F2BlSutAFWzZgqt3Pop0O18BYSgB
 VFJ5uNuabuk2V03RfO3ORreYaveTvZgeO3vre++0EqAoLENSCrGepCZj5kF8igiKVYG9
 XZK+XoM2gH45lgOmn4+82IXhUdbYEnLzi7i6EBBJ4HFa4M7f1e56hYyWjag0HZt3qtMd
 PxcQ==
X-Gm-Message-State: AOJu0Yw/mqFliVfCslsVYus290timrBMXvr2aQA1eEK5yJlgiPAshwCR
 yITxqRzo/Tv3VUdok7Cgu/1C7/BsqYY8bR8HQhc=
X-Google-Smtp-Source: AGHT+IGY6EAOB1V1Qe5cP7Qtq0xhREAgZ/OWFxnNEqYifbPulL3JmxziVhHrWahMjq7mAwLLJfaoOw==
X-Received: by 2002:a17:903:189:b0:1d2:ffba:2d47 with SMTP id
 z9-20020a170903018900b001d2ffba2d47mr8923401plg.77.1702904026314; 
 Mon, 18 Dec 2023 04:53:46 -0800 (PST)
Received: from grind.. ([179.93.21.205]) by smtp.gmail.com with ESMTPSA id
 c2-20020a170902848200b001d09c539c96sm7494897plo.229.2023.12.18.04.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 04:53:45 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v13 00/26] riscv: RVA22 profiles support
Date: Mon, 18 Dec 2023 09:53:08 -0300
Message-ID: <20231218125334.37184-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
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

This is a merge of the two profile series:

"[PATCH for-9.0 v12 00/18] riscv: rv64i/rva22u64 CPUs, RVA22U64 profile support"
"[PATCH for-9.0 v2 0/8] target/riscv: implement RVA22S64 profile"

I'm sending them together since the second series is dependent on the first.

Quick summary of the major features added:

- A new rv64i CPU type. This is a CPU that has only RVI enabled;

- 'rva22u64' and 'rva22s64' profile flags. They were designed to be used
  with the 'rv64i' CPU but can be used with other generic CPUs like
  rv64;

- Two new profile CPUs: 'rva22u64' and 'rva22s64'. A profile CPU is an
  alias of '-cpu rv64,profile=on' and it's the most convenient way of
  using profiles. E.g to launch an rva22s64 'virt' machine:

  ./qemu-system-riscv64 -M virt -cpu rva22s64  (...)

  To test an application with an rva22u64 profile with linux-user mode:

  ./qemu-riscv64 -cpu rva22u64  (...)


The series can also be fetch via:

https://gitlab.com/danielhb/qemu/-/tree/rva22_v13

Patches rebased on top of Alistair riscv-to-apply.next.

All patches acked.

Daniel Henrique Barboza (26):
  target/riscv: create TYPE_RISCV_VENDOR_CPU
  target/riscv/tcg: do not use "!generic" CPU checks
  target/riscv/tcg: update priv_ver on user_set extensions
  target/riscv: add rv64i CPU
  target/riscv: add zicbop extension flag
  target/riscv/tcg: add 'zic64b' support
  riscv-qmp-cmds.c: expose named features in cpu_model_expansion
  target/riscv: add rva22u64 profile definition
  target/riscv/kvm: add 'rva22u64' flag as unavailable
  target/riscv/tcg: add user flag for profile support
  target/riscv/tcg: add MISA user options hash
  target/riscv/tcg: add riscv_cpu_write_misa_bit()
  target/riscv/tcg: handle profile MISA bits
  target/riscv/tcg: add hash table insert helpers
  target/riscv/tcg: honor user choice for G MISA bits
  target/riscv/tcg: validate profiles during finalize
  riscv-qmp-cmds.c: add profile flags in cpu-model-expansion
  target/riscv: add 'rva22u64' CPU
  target/riscv: implement svade
  target/riscv: add priv ver restriction to profiles
  target/riscv/cpu.c: finalize satp_mode earlier
  target/riscv/cpu.c: add riscv_cpu_is_32bit()
  target/riscv: add satp_mode profile support
  target/riscv: add 'parent' in profile description
  target/riscv: add RVA22S64 profile
  target/riscv: add rva22s64 cpu

 hw/riscv/virt.c               |   5 +
 target/riscv/cpu-qom.h        |   5 +
 target/riscv/cpu.c            | 201 +++++++++++++--
 target/riscv/cpu.h            |  18 ++
 target/riscv/cpu_cfg.h        |   4 +
 target/riscv/kvm/kvm-cpu.c    |   7 +-
 target/riscv/riscv-qmp-cmds.c |  44 +++-
 target/riscv/tcg/tcg-cpu.c    | 450 +++++++++++++++++++++++++++++++---
 8 files changed, 672 insertions(+), 62 deletions(-)

-- 
2.43.0


