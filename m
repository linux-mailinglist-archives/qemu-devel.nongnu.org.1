Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CBE7D231E
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 14:46:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quXpI-0007ZE-TA; Sun, 22 Oct 2023 08:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1quXpF-0007Yz-Ux
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 08:45:01 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1quXpD-0000bR-HG
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 08:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kgH+Q+P/lHMJDZpssydq84O/eHC+ZXgBDjbOcDpmyX8=; b=bHEPogtSjVX88vcDsN4E142U2Q
 iXY8nAd0dcJPuu5m83jqZi/s4qTvsJASGRqI8p23Wz017PLW9efG2JcRZX23lFFNbdF/E9Bv6gLph
 mqUb3/DPq3+fqxEKl/sDGKdIKpIozWc7DN+hBPytAYA+hD6gsuLPmP0K0A7HKM6wp4wSsHbEF8YY9
 giLqnq/MzPPxBgp1CHxumIlfZNu6iNzdu/S9mKvaCUWhrGrnX3b1V+3/j29q84P51uCJu0mqsuNlD
 XsqtUZ/DRlWs21Fk2jixj4cZjgEfwxSnvCx4grA4JVRfbjRGeWvM3r7kC5M8JuI3Fnmxt8dE6dvDS
 OshUeqcyk9+aXfsKFG2xwMkk0t3/OdEjt1AmxAudSlUFielmM7jKj2sLfIc9Iqr4Rl5fpBue/u/Me
 F+Vgqjv3/V4FrfQWEo3zlYztIztd+F+YVwrQfWPj2db69soDNDzaod3xm2YlIhvwi5fKTfgXBySWi
 FVIcbLRCtA29H9C0spDRtAhqQ26fEjjs1Tc61Z1y/4Lm9wI4xb5uU8HkLa98qvXkaxh/kquhaArkj
 gatHTwH7caEqNtN98UwHJAh6vL9E6zRp6mWBSkWuPDDcVzr6XulWNFxGvDQBn4YL3sFoMesYA5Iqo
 q/cDmkjyPjTQDV0S8/JaWsQoYJa9WIGUOvQoW22RQ=;
Received: from [2a00:23c4:8bb0:3200:ef67:44e:255:4a10]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1quXp1-00069c-HB; Sun, 22 Oct 2023 13:44:51 +0100
Message-ID: <f4fec7ec-7aff-475f-a055-eaf4069830e8@ilande.co.uk>
Date: Sun, 22 Oct 2023 13:44:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231022060031.490251-1-richard.henderson@linaro.org>
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
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:3200:ef67:44e:255:4a10
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v4 00/90] target/sparc: Convert to decodetree
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

On 22/10/2023 06:59, Richard Henderson wrote:

> Changes for v4:
>    * Implement htstate for RDHPR, WRHPR.
>      This was the issue with sun4v rom, "wrhpr %g0, %htstate".
>      Previously we "implemented" this with nop.  But since we
>      have env->htstate[], add the obvious implementation.

Ah I see. So presumably the patch that implements this could also have a Fixes: 
https://gitlab.com/qemu-project/qemu/-/issues/847 tag?

>    * The fp asi reorg got lost with "sizes", one of which was for
>      the size of the access, and the other was a proxy for the
>      original instruction.  This broke "stda reg, [addr] #ASI_FL8_P",
>      used in Mark's netbsd image.

I found a build failure when building this series with --target-list='sparc-softmmu 
sparc64-softmmu':

cc -m64 -mcx16 -Ilibqemu-sparc-softmmu.fa.p -I. -I.. -Itarget/sparc -I../target/sparc 
-Iqapi -Itrace -Iui -Iui/shader -I/usr/include/pixman-1 -I/usr/include/spice-server 
-I/usr/include/spice-1 -I/usr/include/glib-2.0 
-I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fdiagnostics-color=auto -Wall 
-Winvalid-pch -Werror -std=gnu11 -O2 -g -fstack-protector-strong -Wundef 
-Wwrite-strings -Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls 
-Wold-style-declaration -Wold-style-definition -Wtype-limits -Wformat-security 
-Wformat-y2k -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs 
-Wendif-labels -Wexpansion-to-defined -Wimplicit-fallthrough=2 
-Wmissing-format-attribute -Wno-missing-include-dirs -Wno-shift-negative-value 
-Wno-psabi -isystem /home/build/src/qemu/git/qemu/linux-headers -isystem 
linux-headers -iquote . -iquote /home/build/src/qemu/git/qemu -iquote 
/home/build/src/qemu/git/qemu/include -iquote 
/home/build/src/qemu/git/qemu/host/include/x86_64 -iquote 
/home/build/src/qemu/git/qemu/host/include/generic -iquote 
/home/build/src/qemu/git/qemu/tcg/i386 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 
-D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -fPIE 
-isystem../linux-headers -isystemlinux-headers -DNEED_CPU_H 
'-DCONFIG_TARGET="sparc-softmmu-config-target.h"' 
'-DCONFIG_DEVICES="sparc-softmmu-config-devices.h"' -MD -MQ 
libqemu-sparc-softmmu.fa.p/target_sparc_translate.c.o -MF 
libqemu-sparc-softmmu.fa.p/target_sparc_translate.c.o.d -o 
libqemu-sparc-softmmu.fa.p/target_sparc_translate.c.o -c ../target/sparc/translate.c
In file included from ../target/sparc/translate.c:21:
../target/sparc/translate.c: In function ‘do_wrhtstate’:
/home/build/src/qemu/git/qemu/include/qemu/osdep.h:261:35: error: call to 
‘qemu_build_not_reached_always’ declared with attribute error: code path is reachable
   261 | #define qemu_build_not_reached()  qemu_build_not_reached_always()
       |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../target/sparc/translate.c:3800:5: note: in expansion of macro ‘qemu_build_not_reached’
  3800 |     qemu_build_not_reached();
       |     ^~~~~~~~~~~~~~~~~~~~~~
[10/23] cc -m64 -mcx16 -Iqemu-io.p

The quick diff below was enough to get the build going for me:

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d4468f6673..49b353089e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3797,7 +3797,7 @@ static void do_wrhtstate(DisasContext *dc, TCGv src)

      tcg_gen_st_i64(src, tp, offsetof(CPUSPARCState, htstate));
  #else
-    qemu_build_not_reached();
+    g_assert_not_reached();
  #endif
  }

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
>   target/sparc/insns.decode           |  547 ++
>   target/sparc/cpu.c                  |   41 +-
>   target/sparc/fop_helper.c           |   17 +-
>   target/sparc/helper.c               |    8 -
>   target/sparc/ldst_helper.c          |   17 +-
>   target/sparc/translate.c            | 7115 +++++++++++++--------------
>   target/sparc/vis_helper.c           |   59 -
>   target/sparc/meson.build            |    3 +
>   14 files changed, 4170 insertions(+), 3751 deletions(-)
>   create mode 100644 target/sparc/cpu-feature.h.inc
>   create mode 100644 target/sparc/insns.decode

Otherwise this version passes all my boot tests so:

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Feel free to take this via tcg-next if it's easier for you, and thanks once again for 
such a great piece of work :)


ATB,

Mark.


