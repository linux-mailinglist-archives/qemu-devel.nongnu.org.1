Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 210187DD728
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 21:40:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxvWS-0005ED-Kr; Tue, 31 Oct 2023 16:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxvWQ-0005DH-M0
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 16:39:34 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxvWF-0007K5-IC
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 16:39:34 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5ae143e08b1so59113387b3.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 13:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698784762; x=1699389562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y9f6UBOfFYhoxaLW4bNV81fgl1x5hThdYpOBUgpw5uw=;
 b=DvaC/eeZZCx/54+eSasWg9UMOf7ecOGn8+OGMJ/3yyJDuYNGy4WKY68QcLLoncOA9J
 sq1iMzDi37qJGLPJSNFY1RP0derxes+zWbHui4gi8ZX5G1L/JFG+0Cg8bhPWcrUnqWv4
 09CSThyOJOZLCm7IH4j+IvKIiHk24spAQMQmIiPUpA7uvw2pS/Kr/3OLgO0nGbXfskYG
 mAasopumw7fcqB2wqyKUb2KhQD0C0JPUcmtxG8z5qlciShLzVOqHdnCobFlRlV1LZY+p
 TZU611N92YnNoQj5zpAtMKvMHN+5FqfNDb4yw40r4f057W3tXJpESZnWukFDOKDiqPfi
 ggqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698784762; x=1699389562;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y9f6UBOfFYhoxaLW4bNV81fgl1x5hThdYpOBUgpw5uw=;
 b=I57MVjxfkgK/DV8pMgLXgFcGTKae4tOGcdrZm7NGA9V2fEkTzQURwoMWpMB0PRZrl8
 lxPfpIFttSUel4ZjoovM1RM+phTeAl3OcRaZwt8ObL0TcSDYCTlCGTPrZ4nFjdIAs3WQ
 MT6fX2jE06n9EjxkypLDFPbnr7a3jXG5iQT3+zTx5Iwem4ozl32wl3UaA/WOl6IjjsQJ
 293PXpSJwO43xsd1qyyBG9dvN85BgsIzWwGUQL27DYWwCHpamFU16R2e+40acvYOOHOE
 lNPyhkxzQZf5kC24qssJrJbZKRyqtWxtsvVlL+sWeEL97Jbn/jItrUi+Qy+7l+EVUuuJ
 fn0Q==
X-Gm-Message-State: AOJu0YxCSKBPYK3Y1mAp6xWQy0Zi9e2zbqGEo1rErLi2qMp3Jepf9WB9
 WCw3SI/HOQ0qR20ZHXfz+dTSX3gqNnI3e0fGpwM=
X-Google-Smtp-Source: AGHT+IFAQwBqPXcA9CFGNl2JRX+cJ7G8d0j0UZUYd1NzhYAAXswgKTV19i8L5/kUoAff/FMnRO34Kw==
X-Received: by 2002:a81:ae62:0:b0:5a7:a959:337 with SMTP id
 g34-20020a81ae62000000b005a7a9590337mr14664042ywk.27.1698784761733; 
 Tue, 31 Oct 2023 13:39:21 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 k1-20020a81ff01000000b005add997ae53sm1272802ywn.81.2023.10.31.13.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 13:39:21 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v7 00/16] rv64i CPU, RVA22U64 profile support
Date: Tue, 31 Oct 2023 17:39:00 -0300
Message-ID: <20231031203916.197332-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi,

As discussed in v6, all our problems with the profile implementation
cames from the rv64 CPU and how to deal with its defaults. Enabling a
profile on top of it is straightforward, but disabling it (either via a
script trying to undo a profile enablement, or users doing something
silly) makes things complicated - disabling all the mandatory extensions
will overwrite the CPU defaults, but doing nothing is weird considering
how QEMU options work. And therein lies the rub: we didn't have any
other way of consuming profiles, so we were stuck dancing around rv64
defaults and what to do with them.

In this v7 we're adding a new CPU called 'rv64i'. This is a new type of
CPUs, called 'bare', that doesn't inherit any defaults and allows users
to enable/disable extensions at will. This CPU is implementing bare
RV64I for a reason: this is the mandatory ISA for profiles support.

All the design around profile support is now made on top of how rv64i
works.  Other non-vendor CPUs (like rv64) can still use profiles, but
now we're not concerned about what happens if an user does '-cpu
rv64,rva22u64=false'. In short, we recommend using profiles with rv64i
but we won't forbid using it with rv64 (in particular because stock rv64
does not implement rva22u64, which is surprising giving it has a lot of
defaults ...). Patches 1, 2 and 3 implements rv64i. 

Another noticeable change was made in patches 15 and 16. We're now
exposing the profile flag to all CPUs. In the end a profile is just a
set of mandatory extensions and conditions that must be met. If the
conditions are met we should enable the flag, regardless of user input.
This is done by changes in patch 15. Patch 16 changes
query-cpu-model-expansion to show profile flags.

Patches based on top of Alistair's riscv-to-apply.next.

Patches missing acks: 1, 2, 3, 5, 15, 16

Changes from v6:
- patch 1 (new):
  - create vendor CPU type
- patch 2 (new):
  - check for 'if vendorCPU' instead of 'if !genericCPU'
- patch 3 (new):
  - add rv64i CPU
- patch 5 (former patch 2 from v6):
  - drop the CB_DEF_VALUE define
- patch 6 (fomer patch 3 from v6):
  - mention cbop block size in commit msg
- patch 9 (former patch 6 from v6):
  - removed the "no-op" when disabling a profile
  - rewrote the commit msg to reflect that the design is made on top of the rv64i CPU
- patch 12 (fomer patch 9 from v6):
  - do not disable RVI when disabling a profile
- patch 15 (patch 12 from v6):
  - previous acks revoked due to the amount of changes made
  - disable profile flags if there are missing mandatory extensions during finalize()
  - enable profile flags if all its preconditions are met during
    finalize()
- patch 16 (new):
  - add profile flags to query-cpu-model-expansion
- v6 link: https://lore.kernel.org/qemu-riscv/20231028085427.707060-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (16):
  target/riscv: create TYPE_RISCV_VENDOR_CPU
  target/riscv/tcg: do not use "!generic" CPU checks
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

 hw/riscv/virt.c               |   5 +
 target/riscv/cpu-qom.h        |   3 +
 target/riscv/cpu.c            |  96 ++++++++++-
 target/riscv/cpu.h            |  13 ++
 target/riscv/cpu_cfg.h        |   3 +
 target/riscv/kvm/kvm-cpu.c    |   7 +-
 target/riscv/riscv-qmp-cmds.c |  44 ++++-
 target/riscv/tcg/tcg-cpu.c    | 301 +++++++++++++++++++++++++++++-----
 8 files changed, 412 insertions(+), 60 deletions(-)

-- 
2.41.0


