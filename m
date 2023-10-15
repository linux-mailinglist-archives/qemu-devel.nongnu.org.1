Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6944A7C9B4C
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 22:14:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs7Th-0006sJ-TP; Sun, 15 Oct 2023 16:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qs7Tc-0006rp-Tk
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 16:12:42 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qs7Ta-00084e-W4
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 16:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MsrY9HLyAo0M7oqyv+HSB4yNSHr7Z0CFtl+qgy7x1Lo=; b=mRX4kztDUeXHfYnGeHLvsu3n+L
 WPYUI6y3Z2PYH7l34WXd76UTvgCHKYfnntnNQkHjvv8bVwfQvm86EflR+i8ESAi9eKmdWiqWRfEMe
 XctUWvRPefxZQGSQZSLK5ZzGFk+VoRvIC1frsM8A03go8QTJ3ZUlPMGKZw8JviZN97NpU1GjD7C3J
 7g+rpoCtBzDOMHsG8c8kCFOLskzGsoTrodONwFKN2tz67f510KVuk+s5e1d4KOE+YkmZ0r3QWpyac
 w+ASRVCocdqZdqcFgYdsiMaZpbDEqwoZNpjN9/oWVWzM/2PI4bFqsT9/KMeaThJDrgtzTU35IXn4r
 RwUOc21pAiB5hhXSY9GwpN2lncqEXh1OIn5k/kFY+Cc9pAVCkrgRUc3AKDv20iIT2MkrFrhgvWzy3
 /gD8PTXI/1IFhkliXpokmVYkt14gX0U3ifcaOTNVaVPIVN6GoDxvfKJxnNC8GEB8pZyAjEFC0BUZA
 OXxZWyLWMGeODC6eXX5r6xjeSuz4p68tXE1YsIZdPoKEZoKTVP9AbJkmOHld3w3vljDpg9dHg8McQ
 05r8eZyhoMTyX2U2TptNChpwAcCsRXpogzaDwyM6ECfa5m5k3UfqsgsrqbZDguZbH4u+7QdDBPKEQ
 ngQwZUbAAbKquLMbd/ySuJ6PeNAgKexxfvQm06/Mc=;
Received: from [2a00:23c4:8baf:fd00:b47c:ebb0:33fb:b517]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qs7TQ-0007oX-HA; Sun, 15 Oct 2023 21:12:32 +0100
Message-ID: <925432d7-a8dd-43cf-b27a-ec1c862623ed@ilande.co.uk>
Date: Sun, 15 Oct 2023 21:12:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com
References: <20231013212846.165724-1-richard.henderson@linaro.org>
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
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:fd00:b47c:ebb0:33fb:b517
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 00/85] target/sparc: Convert to decodetree
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 13/10/2023 22:27, Richard Henderson wrote:

> While doing some other testing the other day, I noticed my sparc64
> chroot running particularly slowly.  I think I know what the problem
> is there, but fixing that was going to be particularly ugly with the
> existing sparc translator.
> 
> So I've converted the translator to something more managable.  :-)
> 
> I've only done avocado testing so far, fingers crossed.
> 
> 
> r~
> 
> 
> Richard Henderson (85):
>    target/sparc: Set TCG_GUEST_DEFAULT_MO
>    configs: Enable MTTCG for sparc, sparc64
>    target/sparc: Remove always-set cpu features
>    target/sparc: Add decodetree infrastructure
>    target/sparc: Define AM_CHECK for sparc32
>    target/sparc: Move CALL to decodetree
>    target/sparc: Move BPcc and Bicc to decodetree
>    target/sparc: Move BPr to decodetree
>    target/sparc: Move FBPfcc and FBfcc to decodetree
>    target/sparc: Merge gen_cond with only caller
>    target/sparc: Merge gen_fcond with only caller
>    target/sparc: Merge gen_branch_[an] with only caller
>    target/sparc: Pass DisasCompare to advance_jump_cond
>    target/sparc: Move SETHI to decodetree
>    target/sparc: Move Tcc to decodetree
>    target/sparc: Move RDASR, STBAR, MEMBAR to decodetree
>    target/sparc: Move RDPSR, RDHPR to decodetree
>    target/sparc: Move RDWIM, RDPR to decodetree
>    target/sparc: Move RDTBR, FLUSHW to decodetree
>    target/sparc: Move WRASR to decodetree
>    target/sparc: Move WRPSR, SAVED, RESTORED to decodetree
>    target/sparc: Move WRWIM, WRPR to decodetree
>    target/sparc: Move WRTBR, WRHPR to decodetree
>    target/sparc: Move basic arithmetic to decodetree
>    target/sparc: Move ADDC to decodetree
>    target/sparc: Move MULX to decodetree
>    target/sparc: Move UMUL, SMUL to decodetree
>    target/sparc: Move SUBC to decodetree
>    target/sparc: Move UDIVX, SDIVX to decodetree
>    target/sparc: Move UDIV, SDIV to decodetree
>    target/sparc: Move TADD, TSUB, MULS to decodetree
>    target/sparc: Move SLL, SRL, SRA to decodetree
>    target/sparc: Move MOVcc, MOVR to decodetree
>    target/sparc: Move POPC to decodetree
>    target/sparc: Convert remaining v8 coproc insns to decodetree
>    target/sparc: Move JMPL, RETT, RETURN to decodetree
>    target/sparc: Move FLUSH, SAVE, RESTORE to decodetree
>    target/sparc: Move DONE, RETRY to decodetree
>    target/sparc: Split out resolve_asi
>    target/sparc: Drop ifdef around get_asi and friends
>    target/sparc: Split out ldst functions with asi pre-computed
>    target/sparc: Use tcg_gen_qemu_{ld,st}_i128 for GET_ASI_DTWINX
>    target/sparc: Move simple integer load/store to decodetree
>    target/sparc: Move asi integer load/store to decodetree
>    target/sparc: Move LDSTUB, LDSTUBA to decodetree
>    target/sparc: Move SWAP, SWAPA to decodetree
>    target/sparc: Move CASA, CASXA to decodetree
>    target/sparc: Move PREFETCH, PREFETCHA to decodetree
>    target/sparc: Split out fp ldst functions with asi precomputed
>    target/sparc: Move simple fp load/store to decodetree
>    target/sparc: Move asi fp load/store to decodetree
>    target/sparc: Move LDFSR, STFSR to decodetree
>    target/sparc: Merge LDFSR, LDXFSR implementations
>    target/sparc: Move EDGE* to decodetree
>    target/sparc: Move ARRAY* to decodetree
>    target/sparc: Move ADDRALIGN* to decodetree
>    target/sparc: Move BMASK to decodetree
>    target/sparc: Move FMOVS, FNEGS, FABSS, FSRC*S, FNOT*S to decodetree
>    target/sparc: Move FMOVD, FNEGD, FABSD, FSRC*D, FNOT*D to decodetree
>    target/sparc: Use tcg_gen_vec_{add,sub}*
>    target/sparc: Move gen_ne_fop_FFF insns to decodetree
>    target/sparc: Move gen_ne_fop_DDD insns to decodetree
>    target/sparc: Move PDIST to decodetree
>    target/sparc: Move gen_gsr_fop_DDD insns to decodetree
>    target/sparc: Move gen_fop_FF insns to decodetree
>    target/sparc: Move gen_fop_DD insns to decodetree
>    target/sparc: Move FSQRTq to decodetree
>    target/sparc: Move gen_fop_FFF insns to decodetree
>    target/sparc: Move gen_fop_DDD insns to decodetree
>    target/sparc: Move gen_fop_QQQ insns to decodetree
>    target/sparc: Move FSMULD to decodetree
>    target/sparc: Move FDMULQ to decodetree
>    target/sparc: Move gen_fop_FD insns to decodetree
>    target/sparc: Move FiTOd, FsTOd, FsTOx to decodetree
>    target/sparc: Move FqTOs, FqTOi to decodetree
>    target/sparc: Move FqTOd, FqTOx to decodetree
>    target/sparc: Move FiTOq, FsTOq to decodetree
>    target/sparc: Move FdTOq, FxTOq to decodetree
>    target/sparc: Move FMOVq, FNEGq, FABSq to decodetree
>    target/sparc: Move FMOVR, FMOVcc, FMOVfcc to decodetree
>    target/sparc: Convert FCMP, FCMPE to decodetree
>    target/sparc: Move FPCMP* to decodetree
>    target/sparc: Move FPACK16, FPACKFIX to decodetree
>    target/sparc: Convert FZERO, FONE to decodetree
>    target/sparc: Remove disas_sparc_legacy
> 
>   configs/targets/sparc-softmmu.mak   |    1 +
>   configs/targets/sparc64-softmmu.mak |    1 +
>   linux-user/sparc/target_syscall.h   |    6 +-
>   target/sparc/cpu.h                  |   73 +-
>   target/sparc/helper.h               |   15 +-
>   target/sparc/insns.decode           |  541 +++
>   target/sparc/cpu.c                  |    8 +-
>   target/sparc/fop_helper.c           |   17 +-
>   target/sparc/translate.c            | 6692 +++++++++++++--------------
>   target/sparc/vis_helper.c           |   59 -
>   target/sparc/meson.build            |    3 +
>   11 files changed, 3804 insertions(+), 3612 deletions(-)
>   create mode 100644 target/sparc/insns.decode

Hi Richard,

I've had a chance to run this through the 32-bit set of my SPARC OpenBIOS tests and 
have found a few regressions summarised below by commit:


1 ./qemu-system-sparc -cdrom debian-40r4a-sparc-netinst.iso -boot d -bios ss5.bin 
(Boot with real SS-5 PROM instead of OpenBIOS)

-> Hangs during PROM memory test

-> Bisected to:
91b579b5293c4c5c3cfaf0214a5523b655dea4fe is the first bad commit
commit 91b579b5293c4c5c3cfaf0214a5523b655dea4fe
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Fri Oct 13 14:27:57 2023 -0700

     target/sparc: Move JMPL, RETT, RETURN to decodetree

     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
     Message-Id: <20231013212846.165724-37-richard.henderson@linaro.org>


2. ./qemu-system-sparc -hda net702.qcow -snapshot   (NetBSD 7)

-> Hangs after displaying "Starting network"

-> Bisected to:
736a90daf93404d7e9aabf3ea0056ba761385bb0 is the first bad commit
commit 736a90daf93404d7e9aabf3ea0056ba761385bb0
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Fri Oct 13 14:27:46 2023 -0700

     target/sparc: Move ADDC to decodetree

     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
     Message-Id: <20231013212846.165724-26-richard.henderson@linaro.org>


3.
./qemu-system-sparc -cdrom install52.iso -boot d   (OpenBSD 5.2)
-> Displays "sh: internal error" when selecting "(S)hell" option in the installer

./qemu-system-sparc -cdrom NetBSD-6.1.3-sparc.iso -boot d
-> QEMU exits during early boot

(Linux 3.8 test install)
-> Linux panics during kernel boot

-> Bisected to:
902ab5a4076f03be476c64c66b35ebc8a008c9c7 is the first bad commit
commit 902ab5a4076f03be476c64c66b35ebc8a008c9c7
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Fri Oct 13 14:27:58 2023 -0700

     target/sparc: Move FLUSH, SAVE, RESTORE to decodetree

     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
     Message-Id: <20231013212846.165724-38-richard.henderson@linaro.org>


I hope this is enough to be going on with for now: once the 32-bit SPARC tests pass I 
can look at running through the longer set of 64-bit SPARC tests.


ATB,

Mark.


