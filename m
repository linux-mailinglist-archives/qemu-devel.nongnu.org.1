Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B134275B575
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 19:20:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMXJf-0007gk-Gc; Thu, 20 Jul 2023 13:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMXJY-0007g1-A0
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 13:19:45 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMXJW-0004XQ-GZ
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 13:19:44 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1b0138963ffso787217fac.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 10:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689873581; x=1690478381;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c3RsdBYGgUvCInluWyGBIiR7xObY5sIKM+UawJkhGYo=;
 b=bID35IV/l/etufiAsecruyIOro66sxl+dUPXo7MWSri00VBYwuIwTnXKzevzt8/cPH
 qyJ7lcsb8i6HRaWtS5wefeZSt2VF94vyNaTIo6scgpsMwLnk7yGaape2EPgP7Io4WFS4
 J0bLWzU8RT30RIn/+ATDLgTzquQbgfxxk1euUz/bWInyjLH8OEgWOSu4LGE974aUfaNJ
 x2WtwRLqhF8v89gUVvu4go71dhX7KhJU4s9VW9wl5cXdKhG4v7ANXVSeSEGHvt/Wh6J9
 0l34QdFnseST1cABiXroF6vjag0CL5f9QJAe+N9ziH/CwRZuyQDFjIf4TIFfFWYf/UAi
 BW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689873581; x=1690478381;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c3RsdBYGgUvCInluWyGBIiR7xObY5sIKM+UawJkhGYo=;
 b=MCadLmWX9N0oMeue0JOPReH/UjQf9pEw7v9n8pF+S6HOS92MFrDOxTaOyiroIFUFLu
 DjnPGe8wXLkop3an3+U2wSy/4tlITnpeqLYlnZ2FzpwDT0nufazQnRk5gU+Dd/LRijmz
 r75niTWz/bs5a5KQ8M0wOCwpoXjMxCCCrXCIPVMBYDa+BvORWg8cX/jqzZ2Kub6UQRkr
 IFbyirtmOpxrekYzN5LH8Wip+FSsJFexVAnBOtUptCdyEAQNCyLwklH/JFVd+/Cw44Lf
 aor4SIZzlGcnQVqmzaYxmdRxwjZpsDUKXs2+0wVeDUQPj9qriMhF+/VXtZBzob8BhVVo
 k8Ew==
X-Gm-Message-State: ABy/qLZ3ldRH5DbS4NpfEedxhTxIKneQ7FxhS0AmfHm/2M7c/zOY1PLp
 O7dBI4d/vvqltIrRMQcJpts+fOkYXR/RyORUCTOOJg==
X-Google-Smtp-Source: APBJJlEqHuWyIj5FUY5kCgYq6I6InKDTxcAx/lqa8R3KqTjCKJ4jTO/mbKqhnuT9kWUxvsqB6Ga3LA==
X-Received: by 2002:a05:6870:468d:b0:1b7:8950:f426 with SMTP id
 a13-20020a056870468d00b001b78950f426mr195079oap.15.1689873581015; 
 Thu, 20 Jul 2023 10:19:41 -0700 (PDT)
Received: from grind.. (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 i2-20020a4aab02000000b0055975f57993sm582564oon.42.2023.07.20.10.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 10:19:40 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 v5 00/11] riscv: add 'max' CPU, deprecate 'any'
Date: Thu, 20 Jul 2023 14:19:22 -0300
Message-ID: <20230720171933.404398-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x36.google.com
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

I'm sending this new version based on another observation I made during
another follow-up work (I'll post it shortly).

'mmu' and 'pmp' aren't really extensions in the most tradicional sense,
they're more like features. So, in patch 1, I moved both to the new
riscv_cpu_options array.

This was observed when I was trying to match each existing extension
with a priv_spec. I realized that we have 4 missing entries in
isa_edata_arr[] that we're considering as extensions: ext_zmmul, epmp,
mmu and pmp. The first 2 were sent as bug fixes for 8.1. mmu and pmp
were moved to riscv_cpu_options[] to be handled as such.

A small cosmetic change was made in patch 9 as well.

Patches missing review: 1, 3, 4, 8, 10, 11 

Changes from v4:
- patch 1:
  - add 'mmu' and 'pmp' in riscv_cpu_options
- patch 9:
  - changed 'max' cpu 'for' loop to use ARRAY_SIZE()
- v4 link: https://lore.kernel.org/qemu-riscv/20230718210329.200404-1-dbarboza@ventanamicro.com/

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
 target/riscv/cpu.c             | 176 +++++++++++++++++++++++++--------
 tests/avocado/riscv_opensbi.py |  16 +++
 4 files changed, 164 insertions(+), 41 deletions(-)

-- 
2.41.0


