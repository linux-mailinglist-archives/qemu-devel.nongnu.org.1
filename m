Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A96427DE6C4
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 21:43:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyI2d-0002UA-Ar; Wed, 01 Nov 2023 16:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyI2b-0002Ti-B6
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:42:17 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyI2Y-0000bW-Hn
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:42:17 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5ac376d311aso2939177b3.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 13:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698871332; x=1699476132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0tuh+QVmKUiTUBBeOik/56JX8nsRW6y5StGRSYdQKA4=;
 b=FNqEmwB0wvKqDeGrNkBBrFzjO44I2Opd4TzhaCIIV1tXGJRo6IvrN0/QJRFF8koXS1
 k4X+fog3HVvuKJiAS9t9Od9qnuDQKrYIHyVQ+L9hufve4wYxe/4gjh0NN9b1NdMPdGm5
 YoJNMnQHlETuvHc8jKdntUOw3G9IZ2ebN9b3ujAEjM4Na2npnpCG7LkXtfcupDxrA3+W
 P6pmmCkN/R0pnp5x5xKDPRnNJZi72TO3UW3QgX16a6BYnwnyB6VYiE0kpTuf8Yy/PQEC
 g/OafNNrYZoS5pG5J6iLLffOlrnJJ6jz7vXolF8F1Vf4KRFPtwSc9A+cykgcSMjxHTNc
 DSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698871332; x=1699476132;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0tuh+QVmKUiTUBBeOik/56JX8nsRW6y5StGRSYdQKA4=;
 b=Xx78vTeJR25ys/022J5YlrGie9TW58Lo0UCZ5C93tjEYrYL6AulMYFJklggZXVtjaP
 P8UerRix4m1SwvxX57TDiqJwOzlCyebwtT8Pq8gINn4RGEfKMA7pj80dhMUL1AB85hW7
 HQ9vLKCWwvf4ZipJ/jlQk6bjV0pveGkuAc0Mr0jPgl86fYJLINgjMQoNqWgcdd0NdSGk
 3CGZBJVO2UHNNh3njWvgg3xTYTAnLqu1G0zPaX6eSQhbohN7x7Rqn1UHo/i9y7BTelQE
 xIgifLnXNgd6tAwuIoKi19boVBfu9kN/gJld6LJ1O0JwwwCUaz5qz2zF1OZIvEWn3qtC
 gvpg==
X-Gm-Message-State: AOJu0YwCzKcgMh2MMBOgRFvS9XVmZlR6/MlcBeUuj0zJ/XGAUeQ1vkec
 jH3XlihEVAV8f7XgugDRAi6OWwx7VPvnoaMvd/s=
X-Google-Smtp-Source: AGHT+IGsvWOjyghEqyh4c3VjThVUi6R+9qVavo9X9fSa9+rpF8kRfhx6P1m0aYyZ9784UOV3fhI1JA==
X-Received: by 2002:a25:9805:0:b0:d9a:44fd:c72b with SMTP id
 a5-20020a259805000000b00d9a44fdc72bmr15976706ybo.13.1698871331698; 
 Wed, 01 Nov 2023 13:42:11 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 z187-20020a2533c4000000b00d9cc49edae9sm329724ybz.63.2023.11.01.13.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 13:42:11 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 00/19] rv64i CPU, RVA22U64 profile support
Date: Wed,  1 Nov 2023 17:41:45 -0300
Message-ID: <20231101204204.345470-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This v8 contains a few more extra, trivial changes, related to the
design of the rv64i.

We stripped away all its defaults, including priv_ver and satp mode.
Handling priv_ver was somewhat trivial: profiles and regular extensions
that are user set will now bump the CPU priv_ver if needed. This will
only affect rv64i since generic CPUs are already set to
PRIV_VERSION_LATEST and vendor CPUs does not allow extensions to be
enabled.

Dealing with satp_mode was trickier. First we need to fix the setter()
of satp user flags to allow users to set satp_max_supported of the CPU
if none was set. Then we need extra code during finalize() to handle an
assert that csr.c is throwing due to the lack of a satp_max_supported
value in the CPU. We could either set a default value or error out, and
decided to set a default value. Otherwise, when doing a rv64i CPU
introspection (e.g. query-cpu-model-expansion), we would be obligated to
set a satp mode, which is silly.

I intend to add a proper documentation on both rv64i and the overall
profile extension design. Since documentation can be done after the code
freeze let's wait for this to be merged first.

No other major changes made. Patches based on Alistair's
riscv-to-apply.next.

Patches missing acks: 3, 4, 5, 6

Changes from v7:
- patch 3 (new):
  - allow users to set satp max supported via user flags
- patch 4 (new):
  - set default satp mode max to MBARE during finalize
- patch 5 (new):
  - update update priv_ver on user_set extensions
- patch 6 (patch 3 from v7):
  - remove default priv_ver and satp values from rv64i_bare_cpu_init()
  - remove default values of zicntr and zihpm from rv64i_bare_cpu_init()
- patch 18 (patch 15 from v7):
  - do not check 'edata' in cpu_cfg_ext_get_name() loop
  - remove extra blank line
- v7 link: https://lore.kernel.org/qemu-riscv/20231031203916.197332-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (19):
  target/riscv: create TYPE_RISCV_VENDOR_CPU
  target/riscv/tcg: do not use "!generic" CPU checks
  target/riscv/cpu.c: set satp_max_supported in cpu_riscv_set_satp()
  target/riscv/cpu.c: set satp_mode_max MBARE during satp_finalize()
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

 hw/riscv/virt.c               |   5 +
 target/riscv/cpu-qom.h        |   3 +
 target/riscv/cpu.c            | 119 ++++++++++--
 target/riscv/cpu.h            |  13 ++
 target/riscv/cpu_cfg.h        |   3 +
 target/riscv/kvm/kvm-cpu.c    |   7 +-
 target/riscv/riscv-qmp-cmds.c |  44 ++++-
 target/riscv/tcg/tcg-cpu.c    | 341 +++++++++++++++++++++++++++++-----
 8 files changed, 473 insertions(+), 62 deletions(-)

-- 
2.41.0


