Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CB7758676
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 23:05:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLrrE-0002Uc-GO; Tue, 18 Jul 2023 17:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLrrB-0002UL-Kz
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 17:03:41 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLrr6-0007An-7Z
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 17:03:41 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6b9ede6195cso169843a34.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 14:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689714215; x=1692306215;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iKmZ/gpa4rUX2TdIepaylDRDGOlOcgqrXaKT4AcwHa8=;
 b=TDcxEWnjC+hOfj7CGJ/DfFPswnBltzYFp/DkcPk/jmaQVaKHSEUoGiKZB47S60ZJIQ
 N8vK9tpkzGUlqFEXfxawoWeylt0L7ZbdmgItLonWUU3tsvJyRVpyUnrvIyFaUW36s+pt
 /HrXIfsvud3wTE6CqAZMY+QkfltB0jmIX+KS0k7MJzUbEjdOcxyZFjRNIHm9oRKxhBkd
 Vu+SzvCwlfKNbY88ZhNFPeoueu8PB5yGiWCJGow4S4hxenE0q43C61KXIAL3R4c3mP3m
 k9LpOvbSs2hZHhHa6J8TCNwtEoFmIL0GpVIZVyWg8G0o8O1F96qfQjGXEu5ubH0m/BTX
 YYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689714215; x=1692306215;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iKmZ/gpa4rUX2TdIepaylDRDGOlOcgqrXaKT4AcwHa8=;
 b=Kn5Y8Xpq6OqRu+1EnGFTROEvV61L0Y3enyRYv7FYLbjnLaZUQL/tiUiRkUUnbY7LwZ
 kZLEk09uHngforixN/eFEHEj7rIzZZsyVfGULNoNG6afoKmmHd/xFt7Se5iVCYDe8aR3
 gGSMbbt31KmQguKDjXeBuHrcn2ySotUaIfExIMIA6sHlJLvvlUrgPIEAvtrpSMVuejP+
 rYtfDdIGDyjJlGIU7raFK/4W89ORPOf8HleTWpcDCHZR6IPOGSPMPhEmNhS7WPb6N9g4
 aHJ1Sc0d7N8q7epTDW1tpsVTd4k6wp4bZJr+Bso+j/KQrY5Spjx01gJ9J3IP/id9i6mQ
 napQ==
X-Gm-Message-State: ABy/qLaNHTEr+uzofFSTaUiWfbEv8tEE3SbiDujYfAgHwLnTu9IJKc06
 /qKGvbnT3i288v/0BZXmCn7h1NwZiJ2sIX44Qy748Q==
X-Google-Smtp-Source: APBJJlEMqMatPuAPvLxcXQcrABIglP/YEJibjvIYXI3I/zm5RDtKfhKJYKi5nYyOZsSB30d+yZzXJQ==
X-Received: by 2002:a9d:6c02:0:b0:6b7:53df:1db3 with SMTP id
 f2-20020a9d6c02000000b006b753df1db3mr15338991otq.0.1689714214970; 
 Tue, 18 Jul 2023 14:03:34 -0700 (PDT)
Received: from grind.. (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a056830140200b006b96384ba1csm1160657otp.77.2023.07.18.14.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 14:03:34 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 v4 00/11] riscv: add 'max' CPU, deprecate 'any'
Date: Tue, 18 Jul 2023 18:03:18 -0300
Message-ID: <20230718210329.200404-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x335.google.com
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

This new version has some adjustments w.r.t the KVM code that got a bit
neglected in the last 3 versions. The most notable change is in patch 3,
a new patch where we're moving the KVM property handling into an
exclusive helper. This helped to unclog riscv_cpu_add_user_properties()
a lot, making it easier for future cleanups we're planning to do in this
code.

Patch 4 (new) helped to padronize the code even more, allowing for more
macro usages to reduce repetition. Patch 8 (new) is basically patch 7
for KVM properties.

Patches missing review: 3, 4, 8, 10, 11 

Changes from v3:
- patch 1:
  - skip existing riscv_cpu_options before calling qdev_prop_add_static()
- patch 3 (new):
  - move kvm CPU property handling to riscv_cpu_add_kvm_properties()
- patch 4 (new):
  - remove DEFINE_PROP_END_OF_LIST() for riscv_cpu_extensions[]
- patch 7 (former 5):
  - rename macro to ADD_CPU_QDEV_PROPERTIES_ARRAY()
- patch 8 (new):
  - add ADD_UNAVAIL_KVM_PROP_ARRAY macro
- v3 link: https://lore.kernel.org/qemu-riscv/20230714174311.672359-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (11):
  target/riscv/cpu.c: split CPU options from riscv_cpu_extensions[]
  target/riscv/cpu.c: skip 'bool' check when filtering KVM props
  target/riscv/cpu.c: split kvm prop handling to its own helper
  target/riscv/cpu.c: del DEFINE_PROP_END_OF_LIST() from
    riscv_cpu_extensions
  target/riscv/cpu.c: split vendor exts from riscv_cpu_extensions[]
  target/riscv/cpu.c: split non-ratified exts from
    riscv_cpu_extensions[]
  target/riscv/cpu.c: add ADD_CPU_QDEV_PROPERTIES_ARRAY() macro
  target/riscv/cpu.c: add ADD_UNAVAIL_KVM_PROP_ARRAY() macro
  target/riscv: add 'max' CPU type
  avocado, risc-v: add opensbi tests for 'max' CPU
  target/riscv: deprecate the 'any' CPU type

 docs/about/deprecated.rst      |  12 +++
 target/riscv/cpu-qom.h         |   1 +
 target/riscv/cpu.c             | 169 +++++++++++++++++++++++++--------
 tests/avocado/riscv_opensbi.py |  16 ++++
 4 files changed, 160 insertions(+), 38 deletions(-)

-- 
2.41.0


