Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E357E3358
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:56:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CFy-0005Zk-Bz; Mon, 06 Nov 2023 21:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CFt-0005Yw-UV
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:55:53 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CFq-00078Y-MI
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:55:53 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-28037d046b0so3800900a91.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325749; x=1699930549; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f/FnO5BqIwinhdPp5rJCe49jcUAaZlpfMHLrA54Uk2E=;
 b=CjgQ/fmmk4C/A71wXHL1QXeaPNSO4OkwYE4vre4KnuMxMRIF5mtW89nzXF1vOb4SKH
 V6o+bmBU2iZ7uJC67lrL5bKof2FqxXkmAdEEO3iMlG3cY/oR9bEo5yyk+9EGMX8UFh6W
 83M8S044Mpe4wvinV7NqbgWM2AW0vGofN5IkhPnrkSpaROhXRXqu5hxUR7nUmOcjm19F
 gUloJbszhXqf8DbRVBD4ubeZnGfpG2Hjrh1LEOH6giz0ZuUdo3r0o/aXVh5TNvvy4k44
 8W0A9fRd+Rp11nvji1Vszp8oD5DfWEBxdNa2M63aQmWgHjHqd5EIJe0i679JmDotOixL
 SwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325749; x=1699930549;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f/FnO5BqIwinhdPp5rJCe49jcUAaZlpfMHLrA54Uk2E=;
 b=anDicVp4bbkDxnRikyZ2O6JsvhCf5JjK5neoEgyCFF29lIWMsQmOF5zrrG+mTHWRt2
 SZcpHV7KOAqkr8ijGh4d84l73CZAm1lbsmQ6OOth4zydUcCwpPU++Q6YZLDOY1ucA5UU
 0PrF82wcMFXlfZgwY/NiXltAQlALiRWpJj66BK4iC5tPYa06BSU5BCX6Hqqm9xVTgnXt
 xGH6qTPbF910AnOhy9yFxMTYveJmkmT4K31s8s4Qe44EPntOgLaAjzX1G3xt22XDczra
 yqzFd8n0VQIaFhGL5lRuN61jiqxr9nrADXulln9B6KhCFW8kcPqA0HGWKVrC32eFMQn6
 SAWQ==
X-Gm-Message-State: AOJu0YzBifqnM378Hwa0emiOuYyX5RF5B8Sbi5P9sRM7Dvnx6BQ6QXSl
 hVJOpiTjFNC1Xw06XO6xDZdycCdokwk1hNsfM9I=
X-Google-Smtp-Source: AGHT+IFh3cO5+v7mSKTga0mYxqNd5pjbpYjJMMPjVWvO11At+q/9MWDGzx6B/XxVCLg9niwyH2/wSg==
X-Received: by 2002:a17:90b:1b46:b0:27d:2109:6279 with SMTP id
 nv6-20020a17090b1b4600b0027d21096279mr7968921pjb.12.1699325749323; 
 Mon, 06 Nov 2023 18:55:49 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ee8600b001c0a4146961sm6528619pld.19.2023.11.06.18.55.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 18:55:48 -0800 (PST)
Message-ID: <73a8c07c-0172-4959-a1ce-56b8d39bba4d@linaro.org>
Date: Mon, 6 Nov 2023 18:55:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PULL 00/35] tcg patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Dangit, forgot the PULL tag.

r~

On 11/6/23 18:48, Richard Henderson wrote:
> The following changes since commit 3e01f1147a16ca566694b97eafc941d62fa1e8d8:
> 
>    Merge tag 'pull-sp-20231105' of https://gitlab.com/rth7680/qemu into staging (2023-11-06 09:34:22 +0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20231106
> 
> for you to fetch changes up to d36ce28be424385fc9f7273bf5c15ce815b5cf4e:
> 
>    tcg/sparc64: Implement tcg_out_extrl_i64_i32 (2023-11-06 10:48:46 -0800)
> 
> ----------------------------------------------------------------
> util: Add cpuinfo for loongarch64
> tcg/loongarch64: Use cpuinfo.h
> tcg/loongarch64: Improve register allocation for INDEX_op_qemu_ld_a*_i128
> host/include/loongarch64: Add atomic16 load and store
> tcg: Move expanders out of line
> tcg/mips: Always implement movcond
> tcg/mips: Implement neg opcodes
> tcg/loongarch64: Implement neg opcodes
> tcg: Make movcond and neg required opcodes
> tcg: Optimize env memory operations
> tcg: Canonicalize sub of immediate to add
> tcg/sparc64: Implement tcg_out_extrl_i64_i32
> 
> ----------------------------------------------------------------
> Richard Henderson (35):
>        accel/tcg: Move HMP info jit and info opcount code
>        tcg: Add C_N2_I1
>        tcg/loongarch64: Use C_N2_I1 for INDEX_op_qemu_ld_a*_i128
>        util: Add cpuinfo for loongarch64
>        tcg/loongarch64: Use cpuinfo.h
>        host/include/loongarch64: Add atomic16 load and store
>        accel/tcg: Remove redundant case in store_atom_16
>        accel/tcg: Fix condition for store_atom_insert_al16
>        tcg: Mark tcg_gen_op* as noinline
>        tcg: Move tcg_gen_op* out of line
>        tcg: Move generic expanders out of line
>        tcg: Move 32-bit expanders out of line
>        tcg: Move 64-bit expanders out of line
>        tcg: Move vec_gen_* declarations to tcg-internal.h
>        tcg: Move tcg_gen_opN declarations to tcg-internal.h
>        tcg: Unexport tcg_gen_op*_{i32,i64}
>        tcg: Move tcg_constant_* out of line
>        tcg: Move tcg_temp_new_*, tcg_global_mem_new_* out of line
>        tcg: Move tcg_temp_free_* out of line
>        tcg/mips: Split out tcg_out_setcond_int
>        tcg/mips: Always implement movcond
>        tcg: Remove TCG_TARGET_HAS_movcond_{i32,i64}
>        tcg/mips: Implement neg opcodes
>        tcg/loongarch64: Implement neg opcodes
>        tcg: Remove TCG_TARGET_HAS_neg_{i32,i64}
>        tcg: Don't free vector results
>        tcg/optimize: Pipe OptContext into reset_ts
>        tcg/optimize: Split out cmp_better_copy
>        tcg/optimize: Optimize env memory operations
>        tcg: Eliminate duplicate env store operations
>        tcg/optimize: Split out arg_new_constant
>        tcg: Canonicalize subi to addi during opcode generation
>        tcg/optimize: Canonicalize subi to addi during optimization
>        tcg/optimize: Canonicalize sub2 with constants to add2
>        tcg/sparc64: Implement tcg_out_extrl_i64_i32
> 
>   accel/tcg/internal-common.h                        |   2 -
>   host/include/loongarch64/host/atomic128-ldst.h     |  52 ++
>   host/include/loongarch64/host/cpuinfo.h            |  21 +
>   .../loongarch64/host/load-extract-al16-al8.h       |  39 ++
>   host/include/loongarch64/host/store-insert-al16.h  |  12 +
>   include/exec/cputlb.h                              |   1 -
>   include/tcg/tcg-op-common.h                        | 538 ++---------------
>   include/tcg/tcg-opc.h                              |   8 +-
>   include/tcg/tcg-temp-internal.h                    |  56 +-
>   include/tcg/tcg.h                                  |  82 ---
>   tcg/aarch64/tcg-target.h                           |   4 -
>   tcg/arm/tcg-target.h                               |   2 -
>   tcg/i386/tcg-target.h                              |   4 -
>   tcg/loongarch64/tcg-target-con-set.h               |   2 +-
>   tcg/loongarch64/tcg-target.h                       |  12 +-
>   tcg/mips/tcg-target.h                              |   4 -
>   tcg/ppc/tcg-target.h                               |   4 -
>   tcg/riscv/tcg-target.h                             |   4 -
>   tcg/s390x/tcg-target.h                             |   4 -
>   tcg/sparc64/tcg-target.h                           |   4 -
>   tcg/tcg-internal.h                                 |  18 +
>   tcg/tci/tcg-target.h                               |   4 -
>   accel/tcg/cputlb.c                                 |  17 +-
>   accel/tcg/monitor.c                                | 154 +++++
>   accel/tcg/translate-all.c                          | 127 ----
>   tcg/optimize.c                                     | 370 ++++++++++--
>   tcg/tcg-op-gvec.c                                  | 112 ++--
>   tcg/tcg-op.c                                       | 636 ++++++++++++++++-----
>   tcg/tcg.c                                          | 131 ++++-
>   tcg/tci.c                                          |   2 -
>   util/cpuinfo-loongarch.c                           |  35 ++
>   accel/tcg/ldst_atomicity.c.inc                     |  14 +-
>   tcg/loongarch64/tcg-target.c.inc                   |  34 +-
>   tcg/mips/tcg-target.c.inc                          | 329 +++++------
>   tcg/sparc64/tcg-target.c.inc                       |   5 +
>   util/meson.build                                   |   2 +
>   36 files changed, 1535 insertions(+), 1310 deletions(-)
>   create mode 100644 host/include/loongarch64/host/atomic128-ldst.h
>   create mode 100644 host/include/loongarch64/host/cpuinfo.h
>   create mode 100644 host/include/loongarch64/host/load-extract-al16-al8.h
>   create mode 100644 host/include/loongarch64/host/store-insert-al16.h
>   create mode 100644 util/cpuinfo-loongarch.c


