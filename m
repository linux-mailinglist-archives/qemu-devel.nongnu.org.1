Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A724A7DA5FF
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 10:56:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwf5c-0000Gh-Nf; Sat, 28 Oct 2023 04:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qwf5b-0000GY-2V
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 04:54:39 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qwf5Z-00047N-6c
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 04:54:38 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5ae143e08b1so22271697b3.1
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 01:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698483275; x=1699088075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vj4UWLD5YoaP1OKxtY1paMMCFolm4zk1m2RwxekA3Oo=;
 b=EzX0Y1VxP6+m+5zTCfiLlPtakg0gXiiksTpvEJksLwfwObzFyEC2hLTJBexjWCJ0Kw
 Q2EQgjr3mAd98lW785GNMdrsx6D2z+CsbJFfNLmhnpxYHLR9LOdqIUPeqdiCjx81Ua+6
 WczaNR0h+WvLDz0U+67228ZMI4E0lBa8EfAmjiayusPBYCMsNYcoFnM0FEWSMAR7RZkK
 qpAToO3uWjhPJkvWcRI7kV57AIWLMom99+fj8FODth9+K+TeLytOk43KEB5V0s0EQRSM
 YpQ+RETw8hmkwNGnrc6UmTcc+oIE4fWheXJLpEyuffMdE++79fT12MvDCP8+hBZBWjGB
 IcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698483275; x=1699088075;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vj4UWLD5YoaP1OKxtY1paMMCFolm4zk1m2RwxekA3Oo=;
 b=RSICGJz7kRuNSQiGY5KeMTRmLue3H24jTp5f4eaLoZfJkvv4Vyh+Ufz/MGdpmTRHY6
 yVnHWQqhnSQZYrWgzUltEKLqITJJcNZWuo/BMUgpiJCjzf1lfMFgjl+U3g8XdUmGEb69
 v8qWRvzpMS3QJ2BaIRfYaEEGolWOgGIN34jkaiZ17MrWNdwToBj99NYWGSxbsU9L531y
 3UJw2UP+NHxSR7X7kyFIl/q73cBYO+1l/sWSHlWOd9Rs4bCi5+4yN/rZpOCTK90g8wN/
 pAlsCluPjEQ/Ku5eYb9EzsYFVhOpOZjVsn841bREzkLtftcbonbxSMpqrWZEX4vDd0EV
 hGVQ==
X-Gm-Message-State: AOJu0Yy2TxhnmAesuYkuymxqpt8x8gy/br14MHAdbnve/20ygmSBt4rk
 ay40FG9ot88ry18Wi58fuc5pyDiC9pmrzp7lTrA=
X-Google-Smtp-Source: AGHT+IESkMQ1rJH9lJqdGcopGR7sLrxePhq8cl15nowajB1D4mqkGnelUxyO+eUuIMQsKX2fETcX3g==
X-Received: by 2002:a05:690c:f0c:b0:573:30c8:6e1d with SMTP id
 dc12-20020a05690c0f0c00b0057330c86e1dmr6686493ywb.44.1698483274795; 
 Sat, 28 Oct 2023 01:54:34 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([191.255.2.33])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a81830f000000b00594fff48796sm1604325ywf.75.2023.10.28.01.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 01:54:34 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 00/12] RVA22U64 profile support
Date: Sat, 28 Oct 2023 05:54:15 -0300
Message-ID: <20231028085427.707060-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1134.google.com
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

Based-on: 20231023153927.435083-1-dbarboza@ventanamicro.com
("[PATCH v3 0/4] riscv: zicntr/zihpm flags and disable support")

Hi,

This version has several changes proposed by Drew in v5 and a design
change after a discussion we have in the v3 review [1].

Notable changes:

- zicbop extension flag is added (patch 1). Given that this is an actual
  extension, not a 'named feature', and we already implement is as a
  no-op, we're adding the flag to make our riscv,isa compliant with what
  the profile mandates;

- zic64b is no longer an user flag. zic64b is a named extension, a
  glorified way of telling that we're using 64 byte cache blocks. Users
  can indirectly set it to true/false by simply editing
  cbo{m,p,z}_blocksize;

- zic64b, an all future named extensions, are now exposed in
  query-cpu-model-expansion (patch 3);

- marking a profile as 'false' in the command line no longer disables
  its mandatory extensions in the CPU. Since profile flags are disabled
  by default in all current CPUs, setting 'rva22u64=false' will cause no
  change of state in the CPU, i.e. it'll do nothing. This is the same
  mechanic that RVG already uses and we'll make profiles behave the same
  way. We'll not "be creative" and interpret a 'false' from the command
  line mean something different than the existing 'false'. If we want a
  way to mass disable CPU extensions we can implement cleaner ways of
  doing it. See [1] for even more context/rant about the previous design
  and why we're changing it.

Patches based on top of:

[PATCH v3 0/4] riscv: zicntr/zihpm flags and disable support

Patches missing acks: patches 1,2,3

Changes from v5:
- patch 1 (new):
  - add zicbop extension flag
- patch 2 (patch 1 from v5):
  - zic64b no longer exposed as user flag, no longer throwing user warnings
- patch 3 (new):
  - change query-cpu-model-expansion to include named extensions like zic64b
- patch 4 (patch 2 from v5):
  - remove extra whitespace in profile description comment
  - added "(nor for zic64b, despite it having a cfg offset)" in the profile description comment
  - moved 'NULL' to its own line  in riscv_profiles[]
  - added 'zicbop' as a mandatory profile extension
- patch 6 (patch 4 from v5):
  - add 64 bit CPU restriction for profiles
  - marking a profile as 'false' no longer removes all the mandatory extensions of the CPU model,
    making it compatible with what RVG does:
      profileA=true means "enable all mandatory extensions of profileA"
      profileA=false means "do not enable all mandatory extensions of profileA"
- v5 link: https://lore.kernel.org/qemu-riscv/20231025234459.581697-1-dbarboza@ventanamicro.com/

[1] https://lore.kernel.org/qemu-riscv/e3f53179-7f7e-42a9-8a13-a81bf1beeb89@ventanamicro.com/

Daniel Henrique Barboza (12):
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
  target/riscv/tcg: warn if profile exts are disabled

 hw/riscv/virt.c               |   5 +
 target/riscv/cpu.c            |  48 +++++-
 target/riscv/cpu.h            |  15 ++
 target/riscv/cpu_cfg.h        |   3 +
 target/riscv/kvm/kvm-cpu.c    |   7 +-
 target/riscv/riscv-qmp-cmds.c |  30 +++-
 target/riscv/tcg/tcg-cpu.c    | 277 ++++++++++++++++++++++++++++------
 7 files changed, 335 insertions(+), 50 deletions(-)

-- 
2.41.0


