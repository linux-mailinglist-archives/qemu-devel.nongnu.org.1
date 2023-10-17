Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C4D7CCF13
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 23:19:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsrSC-0001Fl-55; Tue, 17 Oct 2023 17:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qsrS4-0001F3-Aw
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 17:18:10 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qsrRq-00021i-Ip
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 17:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=27XzjD8m2NQJQXHyCw9VD45HxkrS0qNXehVsFI7KV00=; b=wcgxOMatDWeZC/wVhcZedBwgYR
 IRbXLFh1+gJR3YOPOH4/rveEKdo4Q79PNU7oZb6YOSIYHCkKJh9gq9Z03zFQOt5VxRNbtGYKSGX+O
 6STRpVzG/ClQ90gZh1a630q4hwf3PuVAvG+0R81By/bc70D6UYcpDW/ERiEzg9cC1MszmqpeJ/oD4
 I1ViNZhIzQhFVF6ugC+Sd4Q8v2aDsoU7c+kWBTLzG1ZhbTV+NCg8eWeVuSFjC2mTy6a7pY0hTBJLZ
 gZMXYgDFiYbnvYHiHzson7/64GjeNWkIL/bIlsf5To/f8LaQ0cKFxJXNCt85NH7CJD9PM9pulbymJ
 LYZf8o27rRHr9XbDZ0IfDL05kZXRmOiEAhIzF+SDTazPo7jhc+Sril53KcfA1NMgCYgu9dsyIYtRn
 sohRKsmVw+tz5SQxmVPgpAzZsr8W1e/XplUaXvfCs/WVLobLUNETVgI37JHph6lRgBYyrrbIkkIUf
 77LcybLKLfXUb2kFBJ10uYMIKeqX/v9WuGlpNFm+LhGt9maACnBSzCqNdizxFLXm7DUY/QCw4AP11
 YooM83lpfHskWdeIFA5tKd7vb57n+K31rrSOIioNMWOcuXIggcyuuurlxKuMN/QVZgBX0OfMJnsfM
 ikNVCoBFgIEDo1c1a4/dOEwji3fRwitF7wjLnLz3I=;
Received: from [2a00:23c4:8bb0:3200:407d:a65c:9fb4:b9b4]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qsrRh-0002Fa-2o; Tue, 17 Oct 2023 22:17:49 +0100
Message-ID: <acd5b736-e7cd-4595-8b6c-a72f2e686a9c@ilande.co.uk>
Date: Tue, 17 Oct 2023 22:17:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231017061244.681584-1-richard.henderson@linaro.org>
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
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:3200:407d:a65c:9fb4:b9b4
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 00/90] target/sparc: Convert to decodetree
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

On 17/10/2023 07:11, Richard Henderson wrote:

> While doing some other testing the other day, I noticed my sparc64
> chroot running particularly slowly.  I think I know what the problem
> is there, but fixing that was going to be particularly ugly with the
> existing sparc translator.
> 
> So I've converted the translator to something more managable.  :-)
> 
> Changes for v2:
>    * Fixes for JMPL, RETT, SAVE and RESTORE.
>    * Fixes for FMOV etc, which had lost gen_op_clear_ieee_excp_and_FTT.
>    * Allow conditional exceptions to be raised out of line
>      Use this for gen_check_align and conditional trap.
>    * Keep properties and feature bits in sync.
> 
> r~
> 
> Richard Henderson (90):
>    target/sparc: Clear may_lookup for npc == DYNAMIC_PC
>    target/sparc: Implement check_align inline
>    target/sparc: Avoid helper_raise_exception in helper_st_asi
>    target/sparc: Set TCG_GUEST_DEFAULT_MO
>    configs: Enable MTTCG for sparc, sparc64
>    target/sparc: Define features via cpu-feature.h.inc
>    target/sparc: Use CPU_FEATURE_BIT_* for cpu properties
>    target/sparc: Remove sparcv7 cpu features
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
>   target/sparc/cpu.h                  |   76 +-
>   target/sparc/helper.h               |   16 +-
>   target/sparc/cpu-feature.h.inc      |   14 +
>   target/sparc/insns.decode           |  540 +++
>   target/sparc/cpu.c                  |   41 +-
>   target/sparc/fop_helper.c           |   17 +-
>   target/sparc/ldst_helper.c          |   17 +-
>   target/sparc/translate.c            | 6833 +++++++++++++--------------
>   target/sparc/vis_helper.c           |   59 -
>   target/sparc/meson.build            |    3 +
>   13 files changed, 3985 insertions(+), 3639 deletions(-)
>   create mode 100644 target/sparc/cpu-feature.h.inc
>   create mode 100644 target/sparc/insns.decode

Thanks again for working on this :)  I've done a re-run of my 32-bit SPARC tests and 
things are looking fairly good now, although there were still a small number of failures:

[1] ./qemu-system-sparc -bios ss5.bin

-> Now traps immediately on startup
qemu: fatal: Trap 0x02 (Illegal Instruction) while interrupts disabled, Error state
pc: ffeff020  npc: ffeff024
%g0-7: 00000000 ffffffff ffd15a00 ffef0000 00000002 ffd17384 ffefefd8 ffefebd0
%o0-7: 7000cbcf 0007ffff 00080000 00000000 0000001e 07fee5fc 00000000 0000caf0
%l0-7: 07fff000 ffd173f0 ffd173f4 07fef000 07feec00 00000000 00000000 00000000
%i0-7: 01fee000 00001000 00000000 00000000 00000000 0000beec 0002aa2c ffd1e080
%f00:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f08:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f16:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f24:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
psr: 04000fc7 (icc: ---- SPE: SP-) wim: 00000000
fsr: 00000000 y: 00000000

Aborted (core dumped)

-> Bisected to:

6c8bf6bbe369c7cda82aaba63a19508e8cff5085 is the first bad commit
commit 6c8bf6bbe369c7cda82aaba63a19508e8cff5085
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Mon Oct 16 23:11:34 2023 -0700

     target/sparc: Move Tcc to decodetree

     Use the new delay_exceptionv function in the implementation.

     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
     Message-Id: <20231017061244.681584-21-richard.henderson@linaro.org>

  target/sparc/insns.decode |   2 +
  target/sparc/translate.c  | 143 +++++++++++++++++++++-------------------------
  2 files changed, 66 insertions(+), 79 deletions(-)


[2] ./qemu-system-sparc -hda net702.qcow -snapshot   (NetBSD 7)

-> Hangs after displaying "Starting network"

-> Bisected to:

db639ccbdce25dde5e767f3da1ff40e29067610c is the first bad commit
commit db639ccbdce25dde5e767f3da1ff40e29067610c
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Mon Oct 16 23:11:44 2023 -0700

     target/sparc: Move ADDC to decodetree

     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
     Message-Id: <20231017061244.681584-31-richard.henderson@linaro.org>

  target/sparc/insns.decode |  2 ++
  target/sparc/translate.c  | 41 +++++++++++++++++++++++++++++++++++++----
  2 files changed, 39 insertions(+), 4 deletions(-)


[3] ./qemu-system-sparc -cdrom NetBSD-6.1.3-sparc.iso -boot d

-> Displays "write failed, filesystem full" and "Segmentation Fault" error messages 
during boot

-> Bisected to:

db639ccbdce25dde5e767f3da1ff40e29067610c is the first bad commit
commit db639ccbdce25dde5e767f3da1ff40e29067610c
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Mon Oct 16 23:11:44 2023 -0700

     target/sparc: Move ADDC to decodetree

     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
     Message-Id: <20231017061244.681584-31-richard.henderson@linaro.org>

  target/sparc/insns.decode |  2 ++
  target/sparc/translate.c  | 41 +++++++++++++++++++++++++++++++++++++----
  2 files changed, 39 insertions(+), 4 deletions(-)



ATB,

Mark.

