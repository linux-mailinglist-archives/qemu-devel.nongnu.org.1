Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E01B378D03D
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:19:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mq-0000h1-Dm; Tue, 29 Aug 2023 19:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nV-0002S4-Pm
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:53 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nQ-0004Ad-VV
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:52 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7923ae72111so180923039f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 15:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693346566; x=1693951366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PALhtNLDTEQBplpEDAV9CBTQKyCRvnx9lwlRHrFIaiA=;
 b=zyZrwRhpOkxWUpIyiGR84QasUF3iAXz7H7HFNOup5yghWqtbX1zzNu9m/IySEZF0cL
 YvEqakECcyGLoVPBiNofPJYgXuG4NXvwDISIOzC4JrIk8auq8EuaAzPeNZzXlY1VDk0Q
 WxIiYLQX4rvyD0SFQ/QihRTiKRCfJQgVv8l3B4r2vUV6q2plLrPLTasa/tOGQ5/RNoaV
 BYOkjLLPAUWp7RoQAcxfUcKYWLGjllnuGZRK4gppRB/UYN4P1jK5Y23lQXrRrlP0jjgo
 nst527nCwkvRAm2qlKDE63AtK7J55lwWOWdNzND3txUvEeMqz5kMY6HzCRZONzolaeK9
 fS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693346566; x=1693951366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PALhtNLDTEQBplpEDAV9CBTQKyCRvnx9lwlRHrFIaiA=;
 b=QZF1890Zv7X2SbZ7xlqZ7q4h45ioVXicWIFDF2Dp3k8G81fXwf9ZWAfBEzdu1tRXiQ
 wfaS2B9Pca5UeKXd2kFXqaep3hQ0A861qq2LcqezP4Nl5+uTIkzEvfaztv3WstyRpYRG
 LzCIw/9VsP/Es+/Wsh98y+3WUue5v91kSygABAMqxG10mEBnizj7O0HkS1KD8IYp+OhL
 dtvNUQ+JxzYYcajR4Gl1uKsmHQX85MexhyQEY4CFAKqOQtmrHm/2lZk7syspClB1u35l
 VSJIweYwthKoR2oBgaOuyWW5EwACxY0fnsNNGRElKkVsXJAz0YNsOgf/Odwn/hDtXNaO
 sonA==
X-Gm-Message-State: AOJu0Yy0pdBDpNYcKT+zEDkvL0ID5uqt/EX8vZXmlqCGxdu+uhXBdVde
 Aa/ojDXFyKHxcUm2WYZMGjKcl71eifTSinrfkgM=
X-Google-Smtp-Source: AGHT+IHqgeQBV1NzhREUtrfHwYf3viORRCyuQ/I1tXFRRRvG2nhCtpmXD+HYn6Qm/49v3qjgubHDTw==
X-Received: by 2002:a05:6602:1b14:b0:790:d813:2d38 with SMTP id
 dk20-20020a0566021b1400b00790d8132d38mr614519iob.11.1693346565808; 
 Tue, 29 Aug 2023 15:02:45 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 b28-20020a63715c000000b0056606274e54sm9538196pgn.31.2023.08.29.15.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 15:02:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	laurent@vivier.eu
Subject: [PATCH v5 16/20] linux-user/riscv: Add vdso
Date: Tue, 29 Aug 2023 15:02:24 -0700
Message-Id: <20230829220228.928506-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829220228.928506-1-richard.henderson@linaro.org>
References: <20230829220228.928506-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d36;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd36.google.com
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
 linux-user/riscv/vdso-asmoffset.h |   9 ++
 linux-user/elfload.c              |   4 +
 linux-user/riscv/signal.c         |   8 ++
 linux-user/meson.build            |   1 +
 linux-user/riscv/meson.build      |  30 +++++
 linux-user/riscv/vdso-32.so       | Bin 0 -> 2888 bytes
 linux-user/riscv/vdso-64.so       | Bin 0 -> 3840 bytes
 linux-user/riscv/vdso.S           | 186 ++++++++++++++++++++++++++++++
 linux-user/riscv/vdso.ld          |  74 ++++++++++++
 9 files changed, 312 insertions(+)
 create mode 100644 linux-user/riscv/vdso-asmoffset.h
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
index eb22a17e0e..8f902bb427 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1733,8 +1733,10 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 #ifdef TARGET_RISCV32
 #define ELF_CLASS ELFCLASS32
+#include "vdso-32.c.inc"
 #else
 #define ELF_CLASS ELFCLASS64
+#include "vdso-64.c.inc"
 #endif
 
 #define ELF_HWCAP get_elf_hwcap()
@@ -1751,6 +1753,8 @@ static uint32_t get_elf_hwcap(void)
 #undef MISA_BIT
 }
 
+#define vdso_image_info()    &vdso_image_info
+
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
 {
diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
index eaa168199a..5449c7618a 100644
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
     unsigned long uc_flags;
     struct target_ucontext *uc_link;
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
index 1b265ed365..3aa967b27c 100644
--- a/linux-user/meson.build
+++ b/linux-user/meson.build
@@ -46,6 +46,7 @@ subdir('microblaze')
 subdir('mips64')
 subdir('mips')
 subdir('ppc')
+subdir('riscv')
 subdir('s390x')
 subdir('sh4')
 subdir('sparc')
diff --git a/linux-user/riscv/meson.build b/linux-user/riscv/meson.build
new file mode 100644
index 0000000000..0a00cae9fd
--- /dev/null
+++ b/linux-user/riscv/meson.build
@@ -0,0 +1,30 @@
+vdso_cmd = [
+    build_vdso_cmd,
+    '-B', meson.project_build_root(),
+    '-C', meson.current_source_dir(),
+    '-T', 'riscv64-linux-user',
+    '-o', '@OUTPUT@',
+    '--',
+    '-nostdlib', '-shared', '-fpic',
+    '-Wl,-h,linux-vdso.so.1',
+    '-Wl,--build-id=sha1',
+    '-Wl,--hash-style=both',
+    '-Wl,-T,@INPUT1@',
+    '@INPUT0@'
+]
+
+vdso_32_so = custom_target(output: 'vdso-32.so',
+                           input: files('vdso.S', 'vdso.ld'),
+                           depend_files: files('vdso-asmoffset.h'),
+                           command: vdso_cmd + ['-mabi=ilp32d', '-march=rv32g'])
+
+vdso_64_so = custom_target(output: 'vdso-64.so',
+                           input: files('vdso.S', 'vdso.ld'),
+                           depend_files: files('vdso-asmoffset.h'),
+                           command: vdso_cmd + ['-mabi=lp64d', '-march=rv64g'])
+
+vdso_32_inc = gen_vdso.process(vdso_32_so, extra_args: ['-r', '__vdso_rt_sigreturn'])
+vdso_64_inc = gen_vdso.process(vdso_64_so, extra_args: ['-r', '__vdso_rt_sigreturn'])
+
+linux_user_ss.add(when: 'TARGET_RISCV32', if_true: vdso_32_inc)
+linux_user_ss.add(when: 'TARGET_RISCV64', if_true: vdso_64_inc)
diff --git a/linux-user/riscv/vdso-32.so b/linux-user/riscv/vdso-32.so
new file mode 100755
index 0000000000000000000000000000000000000000..189e2f49e78f158cf49e6092edf7ece8cf7e8a25
GIT binary patch
literal 2888
zcmb_eU2GIp6h5=d;!>e*DVSm#Q)tD8)XjFOgkaNj+iv-BX`4b7lsMh)Zo3=lZnHbv
zKtn88L{tQ{1rbpTD59cPKoLbD(ZobwOnmZP<BKu=pbv`F@0*#sOtlX_c-n8zJwJ2i
z-nr*~Gb7<ho2F@^#4W#yvg+ZS@QTcWu9r%gEj3aiK4{uEa0O$6d4yYJu-1ctEiJZY
zjI~vL+bzr`Zlc2{;({telEM+#gsR{9oe@8Rn<!KxMyNRTRR?B@FF+h6WOaMD)NVO*
z_^kKZ)kEKYIr2xx`Cl$9zC2Qlm;ta>D<<^Y^{LDbXfEp#G@rpF=2!%M0Js^z)U7o@
z<FT1C2fuTHYg1F19^CLRXs+)k=m;n9KS&b`Lfn`wpY3T(dK2_~+<6(a7nA0EXzzwr
zQX)T3^}wih#1}H?up=<b9CjmYpTp)JaT#1EHTRIu#wkcQg>&HZq;Sg2rzUufRx+n9
zBt9Q)=9&HQMfv201A%14_`a!A7Y7zEI@ywLSorzTJ12V+qU%HPTt@Ft7)EL!k?D&^
zw<}+4YbN%viu}u&P2`jh7sm$k%Ie#i&n5L#EE-D|%4ZEdm+H?ZjC?jNTT|)$w!3&+
zKmO|^vbMc@lV0zyyBiaRxTgKF*R8+fmw%kco~r=ZR}}7*3%~i1?~53tsQuB(-S<?&
z<}>mkaV2yTx)XXY^fmecihH<Av>lpOKF=krQwDqmum_~GxH67rW^Mprtx9OhxTSdg
z1{7%0%ICT!J)WlcuHHv`MjzU}<*^6$Y<m2@y&IqCdb0DW_I;73*X>_(pzUDmGtJL7
zjWv!p99ngF<#Q{J)IT3Q8hF8ftoFraFV(!fbfWcm^NFUDjjuGky6V)**H)aae?9m{
z;7$LT+P9XyUGvV;$?A8PoUJ@}`}vCZZhOD%!mS@HxH$hq-$%ul=6+oCiTCnsbFRlQ
zH$DrV9ZGDEN2(@(6CNqmwChzh$EDPx$(T2=D2Mpy5>4DyAsMaOC8Kv}8gg7QpT|||
z>HITR;YO}VY4Og+b6<bzuA1mZoxJq#l*096-X62gn0IFp>oK44QjEvElV18l&G^Zt
za<L)NxF4SE(DGm^I9R6-1P23pl%u}jU{H_qXE+thW$7PI^(E4=1QNLcGssoj=QcaS
z;yt?D=E<;l#<JNBB27FX5T17m`HA8-*-3;vW!ctABwty!d7?z|j@xFb9;+;_=P9;$
z)ygNkf$s`&vYf>))b7IW(4sxhUV&xL0>5zo$VZl_-Lx#mZ^4ipLeXHecLO$I&<?^T
z&s$O?VGPvz8GlfPpvh-_&`!P@hVA6T{ji<<#XfWL-z01&Uw#JL$%hh)t=}A6p6K&u
zq<Wj^t()6J>({o3-r3dB5^nA83hSVRdqb<k`o>UmB&>s3@Q%^LYxK6R(E6~xrnO7-
z)sc?oP(<%&Yugass1hAiViVg;Y%~+uP3N#_d}UWE(4m9*3O<sjh(EV|z=-xj8(B*y
z)hL}Y65@|<Pe%t*F>`=i=%^7De}6jfPeyY|%Wq^Y&rl+pOJ&m23_ULXL{jg|Mh6ml
zGLB4TiQh<UGsJHmE`QW8vZ>y@0h0dDQjSb^H(Q<OiKqsYs1{rd2TuiC%K3d^oeb-}
z!}k>5o9uSh<9nVsh_Si{>-hloC)=0x*q4O57hL9;b_2k+W<8!)f*hh+n>hr1zuVsk
zJjX;6eE-aAwtWbj-y=NZ{0>pVIZ@UDQ+7R`dtyF(svfT=?g!MjNe_Yq=i*#1OyT)r
zZC>O2{(@<WTDt*D<&i&#AM6||mG_99$35XWC3Z8x7L`XIN(?GLzZYAS0j<`n?x{k9
q$h!h3d4}IMtjB#*-zylJ62L;gQ3kZCSAsF_TaY<uj>84(M&92P;-?}2

literal 0
HcmV?d00001

diff --git a/linux-user/riscv/vdso-64.so b/linux-user/riscv/vdso-64.so
new file mode 100755
index 0000000000000000000000000000000000000000..3c3b3a8cc579649e5108402b706bf7f741efd2e4
GIT binary patch
literal 3840
zcmc&%Z){Ul6hCieP{)QF3^Uxa3^Nr8G^Lqjk%hc&>o&BEW`j7R$)jt#wQ*~k_I247
zB2(voWYYm6qJk)jf9oF<{Kq~RB_>8b>UWK3jL{hVV9<Had*_tbyGB3w!L!}>yZ8LL
z_r7!Q{k_}0fnZmerh$kHeuc{|0G$o<6?SC_f)1^)6rVLvjR;`tY`bnlAuhz73A)+t
z0!UNb2z5|GIuxDEiEx=>b2g<vL7bu`W%#7=&TvO6dRZ?h^9+4!Mk%hT-0Ef#Hrr|t
zBwrFjDzn_LisCOwz9fXTSTH}(-Mb4m{&4D#+@;gYKK=e$!~ad=mM<FvU!VzA&;!M^
z!HT2mc?v}N?XQKDRpE|#`k-@L(teQ=gTl)TGj<b}GuAPxIhXvf8Lm+LFD=;PU*z%r
z<TeinKXdy6+ohlX16`QCdCr@RPs_FvDxrlFRmq0+tnXpH<Y5~1HSo&<yA@zJ)~KJT
z;=h{px}p!Ven8Q0WqnA|%RZ**(;5)cTCp3}Y?1Y+`AW)ZEy$mc-j`yu>NPdG242#U
zpSA9v*XR3Zyzzzu`xZ`~9bLQTL`Sl1^=C(}&kx4HFvg<UlrbDL&BSOdH53g`h%Pdc
zirgudMaoPpD>@90q;t|58p&njMj{f9#0%YLOe32Z&cw`ICJ7^nWNv&T4eP=GO%UAH
zyKBH`@oc&gCyY{7^k?fdd_(#>e(t9#I$sS~<m}M9m!U1U_qz(Rk<faQX!Wiw&4`qz
zT6AnfY(fkn>J&%?g=q#{lYOA=(X{%iGD}D2=K>blKjgOo%XutKSV#`rK(YN8tZVg^
zW%EnR^=a+yDeay;_l{4S_oeS2c_98^^r77k-|@)6zMYST_6KKrW;-9#A8(s$J<xK{
zduYQG>kc<R*>t4gsk)=JPgg%v`K<d`=kfOE^b=d3Z+qdUldUgqeyQb@?`7{Ro>w=#
zw*K{XZ(Nsee)F2Qn%-`Fr{VO~@7BF{)tTC}E8nmFV8w@(A60zpK1ch3=6eiFD;9Z&
zIrnTu7Td#90CVo@WmKPYH!)6GwpF;{$iB+5<=y1tZ^uU_k&TRjM*Wp%#x}PkeCbWb
zs4wj`!c-gbrF}+}9+QbkHbeT!#8505iJ_wxgZ@EWxER8-PB#~>uAGx%y$gi@iuH^6
zfb1?PFYs%zKW0h}mBZk|)1#NvyP*{Cx$p!FUpl(MaVrYnonrlR=#hi%Ft{AN<xpck
zRnDeWr|r9>1aH}EeVPB9fu;PfL<bG~QS(gupY&;kkbG8$i{C52{_}L;9CAC>OY!Rv
z>WN=fzMN#e%HR80ukz?o)~h_7XT8ezpRiu#Z-_*~og>+}&y#}YaWFb>>-BHn)&WMS
zZ%0R<b5~!$K)Slc-yJY^`rCs616dEh^G2Y@=<4%t4;Ve2ePDD4ceMM1#*VJ8{=iOg
zbkH1=ZYicLMa0GYTEwN?Q-P`-tX$9$u>*Lr6QgE$5Yf!o7?)ZyWyZi0ok)g96A`O|
zzKCHn44&a+&Jz!3<F?++*qX6eCYwkliyB50Jh8YjlnIZ<jCd41r3D@{Hg1B)A`eg4
zG&708oQWTh|19;`1AXJ@dq*PtAxPZs6!kc-MI&u(*{-tx1-<-zu)d?{C-(*7RT8>S
z&|OQ$7d{gFikwhnjuKDjiiFM)4I$&pxe*k9@+FbBAbrn>LS%foKME30lSuy(CwU<I
z?|7G!_yP~IgHFLHYP_ulXlI+m3ttM#eN_B8ozjGxv9{nCUwBn;C40*FGLGP_Xs5fW
zw1s~K<^9$C%LIsjXigHZ{!aL}{X=&UXT0#a;Eys8qvT)IcX7PXtMHwm%wPOv-K0H@
z70gXq+Jf@?sY4WuYW|&bce>_zLdQ5U^nIW^ugt%Wo#oEzjHP;re^7j_7}W7=&@OB1
QbiILp&>V6qv98Ad4M&HUy8r+H

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


