Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEB077D3FD
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 22:17:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0Sb-0001Se-BL; Tue, 15 Aug 2023 16:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW0SZ-0001Rn-1K
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 16:16:11 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW0SV-0004um-Fn
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 16:16:10 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1c4d7103ef5so1648512fac.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 13:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692130566; x=1692735366;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V7lwiT9ZBvxcRqyMAfKGlOl8NMzGjzKM6ee1lSlEc44=;
 b=J2QSzVOPIVDM9rhlx3KyVEgN5YxjX9xZX9g9KiYGsnTRb7gl5dIOD8jrzqk/kSz0RP
 tu6R1ZDCph3EeiGGsQzzstnX1c1dwlLOwgOW3fUlsmTDKb50GR2HqmLFxg0gPuD5CSwc
 0hm1LcZlI9z3N5xexjY0uqBdXGmx8XfJzhHRcUgMOIK7y96wzs0tF9RD376juWS8nHu1
 G2lYxJae/vhQPY3tzHSwP7cgZ/2HpmXVbliXCi6367ix4Xk1N1RgRvb4g6I9G5CTYrnQ
 UqeVoWWrG+PY40H/DmPIdbHpuUpfpbbYzDSkodOcHnsk42uPK2g1zkZWKvt9nq2BTl3D
 VmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692130566; x=1692735366;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V7lwiT9ZBvxcRqyMAfKGlOl8NMzGjzKM6ee1lSlEc44=;
 b=NdJ0QVRru4SMKB+cB9t2yBIEyvf22rdeQfzX9f2OOcI+zxJB+Qjmg+9/YsSoMPOphj
 Lnz9+8vZ2o3fhgLK1CKEm44dqUlqzIo4yjGNijGTRjt9uZcLxUiSWeBSZEJ5MNAREFIt
 5LYLXojwcTbSOSZUex1FHmDSDKe36dMMHekFngJeS5ezHSF2QoFc/NLpz32lM3FALmAM
 0DGUsODBOBOPM+GPg6IFRwJ6U2zijLo8GBk/J2h8fDH39PShlhbGCic5qzCfgQp8GGpE
 Ff/TTEoKJrVLYd5dnpmoVnl+UKIGtQpJ3TJHhCZ5vAHafLeZ7v/jQKjQj75SnyWGfZqV
 rlxQ==
X-Gm-Message-State: AOJu0YznHL0tGvflnBFbyY05KtZwBZqULFDG039XqQvj77pUsQT0t/Bx
 crGrAYjN6k3uZmBvhk4LICBMB58JlAlldn2VhQg=
X-Google-Smtp-Source: AGHT+IEAo+fPT02rXC+wFOdv4qZxIDjn3RjL6QstVCNU6SXinzz5D9hhwT5Qn0C5fng8pjy0gw/JBQ==
X-Received: by 2002:a05:6871:68a:b0:1c1:9eb1:be58 with SMTP id
 l10-20020a056871068a00b001c19eb1be58mr2043313oao.29.1692130565766; 
 Tue, 15 Aug 2023 13:16:05 -0700 (PDT)
Received: from grind.. (189-69-160-189.dial-up.telesp.net.br. [189.69.160.189])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a056870e80e00b001bb5b2a958csm6658203oan.23.2023.08.15.13.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 13:16:05 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v7 00/12] riscv: add 'max' CPU, deprecate 'any'
Date: Tue, 15 Aug 2023 17:15:47 -0300
Message-ID: <20230815201559.398643-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x29.google.com
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

This new version contains a change in patch 4 where, instead of changing
every other Property array to use ARRAY_SIZE(), convert
riscv_cpu_options[] to use DEFINE_PROP_END_OF_LIST(). This change makes
no difference in the code deduplication that is done in the later
patches, and will spare us from a future headache when exporting these
arrays to other files.

No other changes made.

Patches without reviews: 4.

Changes from v6:
- patch 4:
  - Instead of changing arrays to use ARRAY_SIZE(), change
    riscv_cpu_options[] to use DEFINE_PROP_END_OF_LIST()
- v6 link: https://lore.kernel.org/qemu-riscv/20230727220927.62950-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (12):
  target/riscv/cpu.c: split CPU options from riscv_cpu_extensions[]
  target/riscv/cpu.c: skip 'bool' check when filtering KVM props
  target/riscv/cpu.c: split kvm prop handling to its own helper
  target/riscv: add DEFINE_PROP_END_OF_LIST() to riscv_cpu_options[]
  target/riscv/cpu.c: split vendor exts from riscv_cpu_extensions[]
  target/riscv/cpu.c: split non-ratified exts from
    riscv_cpu_extensions[]
  target/riscv/cpu.c: add ADD_CPU_QDEV_PROPERTIES_ARRAY() macro
  target/riscv/cpu.c: add ADD_UNAVAIL_KVM_PROP_ARRAY() macro
  target/riscv/cpu.c: limit cfg->vext_spec log message
  target/riscv: add 'max' CPU type
  avocado, risc-v: add opensbi tests for 'max' CPU
  target/riscv: deprecate the 'any' CPU type

 docs/about/deprecated.rst      |  12 +++
 target/riscv/cpu-qom.h         |   1 +
 target/riscv/cpu.c             | 192 +++++++++++++++++++++++++--------
 tests/avocado/riscv_opensbi.py |  16 +++
 4 files changed, 178 insertions(+), 43 deletions(-)

-- 
2.41.0


