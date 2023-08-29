Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 160EE78D084
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:26:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mn-0000e3-4a; Tue, 29 Aug 2023 19:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nR-0002Qz-CN
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:51 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nL-0004A0-TB
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:47 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68a410316a2so3613913b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 15:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693346562; x=1693951362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pLMtweIj9VXeYhHPPyPr7xGLS4OZL75mnN+1BxZJcQ0=;
 b=CbjjBw9g3IllOGxkZYsxUjtZMrFfuQxgioLEgwjzD1Rbk65uyviyMWkBzx3ndqKcUt
 gwRXcmMNGECOKDuTAWza/BSITD12KurxQOReExCr6RsQ81ix4xUGCpKvRjjGfGsZLgDp
 6ES6Xc2foed6mDDDSJjCVrNghQirJ01AAaP4qAmai4MgU5zgiWXoZ9GpT07yPSUbRlvb
 ZuopSAdARtBSABfwRHJMDa1Dy4uC+IVlGAx0Xxy2LsNVilxFgDcTMZsAIBy9YENitnP3
 YUA4x99xuR9sAVQ1IZnx/6Zk5L01kPk+Lf3WfhDMPihKaQG5D1RFGXIx2+HPYmJGgIiG
 g7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693346562; x=1693951362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pLMtweIj9VXeYhHPPyPr7xGLS4OZL75mnN+1BxZJcQ0=;
 b=D7xIXDasXgPJBOWoZYoEyYhH2qeXf7ejf8FVni2Mw9NuCwIi4LpjYpWtz8Fr2I3Dyf
 TUNFI6OmpPk7Dd3R6ra587EKSnD1ByvVukKpH/+DmEFKAGJot6k3Cg2N0EiApT91eAQe
 2xIvAqkidFfGtGtOCQ7xUonfB1COeFlv6T7h2wB7ddHctW9XDmev471sTG918GLovyCJ
 A94OU24ckI55a3jLXiqOa0HUmpyGVC/CVuY9M6CMZLtRA0NbnUO0eEeIlCHKOuqHHlqq
 wMm/030+YquV12CPwc/WC7nxGYGwys8cyRAjroUe/pwSPpSiceYLkRFCD3puxAfxSqjN
 0bTA==
X-Gm-Message-State: AOJu0YymtOb0RczihlY747igprFtuIlJ6RxcJGRBkjVHGq2nOPf8Abyz
 KIyIrjGAlRs8pMBT7TyOLyaY1PMdWOVjSotSh6o=
X-Google-Smtp-Source: AGHT+IFb5Ak9DZaGrFwSRcSm2f8ZhkQjpI612fElKuQ1rxT4EPNGfPPRvixQlK/qpleyVkdksMHEEg==
X-Received: by 2002:a05:6a00:1256:b0:68a:5395:7a9c with SMTP id
 u22-20020a056a00125600b0068a53957a9cmr564445pfi.9.1693346562589; 
 Tue, 29 Aug 2023 15:02:42 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 b28-20020a63715c000000b0056606274e54sm9538196pgn.31.2023.08.29.15.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 15:02:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	laurent@vivier.eu
Subject: [PATCH v5 13/20] linux-user/aarch64: Add vdso
Date: Tue, 29 Aug 2023 15:02:21 -0700
Message-Id: <20230829220228.928506-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829220228.928506-1-richard.henderson@linaro.org>
References: <20230829220228.928506-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
 linux-user/elfload.c           |   7 ++++
 linux-user/aarch64/meson.build |  33 +++++++++++++++
 linux-user/aarch64/vdso-be.so  | Bin 0 -> 3216 bytes
 linux-user/aarch64/vdso-le.so  | Bin 0 -> 3216 bytes
 linux-user/aarch64/vdso.S      |  73 +++++++++++++++++++++++++++++++++
 linux-user/aarch64/vdso.ld     |  72 ++++++++++++++++++++++++++++++++
 linux-user/meson.build         |   1 +
 7 files changed, 186 insertions(+)
 create mode 100644 linux-user/aarch64/meson.build
 create mode 100755 linux-user/aarch64/vdso-be.so
 create mode 100755 linux-user/aarch64/vdso-le.so
 create mode 100644 linux-user/aarch64/vdso.S
 create mode 100644 linux-user/aarch64/vdso.ld

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b421f04675..8316868bd2 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -768,6 +768,13 @@ static uint32_t get_elf_hwcap2(void)
 
 #undef GET_FEATURE_ID
 
+#if TARGET_BIG_ENDIAN
+# include "vdso-be.c.inc"
+#else
+# include "vdso-le.c.inc"
+#endif
+#define vdso_image_info()    &vdso_image_info
+
 #endif /* not TARGET_AARCH64 */
 #endif /* TARGET_ARM */
 
diff --git a/linux-user/aarch64/meson.build b/linux-user/aarch64/meson.build
new file mode 100644
index 0000000000..b769c87570
--- /dev/null
+++ b/linux-user/aarch64/meson.build
@@ -0,0 +1,33 @@
+# TARGET_BIG_ENDIAN is defined to 'n' for little-endian; which means it
+# is always true as far as source_set.apply() is concerned.  Always build
+# both header files and include the right one via #if.
+
+vdso_cmd = [
+    build_vdso_cmd,
+    '-B', meson.project_build_root(),
+    '-C', meson.current_source_dir(),
+    '-T', 'aarch64-linux-user',
+    '-o', '@OUTPUT@',
+    '--',
+    '-nostdlib', '-shared',
+    '-Wl,-h,linux-vdso.so.1',
+    '-Wl,--build-id=sha1',
+    '-Wl,--hash-style=both',
+    '-Wl,-T,@INPUT1@',
+    '@INPUT0@'
+]
+
+vdso_le_so = custom_target(output: 'vdso-le.so',
+                           input: files('vdso.S', 'vdso.ld'),
+                           command: vdso_cmd + ['-mlittle-endian'])
+
+vdso_be_so = custom_target(output: 'vdso-be.so',
+                           input: files('vdso.S', 'vdso.ld'),
+                           command: vdso_cmd + ['-mbig-endian'])
+
+gen = [
+  gen_vdso.process(vdso_le_so, extra_args: ['-r', '__kernel_rt_sigreturn']),
+  gen_vdso.process(vdso_be_so, extra_args: ['-r', '__kernel_rt_sigreturn']),
+]
+
+linux_user_ss.add(when: 'TARGET_AARCH64', if_true: gen)
diff --git a/linux-user/aarch64/vdso-be.so b/linux-user/aarch64/vdso-be.so
new file mode 100755
index 0000000000000000000000000000000000000000..b19563b648cc3e33a45b9394695d747f55c11db7
GIT binary patch
literal 3216
zcmc&$O>A355T57v+5{-Ysi=q)1g#XIswz)u5h$n}>|m!!<)$HRMcT{OwO?YViH)9L
zih~5?z=Z>%s3*h$7jXfJb1N?G0i;U3Re&lXl@n4Wq>3KOr9bY>?#y~^Y=p#tN%nm^
z-^}dn+ud2e5A%iTRLTP@K3u}SLugCJ*oV)vHVIoG18H~$^{v<fV@J+N4|=197KCBc
zDaVlE2R(y7jfK(7Duo>9^IFFKH#BtTHHOQ{@AI9wplKX>5uW8hLCPZyyWXO)_afvt
zPLSS@;?mf*9GW`;SFwXaoUePPPkDT@e|7!-C&$uv?_9aC^5d7czWDXKi@WpeN3fmy
zrx<A*6rbJ+>g`AO2vOhEfH@8NmszJhLP@nW06fX~F5^>-dY|g;_5-5_8A8+_8Xaiu
zNtb<@VE+Gra0kFPlQ_7^6QK3ZIs9$rX+Ks*pnaEh7d*#b){Dk@&f%|d0P+7IUJH%1
zzr5bM&wHW6q^_JZtbK^5wzY+&;bq`^*2&Mmc`*9?v*xFNq)(mxVb@Eo+;87xAA(Y6
zqqr8Ws^ut2s%uewsa)LXu%*>{>8#lL&~eo0uyLXq)#W%!*5ewiR%`3cm(P_O^$`E}
zLt%FA#G*P7z81dnI?e_Uk^LjhGk;ItxpEOTI?vBzGv}1vC<We-y8bcS5MYHK-k5(7
zf&9rUgKZx+61~RWdkYXWU+~7Zy(k==P1^4XBGkD5^PZiXH!%38tG@b0>)X5a8Aq>-
z7#qb765KeN3yRdY(U8~Y9{HAGERQA<TUS~`QtDIBRg?HYUg~mQI6~z4yx98HX5@#A
zpRHrz={%zZz2iT@e8!-8;y7IIa^G2=>pnQ&<1ck3^+0AX=wCnN+i%_Ix1rxS#7W+-
zv2SI-_&YqCw`={!FtFcyg&lu?#tx46!hrgJ%c*ns9$9wy+dK}f`}+<r>yt+Qg2P{9
z|1^|Jhik7ER%XLGjF(}&2`YDTE_-D5O)NjW_*H&JO)q4R<kd`W0o0+w(Wz`f9i5&&
zmOrkJXQv8z)m?$M?rnt+E@kWcZ|(>P8yjm$@eE=T8>~pLR!<@b%Nw=gTD7D*=!;lP
ziV!Z>*27A%Q89cH8|GXTH>&kom!irLMisRb7uO<HDWj)o5GGMG;YIt8K<9$%#@6kk
z8PnEvt|tfWtH^Hbxc4`za_%gWujHV<#M3$0i%ot{`QAvikV6p!syB+~y0P)2$Q^Ka
zEL{?Rq8nkC(d|?66TX2>eseg#`A)!b<~d>?B9E;Zi4Rbl#NYS7*iYg&jqWqTB<lU*
z$!*H9Nj%qyy~pIcgZxQk9jJd8^S7yk!trv?3F>>r&Ch<?|LxxI6}%@idNhlA{<QuQ
zC+|;gOW0&SlD|m?9EZ_<CmPz`_gbZ6+#65(jbiWFJw~@rH~$C7N<5##fY(n@&))`P
zhxSc`V&%PrW0ddd)H_JfH|0(?Nd8gO={Lk(TXrEBI?c+ri~=%W(nqijh#%(r8a|Rh
HMjQVaBo8Se

literal 0
HcmV?d00001

diff --git a/linux-user/aarch64/vdso-le.so b/linux-user/aarch64/vdso-le.so
new file mode 100755
index 0000000000000000000000000000000000000000..4bd7bf1587b9dc652784efc34f67be6514f46a10
GIT binary patch
literal 3216
zcmcguL2MgU5FKYzk|v=|3KfxpXptgRRj>+0LWOd$gY72BNkeGV(#x;0H@0bFqxB|r
zDgixk;Y1K8ZU%9ID-u*(=z#+gH&jr?C8tW2K#(5b)Yi=G&a>A)TY-ec*nj8$H#2|!
z{y#JO-^~^B1E~~&9QvAiBciklwuhl1*h$*Q&v80P4>3H*Ev;gkPwHggm`30swMk;T
zGAR={>8b`86H!~|wRv~(Du=(NTR~auS~{=IA7z;kxT=M|q<>!Lvw1eOA_9j$u^H#K
zkK5_R716pbm?J$V>5DHJi~P$^cZTvA|Eu|5{&?}o=EzQE<+n#zL<i)-bRlA)ophIU
zqCf9<8Zy4BWAP_+O~-ORLT%YNrjdxzW#yyFCzaprMDwL(flT*wtmd?<;~AAlTL1sk
zWtWF&jBe^WWUqy?+yuX^IL_lu#wX}bM|9#O$13{Qta%<&{Cf+J+s6BdL)muhx%6=!
zqN^c9h+)A*M{sFk_YI{}G#rJu=!yJe@6^p-KWKgU-Ng&z+4fUM?`1yUA!9Cie%)I$
z6)y;C>t18ET-@rRrL{)s5@ZRm?=^d<ADCvX;(Nh{U#GQNeWUfvX1UpL`Tr~x<`-Aa
zn-lKy?sG5jVtDoV$tb12Prm*AVTtF*xgl2Nod#I`{tspdc_rr{l$vr*2_`yeZclR)
z!a1g{EYo1?iPY5Ckr0#k9OE`4N=#<j`RUl<t3R^+jq8s2IUFD8AJ4_c)rm+JStmao
zUJdd)uHo=ov}K_dIea>8Bt}f;aF))<!CB;RG$3!|B8N{N`P+{Vb@R9%AEu=Ib7(&y
zZ~OH}x^=G~AEj-L?|!_O55VR12NUu~&O}bp-nWAxzIUETf0RB;@S8OMp>Xy)9ee+$
z!uj{Um(+z6uXE1Y|19H4`Tr{8Np+;6xLrryR@|-^A1S`4UX)4;OIHe)Yi@(4%QW30
zlYM<LvoQZMrym!7lbbX7<;+6P%w?C!oGzT1%@oX;eEzlES#vfsTgaLI4D9B8H^U#C
z%3a-mQzOW2ZmkE!H<$;0#H;Al8-Yh|d8=Mrua&|M>oP9}MRF_k4YyisRwF#{BV^O_
zo3%#0Z(z#gdR4RP7uP*gEwd&@<OW_V;641WByl143Zy0C5?taSPWV0mdy+d+hY>!A
zJ8%xJkZ^Z_J?hqRmdZC3{!t&mw<Gg#jWQMN@%=r)nBee_Is$%_WpRQ%_)9F5Zw~yU
z-hiXdVt&{m9Z$0DU;K@SJ?av;$c1eC2ql_T8SHTn0mr=q`nsJM(ktBS#QdYqfk*YD
z=O2E+&#}GSSujRD1jqUjBY1x-V3j+vCfGmdo(O&H8^#jDaeLHP@MBO^Zu@^n?Qw@d
zodL)CF^%m%?i)J7cUAE%eKEOL9_9xBlcL15pBv6L1oUxH1OAIR$bI|#CKyYyA5ll|
H{e%7AHUTDw

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
index 099e5c4fe0..1b265ed365 100644
--- a/linux-user/meson.build
+++ b/linux-user/meson.build
@@ -36,6 +36,7 @@ gen_vdso_exe = executable('gen-vdso', 'gen-vdso.c',
 gen_vdso = generator(gen_vdso_exe, output: '@BASENAME@.c.inc',
                      arguments: ['-o', '@OUTPUT@', '@EXTRA_ARGS@', '@INPUT@'])
 
+subdir('aarch64')
 subdir('alpha')
 subdir('arm')
 subdir('hppa')
-- 
2.34.1


