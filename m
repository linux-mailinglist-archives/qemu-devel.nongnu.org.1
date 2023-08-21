Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78447783004
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 20:13:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY9N2-0005jl-Hu; Mon, 21 Aug 2023 14:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qY9LE-0005C0-83
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 14:09:38 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qY9Kx-0004YR-R7
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 14:09:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1A7996412B
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 18:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80261C433C9
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 18:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692641334;
 bh=wUwoPnGnPrEkGOuLBJVM6t5V9fjY39ERQXoyyNAbWi8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=i5hBwRWYjGunhzCTt+/fkXskOqoktEJaMBxl0iBrbqYDpeqciKiX50jgc3iMlhK2q
 z8EwbhJP376NaKlwg7OnaFdd9ZHIgOH44s0qFJOGK+cXR/6I02bU6zNgLf3wzTHGLW
 3zAiaMMKRYF4SpL1oNYg9bvNHTw/6SSFcjHLrY3MGPLN+Rb9ZaZvYZpakacN3ZRPQP
 kWnNAZdBKl1fw6westHj4Mdd6m0McRAL6IfLELaHuH8kT+Ds5idVBJa5Z1qnFw+VY8
 ESbnH0sa6G0jCP5cAfK01qaVblt00FajwEbckAzywA9JY08ocaevEamR0wpDRwhGgP
 kMeufeuDZAPCw==
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-4ff9121fd29so5392749e87.3
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 11:08:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YwFX8rnSiHXpOvpP/QSSmDitA2mggc9Jfy0WfGm1ikZm46GZJ9n
 4/NOlaMQmOcEtpVRQxH4gCydvjiBER4WTCChIMw=
X-Google-Smtp-Source: AGHT+IG8eJHziI8j7G520ckNmgnFAjIrDlMC/PWsXj8nTpySqx9bTbUTNprXkjbtAwEqfaTGgtQF5WTtoqmpT+QwZyY=
X-Received: by 2002:a05:6512:32b2:b0:4fd:ddbc:158d with SMTP id
 q18-20020a05651232b200b004fdddbc158dmr4117278lfe.17.1692641332437; Mon, 21
 Aug 2023 11:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230821161854.419893-1-richard.henderson@linaro.org>
In-Reply-To: <20230821161854.419893-1-richard.henderson@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 21 Aug 2023 20:08:41 +0200
X-Gmail-Original-Message-ID: <CAMj1kXECQeCnUZyt2FMnOSRfzBp_bCVQ2ZUV+VvSx==7nnqu5g@mail.gmail.com>
Message-ID: <CAMj1kXECQeCnUZyt2FMnOSRfzBp_bCVQ2ZUV+VvSx==7nnqu5g@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] crypto: Provide clmul.h and host accel
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
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Mon, 21 Aug 2023 at 18:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Inspired by Ard Biesheuvel's RFC patches [1] for accelerating
> carry-less multiply under emulation.
>
> Changes for v3:
>   * Update target/i386 ops_sse.h.
>   * Apply r-b.
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
>
> Richard Henderson (19):
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
>   target/i386: Use clmul_64
>   target/s390x: Use clmul_64
>   target/ppc: Use clmul_64
>   host/include/i386: Implement clmul.h
>   host/include/aarch64: Implement clmul.h
>

OK, I did the OpenSSL benchmark this time, using a x86_64 cross build
on arm64/ThunderX2, and the speedup is 7x (\o/)

Tested-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>



Distro qemu (no acceleration):

$ qemu-x86_64 --version
qemu-x86_64 version 7.2.4 (Debian 1:7.2+dfsg-7+deb12u1)

$ apps/openssl speed -evp aes-128-gcm
version: 3.2.0-dev
built on: Mon Aug 21 17:57:37 2023 UTC
options: bn(64,64)
compiler: x86_64-linux-gnu-gcc -pthread -m64 -Wa,--noexecstack -Wall
-O3 -DOPENSSL_USE_NODELETE -DL_ENDIAN -DOPENSSL_BUILDING_OPENSSL
-DNDEBUG
CPUINFO: OPENSSL_ia32cap=0xfed8320b0fcbfffd:0x8001020c01d843a9
The 'numbers' are in 1000s of bytes per second processed.
type             16 bytes     64 bytes    256 bytes   1024 bytes
8192 bytes  16384 bytes
AES-128-GCM       8856.13k    13820.95k    17375.49k    16826.37k
16870.06k    17208.66k


QEMU built with this series applied onto latest master:

$ ~/build/qemu/build/qemu-x86_64 apps/openssl speed -evp aes-128-gcm
version: 3.2.0-dev
built on: Mon Aug 21 17:57:37 2023 UTC
options: bn(64,64)
compiler: x86_64-linux-gnu-gcc -pthread -m64 -Wa,--noexecstack -Wall
-O3 -DOPENSSL_USE_NODELETE -DL_ENDIAN -DOPENSSL_BUILDING_OPENSSL
-DNDEBUG
CPUINFO: OPENSSL_ia32cap=0xfffa320b0fcbfffd:0x8041020c01dc47a9
The 'numbers' are in 1000s of bytes per second processed.
type             16 bytes     64 bytes    256 bytes   1024 bytes
8192 bytes  16384 bytes
AES-128-GCM      14237.01k    34176.34k    70633.13k    97372.84k
119668.74k   122049.88k

