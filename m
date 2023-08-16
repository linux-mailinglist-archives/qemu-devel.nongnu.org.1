Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B584577E82A
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:04:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWKs9-0002Qe-C2; Wed, 16 Aug 2023 14:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKs5-0002Oz-Qj
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:53 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKs2-0001LT-If
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:53 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bbff6b2679so44768385ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 11:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692209029; x=1692813829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M478cD9e19CcONyDKO+nZ894P/ANoM0KduR/gS2DCkU=;
 b=caI9R65HoEX81wObwUFzgmuxDK8MftLo5Hf74fWrmn1VSsr2qk3To45/CzPE2ElKZY
 46HOBRVCl53vOdGbBlcb3CUxVio2//y+RSO5mTeJ11wneKiYVTafQN4Jiua0bnP8O+lT
 9R4PEq5jBhrpIAuNtz6mbc/Nk5sNu3XFFRSQV6R/OC60oU0fHvlQGsWx3LLKTGZXy8fe
 q6rdVCsvXIv6bswjhrjQEFdNRi8ohlRAJeVbHm7wEFw8yQuJDdWGGEP9h7pzsSUXy4t0
 knW8bFeExjyE6+w9o8rUSxSVrHMvsUrTM96sA5whMRhP4J8o/icCDMcszZQF9FD6lrVi
 gxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692209029; x=1692813829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M478cD9e19CcONyDKO+nZ894P/ANoM0KduR/gS2DCkU=;
 b=hTbrhxQ2y/PMKS1lnAxrozNRsXKcsSF+cquZI6GzNuHEMnSEJAUoiopT+TivIQXy51
 IBCmSAc5fnIsedO+5yoXn8pNitJ//YW+VK6ad330FJPezrLYdKepJuVA6/zepUs82cRX
 L/NCld36q2ocXh6YDlJ8rCBNIQMTrg0bGpBTMW8rOB4YXSw2D87jenZsPK9C6cLS9mph
 5R166Hj79brLZ8gPpnHOVpICEFdO+OGD8LF6I3rjejQLZ64p3xoBzh864YXpa7GrV8Gl
 YC5IqPyv9iGxg6aiWBW+kVnSc96rxUZpVbF0KdkyK9UvnUnnZVXOOu1NaKfX/YwTVLI+
 zNzg==
X-Gm-Message-State: AOJu0YyMrZGt2gfjoaGJLfeMddPeWcT8qaFumMffF5PePbA6A2MG4/5K
 V+HcyGW6EihsQiZq5nyEGZjxYoHHwEu4MlcgW58=
X-Google-Smtp-Source: AGHT+IFM72BOXV/WfkzC6/GV4PXPrcrEqz5xXMc3CdDtMgVvQzhfLOMGL6GqezZfcznLi+serB9sSA==
X-Received: by 2002:a17:903:2584:b0:1bd:d162:5dc6 with SMTP id
 jb4-20020a170903258400b001bdd1625dc6mr2072140plb.14.1692209028995; 
 Wed, 16 Aug 2023 11:03:48 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a170902868e00b001bc2831e1a9sm13446584plo.90.2023.08.16.11.03.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 11:03:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/18] linux-user/aarch64: Add vdso
Date: Wed, 16 Aug 2023 11:03:31 -0700
Message-Id: <20230816180338.572576-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816180338.572576-1-richard.henderson@linaro.org>
References: <20230816180338.572576-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c             |   4 ++
 linux-user/aarch64/Makefile.vdso |  12 +++++
 linux-user/aarch64/meson.build   |  12 +++++
 linux-user/aarch64/vdso-be.so    | Bin 0 -> 3216 bytes
 linux-user/aarch64/vdso-le.so    | Bin 0 -> 3216 bytes
 linux-user/aarch64/vdso.S        |  73 +++++++++++++++++++++++++++++++
 linux-user/aarch64/vdso.ld       |  72 ++++++++++++++++++++++++++++++
 linux-user/meson.build           |   1 +
 8 files changed, 174 insertions(+)
 create mode 100644 linux-user/aarch64/Makefile.vdso
 create mode 100644 linux-user/aarch64/meson.build
 create mode 100755 linux-user/aarch64/vdso-be.so
 create mode 100755 linux-user/aarch64/vdso-le.so
 create mode 100644 linux-user/aarch64/vdso.S
 create mode 100644 linux-user/aarch64/vdso.ld

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e8a2375ba8..98cb1ff053 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -588,10 +588,14 @@ static const char *get_elf_platform(void)
 #define ELF_CLASS       ELFCLASS64
 #if TARGET_BIG_ENDIAN
 # define ELF_PLATFORM    "aarch64_be"
+# include "vdso-be.c.inc"
 #else
 # define ELF_PLATFORM    "aarch64"
+# include "vdso-le.c.inc"
 #endif
 
+#define vdso_image_info()    &vdso_image_info
+
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
 {
diff --git a/linux-user/aarch64/Makefile.vdso b/linux-user/aarch64/Makefile.vdso
new file mode 100644
index 0000000000..53c19e1ce9
--- /dev/null
+++ b/linux-user/aarch64/Makefile.vdso
@@ -0,0 +1,12 @@
+CROSS_CC ?= aarch64-linux-gnu-gcc
+LDFLAGS := -nostdlib -shared -Wl,-T,vdso.ld \
+	   -Wl,-h,linux-vdso.so.1 -Wl,--hash-style=both -Wl,--build-id=sha1 \
+	   -Wl,-z,max-page-size=4096
+
+all: vdso-le.so vdso-be.so
+
+vdso-le.so: vdso.S vdso.ld Makefile.vdso
+	$(CROSS_CC)  $(LDFLAGS) -mlittle-endian vdso.S -o $@
+
+vdso-be.so: vdso.S vdso.ld Makefile.vdso
+	$(CROSS_CC)  $(LDFLAGS) -mbig-endian vdso.S -o $@
diff --git a/linux-user/aarch64/meson.build b/linux-user/aarch64/meson.build
new file mode 100644
index 0000000000..35e50c9b2c
--- /dev/null
+++ b/linux-user/aarch64/meson.build
@@ -0,0 +1,12 @@
+# ??? There does not seem to be a way to do
+#   when: ['TARGET_AARCH64', !'TARGET_WORDS_BIGENDIAN']
+# so we'd need to add TARGET_WORDS_LITTLEENDIAN.
+# In the meantime, build both files for aarch64 and aarch64_be,
+# only one of which will be included.
+
+gen = [
+  gen_vdso.process('vdso-be.so', extra_args: ['-r', '__kernel_rt_sigreturn']),
+  gen_vdso.process('vdso-le.so', extra_args: ['-r', '__kernel_rt_sigreturn'])
+]
+
+linux_user_ss.add(when: 'TARGET_AARCH64', if_true: gen)
diff --git a/linux-user/aarch64/vdso-be.so b/linux-user/aarch64/vdso-be.so
new file mode 100755
index 0000000000000000000000000000000000000000..311f192d88149f744ee05c2492e8e8de6c5b5ec4
GIT binary patch
literal 3216
zcmc&$L2nyH6rS~N;}lA9Dk>rcL6IU<p=K3=1VQb=33i$yHw~esp_i$#H@4HnM)syS
zNI(u;I8np_aY07n0)GI+g&sgE;#L9b1#v>EgoN5dk&tN3_h#N3uPqxPao{Dh-+bS^
zH#0jkZ@h2k3rne#r=0of3)B;WY0295@hi;c)jpL~8TBCe7)oH<p;;S1Z_>(wY8;%#
zNLzi>Gq`121T#caC_J9mApu==4D`^_-fN7P<6l=Ha$L~14uhy3;y^+2mx8LdZrcY@
z<v31|-jCvF!uw9HoKsg(fsy8$nyu3~KD9rap8Ixl|GkfAw`OKe-2QXyyAOZfWj}(0
zT))6b{lI*BC)McQyF&=RX8>bb^uJ_Idjv~$3@CLU<Liv~Gn##Bbi0399%Ko@?^<rw
zp7<@xgIU)94+sw_b%5t_gC{`iolEF9S*QKjoKW4{%#+|H{AInUpNA9rH4Y&CAI$5Z
zk@lC@+thh4Oqk?V;tU%f(y5GfkQ!cAeZ`#o{2RxkkKS*;_gm(|#cz&0(aHVt*}`3=
z^`)p;kG6CrisRaL)YvE&cYA7St5LcnZA0W{)at3tShs4GW)$x<>uRf3-)YZWF1H#X
z{-08XQ!D4z^<4N&`1Es_4dtKw5%cWd1HXU$2^gK{M^NlJr8i0`FRj0Sm)ihplOEob
ze;h#m<dsD^hC*i6*n4A51?@+@sRNIRMrV`udzJ(}?f-c6@ZNO<|8UjUKN)_opD!nP
zb;7n$>?p&=(Oh7X-<CnAeSn$$wN*T!<Dbmsm0=JiKh0c?hzE4Z%T>_`q4Rlh`D>b?
zr>&pMW6|k6!}{|N{`*<aTC`8-obPhqIi2%9xH8}`c_sNk&0a7(f5>;(y3udLuzpCB
zaX&@f*@*rRd2Zak^`AoEu=fgk{{FJ-9QVSA{C_c#=gE7dlF)B*KeX;|CUjY!4D=5Y
z`Ze~?s8T6cd3k=d8aC8)SxvW<&b_j-aQf8qNIzWsI=`%!))r3Z^>S`a>63*siwgyP
zW@+iA{8@c=VX=_c{Tb-;-evgcRCd1q=8jNdYj-;?z6y++7OPULH{wWz<=uL5yH+w4
z_yUV@QH7QIPFO9rs#cGiR=FHCTeU{LkLa=rqpIF$7Pli^EyGio3gf69^P>GnpmV`_
z<MMXh_UZCEH!ue6tJveHB=2ufId=}pSH_^a#M3!=5=DMb`QAu%puq$c<r~Fw-njTl
zXmbf2sY~Y1_M<vtxqHg^geOqsH;2c!-wEhvl_QP;xo@LLd;m6&-}gV*PvZA1_ZihZ
z_^^0#TTHY`Jm-nK$K<<%{K;e;sQv=R?@|TE@p8`zntLTVKKmK}^Ml_jxF@rwH-~2a
zwEhw&?@w+UC^8=zzfBG3htYi}TG`$AhSD(}jHmsExqJ4g<?fjr|1GEz&*w1U^%FGn
zcfqL8zKKz+yq9Q<@*SOe4FY{r9_9uae-fO2Ly~LDE(Ga|Og?86kogjyKp7D~&iA!?
JM*<mL{NMe#CGr3O

literal 0
HcmV?d00001

diff --git a/linux-user/aarch64/vdso-le.so b/linux-user/aarch64/vdso-le.so
new file mode 100755
index 0000000000000000000000000000000000000000..797ab5d9371bb66415f674a9013aae823b92668c
GIT binary patch
literal 3216
zcmcgu&1+Ow6hD&}o0z1=NX0;;wU8Dm^%0d8i(Sm5GclG)w5ej6&2^l4$xKaV<jsqn
zlzzBy<DxXBt8U6D-L(Her4;JIMZrxGTigjkp-?DsQ9;m7&w20sX5QR9u^{v$_nmux
z=j*<E&pGox&E=<hQYivC^gVS}L}?YQ_d`RlL$rmT+i94dVYrt^TE#XWRcGLEBXFPE
zB(V)~$^_2ALh9kCh??rx=Iza^9Py6-9+bqcp?+=tT<Dz$T-Cx@GM`s}HqWXZIO2(o
zY<UZhBeN$(>zZJW%$Q^@v1Bds$%~hE%`bfY((WH;K6-HF?wRYK{qh=%Xq!Bk79tkf
z$@I87`um?&P1YB5E%Ah|>RRqcs3`}>G!QZRK>48ZQRNR?k-xNTkm-@G)tokTJ)!bQ
z>;Hec9C8N@(QVy_rUzve|3h)y$NP+r(7l$uQ@K|0bJg;*OYxsA+_uLWc__z@GnYB;
zL-aI-2std6=m;)D?0%qhiu$AU7Cn)F<sH8L=jV+tuAg4mo^8Io=TYX{J7mmR&#!vR
zX2}bJ%8FN8EEU!|XmPn#JPTO@?0fYN>IbG?S@OML)vwZWrMlYKcfM4wx%|JM@<(S+
z&YJ`7>+Zofcr(0v{K+b%f0uvy>siU?-8_)1@=iT0zjVX&p|0c}gi>S9VZlTv&Er)b
zLb%7&hjY~1cs?~Y^g@V9eh%@N5G5uv?)<uU=Y^YWf9slKehb&zy4TaOb$KL`Mb^nr
zhj)Yej%zsl7ERfxMGoIi6NM3zIb5X^a&Z<poDHbkxX9s~NBwr=eeF8##``I${v6s$
zsM~J+fp*{P#s_I#^Sc}G)B|vN{oaK7kvoxFw9jog#5eni^atsigt$rmcZA;Wwe0gB
z3;l0?FX;;@-siM+{#nM8>i-?allsV#;&vbTSaG{we5v@Reo-u*I#;RBF1s}vFVT2|
zO!mFm%*@fZxcs>Bo7}XSn#;`O%yf2+%#r-D$xPlHo0@tzcfy>=Oy+Z@y8_#F->&e-
zmvUS8zw`)l>uW1P;SBS@k9ZlgYAx`{Ev;1xE0tn6VO{2hpg`_Yb=55w>g5Oz{0KSk
z`SnVz+O;qxa=o%y^b0GVDVJCiD{=#`5%3v4ElFO;cLmB4c?m9g5GVXT0DF-q(ua{g
z$UAUOu8{EU0(<nWS6C{)sfdsM0KOiXhkF!Pu*dK30mcMJeDo3UJuHh8?7`n;q5S3`
zKKczf`Yimz4&``=ZSV7MJnYezz(p=(+eawTq{?8A?+|c&cR*i{6H9uVXRTO#^f~aT
ze{|v_4)`gymv0uV(GS6~f8+?>9~)TYiR=mXkNZx9KF$qm$>F#?`YZTeC@Qz(f1>vI
zhCrVI$Nu5QjvtQ=9pM|QcurqTzAJa~K>SfrV%o|BcN+rwIIRi)T^!`OeSag2CD{*X
Jpo>qi{}(kpCh`CP

literal 0
HcmV?d00001

diff --git a/linux-user/aarch64/vdso.S b/linux-user/aarch64/vdso.S
new file mode 100644
index 0000000000..e436e60fd9
--- /dev/null
+++ b/linux-user/aarch64/vdso.S
@@ -0,0 +1,73 @@
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
+
+/* TODO: Add elf note for LINUX_VERSION_CODE */
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


