Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA9E74EDE3
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 14:17:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJCGs-0001N9-Ny; Tue, 11 Jul 2023 08:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJCGj-0001MM-J7
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 08:15:02 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJCGh-000568-31
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 08:15:01 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2b6a084a34cso85669331fa.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 05:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689077696; x=1691669696;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s1/TjbYAfFSJ50EXdWkfI4zXmq+X44y5XBsdJS5iKns=;
 b=bfHdYVgiNYHqnQxm9VCTLYKJmeiZD490KXK4s77Ga9lAmXSBvxNAsaejbsVJDqu8Xw
 ACqmGhaQHdv4kOT3skYuVANws0Rg+UIqdQI6BmvvPrddv2SGJpuM6tFQRcyCr1eKbD/P
 yJwI7cAJOjnyIteY3WIw5iaUfv9I6dhAUqx7U821u7EeSZnDeBxAc48vEzeWXSML4Fbw
 XgUKBHR8HNUk5waaPNJ69O9WvQWWSB3tBjkMQ+1dUUy/djkpWt9NHYAvoEb12f+yUsSY
 ljkesHEN1bLa+880uEAsf86/Am7V+uay6E9oA9bS36Qe+Hi3HbcYddGzCrRVz2Vo4pIy
 FVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689077696; x=1691669696;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s1/TjbYAfFSJ50EXdWkfI4zXmq+X44y5XBsdJS5iKns=;
 b=kycpheNxteyF2PD3Ip1hWWEAfgy5l+yGtj/V+Y9uB4KlB1g8d6sEXr0ExEpE8SI5jG
 qke3AoWDUc8qt7WDB00rkOrGkSk+zwgvQUCnBjnjYqtUS9g3Mxw2S9h6sS0Bo5nx0gHh
 AWdTuR2ZpBvdkVJ/OvCAefSXNeptKVgLP1RBadoYwp8wv/kJUilfcZSL89oFlP1oXvCN
 JjKpbLaVLi4+nw3gUSKqZfIsY/czTLd+rDghXAQO3n1MwLaabrMIHR8N6FmDrXFBYQLm
 coP1Z8XZNUPRYIK388DbwKTB2Ox5bddtHG5ug6auhLtUcC7dTtHihJ2BNPaKOMkRgStM
 Qq9w==
X-Gm-Message-State: ABy/qLYpe2wwy/RgV5WDlrQvcCcxRSKmdpYa8eJSjalAhxwzvQ+3aqkx
 E07sxUQHUUENuTnOUmq9aJh4coF3exX631XiVqs=
X-Google-Smtp-Source: APBJJlE2cOqgCGsPe9bU4prJ2pKpJ/CKdIgtIjCIdFu1Om/Wg2aq9kHbCh+K6Zm5C37kTK7Olgz7Fg==
X-Received: by 2002:a2e:9807:0:b0:2b6:e2aa:8fc2 with SMTP id
 a7-20020a2e9807000000b002b6e2aa8fc2mr11593798ljj.46.1689077696411; 
 Tue, 11 Jul 2023 05:14:56 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a1709062e9000b00992ea405a79sm1072478eji.166.2023.07.11.05.14.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 05:14:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-8.2 v3 00/16] target/riscv: Allow building without TCG
 (KVM-only so far)
Date: Tue, 11 Jul 2023 14:14:37 +0200
Message-Id: <20230711121453.59138-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

v3: Rebased on master
    (commit 94d68c1136, merge tag 'pull-riscv-to-apply-20230710-1')

Philippe Mathieu-Daudé (16):
  target/riscv: Remove unuseful KVM stubs
  target/riscv: Remove unused 'instmap.h' header in translate.c
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

 target/riscv/cpu.h                            |   27 +-
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
 target/riscv/{ => sysemu}/kvm.c               |    4 +-
 target/riscv/{ => sysemu}/machine.c           |    0
 target/riscv/{ => sysemu}/monitor.c           |    0
 target/riscv/{ => sysemu}/pmp.c               |    0
 target/riscv/{ => sysemu}/pmu.c               |    0
 target/riscv/{ => sysemu}/riscv-qmp-cmds.c    |    0
 target/riscv/{ => sysemu}/time_helper.c       |    0
 target/riscv/{ => tcg}/bitmanip_helper.c      |    0
 target/riscv/tcg/cpu.c                        |   98 +
 target/riscv/{ => tcg}/crypto_helper.c        |    0
 target/riscv/{ => tcg}/fpu_helper.c           |    0
 target/riscv/{ => tcg}/m128_helper.c          |    0
 target/riscv/{ => tcg}/op_helper.c            |    0
 target/riscv/tcg/sysemu/cpu_helper.c          |  765 ++++++++
 target/riscv/tcg/sysemu/debug.c               |  165 ++
 target/riscv/tcg/tcg-stub.c                   |   31 +
 target/riscv/{ => tcg}/translate.c            |    1 -
 target/riscv/{ => tcg}/vector_helper.c        |    0
 target/riscv/{ => tcg}/zce_helper.c           |    0
 .gitlab-ci.d/crossbuilds.yml                  |    8 +
 target/riscv/meson.build                      |   33 +-
 target/riscv/sysemu/meson.build               |   13 +
 target/riscv/tcg/meson.build                  |   22 +
 target/riscv/tcg/sysemu/meson.build           |    4 +
 44 files changed, 2038 insertions(+), 1894 deletions(-)
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
 rename target/riscv/{ => sysemu}/kvm.c (99%)
 rename target/riscv/{ => sysemu}/machine.c (100%)
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


