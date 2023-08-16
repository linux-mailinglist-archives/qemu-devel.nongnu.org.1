Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2504677E836
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:05:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWKsD-0002Rt-Bb; Wed, 16 Aug 2023 14:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKs6-0002QU-TX
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:54 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKs3-0001LY-8k
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:54 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bb84194bf3so43520505ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 11:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692209030; x=1692813830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wyk/wqqae3PWGVb2dUGppyGhAFdYitmYsOT76yz/I4g=;
 b=FCDcUp7VdmCXdiqx4cxoY+n5SETVjkI/wfgSi8mbYbvNdHtvQw3+edtBi/heS3HHT+
 xMNb3rEixgCNkVFrnBp4oS48czL8I6bz6bfLyQwNBcZssuQJwBg/c/SN9b42leN1jPhY
 eSJCSLffLEbSI+mLw0JQqvsIOBVo6oAc2DjKh7zPHRpQtjUqLi5k3VMWIE9T8KvbvP65
 dZVmTpBXq6eF7LNLXXq7coh93R0yPseuHmC2rdw34dWxMcp01CgfsiR56oxWhnAWtcJK
 jvmHQimvFC6JRgh0xXSSmKWeRNtlemKUwO3zxZ1z5TAvlzXkudhz1+bbxhmghnFpQcCS
 A+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692209030; x=1692813830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wyk/wqqae3PWGVb2dUGppyGhAFdYitmYsOT76yz/I4g=;
 b=Zkryp4IdO7LvNENITCYPMXfk+kVFwnzVdsAd5o3bMmA5KqVjyIEwPDy2lpQqJCj8kk
 snP9wDgUGljdTuH+dxKW0Od4tZlbcCbOrtFaQVqzB4pQ/DVVwL8VfkOzBJihXEw2Qnsa
 P6HPKfJwnZcwdAk+SNmnky7fgbB0Pe3Uai0dRVMjzexmevGnoQE2yGNhLGc4tYcFrp4Q
 UbiWKSXgl7zEaAriVo8ZVg4ZZ0+p74jbvXwBVMUbj8NUjXpVJ0O4gNjByx16m/Kt3A8A
 2nXlmkw7nnUmYGK55a1NSfYR3BoxCLXV6PIsCvqXPTTVYh0CXSGmqF9Biko5k9MrXrOB
 St5g==
X-Gm-Message-State: AOJu0YzsbNVjusNGpGMp/qZ45N9yWM74bZwqWA8fj0MYbApDFU6Lfztx
 Dt9zUoUcllf0lPuD8zEOvf4ru9G4NY0XtL4OkIc=
X-Google-Smtp-Source: AGHT+IEsvfKTabl3DdayW1ny7eS9J0b8Rk0zdiv6q3+i33r7pgEPWSqwG+7COstqMsK108bypX0c/A==
X-Received: by 2002:a17:903:32cd:b0:1b5:1467:c4e8 with SMTP id
 i13-20020a17090332cd00b001b51467c4e8mr2928672plr.15.1692209029812; 
 Wed, 16 Aug 2023 11:03:49 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a170902868e00b001bc2831e1a9sm13446584plo.90.2023.08.16.11.03.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 11:03:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 12/18] linux-user/arm: Add vdso
Date: Wed, 16 Aug 2023 11:03:32 -0700
Message-Id: <20230816180338.572576-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816180338.572576-1-richard.henderson@linaro.org>
References: <20230816180338.572576-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

The thumb vdso will only be used for m-profile,
as all of our a-profile cpus support arm mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/signal.c       |  30 +++---
 linux-user/elfload.c          |  24 +++++
 linux-user/arm/Makefile.vdso  |  17 +++
 linux-user/arm/meson.build    |  18 ++++
 linux-user/arm/vdso-arm-be.so | Bin 0 -> 2712 bytes
 linux-user/arm/vdso-arm-le.so | Bin 0 -> 2712 bytes
 linux-user/arm/vdso-thm-be.so | Bin 0 -> 2684 bytes
 linux-user/arm/vdso-thm-le.so | Bin 0 -> 2684 bytes
 linux-user/arm/vdso.S         | 193 ++++++++++++++++++++++++++++++++++
 linux-user/arm/vdso.ld        |  67 ++++++++++++
 10 files changed, 332 insertions(+), 17 deletions(-)
 create mode 100644 linux-user/arm/Makefile.vdso
 create mode 100755 linux-user/arm/vdso-arm-be.so
 create mode 100755 linux-user/arm/vdso-arm-le.so
 create mode 100755 linux-user/arm/vdso-thm-be.so
 create mode 100755 linux-user/arm/vdso-thm-le.so
 create mode 100644 linux-user/arm/vdso.S
 create mode 100644 linux-user/arm/vdso.ld

diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
index cf99fd7b8a..bd160b113b 100644
--- a/linux-user/arm/signal.c
+++ b/linux-user/arm/signal.c
@@ -167,9 +167,8 @@ setup_return(CPUARMState *env, struct target_sigaction *ka, int usig,
     abi_ulong handler = 0;
     abi_ulong handler_fdpic_GOT = 0;
     abi_ulong retcode;
-    int thumb, retcode_idx;
-    int is_fdpic = info_is_fdpic(((TaskState *)thread_cpu->opaque)->info);
-    bool copy_retcode;
+    bool thumb;
+    bool is_fdpic = info_is_fdpic(((TaskState *)thread_cpu->opaque)->info);
 
     if (is_fdpic) {
         /* In FDPIC mode, ka->_sa_handler points to a function
@@ -184,9 +183,7 @@ setup_return(CPUARMState *env, struct target_sigaction *ka, int usig,
     } else {
         handler = ka->_sa_handler;
     }
-
     thumb = handler & 1;
-    retcode_idx = thumb + (ka->sa_flags & TARGET_SA_SIGINFO ? 2 : 0);
 
     uint32_t cpsr = cpsr_read(env);
 
@@ -202,24 +199,23 @@ setup_return(CPUARMState *env, struct target_sigaction *ka, int usig,
         cpsr &= ~CPSR_E;
     }
 
+    /* Our vdso default_sigreturn label is a table of entry points. */
+    int idx = is_fdpic * 2 + ((ka->sa_flags & TARGET_SA_SIGINFO) != 0);
+    retcode = default_sigreturn + idx * 16;
+
+    /*
+     * Put the sigreturn code on the stack no matter which return
+     * mechanism we use in order to remain ABI compliant.
+     */
+    memcpy(frame->retcode, g2h_untagged(retcode & ~1), 16);
+
     if (ka->sa_flags & TARGET_SA_RESTORER) {
         if (is_fdpic) {
+            /* Place the function descriptor in slot 3. */
             __put_user((abi_ulong)ka->sa_restorer, &frame->retcode[3]);
-            retcode = (sigreturn_fdpic_tramp +
-                       retcode_idx * RETCODE_BYTES + thumb);
-            copy_retcode = true;
         } else {
             retcode = ka->sa_restorer;
-            copy_retcode = false;
         }
-    } else {
-        retcode = default_sigreturn + retcode_idx * RETCODE_BYTES + thumb;
-        copy_retcode = true;
-    }
-
-    /* Copy the code to the stack slot for ABI compatibility. */
-    if (copy_retcode) {
-        memcpy(frame->retcode, g2h_untagged(retcode & ~1), RETCODE_BYTES);
     }
 
     env->regs[0] = usig;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 98cb1ff053..8c2ca3520f 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -580,6 +580,30 @@ static const char *get_elf_platform(void)
 #undef END
 }
 
+#if TARGET_BIG_ENDIAN
+# include "vdso-arm-be.c.inc"
+# include "vdso-thm-be.c.inc"
+#else
+# include "vdso-arm-le.c.inc"
+# include "vdso-thm-le.c.inc"
+#endif
+
+static const VdsoImageInfo *vdso_image_info(void)
+{
+    ARMCPU *cpu = ARM_CPU(thread_cpu);
+
+    /*
+     * The only cpus we support that do *not* have arm mode are m-profile.
+     * It's not really possible to run Linux on these, but this config is
+     * useful for testing gcc.  In any case, choose the vdso image that
+     * will work for the target cpu.
+     */
+    return (arm_feature(&cpu->env, ARM_FEATURE_M)
+            ? &vdso_thm_image_info
+            : &vdso_arm_image_info);
+}
+#define vdso_image_info vdso_image_info
+
 #else
 /* 64 bit ARM definitions */
 #define ELF_START_MMAP 0x80000000
diff --git a/linux-user/arm/Makefile.vdso b/linux-user/arm/Makefile.vdso
new file mode 100644
index 0000000000..e031a3d549
--- /dev/null
+++ b/linux-user/arm/Makefile.vdso
@@ -0,0 +1,17 @@
+CROSS_CC ?= arm-linux-gnueabihf-gcc
+LDFLAGS := -nostdlib -shared -Wl,-T,vdso.ld \
+	   -Wl,-h,linux-vdso.so.1 -Wl,--hash-style=both -Wl,--build-id=sha1
+
+all: vdso-arm-le.so vdso-arm-be.so vdso-thm-le.so vdso-thm-be.so
+
+vdso-arm-le.so: vdso.S vdso.ld Makefile.vdso
+	$(CROSS_CC) $(LDFLAGS) -mlittle-endian -marm vdso.S -o $@
+
+vdso-arm-be.so: vdso.S vdso.ld Makefile.vdso
+	$(CROSS_CC) $(LDFLAGS) -mbig-endian -marm vdso.S -o $@
+
+vdso-thm-le.so: vdso.S vdso.ld Makefile.vdso
+	$(CROSS_CC) $(LDFLAGS) -mlittle-endian -mthumb vdso.S -o $@
+
+vdso-thm-be.so: vdso.S vdso.ld Makefile.vdso
+	$(CROSS_CC) $(LDFLAGS) -mbig-endian -mthumb vdso.S -o $@
diff --git a/linux-user/arm/meson.build b/linux-user/arm/meson.build
index 5a93c925cf..66072411d6 100644
--- a/linux-user/arm/meson.build
+++ b/linux-user/arm/meson.build
@@ -5,3 +5,21 @@ syscall_nr_generators += {
                    arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
                    output: '@BASENAME@_nr.h')
 }
+
+# ??? There does not seem to be a way to do
+#   when: ['TARGET_ARM', !'TARGET_WORDS_BIGENDIAN']
+# so we'd need to add TARGET_WORDS_LITTLEENDIAN.
+# In the meantime, build both files for arm and armeb.
+
+gen = [
+  gen_vdso.process('vdso-arm-be.so',
+                   extra_args: ['-s', 'sigreturn_codes', '-p', 'vdso_arm']),
+  gen_vdso.process('vdso-arm-le.so',
+                   extra_args: ['-s', 'sigreturn_codes', '-p', 'vdso_arm']),
+  gen_vdso.process('vdso-thm-be.so',
+                   extra_args: ['-s', 'sigreturn_codes', '-p', 'vdso_thm']),
+  gen_vdso.process('vdso-thm-le.so',
+                   extra_args: ['-s', 'sigreturn_codes', '-p', 'vdso_thm']),
+]
+
+linux_user_ss.add(when: 'TARGET_ARM', if_true: gen)
diff --git a/linux-user/arm/vdso-arm-be.so b/linux-user/arm/vdso-arm-be.so
new file mode 100755
index 0000000000000000000000000000000000000000..b642b8e5e9322513c289a75ed431645e5f139475
GIT binary patch
literal 2712
zcmbtWO-x)>6h3eMX<-;D!8UY(kr-3USSe|mXbb}brDm8m6k@H3kH^fwObRn(=Fx(w
zGHNZ=V%vmnn_${S7uFE%!i~zRF|J&&FmZz^O)xQ96Et0@<M-Y7E)Fdl<C*#1x!*bG
z{=9qdIWx08iC)8F$fkJZS+upGLnQdXU-pP}NQ?O4Ymf;10RX;DETT>LT<HFw6yK@?
z3A!U=KzUe&GTMadpSJHG7xBQaA#wN!<#+W8v_>o1M76&W+<PQBBsbS*zOt6vK0o++
z)2_z5O}CP>vp>KW28NtI##*8B_wSgG@8*Y&L*pHdY3Ln50oVyd3YE&A@GnFE1@3`<
z0CflL|0^*pe;$KGc8SzNw}Es1Mwd5%r>i*j*oS@E^k>jk(jb-J(BS@R@uI;qqo#15
zD0o+OB0LW*jN$nae*Yeyj$t4FQuDWxJ#b~9?u+lb^W8W0Jac#7B{9u2=~BT=jTcg<
z&9RJa=O!}S8V_|mW-ew*+UE8wjHay_8PDaXrrS7f6yFylaWpw}(rk|&!YZ)gn;!$~
z#Ha3;uRn&JXTBHUx#~AFyq`|}0Y)E1?UT{$eG%<WAc(+|(10-xJqcZgz6gB{dJ+02
zG|t&r2139JuphPvAjX>m;yD*KnrrJwInQo@``;*C;n1AtGWU}91Hi^M_CDA!{$ugO
zu>A}~s>bO6=bR@nX+0+$E=S&}e>ePI-TB)0cV5^rS93A+LGZ)CCI7tdBkyI;6;2M}
z{4W8Y0DGl3yz1Ipz`p^OfJTXg{cmmf1A$0QkosvKuZ^?-T*o31abf~)OhCuLB~tEe
z`zbiNc+WUDcQ0sM{k2^Fa-FsX*S1h)3%RyXl`RQdQk;I6?#Hv>XTjMfZiC;h;v4PP
z?}t1K>rYgkSAP58RvyEep0qO7NDj9|q|V<lC;?B1?d@cRMkIjt^9;$|{806PoH+t9
zzULFf%_n2c<$h{(Q}+XYwTa+yTETJWC{En~$DLAqnNRQ<YWVg1tU(Yj&yRlAB8bX=
z@>+*GPjFsD{SH{1st1U1;^AX_Jw`h2^w8ru%#BCcacYR+^lwK0Mc6vA8SMX@ULV?A
z-^+SG-1tG*l(_Zi4fLOfLD#n;_%yh#Zx_JRRs1?Q*XQ_CsaPU*YUp&dAgz|Prp1iE
zmW=fu?Uqt*teCN<ig`0tNULgsqHp%}nY{zC{vNY0J|O0i#Idee!aUa7d!lF19E^1(
zdd#Yl;uf$i1?bVDR#m9B6uNC{nyP;iEzL~W)(Es+baYm?@&!91(ezB-n#iS81F_JS
zZAo-2KNZbdrL1GOi;m??rdY}q@>__RmS`qxjux$njG0X%QZtF#nQ2?1v4Q@mW!uHv
z$drw(`A>rLR`-;5pLs#F0$O}-<0)wU+rs-wlmYjStK8uI-UsmBVm#)N%B5j&#__Il
zJmyQg%W;jFU&NOC%{YR&z&zu4YYt>TIQl8kafk66&H9fx=A+8V4)90gx?CIM;ttgB
zz8VY<olmb|yb3tu?l@5E)8oNTpS-I7BY-YDki)R^ed*`=D5C(!=6DYssQ)_jQFNS*
zwj0MfKp4zJEjsRP7#N2$Vg9Hbx~hYqxyO|AlmG4ksBaaI-GCPTzV4jb?86$3B{0+v
l!G999K90$nrS|~Mz%4vJ1GMPz8epi33!VbMrh}kW+&|~zlpz2B

literal 0
HcmV?d00001

diff --git a/linux-user/arm/vdso-arm-le.so b/linux-user/arm/vdso-arm-le.so
new file mode 100755
index 0000000000000000000000000000000000000000..8135c3f39f6a674c296eab150c218395248ecd53
GIT binary patch
literal 2712
zcmbtWO-x)>6h3brGYn-IhHA78E~*mK)G}5ijY)}N_$yVQ4L=dP@G;Chn29jc%sg5!
zRmWOOwLdhWOPgSH;ldhXT(~i^GRB2*fr*VSFttfdjAB9?Ow{rF?t2#>l!b{0zIX0-
z&bjCQynD}^*E)N;48ssDrtB5Xnqge6#3LZVX4xY_`06AkA(-gXSU{Vo@SyvHDp`Sp
zU@AfO0G{hUl+Y%0|6{kD^g4nxI^ZL;pL*Gc2DAyk|9)^2INUcRH@-de_4j*kyfg5}
zBh{Bie`q;#=lEO{z9FyAPnhtXzsva;#tg#N0nIf|!@dJL4^#s&;Lmb7zXbnZ&``1p
z{RtcYQxfQZ5ewiLJ0&8G(9_^t2l)fgX&>hvAM<e=TuYt&UgrL4;XZIZ)D(16!nHDw
zfBKA}ji5hRu{+2%`;g05^^5&;2Quy7d|I>nz4qLNeP28#mUS{+%v-66eCj1@+;*Jo
zq`j^2VDmlZf?d=$uV;QNot%-0Y;J10k$L0ze^Ppm^bHMLP4R=AL}263z)bn~?&rVO
zaIYQ$_+BaQ+6=in^^r**MembQZyss|=b0Qv;4t(A^a<z^^m*v3&<oJ-L$5+FL5G25
zU_ZcjMKNCPm%!<$Q6H&M?`s!q+<!G@TQocyxNNX}09f0`-VGb`Z;c;;?H53e<K<}v
zr(nzh3|h-UM@q5RYtKaAs5u*Xv-;eQ*{bv5w<_NbT?k&RxMW@q%wei3cMJ4~0QX3`
zqARrT0lowl0X2Rs8hm9f7z)LzDybi>2&ov(V*yZeQ86JeCZuBEQc`Md{JHYP!cF7!
z?9EE!%5SC8XSZpa_iXb%TiCOOeYQT>`o!&r5q~@dehQpz;yU<sA75*_b}Jm1zkOf%
z3FUX5+RPIVVp>T%Ihqxt2F+mepo9W^i}%X1XEMcg>pNt6H-z<oVtO~}yAAH%DAp0z
zuWpL4p17R1&#fyicPpW;8>WPne`zDWN^#adim9rQNQ-xYO;wHD`|tWADo#I4sqt3e
zS}ITv7{PksN<?bObwTj*X)oh<g6Q=d;Pv1O=-&z*Ks|b#es6xPlFxwa{b2kcxE9u<
z7eV~>tpM(?Z|A`M_3awCzrIN-^_*Rp>`le<(vXyfv{)T4^d)+av`aBNUa+01Le5I%
z)2f=F=v$rLR#$(bx6|tG=ojm7&(XF-k9D-GYoK$`8cekHbXvZW;uWw>1!!wg^A)O1
zg>IXgrs|)>i!+l>aunJrxH_X-xx8abJUx?3PG(c8fmrCIla%;)ZYrKh7BjBhDY%xC
zcA=Qf=Qa^5Epa<zjTMrUwv|aEQZtD=_Ov7MM1OBQ={SY#=#+!4`R~H_?SA_I{nj@4
zy6dC#Fl_qU!t+9u0QZEu-wmGbeE`3qJTkmT#0c7q<F#Qv)|MuZ^Jwxs5&qN7ID)l|
zw~YCC?}+_q>m#k>o`&tN_pRoABv?bY#<h7i=HvID;CEjO(kpou&$5?~_m|-ObUsiu
zr{|&dZ-gZn3C>0DDd$HS1DKor{J(cVmFPGJOvkYf5D`5o_;lQ>UL4;E?+<YWZ7r&P
zgPaAB;)J%ZAa0i?&^omqQ@hp?w+JKa2Y-`*s`ti<rS||$`2Z96m<>;KzB+J!+;MEk
KRUHJa<Ng85pq0%4

literal 0
HcmV?d00001

diff --git a/linux-user/arm/vdso-thm-be.so b/linux-user/arm/vdso-thm-be.so
new file mode 100755
index 0000000000000000000000000000000000000000..3c519e4b0e99d94b98761c1d22d0b9cd52803535
GIT binary patch
literal 2684
zcmbtWT}+#06h2>nfzeXTGMyNMk*LAZOhV=ojiFEqGZbbAacbg6X+LNqv`hQJz%cC;
zx9R3~p;=<4$<%8%VrJsaVy}$Zh4F$5FJ|-t6Jw0=XPRBO;q$!T_u>a~V?5>Qd7ty1
z_y3$zULF`u89qZc#4it_tqnaQ;niTxC(<MB5=39C#LyoC(6@n$XcGY!dORp4P<J3<
zcV<i|H$AAKO{npC`}>0;KJ;ry5`Bc~cl9c?MhDu2w|^(Ne{f`6mR341J$vie&4_XN
z1M7C~hhX>l^XQ8L<IWgkt-OBw53I+t1)-DBIHR!u-2{|@9YCzSzWx{b>(IBrebB!^
zT|xW*N&?&GIt_P-G(&fRThL7|-v$1hhvSX|PkA_fm9)zGuW0aowfNECn^9AEPZXS0
zy$Ih!3w`*0L@>BJpnW(dxYBk_3VY9GBA<TMU+VvG_XD4Io)*)b&sWQ4Zl;`j!JM{i
zyEtoYYuwlKFLTAJYMVQ<JeAKb%1p5|x6s9T<M?|-h7XL4A2z$=`>+dK_{PV;KJkhC
z{Mq}k^Ud!8_^$e7hX2yspJ42xsCzQn{EwmC3xwf#7#c7pp^re%K%au1hrS5?5;We~
zco%2@R)9UQ#Q-s0%!qF(YP2;+NV(2k0Pnv^648c}zO%eb+V=uKZet&U?fN$M3D~{_
z8a(s#fOE}5ShR(UPSj$@TV9F28d+|BZO4hGlZ~euUJt(!IvqR{c+-E@caDogxc=k7
z3E*BCjDF|Z+rhs8&Hy_l77ZS|5e$W5jbZBh0}LB!2Yv#UfSBVGa(zPD2VEkyPkMg~
z-zneLuCn!(+Zw&GeAKaxJV;$nUH)Ba#8GhFrv7LPzj~qh+B>P(p!WG@3r}FpyR%ky
zvWO_a-hz*Ir6m*zryIQ?&7Ez?Dq9G0_xMhpfV%@!&a<C+05QJiH;9`v#+u8S7Z6o5
z*sm@MJV`4!;)>$b25`iU;&pz5H&UaYaYD{I!xrC&ob?70ILL4CW@;_q3^siRY)<7o
zd>nuD(Z2;F)p)es`Ot#6{wOWZ`3+}$8+wkz){D#F_=olW(B}T0(D&i`kHMzItvSzQ
zytjr`z?pBlh9UMg)v))#|EXcQTxKvm(qD*|rNfqvyqL*nMiS`*{ZcJXS1fz3QZjSp
zys8)|?B>9bnaU*61LjaNBj(`nXkTL398IMT4UCy%iN4_h(^EFwBDJZ=Y%N@#VzjB4
zZBw^YjgxqFan{aGLfaKb7j&yswk?V07fadMVoo*S3!SyI5}z*3#S7VL!Li#F$1-nK
zs>O0?6EX7=w+iM|B|B@Gg*-epleldy*b+}<(($ZqSBjH!Hm>GB3Eo@9DPx~`L399G
z+?bd9U|@VB>{PrkW@~^O;|M1wzB{2AXPA$9q;hEjoPLZ|`mttqyBzZ|zf_KS<C}g2
zbAfrr`PLlB9&ql1qW$*ccbGLEe#}RelRe;D{rX%R{gMvUZ#&FNbUr<a`PN~f-xUWc
zAM|{%vrnGZ{|A899msyzd0zH&f0QYJb8|l2oyvKvzaiSshQ;+`9UzRY_rgK^J)$4p
zg!!&={s=o<;T=<!VbpsD4b<_)H`k)i>#nKIf$Nxl1q}5=b^+WU=VZ<D%ojQX{xP6M
T&({ir$1jY!A#ZCZXyx}eT}OjD

literal 0
HcmV?d00001

diff --git a/linux-user/arm/vdso-thm-le.so b/linux-user/arm/vdso-thm-le.so
new file mode 100755
index 0000000000000000000000000000000000000000..eaf95eaa5505d66ac1fe667e2e7523608933e15c
GIT binary patch
literal 2684
zcmbtWU1%It6h5<?-A&r;W>Z94BT_Y})Mlt5M8Q(B`PrnBpPD8Z5u9vxC)vehr|eGB
zL~7k?Y-<~vhx#H`sE99uT13H@(tQ%?gZL1&4;6jT7ZIsiOA&4SzB_Z{B<4ZzB;TC-
zoqO(?JNMpm?!M5|pEe9bw1nkB(X0)|l^7l&iL}X1iJ-4hk`jf9eH!P{CTe`>@t{ho
z=pYzM5IuzF%>XKB6MFoCAKctcIB9gFkI?<pD*-g4O$7UI0}lhegQIfk?5%hIxN^!_
zj>O*C{`FTKU$&O-O`vboAM-sX{QIp{Cy94PVC#nFH_pSp1=<0&0!iS{)m5j8{=cB1
z<QnuxZ2V72VZ4J6sD<7p_0j@ugY*65w?jW2;9TP;0^A1I(kQ>Ia(%UM9r!)e6bw_s
zZ)Kd|^yxzz!Tw0ijtJWvLoSz_E(|a4$#;G6NqooKUB%P8KD}QoYc5xItn9Rteb$<?
zUAHh}Z)$9B`<J<7m$l6w=}hJ_3o>0O&d#?mu8IGLrGNk6=$O@NwsR7pwLb$h<=<PE
zevWg`?*h256z|&%xiR~Gn0*wzPDWGsu?}#a$uT&NK~F#*f}Vyx2|WjW9{MQsHRyBD
zwZH{nH^B2iF`gTi(2<1ER38_<XFI_4=iW&wQF|hE#-M!<@FTF%-Ur*&P3+^aeGc$U
z=s0a`L-5XncxeM)I$lX0Yj`p7Qhc%g<*moJoTxil`%3Io^mJsY=GE|-&@!f~=Cv34
zIB+*0y@~H=-wAvMECFhbl8MOk*CWwrvMxq_Urki`{Dl4^fcj?T6ZL(f$_HIaDj#?J
z8oNWjtz2a5tlt{CzIfQP4L(3!O@Hv4REWdix=sDw27d94`pd7UlfByKn+-g5CtjPe
zGZO_dIJd|nEdvsb#|G+xr`nqvpDTVdtWJlwPc()7EMU%i+{>0LYuw8k)(Wp*WrMJ0
zc$^vL)eet))lS!ju(yj+UGuL~{;YAHzd9AN*H6;0syHGC{A3NI1_UK6asLZEYYlRq
z9@<~v-$1UD-jAna(0?0<t`i1$6ZkQ_uLC-S@ei@zpC3={K5)Gr^dAA&!kY68NU(;L
zz=Ji6XD?X8-UJWUFv(_n+uiw@5z~=oSDJHTbw4$j8ra_@<-%0Sc4tdPE9>M`#Xw=V
zdit#NaB85(>gygBtG9osGu3YmrPBv{My!!kXMc|sC>wr}T32K?7Op@sT35_AsavYX
ziCJElaWfOpZpqVm-6}e+EoN?^n3*YLRRg}z88;*5RB_hKXUcic?v^~uoLwpxoZ>oS
z<;1k})?_I&V_W$gJT(*3wdY+iQ^Nyh#&t`DiCGs*^WTO0?OpHx+^5Zf;r`K+dtlS|
z2hR&p0lX9L-3_c!y8zykJTlB9VjOMyF>M%+Ioj%T9!;JnB6zy#N3dQo%NUP&N9;yh
zA8GCPC~P<U`<VGiuug9D>-24m$2*?j-L3`Ul{}8;svnQ}OK^TV9;lkrlhFEiKov%U
zbJ1(c`B5eT#^$)-ZyHb~+Rp{keyjsTy`B{MwBJ$Rk9)#=Ck~;lMb&7KMF1hzx~lNw
zo@>#e^*gowD*SlIv3~G(2dLUNRxG^+Xvz{M@F5$%=y;9bLBD-ikk_;mwD$WOF-L=H

literal 0
HcmV?d00001

diff --git a/linux-user/arm/vdso.S b/linux-user/arm/vdso.S
new file mode 100644
index 0000000000..57e405d453
--- /dev/null
+++ b/linux-user/arm/vdso.S
@@ -0,0 +1,193 @@
+/*
+ * arm linux replacement vdso.
+ *
+ * Copyright 2023 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <asm/unistd.h>
+
+	.text
+	.eabi_attribute Tag_FP_arch, 0
+
+#ifdef __thumb__
+	.thumb
+	.arch	armv7-m
+	.eabi_attribute Tag_ARM_ISA_use, 0
+	.eabi_attribute Tag_CPU_arch, 13 /* TAG_CPU_ARCH_V7_M */
+
+.macro	raw_syscall n
+	.ifne \n < 0x100
+	mov	r7, #\n
+	.else
+	ldr	r7, =\n
+	.endif
+	swi	#0
+.endm
+
+.macro	fdpic_thunk ofs
+	ldr	r3, [sp, #\ofs]
+	ldmia	r2, {r2, r3}
+	mov	r9, r3
+	bx	r2
+.endm
+
+#else
+	.arm
+	.arch	armv4t
+	.eabi_attribute Tag_THUMB_ISA_use, 0
+
+.macro	raw_syscall n
+	.ifne \n < 0x100
+	mov	r7, #\n
+	.else
+	mov	r7, #(\n & 0xff)
+	orr	r7, r7, #(\n & 0xff00)
+	.endif
+	svc	#(\n | __NR_OABI_SYSCALL_BASE)
+.endm
+
+.macro	fdpic_thunk ofs
+	ldr	r3, [sp, #\ofs]
+	ldmia	r3, {r3, r9}
+	bx	r3
+.endm
+
+#endif
+
+.macro	endf name
+	.globl	\name
+	.type	\name, %function
+	.size	\name, . - \name
+.endm
+
+/*
+ * We must save/restore r7 for the EABI syscall number.
+ * While we're doing that, we might as well save LR to get a free return,
+ * and a branch that is interworking back to ARMv5.
+ */
+
+.macro SYSCALL name, nr
+\name:
+	.cfi_startproc
+	push	{r7, lr}
+	.cfi_adjust_cfa_offset 8
+	.cfi_offset r7, -8
+	.cfi_offset lr, -4
+	raw_syscall \nr
+	pop	{r7, pc}
+	.cfi_endproc
+endf \name
+.endm
+
+SYSCALL	__vdso_clock_gettime, __NR_clock_gettime
+SYSCALL __vdso_clock_gettime64, __NR_clock_gettime64
+SYSCALL __vdso_clock_getres, __NR_clock_getres
+SYSCALL __vdso_gettimeofday, __NR_gettimeofday
+
+
+/*
+ * We, like the real kernel, use a table of sigreturn trampolines.
+ * Unlike the real kernel, we do not attempt to pack this into as
+ * few bytes as possible -- simply use 16 bytes per slot.
+ *
+ * Within each slot, use the exact same code sequence as the kernel,
+ * lest we trip up someone doing code inspection.
+ */
+
+/* offsetof(struct sigframe, retcode[3]) */
+#define SIGFRAME_RC3_OFFSET     756
+#define RT_SIGFRAME_RC3_OFFSET  884
+
+.macro	slot n
+	.balign	16
+	.org	sigreturn_codes + 16 * \n
+.endm
+
+/*
+ * Start the unwind info at least one instruction before the signal
+ * trampoline, because the unwinder will assume we are returning
+ * after a call site.
+ */
+	.cfi_startproc simple
+	.cfi_signal_frame
+	.cfi_return_column 15
+
+	.cfi_def_cfa	sp, 32 + 64
+	.cfi_offset	r0, -16 * 4
+	.cfi_offset	r1, -15 * 4
+	.cfi_offset	r2, -14 * 4
+	.cfi_offset	r3, -13 * 4
+	.cfi_offset	r4, -12 * 4
+	.cfi_offset	r5, -11 * 4
+	.cfi_offset	r6, -10 * 4
+	.cfi_offset	r7, -9 * 4
+	.cfi_offset	r8, -8 * 4
+	.cfi_offset	r9, -7 * 4
+	.cfi_offset	r10, -6 * 4
+	.cfi_offset	r11, -5 * 4
+	.cfi_offset	r12, -4 * 4
+	.cfi_offset	r13, -3 * 4
+	.cfi_offset	r14, -2 * 4
+	.cfi_offset	r15, -1 * 4
+
+	nop
+
+	.balign	16
+sigreturn_codes:
+	/* [EO]ABI sigreturn */
+	slot	0
+	raw_syscall __NR_sigreturn
+
+	.cfi_def_cfa_offset 160 + 64
+
+	/* [EO]ABI rt_sigreturn */
+	slot	1
+	raw_syscall __NR_rt_sigreturn
+
+	.cfi_endproc
+
+	.macro cfi_fdpic_pc ofs
+	/*
+	 * fd = *(r13 + ofs)
+         * pc = *fd
+	 *
+	 * DW_CFA_expression lr (14), length (5),
+	 *   DW_OP_breg13, ofs, DW_OP_deref, DW_OP_deref
+         */
+	.cfi_escape 0x10, 14, 5, 0x7d, (\ofs & 0x7f) + 0x80, (\ofs >> 7), 0x06, 0x06
+	.endm
+
+	.macro cfi_fdpic_r9 ofs
+	/*
+	 * fd = *(r13 + ofs)
+         * r9 = *(fd + 4)
+	 *
+	 * DW_CFA_expression r9, length (7),
+	 *   DW_OP_breg13, ofs, DW_OP_deref,
+	 *   DW_OP_plus_uconst, 4, DW_OP_deref
+         */
+	.cfi_escape 0x10, 9, 7, 0x7d, (\ofs & 0x7f) + 0x80, (\ofs >> 7), 0x06, 0x23, 4, 0x06
+	.endm
+
+	/* FDPIC sigreturn */
+	.cfi_startproc
+	cfi_fdpic_pc SIGFRAME_RC3_OFFSET
+	cfi_fdpic_r9 SIGFRAME_RC3_OFFSET
+
+	slot	2
+	fdpic_thunk SIGFRAME_RC3_OFFSET
+	.cfi_endproc
+
+	/* FDPIC rt_sigreturn */
+	.cfi_startproc
+	cfi_fdpic_pc RT_SIGFRAME_RC3_OFFSET
+	cfi_fdpic_r9 RT_SIGFRAME_RC3_OFFSET
+
+	slot	3
+	fdpic_thunk RT_SIGFRAME_RC3_OFFSET
+	.cfi_endproc
+
+	.balign	16
+endf sigreturn_codes
diff --git a/linux-user/arm/vdso.ld b/linux-user/arm/vdso.ld
new file mode 100644
index 0000000000..3b00adf27a
--- /dev/null
+++ b/linux-user/arm/vdso.ld
@@ -0,0 +1,67 @@
+/*
+ * Linker script for linux arm replacement vdso.
+ *
+ * Copyright 2023 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+VERSION {
+        LINUX_2.6 {
+        global:
+                __vdso_clock_gettime;
+                __vdso_gettimeofday;
+                __vdso_clock_getres;
+                __vdso_clock_gettime64;
+
+        local: *;
+        };
+}
+
+
+PHDRS {
+        phdr            PT_PHDR         FLAGS(4) PHDRS;
+        load            PT_LOAD         FLAGS(7) FILEHDR PHDRS; /* FLAGS=RWX */
+        dynamic         PT_DYNAMIC      FLAGS(4);
+        eh_frame_hdr    PT_GNU_EH_FRAME;
+        note            PT_NOTE         FLAGS(4);
+}
+
+SECTIONS {
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
+        .text           : { *(.text*) }         :load
+}
-- 
2.34.1


