Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B2D743906
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 12:10:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFB3C-00051O-2y; Fri, 30 Jun 2023 06:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFB39-00050x-Mo
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:08:23 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFB37-0000iO-Kr
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:08:23 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1b078b34df5so1529084fac.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 03:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688119699; x=1690711699;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rS14vjWJcYSPfeLT5geB+8LgzHhJx3nAgLr7frBsGYY=;
 b=lqiIOTEBP0B1KtN5ONtxJi2x77YIYyp7My4a6eq5o5LRi3KHYleyW6VXvu5T/gmwvI
 WJ9fM1mbRXocu9ThJ0HzNFc691dhJ88VvOT7q6lmRBxdAPTApYWkFhkkHbF34DdN43o6
 h0I4mwlj4vPcW9kXfCm30Fcw1q/vAJNTWExHAAuBrr73zhGPHu2VbPR3X1hg0Qq8exAB
 KP1LH3DzfDI7vX7YBuoyZgLQvC96FGRJFujUFjD05YqRz3Kik9I7/v4XTLoKEe4xuVDG
 AA09nvOfQwPl+JX2tPnoURgCqkTFeek1E1t03f8ySTfPs9ofDiHfdGM0m07AY/FgoKsC
 a/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688119699; x=1690711699;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rS14vjWJcYSPfeLT5geB+8LgzHhJx3nAgLr7frBsGYY=;
 b=GdwhZR38PYMEShHWaLm9FkReXK6dCHUfXHHXJods6HAJHgY7VPkckCOOYE3fA9Nr2j
 VvQbaiDoMDC7kKOG0wMuOSgviNLOgf+/nzfDQzcx7vwmMVyhsR4cv3yMN775xzMhVg+a
 to2lm1fO1ARW1k3ag4Bay4It/XhxfSigS0HLduv9vMGPRYCX1eVJ1X/JeuuoCWTmG9Sd
 KfnkMBk/dz7bIX4Fjynx7XLmrnzKuhk7+nYWTiJYDw7dSfLbs4C9QuAz4XdhhrtaMF/3
 uuNC4oEH9/TU13XipCehxq0agjZS60sEdv0MdF1F0hJmz21Wy9T0oKdbI+SQ1zsg8DMF
 YpjQ==
X-Gm-Message-State: ABy/qLZcoWTrgBGHeFZZIlzoCyWhrD+H5A20R76U5XEAXnihsDRy/B3F
 B3UEdcnmi8NnBSJkGYmqmPck0cr7jmZnzS34Et8=
X-Google-Smtp-Source: APBJJlFJgwNBTZALBDFYLi3pMDl22lKXCsXPp38q5bzIdCQlWbNgqs+dKWkPbdPAH2IdvbJUnVQ21A==
X-Received: by 2002:a05:6870:be0a:b0:1b0:3821:f09a with SMTP id
 ny10-20020a056870be0a00b001b03821f09amr3127471oab.14.1688119699261; 
 Fri, 30 Jun 2023 03:08:19 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 eh18-20020a056870f59200b001a663e49523sm8707467oab.36.2023.06.30.03.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 03:08:18 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v7 00/20] target/riscv, KVM: fixes and enhancements 
Date: Fri, 30 Jun 2023 07:07:51 -0300
Message-ID: <20230630100811.287315-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2d.google.com
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

This version includes most of the fixes and changes suggested in the v6
review [1].

Unfortunately we weren't able to proceed with Drew's suggestion to avoid
assigning 'name' and 'description' during runtime in patch 11 because
some Gitlab runners (clang-user and tsan-build) complained about
misa_ext_info_arr[] not being a compiler-time constant. I documented
this 'clang' situation in patch 11 commit msg.

The change to use __builtin_ctz() instead of ctz32() was kept because
it's clearer to use the MISA bits (RVA, RVC ...) as input for
MISA_EXT_INFO() than doing a calculation with (letter - 'A').

All other suggestions from both Drew and Phil were implemented. 'sudo'
references from commit msgs were removed from patches 1 and 2 as
suggested by Michael (R-bs were kept).

Series based on top of Alistair's riscv-to-apply.next.

Patches missing review: 11, 12

Changes from v6:
- patches 1 and 2: removed 'sudo' references from commit msgs
- patch 11:
  - use __builtin_ctz() instead of ctz32() in MISA_EXT_INFO
  - renamed getter to riscv_get_misa_ext_description()
  - do input/output validation in both getters
- patch 12:
  - use object_property_find() to skip the property if it already exists
- v6 link: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg06353.html

[1] https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg06353.html

Daniel Henrique Barboza (20):
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
  target/riscv/cpu.c: add satp_mode properties earlier
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
 target/riscv/cpu.c                            | 341 ++++++++++--
 target/riscv/cpu.h                            |   7 +-
 target/riscv/kvm.c                            | 499 +++++++++++++++++-
 target/riscv/kvm_riscv.h                      |   1 +
 19 files changed, 940 insertions(+), 87 deletions(-)

-- 
2.41.0


