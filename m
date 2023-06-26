Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C84673EF26
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 01:22:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDvVW-0004aH-3S; Mon, 26 Jun 2023 19:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDvVJ-0004Ys-NX
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 19:20:21 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDvVH-0008Bm-26
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 19:20:17 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-98df3dea907so348893166b.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 16:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687821611; x=1690413611;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wv9Tq5llbl/sjP52djumXiDvzm3itZBu/GStUzP7o5Y=;
 b=Na1hPYzB8PgQSQ40PeilqNmyYUXY1NeW0ffvN9IpsQ89e1gH1bZoEDZwVM4iZmE0DV
 y8XPg9jQUfgQFWE+Su2SWViRR+HbLZJqx6UUg1BD5VUJG3xL58gIXqEKlBIBjBk+z17K
 fGPufHaraI42OwOSVoQ7IemNSAjPH2dkEncwRw4cAE5bmBQFoJ9ik3JE/UzjYpx6LI/L
 /XXY+3YZx7OIeDUBuu51n9mj8xE6t4p7ezlkrkBewMrMPO1W+sU+d0HitD6Ci37f/vr1
 2Kpm5CVyuxmw83+Ix00+1sWfYAmhbcqt40DSUwhspdB5A1+Ihb4BtBkZ73VAYMZEeige
 VgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687821611; x=1690413611;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wv9Tq5llbl/sjP52djumXiDvzm3itZBu/GStUzP7o5Y=;
 b=Q/bg1m//hbyKkf8TE5zdTGF/H6Ypmnj7BwgS3oIw80tXz+kD/Badof1kiDS57gQLbT
 e10SutFIzXxB+8JS2Q7K/BmD2drrxKUHBuIXoqtZq1ZMdtN383+ZOYXHSOxdD/eawiOH
 gehqQsKdL2JlIj00RCRSq8+nr4bMu0DKty5+p1o+rTmB2xPXRR0fWmpbCtVUcaNwZYqv
 u9qNo1xUuLdzFU/I7HDnbyKFjj6ED9Rg8Q96jkuKetmmvOmRK6FcroysW0bmbkNyw4aM
 f2q4smQKlOnBOB25a2H07sCZ2IZ+ZH0vzCIXvjssOTWNoaJgd3IZuqBPXMuCdEVZRCBY
 zeFw==
X-Gm-Message-State: AC+VfDz8ZHTNHy4eBRMa4+wbx9PN7WzxFRhJ4s4Cj0l7Br6sxJ5xAEq8
 K+Gc+2VvFS4WhErzNNu454tQ/oUTXNoBaodJi0M=
X-Google-Smtp-Source: ACHHUZ7FKhx9jL0e3rcwBXPfHjgjyNhrauyvegSoZM4UDZzPaP1LL1cn7TBke9uCBg/D/LFZ7f7suQ==
X-Received: by 2002:a17:907:368c:b0:982:2586:f85 with SMTP id
 bi12-20020a170907368c00b0098225860f85mr25253076ejc.65.1687821610863; 
 Mon, 26 Jun 2023 16:20:10 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.226])
 by smtp.gmail.com with ESMTPSA id
 ck18-20020a170906c45200b0098e38d2e584sm2599001ejb.43.2023.06.26.16.20.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Jun 2023 16:20:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, qemu-riscv@nongnu.org
Subject: [PATCH 00/16] target/riscv: Allow building without TCG (KVM-only so
 far)
Date: Tue, 27 Jun 2023 01:19:51 +0200
Message-Id: <20230626232007.8933-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

this series reorder TCG specific code in order to easily
build a KVM-only binary. sysemu specific code is also
moved around, to help noticing invalid uses from user
emulation. Last patch adds a new job to our CI to avoid
this to bitrot.

Please review,

Phil.

Philippe Mathieu-Daudé (16):
  target/riscv: Remove unused 'instmap.h' header in translate.c
  target/riscv: Restrict KVM-specific fields from ArchCPU
  target/riscv: Restrict sysemu specific header to user emulation
  target/riscv: Restrict 'rv128' machine to TCG accelerator
  target/riscv: Move sysemu-specific files to target/riscv/sysemu/
  target/riscv: Restrict riscv_cpu_do_interrupt() to sysemu
  target/riscv: Move TCG-specific files to target/riscv/tcg/
  target/riscv: Move TCG-specific cpu_get_tb_cpu_state() to tcg/cpu.c
  target/riscv: Expose some 'trigger' prototypes from debug.c
  target/riscv: Extract TCG-specific code from debug.c
  target/riscv: Move sysemu-specific debug files to target/riscv/sysemu/
  target/riscv: Expose riscv_cpu_pending_to_irq() from cpu_helper.c
  target/riscv: Move TCG/sysemu-specific code to tcg/sysemu/cpu_helper.c
  target/riscv: Move sysemu-specific code to sysemu/cpu_helper.c
  target/riscv: Restrict TCG-specific prototype declarations
  gitlab-ci.d/crossbuilds: Add KVM riscv64 cross-build jobs

 target/riscv/cpu.h                            |   29 +-
 target/riscv/internals.h                      |    4 +
 target/riscv/{ => sysemu}/debug.h             |    6 +
 target/riscv/{ => sysemu}/instmap.h           |    0
 target/riscv/{ => sysemu}/kvm_riscv.h         |    0
 target/riscv/{ => sysemu}/pmp.h               |    0
 target/riscv/{ => sysemu}/pmu.h               |    0
 target/riscv/{ => sysemu}/time_helper.h       |    0
 target/riscv/{ => tcg}/XVentanaCondOps.decode |    0
 target/riscv/{ => tcg}/insn16.decode          |    0
 target/riscv/{ => tcg}/insn32.decode          |    0
 target/riscv/{ => tcg}/xthead.decode          |    0
 hw/riscv/virt.c                               |    2 +-
 target/riscv/cpu.c                            |   35 +-
 target/riscv/cpu_helper.c                     | 1692 +----------------
 target/riscv/csr.c                            |    6 +-
 target/riscv/{ => sysemu}/arch_dump.c         |    0
 target/riscv/sysemu/cpu_helper.c              |  863 +++++++++
 target/riscv/{ => sysemu}/debug.c             |  153 +-
 target/riscv/{ => sysemu}/kvm-stub.c          |    0
 target/riscv/{ => sysemu}/kvm.c               |    0
 target/riscv/{ => sysemu}/machine.c           |    8 +-
 target/riscv/{ => sysemu}/monitor.c           |    0
 target/riscv/{ => sysemu}/pmp.c               |    0
 target/riscv/{ => sysemu}/pmu.c               |    0
 target/riscv/{ => sysemu}/riscv-qmp-cmds.c    |    0
 target/riscv/{ => sysemu}/time_helper.c       |    0
 target/riscv/{ => tcg}/bitmanip_helper.c      |    0
 target/riscv/tcg/cpu.c                        |   97 +
 target/riscv/{ => tcg}/crypto_helper.c        |    0
 target/riscv/{ => tcg}/fpu_helper.c           |    0
 target/riscv/{ => tcg}/m128_helper.c          |    0
 target/riscv/{ => tcg}/op_helper.c            |    0
 target/riscv/tcg/sysemu/cpu_helper.c          |  766 ++++++++
 target/riscv/tcg/sysemu/debug.c               |  165 ++
 target/riscv/tcg/tcg-stub.c                   |   31 +
 target/riscv/{ => tcg}/translate.c            |    1 -
 target/riscv/{ => tcg}/vector_helper.c        |    0
 target/riscv/{ => tcg}/zce_helper.c           |    0
 .gitlab-ci.d/crossbuilds.yml                  |    8 +
 target/riscv/meson.build                      |   33 +-
 target/riscv/sysemu/meson.build               |   14 +
 target/riscv/tcg/meson.build                  |   22 +
 target/riscv/tcg/sysemu/meson.build           |    4 +
 44 files changed, 2046 insertions(+), 1893 deletions(-)
 rename target/riscv/{ => sysemu}/debug.h (96%)
 rename target/riscv/{ => sysemu}/instmap.h (100%)
 rename target/riscv/{ => sysemu}/kvm_riscv.h (100%)
 rename target/riscv/{ => sysemu}/pmp.h (100%)
 rename target/riscv/{ => sysemu}/pmu.h (100%)
 rename target/riscv/{ => sysemu}/time_helper.h (100%)
 rename target/riscv/{ => tcg}/XVentanaCondOps.decode (100%)
 rename target/riscv/{ => tcg}/insn16.decode (100%)
 rename target/riscv/{ => tcg}/insn32.decode (100%)
 rename target/riscv/{ => tcg}/xthead.decode (100%)
 rename target/riscv/{ => sysemu}/arch_dump.c (100%)
 create mode 100644 target/riscv/sysemu/cpu_helper.c
 rename target/riscv/{ => sysemu}/debug.c (83%)
 rename target/riscv/{ => sysemu}/kvm-stub.c (100%)
 rename target/riscv/{ => sysemu}/kvm.c (100%)
 rename target/riscv/{ => sysemu}/machine.c (98%)
 rename target/riscv/{ => sysemu}/monitor.c (100%)
 rename target/riscv/{ => sysemu}/pmp.c (100%)
 rename target/riscv/{ => sysemu}/pmu.c (100%)
 rename target/riscv/{ => sysemu}/riscv-qmp-cmds.c (100%)
 rename target/riscv/{ => sysemu}/time_helper.c (100%)
 rename target/riscv/{ => tcg}/bitmanip_helper.c (100%)
 create mode 100644 target/riscv/tcg/cpu.c
 rename target/riscv/{ => tcg}/crypto_helper.c (100%)
 rename target/riscv/{ => tcg}/fpu_helper.c (100%)
 rename target/riscv/{ => tcg}/m128_helper.c (100%)
 rename target/riscv/{ => tcg}/op_helper.c (100%)
 create mode 100644 target/riscv/tcg/sysemu/cpu_helper.c
 create mode 100644 target/riscv/tcg/sysemu/debug.c
 create mode 100644 target/riscv/tcg/tcg-stub.c
 rename target/riscv/{ => tcg}/translate.c (99%)
 rename target/riscv/{ => tcg}/vector_helper.c (100%)
 rename target/riscv/{ => tcg}/zce_helper.c (100%)
 create mode 100644 target/riscv/sysemu/meson.build
 create mode 100644 target/riscv/tcg/meson.build
 create mode 100644 target/riscv/tcg/sysemu/meson.build

-- 
2.38.1


