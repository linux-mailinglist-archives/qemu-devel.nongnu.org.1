Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B40BA76EBB9
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 16:03:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRYv4-0007L1-51; Thu, 03 Aug 2023 10:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qRYus-0007BA-M9
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 10:03:04 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qRYuq-0006gi-QW
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 10:03:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 638C461D85
 for <qemu-devel@nongnu.org>; Thu,  3 Aug 2023 14:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85ADC433C7
 for <qemu-devel@nongnu.org>; Thu,  3 Aug 2023 14:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1691071378;
 bh=R2hfi/oO5wt4RqXSmSmELSVqNTI6UY4ryC1JnqkctrE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ewzLbU9tu2WhXepyoIVl1rxYQq98lV3nKMmnipLXfn5x7GAWzbDTmsk5Px09irg3w
 NxGSgm2h4MJ1tJWTXCDqbkBEVgTJSJWUBX1+kypOQbjD0+VS7lZlyiv6qKezuds2JF
 NlMsnUEY3ns+Tm/M2YBNPuvf/jTgXLCHUNRAAQsmWIiHt1a8pZhx/agmHmhplMBQI0
 rzA0tz9y4BkTjnf9/WYi95auOH40QeoNh9xfjnhj4J9pZ034LFnbGIJeI6SORXn9Ax
 SzajIm9RWebhV6ICWP409dFUrdeD80erOEpYzLWtpFIL2jM8hgXCdoAPq1abPr0TjQ
 yAyK8IsHl477Q==
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-4fe10f0f4d1so1836970e87.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 07:02:58 -0700 (PDT)
X-Gm-Message-State: ABy/qLbbSMAHSoM8wZ83Oh9yzdTH0y3xr8LielOUsrKkaaxEj1Kr8d2D
 QrHGkBRQr8o2RDW5IdpbY/leocI5ZEmibWRl+E8=
X-Google-Smtp-Source: APBJJlF+r+xcP60CSxO78np4R1OusKCNw3vbByC48zSW3Pev+ESKl/JbhIWPutnmlenNu1FnoocOGLrphJkFq8V9130=
X-Received: by 2002:ac2:43b1:0:b0:4fe:3e89:fcae with SMTP id
 t17-20020ac243b1000000b004fe3e89fcaemr6742720lfl.24.1691071376765; Thu, 03
 Aug 2023 07:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230713211435.13505-1-richard.henderson@linaro.org>
In-Reply-To: <20230713211435.13505-1-richard.henderson@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 3 Aug 2023 16:02:45 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHKXeH6JvEqwvJQcpL1kje0rJbx9-WkAgDBiUzr78VMYA@mail.gmail.com>
Message-ID: <CAMj1kXHKXeH6JvEqwvJQcpL1kje0rJbx9-WkAgDBiUzr78VMYA@mail.gmail.com>
Subject: Re: [RFC PATCH for-8.2 00/18] crypto: Provide clmul.h and host accel
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=ardb@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 13 Jul 2023 at 23:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Inspired by Ard Biesheuvel's RFC patches [1] for accelerating
> carry-less multiply under emulation.
>
> This is less polished than the AES patch set:
>
> (1) Should I split HAVE_CLMUL_ACCEL into per-width HAVE_CLMUL{N}_ACCEL?
>     The "_generic" and "_accel" split is different from aes-round.h
>     because of the difference in support for different widths, and it
>     means that each host accel has more boilerplate.
>
> (2) Should I bother trying to accelerate anything other than 64x64->128?

That is the only compelling use case afaict.

>     That seems to be the one that GSM really wants anyway.  I'd keep all
>     of the sizes implemented generically, since that centralizes the 3
>     target implementations.
>
> (3) The use of Int128 isn't fantastic -- better would be a vector type,
>     though that has its own special problems for ppc64le (see the
>     endianness hoops within aes-round.h).  Perhaps leave things in
>     env memory, like I was mostly able to do with AES?
>
> (4) No guest test case(s).
>
>
> r~
>
>
> [1] https://patchew.org/QEMU/20230601123332.3297404-1-ardb@kernel.org/
>
> Richard Henderson (18):
>   crypto: Add generic 8-bit carry-less multiply routines
>   target/arm: Use clmul_8* routines
>   target/s390x: Use clmul_8* routines
>   target/ppc: Use clmul_8* routines
>   crypto: Add generic 16-bit carry-less multiply routines
>   target/arm: Use clmul_16* routines
>   target/s390x: Use clmul_16* routines
>   target/ppc: Use clmul_16* routines
>   crypto: Add generic 32-bit carry-less multiply routines
>   target/arm: Use clmul_32* routines
>   target/s390x: Use clmul_32* routines
>   target/ppc: Use clmul_32* routines
>   crypto: Add generic 64-bit carry-less multiply routine
>   target/arm: Use clmul_64
>   target/s390x: Use clmul_64
>   target/ppc: Use clmul_64
>   host/include/i386: Implement clmul.h
>   host/include/aarch64: Implement clmul.h
>
>  host/include/aarch64/host/cpuinfo.h      |   1 +
>  host/include/aarch64/host/crypto/clmul.h | 230 +++++++++++++++++++++++
>  host/include/generic/host/crypto/clmul.h |  28 +++
>  host/include/i386/host/cpuinfo.h         |   1 +
>  host/include/i386/host/crypto/clmul.h    | 187 ++++++++++++++++++
>  host/include/x86_64/host/crypto/clmul.h  |   1 +
>  include/crypto/clmul.h                   | 123 ++++++++++++
>  target/arm/tcg/vec_internal.h            |  11 --
>  crypto/clmul.c                           | 163 ++++++++++++++++
>  target/arm/tcg/mve_helper.c              |  16 +-
>  target/arm/tcg/vec_helper.c              | 112 ++---------
>  target/ppc/int_helper.c                  |  63 +++----
>  target/s390x/tcg/vec_int_helper.c        | 175 +++++++----------
>  util/cpuinfo-aarch64.c                   |   4 +-
>  util/cpuinfo-i386.c                      |   1 +
>  crypto/meson.build                       |   9 +-
>  16 files changed, 865 insertions(+), 260 deletions(-)
>  create mode 100644 host/include/aarch64/host/crypto/clmul.h
>  create mode 100644 host/include/generic/host/crypto/clmul.h
>  create mode 100644 host/include/i386/host/crypto/clmul.h
>  create mode 100644 host/include/x86_64/host/crypto/clmul.h
>  create mode 100644 include/crypto/clmul.h
>  create mode 100644 crypto/clmul.c
>
> --
> 2.34.1
>

