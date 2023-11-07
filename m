Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C487E337C
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:06:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CQ9-0005Ta-F6; Mon, 06 Nov 2023 22:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r0CQ2-00051i-FO
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:06:23 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r0CPz-0001CI-Cz
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:06:21 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6ce2eaf7c2bso3400186a34.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699326378; x=1699931178; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=esV4I9dGU5fPC+Q9FNytWpzvWOtRhSCYExFq7yDz86w=;
 b=M0MjjmP7CiyJqrtI73AcvIe5+o4vNiud42wquQ70KbhrGBjakA/X/DJSrEeVdEHUsj
 SZNcrGDNmnfjeteVgzJ2a8xUWBJqe4hwvTxM7jKx4JymMKR4I361Ah428t7+N3pjMAzZ
 BsgIgqgVS1xLotPSRGCwW4Z40ygeJy+SctLbVqFBpKjud/uHX0lSbgWQMWkC1uK821aj
 oosdbevuhRhQpRZIu4Dpw6sDta6StbBut4YiVJWJQRZegnESuZUCX/kZVAsbYyqIZYjh
 sjbEg031hx+sLZUT9uVx5kuF4OC/S0QaaQZQ2jTJxf94UEA0aJU/K9rOMKVDeNa+X4Ci
 btAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326378; x=1699931178;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=esV4I9dGU5fPC+Q9FNytWpzvWOtRhSCYExFq7yDz86w=;
 b=JUmk72RhhdoF2TlbKtKN19gei4CSGQCX1xpIANKRh9E21G0ypQ50ZtalnVOl2XW0/I
 AXvekquEDYPh6Gndd+uFIbVhXC5xS1mXJJA8ODZI48ezYDQ72tGD1llkC3v3BKpACGMd
 I0wE3QOUQ95mMcUJEm7bCkZ/vuhyWys6jtIWZh8zYuAROLPNd9nbcxDFESrKn0PlhZwZ
 1gdEyTM3BWLtW4utFET57UTemReP6G9b0r481G0kLfEdlwyaKwITDp50fmJ8Lf0sOrDW
 F/lzRAJ2vkgAUuur4jhb7uPSqXgWpUTKTHPGB1DVz174x6RYxPKUd/h8p7rjl56SVlPN
 fN6A==
X-Gm-Message-State: AOJu0YwAcJX8mATW+BYDliaCjWP2NoJvV79Zgr6A+vOoSZlJSKv0zdJy
 Iza94inUUXboBbg4Is+NYDGU2deETBCudqdxXe9gkGJM
X-Google-Smtp-Source: AGHT+IGUU6aTb47TWKmbUPvADO1y4yBAaTv4HIhd4xdyHYmsTXMlIfOZPVIJK7h+4Y0C9cG8osOuqMMft225+OiZnaU=
X-Received: by 2002:a05:6830:43a6:b0:6c4:da36:f949 with SMTP id
 s38-20020a05683043a600b006c4da36f949mr37570115otv.8.1699326377925; Mon, 06
 Nov 2023 19:06:17 -0800 (PST)
MIME-Version: 1.0
References: <20231107024842.7650-1-richard.henderson@linaro.org>
 <73a8c07c-0172-4959-a1ce-56b8d39bba4d@linaro.org>
In-Reply-To: <73a8c07c-0172-4959-a1ce-56b8d39bba4d@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 7 Nov 2023 11:06:05 +0800
Message-ID: <CAJSP0QU-kc5FHzaPfDfKRj61cjLfphTywV=Y4Sd_k6q7bJqfHg@mail.gmail.com>
Subject: Re: [PULL 00/35] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, 7 Nov 2023 at 10:56, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Dangit, forgot the PULL tag.

Okay, thanks for pointing it out. I've added this to the staging branch.

Stefan

>
> r~
>
> On 11/6/23 18:48, Richard Henderson wrote:
> > The following changes since commit 3e01f1147a16ca566694b97eafc941d62fa1e8d8:
> >
> >    Merge tag 'pull-sp-20231105' of https://gitlab.com/rth7680/qemu into staging (2023-11-06 09:34:22 +0800)
> >
> > are available in the Git repository at:
> >
> >    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20231106
> >
> > for you to fetch changes up to d36ce28be424385fc9f7273bf5c15ce815b5cf4e:
> >
> >    tcg/sparc64: Implement tcg_out_extrl_i64_i32 (2023-11-06 10:48:46 -0800)
> >
> > ----------------------------------------------------------------
> > util: Add cpuinfo for loongarch64
> > tcg/loongarch64: Use cpuinfo.h
> > tcg/loongarch64: Improve register allocation for INDEX_op_qemu_ld_a*_i128
> > host/include/loongarch64: Add atomic16 load and store
> > tcg: Move expanders out of line
> > tcg/mips: Always implement movcond
> > tcg/mips: Implement neg opcodes
> > tcg/loongarch64: Implement neg opcodes
> > tcg: Make movcond and neg required opcodes
> > tcg: Optimize env memory operations
> > tcg: Canonicalize sub of immediate to add
> > tcg/sparc64: Implement tcg_out_extrl_i64_i32
> >
> > ----------------------------------------------------------------
> > Richard Henderson (35):
> >        accel/tcg: Move HMP info jit and info opcount code
> >        tcg: Add C_N2_I1
> >        tcg/loongarch64: Use C_N2_I1 for INDEX_op_qemu_ld_a*_i128
> >        util: Add cpuinfo for loongarch64
> >        tcg/loongarch64: Use cpuinfo.h
> >        host/include/loongarch64: Add atomic16 load and store
> >        accel/tcg: Remove redundant case in store_atom_16
> >        accel/tcg: Fix condition for store_atom_insert_al16
> >        tcg: Mark tcg_gen_op* as noinline
> >        tcg: Move tcg_gen_op* out of line
> >        tcg: Move generic expanders out of line
> >        tcg: Move 32-bit expanders out of line
> >        tcg: Move 64-bit expanders out of line
> >        tcg: Move vec_gen_* declarations to tcg-internal.h
> >        tcg: Move tcg_gen_opN declarations to tcg-internal.h
> >        tcg: Unexport tcg_gen_op*_{i32,i64}
> >        tcg: Move tcg_constant_* out of line
> >        tcg: Move tcg_temp_new_*, tcg_global_mem_new_* out of line
> >        tcg: Move tcg_temp_free_* out of line
> >        tcg/mips: Split out tcg_out_setcond_int
> >        tcg/mips: Always implement movcond
> >        tcg: Remove TCG_TARGET_HAS_movcond_{i32,i64}
> >        tcg/mips: Implement neg opcodes
> >        tcg/loongarch64: Implement neg opcodes
> >        tcg: Remove TCG_TARGET_HAS_neg_{i32,i64}
> >        tcg: Don't free vector results
> >        tcg/optimize: Pipe OptContext into reset_ts
> >        tcg/optimize: Split out cmp_better_copy
> >        tcg/optimize: Optimize env memory operations
> >        tcg: Eliminate duplicate env store operations
> >        tcg/optimize: Split out arg_new_constant
> >        tcg: Canonicalize subi to addi during opcode generation
> >        tcg/optimize: Canonicalize subi to addi during optimization
> >        tcg/optimize: Canonicalize sub2 with constants to add2
> >        tcg/sparc64: Implement tcg_out_extrl_i64_i32
> >
> >   accel/tcg/internal-common.h                        |   2 -
> >   host/include/loongarch64/host/atomic128-ldst.h     |  52 ++
> >   host/include/loongarch64/host/cpuinfo.h            |  21 +
> >   .../loongarch64/host/load-extract-al16-al8.h       |  39 ++
> >   host/include/loongarch64/host/store-insert-al16.h  |  12 +
> >   include/exec/cputlb.h                              |   1 -
> >   include/tcg/tcg-op-common.h                        | 538 ++---------------
> >   include/tcg/tcg-opc.h                              |   8 +-
> >   include/tcg/tcg-temp-internal.h                    |  56 +-
> >   include/tcg/tcg.h                                  |  82 ---
> >   tcg/aarch64/tcg-target.h                           |   4 -
> >   tcg/arm/tcg-target.h                               |   2 -
> >   tcg/i386/tcg-target.h                              |   4 -
> >   tcg/loongarch64/tcg-target-con-set.h               |   2 +-
> >   tcg/loongarch64/tcg-target.h                       |  12 +-
> >   tcg/mips/tcg-target.h                              |   4 -
> >   tcg/ppc/tcg-target.h                               |   4 -
> >   tcg/riscv/tcg-target.h                             |   4 -
> >   tcg/s390x/tcg-target.h                             |   4 -
> >   tcg/sparc64/tcg-target.h                           |   4 -
> >   tcg/tcg-internal.h                                 |  18 +
> >   tcg/tci/tcg-target.h                               |   4 -
> >   accel/tcg/cputlb.c                                 |  17 +-
> >   accel/tcg/monitor.c                                | 154 +++++
> >   accel/tcg/translate-all.c                          | 127 ----
> >   tcg/optimize.c                                     | 370 ++++++++++--
> >   tcg/tcg-op-gvec.c                                  | 112 ++--
> >   tcg/tcg-op.c                                       | 636 ++++++++++++++++-----
> >   tcg/tcg.c                                          | 131 ++++-
> >   tcg/tci.c                                          |   2 -
> >   util/cpuinfo-loongarch.c                           |  35 ++
> >   accel/tcg/ldst_atomicity.c.inc                     |  14 +-
> >   tcg/loongarch64/tcg-target.c.inc                   |  34 +-
> >   tcg/mips/tcg-target.c.inc                          | 329 +++++------
> >   tcg/sparc64/tcg-target.c.inc                       |   5 +
> >   util/meson.build                                   |   2 +
> >   36 files changed, 1535 insertions(+), 1310 deletions(-)
> >   create mode 100644 host/include/loongarch64/host/atomic128-ldst.h
> >   create mode 100644 host/include/loongarch64/host/cpuinfo.h
> >   create mode 100644 host/include/loongarch64/host/load-extract-al16-al8.h
> >   create mode 100644 host/include/loongarch64/host/store-insert-al16.h
> >   create mode 100644 util/cpuinfo-loongarch.c
>
>

