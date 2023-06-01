Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DE171F067
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 19:14:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4lrx-0003O0-Im; Thu, 01 Jun 2023 13:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1q4lrk-0003Hv-Ju; Thu, 01 Jun 2023 13:13:37 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1q4lrh-00066R-HK; Thu, 01 Jun 2023 13:13:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EB72F60BC8;
 Thu,  1 Jun 2023 17:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B86C433D2;
 Thu,  1 Jun 2023 17:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685639604;
 bh=JvQL6Ij4GYJBpmlRzXvWsOCbEAPXdtU4JKFO6R7yHx0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=QNi7MEY7W/x/w1Nq9pJvdzPqfAM9QU+cDG/A9rzCswhZWHSigQrukR34u5mDERXBL
 lY8lsMu68LlXU4oRUzxbJ1NIzu7sqD5GyYoAujS75dtAUCjEIvxbOJtVESnbSR8N8l
 Ax5o78Hl2tGKZpt5BHXMBavsySJQNfm4wgB0fvMH6/neljE035P/jSbq0VDKr5S7zi
 8L7AO/TeZ+r6YBUT5UWqKpMeJvKy/iuYUu7JEwSlDtLVNj1rXVahM1Qagv4oO7iTjw
 LIoG9cvdd5/0z0PTy3LlW/+iyeBxYJ+QoKWrJhAiXy/YgO2LtWSjl+L12dgRXCWBMV
 TWB7/kVC5dwZA==
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-4f60a27c4a2so1011776e87.2; 
 Thu, 01 Jun 2023 10:13:24 -0700 (PDT)
X-Gm-Message-State: AC+VfDyZ4Ak1exozukUM9/yn0OTigy1pa5eKhO5Za1bsHFJPF+Jen5eN
 DlAKiY8YMX8MublZLSv3GIgSvbl3pzWz4VCzh8o=
X-Google-Smtp-Source: ACHHUZ5KTjsUQomm+IOJwTSyyFa/yoONLqO3fconLSWKN6m1Vbn/gTSAV5cBQPAqpGEj787Soj6YP25CkdFrPwvxAJo=
X-Received: by 2002:ac2:5a06:0:b0:4f4:b28f:6b9c with SMTP id
 q6-20020ac25a06000000b004f4b28f6b9cmr376808lfn.29.1685639602381; Thu, 01 Jun
 2023 10:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230601123332.3297404-1-ardb@kernel.org>
 <20230601123332.3297404-3-ardb@kernel.org>
In-Reply-To: <20230601123332.3297404-3-ardb@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 1 Jun 2023 19:13:10 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHmiqA-3hi2KLpSDZzaWFwSmz-x61sRgJqawt7TNPZqnA@mail.gmail.com>
Message-ID: <CAMj1kXHmiqA-3hi2KLpSDZzaWFwSmz-x61sRgJqawt7TNPZqnA@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/i386: Implement PCLMULQDQ using AArch64 PMULL
 instructions
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=139.178.84.217; envelope-from=ardb@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 1 Jun 2023 at 14:33, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Use the AArch64 PMULL{2}.P64 instructions to implement PCLMULQDQ instead
> of emulating them in C code if the host supports this. This is used in
> the implementation of GCM, which is widely used in IPsec VPN and HTTPS.
>
> Somewhat surprising results: on my ThunderX2, enabling this on top of
> the AES acceleration I sent out earlier, the speedup is substantial.
>
> (1420 is a typical IPsec block size - in HTTPS, GCM operates on much
> larger block sizes but the kernel mode benchmarks are not the best place
> to measure its performance in this mode)
>
> tcrypt: testing speed of rfc4106(gcm(aes)) (rfc4106-gcm-aesni) encryption
>
> No acceleration
> tcrypt: test 5 (160 bit key, 1420 byte blocks): 10046 operations in 1 seconds (14265320 bytes)
>
> AES acceleration
> tcrypt: test 5 (160 bit key, 1420 byte blocks): 13970 operations in 1 seconds (19837400 bytes)
>
> AES + PMULL acceleration
> tcrypt: test 5 (160 bit key, 1420 byte blocks): 24372 operations in 1 seconds (34608240 bytes)
>

User space benchmark (using OS's qemu-x86_64 vs one built with these
changes applied)

Speedup is about 5x


ard@gambale:~/build/openssl$ apps/openssl speed -evp aes-128-gcm
Doing AES-128-GCM for 3s on 16 size blocks: 1692138 AES-128-GCM's in 2.98s
Doing AES-128-GCM for 3s on 64 size blocks: 665012 AES-128-GCM's in 3.00s
Doing AES-128-GCM for 3s on 256 size blocks: 203784 AES-128-GCM's in 3.00s
Doing AES-128-GCM for 3s on 1024 size blocks: 49397 AES-128-GCM's in 3.00s
Doing AES-128-GCM for 3s on 8192 size blocks: 6447 AES-128-GCM's in 3.00s
Doing AES-128-GCM for 3s on 16384 size blocks: 3058 AES-128-GCM's in 3.00s
version: 3.2.0-dev
built on: Thu Jun  1 17:06:09 2023 UTC
options: bn(64,64)
compiler: x86_64-linux-gnu-gcc -pthread -m64 -Wa,--noexecstack -Wall
-O3 -DOPENSSL_USE_NODELETE -DL_ENDIAN -DOPENSSL_BUILDING_OPENSSL
-DNDEBUG
CPUINFO: OPENSSL_ia32cap=0xfed8320b0fcbfffd:0x8001020c01d843a9
The 'numbers' are in 1000s of bytes per second processed.
type             16 bytes     64 bytes    256 bytes   1024 bytes
8192 bytes  16384 bytes
AES-128-GCM       9085.30k    14186.92k    17389.57k    16860.84k
17604.61k    16700.76k



ard@gambale:~/build/openssl$ ../qemu/build/qemu-x86_64 apps/openssl
speed -evp aes-128-gcm
Doing AES-128-GCM for 3s on 16 size blocks: 2703271 AES-128-GCM's in 2.99s
Doing AES-128-GCM for 3s on 64 size blocks: 1537884 AES-128-GCM's in 3.00s
Doing AES-128-GCM for 3s on 256 size blocks: 653008 AES-128-GCM's in 3.00s
Doing AES-128-GCM for 3s on 1024 size blocks: 203579 AES-128-GCM's in 3.00s
Doing AES-128-GCM for 3s on 8192 size blocks: 29020 AES-128-GCM's in 3.00s
Doing AES-128-GCM for 3s on 16384 size blocks: 14716 AES-128-GCM's in 2.99s
version: 3.2.0-dev
built on: Thu Jun  1 17:06:09 2023 UTC
options: bn(64,64)
compiler: x86_64-linux-gnu-gcc -pthread -m64 -Wa,--noexecstack -Wall
-O3 -DOPENSSL_USE_NODELETE -DL_ENDIAN -DOPENSSL_BUILDING_OPENSSL
-DNDEBUG
CPUINFO: OPENSSL_ia32cap=0xfed8320b0fcbfffd:0x8001020c01d843a9
The 'numbers' are in 1000s of bytes per second processed.
type             16 bytes     64 bytes    256 bytes   1024 bytes
8192 bytes  16384 bytes
AES-128-GCM      14465.66k    32808.19k    55723.35k    69488.30k
79243.95k    80637.77k

