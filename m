Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D277E2F61
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 23:04:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r07gd-0008Kn-2x; Mon, 06 Nov 2023 17:03:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r07gb-0008Ka-45
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 17:03:09 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r07gZ-0005xP-A1
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 17:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0SH1mJy97xVSwGhaitL1TAM1CQBAxqbVeECAxwSil8Q=; b=PWgzag/c9uhmvIdpKryHSAZP//
 s1LQxznNmSHsOhwQNwhc2+Ikz3JpTndniSdyQQf8vV1rloAbKv1wkCOA1D2BpXmc+R1twgBe+WKO3
 eck8YPnoPe0xHh/7fzzRtFZfH02D0EJcoD9t8zR8Vkm+LjAqVztNdfuZIV6ojr1XreqCx8mFLyMF4
 vfj0i5hEj1j2EDm1Gk0ghVaVykg+dHE+6v4vrkoPCwYk8rjoW7AV/tL2VjQHKsnBZ08yaryNXtDNY
 4Ruc2aiPLhjDaUX3RIah8bGtCl+hQ9FWbZU2eQES0BiDjj7cVTY99auGdhy3Uvago5pCCaHXAoKAJ
 r8GIBsBpkdrY2GwiXo4TpxBJs76/Us0VGGiAesMy55/Vg5fJwnRNO0v5zOBpZ4QZnio+k3aZSvHmE
 wOvT1L0HkFKPdrjDeSum+Mn9YjljLP8iKuUwX6phDGMU3dzSzf8E5QjnW6FEEFsr5vCcmiPLFdh7b
 w6yBUtFlrUEufPmpWMf+o6uDZMWU8CXTsev9sGsQSXih6+Q5FsBecLRiqir/MCXmUqgW+dOW+9VHo
 oNq+q5JecFrl0m4MiH0DuFS7qkhSKasKQUat5n88tfeZgckuXoFAsqmrqJ7Ottzbui7pChOc0J+si
 TSZBu4rR6HQC2LmSya0aoBeQabm5f7DjRELF+F6WQ=;
Received: from [2a00:23c4:8bb0:5400:786d:754a:beab:3c15]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r07gF-0007HJ-QN; Mon, 06 Nov 2023 22:02:51 +0000
Message-ID: <8abcfb1b-6fdd-4d74-a75e-419b89a093ca@ilande.co.uk>
Date: Mon, 6 Nov 2023 22:02:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
 <20231026001542.1141412-111-richard.henderson@linaro.org>
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
In-Reply-To: <20231026001542.1141412-111-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:5400:786d:754a:beab:3c15
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PULL 81/94] target/sparc: Move FDMULQ to decodetree
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

On 26/10/2023 01:15, Richard Henderson wrote:

> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/insns.decode |  1 +
>   target/sparc/translate.c  | 41 +++++++++++++++++++++------------------
>   2 files changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
> index 6817d52ca2..a19d191603 100644
> --- a/target/sparc/insns.decode
> +++ b/target/sparc/insns.decode
> @@ -261,6 +261,7 @@ FDIVs       10 ..... 110100 ..... 0 0100 1101 .....        @r_r_r
>   FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @r_r_r
>   FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @r_r_r
>   FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @r_r_r
> +FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @r_r_r
>   FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
>   FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
>   FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 6626042776..29643768e1 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -1669,21 +1669,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
>   }
>   #endif
>   
> -static void gen_fop_QDD(DisasContext *dc, int rd, int rs1, int rs2,
> -                        void (*gen)(TCGv_ptr, TCGv_i64, TCGv_i64))
> -{
> -    TCGv_i64 src1, src2;
> -
> -    src1 = gen_load_fpr_D(dc, rs1);
> -    src2 = gen_load_fpr_D(dc, rs2);
> -
> -    gen(tcg_env, src1, src2);
> -    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
> -
> -    gen_op_store_QT0_fpr(QFPREG(rd));
> -    gen_update_fprs_dirty(dc, QFPREG(rd));
> -}
> -
>   #ifdef TARGET_SPARC64
>   static void gen_fop_DF(DisasContext *dc, int rd, int rs,
>                          void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i32))
> @@ -4982,6 +4967,27 @@ TRANS(FSUBq, ALL, do_env_qqq, a, gen_helper_fsubq)
>   TRANS(FMULq, ALL, do_env_qqq, a, gen_helper_fmulq)
>   TRANS(FDIVq, ALL, do_env_qqq, a, gen_helper_fdivq)
>   
> +static bool trans_FdMULq(DisasContext *dc, arg_r_r_r *a)
> +{
> +    TCGv_i64 src1, src2;
> +
> +    if (gen_trap_ifnofpu(dc)) {
> +        return true;
> +    }
> +    if (gen_trap_float128(dc)) {
> +        return true;
> +    }
> +
> +    gen_op_clear_ieee_excp_and_FTT();
> +    src1 = gen_load_fpr_D(dc, a->rs1);
> +    src2 = gen_load_fpr_D(dc, a->rs2);
> +    gen_helper_fdmulq(tcg_env, src1, src2);
> +    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
> +    gen_op_store_QT0_fpr(QFPREG(a->rd));
> +    gen_update_fprs_dirty(dc, QFPREG(a->rd));
> +    return advance_pc(dc);
> +}
> +
>   #define CHECK_IU_FEATURE(dc, FEATURE)                      \
>       if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
>           goto illegal_insn;
> @@ -5048,11 +5054,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
>                   case 0x4b: /* fmulq */
>                   case 0x4f: /* fdivq */
>                   case 0x69: /* fsmuld */
> -                    g_assert_not_reached(); /* in decodetree */
>                   case 0x6e: /* fdmulq */
> -                    CHECK_FPU_FEATURE(dc, FLOAT128);
> -                    gen_fop_QDD(dc, rd, rs1, rs2, gen_helper_fdmulq);
> -                    break;
> +                    g_assert_not_reached(); /* in decodetree */
>                   case 0xc6: /* fdtos */
>                       gen_fop_FD(dc, rd, rs2, gen_helper_fdtos);
>                       break;

Hi Richard,

I was working through my SPARC boot tests for your latest target/sparc series when I 
spotted a segfault on my FreeBSD SPARC64 image. A git bisect indicated that this was 
the patch that originally introduced the error, something I must have missed when 
testing the original decodetree conversion series.

The reproducer is:

./qemu-system-sparc64 -m 256 -cdrom FreeBSD-10.3-RELEASE-sparc64-bootonly.iso \
     -boot d -nographic

and the error is a segfault in devd:

...
...
Trying to mount root from cd9660:/dev/iso9660/10_3_RELEASE_SPARC64_BO [ro]...
Entropy harvesting: interrupts ethernet point_to_point swi.
Starting file system checks:
Mounting local file systems:.
Writing entropy file:.
/etc/rc: WARNING: $hostname is not set -- see rc.conf(5).
Starting Network: lo0 hme0.
lo0: flags=8049<UP,LOOPBACK,RUNNING,MULTICAST> metric 0 mtu 16384
         options=600003<RXCSUM,TXCSUM,RXCSUM_IPV6,TXCSUM_IPV6>
         inet6 ::1 prefixlen 128
         inet6 fe80::1%lo0 prefixlen 64 scopeid 0x2
         inet 127.0.0.1 netmask 0xff000000
         nd6 options=21<PERFORMNUD,AUTO_LINKLOCAL>
hme0: flags=8802<BROADCAST,SIMPLEX,MULTICAST> metric 0 mtu 1500
         options=8000b<RXCSUM,TXCSUM,VLAN_MTU,LINKSTATE>
         ether 52:54:00:12:34:56
         nd6 options=29<PERFORMNUD,IFDISABLED,AUTO_LINKLOCAL>
         media: Ethernet autoselect
Starting devd.
pid 246 (ps), uid 0: exited on signal 11
Segmentation fault
^^^^^^^^^^^^^^^^^^

Starting Network: hme0.
hme0: flags=8802<BROADCAST,SIMPLEX,MULTICAST> metric 0 mtu 1500
         options=8000b<RXCSUM,TXCSUM,VLAN_MTU,LINKSTATE>
         ether 52:54:00:12:34:56
         nd6 options=29<PERFORMNUD,IFDISABLED,AUTO_LINKLOCAL>
         media: Ethernet autoselect
...
...


ATB,

Mark.


