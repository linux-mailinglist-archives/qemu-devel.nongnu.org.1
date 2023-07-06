Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 111AF749936
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 12:19:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHM3a-0004jK-TW; Thu, 06 Jul 2023 06:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHM3Z-0004in-6X
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:17:49 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHM3X-0005qD-Id
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:17:48 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6b883e1e9d5so378907a34.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 03:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688638666; x=1691230666;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pZ0vziReUTJ6jE0UHySINqmk2Aeu7EHNyCfMcmvDeao=;
 b=AXfvZLJbu+1GSZBrodgZerEdQdc79c+NZGYXmeUyC9TEk4lcHPxH+fCweiwYQGIODD
 qoQLZHJ/HfveYycEyvx7M6xc/EK4cTwlOIzTMR0N+sUM92iJe5wu4kIh6r4AAHtZ7eDd
 OR/e+k62tpaYZK7fIL5VYD6nkVZD/bfftEzNblXBfQpgUUvBNuw7yrPeCM84ORxOSQCa
 DzD0Rfv3ZCZeFqV/95J92ogEFixvEZ+1s4scRxA22gEvS3/unw2gVcKIX6GRTCq+n4OO
 7d92JpXwj6gLKheXbXee2ErGVjawZojdmb/BEnpjjYi/204TaljZ7YwN/dgwfcw2ljRW
 S4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688638666; x=1691230666;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pZ0vziReUTJ6jE0UHySINqmk2Aeu7EHNyCfMcmvDeao=;
 b=WpdCTYFZo88aExlAUr4P9Ch4tram4xxp5mc4cX8fQBOWu1KCh9GLYkQ+2FBatxLKSj
 0c97Wc4hLs0PWXt38RCLDYi/+H6EZA7+YPQTWXnWq79b3cXkTDig4CAJcKhwxooA4QzW
 yDrLQz2b3SuEbt+vxH44QoiELdWpGaT7yUzg2JuOjPF5xeM89sS0ErXnrm1wcXGJ/yfX
 DHcjGJWlt8QFR0K0ww+dBFcqGzktbYfJAxgQRkhfoiIcLPcL0QvfMYVPBzayMJpeOm2o
 qd99JLikpkNDHUcjFEszloGXyTExWoRamSxyAzC+XjWhhmCFG2SW+sh6iAPUkowV7eAZ
 URkQ==
X-Gm-Message-State: ABy/qLabdEHWIadcuxED0lyaYuzD2SajFr4Y2d13tPAMVz5ijdr8YB8e
 o7XhUELiCjP33uiOQfl87YkYHnFZckMPbJ9pnrs=
X-Google-Smtp-Source: APBJJlFHTD+k6I6LRBh/19512+UBnRVYCTNtzBINBnlpVmqAwQXo9ShyF67rd3rUAqleoc/4SCeOZw==
X-Received: by 2002:a9d:7f83:0:b0:6b8:8f20:4cbc with SMTP id
 t3-20020a9d7f83000000b006b88f204cbcmr1494637otp.13.1688638665752; 
 Thu, 06 Jul 2023 03:17:45 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 h25-20020a9d6a59000000b006b8850ad193sm511382otn.56.2023.07.06.03.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 03:17:45 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 00/20] target/riscv, KVM: fixes and enhancements
Date: Thu,  6 Jul 2023 07:17:18 -0300
Message-ID: <20230706101738.460804-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x336.google.com
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

In this version we dialed back from our design decision in patch 14,
returning to the design we've been using since the first version. The
rationale behind is that we can't get rid of EINVAL since it will break
extension for all other KVM versions prior to this one where we're
adding the first version of the KVM specific capabilities. We'll switch
later on for get-reg-list when it's available, but for now we're stuck
with EINVAL. Drew provided a detailed explanation here:

https://lore.kernel.org/qemu-devel/20230706-38ab9f9705448bb10413f1af@orel/T/#m75a5323e76518c02598758fdd6a8943951812875

As a bonus I also fixed the device-tree binding link satp in patch 2 like
Connor suggested. 

I believe we're ready to go.

Patches missing review: 14

Changes from v8:
  - patch 2:
    - fix device-tree binding link in commit message 
  - patch 14:
    - use EINVAL instead of ENOENT
v8 link: https://lore.kernel.org/qemu-devel/20230706-38ab9f9705448bb10413f1af@orel/T/#m1c889304847598789db313f3e0854ed0d41ce60c

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


