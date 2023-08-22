Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68691783D1B
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 11:41:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYNsn-00050F-Ih; Tue, 22 Aug 2023 05:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qYNsj-0004xY-RB
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:41:01 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qYNsh-0002Re-3j
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:41:01 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-529fb04a234so3491234a12.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 02:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697257; x=1693302057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+99yKd7mHklJJwU1DmkVSdsTjQc5/6t9Ny9uz4G5Bwk=;
 b=dP7glGeXNYRtxGDk1gqJR4TaODYrBmmUy1p9Xs9XhlCsWpBXsI6VXT/btsVposxuAm
 Ij0LPAtmnVRlSdXqi9ohfUgSvlLlyYlZAUMH+Gzm34eASunMH/1xtIEkXWx662F97tw6
 XbmSEMfpk1tuTDX8Wx46vKfSoJ/u1ffZI85PEeJJpcXTh76z5HnqJLJE/VA+7O2GVgOi
 dJZbL9ZOOw4gy5sge1vopeRt6bZF0cP0uLWaKajU/p8RaRvx9htEFxGhzD4t3ZSDQ6zA
 bx1I7W9gApy5lZ1fvaG/LUXHyqmSCnFA+sBXHGP6cmlIVopU4aXqK6/XkLOPbz4xi2Wk
 E/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697257; x=1693302057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+99yKd7mHklJJwU1DmkVSdsTjQc5/6t9Ny9uz4G5Bwk=;
 b=PHtKH6kYWkNm+lpNlmwM1af8r316WSo5B+i11HFuBibGYKYkIDPAyrxR8OkEQ6QguW
 cOSud+alxQGyn/uoclBzAPOONfrSV6JMhb3NrBFx/REVXVN2TVjb8um54tBLYUNrzLem
 1rrlauDWSif9Hh2V4FV6nAQeQSLqOnZAIhn5TzzTP7XGpiIMWQyDnOacpYsqVezBXEIh
 EPDCHsBJOgJO75v0hZuOqpdzQvJHslhlZrY4yYjkLPodN9MtI7Q0uO56u0rtkoD1wX/v
 3t98FEz5xm1BeNOhjrCxL39VWoddQXQHgj2zE9UQsZB+DyLa4S0cJk6RN6d/tnIDFSIQ
 xrng==
X-Gm-Message-State: AOJu0YwiGmuJ8wxqrqxGhZuXuebSPe6D1RowdKD9Yxu1X4+Gz+QLTxgm
 3Bt0VY16uWK37kfg6sUFOVMsFC3NxdsSFrLeSVi/bg==
X-Google-Smtp-Source: AGHT+IGpoN+VJsx+3FcRDfPKsDlgF8XX/3uHcXJouSHaN2uGu9R4tkU4gwp7WPHJwIhoi1NfYCObprh1i3Ku38+YtLI=
X-Received: by 2002:a05:6402:88a:b0:523:a1f:1b50 with SMTP id
 e10-20020a056402088a00b005230a1f1b50mr7847296edy.28.1692697257067; Tue, 22
 Aug 2023 02:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230822042530.1026751-1-richard.henderson@linaro.org>
In-Reply-To: <20230822042530.1026751-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2023 10:40:46 +0100
Message-ID: <CAFEAcA_YEOXOfmRXcPCQZGbkhsKG-L2kMCr-68NJedGn4feb3Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] Implement Most ARMv8.3 Pointer Authentication
 Features
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Aaron Lindsay <Aaron@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 22 Aug 2023 at 05:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is an update of Aaron's v3 [1].
> There are a fair number of changes beyond a mere rebase:
>
>   * Updates to the test cases which fail with the new features.
>   * Updates to the documentation.
>   * Preserve pauth feature set when changing pauth algorithm.
>   * Rearrange feature detection:
>      - Add ARMPauthFeature
>      - Use it with isar_feature_pauth_feature
>      - Remove many of the isar predicates
>     The pauth_auth and pauth_addpac routines wind up making lots
>     of tests against the pauth feature set.  Rather than recompute
>     the feature set many times for each predicate, compute it once
>     and compare against the enumerators.
>   * Algorithmic simplification of Pauth2 and FPAC using cmp_mask.

Thanks for the respin. (Looks like you forgot to cc Aaron on this.)

-- PMM

>
> r~
>
> [1] https://patchew.org/QEMU/20230322202541.1404058-1-aaron@os.amperecomputing.com/
>
> Aaron Lindsay (6):
>   target/arm: Add ID_AA64ISAR2_EL1
>   target/arm: Add feature detection for FEAT_Pauth2 and extensions
>   target/arm: Implement FEAT_EPAC
>   target/arm: Implement FEAT_Pauth2
>   targer/arm: Inform helpers whether a PAC instruction is 'combined'
>   target/arm: Implement FEAT_FPAC and FEAT_FPACCOMBINE
>
> Richard Henderson (3):
>   tests/tcg/aarch64: Adjust pauth tests for FEAT_FPAC
>   target/arm: Don't change pauth features when changing algorithm
>   target/arm: Implement FEAT_PACQARMA3
>
>  docs/system/arm/cpu-features.rst  |  21 ++--
>  docs/system/arm/emulation.rst     |   7 ++
>  target/arm/cpu.h                  |  51 +++++++--
>  target/arm/syndrome.h             |   7 ++
>  target/arm/tcg/helper-a64.h       |   4 +
>  target/arm/arm-qmp-cmds.c         |   2 +-
>  target/arm/cpu64.c                |  86 ++++++++++----
>  target/arm/helper.c               |   4 +-
>  target/arm/hvf/hvf.c              |   1 +
>  target/arm/kvm64.c                |   2 +
>  target/arm/tcg/cpu64.c            |   2 +
>  target/arm/tcg/pauth_helper.c     | 180 ++++++++++++++++++++++++------
>  target/arm/tcg/translate-a64.c    |  12 +-
>  tests/qtest/arm-cpu-features.c    |  12 +-
>  tests/tcg/aarch64/pauth-2.c       |  61 ++++++++--
>  tests/tcg/aarch64/pauth-4.c       |  28 ++++-
>  tests/tcg/aarch64/pauth-5.c       |  20 ++++
>  tests/tcg/aarch64/Makefile.target |   5 +-
>  18 files changed, 409 insertions(+), 96 deletions(-)

