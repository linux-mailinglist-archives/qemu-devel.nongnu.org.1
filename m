Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99624787B54
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 00:16:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZIbN-0007dy-ES; Thu, 24 Aug 2023 18:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZIbK-0007dC-UR
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 18:14:50 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZIbI-0005vs-FS
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 18:14:50 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5732481b242so239907eaf.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 15:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692915286; x=1693520086;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8jhibZdpXIVuFFBL69YnfGXyedV2du86T3CjXRnhyx4=;
 b=DMvwk6vNW8bohehtSmnWwTyWKzi5WDDBntFLkyDpPSBd3M2UgApZ8XgT8ZZnRWcrP+
 YCmNt1QnqkTQ7GSP4TkjA9Rpvyoor3lLyVBK5ftSktHC2jqH06oeu90pu71eztBCCkH/
 mXYv1uc+tM89sgiQwHSu7zkT29oJjIQlCtcpiVihlF6AeJxSqnj+TXNon6uOhBzcIu+h
 a0WRmJiQzrsf/WJseyMSF8hmy3ZoOwOyN5rJMo+q9JmRqjJb+ra29hMuj8UaSe3WNJk5
 iOa5yMRTe+0tZmhOv1IFCgXe+I3tChw1n8KVGWm+ZPHIuc4is3Bec0Re1EpCi511ntyq
 qsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692915286; x=1693520086;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8jhibZdpXIVuFFBL69YnfGXyedV2du86T3CjXRnhyx4=;
 b=TsDK9eRfGY3giI/Np/gqrnCF1lRicS5HLmcIZ/ozdwnUreZOLDnWc2FyJOxRyIhmUM
 KQ326zD6qt71bdf9BIqEVosMg7h/xePgw8gRzhabGo8LbHwQDT/FnML5aPtpKN+AnzbD
 5aCTBRnySlfdh7MducHwH5K44xDNKyC2eHyGt3XF/mOt5tIhpg3akqW6xmZXxoG0bUSV
 juMOKNif2EESFtSQ5kJDMHuv6tzDo4/7Ctgz/msBhQuqao0FL6XL3LUT6Xcc2beqcVi9
 I9SnTEAKkHnNcd2/FZbPtbUzpSsMoHibCXs5T4I9akRkza52YwtoG7Kjjos9Fc7jTifk
 Kltw==
X-Gm-Message-State: AOJu0YznJRNh3zB25G+En6/uIPbWvB7VKmPb71o/si0mMgdhAM0FOXcs
 kcEjAsMPO7d0d8+3UZvlNluFoxmmvJYk68aG8Oc=
X-Google-Smtp-Source: AGHT+IEtNNQvDsTZKGcPvwGOpzlbYPHXdVlrg0cGw1zAXBlKERs6APo97WxQGied2muc90d1e41P5A==
X-Received: by 2002:a4a:3457:0:b0:56c:7428:4a35 with SMTP id
 n23-20020a4a3457000000b0056c74284a35mr4116199oof.7.1692915286511; 
 Thu, 24 Aug 2023 15:14:46 -0700 (PDT)
Received: from grind.. ([179.93.21.19]) by smtp.gmail.com with ESMTPSA id
 o129-20020a4a4487000000b00565fcfabab8sm256338ooa.21.2023.08.24.15.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 15:14:46 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH RESEND v8 00/20] riscv: 'max' CPU, detect user choice in TCG
Date: Thu, 24 Aug 2023 19:14:20 -0300
Message-ID: <20230824221440.484675-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a resend of these two patch sets because they no longer apply
into Alistair's riscv-to-apply.next:

[PATCH v8 00/12] riscv: add 'max' CPU, deprecate 'any'
https://lore.kernel.org/qemu-riscv/20230815223741.433763-1-dbarboza@ventanamicro.com/

[PATCH v3 0/8] riscv: detecting user choice in TCG extensions
https://lore.kernel.org/qemu-riscv/20230815224733.434682-1-dbarboza@ventanamicro.com/


They're being sent in a single package for convenience. No other changes
made from their old versions aside from the rebase.

Patches missing acks: 4,7,8

Changes from v7:
- patch 7:
  - add riscv_cpu_add_qdev_prop_array() function instead of a macro
- patch 8:
  - add riscv_cpu_add_kvm_unavail_prop_array() function instead of a
    macro
- v7 link: https://lore.kernel.org/qemu-riscv/20230815201559.398643-1-dbarboza@ventanamicro.com/

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
  avocado, risc-v: add opensbi tests for 'max' CPU
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

 docs/about/deprecated.rst      |  12 +
 target/riscv/cpu-qom.h         |   1 +
 target/riscv/cpu.c             | 555 +++++++++++++++++++++++----------
 target/riscv/cpu.h             |   2 +
 target/riscv/kvm.c             |   8 +-
 tests/avocado/riscv_opensbi.py |  16 +
 6 files changed, 425 insertions(+), 169 deletions(-)

-- 
2.41.0


