Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 292E4740148
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:34:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBc2-0003Td-WE; Tue, 27 Jun 2023 12:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEBby-0003TC-J7
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:32:14 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEBbw-0004l7-D4
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:32:14 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1b03fb998c8so2063330fac.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687883530; x=1690475530;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q9g+JEhe6nFMLq4BixGljbraKI1PEb8Y6zj2lU4lUug=;
 b=ShFRNNC5sUU+qyjOECxEItL8SK9RkYnOJKtpSzny/fOjvprl+8m0t0tpgnScVcVGMB
 BN2HL6WdJ59Tgm+J0km5YYwbIHAUMz+q4EIMyPYWKAt5woFnwRTc5ZSuod2I/A8ai1ML
 x8OfY3iXU4BPiu8Pv62w21W+sKQ1oKeuzfMxc7OV8pfFEF2qVtvV0HF+j/XgHfOG/iuE
 H5zdfmEUQVt+Oq166xMW/NBOOEzpAAkI7RjVaz/QJ9vmiSmxs6bIlj7M/l1MhPPt4NFH
 eHpDrxRnBIBcr4vkFo5EnjYfcbtQCFEyHV54T1XvUC5YjZH0bN0uVr75x+URa2TmPJJQ
 ihEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687883530; x=1690475530;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q9g+JEhe6nFMLq4BixGljbraKI1PEb8Y6zj2lU4lUug=;
 b=PiSkvjnSpmfhhviMDLXl4QZ+YpoG4ooB+7un57RkX51WzOCJe/+NMnoYVpE9j+XG66
 nAi/qecFDV0hoe7lSBa1bH1RN7Ag+t0bgsHLCo5+FMWm2+s1cW8A+rHbnjbOrWnpjF1c
 kVsdLvSmRGAUN6rCk4W2ACtuojjQ7Wt2cuVWVVWh2zD2oYo3SVsYNlBXXmH3rIurcVMr
 DcTZa31tOuHnjUsU3uO6aWuZ3mfEMWHbXMEjWi7RfVCfQy17eEubLyUfPVtfQEf/tqCD
 RuZiv/utCu2Y4kjyhXXOY2BwkQCp+yt8r9SDefXjkhZU/sdbD10fRQaf+S9vg/3lWkCA
 vsGQ==
X-Gm-Message-State: AC+VfDxYUVdnuNQxL3u+m7z5xKmlzbvde6xBOw0amtSGEZ+3wrX0alol
 90W3Ild1aPsSewTwKMqH0xOlYqrjXOJHzFG5qDc=
X-Google-Smtp-Source: ACHHUZ4gwKSlwL4Eu/R9eL81rTlTlea0xpLW1vPkRYk+EK382XWfp9D4lhlEkdHqwNrgPvJ/MmEg1Q==
X-Received: by 2002:a05:6870:73c4:b0:191:f657:13ee with SMTP id
 a4-20020a05687073c400b00191f65713eemr24820611oan.11.1687883530111; 
 Tue, 27 Jun 2023 09:32:10 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 gu17-20020a056870ab1100b001a3093ec23fsm5254134oab.32.2023.06.27.09.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:32:09 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v5 00/19] target/riscv, KVM: fixes and enhancements
Date: Tue, 27 Jun 2023 13:31:44 -0300
Message-ID: <20230627163203.49422-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2a.google.com
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

This version has changes in patch 16 proposed by Andrew in v4. No other
changes made.

Patches missing review: 16

Changes from v4:
- patch 16:
  - reworded comment to "Check if KVM created the property already"
  - reworded comment to "Set the default to disabled for every extension
    unknown to KVM and error out if the user attempts to enable any of
    them."
  - renamed cpu_set_cfg_noop() to cpu_set_cfg_unavailable()
  - only error out if the user is enabling a non-KVM extension when
    running KVM
  - changed commit msg to reflect that we're erroring out if a non-KVM
    extension is enabled when using KVM
- v4 link: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg05635.html

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
 target/riscv/cpu.c                            | 288 ++++++++--
 target/riscv/cpu.h                            |  11 +-
 target/riscv/kvm.c                            | 499 +++++++++++++++++-
 target/riscv/kvm_riscv.h                      |   1 +
 19 files changed, 897 insertions(+), 81 deletions(-)

-- 
2.41.0


