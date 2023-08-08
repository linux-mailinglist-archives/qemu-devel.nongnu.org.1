Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1266477405E
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:02:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQ5m-0006np-PU; Tue, 08 Aug 2023 13:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTQ5k-0006na-50
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:01:56 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTQ5g-0001JF-Kh
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:01:55 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31771bb4869so5163242f8f.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691514110; x=1692118910;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8sWzk+iqMQPwc27ifh0zhQTHTdP8jc9ACrpdnmO8nsw=;
 b=FvCTHvdI2ThWlEoHvGK7mM9sf8lLGsyCXavFQSqDS987u5rhD3UV8X7YigJU6bpdB/
 iSkG/XGzXoE6+HN3vumFl6BpWeqxWOHbr3UvFH5hMpmM70isLokZZaZUtpN79GFl7Oq4
 lMz2cW6ZgwKAqmOOej+soziWc9EyVYma2nlZRjFGt6Sl62ZATkIKjQXaSdGTdAov5Cs7
 tvsrTRJuhUGIx0klIaafE3+A23tY/vnhrjP6nv3MTvvlftTXQLQmOab+wCigFP4Mqgrx
 sEtx0gOmB/93N03AbMIAfaO41tmkz+Of9clpHiJv80vBbDclNrU5uYBNml26UwrQ+qXH
 65aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514110; x=1692118910;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8sWzk+iqMQPwc27ifh0zhQTHTdP8jc9ACrpdnmO8nsw=;
 b=H2WU0gHB5nW+Rrmyu5/B0xZCvfuH7XI1D1k1Z7XbS0N5+lRh7zducPGZd7xbrVLJkc
 lU/vEbzFavn5Gykx/+O8qHJFfDD0naIv9Qq1RiBtvJINwMWDV5L21fMAmu5KmTDFfVZx
 G5dIYFe1aXRn5IDl3VFOhr8qkPPF+YlUEDfYsTwWXXxE5L+9NpNiG6iL41DCX6kAkDDM
 H2byvuWMgcbZjJNx2pBXZbCwtF4XWFTL+ICR/Dv+pYZeXs47OeEmMQbYcu6ohqwke/NK
 EcwI0vELMuYc/cqZtC3EPwQ3BcnEYFNROV3KU7PPlbp2g1jPsLl8Nt1SHhgZBbt+BM3M
 reJA==
X-Gm-Message-State: AOJu0YxAsW5MPlrvpZ3K8evEvxk5HHoEijAtOmadFdtQ3WHkKs6bovaY
 0gW0ThbbAmc68zogOEJgJMbVhEgLJH/6Xc1ACFs=
X-Google-Smtp-Source: AGHT+IFklKyeERlN1mT+m8XR+UovE4RmrqqxuYL9T3N++2SML7hd+MP9QNLHa/lSXsVsvWsA31OK7A==
X-Received: by 2002:adf:e78d:0:b0:317:5b3b:89a1 with SMTP id
 n13-20020adfe78d000000b003175b3b89a1mr64292wrm.10.1691514110568; 
 Tue, 08 Aug 2023 10:01:50 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s18-20020adfeb12000000b0031779a6b451sm14186033wrn.83.2023.08.08.10.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:01:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BBE6B1FFBB;
 Tue,  8 Aug 2023 18:01:49 +0100 (BST)
References: <20230807163705.9848-1-richard.henderson@linaro.org>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu,
 deller@gmx.de, qemu-devel@nongnu.org
Subject: Re: [PATCH for-8.1 v10 00/14] linux-user: image mapping fixes
Date: Tue, 08 Aug 2023 18:00:31 +0100
In-reply-to: <20230807163705.9848-1-richard.henderson@linaro.org>
Message-ID: <87zg315uyq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> This is the second half of
>
> https://patchew.org/QEMU/20230804220032.295411-1-richard.henderson@linaro=
.org/
>
> which I held back because of regressions with s390x testing.
>
> It turns out that patch 4, "Use MAP_FIXED_NOREPLACE for initial image mma=
p"
> actually triggered EEXIST, which meant that probe_guest_base did not
> do its job to select unused host virtual memory.  It's a mystery why
> we have not seen larger problems because of this.
>
> As I kept digging, I found quite a number of problems within
> probe_guest_base and its subroutines.  I have rewritten it completely.
> Hopefully it is much easier to understand in its new form.
>
> Testing this has been difficult, because it is most visible with
> non-PIE executables, and most modern distros default to PIE, and
> our current implementation of --disable-pie does not work.

I should say:

  [alex@aarch64:~/l/q/b/ci.all.linux.static] review/linux-user-mapping-v4|=
=E2=80=A6 + retry.py -n 100 -c -- make check-tcg

Gives:

  Results summary:
  0: 100 times (100.00%), avg time 150.644 (14.47 varience/3.80 deviation)
  Ran command 100 times, 100 passes

which I think has squashed an intermittent bug plaguing CI so have a:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

for the series.


>
>
> r~
>
>
> Helge Deller (1):
>   linux-user: Adjust initial brk when interpreter is close to executable
>
> Richard Henderson (13):
>   linux-user: Adjust task_unmapped_base for reserved_va
>   linux-user: Define TASK_UNMAPPED_BASE in $guest/target_mman.h
>   linux-user: Define ELF_ET_DYN_BASE in $guest/target_mman.h
>   linux-user: Use MAP_FIXED_NOREPLACE for initial image mmap
>   linux-user: Use elf_et_dyn_base for ET_DYN with interpreter
>   linux-user: Do not adjust image mapping for host page size
>   linux-user: Do not adjust zero_bss for host page size
>   linux-user: Use zero_bss for PT_LOAD with no file contents too
>   util/selfmap: Rewrite using qemu/interval-tree.h
>   linux-user: Remove duplicate CPU_LOG_PAGE from probe_guest_base
>   linux-user: Consolidate guest bounds check in probe_guest_base
>   linux-user: Rewrite fixed probe_guest_base
>   linux-user: Rewrite non-fixed probe_guest_base
>
>  include/qemu/selfmap.h               |  20 +-
>  linux-user/aarch64/target_mman.h     |  13 +
>  linux-user/alpha/target_mman.h       |  11 +
>  linux-user/arm/target_mman.h         |  11 +
>  linux-user/cris/target_mman.h        |  12 +
>  linux-user/hexagon/target_mman.h     |  13 +
>  linux-user/hppa/target_mman.h        |   6 +
>  linux-user/i386/target_mman.h        |  16 +
>  linux-user/loongarch64/target_mman.h |  11 +
>  linux-user/m68k/target_mman.h        |   5 +
>  linux-user/microblaze/target_mman.h  |  11 +
>  linux-user/mips/target_mman.h        |  10 +
>  linux-user/nios2/target_mman.h       |  10 +
>  linux-user/openrisc/target_mman.h    |  10 +
>  linux-user/ppc/target_mman.h         |  20 +
>  linux-user/qemu.h                    |   1 -
>  linux-user/riscv/target_mman.h       |  10 +
>  linux-user/s390x/target_mman.h       |  20 +
>  linux-user/sh4/target_mman.h         |   7 +
>  linux-user/sparc/target_mman.h       |  25 +
>  linux-user/user-mmap.h               |   5 +-
>  linux-user/x86_64/target_mman.h      |  15 +
>  linux-user/xtensa/target_mman.h      |  10 +
>  linux-user/elfload.c                 | 788 +++++++++++++--------------
>  linux-user/main.c                    |  43 ++
>  linux-user/mmap.c                    |  19 +-
>  linux-user/syscall.c                 |  15 +-
>  util/selfmap.c                       | 114 ++--
>  28 files changed, 777 insertions(+), 474 deletions(-)


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

