Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9579C7B1F6D
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 16:28:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlryO-0003OE-PA; Thu, 28 Sep 2023 10:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qlryN-0003O4-1y
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 10:26:35 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qlryL-0008Go-63
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 10:26:34 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-57b811a6ce8so5569065eaf.3
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 07:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695911191; x=1696515991; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DONvhEep/UUwrjshE5PKelJbqD+tIfV90VHIdgIGOFQ=;
 b=AAXhvNSUHaiXUEJ0FWYWSOdcTAcsqgXt0qT/Q8/W7NJUUq6wSnpgrFkoNafBcVIph5
 Xue1JzpZZRruXsPNgU3YH53QxS5afpZffbi24EGFubSkUEYUZ22B5DUoj7hrkROyEdAs
 QbQ/W3BpyRS9lAgzw2A9cgCjCgtfTzYGM6UWLhc0nH8vOjSgYgOY/iEJ4R/XlQwjhG0q
 I4ZRq03b+X0LORijPWR4CrlyM0ahsdRtLTuHSKsOsSJry+xfJSJggs6e1XOCBr7eswul
 d3PvDdiagz7aCxRhVKcSsk2pe/xp53zETXgQIESHs/bJIKPkP8wikZ/nkciNZRsqWXRF
 AGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695911191; x=1696515991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DONvhEep/UUwrjshE5PKelJbqD+tIfV90VHIdgIGOFQ=;
 b=L44t0rayUW5ggN+vms3/VIERA8H1b82WsjDqsJg3MUgXajsTFQ6gH77W+kmmpUN8SN
 3M6OCfeiXMbMcOMd90EVTQQUQnZ+LiorWuR6L0FUwNsxbZqQJoAmm7XMsFHf+6YJuHqV
 BPGqybrhSi3QPaIyHtflQayzL+k3mG333HPPysFw/fNIDFpsR2JWYtoS6SFcVT8qcNWR
 NuFSDwWjx1OreqexKmaz724ukBPuAGGhML20m40359EFecYYnJ9YTorb2S2gS3HlXjYC
 iVdgHGUPYxVWd5jbHl/V5XE04VHAMZiWYhXSxmq3ghmCIt/s3oCkNwIHt4GGpf/CJolQ
 jgww==
X-Gm-Message-State: AOJu0Yx/EGvnvmDvKnEMe2HGrc4CQFrh+HY6BXKE9KK/3ELGeR3JGlWc
 ifIQjfoux6pbCzDP0SowOyQb0QnQRzHQKNk7pnAIkRqC8kI=
X-Google-Smtp-Source: AGHT+IHaTKlKt2kHyd6C5oBWwODiZ6dByyxxn2qEuhyv5tQ+tS2UfrS4t+PFR3U5ce7JSNaz8a5JHj4uHd5kzFISnV4=
X-Received: by 2002:a4a:6f49:0:b0:57b:5e98:f733 with SMTP id
 i9-20020a4a6f49000000b0057b5e98f733mr1231175oof.3.1695911191026; Thu, 28 Sep
 2023 07:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230928085303.511518-1-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20230928085303.511518-1-kbastian@mail.uni-paderborn.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 28 Sep 2023 10:26:18 -0400
Message-ID: <CAJSP0QVgH+9-ethHt5vWDraS+dpQssrbzkuxu95FONhWCNKOog@mail.gmail.com>
Subject: Re: [PULL v2 00/21] tricore queue
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Please take a look at these CI test failures:
https://gitlab.com/qemu-project/qemu/-/jobs/5185201978
https://gitlab.com/qemu-project/qemu/-/jobs/5185202098

Thanks,
Stefan

On Thu, 28 Sept 2023 at 04:57, Bastian Koppelmann
<kbastian@mail.uni-paderborn.de> wrote:
>
> The following changes since commit 36e9aab3c569d4c9ad780473596e18479838d1aa:
>
>   migration: Move return path cleanup to main migration thread (2023-09-27 13:58:02 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/bkoppelmann/qemu.git tags/pull-tricore-20230928
>
> for you to fetch changes up to 080ca1baa84316a58790b6507de89fabf4c40ec0:
>
>   target/tricore: Change effective address (ea) to target_ulong (2023-09-28 10:45:22 +0200)
>
> ----------------------------------------------------------------
> - Add FTOU, CRCN, FTOHP, and HPTOF insns
> - Add test for arithmetic TriCore insns
>
> ----------------------------------------------------------------
> Changes from v1:
> - Removed sas.py file that slipped in patch 15
> ----------------------------------------------------------------
>
> Bastian Koppelmann (21):
>       tests/tcg/tricore: Bump cpu to tc37x
>       target/tricore: Implement CRCN insn
>       target/tricore: Correctly handle FPU RM from PSW
>       target/tricore: Implement FTOU insn
>       target/tricore: Clarify special case for FTOUZ insn
>       target/tricore: Implement ftohp insn
>       target/tricore: Implement hptof insn
>       target/tricore: Fix RCPW/RRPW_INSERT insns for width = 0
>       target/tricore: Swap src and dst reg for RCRR_INSERT
>       target/tricore: Replace cpu_*_code with translator_*
>       target/tricore: Fix FTOUZ being ISA v1.3.1 up
>       tests/tcg/tricore: Extended and non-extened regs now match
>       hw/tricore: Log failing test in testdevice
>       tests/tcg: Reset result register after each test
>       tests/tcg/tricore: Add test for all arith insns up to addx
>       tests/tcg/tricore: Add test from 'and' to 'csub'
>       tests/tcg/tricore: Add test from 'dextr' to 'lt'
>       tests/tcg/tricore: Add test from 'max' to 'shas'
>       tests/tcg/tricore: Add test from 'shuffle' to 'xor.t'
>       target/tricore: Remove CSFRs from cpu.h
>       target/tricore: Change effective address (ea) to target_ulong
>
>  hw/tricore/tricore_testdevice.c           |   4 +
>  target/tricore/cpu.h                      | 143 +--------------
>  target/tricore/fpu_helper.c               | 111 ++++++++++++
>  target/tricore/helper.c                   |  19 +-
>  target/tricore/helper.h                   |   4 +
>  target/tricore/op_helper.c                |  79 ++++++++-
>  target/tricore/translate.c                |  56 ++++--
>  target/tricore/tricore-opcodes.h          |   3 +
>  tests/tcg/tricore/Makefile.softmmu-target |   7 +-
>  tests/tcg/tricore/asm/macros.h            | 190 +++++++++++++++++---
>  tests/tcg/tricore/asm/test_arith.S        | 280 ++++++++++++++++++++++++++++++
>  tests/tcg/tricore/asm/test_crcn.S         |   9 +
>  tests/tcg/tricore/asm/test_ftohp.S        |  14 ++
>  tests/tcg/tricore/asm/test_ftou.S         |  12 ++
>  tests/tcg/tricore/asm/test_hptof.S        |  12 ++
>  tests/tcg/tricore/asm/test_insert.S       |  14 ++
>  16 files changed, 780 insertions(+), 177 deletions(-)
>  create mode 100644 tests/tcg/tricore/asm/test_arith.S
>  create mode 100644 tests/tcg/tricore/asm/test_crcn.S
>  create mode 100644 tests/tcg/tricore/asm/test_ftohp.S
>  create mode 100644 tests/tcg/tricore/asm/test_ftou.S
>  create mode 100644 tests/tcg/tricore/asm/test_hptof.S
>

