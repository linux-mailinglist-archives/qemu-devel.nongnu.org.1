Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E036C7A7A67
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 13:26:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qivFx-0005UI-He; Wed, 20 Sep 2023 07:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qivFu-0005TP-9L
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:20:30 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qivFs-00022K-IV
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:20:30 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6c21b2c6868so3873835a34.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 04:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695208827; x=1695813627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cD4Yh3yYi1/+2MPcY5wY2Z55yifTh4XeSglHuN/8j9Q=;
 b=nEViZ/rBXU8VdGUqvZ0we4rlY0dtL7JNmNY21ifDEPGS1IVWdnAfohqmvBYrt8g6Yd
 epDZ9zgI8LK4yMz9qzrrLc+gSRKzVID5LgdNZ+5yxunGmMVzABTEuN2CXN2FeoZ8FpI/
 6vclE4a5tKwPxatYTee2HSJcYGOGZP67TGFTpWmVvmO58EnZF4or9o9aU74ThMSrN/5L
 jLWR+JF2P+yv81Y59+k2u5lv81M2GQ34lX+xerG/PJUVfiboNgE5Wt6vKsIE55wLiUJc
 oohfXLBJ/auIgGtwKGdT4pQelp8NQAjcQxB0FYseHkXGIK/gjGw3m57+azQANf9uTyqw
 ue/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695208827; x=1695813627;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cD4Yh3yYi1/+2MPcY5wY2Z55yifTh4XeSglHuN/8j9Q=;
 b=OOldyhUr0jpfcSlZUQyvOwsQxtKDS2/Qb5yKC0HP4E9d9x7Mr900q1OIZo0D2waNRw
 6aBAzc7Uqpdg6hLWNCLv0JccDG1ril/vY5OtqtHEUSv45PNb8lGAkhMUJsz6w4UyMimY
 1KHCGlf/NGcwAVfDq3lCUPEcAuzLgoSSCcHFXMn9lqWrVjLWgo0mkKsk0/s1UvgjJQ3o
 ryPCguYpwUwQNjY2NpTlTCXEBIgrPzoc95B8Y1tZGfSdYGOyvsGg1x2VVo1UttjvGmuU
 8v7gS855wTtC/pB4MJWfGDXml/PWgcyRkAZ7NqK7Fsu9UgmDSOeB3FHLDAzk+STFM8xa
 7WMA==
X-Gm-Message-State: AOJu0YwlK+BMmjqODWRo7Lzk1uAovzhzSUMw8nlEpUOTjn4Vg8MOHdLY
 ymU8YhFk9JJUeStHAKqX/eEkNlcsBozyeDZHtWU=
X-Google-Smtp-Source: AGHT+IEw0jN/lGWXaEThxMOSGiwufg9NVUw3XLI4Cvsr6rynjCX7e8sNdem072L1XyG0z4uOPL2UzA==
X-Received: by 2002:a05:6830:22d1:b0:6b8:7d12:423d with SMTP id
 q17-20020a05683022d100b006b87d12423dmr2164677otc.18.1695208826737; 
 Wed, 20 Sep 2023 04:20:26 -0700 (PDT)
Received: from grind.. ([2804:7f0:bcc0:bdf2:b7ba:a476:c0e3:fb59])
 by smtp.gmail.com with ESMTPSA id
 q4-20020a9d7c84000000b006b45be2fdc2sm5863955otn.65.2023.09.20.04.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 04:20:26 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 00/19] riscv: split TCG/KVM accelerators from cpu.c
Date: Wed, 20 Sep 2023 08:20:01 -0300
Message-ID: <20230920112020.651006-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x331.google.com
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

In this version we changed patch 10 (remove kvm-stub.c) as suggested by
Phil to not include non-KVM stubs in kvm_riscv.h. A change in patch 05
requested by Zhiwei was also made.

Patches based on Alistair's riscv-to-apply.next.

Patches missing acks: patch 10

Changes from v2:
- patch 05:
  - remove riscv_cpu_add_user_properties() from riscv_host_cpu_init()
- patch 10:
  - do not add non-KVM stubs in kvm_riscv.h
- v2 link: https://lore.kernel.org/qemu-riscv/20230906091647.1667171-1-dbarboza@ventanamicro.com/

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


