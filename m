Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F07EC7BA70F
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 18:48:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoRVq-0003Kg-QF; Thu, 05 Oct 2023 12:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoRVp-0003KI-Hh
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:47:45 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoRVn-00054a-1K
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:47:45 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40684f53d11so11672085e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 09:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696524461; x=1697129261; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mvCkQXXAd5EbIJoTbMizcHDwMier6NvN2KTD2NVp/yM=;
 b=O2PCTfxrcojCB8KWMqGzTbM7YgaGC7t2zuoBL0tAOFvA32SYanFAUfynsZ/KcCf0nW
 IvZWVV1CsbeFCZlV4OJirO6+RLXeSDJipC3PYagJEnQ4jnKs9DE6N2XEsjbpqxGSZJD+
 816NiQBhR6i83Ufba2yB79OxZlVL45HkXNrbhZ5QGHBd1RplEAFAp/LhMwRxGHf/077o
 X8VbiD1MerizC4pcsH5q5GimtpKyOVNgXQwmmpD/4ZksNdquHa4/deFtu7p1gYrSIvia
 Yt/Yw52WYdDEe9m4M/aSw7qANnriPws2y+743oj+op1l+giXx8t9jtt7s/PRBxTM6h/9
 jqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696524461; x=1697129261;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mvCkQXXAd5EbIJoTbMizcHDwMier6NvN2KTD2NVp/yM=;
 b=Wy0ha9eqzUeI1f7UOoDIs8ND5OpbTdL9QzBQHIMmJNhe363nxr/VJGbE2T0M6wp2Hk
 xPRG17aesJ9BuFxZ6z8Ws6vEN8LDL3TviWGp9TXA4KRS04OYyApAKSkq29a2vGPZeQ0w
 jvqQwGhhZbHMoCkwncqBn793hGw/fo/K/LxLC/ncd7pbZkAu0VJ9K6KbgokhSdFuwrBB
 dyEt6jYAhfkqACWnbj9wN2IBvvEmtXT+zyujq4GeOb3Eh16WxRht8Pzo9Pz3WZvQNIsD
 GWNhTLWwUmTO4PhjhzxROtl37dCMu7G1epUeDakmsSvInEuXF18MjXH909r8WhhVc2xT
 TVTA==
X-Gm-Message-State: AOJu0Yw1Kla4Co8xVkANshK5SDE/Ekq7VFmLUINUUUI1mM94ZeR4VU2i
 UIRHYDDbJMEtKi55z3cAfqJd6A==
X-Google-Smtp-Source: AGHT+IHklSzWNSu+/N0zmalkDt9ZlkqZEHoJ7Vn8CagQL/W2eNehS1uJDS8viRH+q09wCRodHhPSeQ==
X-Received: by 2002:a1c:7218:0:b0:401:d803:6243 with SMTP id
 n24-20020a1c7218000000b00401d8036243mr5420759wmc.32.1696524461195; 
 Thu, 05 Oct 2023 09:47:41 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a7bc8d7000000b003fe1c332810sm4142613wml.33.2023.10.05.09.47.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 09:47:40 -0700 (PDT)
Message-ID: <4aca22af-5c98-8fb3-9c73-5e61e1ff54b1@linaro.org>
Date: Thu, 5 Oct 2023 18:47:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6 11/19] linux-user/aarch64: Add vdso
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230930021529.987950-1-richard.henderson@linaro.org>
 <20230930021529.987950-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230930021529.987950-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.219,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 30/9/23 04:15, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c             |   6 +++
>   linux-user/aarch64/Makefile.vdso |  15 +++++++
>   linux-user/aarch64/meson.build   |  11 +++++
>   linux-user/aarch64/vdso-be.so    | Bin 0 -> 3216 bytes
>   linux-user/aarch64/vdso-le.so    | Bin 0 -> 3216 bytes
>   linux-user/aarch64/vdso.S        |  71 ++++++++++++++++++++++++++++++
>   linux-user/aarch64/vdso.ld       |  72 +++++++++++++++++++++++++++++++
>   linux-user/meson.build           |   1 +
>   8 files changed, 176 insertions(+)
>   create mode 100644 linux-user/aarch64/Makefile.vdso
>   create mode 100644 linux-user/aarch64/meson.build
>   create mode 100755 linux-user/aarch64/vdso-be.so
>   create mode 100755 linux-user/aarch64/vdso-le.so
>   create mode 100644 linux-user/aarch64/vdso.S
>   create mode 100644 linux-user/aarch64/vdso.ld

Comments are well appreciated, thanks.

To the best of my knowledge,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 1e1fdce656..693ebc94bd 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -944,6 +944,12 @@ const char *elf_hwcap2_str(uint32_t bit)
>   
>   #undef GET_FEATURE_ID
>   
> +#if TARGET_BIG_ENDIAN
> +# define VDSO_HEADER  "vdso-be.c.inc"
> +#else
> +# define VDSO_HEADER  "vdso-le.c.inc"
> +#endif
> +
>   #endif /* not TARGET_AARCH64 */
>   #endif /* TARGET_ARM */
>   
> diff --git a/linux-user/aarch64/Makefile.vdso b/linux-user/aarch64/Makefile.vdso
> new file mode 100644
> index 0000000000..599958116b
> --- /dev/null
> +++ b/linux-user/aarch64/Makefile.vdso
> @@ -0,0 +1,15 @@
> +include $(BUILD_DIR)/tests/tcg/aarch64-linux-user/config-target.mak
> +
> +SUBDIR = $(SRC_PATH)/linux-user/aarch64
> +VPATH += $(SUBDIR)
> +
> +all: $(SUBDIR)/vdso-be.so $(SUBDIR)/vdso-le.so
> +
> +LDFLAGS = -nostdlib -shared -Wl,-h,linux-vdso.so.1 -Wl,--build-id=sha1 \
> +	  -Wl,--hash-style=both -Wl,-T,$(SUBDIR)/vdso.ld
> +
> +$(SUBDIR)/vdso-be.so: vdso.S vdso.ld
> +	$(CC) -o $@ $(LDFLAGS) -mbig-endian $<
> +
> +$(SUBDIR)/vdso-le.so: vdso.S vdso.ld
> +	$(CC) -o $@ $(LDFLAGS) -mlittle-endian $<
> diff --git a/linux-user/aarch64/meson.build b/linux-user/aarch64/meson.build
> new file mode 100644
> index 0000000000..248c578d15
> --- /dev/null
> +++ b/linux-user/aarch64/meson.build
> @@ -0,0 +1,11 @@
> +# TARGET_BIG_ENDIAN is defined to 'n' for little-endian; which means it
> +# is always true as far as source_set.apply() is concerned.  Always build
> +# both header files and include the right one via #if.
> +
> +vdso_be_inc = gen_vdso.process('vdso-be.so',
> +                               extra_args: ['-r', '__kernel_rt_sigreturn'])
> +
> +vdso_le_inc = gen_vdso.process('vdso-le.so',
> +                               extra_args: ['-r', '__kernel_rt_sigreturn'])
> +
> +linux_user_ss.add(when: 'TARGET_AARCH64', if_true: [vdso_be_inc, vdso_le_inc])
> diff --git a/linux-user/aarch64/vdso-be.so b/linux-user/aarch64/vdso-be.so
> new file mode 100755
> index 0000000000000000000000000000000000000000..6084f3d1a701316004894fcdd739c4e1e0463b68
> GIT binary patch
> literal 3216
> zcmc&$O>A355T57v+64N8Q&ABq6>X&mRj7RmMS`Gmu!EhX$W24qs-c&yv0q~6$41XD
> z#X$mc;KBh>)D!9f7jbE&o<UsN14xy6s{mC(f)i3Dq>3KO1&W#3omsDqjgUAn$-Zyr
> zo0*+`yF2UmUcNA$N_k+#hcB@25ZaP4_Th`HO~N+FKpLJveLJ?m*pV~RgWjm21z{L<
> z$}wd4LC@e<V_`J2N+HMjyq2;54GrCSjp1_g^L!^RXc~uJgeN&rkn%{wuD59Hy$Csu
> z6QuW}xHPtHGjnI)CU#JW^L5YkDUVO~&u;(z;i>e4`!_DFeDmp#mw&i^<zSxu2zGP-
> z93zc`;?p}pz5VAyLe#f3U`~Vnm#otsp`=<G03K(2i*W~|-luxI{fE(m3?b@|j1IK+
> zq|3fcF#mr*xCdaTNgUke3DA1y9R42jv>z)Y(0;(W3!dXI>qX-{<?y#SfcSq9uZ2e1
> zUtVwB=e^KjQdiCy);`2j+up*`@G|ff>*VL(Jr;fPar2{J(&x^9ec+i^?x(BSN1)Vd
> z6xX6PwHzf$bv>#tm5ZAlwzO6+t%|J=9Y>808z-t!U5=w<Bd)<(wYJeba-rO)hxq>-
> z6pqiGSyV^E7sBUX!r9;<vVWv`=5N>i8&^=H^Slq6Ij8hSDe#8W?GM<704wzH#{6Rl
> z<WF81Y=^Ot=r#7<UVxzav^TbMzi@OmX}>3kP~-l0hxTsW!QgLi`s#bF@9x%T9lbJQ
> zY!o|4aN}q$C{o`>LtdYI<XeWZJeo*sU1<$TsZTvuP2vN2smpoc2$ARWV(V9%ksmUC
> zwvL6T^NbSoj{g|*8H47D<8ZypeP?;D``}`aztok~1DU;`fBleezjdSEhJND^CwV`|
> zzLf#v@9}KjuJs?oz<%!)cKrQWJ2>781M2@Zr_SAbWZB{G@i?^Z?>M}yPa6444u6aN
> z(@-i+W?!6HJsZ|xybR+_P`TIVvL}weg5`%7zsk?5>4ofxyqe7|fSM_soXQr|$?54+
> z`P1rjcB+t9-4$r--d6bFQntST=8k}{vALcU-#|=agB9u3>PZA)d9zkrua<NNeG!XE
> z5yIu#Mp!8}Duz#D!(52sMzvn+QdAkjsG^qQ;(DYiW%Lvc!X#=YylDRs=v;8!*t%Ub
> zW7@jT_2i&^6*-6<_x?sz&YeZ_l^oQUcsd8qVw2xfzBf`W<WK~G>W$*LZfyK0az`B=
> zOP9o-=tekTbo-S2gfC;0-yF_wz7ueqd5$=Y$YX0p;sews@%Q~V_LKN6qx+07iF&_y
> za+`8&63=yF?=kuAAb%2B2kO6y`P<Y%;dr^{1oge*=4U_cf428~1@Fm>9?hbjKdryS
> z$@`Pr5;mES<ZqGz$6>VJiH5fKy;kWM_r}wHqu6`)kkRea&Hpa463^!_;Pn&K^S8m+
> zp?wpfSa~nu80C99^(GSZO}Up1l7AF+`VDc{mR$&j&a-ljQ9$NP`UtiG@xy#y!}}7*
> HXyg9^8}}&g
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/linux-user/aarch64/vdso-le.so b/linux-user/aarch64/vdso-le.so
> new file mode 100755
> index 0000000000000000000000000000000000000000..947d534ec1899740edbd6921da6bc6e70e2ecd09
> GIT binary patch
> literal 3216
> zcmcguL2MgU5FKYzk|v=|N~=Z+qD6{Og<utmRJD|Y9c(v2Zd%etExr7@_Qp0%>~_6L
> z9VDO!E}RJB#LXZsa7BWO3q5c^;)VcKz2t<11S;tPP82h<JI`MKYy}b$WB;B1-^~2^
> z`~S@Be=AqW52R8Aa_9@{jfm1J*c^t2V8>|}KgVe=J;LxHx3r3FKB<#|V;X^n)Fz2-
> z%cM-;q^lZWOhj#+*XG^Ds~rB${uGqOuBG$Zd_T*Cz*Q~uCH;#!pUtzO6%jc6iOo2-
> zUEEGBEQ!`_!5rx^Nnd=)Smd95v^A8^_@B?;{q2QA>mys0rC%Ro5$%x&)1`=ocG5ko
> z6aD^Iry=8;Iu?IIw{$G$Bh;3SV;YGV-B3QNd{X(JooK$aERgAej@6vDbv&c;NbCQ9
> zy6kcvjnN%lhwQabmYd)|D~|JcjqwS(-w~ZS$+3$5Eo+{GihpC_aoczwaVXo4J(oVt
> zLv%HS2r(>}=m;)N?7pOQiiV@`7Cn)F;GMkl%e$@jzP@~EJllTi@Po`JTV%{t&#!wc
> zrs4%bZPjZmmx~)cw6xMFU4<+G_Pu5g^#jwaReUd4^Xs%ytFN`5T`xBqF8`mS!u-P0
> zMRU|W=01Od7sIQ^Pev*IefZVAM<t#g=Z097cN$>%JKvfi<dvL*P-@CKDVXS_xjn;8
> z2<Mo3eUS!RPo$>C4uzP+=NPvcQDQRF&JRZp-29I1zrXF6AH(sU{_$LFT%Cwyk#+LZ
> z;ng6&;~EaXMOzkXk;A9cMq<Qd4rl3%9GpcCM+5RUE^_$fk-z=;P&beJ@nK5JKZkY`
> z^0r@pq+9p;@lo2;`0mGh`2bvAe=s3`<V@rg?S0!D;ydSw^hfFA1iwl1?+a(Y-?8_9
> zDx81kdr4hL@jB<M{m(L<l>e_Vo>WIFiraPM4aMzx@xJ0a>P4w^{aUtsrS3Lpx=hn8
> zGTB!bGN<QX;`HOfZ*p@cznD3lGjrKRGN%e>W-|qICZ9i-J8#ZsW(zsfpMl-H?`HVJ
> zQ@N}AZ)ya&&5hNdc!hc3N4$z&y%BiimN)9f)mka+urBjrP$aifUvsO)W;MbCKSI_$
> zzgcV4`v#^=u2(h7esR?^)iP^hL~h`<0^Y;_N)i`xuRvNNF2N-Z;)L%5uqU}Abr|7;
> zxC7_l3JG@?*rRSe%~JWM!awQ*_-14tu2H6fJ-)w38511-QAfZJvn)=q2Y-=;^38#N
> z)EjWrS<DYRq~me6{e!>put!}27rBsaAE89EDuX@lA>g=oKwq~LLwcEeotS^rIq;}{
> z^!&pQ_yx9?I}66Bhu~O0Vg&Dx1uSz%)&%>9-4mgYeZyE{IBt*n3VsBN%5DE|sy*%y
> zs59VLKc=z$$9+Rb__iuu(-)I_<pFN+KPgH~ySd?PLqH#wHQ+yugWR{zZ-TKT`w?~Y
> I_CMJF4X7R_od5s;
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/linux-user/aarch64/vdso.S b/linux-user/aarch64/vdso.S
> new file mode 100644
> index 0000000000..34d3a9ebd2
> --- /dev/null
> +++ b/linux-user/aarch64/vdso.S
> @@ -0,0 +1,71 @@
> +/*
> + * aarch64 linux replacement vdso.
> + *
> + * Copyright 2023 Linaro, Ltd.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <asm/unistd.h>
> +
> +/* ??? These are in include/elf.h, which is not ready for inclusion in asm. */
> +#define NT_GNU_PROPERTY_TYPE_0  5
> +#define GNU_PROPERTY_AARCH64_FEATURE_1_AND      0xc0000000
> +#define GNU_PROPERTY_AARCH64_FEATURE_1_BTI      (1U << 0)
> +#define GNU_PROPERTY_AARCH64_FEATURE_1_PAC      (1U << 1)
> +
> +#define GNU_PROPERTY_AARCH64_FEATURE_1_DEFAULT \
> +    (GNU_PROPERTY_AARCH64_FEATURE_1_BTI | GNU_PROPERTY_AARCH64_FEATURE_1_PAC)
> +
> +	.section .note.gnu.property
> +	.align	3
> +	.long	2f - 1f
> +	.long	6f - 3f
> +	.long	NT_GNU_PROPERTY_TYPE_0
> +1:	.string	"GNU"
> +2:	.align	3
> +3:	.long	GNU_PROPERTY_AARCH64_FEATURE_1_AND
> +	.long	5f - 4f
> +4:	.long	GNU_PROPERTY_AARCH64_FEATURE_1_DEFAULT
> +5:	.align	3
> +6:
> +
> +	.text
> +
> +.macro endf name
> +	.globl	\name
> +	.type	\name, @function
> +	.size	\name, . - \name
> +.endm
> +
> +.macro vdso_syscall name, nr
> +\name:
> +	bti	c
> +	mov	x8, #\nr
> +	svc	#0
> +	ret
> +endf	\name
> +.endm
> +
> +	.cfi_startproc
> +
> +vdso_syscall __kernel_gettimeofday, __NR_gettimeofday
> +vdso_syscall __kernel_clock_gettime, __NR_clock_gettime
> +vdso_syscall __kernel_clock_getres, __NR_clock_getres
> +
> +	.cfi_endproc
> +
> +
> +/*
> + * TODO: The kernel makes a big deal of turning off the .cfi directives,
> + * because they cause libgcc to crash, but that's because they're wrong.
> + *
> + * For now, elide the unwind info for __kernel_rt_sigreturn and rely on
> + * the libgcc fallback routine as we have always done.  This requires
> + * that the code sequence used be exact.
> + */
> +__kernel_rt_sigreturn:
> +	/* No BTI C insn here -- we arrive via RET. */
> +	mov	x8, #__NR_rt_sigreturn
> +	svc	#0
> +endf	__kernel_rt_sigreturn
> diff --git a/linux-user/aarch64/vdso.ld b/linux-user/aarch64/vdso.ld
> new file mode 100644
> index 0000000000..4c12f33352
> --- /dev/null
> +++ b/linux-user/aarch64/vdso.ld
> @@ -0,0 +1,72 @@
> +/*
> + * Linker script for linux aarch64 replacement vdso.
> + *
> + * Copyright 2021 Linaro, Ltd.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +VERSION {
> +        LINUX_2.6.39 {
> +        global:
> +                __kernel_rt_sigreturn;
> +                __kernel_gettimeofday;
> +                __kernel_clock_gettime;
> +                __kernel_clock_getres;
> +
> +        local: *;
> +        };
> +}
> +
> +
> +PHDRS {
> +        phdr            PT_PHDR         FLAGS(4) PHDRS;
> +        load            PT_LOAD         FLAGS(7) FILEHDR PHDRS;
> +        dynamic         PT_DYNAMIC      FLAGS(4);
> +        eh_frame_hdr    PT_GNU_EH_FRAME;
> +        note            PT_NOTE         FLAGS(4);
> +}
> +
> +SECTIONS {
> +        /*
> +         * We can't prelink to any address without knowing something about
> +         * the virtual memory space of the host, since that leaks over into
> +         * the available memory space of the guest.
> +         */
> +        . = SIZEOF_HEADERS;
> +
> +        /*
> +         * The following, including the FILEHDRS and PHDRS, are modified
> +         * when we relocate the binary.  We want them to be initially
> +         * writable for the relocation; we'll force them read-only after.
> +         */
> +        .note           : { *(.note*) }         :load :note
> +        .dynamic        : { *(.dynamic) }       :load :dynamic
> +        .dynsym         : { *(.dynsym) }        :load
> +        /*
> +         * There ought not be any real read-write data.
> +         * But since we manipulated the segment layout,
> +         * we have to put these sections somewhere.
> +         */
> +        .data           : {
> +                *(.data*)
> +                *(.sdata*)
> +                *(.got.plt) *(.got)
> +                *(.gnu.linkonce.d.*)
> +                *(.bss*)
> +                *(.dynbss*)
> +                *(.gnu.linkonce.b.*)
> +        }
> +
> +        .rodata         : { *(.rodata*) }
> +        .hash           : { *(.hash) }
> +        .gnu.hash       : { *(.gnu.hash) }
> +        .dynstr         : { *(.dynstr) }
> +        .gnu.version    : { *(.gnu.version) }
> +        .gnu.version_d  : { *(.gnu.version_d) }
> +        .gnu.version_r  : { *(.gnu.version_r) }
> +        .eh_frame_hdr   : { *(.eh_frame_hdr) }  :load :eh_frame_hdr
> +        .eh_frame       : { *(.eh_frame) }      :load
> +
> +        .text           : { *(.text*) }         :load   =0xd503201f
> +}
> diff --git a/linux-user/meson.build b/linux-user/meson.build
> index e4cb70ed2d..dd24389052 100644
> --- a/linux-user/meson.build
> +++ b/linux-user/meson.build
> @@ -35,6 +35,7 @@ gen_vdso_exe = executable('gen-vdso', 'gen-vdso.c',
>   gen_vdso = generator(gen_vdso_exe, output: '@BASENAME@.c.inc',
>                        arguments: ['-o', '@OUTPUT@', '@EXTRA_ARGS@', '@INPUT@'])
>   
> +subdir('aarch64')
>   subdir('alpha')
>   subdir('arm')
>   subdir('hppa')


