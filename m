Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E8273732B
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 19:48:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBfS0-0001Zi-MD; Tue, 20 Jun 2023 13:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBfRw-0001Sy-TN
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:47:30 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBfRt-0003JP-EJ
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:47:28 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51a2661614cso6594865a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 10:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687283242; x=1689875242;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FTWKH1H+EoHUUCi36zW1qVwEWJr2dBauX3lyPOQWzf4=;
 b=cvmUZSlnQ2JGf10lJtbRNdUOb6c7aZNFP3c+BarwUnRxd2oLZLkWbq0z4l/i46EI5c
 uFoghnNZ+sesLoo5gGWrjPJuZ1zv9cLJeEChojmqDAT0XCAGgxCOD6MycWGznFeWWUb9
 Vk14nR4EO2fjnaS2hb5PTEmNP0FaCxqmtYX2WeITOAcNTuG1Y4ZAuFHu14VGlVIOdHWR
 rlaXtU/MBnD8ZVN3hVxqO1adJHEB5V1wEl90qpIou35fYuYtRRXPB4AX3LqVJZs+Pgf0
 lNfW5dZfpvmd+8MmMy1SUtkXCdL/iswjMR5LkYfLX1B9EsnEkZHjgLw++HcluacusBRo
 tKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687283242; x=1689875242;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FTWKH1H+EoHUUCi36zW1qVwEWJr2dBauX3lyPOQWzf4=;
 b=cYvEaWRQhS3KDWZcg0aoThbUyPfKgNcNnjoGCcgTxK4F0jtGVGuzeoI1WSTug54oFz
 WBIv2IQi/TsRYaaLcoUtGyi66U/tbVdy0Db4NUfJ6VFNWcZRY8CEwhmTjFsezZ6Aq4+S
 n+DPmTu28Ni93Te3cxgema0EseyEF+JzIxDwcJibv38QC5btOmFiGoc5RnR+2hdYTYA8
 xmBKBJUBc9NrV23uahtMWlc7zvyPEJ241ODf+tic+xv77fv6148Om/TOjdemAO2jVCmU
 gao6in73nx1/l3ojecuElqY+k65oHnhHPmh2HD5+NehJXz+JWl1z706fcnHddGckTfbf
 7Qjw==
X-Gm-Message-State: AC+VfDyb519+saqvf5C6BWvbeuOQRvEbhZu6yg11p3hR0NNff6qdBfxx
 49+e0V/YYuq5yZcft+U76jFREc756JiWlmAxWplI9ZslRIRijeBR
X-Google-Smtp-Source: ACHHUZ4iPq+cS6Nbox13sZzM8CsUMCdquWdjhk48f866BpjpKHNjJQpkYfShoa1C3vdpaJG5exuDuN8sCCDp8bRP8oM=
X-Received: by 2002:aa7:dcc6:0:b0:516:4098:66f4 with SMTP id
 w6-20020aa7dcc6000000b00516409866f4mr8504729edu.18.1687283241982; Tue, 20 Jun
 2023 10:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_UkPyic7U8eJkzBdBNoQowMToJkK-ro9re51zwn9-CMw@mail.gmail.com>
In-Reply-To: <CAFEAcA_UkPyic7U8eJkzBdBNoQowMToJkK-ro9re51zwn9-CMw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2023 18:47:10 +0100
Message-ID: <CAFEAcA_EjzQvy67XpXeEn7zMbkoCPLAs3n5PGK2J5kuGkFEBhQ@mail.gmail.com>
Subject: Re: 'make check-tcg' fails with an assert in
 qemu_plugin_vcpu_init_hook
To: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Tue, 20 Jun 2023 at 17:56, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> $ make -C build/x86 check-tcg
> make: Entering directory '/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86'
> [...]
>   TEST    munmap-pthread on arm
> **
> ERROR:../../plugins/core.c:221:qemu_plugin_vcpu_init_hook: assertion
> failed: (success)
> **
> ERROR:../../accel/tcg/cpu-exec.c:1024:cpu_exec_setjmp: assertion
> failed: (cpu == current_cpu)

git bisect blames commit d7ee93e2435970:

    cputlb: Restrict SavedIOTLB to system emulation

I think that commit is not correct, because it means that
the size of 'struct CPUState' and also the offset of fields
like 'cpu_index' will be different for files which are
compile-per-target-for-usermode and files which are
compile-once-only. The assert happens here because the
code which sets up cpu_index is build-once, but the code
in qemu_plugin_vcpu_init_hook() which reads cpu_index is
build-per-target and now they don't agree about where in
the struct the field is...

Reverting the commit fixes the bug.

thanks
-- PMM

