Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 425D17B3D92
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 04:17:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmPWU-0000Jw-I3; Fri, 29 Sep 2023 22:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmPWN-0000G4-2c
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 22:15:55 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmPWG-00020y-6K
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 22:15:54 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-27777b778bfso6157452a91.3
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 19:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696040144; x=1696644944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QMALYQ6ZHTn7wyG3+42rapaOzHSgcSBLV1NTBu/gWFs=;
 b=Qf/zU/jnvYcrH6pz6thu9O3On9aBU2kT1B8UhPFtPZLXDaIQj4rCuDjzcZMGBmPYZv
 udDBrteKge/C0OSJ+GnUIw56xLfs+8vPpxv6l0YeDGBsMp4K52Zm+E7TlW8GHs4QU1QS
 y/qoUfmxbUZxnNZiinD/nTcG2FbF/89dU/ZBZe9OE/cickmA5qsavut5ImoT1MON9zrr
 LVNbDnW1CIL3PDNvJsGGajgTQ2PeGMtrLKeMvO4n8nAkJgnXY5VAilFX55vXOo2TZxPp
 GC7peW6q+YMpvHcoZ8zMMizOQHLeq/FwXNI8mtzQGXNkSyruCPezsUtzNRHLsWF6MHea
 S7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696040144; x=1696644944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QMALYQ6ZHTn7wyG3+42rapaOzHSgcSBLV1NTBu/gWFs=;
 b=Wwq8bbcCgCMdYlZvR5YfMeNJ9SerhENmj7D8Jv9d74FSDW5qIffLZGgni82qnQSadW
 qzmJ3Z18bQFS+Ym5/sGy2bCCqCX9ka0Sphzc1y8sgejd7u6FagNkl0NJBxbQuW2tVWLf
 Ip5HQzG3wS5yOm7Z4DyVGPrRysrLqvSQkWOzuXwKi7ST5Y/OIY4QPzMutGYqwGHk7MzF
 pAjWeje1ClyFw7NVn66b6FY+jbG9gng/7cHwJ1XZ4ye7wl5vE28PMPuUUr2qrAJVbp+R
 pSxgol911G5vj9yag6Lt8VhuULXH7vHfu484RijnMpWjWeFoFqcfz9uWESzM+/ND2xiV
 XvSA==
X-Gm-Message-State: AOJu0YwOOqeB09rxr3lX000i0/9SHghl2LEdki/lLs+ZvXEH+siSJy3a
 ruLzNe9kWO4FzizcGyoQHVL49TA/ZlqD5y0FA8U=
X-Google-Smtp-Source: AGHT+IHIm7SDeUBonhtILUxMNzXUdzFNY/COtyT1nHoNeVLv90d/LQI5zJsIYQ7xPP+J9UDd0pF5Aw==
X-Received: by 2002:a17:90a:d38c:b0:269:3771:7342 with SMTP id
 q12-20020a17090ad38c00b0026937717342mr5105088pju.18.1696040144231; 
 Fri, 29 Sep 2023 19:15:44 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fv21-20020a17090b0e9500b002775281b9easm2130692pjb.50.2023.09.29.19.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 19:15:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 14/19] linux-user/riscv: Add vdso
Date: Fri, 29 Sep 2023 19:15:24 -0700
Message-Id: <20230930021529.987950-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930021529.987950-1-richard.henderson@linaro.org>
References: <20230930021529.987950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/riscv/vdso-asmoffset.h |   9 ++
 linux-user/elfload.c              |   2 +
 linux-user/riscv/signal.c         |   8 ++
 linux-user/meson.build            |   1 +
 linux-user/riscv/Makefile.vdso    |  15 +++
 linux-user/riscv/meson.build      |   7 ++
 linux-user/riscv/vdso-32.so       | Bin 0 -> 2888 bytes
 linux-user/riscv/vdso-64.so       | Bin 0 -> 3840 bytes
 linux-user/riscv/vdso.S           | 186 ++++++++++++++++++++++++++++++
 linux-user/riscv/vdso.ld          |  74 ++++++++++++
 10 files changed, 302 insertions(+)
 create mode 100644 linux-user/riscv/vdso-asmoffset.h
 create mode 100644 linux-user/riscv/Makefile.vdso
 create mode 100644 linux-user/riscv/meson.build
 create mode 100755 linux-user/riscv/vdso-32.so
 create mode 100755 linux-user/riscv/vdso-64.so
 create mode 100644 linux-user/riscv/vdso.S
 create mode 100644 linux-user/riscv/vdso.ld

diff --git a/linux-user/riscv/vdso-asmoffset.h b/linux-user/riscv/vdso-asmoffset.h
new file mode 100644
index 0000000000..123902ef61
--- /dev/null
+++ b/linux-user/riscv/vdso-asmoffset.h
@@ -0,0 +1,9 @@
+#ifdef TARGET_ABI32
+# define sizeof_rt_sigframe     0x2b0
+# define offsetof_uc_mcontext   0x120
+# define offsetof_freg0         0x80
+#else
+# define sizeof_rt_sigframe     0x340
+# define offsetof_uc_mcontext   0x130
+# define offsetof_freg0         0x100
+#endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ccf8a1dc78..ff6951950b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1884,8 +1884,10 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 #ifdef TARGET_RISCV32
 #define ELF_CLASS ELFCLASS32
+#define VDSO_HEADER "vdso-32.c.inc"
 #else
 #define ELF_CLASS ELFCLASS64
+#define VDSO_HEADER "vdso-64.c.inc"
 #endif
 
 #define ELF_HWCAP get_elf_hwcap()
diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
index f989f7f51f..941eadce87 100644
--- a/linux-user/riscv/signal.c
+++ b/linux-user/riscv/signal.c
@@ -21,6 +21,7 @@
 #include "user-internals.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
+#include "vdso-asmoffset.h"
 
 /* Signal handler invocation must be transparent for the code being
    interrupted. Complete CPU (hart) state is saved on entry and restored
@@ -37,6 +38,8 @@ struct target_sigcontext {
     uint32_t fcsr;
 }; /* cf. riscv-linux:arch/riscv/include/uapi/asm/ptrace.h */
 
+QEMU_BUILD_BUG_ON(offsetof(struct target_sigcontext, fpr) != offsetof_freg0);
+
 struct target_ucontext {
     abi_ulong uc_flags;
     abi_ptr uc_link;
@@ -51,6 +54,11 @@ struct target_rt_sigframe {
     struct target_ucontext uc;
 };
 
+QEMU_BUILD_BUG_ON(sizeof(struct target_rt_sigframe)
+                  != sizeof_rt_sigframe);
+QEMU_BUILD_BUG_ON(offsetof(struct target_rt_sigframe, uc.uc_mcontext)
+                  != offsetof_uc_mcontext);
+
 static abi_ulong get_sigframe(struct target_sigaction *ka,
                               CPURISCVState *regs, size_t framesize)
 {
diff --git a/linux-user/meson.build b/linux-user/meson.build
index dd24389052..3ff3bc5bbc 100644
--- a/linux-user/meson.build
+++ b/linux-user/meson.build
@@ -45,6 +45,7 @@ subdir('microblaze')
 subdir('mips64')
 subdir('mips')
 subdir('ppc')
+subdir('riscv')
 subdir('s390x')
 subdir('sh4')
 subdir('sparc')
diff --git a/linux-user/riscv/Makefile.vdso b/linux-user/riscv/Makefile.vdso
new file mode 100644
index 0000000000..2c257dbfda
--- /dev/null
+++ b/linux-user/riscv/Makefile.vdso
@@ -0,0 +1,15 @@
+include $(BUILD_DIR)/tests/tcg/riscv64-linux-user/config-target.mak
+
+SUBDIR = $(SRC_PATH)/linux-user/riscv
+VPATH += $(SUBDIR)
+
+all: $(SUBDIR)/vdso-32.so $(SUBDIR)/vdso-64.so
+
+LDFLAGS = -nostdlib -shared -fpic -Wl,-h,linux-vdso.so.1 -Wl,--build-id=sha1 \
+	  -Wl,--hash-style=both -Wl,-T,$(SUBDIR)/vdso.ld
+
+$(SUBDIR)/vdso-32.so: vdso.S vdso.ld vdso-asmoffset.h
+	$(CC) -o $@ $(LDFLAGS) -mabi=ilp32d -march=rv32g $<
+
+$(SUBDIR)/vdso-64.so: vdso.S vdso.ld vdso-asmoffset.h
+	$(CC) -o $@ $(LDFLAGS) -mabi=lp64d -march=rv64g $<
diff --git a/linux-user/riscv/meson.build b/linux-user/riscv/meson.build
new file mode 100644
index 0000000000..beb989a7ca
--- /dev/null
+++ b/linux-user/riscv/meson.build
@@ -0,0 +1,7 @@
+vdso_32_inc = gen_vdso.process('vdso-32.so',
+                               extra_args: ['-r', '__vdso_rt_sigreturn'])
+vdso_64_inc = gen_vdso.process('vdso-64.so',
+                               extra_args: ['-r', '__vdso_rt_sigreturn'])
+
+linux_user_ss.add(when: 'TARGET_RISCV32', if_true: vdso_32_inc)
+linux_user_ss.add(when: 'TARGET_RISCV64', if_true: vdso_64_inc)
diff --git a/linux-user/riscv/vdso-32.so b/linux-user/riscv/vdso-32.so
new file mode 100755
index 0000000000000000000000000000000000000000..274b92c23dca9b44da32cb0c293f879c03a5f8ae
GIT binary patch
literal 2888
zcmb_eU2Icj7=BMnu}qj912f!W2AjB$*>rUfg3GdY>-e#3%V3I1JnPzSZDj4zo-VKu
z2M!Sx1sxzF>HtMl)Cnk}C?uMg=#7b2-fO%u#vk-Tk@-C5oUfeeF1+yFp1$AvbKdiP
z=X<~BoY6?MUDGsC;+9`US&eW`ctvJGH%hh4mO3dDA2jXjxQsEuJi;w9RPVvSmR4Ic
z#@edB?H1+|H_+h|aY0oeN#QVTLe=m3&PW`_O%!SoBUGIFiUTvn7a)!jvbv*3>NlT0
zbjEx2%E52H9Q~v7+%M-BUm7h%%m7%c4HNq9+EjKsG?#S|n$KVob1Z@02iyo?>ed>d
z@z_k6gWtKp)v2j$FK+l3G}reNbd(eLAEbo^A#Ti;&-N51y$O0g?z{}zi%D}nw0A)(
zDU+Y4dSTQ$;tLsc*io1j4!aq)&tY?qxD2k7ntRA+;}oQu!a4AHQaEMiQxm*KE1T00
z5}%JY^UQwuqH=P>zCfz#z}~5o7X}wEI?<YGTKM^q+b8>yqU*znd{!Sw8b*3Bne9)+
zwkcnHOE&(Hiu}u&OXigi7srPR%Ie=z$fxvlJQhzC%jXO|pB~61jY2LXThf`r);oAx
zKmHpey0)WdliuiWSdIxpT+{y8>(<|~OFzzI&s72JD+>3@h2O&H_a%%`)c$Cd?z^gC
z^BMV&xDq-A-37e|`YQbZ#XZt3+ICH=oaYkOsQ|tL*aOm4TAe^MGdBRRRy8!`fTei-
z1{7$~D(AW;J)V}t&b~)_#~$3Z`O*7#Z+h&WJsThIexmEij=j;R);+yuU;F;HXTs06
zj5i->I=Jf4%I8)bZhSs?B=Ca&X#I=JUaEU}=|tPH@bQ)t&95}Qy6WW0*H)Zrd_DL^
z;7$MO`nQ(7UH8t?$=Y|9oT)y0>$$4;Zh61r{LLRMxG?`i-$$hv=YCxBiTBcMbFN1*
zH$DrV9ZGz+M`|X3;~pv3v}-kW$E4h&$+$PLD3AEq5>4DSAsMULDPy;38gg85pT|}1
z>H0HX<wmYZdFhVkvtNJeu9@gToq`PPkmB{@-d?lLxOYbh>oK44a*W5llV18lVf^IM
z`S`GC+z(G~_|9NDIMkpI28RNAjHCYGP*6|sXCxiZ=jb0v_a`&)Boes+GsqR&=QcaS
z;yt?D=E<;l#<JNBA}u^15T17m`HA8-*-3;vW!ctABwty!d7?z|j@xFbUaKsw=P9;$
z)ygNkf$xfOvYf>))b8T$(4sxhUV&xL0>5zo$VZl_-Lx#mZ^DoqLeXHecLO$I&<?^T
z&s$O=5e(G&8Gk^9pvh<b&`!P@f$ikOr(rw!i+$$gze(6mzWfZflMf{xU)~<>TCvWb
zmD;VMx82tfTEDhc^sesC)<|1VcSHvz+#OmS(Km*|(TEOa!8=BetkK)ML+c~@nznAy
zS4TU;p{U;3-o7ESQ6)O4#3r_x*k~rQo6cd=_{y$Sq(cYu6@4U65r2N$pb_hXHgc9u
zsZl0tB*mZDmWd6f<K_Ul&@m$>{((%vpNi#Emfy%(p5bIJpU!5c8G1te$&}uoiw!3A
zR05gG62Fn$YKY%FT>hA0<kEcw10?;Qr4pI!Zniql6HyB&Q7yO_4xS3Ol=J(-IvLh`
zhwmxAH`(p1$M-z3A7gb7*7E`EPqr`Xu`daAFSyJx?IwV2&3Zhq1UW>tHggF2ez(67
zc#eq{`2Lv}wtWbj-y=NZ{0>pVIZ@UDQ+7R`dtyF(svfT=?giAhNiTu~=i*#1OyT)r
zZC>O2{(@<WTDt*D<&i&#AM6||mG`in$35XWC3Z2v7L`XIN(?DKzZYAT0j<`n?x{jU
q$h!<Dd4}IMtjB#*-zylJ62L;gQ3kZCSB5d}Ta-CyjzdN3dfwmbtESli

literal 0
HcmV?d00001

diff --git a/linux-user/riscv/vdso-64.so b/linux-user/riscv/vdso-64.so
new file mode 100755
index 0000000000000000000000000000000000000000..792b3ea1ee7b262c27b2c02bf6d397ddb8f85cc6
GIT binary patch
literal 3840
zcmc&%Yiv|S6h600=~`NBOEJYZO)*uGl+CuOq>+Z)ZM$vJrQIwLF`8VK-EDVc_mSPZ
zO=*Z!t#1UhfQYC?6vbzKpx}%CFiK2}{M7#%(HNsK`op00oO{n%?oK!Q!yle@?l*HD
zGjq?(e0O$_KhR&MX&~Z)U*U2KKxe~zrCnKqphFid#b+(lAOhGr+pgPChzoLOf^N3E
z05TLeMje!pUPUK!BCJqs&ZhJyh*Pwr44*XK8SY3$FY5(mp22U;D8;puTiq<eR$C2%
z<V!+G<pB4qqWBAvF9~5i7R(O}3~hsTKb-m_f9Z6^r{7;|_`Yf0@MW|A3pBxUdZ3s#
zSaDQ6Pk|`E{k4#`D%>$oA9QX@+AmUKP<VM^zukmoj17!x&Lux=hAR~ROAGe+7kRut
zxy{4D&)mMicIoH;Ko@3jp7SQ-)3Vh;6?Af<s@SlW^@FUJJWQj$7JgY^w*u_I8ub%Z
z{8zGGSM&kaZ&&miSszsNvX5!{v<8H<R_ul~TV(xdzLIiU3-TwV_oW!EW>u}OftPgT
zXRZ6^jdNS}d*e+9_b!|~n_Ru>L~p8l<!48)pW7J&!x)d|(#B}aG!w~KdL$a&CA!F1
zI&!C27Ado_oait(lF3VJWGtVH8;M9b5-)V0HH}<iG#fMX*%XW=Qu&E>G^_{z+aa)N
zXxnz9)6;$<P8g-E=+D+^_=fa%{M=8~biSIf$l0NHFGE{?&v%t%Bcb&q(HdPFS`jHv
z_2}4**n${D)G3e(3eya@CPSd@*0jdzGD}D2=K>blKjhbj<vf-aEF?#4px7-KtZR)`
zW%EnR^=a+yDea!!_fAZk_hs%Mdm#Q`^r0OO-|@)yy;~m*?hEW6Jka-;{&@FH*TK$1
z-otHAtU1#9WXsW}ry7pcKV9=o)wAx|zT-X5=_fWm-~GZ(C%ax;|5E3vj+ec!cwTLL
zZSCu8-neeA_04PEYI(c)ou<=QzuWNMRcGqY*1ccz!SWBQKC1lKeUA16&36_{7Z!Pk
z8TWz89JWWN0A}1Z6;z*bw=hmwwiUSH$iBj|&AG|P*MpC2A{QA4jruFkj<4@bbY$9%
zWJktpgsC>tk?Am^^q5RUa#_+(CPreZNDLjl81xU~!o?7tb-KB5b>*BC>s=uHSFB&m
z2V{3ad4XSx{V`K=s2m0to*uoV-VLRA&xI#g_|nl0j$2vy?iA~n!Jr&$hr#9GEr%NW
zsdhH4I&I%2C3wqT>&yJ-3@qh;B|2!>kD6!N|D?|-gw$bmxcI&N>_1Nj&LOvBy%fKW
zpq}_u<;zLdtNgu>^(v1ZW4+4LbF5eS{u9=#{0)&vd#JxZ8S<o|bpnjO+lG9bH}!%M
z3=Q}C`?iJr2GZ3nz5&0n)z=g78_0V2oj3f0Mt{h+*>4Q?g}@jH4EOi~#&CcC7XMap
zbkH1=ZYicLMa0GYTEwN?Q-P`-tX$9$u>*K=yOL&jC!(3PF)p=K+KhoGx+@h<CL&e^
zeG$WE7(An?yeA&c#cjQrwKe0hY%Y;b6*Y_~cw%v5BpXh~jCd41r3D@{HerItA`eg4
zG_#4Fc@sY%|5+Nb2l~d*_l`vPLy)-NDe7@vjYitqvR!5W3wrtcV0}l?PworEt0Z)v
zpu3igFMK5U6*-~E93`I46$zaq8bZdGb0aAJ<VzxLLHeE%g~<4Fe-tF1CXxOnPVzwZ
z-|;Rd@dX}a2c3dZ)OcG9(8D%~7rqpf`>6PHI;9CWV{O4PzVNDG9ec|7GLGP_Xs5fW
zw1s~K<^9$C%LIsjXigHZ{!aL}{X=&UXT0#a;Eys8qvT)IcX7PXtMHwm%wPOv-K0H@
z70gXW+Jf@?saF(?YW|&bce>8;gl0K0^nIW^ugt%Jo#oEzjHP;ze^7j_7}W7=(JpK2
QbiILp&>VIuv98Ad4S{NxYXATM

literal 0
HcmV?d00001

diff --git a/linux-user/riscv/vdso.S b/linux-user/riscv/vdso.S
new file mode 100644
index 0000000000..70a4f710db
--- /dev/null
+++ b/linux-user/riscv/vdso.S
@@ -0,0 +1,186 @@
+/*
+ * RISC-V linux replacement vdso.
+ *
+ * Copyright 2021 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <asm/unistd.h>
+#include <asm/errno.h>
+
+#if __riscv_xlen == 32
+# define TARGET_ABI32
+#endif
+#include "vdso-asmoffset.h"
+
+	.text
+
+.macro endf name
+	.globl	\name
+	.type	\name, @function
+	.size	\name, . - \name
+.endm
+
+.macro raw_syscall nr
+	li	a7, \nr
+	ecall
+.endm
+
+.macro vdso_syscall name, nr
+\name:
+	raw_syscall \nr
+endf	\name
+.endm
+
+__vdso_gettimeofday:
+	.cfi_startproc
+#ifdef __NR_gettimeofday
+	raw_syscall __NR_gettimeofday
+	ret
+#else
+	/* No gettimeofday, fall back to clock_gettime64. */
+	beq	a1, zero, 1f
+	sw	zero, 0(a1)	/* tz->tz_minuteswest = 0 */
+	sw	zero, 4(a1)	/* tz->tz_dsttime = 0 */
+1:	addi	sp, sp, -32
+	.cfi_adjust_cfa_offset 32
+	sw	a0, 16(sp)	/* save tv */
+	mv	a0, sp
+	raw_syscall __NR_clock_gettime64
+	lw	t0, 0(sp)	/* timespec.tv_sec.low */
+	lw	t1, 4(sp)	/* timespec.tv_sec.high */
+	lw	t2, 8(sp)	/* timespec.tv_nsec.low */
+	lw	a1, 16(sp)	/* restore tv */
+	addi	sp, sp, 32
+	.cfi_adjust_cfa_offset -32
+	bne	a0, zero, 9f	/* syscall error? */
+	li	a0, -EOVERFLOW
+	bne	t1, zero, 9f	/* y2038? */
+	li	a0, 0
+	li	t3, 1000
+	divu	t2, t2, t3	/* nsec -> usec */
+	sw	t0, 0(a1)	/* tz->tv_sec */
+	sw	t2, 4(a1)	/* tz->tv_usec */
+9:	ret
+#endif
+	.cfi_endproc
+endf __vdso_gettimeofday
+
+	.cfi_startproc
+
+#ifdef __NR_clock_gettime
+vdso_syscall __vdso_clock_gettime, __NR_clock_gettime
+#else
+vdso_syscall __vdso_clock_gettime, __NR_clock_gettime64
+#endif
+
+#ifdef __NR_clock_getres
+vdso_syscall __vdso_clock_getres, __NR_clock_getres
+#else
+vdso_syscall __vdso_clock_getres, __NR_clock_getres_time64
+#endif
+
+vdso_syscall __vdso_getcpu, __NR_getcpu
+
+__vdso_flush_icache:
+	/* qemu does not need to flush the icache */
+	li	a0, 0
+	ret
+endf __vdso_flush_icache
+
+	.cfi_endproc
+
+/*
+ * Start the unwind info at least one instruction before the signal
+ * trampoline, because the unwinder will assume we are returning
+ * after a call site.
+ */
+
+	.cfi_startproc simple
+	.cfi_signal_frame
+
+#define sizeof_reg	(__riscv_xlen / 4)
+#define sizeof_freg	8
+#define B_GR	(offsetof_uc_mcontext - sizeof_rt_sigframe)
+#define B_FR	(offsetof_uc_mcontext - sizeof_rt_sigframe + offsetof_freg0)
+
+	.cfi_def_cfa	2, sizeof_rt_sigframe
+
+	/* Return address */
+	.cfi_return_column 64
+	.cfi_offset	64, B_GR + 0			/* pc */
+
+	/* Integer registers */
+	.cfi_offset	1, B_GR + 1 * sizeof_reg	/* r1 (ra) */
+	.cfi_offset	2, B_GR + 2 * sizeof_reg	/* r2 (sp) */
+	.cfi_offset	3, B_GR + 3 * sizeof_reg
+	.cfi_offset	4, B_GR + 4 * sizeof_reg
+	.cfi_offset	5, B_GR + 5 * sizeof_reg
+	.cfi_offset	6, B_GR + 6 * sizeof_reg
+	.cfi_offset	7, B_GR + 7 * sizeof_reg
+	.cfi_offset	8, B_GR + 8 * sizeof_reg
+	.cfi_offset	9, B_GR + 9 * sizeof_reg
+	.cfi_offset	10, B_GR + 10 * sizeof_reg
+	.cfi_offset	11, B_GR + 11 * sizeof_reg
+	.cfi_offset	12, B_GR + 12 * sizeof_reg
+	.cfi_offset	13, B_GR + 13 * sizeof_reg
+	.cfi_offset	14, B_GR + 14 * sizeof_reg
+	.cfi_offset	15, B_GR + 15 * sizeof_reg
+	.cfi_offset	16, B_GR + 16 * sizeof_reg
+	.cfi_offset	17, B_GR + 17 * sizeof_reg
+	.cfi_offset	18, B_GR + 18 * sizeof_reg
+	.cfi_offset	19, B_GR + 19 * sizeof_reg
+	.cfi_offset	20, B_GR + 20 * sizeof_reg
+	.cfi_offset	21, B_GR + 21 * sizeof_reg
+	.cfi_offset	22, B_GR + 22 * sizeof_reg
+	.cfi_offset	23, B_GR + 23 * sizeof_reg
+	.cfi_offset	24, B_GR + 24 * sizeof_reg
+	.cfi_offset	25, B_GR + 25 * sizeof_reg
+	.cfi_offset	26, B_GR + 26 * sizeof_reg
+	.cfi_offset	27, B_GR + 27 * sizeof_reg
+	.cfi_offset	28, B_GR + 28 * sizeof_reg
+	.cfi_offset	29, B_GR + 29 * sizeof_reg
+	.cfi_offset	30, B_GR + 30 * sizeof_reg
+	.cfi_offset	31, B_GR + 31 * sizeof_reg	/* r31 */
+
+	.cfi_offset	32, B_FR + 0			/* f0 */
+	.cfi_offset	33, B_FR + 1 * sizeof_freg	/* f1 */
+	.cfi_offset	34, B_FR + 2 * sizeof_freg
+	.cfi_offset	35, B_FR + 3 * sizeof_freg
+	.cfi_offset	36, B_FR + 4 * sizeof_freg
+	.cfi_offset	37, B_FR + 5 * sizeof_freg
+	.cfi_offset	38, B_FR + 6 * sizeof_freg
+	.cfi_offset	39, B_FR + 7 * sizeof_freg
+	.cfi_offset	40, B_FR + 8 * sizeof_freg
+	.cfi_offset	41, B_FR + 9 * sizeof_freg
+	.cfi_offset	42, B_FR + 10 * sizeof_freg
+	.cfi_offset	43, B_FR + 11 * sizeof_freg
+	.cfi_offset	44, B_FR + 12 * sizeof_freg
+	.cfi_offset	45, B_FR + 13 * sizeof_freg
+	.cfi_offset	46, B_FR + 14 * sizeof_freg
+	.cfi_offset	47, B_FR + 15 * sizeof_freg
+	.cfi_offset	48, B_FR + 16 * sizeof_freg
+	.cfi_offset	49, B_FR + 17 * sizeof_freg
+	.cfi_offset	50, B_FR + 18 * sizeof_freg
+	.cfi_offset	51, B_FR + 19 * sizeof_freg
+	.cfi_offset	52, B_FR + 20 * sizeof_freg
+	.cfi_offset	53, B_FR + 21 * sizeof_freg
+	.cfi_offset	54, B_FR + 22 * sizeof_freg
+	.cfi_offset	55, B_FR + 23 * sizeof_freg
+	.cfi_offset	56, B_FR + 24 * sizeof_freg
+	.cfi_offset	57, B_FR + 25 * sizeof_freg
+	.cfi_offset	58, B_FR + 26 * sizeof_freg
+	.cfi_offset	59, B_FR + 27 * sizeof_freg
+	.cfi_offset	60, B_FR + 28 * sizeof_freg
+	.cfi_offset	61, B_FR + 29 * sizeof_freg
+	.cfi_offset	62, B_FR + 30 * sizeof_freg
+	.cfi_offset	63, B_FR + 31 * sizeof_freg	/* f31 */
+
+	nop
+
+__vdso_rt_sigreturn:
+	raw_syscall __NR_rt_sigreturn
+endf __vdso_rt_sigreturn
+
+	.cfi_endproc
diff --git a/linux-user/riscv/vdso.ld b/linux-user/riscv/vdso.ld
new file mode 100644
index 0000000000..aabe2b0ab3
--- /dev/null
+++ b/linux-user/riscv/vdso.ld
@@ -0,0 +1,74 @@
+/*
+ * Linker script for linux riscv replacement vdso.
+ *
+ * Copyright 2021 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+VERSION {
+        LINUX_4.15 {
+        global:
+                __vdso_rt_sigreturn;
+                __vdso_gettimeofday;
+                __vdso_clock_gettime;
+                __vdso_clock_getres;
+                __vdso_getcpu;
+                __vdso_flush_icache;
+
+        local: *;
+        };
+}
+
+
+PHDRS {
+        phdr            PT_PHDR         FLAGS(4) PHDRS;
+        load            PT_LOAD         FLAGS(7) FILEHDR PHDRS;
+        dynamic         PT_DYNAMIC      FLAGS(4);
+        eh_frame_hdr    PT_GNU_EH_FRAME;
+        note            PT_NOTE         FLAGS(4);
+}
+
+SECTIONS {
+        /*
+         * We can't prelink to any address without knowing something about
+         * the virtual memory space of the host, since that leaks over into
+         * the available memory space of the guest.
+         */
+        . = SIZEOF_HEADERS;
+
+        /*
+         * The following, including the FILEHDRS and PHDRS, are modified
+         * when we relocate the binary.  We want them to be initially
+         * writable for the relocation; we'll force them read-only after.
+         */
+        .note           : { *(.note*) }         :load :note
+        .dynamic        : { *(.dynamic) }       :load :dynamic
+        .dynsym         : { *(.dynsym) }        :load
+        /*
+         * There ought not be any real read-write data.
+         * But since we manipulated the segment layout,
+         * we have to put these sections somewhere.
+         */
+        .data           : {
+                *(.data*)
+                *(.sdata*)
+                *(.got.plt) *(.got)
+                *(.gnu.linkonce.d.*)
+                *(.bss*)
+                *(.dynbss*)
+                *(.gnu.linkonce.b.*)
+        }
+
+        .rodata         : { *(.rodata*) }
+        .hash           : { *(.hash) }
+        .gnu.hash       : { *(.gnu.hash) }
+        .dynstr         : { *(.dynstr) }
+        .gnu.version    : { *(.gnu.version) }
+        .gnu.version_d  : { *(.gnu.version_d) }
+        .gnu.version_r  : { *(.gnu.version_r) }
+        .eh_frame_hdr   : { *(.eh_frame_hdr) }  :load :eh_frame_hdr
+        .eh_frame       : { *(.eh_frame) }      :load
+
+        .text           : { *(.text*) }         :load   =0xd503201f
+}
-- 
2.34.1


