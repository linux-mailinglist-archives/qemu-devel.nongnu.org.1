Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F8B72ED76
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 23:00:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9B6n-0001x5-Jp; Tue, 13 Jun 2023 16:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q9B6l-0001wW-P4
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 16:59:19 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q9B6j-0006cD-RY
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 16:59:19 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-39aa8256db7so2728318b6e.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 13:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686689955; x=1689281955;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/Z10AqOhEOIJ/+yzYDRvzuYRbMbIthZFfmRez4PCXMo=;
 b=polR8EUT/9nBPaCHyvHXSqyVctHgy/UKhtiQvDjg49DPcjR8cNnuEo6yA3IQiDFwe7
 vviuZeIy6sazjjWa0dqV4l3yIAnXjax0D83ufl5nb8r+wsBTtPoMC9qVHgJV8gOTOzrP
 O0GMBzSM5Vq1osUfZzGlHnRdI8AzFtxVpfJucqRXaToi/2uOrJSfQkUUmoMDIwVMsY1F
 CdYsnDVSC5GWL8pEKJFwb+yeUF6+g+rwcMfUaVDyZLeMyaV0tdrzQNj8Ybd22bmmEUjI
 OTH2W4dEi3hR0pMXkeGvruwjRQHw/6QHV6PeAl6nPqyK7cUoxFvKpOS9pLZNheTg7V73
 2hdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686689955; x=1689281955;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Z10AqOhEOIJ/+yzYDRvzuYRbMbIthZFfmRez4PCXMo=;
 b=QGv/Afgpo3D3x7fU6TFZW2EsTQR4IpaTBhWRPN3SzHiM7WbZ1DPZNjCcG3t+t4rE6R
 W9F53sGMXCHMyMo8JMDKY5wgIWq1+9y1nHeBLofzlDvpGL3jvoZRCadjYG98wSkpE5FD
 QhQOXbeWTvGKFXLNLg08Nhty2WsC//VdQCxSc/IZR6sOH2EPBbn+G2LR6Y7N/rPcM9K6
 WO30+WlpUHmPIbLEddgbVcoqQj9ZbOA44XCfarc9OqtRLNUDNZOOg1fl6us2C2EiqnKq
 F9tCsDbbcTNH/PWIOq80ZCJWwYN2ZBPdAJXwGO1K+XAAidxa/1ZcIupNuPyymPQvUTvU
 lcig==
X-Gm-Message-State: AC+VfDza7TV7EU35IpL7CA06FTK5icsxkqXRTu5e6b7bYWxa1Rh7olfk
 6kxMRp+K6VkwhtkmzV3aj3ctHUYbsR3zYhTVJFk=
X-Google-Smtp-Source: ACHHUZ4XL99KtkUUX7L2GTpLFdQgRtNu0GKg6DeVs039PfQGeU7bDfpcDu8XoTIsQciaBoDz0Hi6Tw==
X-Received: by 2002:aca:1902:0:b0:39a:51a0:d4d3 with SMTP id
 l2-20020aca1902000000b0039a51a0d4d3mr7969298oii.33.1686689955562; 
 Tue, 13 Jun 2023 13:59:15 -0700 (PDT)
Received: from grind.. ([177.170.117.210]) by smtp.gmail.com with ESMTPSA id
 q82-20020acaf255000000b003982a8a1e3fsm5619514oih.51.2023.06.13.13.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 13:59:15 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 00/18] target/riscv, KVM: fixes and enhancements
Date: Tue, 13 Jun 2023 17:58:39 -0300
Message-Id: <20230613205857.495165-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22c.google.com
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

In this new version a lot of changes were made in the second half of the
series, all based on Andrew's feeback in v1.

Most notable changes are focused on reducing code repetition:

- a new misa_ext_infos[] array that holds 'name' and 'description' info
  for MISA extensions to be shared between TCG and KVM code;

- 'KVMCPUConfig', a common struct used for both MISA and multi-letter KVM
  extensions to store extension state;

- we're not adding a KVM specific riscv_isa_string_ext() function
  anymore. A few tweaks are made to allow the same function to be used
  for both TCG and KVM

Another notable change is on the last patch, where a lot of complexity
were removed by treating cbom/z blocksizes in a similar manner we deal
with machine-id properties: fetch their value at init() time and
validate the value in the set() accessor to fail early.

Patches missing review: 9-15, 17-18

Changes from v1:
- patch 11 (NEW):
  - move code from riscv/cpu.c to cpu.h to create a MisaExtInfo array
- patch 17 (NEW):
  - create a helper to retrieve the pointer address of a given cpu->cfg
    attribute in a KVMCPUConfig element
- patch 1:
  - renamed riscv_running_KVM() to riscv_running_kvm()
- patches 3,4,5:
  - added get() accessors for machine-id properties
- patch 12 (former 11):
  - use new MisaExtInfo instead of duplicating names and descriptions
  - renamed RISCVCPUMisaExtConfig to KVMCPUConfig
  - KVMCPUConfig is now generic and used by both MISA and multi-letter
    extensions
- patch 13 (former 12):
  - removed the -EINVAL check. Always error out if an error happens when
    disabling a MISA extension
- patch 15 (former 14):
  - kvm_riscv_isa_string_ext() was removed
  - add 'kvm_available' in isa_ext_data struct
  - added a new ISA_EXT_DATA_ENTRY_KVM() to set the added flag for
    extensions that kvm is aware of
  - added env->priv_ver = PRIV_VERSION_LATEST in riscv_host_cpu_init()
- patch 18 (former 16):
  - all cbomz_blocksize logic was moved from realize() to init() time
  - create a named KVMCPUConfig for each blocksize instead of adding
    them in a separated array
  - read blocksizes during init() time using the scratch KVM CPU
  - validation moved to the property set() handler
- v1 link: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg07779.html

Daniel Henrique Barboza (18):
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
  target/riscv/cpu: add misa_ext_infos[]
  target/riscv: add KVM specific MISA properties
  target/riscv/kvm.c: update KVM MISA bits
  target/riscv/kvm.c: add multi-letter extension KVM properties
  target/riscv: make riscv_isa_string_ext() KVM compatible
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
 target/riscv/cpu.c                            | 261 +++++++--
 target/riscv/cpu.h                            |  22 +-
 target/riscv/kvm.c                            | 502 +++++++++++++++++-
 target/riscv/kvm_riscv.h                      |   1 +
 19 files changed, 878 insertions(+), 87 deletions(-)

-- 
2.40.1


