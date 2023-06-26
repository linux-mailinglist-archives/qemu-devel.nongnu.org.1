Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F0273EE37
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:03:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuI4-0001a7-AH; Mon, 26 Jun 2023 18:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qDuHq-0001Kx-Uj
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:02:20 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qDuHo-0005qR-WD
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:02:18 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1b055510c9dso528577fac.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 15:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687816935; x=1690408935;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dnfNaO/obmacoJFfINopOu8v1OhB9d/fUeu6hywHkbM=;
 b=kNNNHdgDnlx/Y+Sjdwf3D0Jgb1VOvdvvIYF58CnqkRhv+JuvTodvttfwkYLbMh7pnJ
 lXmtddWB7jniFONps4Db/9HfhpLOIUM58DDSoeGJ5Q4LoWqNtLGglME6JbelKJ8rZCr8
 zHkbdfP7Ql32AA0gLv5fdsyI5wHz1GZuxUUbFG8WpTf1jBmwwEfNKUVw4RHHkRvlpvHt
 27uGzUqccG8OWumqoLHJp4JzVbnp9TmuQ2y7VnoOOJQlizZBBp3tn96fr7jM4pYPZCeI
 av9u8v4+uQMHPZWhjIwW9PazFQWZViFquqNd3s2YdF+25bXFKxYmDWsrt8lrtPATTsW/
 5Rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687816935; x=1690408935;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dnfNaO/obmacoJFfINopOu8v1OhB9d/fUeu6hywHkbM=;
 b=QPVJn2hJoxf76eJUlFgMoekFy6DugbULOqIR5PN++ECenjzmvgm7YAMLHomr9LH23n
 E29LF95u8H61+E+9yqHcSot66vNJhvZJXOo1yr3iwfMbsv/Qgv6xZ9sOxJW9Bk+CYgXM
 sd1eKUfLkqGvbq/OzemQ/jn/s9u+Y3MGM6Ajg7Y5F6iYbniSNIy5zLZeBNX53uA/PFrk
 nCd5apkY6Moj+qLdgXmeUUlQd6NRD3Z/WJGnA6ufoBfT8hDyz8Op5ZRXpbxM2yr9DsBN
 o9iStrJyuFhSZH5yn0qmKFGktWQwlOhaq7OaCujhqF4Dk4tIkHF3gccYZah0Po+sTmIO
 3Z9g==
X-Gm-Message-State: AC+VfDyNgspYcD+w1tpNUg4y7HnnmO82PxL+moML6PI7J8cziQ0L+bRM
 G0yxuI9qSxj1BZECFUA9iI8BM6Rk3i5RgHUwmaU=
X-Google-Smtp-Source: ACHHUZ5/L7pk7KYuUNrItyGLzLUMpj/PFnpVehTReklc+PCMdEzwrejBPpvv6xW054jqAKdRPQAKIw==
X-Received: by 2002:a05:6871:4c4:b0:1b0:454b:1c3d with SMTP id
 n4-20020a05687104c400b001b0454b1c3dmr2517247oai.36.1687816935195; 
 Mon, 26 Jun 2023 15:02:15 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a056870a10c00b001b03fbfa0c5sm1831419oae.39.2023.06.26.15.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 15:02:14 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 00/19] target/riscv, KVM: fixes and enhancements
Date: Mon, 26 Jun 2023 19:01:50 -0300
Message-ID: <20230626220209.22142-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x30.google.com
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

This version has a change requested by Andrew in patch 16.

All patches aside from patch 16 are acked/reviewed.

Changes from v3:
- patch 16:
  - error out with a "extension <name> is not available with KVM"
- v3 link: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg04575.html

Daniel Henrique Barboza (19):
  target/riscv: skip features setup for KVM CPUs
  hw/riscv/virt.c: skip 'mmu-type' FDT if satp mode not set
  target/riscv/cpu.c: restrict 'mvendorid' value
  target/riscv/cpu.c: restrict 'mimpid' value
  target/riscv/cpu.c: restrict 'marchid' value
  target/riscv: use KVM scratch CPUs to init KVM properties
  target/riscv: read marchid/mimpid in kvm_riscv_init_machine_ids()
  target/riscv: handle mvendorid/marchid/mimpid for KVM CPUs
  linux-headers: Update to v6.4-rc1
  target/riscv/kvm.c: init 'misa_ext_mask' with scratch CPU
  target/riscv/cpu: add misa_ext_info_arr[]
  target/riscv: add KVM specific MISA properties
  target/riscv/kvm.c: update KVM MISA bits
  target/riscv/kvm.c: add multi-letter extension KVM properties
  target/riscv/cpu.c: remove priv_ver check from riscv_isa_string_ext()
  target/riscv/cpu.c: create KVM mock properties
  target/riscv: update multi-letter extension KVM properties
  target/riscv/kvm.c: add kvmconfig_get_cfg_addr() helper
  target/riscv/kvm.c: read/write (cbom|cboz)_blocksize in KVM

 hw/riscv/virt.c                               |  14 +-
 include/standard-headers/linux/const.h        |   2 +-
 include/standard-headers/linux/virtio_blk.h   |  18 +-
 .../standard-headers/linux/virtio_config.h    |   6 +
 include/standard-headers/linux/virtio_net.h   |   1 +
 linux-headers/asm-arm64/kvm.h                 |  33 ++
 linux-headers/asm-riscv/kvm.h                 |  53 +-
 linux-headers/asm-riscv/unistd.h              |   9 +
 linux-headers/asm-s390/unistd_32.h            |   1 +
 linux-headers/asm-s390/unistd_64.h            |   1 +
 linux-headers/asm-x86/kvm.h                   |   3 +
 linux-headers/linux/const.h                   |   2 +-
 linux-headers/linux/kvm.h                     |  12 +-
 linux-headers/linux/psp-sev.h                 |   7 +
 linux-headers/linux/userfaultfd.h             |  17 +-
 target/riscv/cpu.c                            | 286 ++++++++--
 target/riscv/cpu.h                            |  11 +-
 target/riscv/kvm.c                            | 499 +++++++++++++++++-
 target/riscv/kvm_riscv.h                      |   1 +
 19 files changed, 895 insertions(+), 81 deletions(-)

-- 
2.41.0


