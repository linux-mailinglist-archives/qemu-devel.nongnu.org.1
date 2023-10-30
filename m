Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 343077DC1D4
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:22:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZed-000246-V1; Mon, 30 Oct 2023 17:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdy-00012B-Th
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:55 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdp-0006VX-Gm
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:54 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cbf47fa563so37709485ad.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 14:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698700662; x=1699305462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIIKnVJMvYMr+X7UeO2akO3+fnEkCjZX9Tlv2TRpvik=;
 b=PwSAbPksyxG3bPtOo42RGqAhQcICno30YlGaJw79L7gvV6Kv7sLk7Z0o/83GhGhauQ
 361o4vUBU8I34l9ApPsPr5+BXLFPQsMfeBGea4QMnFN1rkUzqPESXRYmYdSVhIsffFws
 9OHADm09K3uYmRnvYaUx/RpKDVPEQzDphcppgldqKA2Ow6wqFIj/hcaQO1BvlYVRXMZ0
 pRgvtEosclYxZuybekkUKd2QSuizn7VmhVuN2PfgzxgsGYxpoGXifezz9SrK3MsHzXER
 +jfLkwIGXRlW2FR84FvKmYB9njnfpq0kmNMxT/QAmbgRrmE2Y216j/wtluu6Vqr+tFgX
 7IIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698700662; x=1699305462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vIIKnVJMvYMr+X7UeO2akO3+fnEkCjZX9Tlv2TRpvik=;
 b=e7sBn1pbTa51n4TofF/MjMxa8Xcvo3rWzi10GL5ShTK0MyDtLxFnjolfIHiHQZzDDx
 0v19nRBp9n3A51Ec06seZtpR3QVi2ki+0ScOH/AguiCz8ioky1/qnHei8oKsMQG55jq5
 uILwGJdJ8FoJGTGxgPlEn2Q5jW/hOgZh4Ei+vaF2xAUrJBdzcGYg+/wfuw15R6ORqgnF
 7xR4nK0j9AFT2KWDyL5Fq+4q5rjFjL/+9ioSXeru3EFmMKSRTnMPmYITOKK6I379eGYo
 AwLlsHRZdPRA78pjJ1g3aD548M/c1btRgD8T26xNZRdz3cXo8J1CrFrmh/TGvGaJwvvC
 P+wA==
X-Gm-Message-State: AOJu0YxzV9I3uQO+rgTeFW/kPxIh5EToTzK/T6YtZdNAvY66dx4+pr+h
 yH3Gw2wVMr0THs3peMVGm+vKs+XmkWPmvcnwWUY=
X-Google-Smtp-Source: AGHT+IHrHP7Jg6qtUhgbiBoL46HT3mKEMh33jBWg40f3wv18wbvu8wxl65jS9pdybJNQcniwxqf5UQ==
X-Received: by 2002:a17:902:da89:b0:1cc:449b:68a8 with SMTP id
 j9-20020a170902da8900b001cc449b68a8mr4455909plx.46.1698700662246; 
 Mon, 30 Oct 2023 14:17:42 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf2-20020a170903268200b001cc32261bdfsm4670350plb.38.2023.10.30.14.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:17:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/21] linux-user/riscv: Add vdso
Date: Mon, 30 Oct 2023 14:17:21 -0700
Message-Id: <20231030211727.165090-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030211727.165090-1-richard.henderson@linaro.org>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/riscv/vdso-asmoffset.h |   9 ++
 linux-user/elfload.c              |   2 +
 linux-user/riscv/signal.c         |   8 ++
 linux-user/meson.build            |   1 +
 linux-user/riscv/Makefile.vdso    |  15 +++
 linux-user/riscv/meson.build      |   7 ++
 linux-user/riscv/vdso-32.so       | Bin 0 -> 2900 bytes
 linux-user/riscv/vdso-64.so       | Bin 0 -> 3856 bytes
 linux-user/riscv/vdso.S           | 187 ++++++++++++++++++++++++++++++
 linux-user/riscv/vdso.ld          |  74 ++++++++++++
 10 files changed, 303 insertions(+)
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
index 3306651be5..e2d90b84a9 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1892,8 +1892,10 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
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
index 0000000000000000000000000000000000000000..1ad1e5cbbbb8b1fe36b0fe4bcb6c06fab8219ecd
GIT binary patch
literal 2900
zcmb_eTWl0n7(TPZVyUHWDVSm#Q)tBoakE`3X|QQ_x7~7aX*Y!`UgC5+yX~&9yUp%w
zLmR@yBHoaTR0Kq&poogPiZ>L6L=zLABtH4zgAYa%jnRm{h}7?!nX^o_4?g&}-~Q*n
z%s=PM`Oi1AEgb1m6h%l;#cx7dEpVPL6Ji#0i>Mc~MU$u!9%$NEaRFn3d4wv&aH|^w
zTRLpb7;DS=wp%clxP}go5H6@1BuN~CP00Gu?~M2%+(e=gF+#?vFF7z%d_LkRAy#(x
ziH@zeoN%Z87eg1Tzxkm)cKE@*AHS_c%m7%c6BGLV%2aj>G?#S_n$Mt!IhI531+E1!
zb!!dKcx<N3!EXg{d1@-#j~o64&Gr2P9pME22MMqsM8$0RY)@g*8=&Xm&P$;yFlo+#
z_D*OiRpQsFei%N)IbX&XFzCpSz-)BH+hNx@;@l%HgX^T`9`e~Z1?i^n9(<k@PMP`C
z1g}x5<}?R|$3vTWW<PvUTU@u-m#mxEJ$3SIdeOoY9htTTpC7roIFJyUHWJTgwV{Mz
zq|%A(U_3S|efp-XzEMX0<;*4W(ua%n;exaVHx=?pEv3iwWT|}4(DJFFT*4^iGGbFI
zQ`mefZ|lW>vxuzj?%SZXc$;s>gdwhJf9!SZZ}R-lbJ=rs0Q-u<y>j8Vu<iSD#wc=s
zlv?$Udf0qM9wfFxC!wRz6VR9G2Po=TuTZuqO6^>iV4WJ^OMpEfqLuY=G&6I30BbFy
zA2MMnUcU|n0!nR#tLSzI;yVT&>K}h#=lu`gyKBQEcRjlPvEIj{Pjv5&Jh^7is=ZzN
zI`@a33LI#kXnT6a!PaM%A8I-5KjM4Vdvw`zOP_CgVac)1$<Xn@iS`%UURrUo_2uQK
zT3+$L>U+(5dfDqs-)MSsNwM**#c$W2x$&L4cW-#F=KbqGn16QOhn|lr&sBU}{z=*S
z+2&l2Vs85Y_AN!<<rWRcfa7jatteL-nkGfHTM-A!d<*l4k1tk)+7J}u4Lij6O^SjX
zm+o=9s@>5)^*R-~LR437Z$I<Zr)tBoKGZ3Qq3xn{y*2JPYgyy%<*dswuQfI717*cB
z`hy|-<WhNkL@3-FcW&f1f671Htfl?KJ}t)4pnuq}#rZRq((^g`$5MldjGjOuH)965
zWcyUJJ1h>QOEpi4#W|L(nwbF}76{Kig<M5ZO{NlpoMqY8sU&w<wt2dQ<RH~%tbVI3
zuIGuiIM&K1(}DX+aWbC8HPmWpr)bfhYp=kvXMt<Dm*gf(<jz_a<JVzGKA|YE*~bB!
zJZSr2lk+Vp7hw$K`We4ZhM>u9gV0Xy8iVcR#yzl|T*jVra$ym+lRH0y?c_$G>(TsZ
zB(~9;6^)yP)_G5NaP8_2p+$RpI>McOy<rXXaA$C3SX&<qMZy|b2Jag!yh`ip4XzDq
zt2%pywldNa3P!Y^uC8_A^)k^xD>li^#7r|0-*i5k#$9%$5;Zzlu;e3=3gOL<rj6JD
zw2`xPQjRiNBO$!;(M&9z(#-*Kp<_l&c!x3tZ!(roT7DyEc}5bsd@7rnW@vHYO(eC!
zTr8c?l5u28OL&dMW<z+*!{v<`MlLl_FhJP<S!$8V?q;j=JQ0n66xo7{;NYoXOF6$a
ztdn8AgZR$kJCxnddVJ>-<R*C!*7E@DPqr`Xu`daEFSyJx?KXgI&3Zhq1UW>uHggF2
z{;<Cnc#eqxeE-Y~**=8LZxfzzev?SyoG5F6DZ3ueJuweHS&!EfcLVY}r5{0pb8)U0
zrr`NvZC>O27K3SuT)P2F=8->$pX?kenYY!><DT%G5`4~5WZq6VP-0m6`R&*t4QRPu
vc~2SIg1ifGl4tmx!+P8|`R#(CDQ#Hj*V2HN^{Oz&eM_<c&2g|~UCsL&j}fS?

literal 0
HcmV?d00001

diff --git a/linux-user/riscv/vdso-64.so b/linux-user/riscv/vdso-64.so
new file mode 100755
index 0000000000000000000000000000000000000000..83992bebe6d0182f24edfffc531015fd2f4e1cfb
GIT binary patch
literal 3856
zcmc&%>u*#=6hC(_g{2g1p%}2$6tfXRaI<VGR&B^`cefN-%BHljMv}|2kM73qBfEE-
z(h#Xy-@LSlh@eFjU#RsBzS<8a68*wQ{R51AFh(W%#Ya77?>Woe=_Y*egQvasH*+2{
zbI;8DW_Eul-0jdb5YgcZT&)54*l?-dDl9<oK?f|vcM~)s0$4iB?z5m07vaVPoov?u
z@)S2p4b+f;qLVQZE>djvs<bDFLoAB}-_+lEZb(HB>jh<;ksr)B#kJLyo0*3$OAUhL
zOF~G`5pGvS@fRdt62fMDFh8)RcK}XpyK&cy`P-tAbBl-nyz=dg=iu7KXo6+*LNP5U
z$5HVj1)}`^&s?rt;D&kl;N!Za{W2v6g{Kz|TUA)XxQbEDx#Wk<P#zRk#Q(23tN+W~
z-``y4?%)@$Ut+to^M9a@*_-9ON&hr$%b@|<IZ+L4SkL;fqMty06Z|^IZWY*#C2A+n
z{*t$qtoJGHgjpX~{5P|HQ1O>_Ov9%+Af&lsH!N8q^H2Rt%4sghpOC(nVzkE9O+F1g
zq$9ubynoX&z4Ndq)q3>6+}R76HLK4AvYjixKCyOsPXY{MBwoxJLkZJNXA-$&Ji1qO
zvEf|oezD9`77|6#VQ?&8l3H@OR7@G^STvTZG+!`{VtS~MFiV9j45zcD(OaooH~w#g
z@YddeL8INh@irVVilge!(rNgG^mlsZ=cTm2TJe#+L*MQ|TWSA~^<*QV`6SU=^t)V$
zl&5BN>_lusj39<7kRBAK8PLc2K-;HjElV9`9qorp_{jPpzYX|YWJG}D^g_Ydofz!X
zS{fX)3+sFn+JocTL;D^coiHECKRWza>hbs!yPw?k)Zl^sgONkw!#ziWPy3$foa{K-
z{;cQNhUeBDcRk;BqV<JUC!0?-zS!`Rb1Hbc>t)}W&98L6dgs}W*EYT0{)YEW&s*+u
z8{S_3&boJRnRdN*^ZRWd-1K4VM>l-D>XYlwH(yx(Y2#<hK5zJ<{!8Z!tp^(K6h1+G
z<QpcPN9v1M9~uXkbT%%!T5hwI$16T7aPg7v3XGX_PCLop--WM2x)>V)tpkg7g^^9|
zX>Wd`k@4m|MwCiPZ{BOf={1&)6$_*vOD7ZASOOhA7<3KMadL!r?XEh`w(Of~y$-^M
z)%yATKz1GKDtue*kC~&*qlk{X$yZbFgjzhP<Bk^ov^S+ATg!P=tzQB?ve9h@-Ns`!
zHI9F&y;?5Qa$Zn_$E>-(%7^yATK?CegNE&>d8Yk9`f-JzyyXVxe^-e8XK4f4<UTCd
z;@c$ZiEmZ@9Amx8=Z9FY^6E*}tGqqUdX@jbV!g`e5Q_~)ZV!0_?i{#A!3f^l>)*aL
z07j&5M<5g&=nEN0U)%g!LPo#8D;zSA1@YWBLOn)zpMQJE=n3|Lu_e5t%O5s&ba(Fz
z^^2p8_LzigF=s7euIAe+ZsnFL)NNzwijIgLz+K#%F{67B&4Ps~DP?nJ0^ISv*=Qym
zD;LlgF=|G^J(MlEQ_*6|(whZKGm<D2)46O_#fXDDkus8nXeME#;^-+gaGQxy6WnD2
zaYs$Fkls@=@j&^{(t<6}nMdaziSUP@%Tia~>ULg(7Fyb}TxI<WdicC3pR4F6_W|Nr
z61rc|-AnoxJ`((noKR$p5>NYzg!U12A^pp~5fp#&C6T%yoo_@T(!bm%1&OOkq<x8#
zJdphlyxU29g$LQeN5Lp+yrl)`Vw=PZUkb|oRQx%eQiZ#*G-vBycvWyYdrJS(kKjFM
zr@N}ug?|O*`_=r*0EmBROcF0VEqJZ<Lw6E;yzsf;Ptp;i<X_YeaJ<l~@SR{#92sTa
zL_L88%uQbEg7SMRAPPn`|Ms!lU1xbfQ=Aw&ALtG&<Cpa-cUXHYm3Q+GjPDhL+J6(;
TWp3@RckmCKV|FE$)%bq_XAha}

literal 0
HcmV?d00001

diff --git a/linux-user/riscv/vdso.S b/linux-user/riscv/vdso.S
new file mode 100644
index 0000000000..a86d8fc488
--- /dev/null
+++ b/linux-user/riscv/vdso.S
@@ -0,0 +1,187 @@
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
+	ret
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


