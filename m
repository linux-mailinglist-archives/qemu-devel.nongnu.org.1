Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C8A7ADE3A
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 19:58:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkppi-0000Y0-31; Mon, 25 Sep 2023 13:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qkppf-0000XB-Cl
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:57:19 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qkppd-00029a-Jr
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:57:19 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-690bfd4f3ebso5171163b3a.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 10:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695664635; x=1696269435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aVjYOcfSPRDrm5vzAta8aod2lUloyiCZt3TJpOu5FjU=;
 b=MxOUOJbzy47k21STkDtfUuZ49Zl1L6sGBtgxOet764uVgh6EM/8d9b0KhhT9rH+qd7
 PSMG03WCQ2U0d80rl3OfeHqN0YfvqTrke5dPUpB631NtsjS5/LuxZtvQoXQtV/ZWHB35
 LVDl/LX22oEcl2NdB2mVogWTrrXEHCJaKmy3xSn0qe36DtjDInftH1FHJvLazng8fHQW
 VPZ2J6Myuuw99dQjdEzUPmENjJC6YhjWlY/LX7dzW931+R3EY3cKZX4yc62hLbX88QFI
 MNdcgVnMEFDMSR6DjVrmcu354djpFFT59pjDLw8CxDIEE4SL9c6Z4BteZKmPgFupYp/9
 m6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695664635; x=1696269435;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aVjYOcfSPRDrm5vzAta8aod2lUloyiCZt3TJpOu5FjU=;
 b=l7CEwmXYqCx3qxUMKOb5U4kOcR4wZjW6j3RivyBDvDLS5g2cDdW+qI/zBCjUF+6cTI
 7KPuFlhXx3+m+eeGidmh3o+8SBjViP/ceSfYOVxIw5FFRB6Xy4mBND4zuuMOmWHCP5eY
 iE2F9JEeSQLpC5hV0XdSKEIpJUBUZB0IOB99MGyG5Iyx6THzLZoUuvyRT89BuGJofrpZ
 EEasP/OBeNQfDukJcYhd1fIZi7KHCuqDo2guqIf+BvlxmqsJjsZHrveLNLbvOQPPAwZj
 L7+gEuEev8+kJGaZVrEUxTgYAmlTo21l8i4jAQrffMKVD7NGMU6gP1NwfiAjG6EvDXMq
 k67Q==
X-Gm-Message-State: AOJu0YwDMDSkezlONjpn/PFxKCaMjOdp2+pQww6wqTeI8s1lSKfXgvoy
 ZP3zBSJCA5KEZkxn8qLqnd6RnHDo18DySd6e+38=
X-Google-Smtp-Source: AGHT+IFp0HL9PfJ+LdRwqd3EB1lmRHDo+2Ut9BKdO1q3L1374RLYGv3dHsXvCb4ZJcV99M6iOgxfAw==
X-Received: by 2002:a05:6a20:4310:b0:14e:509:1d7b with SMTP id
 h16-20020a056a20431000b0014e05091d7bmr6462994pzk.8.1695664635573; 
 Mon, 25 Sep 2023 10:57:15 -0700 (PDT)
Received: from grind.. ([177.94.42.59]) by smtp.gmail.com with ESMTPSA id
 i3-20020a17090a65c300b00262ca945cecsm3312722pjs.54.2023.09.25.10.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 10:57:15 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 00/19] riscv: split TCG/KVM accelerators from cpu.c
Date: Mon, 25 Sep 2023 14:56:50 -0300
Message-ID: <20230925175709.35696-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x435.google.com
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

This new version has a simple copyright change in the tcg-cpu.c file,
patch 01, suggested by Alistair in v3. No other changes made.

All patches acked/reviewed.

Changes from v3:
- patch 1:
  - use cpu.c copyright notice in tcg-cpu.c
- v3 link: https://lore.kernel.org/qemu-riscv/20230920112020.651006-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (19):
  target/riscv: introduce TCG AccelCPUClass
  target/riscv: move riscv_cpu_realize_tcg() to TCG::cpu_realizefn()
  target/riscv: move riscv_cpu_validate_set_extensions() to tcg-cpu.c
  target/riscv: move riscv_tcg_ops to tcg-cpu.c
  target/riscv/cpu.c: add .instance_post_init()
  target/riscv: move 'host' CPU declaration to kvm.c
  target/riscv/cpu.c: mark extensions arrays as 'const'
  target/riscv: move riscv_cpu_add_kvm_properties() to kvm.c
  target/riscv: make riscv_add_satp_mode_properties() public
  target/riscv: remove kvm-stub.c
  target/riscv: introduce KVM AccelCPUClass
  target/riscv: move KVM only files to kvm subdir
  target/riscv/kvm: do not use riscv_cpu_add_misa_properties()
  target/riscv/cpu.c: export set_misa()
  target/riscv/tcg: introduce tcg_cpu_instance_init()
  target/riscv/cpu.c: make misa_ext_cfgs[] 'const'
  target/riscv/tcg: move riscv_cpu_add_misa_properties() to tcg-cpu.c
  target/riscv/cpu.c: export isa_edata_arr[]
  target/riscv/cpu: move priv spec functions to tcg-cpu.c

 hw/intc/riscv_aplic.c                 |   2 +-
 hw/riscv/virt.c                       |   2 +-
 target/riscv/cpu.c                    | 988 ++------------------------
 target/riscv/cpu.h                    |  30 +-
 target/riscv/csr.c                    |   1 +
 target/riscv/kvm-stub.c               |  30 -
 target/riscv/{kvm.c => kvm/kvm-cpu.c} | 120 +++-
 target/riscv/{ => kvm}/kvm_riscv.h    |   4 -
 target/riscv/kvm/meson.build          |   1 +
 target/riscv/meson.build              |   4 +-
 target/riscv/tcg/meson.build          |   2 +
 target/riscv/tcg/tcg-cpu.c            | 883 +++++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.h            |  27 +
 13 files changed, 1113 insertions(+), 981 deletions(-)
 delete mode 100644 target/riscv/kvm-stub.c
 rename target/riscv/{kvm.c => kvm/kvm-cpu.c} (91%)
 rename target/riscv/{ => kvm}/kvm_riscv.h (89%)
 create mode 100644 target/riscv/kvm/meson.build
 create mode 100644 target/riscv/tcg/meson.build
 create mode 100644 target/riscv/tcg/tcg-cpu.c
 create mode 100644 target/riscv/tcg/tcg-cpu.h

-- 
2.41.0


