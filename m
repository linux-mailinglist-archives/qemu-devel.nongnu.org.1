Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12217782CD5
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 16:59:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY6MF-0008Nk-Nh; Mon, 21 Aug 2023 10:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qY6MD-0008NE-Tf
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 10:58:17 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qY6MB-00038q-Cv
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 10:58:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 904E363B36
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 14:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D629CC4166B
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 14:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692629891;
 bh=ezrzVIsWWkfosaT2rucISi261nME8B8GsFcUpHWRS2g=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=rNxlycNmfjIz0DcZTsDNC/vZ2GG0yMOFrJWietATGPdbJXmL846+C/TXyEZUikxaF
 9ylAhu1uDgOsy92N+SZLvljNcZ6t8XZh7jLxPnnqKaT71PydCgXpxO2dVdysfKz4xn
 tzB9l+1AOZIbN0/EtMLMOIuNtnj9+K8PZ+QNv71lH4RTNY38ezoXucBYQtSioOeYDZ
 QE1WlC5ndjk//SE+597TZlLzKOOKWmQV62K7btopBbggVUU76NOUehE9dwezLNqN1x
 9PE8LEQJiqjcxIgt0xyg00wfbROLi0Hcy+XjepDcjgY579vLYrx9+5PVXSvM9DHZVn
 IC2pXaxoB3XVA==
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-4fe4762173bso5183234e87.3
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 07:58:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YzHFH6ZGnnTOPT7nZsLvaMHBQhmUq0q2m39xnC/ji1XbcyBs+QX
 /9Bo2gjWD+JQETUJc5G4S+KKdvNPZbQsGy1CrzI=
X-Google-Smtp-Source: AGHT+IFG7Ztf/ebS8lmZBj7qkqozgIqtUxNXHmf8F1R2XSiVQfDIqZJ5Umov+RtZoFpG3TCHhRv/RuC7i7GUW9ND3WU=
X-Received: by 2002:a05:6512:2347:b0:4f7:66bf:b263 with SMTP id
 p7-20020a056512234700b004f766bfb263mr5563784lfu.24.1692629889836; Mon, 21 Aug
 2023 07:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230819010218.192706-1-richard.henderson@linaro.org>
In-Reply-To: <20230819010218.192706-1-richard.henderson@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 21 Aug 2023 16:57:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFWeUzWkpt5o0Bh6CXzBHoxkZk7wUiLsidEvDjH_SSnHw@mail.gmail.com>
Message-ID: <CAMj1kXFWeUzWkpt5o0Bh6CXzBHoxkZk7wUiLsidEvDjH_SSnHw@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] crypto: Provide clmul.h and host accel
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=139.178.84.217; envelope-from=ardb@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

On Sat, 19 Aug 2023 at 03:02, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Inspired by Ard Biesheuvel's RFC patches [1] for accelerating
> carry-less multiply under emulation.
>
> Changes for v2:
>   * Only accelerate clmul_64; keep generic helpers for other sizes.
>   * Drop most of the Int128 interfaces, except for clmul_64.
>   * Use the same acceleration format as aes-round.h.
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

I didn't re-run the OpenSSL benchmark, but the x86 Linux kernel still
passes all its crypto selftests when running under TCG emulation on a
TX2 arm64 host, so

Tested-by: Ard Biesheuvel <ardb@kernel.org>

for the series.

Thanks,
Ard.

