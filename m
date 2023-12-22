Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 465E981C9D5
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 13:23:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGeYF-0001W9-LZ; Fri, 22 Dec 2023 07:22:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGeYD-0001VO-UL
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 07:22:49 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGeY7-0005m4-4h
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 07:22:49 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6d93278bfbeso1136943b3a.3
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 04:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1703247761; x=1703852561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yy17GAX+dhVN3LfZ5BcAmjluYdS7Pglp6Hw9dnl9U8E=;
 b=T+3Pw78t9x/4aUkk3q25/egSVs7HROs4gQaUp5hxVaaIm9p81q+bpTEUBR2E/xsWUT
 LQC4xQkr8Mwxun7JNjuRyptp9puuN1jRalS2XeQPFkwZ9d5I43BaNYGQPxBKu4ohW7bp
 GScbjEM/S7jfn7s0PmndcznTN1N9ryrqWtiwxaom/Xtg/DYtX65Xc71myXmXHh5hmmV7
 G25UgsYlt+2crCNE6fyAzMEjVjGDtclvGVOraaEPk4rY9dWjVBiLHXPOdVSN5xpS7kmk
 fXDS3f0ylapECcRCtA2Vc6AtxKaz1pWSjPxtifLjxmYveNDvTff3g+Y07hkKNF4mDumM
 G0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703247761; x=1703852561;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yy17GAX+dhVN3LfZ5BcAmjluYdS7Pglp6Hw9dnl9U8E=;
 b=jlEK3rqH7672Vi+boR5gw7Ra7tbVz6zZ7c5Q3EPlzZsH59nP6lOOLx1g86L88Ne7tN
 /flZXLkMkufN0VkHJMfrdTAlixwYDCALiaHIa7/Lua8ZmhLRQy7pCgVveweTuEj4QZ3R
 Tg1d1lNakUvFEEHNTn76HVC4Rv2c4lKMiUZ+m98LvrASv6rVCN/d7u2v9ji/MJlwV/dN
 EZiRkcfCqaxejqYWGO8FCRbWfbcdZXdt7GjVCsTzahVyhC3zJslentqgp1jD3HA98EW/
 OGg6bm1+fLJ8z4bd7YQ5mNnsYGz/49uNODvYdCZ2NwEZS+/rBTrpIqlWTArDceSsUIKi
 gKTA==
X-Gm-Message-State: AOJu0YwOR7TJ6sGRvykvykoxklk3cd30sbFEzV1jT7H2tGSRXE6clxGT
 980xlPwZMMgQ6heXJZuscFTLEpTVpZXsXUOZRUrZX9hfS0hJ2Q==
X-Google-Smtp-Source: AGHT+IG6TbqijRh1w5fiOyJXi+e5d8IXFsCYitNUZ6NGdi2UI9984BFIiE8In5lRI8vMaprWwOvIGw==
X-Received: by 2002:aa7:8045:0:b0:6d9:8b95:9b52 with SMTP id
 y5-20020aa78045000000b006d98b959b52mr405283pfm.55.1703247760790; 
 Fri, 22 Dec 2023 04:22:40 -0800 (PST)
Received: from grind.dc1.ventanamicro.com (201-69-66-51.dial-up.telesp.net.br.
 [201.69.66.51]) by smtp.gmail.com with ESMTPSA id
 g14-20020aa7874e000000b006ce7ad8c14esm3274901pfo.164.2023.12.22.04.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 04:22:40 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 00/16] target/riscv: deprecate riscv_cpu_options[]
Date: Fri, 22 Dec 2023 09:22:19 -0300
Message-ID: <20231222122235.545235-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
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

This new version fixes all instances of 'const PropertyInfo' added,
changing it to 'static const PropertyInfo', like suggested by Richard in
v1.

Patches based on Alistair's riscv-to-apply.next. Series is also found
here:

https://gitlab.com/danielhb/qemu/-/tree/fix_cpu_opts_v2

Changes from v1:
- changed 'const PropertyInfo' to 'static const PropertyInfo' in all
  relevant patches.
- v1 link: https://lore.kernel.org/qemu-riscv/20231221175137.497379-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (16):
  target/riscv/cpu_cfg.h: remove user_spec and bext_spec
  target/riscv: move 'pmu-mask' and 'pmu-num' to riscv_cpu_properties[]
  target/riscv: make riscv_cpu_is_generic() public
  target/riscv: move 'mmu' to riscv_cpu_properties[]
  target/riscv: move 'pmp' to riscv_cpu_properties[]
  target/riscv: rework 'priv_spec'
  target/riscv: rework 'vext_spec'
  target/riscv: move 'vlen' to riscv_cpu_properties[]
  target/riscv: move 'elen' to riscv_cpu_properties[]
  target/riscv: create finalize_features() for KVM
  target/riscv: move 'cbom_blocksize' to riscv_cpu_properties[]
  target/riscv: move 'cboz_blocksize' to riscv_cpu_properties[]
  target/riscv: remove riscv_cpu_options[]
  target/riscv/cpu.c: move 'mvendorid' to riscv_cpu_properties[]
  target/riscv/cpu.c: move 'mimpid' to riscv_cpu_properties[]
  target/riscv/cpu.c: move 'marchid' to riscv_cpu_properties[]

 target/riscv/cpu.c           | 584 +++++++++++++++++++++++++++++------
 target/riscv/cpu.h           |   7 +-
 target/riscv/cpu_cfg.h       |   4 -
 target/riscv/kvm/kvm-cpu.c   |  94 +++---
 target/riscv/kvm/kvm_riscv.h |   1 +
 target/riscv/tcg/tcg-cpu.c   |  63 ----
 6 files changed, 561 insertions(+), 192 deletions(-)

-- 
2.43.0


