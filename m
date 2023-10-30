Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D92A37DC1B6
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:18:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZeL-0001Lo-V4; Mon, 30 Oct 2023 17:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdy-00012C-VN
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:55 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdt-0006WM-84
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:54 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2800229592aso3267668a91.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 14:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698700665; x=1699305465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ztySwLt09Xrx/3uH1inQuLgToI8Xa096x+QRO+kFx8=;
 b=oFoVFsniRJ+vBg01Hdtfm1ubpms0zJuNWAhyL8MdS6La/4NaPR1hAO6ZgILcqiRO+x
 tF8ulgnMMBPbPe/0Ier6f6q291P6WjDIBk+CMQ3+n/6Z2mH5bYESRf6in6LF05YVaecw
 mvSTX7+MpnSDrLdqGRsw/dugDFz3CzPcXSGYKDk5+71HxhgQ7Sa7mLHnI3vR+N4Hp4zm
 Oqr5JqPBTnL0hy4NRPW/9cVJsppUZRR2Se8cfi09rofCP9SAugH3joc3KoHrkwX+GLKS
 RqluBkXWtuodEHcrXZUd8QBKu/gRkyOjkHEfT3Wkgto1rxztxoTC/0WxWvaTT7oCB3zl
 oprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698700665; x=1699305465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ztySwLt09Xrx/3uH1inQuLgToI8Xa096x+QRO+kFx8=;
 b=fb92QOEzy3q0+vBuE5SfLDVubtJ6CIFAaNbqBi7YOYg3pl1V8jVI6LOSmJgujGt5vQ
 D5GhOS46L/ajo+J5PjhqeQb/RspExYh9ovTgZ2zaA6XXWdGF2OKGFrpHHXqfAXKb1hCI
 9yd1PxiaL+N6liX4JaFkdqiuSw+Bkq/PO88zZK9CObxg5MymAzgJ9GPYtVentHJzpUfO
 k2USv4044b36rDwQ27sA+FaQQ4dko3UJ0XCCjx9jvwyWOCEITic8PTs2lamfu79YjXNk
 TUZqaTddbSODa0rS0RUOsASnTwL59h77VhRN6Myxzlac2WkxkjwBDLmPmYLgAPuJy6/K
 bU0Q==
X-Gm-Message-State: AOJu0YxH9qhMfrpcPpxFlcBXODjChGSU0svIK45eCPRXpYZpOeVEyy+c
 HjCNTL7UYDTAho0uPiuYjc6t2e6XSHhYAYDnfTY=
X-Google-Smtp-Source: AGHT+IHdpzkJwnC87MlRX9cS3qqj6qc6byzoZRZxwFoSkeHfp1z7cgGDRebVYUQCgf4oCtrcvDrQVw==
X-Received: by 2002:a17:902:ff02:b0:1cc:1490:e7bf with SMTP id
 f2-20020a170902ff0200b001cc1490e7bfmr7136727plj.30.1698700665566; 
 Mon, 30 Oct 2023 14:17:45 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf2-20020a170903268200b001cc32261bdfsm4670350plb.38.2023.10.30.14.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:17:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/21] linux-user/s390x: Add vdso
Date: Mon, 30 Oct 2023 14:17:25 -0700
Message-Id: <20231030211727.165090-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030211727.165090-1-richard.henderson@linaro.org>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/s390x/vdso-asmoffset.h |   2 +
 linux-user/elfload.c              |   2 +
 linux-user/s390x/signal.c         |   4 +-
 linux-user/s390x/Makefile.vdso    |  11 +++++
 linux-user/s390x/meson.build      |   6 +++
 linux-user/s390x/vdso.S           |  61 +++++++++++++++++++++++++
 linux-user/s390x/vdso.ld          |  72 ++++++++++++++++++++++++++++++
 linux-user/s390x/vdso.so          | Bin 0 -> 3464 bytes
 8 files changed, 155 insertions(+), 3 deletions(-)
 create mode 100644 linux-user/s390x/vdso-asmoffset.h
 create mode 100644 linux-user/s390x/Makefile.vdso
 create mode 100644 linux-user/s390x/vdso.S
 create mode 100644 linux-user/s390x/vdso.ld
 create mode 100755 linux-user/s390x/vdso.so

diff --git a/linux-user/s390x/vdso-asmoffset.h b/linux-user/s390x/vdso-asmoffset.h
new file mode 100644
index 0000000000..27a062d6c1
--- /dev/null
+++ b/linux-user/s390x/vdso-asmoffset.h
@@ -0,0 +1,2 @@
+/* Minimum stack frame size */
+#define STACK_FRAME_OVERHEAD    160
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 26602516aa..a1583883fa 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1894,6 +1894,8 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE 4096
 
+#define VDSO_HEADER "vdso.c.inc"
+
 #endif /* TARGET_S390X */
 
 #ifdef TARGET_RISCV
diff --git a/linux-user/s390x/signal.c b/linux-user/s390x/signal.c
index 0f8b8e04bf..b40f738a70 100644
--- a/linux-user/s390x/signal.c
+++ b/linux-user/s390x/signal.c
@@ -21,14 +21,12 @@
 #include "user-internals.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
+#include "vdso-asmoffset.h"
 
 #define __NUM_GPRS 16
 #define __NUM_FPRS 16
 #define __NUM_ACRS 16
 
-/* Minimum stack frame size */
-#define STACK_FRAME_OVERHEAD    160
-
 #define _SIGCONTEXT_NSIG        64
 #define _SIGCONTEXT_NSIG_BPW    64 /* FIXME: 31-bit mode -> 32 */
 #define _SIGCONTEXT_NSIG_WORDS  (_SIGCONTEXT_NSIG / _SIGCONTEXT_NSIG_BPW)
diff --git a/linux-user/s390x/Makefile.vdso b/linux-user/s390x/Makefile.vdso
new file mode 100644
index 0000000000..e82bf9e29f
--- /dev/null
+++ b/linux-user/s390x/Makefile.vdso
@@ -0,0 +1,11 @@
+include $(BUILD_DIR)/tests/tcg/s390x-linux-user/config-target.mak
+
+SUBDIR = $(SRC_PATH)/linux-user/s390x
+VPATH += $(SUBDIR)
+
+all: $(SUBDIR)/vdso.so
+
+$(SUBDIR)/vdso.so: vdso.S vdso.ld vdso-asmoffset.h
+	$(CC) -o $@ -nostdlib -shared -Wl,-h,linux-vdso64.so.1 \
+	  -Wl,--build-id=sha1 -Wl,--hash-style=both \
+	  -Wl,-T,$(SUBDIR)/vdso.ld $<
diff --git a/linux-user/s390x/meson.build b/linux-user/s390x/meson.build
index 0781ccea1d..a7a25ed9ce 100644
--- a/linux-user/s390x/meson.build
+++ b/linux-user/s390x/meson.build
@@ -3,3 +3,9 @@ syscall_nr_generators += {
                      arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
                      output: '@BASENAME@_nr.h')
 }
+
+vdso_inc = gen_vdso.process('vdso.so', extra_args: [
+                                '-s', '__kernel_sigreturn',
+                                '-r', '__kernel_rt_sigreturn'
+                            ])
+linux_user_ss.add(when: 'TARGET_S390X', if_true: vdso_inc)
diff --git a/linux-user/s390x/vdso.S b/linux-user/s390x/vdso.S
new file mode 100644
index 0000000000..3332492477
--- /dev/null
+++ b/linux-user/s390x/vdso.S
@@ -0,0 +1,61 @@
+/*
+ * s390x linux replacement vdso.
+ *
+ * Copyright 2023 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <asm/unistd.h>
+#include "vdso-asmoffset.h"
+
+.macro endf name
+	.globl	\name
+	.type	\name, @function
+	.size	\name, . - \name
+.endm
+
+.macro raw_syscall n
+        .ifne	\n < 0x100
+	svc	\n
+	.else
+	lghi	%r1, \n
+	svc	0
+        .endif
+.endm
+
+.macro vdso_syscall name, nr
+\name:
+	.cfi_startproc
+	aghi	%r15, -(STACK_FRAME_OVERHEAD + 16)
+	.cfi_adjust_cfa_offset STACK_FRAME_OVERHEAD + 16
+	stg	%r14, STACK_FRAME_OVERHEAD(%r15)
+	.cfi_rel_offset %r14, STACK_FRAME_OVERHEAD
+	raw_syscall \nr
+	lg	%r14, STACK_FRAME_OVERHEAD(%r15)
+	aghi	%r15, STACK_FRAME_OVERHEAD + 16
+	.cfi_restore %r14
+	.cfi_adjust_cfa_offset -(STACK_FRAME_OVERHEAD + 16)
+	br	%r14
+	.cfi_endproc
+endf	\name
+.endm
+
+vdso_syscall __kernel_gettimeofday, __NR_gettimeofday
+vdso_syscall __kernel_clock_gettime, __NR_clock_gettime
+vdso_syscall __kernel_clock_getres, __NR_clock_getres
+vdso_syscall __kernel_getcpu, __NR_getcpu
+
+/*
+ * TODO unwind info, though we're ok without it.
+ * The kernel supplies bogus empty unwind info, and it is likely ignored
+ * by all users.  Without it we get the fallback signal frame handling.
+ */
+
+__kernel_sigreturn:
+	raw_syscall __NR_sigreturn
+endf	__kernel_sigreturn
+
+__kernel_rt_sigreturn:
+	raw_syscall __NR_rt_sigreturn
+endf	__kernel_rt_sigreturn
diff --git a/linux-user/s390x/vdso.ld b/linux-user/s390x/vdso.ld
new file mode 100644
index 0000000000..d3f1d1b164
--- /dev/null
+++ b/linux-user/s390x/vdso.ld
@@ -0,0 +1,72 @@
+/*
+ * Linker script for linux s390x replacement vdso.
+ *
+ * Copyright 2023 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+VERSION {
+        LINUX_2.6.29 {
+        global:
+                __kernel_gettimeofday;
+                __kernel_clock_gettime;
+                __kernel_clock_getres;
+                __kernel_getcpu;
+                __kernel_rt_sigreturn;
+                __kernel_sigreturn;
+                /*
+                 * QEMU handles syscall restart internally, so we don't
+                 * need the __kernel_restart_syscall entry point.
+                 */
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
diff --git a/linux-user/s390x/vdso.so b/linux-user/s390x/vdso.so
new file mode 100755
index 0000000000000000000000000000000000000000..64130f6f335269b03291653d006225b365be9cd9
GIT binary patch
literal 3464
zcmcguUuaup6hAlrn#R#}B6HHJ6^h8v3s#wtDI{HzWs-HJcB~u1U2JZX*fw`0w>2I9
z>4SqkSsXs>VMq|PDvEm&1Rwf1RK!O?(CHKhzDz`4)-9g%edpXip_vbYU-<6tJHK<z
zcW%!8&bjyXe5nwL7~qX4?8S9}P@0U^51wZ!4ROf8FziM-fitG{$m!98#y(98LK0<)
zF`)T=*Tk6C2o94N!O8KAbs})9bp<|Z(f=FCiu>y{lI$0|t_^w-9%V;CvX_ZVV@~UP
z5ysh1P<-w|K6-fSIDGtl`ke<)|Mc0}bJcWb@yj2!fBy7s_8}PJ^{b5Jk0Yw$Io;cT
zvAm@bv#$o5>1TjUWL@)+V!Xt77o&O(PPe<Q<=ACHly9+~a!c|JEyu*4)&DD)cLVIw
z5#zsb<Wa;~pHGlXgYG*Q;1!7%(pLlg1FRr>!{_5F56Dq|HugaG54H=!y#f0xtl;=^
z{(|Oe9c6~jI}MdzM5-AY|8oAd5niPp<$=q-bPi}udYXw&GFgmg;C+@!7ys^{eeuHj
z*T4PgtbX)Xd*k=9hda69Q>Wkk@x$ybu&hP9*|3+as_nY<W!qV(l-GQAe#x0%6x|MV
z({A}JZZUsm#g|+4YSVUCnhl?7x|Yu_)f+4A$5tyX=fIO@%P}8^(vhj-bJm1;z?^s*
zZyoa${1Id5U*x4{=^0Ud(KFC>Lm7yGF<^c5IqMK$gD%EM^dJJ&HRX_=UlHe3oHd-=
zIM1UMJ^v4I(xAP;I6DJId&n5swY$R)f#T6@<J<?ip>HFFH}{sl84Bv3LERZ;$NK58
z{sq)6-9i5f>gc{kWq<MCyxE<;cJ)RF##2)YW1BbO^1yAM-@MO=rJ%1aeh1xCVO{Fw
z)F*fkeFq*cPKoqGZHhdf^Ke}tPv;Sb*Qb<(B%kYOMiG2Lp8K5cgQ7#8>nFM;93k>t
zPf{jYi+obAVwW^}{2=pE|4KxA?w|60@a(yd##JBHtcojrD!7kfczq<42ikk5{qOhf
zLwR_@?>o{q)cHH)^P&ED(&rPwe&_gnsNbFI)9)_$_Mtxep3ldxa1KVn%AK6b9zAjh
zOC8^LR=#KzX0k`~RxvjN*5T5z$!y6wRwz85pS5PQlcl`n_k`ZI;q{zQa|v~hox4`3
zdw3>(zwsz90(Cq9v$eMDmS044n;L7fYB;V9W@W8WUarrp1==E(-7=Wf#)?@hw`!Vq
zo0?g*o2|Oj2nkjNOuJ?+G|S7jRjZ(-NMO2l+m)mAUvLDS<$WUcH>WrB>T|p&K(J6A
zLY*8iECCvFZapMYV$hoF3cmya_T!ZA42~~#E(lv_L;l=1Jb$XEi2%>>r49tu`x(u=
zA@PZzo*QQk$Cth#sCp{ztt`c#Fpb|mfA{!rX*tRW8I*VOC$q_bj^j&u1tHXb&|dOD
z{?B3jE-i3~KihkKi}D<d&vwfGMDKSTwpH#&f{;dk%D?!@|3?ZIaLWBi{OhE^eHgv(
zV@-Q~TZwdtd;FzO3c^KkWDLfCE#RNfdg)Vw>YW<g!b>ds%Kr-5;5sp;iO3^}^sP;K
oq#^O?{L#B0m|N2GNEUhVg)ofre@WbfvycCv+~*tYC*b-21AbI{0ssI2

literal 0
HcmV?d00001

-- 
2.34.1


