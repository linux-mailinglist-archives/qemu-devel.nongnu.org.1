Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DF7790289
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 21:48:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcA6J-0007lM-9a; Fri, 01 Sep 2023 15:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA6H-0007l2-Oy
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:46:37 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA6F-0002uK-8t
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:46:37 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5739965a482so201105eaf.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693597594; x=1694202394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qa/lEGUuiSTYdIPWFhWhc/A3P+oNCfp1O+Hq9v6jrOI=;
 b=E5cMFeJL1u3cY127yDQ7vEq7wqorgkdiaijGDmhwaz9DVWSEHSCm1g/LqCputjNbpK
 XRJV1YBBkDtALOeI1lj7qkWZpJnRF4ozkoUSOzHBczv7PapG7jl72m0uZ/YZhUojwUuX
 AUQwo+lOOJHFDx2U8+6JQGAxhB17qRremNVDsrRVgcvKhAONIqwtBaRKqdXnLoMRR9cX
 tiBy7vBDnHc5kjwP/BoBde28ew6mfaCWTRqO6AddtAyGDAJbUpzv8brqZMa9Xy0AyVdI
 HKX20gvaK46RBbIwu+ulugf+Nqkq4LiKQT2TkewvV+GHDOKdgkNbDYTZL9nOcmiQsktl
 Y9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693597594; x=1694202394;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qa/lEGUuiSTYdIPWFhWhc/A3P+oNCfp1O+Hq9v6jrOI=;
 b=eo36pb5Qw0zptnmCIB6uF7+KYKf7KdRbyw197wt9kcPHMomLFFUlLsLko2agYYjcay
 xJs5m3GfptK/TMAISuV+rzx3B+lTS4d+oN2YrDt1fYibXfpv4js2m5Q8dbj3IPT4byon
 YXflItMpPK3WqlR14gEW3xyaoh/FZqdNEKmW8YFGVrTaSaUNGiJ2a3XvuAXJqGIZK1rL
 0H4am0c+9zwfFc4mxRUGT/JlTlX+Pskkjae194ZcifdbFBqm+pz5o8qHxZ0Hxn+m1kL5
 Vm5i4Xc2XudzGUGU8iVUM/w1E4tmXlrNOMehG+Ymr+2zFzNZoaf6rBT+V1FqxvNf6mmI
 sN8Q==
X-Gm-Message-State: AOJu0YyaDFmqWBr12YUZqXwH4mtv0vOoT+ayXfouPF6cN5ba5ygBVixS
 c41GuSOPV2fVKMvQjza8fniemDKijmcH5QofEJU=
X-Google-Smtp-Source: AGHT+IG7rgOAhevh8Mhk1w7TnZ29oBcnsVlSps0hzKYWtf2JjW6zT3S9F/M+OlDf1F5NGYMOt4QCMA==
X-Received: by 2002:a4a:2553:0:b0:56e:9d63:9ac5 with SMTP id
 v19-20020a4a2553000000b0056e9d639ac5mr2475324ooe.2.1693597593735; 
 Fri, 01 Sep 2023 12:46:33 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.194])
 by smtp.gmail.com with ESMTPSA id
 h187-20020a4a5ec4000000b00565d41ba4d0sm2303002oob.35.2023.09.01.12.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 12:46:33 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 00/20] riscv: 'max' CPU, detect user choice in TCG
Date: Fri,  1 Sep 2023 16:46:06 -0300
Message-ID: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This new version contains suggestions made by Andrew Jones in v8.

Most notable change is the removal of the opensbi.py test in patch 11,
which was replaced by a TuxBoot test. It's more suitable to test the
integrity of all the extensions enabled by the 'max' CPU.

The series is available in this branch:

https://gitlab.com/danielhb/qemu/-/tree/max_cpu_user_choice_v9

Patches missing acks: 11, 15

Changes from v8:
- patch 7:
  - add g_assert(array) at the start of riscv_cpu_add_qdev_prop_array()
- patch 8:
  - add g_assert(array) at the start of riscv_cpu_add_kvm_unavail_prop_array()
- patch 11:
  - removed both opensbi.py tests
  - added 2 'max' cpu tuxboot tests in tuxrun_baselines.py
- patch 12:
  - fixed typos in deprecated.rst
- patch 15:
  - use g_assert_not_reached() at the end of cpu_cfg_ext_get_min_version()
- patch 19:
  - added comment on top of riscv_cpu_add_misa_properties() explaining why
    we're not implementing user choice support for MISA properties
- patch 20:
  - warn_report() is now called after the G error conditions
- v8 link: https://lore.kernel.org/qemu-riscv/20230824221440.484675-1-dbarboza@ventanamicro.com/



Daniel Henrique Barboza (20):
  target/riscv/cpu.c: split CPU options from riscv_cpu_extensions[]
  target/riscv/cpu.c: skip 'bool' check when filtering KVM props
  target/riscv/cpu.c: split kvm prop handling to its own helper
  target/riscv: add DEFINE_PROP_END_OF_LIST() to riscv_cpu_options[]
  target/riscv/cpu.c: split non-ratified exts from
    riscv_cpu_extensions[]
  target/riscv/cpu.c: split vendor exts from riscv_cpu_extensions[]
  target/riscv/cpu.c: add riscv_cpu_add_qdev_prop_array()
  target/riscv/cpu.c: add riscv_cpu_add_kvm_unavail_prop_array()
  target/riscv/cpu.c: limit cfg->vext_spec log message
  target/riscv: add 'max' CPU type
  avocado, risc-v: add tuxboot tests for 'max' CPU
  target/riscv: deprecate the 'any' CPU type
  target/riscv/cpu.c: use offset in isa_ext_is_enabled/update_enabled
  target/riscv: make CPUCFG() macro public
  target/riscv/cpu.c: introduce cpu_cfg_ext_auto_update()
  target/riscv/cpu.c: use cpu_cfg_ext_auto_update() during realize()
  target/riscv/cpu.c: introduce RISCVCPUMultiExtConfig
  target/riscv: use isa_ext_update_enabled() in
    init_max_cpu_extensions()
  target/riscv/cpu.c: honor user choice in cpu_cfg_ext_auto_update()
  target/riscv/cpu.c: consider user option with RVG

 docs/about/deprecated.rst         |  12 +
 target/riscv/cpu-qom.h            |   1 +
 target/riscv/cpu.c                | 564 +++++++++++++++++++++---------
 target/riscv/cpu.h                |   2 +
 target/riscv/kvm.c                |   8 +-
 tests/avocado/tuxrun_baselines.py |  32 ++
 6 files changed, 450 insertions(+), 169 deletions(-)

-- 
2.41.0


