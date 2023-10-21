Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEB67D1D63
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 16:10:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quCeF-00055d-Vo; Sat, 21 Oct 2023 10:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1quCeD-00055S-QQ
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 10:08:13 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1quCe8-0006GO-5t
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 10:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PO1zGFo1hKUCWugr2n2tyc4wSD0wHo7r/bdQ1+1XmoA=; b=uFcmAu3gqqwYKLdVUPtOdmue6v
 8k7kB1hU0D3uInQ/9nYv4xEwkObphAnrl7I0PBUQLXZ02GL3XHrfB8eMgveP6+VEj02pBgKfrTGJt
 KJr/68sw/J2UfjO/o4ypN2OkkmHMaowClLwwNYD5N67GQb/HkVmtNl5CWdl+nJtQOY+vErnv5hH2O
 RP+1cNOugNCs7BOPW0OGtPiWYy0R3SjGq5oUw/2YFXCOWgkaTSbOxqv5ddjY+eklG82b1mUd7YP2D
 /f4jQ/NWYviBEdmrW121qrksGQxRFUldMMiAxvWMVFdGDlJ4ZWYyBWhrr7teeHitby9RoXDmV8XKB
 zlACWOBybgai13oBzPH7i2CRs6dsAU7PtiFfnBJXFPS1c4bgfOMyRX4gGSud3jq/0x09ERBJBsHHW
 Q+IcEzT3fzbnSaf0Ae9dNwTqw6vi3dr7tEoJiBdx4LYruU8aHdu1S5Dc06Zm95hFk3YcwfejOLLg5
 sFnfq26Bfgy2vhVjDLsMM65ghbfv0w9pkAZGbAttPXwRNm4q24F9StHmdPVWBp6DcSPvGYB0dTxNb
 l41EAgo/LN4izFBYjHfOlhPha94noPW9SAiB/l/X6y8Mtcny02oj/OKKqjOXltV9dByxswWNtob0R
 xh9jow73Hu+o3OVPo19CJFCTmiBuJPjAHKwR5Tl+4=;
Received: from [2a00:23c4:8bb0:3200:3d46:364e:bc78:5cb]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1quCdw-000Ast-87; Sat, 21 Oct 2023 15:08:00 +0100
Message-ID: <fcea777a-d305-450a-b28f-c3a650145d06@ilande.co.uk>
Date: Sat, 21 Oct 2023 15:07:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231021053158.278135-1-richard.henderson@linaro.org>
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
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:3200:3d46:364e:bc78:5cb
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 00/90] target/sparc: Convert to decodetree
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 21/10/2023 06:30, Richard Henderson wrote:

> Changes for v3:
>    * Relax v8 simm13 checking for Tcc.
>    * Split gen_op_addx_int and reorganize to not clobber current cc_op.
>    * Do not replicate decoding for insns that can set cc_op.
> 
> Changes for v2:
>    * Fixes for JMPL, RETT, SAVE and RESTORE.
>    * Fixes for FMOV etc, which had lost gen_op_clear_ieee_excp_and_FTT.
>    * Allow conditional exceptions to be raised out of line
>      Use this for gen_check_align and conditional trap.
>    * Keep properties and feature bits in sync.
> 
> 
> r~
> 
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
>   target/sparc/insns.decode           |  547 +++
>   target/sparc/cpu.c                  |   41 +-
>   target/sparc/fop_helper.c           |   17 +-
>   target/sparc/helper.c               |    8 -
>   target/sparc/ldst_helper.c          |   17 +-
>   target/sparc/translate.c            | 7072 +++++++++++++--------------
>   target/sparc/vis_helper.c           |   59 -
>   target/sparc/meson.build            |    3 +
>   14 files changed, 4127 insertions(+), 3751 deletions(-)
>   create mode 100644 target/sparc/cpu-feature.h.inc
>   create mode 100644 target/sparc/insns.decode

Hi Richard,

I've given v3 a run through my entire set of boot tests, and all the 32-bit SPARC 
tests now pass. Running through the 64-vit SPARC tests I've found a couple of failures:


[1] ./qemu-system-sparc64 -m 256 -hda netbsd615.qcow2 -snapshot -nographic (NetBSD)

-> Displays error on boot

[1]   Illegal instruction (core dumped) chown root:opera...
[1]   Illegal instruction (core dumped) (local line; loc...
init: fatal signal: Illegal instruction

-> Bisected to:

ce60dba1aa7cbf4a4c76b7111b4102ba4734c986 is the first bad commit
commit ce60dba1aa7cbf4a4c76b7111b4102ba4734c986
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Fri Oct 20 22:31:22 2023 -0700

     target/sparc: Split out fp ldst functions with asi precomputed

     Take the operation size from the MemOp instead of a
     separate parameter.

     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
     Message-Id: <20231021053158.278135-55-richard.henderson@linaro.org>

  target/sparc/translate.c | 136 +++++++++++++++++++++++++++--------------------
  1 file changed, 78 insertions(+), 58 deletions(-)


[2] ./qemu-system-sparc64 -M niagara -L niagara/S10image/ -nographic -m 256 -drive 
if=pflash,readonly=on,file=niagara/S10image/disk.s10hw2

-> Traps on startup:

qemu: fatal: Trap 0x0010 while trap level (6) >= MAXTL (6), Error state
pc: 0000000000408070  npc: 0000000000408074
%g0-3: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
%g4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
%o0-3: 0000000000458bf8 000000000042a000 7600000000000000 0000000000000000
%o4-7: ffffffffffffffff 0000000000000000 0000000000000000 0000000000000000
%l0-3: 0000000000000000 0000009800000a00 000000000000001f 0000000000000000
%l4-7: 0000001f12080000 0000000000000000 0000000000458bf8 000000000041446c
%i0-3: 0000000000458900 0000000000458bf8 000000000042a000 000000000042a000
%i4-7: 0000001f12080000 0000000000000000 0000000000000000 0000000000000000
%f00:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f08:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f16:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f24:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f32:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f40:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f48:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f56:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
pstate: 00000014 ccr: 44 (icc: -Z-- xcc: -Z--) asi: 00 tl: 6 pil: 0 gl: 4
tbr: 0000000000000000 hpstate: 0000000000000804 htba: 0000000000400000
cansave: 6 canrestore: 0 otherwin: 0 wstate: 0 cleanwin: 6 cwp: 0
fsr: 0000000000000000 y: 0000000000000000 fprs: 0000000000000000

Aborted (core dumped)

-> Bisected to:

f483f1fb90c84d5f8a9012836f9e807f809db389 is the first bad commit
commit f483f1fb90c84d5f8a9012836f9e807f809db389
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Fri Oct 20 22:30:56 2023 -0700

     target/sparc: Move WRTBR, WRHPR to decodetree

     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
     Message-Id: <20231021053158.278135-29-richard.henderson@linaro.org>

  target/sparc/insns.decode |   9 ++++
  target/sparc/translate.c  | 110 +++++++++++++++++++++++-----------------------
  2 files changed, 65 insertions(+), 54 deletions(-)



ATB,

Mark.


