Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 839987FF959
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 19:29:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8llY-0007PK-FF; Thu, 30 Nov 2023 13:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r8llW-0007OS-4x
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 13:27:58 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r8llU-00020Y-KH
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 13:27:57 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6cc2027f7a2so1255232b3a.2
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 10:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1701368874; x=1701973674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q7yun4U7tx9SivzwtPFNXuaW40xzS24FRTchvW/8usI=;
 b=boDayZLND9BSo5BOfB1p3aNzo/47wKv+hxUXq+H7PLBMtctHJpoFpyBM6kJP5oubjP
 Nq9xq+yPbR+eXfLNd709zM33rRwSnY5AogG4z1IsY1kaddlzME5uGd7gl4Psfq5+BBvB
 UIioEh8/pv4lf6uaTIswFtfmV9xq8Sopq05OxQpPErRIeVKe24OtrLiKLPX/7cxv9FDf
 I02RkiLob8kDVHOmFYBB8fDn63M1RFcMlxvg2f9EVAkBK5VCmydD0M+kaCSr/avLr3K+
 DIArXr2o2t7CjR+Cys3PqCVgiDtpD4GK7+TgxwJaGezsduLB0shviHYOldpWA/vnAckQ
 UYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701368874; x=1701973674;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q7yun4U7tx9SivzwtPFNXuaW40xzS24FRTchvW/8usI=;
 b=v6b2OVul9hzhBM5lsTlU+9cUNHKyKiXkCqgWJ8t0IuF+pTknjdDNghuHVS8TRJKGiI
 je/eXoshd11BdIyHP3CMYrJw+1sqfxdHcxLl6Z2rcOkaRHGqbZtnWP7QqVHgaOwOOsHo
 FVTMOKRx5Idog2vPXAHzKUjnDZc6XP+4hfQvahA/lWVEvyMMQ2+lBXK8YNBkuQ2g4XUs
 NuuwYKpz+m6tLPH5SppLiLSQ/6nqx/3qtgy+nQKeGLa+++u/iNuyIHXpi/cCLnb78D36
 /8vnVoIiUQ5dh/3FAfN0hoIMBw/MtfzNBq/bT/5ZK5R95ZkKoKjaPReizj1mU48SwsEq
 SMjQ==
X-Gm-Message-State: AOJu0YwkeVlWejDm4glYonoO0NkKlMy01bmYrypMZmqKAVf15Px4e3f1
 w/Mi+nU3wwjjF+PkACIS7h8R/lORgXuylhkB8EE=
X-Google-Smtp-Source: AGHT+IFvckFmJFm1GIC7sfIwbm4bQM2/jv+62pPyaeLlzpAmmn3Pq1NAAXitW8RmaY8CS6P/qw/hlA==
X-Received: by 2002:a05:6a00:3a04:b0:6cb:bc06:b058 with SMTP id
 fj4-20020a056a003a0400b006cbbc06b058mr23886350pfb.0.1701368874521; 
 Thu, 30 Nov 2023 10:27:54 -0800 (PST)
Received: from grind.. (200-206-229-234.dsl.telesp.net.br. [200.206.229.234])
 by smtp.gmail.com with ESMTPSA id
 b24-20020aa78718000000b0068fece22469sm1517451pfo.4.2023.11.30.10.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 10:27:54 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 0/4] target/riscv: add RVV CSRs
Date: Thu, 30 Nov 2023 15:27:44 -0300
Message-ID: <20231130182748.1894790-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42a.google.com
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

This series adds RVV, vstart, vl and vtype regs to the KVM driver.

But first we need a couple of things done. We need 'ptrace.h' RISC-V
linux-header to be able to read/write RVV CSRs. This is done in patch 2.
Patch 1 is the usual linux-header bump for all archs.

Patch 3 is adding a realize() callback for the KVM driver because we're
doing a prctl() to enable Vector support for the thread.

Patches are based on master. You'll need the following KVM fix to be
able to build:

[PATCH for-8.2] target/riscv/kvm: fix shadowing in kvm_riscv_(get|put)_regs_csr


Daniel Henrique Barboza (4):
  linux-headers: Update to Linux v6.7-rc3
  linux-headers: riscv: add ptrace.h
  target/riscv/kvm: do PR_RISCV_V_SET_CONTROL during realize()
  target/riscv/kvm: add RVV and Vector CSR regs

 include/standard-headers/drm/drm_fourcc.h     |   2 +
 include/standard-headers/linux/pci_regs.h     |  24 ++-
 include/standard-headers/linux/vhost_types.h  |   7 +
 .../standard-headers/linux/virtio_config.h    |   5 +
 include/standard-headers/linux/virtio_pci.h   |  11 ++
 linux-headers/asm-arm64/kvm.h                 |  32 ++++
 linux-headers/asm-generic/unistd.h            |  14 +-
 linux-headers/asm-loongarch/bitsperlong.h     |   1 +
 linux-headers/asm-loongarch/kvm.h             | 108 +++++++++++
 linux-headers/asm-loongarch/mman.h            |   1 +
 linux-headers/asm-loongarch/unistd.h          |   5 +
 linux-headers/asm-mips/unistd_n32.h           |   4 +
 linux-headers/asm-mips/unistd_n64.h           |   4 +
 linux-headers/asm-mips/unistd_o32.h           |   4 +
 linux-headers/asm-powerpc/unistd_32.h         |   4 +
 linux-headers/asm-powerpc/unistd_64.h         |   4 +
 linux-headers/asm-riscv/kvm.h                 |  12 ++
 linux-headers/asm-riscv/ptrace.h              | 132 +++++++++++++
 linux-headers/asm-s390/unistd_32.h            |   4 +
 linux-headers/asm-s390/unistd_64.h            |   4 +
 linux-headers/asm-x86/unistd_32.h             |   4 +
 linux-headers/asm-x86/unistd_64.h             |   3 +
 linux-headers/asm-x86/unistd_x32.h            |   3 +
 linux-headers/linux/iommufd.h                 | 180 +++++++++++++++++-
 linux-headers/linux/kvm.h                     |  11 ++
 linux-headers/linux/psp-sev.h                 |   1 +
 linux-headers/linux/stddef.h                  |   7 +
 linux-headers/linux/userfaultfd.h             |   9 +-
 linux-headers/linux/vfio.h                    |  47 +++--
 linux-headers/linux/vhost.h                   |   8 +
 scripts/update-linux-headers.sh               |   3 +
 target/riscv/kvm/kvm-cpu.c                    | 103 ++++++++++
 32 files changed, 735 insertions(+), 26 deletions(-)
 create mode 100644 linux-headers/asm-loongarch/bitsperlong.h
 create mode 100644 linux-headers/asm-loongarch/kvm.h
 create mode 100644 linux-headers/asm-loongarch/mman.h
 create mode 100644 linux-headers/asm-loongarch/unistd.h
 create mode 100644 linux-headers/asm-riscv/ptrace.h

-- 
2.41.0


