Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DDF8D2632
	for <lists+qemu-devel@lfdr.de>; Tue, 28 May 2024 22:44:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC3ff-0001Zy-Sw; Tue, 28 May 2024 16:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sC3fc-0001ZX-BJ
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:43:44 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sC3fa-0005MU-IJ
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=FFtWUWxK5K3bQ/NMEVNIOSQavZ1Ul0PBNwKd8jxG2ss=; b=py9V8cMrNgHN272M50Eyp1xhZV
 88qdoyWs+BIPC/onoXfvRP3J9qBDtHwHHrhgagGJdornbtCcvezqpTvplbHUrndLRq4ZJOVLVXndk
 k83Zz29uh9LZfER1tuVpD2iVPENMcnlxbHLdaeSgu8HNbSviL/EgQfEiwqRfE3f8RR57GtSLa9QbL
 1hK2HdyQJHGl0ilwtlwU36JN0ifSjO9AUucAm107qzlLgtl+1Dh4yj/iIodoiqI1V3ilBK4bgOdhQ
 lxyzOUcJe61ZgtTBSC13yEOkeeuLRivqS21xNaFE5TdWYyUbHx2hghXWzzipGqz0Ks2bmV60KC4ZN
 M80iQtjUtfRkp0xIFNX8HOQV7CS+Y2HJEQsuogHe5XJnWaxLvxaU60G5d80tyDN3Y8LmDMDKXrp3i
 sv8hPX56B+kNcZ8ahzP/USWcSaQFGGWaO7jZUOj802gngpuzXe4LOi4VtisP+wOHtDBlpZPGb8tmS
 5wyYADdLhvMM+czQO0RMMEnlLvHta19nD6VeMUbtDBK/bSUXWZdIR9P44k8FOgvZerCM5/x0gjMYX
 XtfOFCuiaxUGlLodRVWUuTWaTOjigOIEMHAxfEcGlimNhaNIDhQy0k8wJ7jySJF/qBrlCT9hvwNKO
 NGCScmMFmhp30u4y/aXysSS7z0cb895W/uLX2/4fw=;
Received: from [2a00:23c4:8bb4:4000:7888:3a1b:7ac1:9da2]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sC3eG-0001Hd-3l; Tue, 28 May 2024 21:42:24 +0100
Message-ID: <b672e2a9-a547-44c7-9020-fdbd23046789@ilande.co.uk>
Date: Tue, 28 May 2024 21:43:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240526193637.459064-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20240526193637.459064-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:7888:3a1b:7ac1:9da2
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH RISU v2 00/13] ELF and Sparc64 support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 26/05/2024 20:36, Richard Henderson wrote:

> Let risu accept elf test files, adjusted from v1.
> Adjust risugen to invoke the assembler and linker,
> with a cross-compiler prefix if needed.
> Add some sparc64 testing which utilizes this.
> 
> Changes for v2:
>    - Implement VIS2 through VIS4.
> 
> There's something odd going on with the Sparc M8 Solaris host where
> the values recorded via RISU for some floating-point operations are
> incorrectly rounded, but performing the same operations with the
> same inputs in a standalone test program produces correct results.
> 
> I wonder if there's some unfinished_FPop exception being generated
> and the operating system emulation is producing incorrect results.
> I'd be much happier if I could test this on Linux...
> 
> 
> r~
> 
> 
> Richard Henderson (13):
>    risu: Allow use of ELF test files
>    Build elf test cases instead of raw binaries
>    Introduce host_context_t
>    risu: Add initial sparc64 support
>    risugen: Be explicit about print destinations
>    risugen: Add sparc64 support
>    contrib/generate_all: Do not rely on ag
>    sparc64: Add a few logical insns
>    sparc64: Add VIS1 instructions
>    sparc64: Add VIS2 and FMAF insns
>    sparc64: Add VIS3 instructions
>    sparc64: Add IMA instructions
>    sparc64: Add VIS4 instructions
> 
>   Makefile                   |  22 ++-
>   risu.h                     |  16 +-
>   risu_reginfo_aarch64.h     |   2 +
>   risu_reginfo_arm.h         |   2 +
>   risu_reginfo_i386.h        |   2 +
>   risu_reginfo_loongarch64.h |   3 +
>   risu_reginfo_m68k.h        |   2 +
>   risu_reginfo_ppc64.h       |   2 +
>   risu_reginfo_s390x.h       |   2 +
>   risu_reginfo_sparc64.h     |  36 ++++
>   risu.c                     |  59 +++++-
>   risu_aarch64.c             |   6 +-
>   risu_arm.c                 |   7 +-
>   risu_i386.c                |   7 +-
>   risu_loongarch64.c         |   6 +-
>   risu_m68k.c                |   6 +-
>   risu_ppc64.c               |   6 +-
>   risu_reginfo_loongarch64.c |   3 +-
>   risu_reginfo_sparc64.c     | 186 ++++++++++++++++++
>   risu_s390x.c               |   5 +-
>   risu_sparc64.c             |  52 +++++
>   configure                  |   2 +
>   contrib/generate_all.sh    |   4 +-
>   risugen                    |  10 +-
>   risugen_common.pm          |  68 ++++++-
>   risugen_sparc64.pm         | 385 +++++++++++++++++++++++++++++++++++++
>   sparc64.risu               | 298 ++++++++++++++++++++++++++++
>   test.ld                    |  12 ++
>   test_aarch64.s             |   4 +-
>   test_arm.s                 |  16 +-
>   test_i386.S                |   4 +-
>   test_sparc64.s             | 137 +++++++++++++
>   32 files changed, 1298 insertions(+), 74 deletions(-)
>   create mode 100644 risu_reginfo_sparc64.h
>   create mode 100644 risu_reginfo_sparc64.c
>   create mode 100644 risu_sparc64.c
>   create mode 100644 risugen_sparc64.pm
>   create mode 100644 sparc64.risu
>   create mode 100644 test.ld
>   create mode 100644 test_sparc64.s

Nice! I don't have any experience with RISU so I don't feel too qualified to review 
the series, but obviously there are clear benefits to having SPARC support included :)


ATB,

Mark.


