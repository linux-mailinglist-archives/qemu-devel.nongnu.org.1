Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FC27DC1BC
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:19:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZe5-00016F-Qp; Mon, 30 Oct 2023 17:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdx-000112-EB
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:53 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdn-0006VE-Ht
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:52 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cc3542e328so13254865ad.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 14:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698700659; x=1699305459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+bR46JSOqwlNXNPelKKL+3XJAFRZZecNI0O7KRhIOs=;
 b=caW6BkjBR80YF25qqvs0IMBuYZOL1othElj2fDEVvab1ivud9o3p9mhzcZ512oluzV
 AhgXp9V/uLqrcBw1KzSaAx9YEoNY38IFAj3M+oXAp0WMce26AP/374xB6GLlvlC4B/cn
 HYaHtlqYXo/ZPY4c2EA06KH/kIS8R3bhWks4L0moeygg+kcUcxgGpLqB9rjjNvhTs+2p
 j1+tR/2WW0cgLmgqhRIn5IUsT1OqVE6e/vHPKGE0soKDKDoht3Yc1c4ZbS9c9S/FoHEe
 aN8rdZ/F58oC+QvfbfccdwjsoudDK6D9Kx4g18qco0FzyaBHhhY55g+8uBk81OclaDmW
 fnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698700659; x=1699305459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G+bR46JSOqwlNXNPelKKL+3XJAFRZZecNI0O7KRhIOs=;
 b=mQkdm6/Z/HULpbv9m8evdn6CmXSs7/xqGwR8zetYAfqfaEeKhx/dClyWIH0cWk7tzK
 XC7Cp6J7aFEVSslNA5A6iU+8IP1Rv0Q2MtIL0BS4OR9Q/mxT0N/n1C76gMDEJkIanRD7
 EF8ZGheNIuwhXKwSDikMeJ14W7JK1+qnyjzJNuJKy6BUT736qgGx3asbWxNzo6tT/A/7
 VPQJMZ5kteYCFCRqakk8btvTf1Zzxhodz/u80w/43Cz1ROycWvkIUma2hX47xrXci99X
 EoxDNHDZ9KqGXGt5RBDUyKHrF7sV8ebHgPA3c2wp3Hl6tMHOnEOT818aQne/tPvVV+E7
 /Y9Q==
X-Gm-Message-State: AOJu0YzuxP1J21H0/dsnYkEPGZCGJrsFcNVI4z9wu2ZqAEwkhK8sAy3/
 BEZpp/byVjxjac/GjhLG7RfY9nf4VnHic11pEXU=
X-Google-Smtp-Source: AGHT+IE1vpIe9iaxfPX9M3KExsPl8aapj2n5RlHfQA3ZJM3JCFwNNX2edw64weGZmAvzvWa9xd7SzQ==
X-Received: by 2002:a17:902:d484:b0:1cc:361b:7b28 with SMTP id
 c4-20020a170902d48400b001cc361b7b28mr4701218plg.64.1698700659559; 
 Mon, 30 Oct 2023 14:17:39 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf2-20020a170903268200b001cc32261bdfsm4670350plb.38.2023.10.30.14.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:17:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/21] linux-user/aarch64: Add vdso
Date: Mon, 30 Oct 2023 14:17:18 -0700
Message-Id: <20231030211727.165090-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030211727.165090-1-richard.henderson@linaro.org>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c             |   6 +++
 linux-user/aarch64/Makefile.vdso |  15 +++++++
 linux-user/aarch64/meson.build   |  11 +++++
 linux-user/aarch64/vdso-be.so    | Bin 0 -> 3216 bytes
 linux-user/aarch64/vdso-le.so    | Bin 0 -> 3216 bytes
 linux-user/aarch64/vdso.S        |  71 ++++++++++++++++++++++++++++++
 linux-user/aarch64/vdso.ld       |  72 +++++++++++++++++++++++++++++++
 linux-user/meson.build           |   1 +
 8 files changed, 176 insertions(+)
 create mode 100644 linux-user/aarch64/Makefile.vdso
 create mode 100644 linux-user/aarch64/meson.build
 create mode 100755 linux-user/aarch64/vdso-be.so
 create mode 100755 linux-user/aarch64/vdso-le.so
 create mode 100644 linux-user/aarch64/vdso.S
 create mode 100644 linux-user/aarch64/vdso.ld

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 62a33481e1..0a3a57018b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -944,6 +944,12 @@ const char *elf_hwcap2_str(uint32_t bit)
 
 #undef GET_FEATURE_ID
 
+#if TARGET_BIG_ENDIAN
+# define VDSO_HEADER  "vdso-be.c.inc"
+#else
+# define VDSO_HEADER  "vdso-le.c.inc"
+#endif
+
 #endif /* not TARGET_AARCH64 */
 #endif /* TARGET_ARM */
 
diff --git a/linux-user/aarch64/Makefile.vdso b/linux-user/aarch64/Makefile.vdso
new file mode 100644
index 0000000000..599958116b
--- /dev/null
+++ b/linux-user/aarch64/Makefile.vdso
@@ -0,0 +1,15 @@
+include $(BUILD_DIR)/tests/tcg/aarch64-linux-user/config-target.mak
+
+SUBDIR = $(SRC_PATH)/linux-user/aarch64
+VPATH += $(SUBDIR)
+
+all: $(SUBDIR)/vdso-be.so $(SUBDIR)/vdso-le.so
+
+LDFLAGS = -nostdlib -shared -Wl,-h,linux-vdso.so.1 -Wl,--build-id=sha1 \
+	  -Wl,--hash-style=both -Wl,-T,$(SUBDIR)/vdso.ld
+
+$(SUBDIR)/vdso-be.so: vdso.S vdso.ld
+	$(CC) -o $@ $(LDFLAGS) -mbig-endian $<
+
+$(SUBDIR)/vdso-le.so: vdso.S vdso.ld
+	$(CC) -o $@ $(LDFLAGS) -mlittle-endian $<
diff --git a/linux-user/aarch64/meson.build b/linux-user/aarch64/meson.build
new file mode 100644
index 0000000000..248c578d15
--- /dev/null
+++ b/linux-user/aarch64/meson.build
@@ -0,0 +1,11 @@
+# TARGET_BIG_ENDIAN is defined to 'n' for little-endian; which means it
+# is always true as far as source_set.apply() is concerned.  Always build
+# both header files and include the right one via #if.
+
+vdso_be_inc = gen_vdso.process('vdso-be.so',
+                               extra_args: ['-r', '__kernel_rt_sigreturn'])
+
+vdso_le_inc = gen_vdso.process('vdso-le.so',
+                               extra_args: ['-r', '__kernel_rt_sigreturn'])
+
+linux_user_ss.add(when: 'TARGET_AARCH64', if_true: [vdso_be_inc, vdso_le_inc])
diff --git a/linux-user/aarch64/vdso-be.so b/linux-user/aarch64/vdso-be.so
new file mode 100755
index 0000000000000000000000000000000000000000..6084f3d1a701316004894fcdd739c4e1e0463b68
GIT binary patch
literal 3216
zcmc&$O>A355T57v+64N8Q&ABq6>X&mRj7RmMS`Gmu!EhX$W24qs-c&yv0q~6$41XD
z#X$mc;KBh>)D!9f7jbE&o<UsN14xy6s{mC(f)i3Dq>3KO1&W#3omsDqjgUAn$-Zyr
zo0*+`yF2UmUcNA$N_k+#hcB@25ZaP4_Th`HO~N+FKpLJveLJ?m*pV~RgWjm21z{L<
z$}wd4LC@e<V_`J2N+HMjyq2;54GrCSjp1_g^L!^RXc~uJgeN&rkn%{wuD59Hy$Csu
z6QuW}xHPtHGjnI)CU#JW^L5YkDUVO~&u;(z;i>e4`!_DFeDmp#mw&i^<zSxu2zGP-
z93zc`;?p}pz5VAyLe#f3U`~Vnm#otsp`=<G03K(2i*W~|-luxI{fE(m3?b@|j1IK+
zq|3fcF#mr*xCdaTNgUke3DA1y9R42jv>z)Y(0;(W3!dXI>qX-{<?y#SfcSq9uZ2e1
zUtVwB=e^KjQdiCy);`2j+up*`@G|ff>*VL(Jr;fPar2{J(&x^9ec+i^?x(BSN1)Vd
z6xX6PwHzf$bv>#tm5ZAlwzO6+t%|J=9Y>808z-t!U5=w<Bd)<(wYJeba-rO)hxq>-
z6pqiGSyV^E7sBUX!r9;<vVWv`=5N>i8&^=H^Slq6Ij8hSDe#8W?GM<704wzH#{6Rl
z<WF81Y=^Ot=r#7<UVxzav^TbMzi@OmX}>3kP~-l0hxTsW!QgLi`s#bF@9x%T9lbJQ
zY!o|4aN}q$C{o`>LtdYI<XeWZJeo*sU1<$TsZTvuP2vN2smpoc2$ARWV(V9%ksmUC
zwvL6T^NbSoj{g|*8H47D<8ZypeP?;D``}`aztok~1DU;`fBleezjdSEhJND^CwV`|
zzLf#v@9}KjuJs?oz<%!)cKrQWJ2>781M2@Zr_SAbWZB{G@i?^Z?>M}yPa6444u6aN
z(@-i+W?!6HJsZ|xybR+_P`TIVvL}weg5`%7zsk?5>4ofxyqe7|fSM_soXQr|$?54+
z`P1rjcB+t9-4$r--d6bFQntST=8k}{vALcU-#|=agB9u3>PZA)d9zkrua<NNeG!XE
z5yIu#Mp!8}Duz#D!(52sMzvn+QdAkjsG^qQ;(DYiW%Lvc!X#=YylDRs=v;8!*t%Ub
zW7@jT_2i&^6*-6<_x?sz&YeZ_l^oQUcsd8qVw2xfzBf`W<WK~G>W$*LZfyK0az`B=
zOP9o-=tekTbo-S2gfC;0-yF_wz7ueqd5$=Y$YX0p;sews@%Q~V_LKN6qx+07iF&_y
za+`8&63=yF?=kuAAb%2B2kO6y`P<Y%;dr^{1oge*=4U_cf428~1@Fm>9?hbjKdryS
z$@`Pr5;mES<ZqGz$6>VJiH5fKy;kWM_r}wHqu6`)kkRea&Hpa463^!_;Pn&K^S8m+
zp?wpfSa~nu80C99^(GSZO}Up1l7AF+`VDc{mR$&j&a-ljQ9$NP`UtiG@xy#y!}}7*
HXyg9^8}}&g

literal 0
HcmV?d00001

diff --git a/linux-user/aarch64/vdso-le.so b/linux-user/aarch64/vdso-le.so
new file mode 100755
index 0000000000000000000000000000000000000000..947d534ec1899740edbd6921da6bc6e70e2ecd09
GIT binary patch
literal 3216
zcmcguL2MgU5FKYzk|v=|N~=Z+qD6{Og<utmRJD|Y9c(v2Zd%etExr7@_Qp0%>~_6L
z9VDO!E}RJB#LXZsa7BWO3q5c^;)VcKz2t<11S;tPP82h<JI`MKYy}b$WB;B1-^~2^
z`~S@Be=AqW52R8Aa_9@{jfm1J*c^t2V8>|}KgVe=J;LxHx3r3FKB<#|V;X^n)Fz2-
z%cM-;q^lZWOhj#+*XG^Ds~rB${uGqOuBG$Zd_T*Cz*Q~uCH;#!pUtzO6%jc6iOo2-
zUEEGBEQ!`_!5rx^Nnd=)Smd95v^A8^_@B?;{q2QA>mys0rC%Ro5$%x&)1`=ocG5ko
z6aD^Iry=8;Iu?IIw{$G$Bh;3SV;YGV-B3QNd{X(JooK$aERgAej@6vDbv&c;NbCQ9
zy6kcvjnN%lhwQabmYd)|D~|JcjqwS(-w~ZS$+3$5Eo+{GihpC_aoczwaVXo4J(oVt
zLv%HS2r(>}=m;)N?7pOQiiV@`7Cn)F;GMkl%e$@jzP@~EJllTi@Po`JTV%{t&#!wc
zrs4%bZPjZmmx~)cw6xMFU4<+G_Pu5g^#jwaReUd4^Xs%ytFN`5T`xBqF8`mS!u-P0
zMRU|W=01Od7sIQ^Pev*IefZVAM<t#g=Z097cN$>%JKvfi<dvL*P-@CKDVXS_xjn;8
z2<Mo3eUS!RPo$>C4uzP+=NPvcQDQRF&JRZp-29I1zrXF6AH(sU{_$LFT%Cwyk#+LZ
z;ng6&;~EaXMOzkXk;A9cMq<Qd4rl3%9GpcCM+5RUE^_$fk-z=;P&beJ@nK5JKZkY`
z^0r@pq+9p;@lo2;`0mGh`2bvAe=s3`<V@rg?S0!D;ydSw^hfFA1iwl1?+a(Y-?8_9
zDx81kdr4hL@jB<M{m(L<l>e_Vo>WIFiraPM4aMzx@xJ0a>P4w^{aUtsrS3Lpx=hn8
zGTB!bGN<QX;`HOfZ*p@cznD3lGjrKRGN%e>W-|qICZ9i-J8#ZsW(zsfpMl-H?`HVJ
zQ@N}AZ)ya&&5hNdc!hc3N4$z&y%BiimN)9f)mka+urBjrP$aifUvsO)W;MbCKSI_$
zzgcV4`v#^=u2(h7esR?^)iP^hL~h`<0^Y;_N)i`xuRvNNF2N-Z;)L%5uqU}Abr|7;
zxC7_l3JG@?*rRSe%~JWM!awQ*_-14tu2H6fJ-)w38511-QAfZJvn)=q2Y-=;^38#N
z)EjWrS<DYRq~me6{e!>put!}27rBsaAE89EDuX@lA>g=oKwq~LLwcEeotS^rIq;}{
z^!&pQ_yx9?I}66Bhu~O0Vg&Dx1uSz%)&%>9-4mgYeZyE{IBt*n3VsBN%5DE|sy*%y
zs59VLKc=z$$9+Rb__iuu(-)I_<pFN+KPgH~ySd?PLqH#wHQ+yugWR{zZ-TKT`w?~Y
I_CMJF4X7R_od5s;

literal 0
HcmV?d00001

diff --git a/linux-user/aarch64/vdso.S b/linux-user/aarch64/vdso.S
new file mode 100644
index 0000000000..34d3a9ebd2
--- /dev/null
+++ b/linux-user/aarch64/vdso.S
@@ -0,0 +1,71 @@
+/*
+ * aarch64 linux replacement vdso.
+ *
+ * Copyright 2023 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <asm/unistd.h>
+
+/* ??? These are in include/elf.h, which is not ready for inclusion in asm. */
+#define NT_GNU_PROPERTY_TYPE_0  5
+#define GNU_PROPERTY_AARCH64_FEATURE_1_AND      0xc0000000
+#define GNU_PROPERTY_AARCH64_FEATURE_1_BTI      (1U << 0)
+#define GNU_PROPERTY_AARCH64_FEATURE_1_PAC      (1U << 1)
+
+#define GNU_PROPERTY_AARCH64_FEATURE_1_DEFAULT \
+    (GNU_PROPERTY_AARCH64_FEATURE_1_BTI | GNU_PROPERTY_AARCH64_FEATURE_1_PAC)
+
+	.section .note.gnu.property
+	.align	3
+	.long	2f - 1f
+	.long	6f - 3f
+	.long	NT_GNU_PROPERTY_TYPE_0
+1:	.string	"GNU"
+2:	.align	3
+3:	.long	GNU_PROPERTY_AARCH64_FEATURE_1_AND
+	.long	5f - 4f
+4:	.long	GNU_PROPERTY_AARCH64_FEATURE_1_DEFAULT
+5:	.align	3
+6:
+
+	.text
+
+.macro endf name
+	.globl	\name
+	.type	\name, @function
+	.size	\name, . - \name
+.endm
+
+.macro vdso_syscall name, nr
+\name:
+	bti	c
+	mov	x8, #\nr
+	svc	#0
+	ret
+endf	\name
+.endm
+
+	.cfi_startproc
+
+vdso_syscall __kernel_gettimeofday, __NR_gettimeofday
+vdso_syscall __kernel_clock_gettime, __NR_clock_gettime
+vdso_syscall __kernel_clock_getres, __NR_clock_getres
+
+	.cfi_endproc
+
+
+/*
+ * TODO: The kernel makes a big deal of turning off the .cfi directives,
+ * because they cause libgcc to crash, but that's because they're wrong.
+ *
+ * For now, elide the unwind info for __kernel_rt_sigreturn and rely on
+ * the libgcc fallback routine as we have always done.  This requires
+ * that the code sequence used be exact.
+ */
+__kernel_rt_sigreturn:
+	/* No BTI C insn here -- we arrive via RET. */
+	mov	x8, #__NR_rt_sigreturn
+	svc	#0
+endf	__kernel_rt_sigreturn
diff --git a/linux-user/aarch64/vdso.ld b/linux-user/aarch64/vdso.ld
new file mode 100644
index 0000000000..4c12f33352
--- /dev/null
+++ b/linux-user/aarch64/vdso.ld
@@ -0,0 +1,72 @@
+/*
+ * Linker script for linux aarch64 replacement vdso.
+ *
+ * Copyright 2021 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+VERSION {
+        LINUX_2.6.39 {
+        global:
+                __kernel_rt_sigreturn;
+                __kernel_gettimeofday;
+                __kernel_clock_gettime;
+                __kernel_clock_getres;
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
diff --git a/linux-user/meson.build b/linux-user/meson.build
index e4cb70ed2d..dd24389052 100644
--- a/linux-user/meson.build
+++ b/linux-user/meson.build
@@ -35,6 +35,7 @@ gen_vdso_exe = executable('gen-vdso', 'gen-vdso.c',
 gen_vdso = generator(gen_vdso_exe, output: '@BASENAME@.c.inc',
                      arguments: ['-o', '@OUTPUT@', '@EXTRA_ARGS@', '@INPUT@'])
 
+subdir('aarch64')
 subdir('alpha')
 subdir('arm')
 subdir('hppa')
-- 
2.34.1


