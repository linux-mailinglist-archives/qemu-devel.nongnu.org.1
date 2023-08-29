Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E16E678CFE5
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:07:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7ml-0000dp-Vp; Tue, 29 Aug 2023 19:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nR-0002R1-CV
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:51 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nK-00049W-J9
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:47 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68bed286169so4216993b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 15:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693346561; x=1693951361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kee2mUckLTu0r5fI4Zox2tGZrq73NQtpZRaUibEwLSc=;
 b=NYnRP5kgztaNlnwcyCgcHQG+7Kf9dqNM2RU6nuI8jFAQEc6ZbfWK9l/RuzuvGHbbZ8
 fY3UvlySFCPAxQ8owMfc16ZlqYIdkmVDOZs6VTN4/U+SoOQNDRHoCCa9wiNB1b0wy4C8
 uxrHh26glr59o4jW0Sup64YkWB7QVeWloKz1btc1tFVeerAS3VcJXdSYFrjxdddPGMuu
 x37IwV1RuAH3n/I3Gzpw7r1tREW9Ob0FylBukklXjfudHTo0URwIvqE2xNHFqba/84iB
 hVDMbdwY5RwNzPFBVjfSv3troo1nMYWOPgqKP5+MyX3LMmaY7t8FPfc3APm/QKQn2tgM
 epEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693346561; x=1693951361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kee2mUckLTu0r5fI4Zox2tGZrq73NQtpZRaUibEwLSc=;
 b=jsCrgbIgGdyge8xNdBpajcuiuhgEgG5bTAXarKQ0WVvcoFenqhiWH+rn7L1EXpaDme
 9+O8U8vDMdUj57KgxzT9SzQQY0G9wRdg8y0XtZmWn1i2wJH5+F9uBenCGVb5yB6NGsae
 a72zSdYYKFvTYEKhlqIJMYQ6JOrGTQXbspnm/sSLNI1XqkXfz86/K213SjkQot4Bn8V+
 84BZ/DTCayQw84Gv1J/8ehDG9Thlvl836fFaBKRtb4bHj8V4BHZdfAWGaYB3r6TVoqWp
 DRFHCpYyqNUU/Uob+C/VWbVPB1TC1spjI1wURWaLfvv1QWPpk0If7tYZQCV2sajxpzZ0
 j7Kw==
X-Gm-Message-State: AOJu0Yykg0o2V75hxdhJwh0uuHOlNg+0aW3u8O/5lCi2zZeVFNZ9hJo3
 2BghY47qVC+UrV9Stp5tSsYKAmLuT3aoLy5hfbc=
X-Google-Smtp-Source: AGHT+IGE0r81mPNxATsiulAv+zUirOuvtzw8Hqc04791kFA3YYhsEm24CL3xvxNq3BALktgEb0QiSg==
X-Received: by 2002:a05:6a00:3903:b0:68c:3f2:6000 with SMTP id
 fh3-20020a056a00390300b0068c03f26000mr517468pfb.6.1693346560823; 
 Tue, 29 Aug 2023 15:02:40 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 b28-20020a63715c000000b0056606274e54sm9538196pgn.31.2023.08.29.15.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 15:02:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	laurent@vivier.eu
Subject: [PATCH v5 11/20] linux-user/i386: Add vdso
Date: Tue, 29 Aug 2023 15:02:19 -0700
Message-Id: <20230829220228.928506-12-richard.henderson@linaro.org>
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

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1267
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/vdso-asmoffset.h |   6 ++
 linux-user/elfload.c             |  16 +++-
 linux-user/i386/signal.c         |  11 +++
 linux-user/i386/meson.build      |  24 ++++++
 linux-user/i386/vdso.S           | 143 +++++++++++++++++++++++++++++++
 linux-user/i386/vdso.ld          |  76 ++++++++++++++++
 linux-user/i386/vdso.so          | Bin 0 -> 2672 bytes
 7 files changed, 274 insertions(+), 2 deletions(-)
 create mode 100644 linux-user/i386/vdso-asmoffset.h
 create mode 100644 linux-user/i386/vdso.S
 create mode 100644 linux-user/i386/vdso.ld
 create mode 100755 linux-user/i386/vdso.so

diff --git a/linux-user/i386/vdso-asmoffset.h b/linux-user/i386/vdso-asmoffset.h
new file mode 100644
index 0000000000..4e5ee0dd49
--- /dev/null
+++ b/linux-user/i386/vdso-asmoffset.h
@@ -0,0 +1,6 @@
+/*
+ * offsetof(struct sigframe, sc.eip)
+ * offsetof(struct rt_sigframe, uc.tuc_mcontext.eip)
+ */
+#define SIGFRAME_SIGCONTEXT_eip      64
+#define RT_SIGFRAME_SIGCONTEXT_eip  220
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 2a6adebb4a..fb876ae30a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -309,12 +309,24 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
     (*regs)[15] = tswapreg(env->regs[R_ESP]);
     (*regs)[16] = tswapreg(env->segs[R_SS].selector & 0xffff);
 }
-#endif
+
+/*
+ * i386 is the only target which supplies AT_SYSINFO for the vdso.
+ * All others only supply AT_SYSINFO_EHDR.
+ */
+#define DLINFO_ARCH_ITEMS 1
+#define ARCH_DLINFO       NEW_AUX_ENT(AT_SYSINFO, vdso_info->entry);
+
+#include "vdso.c.inc"
+
+#define vdso_image_info()    &vdso_image_info
+
+#endif /* TARGET_X86_64 */
 
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
-#endif
+#endif /* TARGET_I386 */
 
 #ifdef TARGET_ARM
 
diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 60fa07d6f9..bc5d45302e 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -214,6 +214,17 @@ struct rt_sigframe {
 };
 #define TARGET_RT_SIGFRAME_FXSAVE_OFFSET (                                 \
     offsetof(struct rt_sigframe, fpstate) + TARGET_FPSTATE_FXSAVE_OFFSET)
+
+/*
+ * Verify that vdso-asmoffset.h constants match.
+ */
+#include "i386/vdso-asmoffset.h"
+
+QEMU_BUILD_BUG_ON(offsetof(struct sigframe, sc.eip)
+                  != SIGFRAME_SIGCONTEXT_eip);
+QEMU_BUILD_BUG_ON(offsetof(struct rt_sigframe, uc.tuc_mcontext.eip)
+                  != RT_SIGFRAME_SIGCONTEXT_eip);
+
 #else
 
 struct rt_sigframe {
diff --git a/linux-user/i386/meson.build b/linux-user/i386/meson.build
index ee523019a5..d858bf1d77 100644
--- a/linux-user/i386/meson.build
+++ b/linux-user/i386/meson.build
@@ -3,3 +3,27 @@ syscall_nr_generators += {
                     arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
                     output: '@BASENAME@_nr.h')
 }
+
+vdso_so = custom_target(output: 'vdso.so',
+                        input: files('vdso.S', 'vdso.ld'),
+                        depend_files: files('vdso-asmoffset.h'),
+                        command: [
+                            build_vdso_cmd,
+                            '-B', meson.project_build_root(),
+                            '-C', meson.current_source_dir(),
+                            '-T', 'i386-linux-user',
+                            '-o', '@OUTPUT@',
+	                    '--', '-m32', '-nostdlib', '-shared',
+	                    '-Wl,-h,linux-gate.so.1',
+                            '-Wl,--build-id=sha1',
+                            '-Wl,--hash-style=both',
+                            '-Wl,-T,@INPUT1@',
+                            '@INPUT0@'
+                        ])
+
+vdso_inc = gen_vdso.process(vdso_so, extra_args: [
+                                '-s', '__kernel_sigreturn',
+                                '-r', '__kernel_rt_sigreturn'
+                            ])
+
+linux_user_ss.add(when: 'TARGET_I386', if_true: vdso_inc)
diff --git a/linux-user/i386/vdso.S b/linux-user/i386/vdso.S
new file mode 100644
index 0000000000..e7a1f333a1
--- /dev/null
+++ b/linux-user/i386/vdso.S
@@ -0,0 +1,143 @@
+/*
+ * i386 linux replacement vdso.
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
+.macro vdso_syscall1 name, nr
+\name:
+	.cfi_startproc
+	mov	%ebx, %edx
+	.cfi_register %ebx, %edx
+	mov	4(%esp), %ebx
+	mov	$\nr, %eax
+	int	$0x80
+	mov	%edx, %ebx
+	ret
+	.cfi_endproc
+endf	\name
+.endm
+
+.macro vdso_syscall2 name, nr
+\name:
+	.cfi_startproc
+	mov	%ebx, %edx
+	.cfi_register %ebx, %edx
+	mov	4(%esp), %ebx
+	mov	8(%esp), %ecx
+	mov	$\nr, %eax
+	int	$0x80
+	mov	%edx, %ebx
+	ret
+	.cfi_endproc
+endf	\name
+.endm
+
+.macro vdso_syscall3 name, nr
+\name:
+	.cfi_startproc
+	push	%ebx
+	.cfi_adjust_cfa_offset 4
+	.cfi_rel_offset %ebx, 0
+	mov	8(%esp), %ebx
+	mov	12(%esp), %ecx
+	mov	16(%esp), %edx
+	mov	$\nr, %eax
+	int	$0x80
+	pop	%ebx
+	.cfi_adjust_cfa_offset -4
+	.cfi_restore %ebx
+	ret
+	.cfi_endproc
+endf	\name
+.endm
+
+__kernel_vsyscall:
+	.cfi_startproc
+	int	$0x80
+	ret
+	.cfi_endproc
+endf	__kernel_vsyscall
+
+vdso_syscall2 __vdso_clock_gettime, __NR_clock_gettime
+vdso_syscall2 __vdso_clock_gettime64, __NR_clock_gettime64
+vdso_syscall2 __vdso_clock_getres, __NR_clock_getres
+vdso_syscall2 __vdso_gettimeofday, __NR_gettimeofday
+vdso_syscall1 __vdso_time, __NR_time
+vdso_syscall3 __vdso_getcpu, __NR_gettimeofday
+
+/*
+ * Signal return handlers.
+ */
+
+	.cfi_startproc simple
+	.cfi_signal_frame
+
+/*
+ * For convenience, put the cfa just above eip in sigcontext, and count
+ * offsets backward from there.  Re-compute the cfa in the two contexts
+ * we have for signal unwinding.  This is far simpler than the
+ * DW_CFA_expression form that the kernel uses, and is equally correct.
+ */
+
+	.cfi_def_cfa	%esp, SIGFRAME_SIGCONTEXT_eip + 4
+
+	.cfi_offset	%eip, -4
+			/* err, -8 */
+			/* trapno, -12 */
+	.cfi_offset	%eax, -16
+	.cfi_offset	%ecx, -20
+	.cfi_offset	%edx, -24
+	.cfi_offset	%ebx, -28
+	.cfi_offset	%esp, -32
+	.cfi_offset	%ebp, -36
+	.cfi_offset	%esi, -40
+	.cfi_offset	%edi, -44
+
+/*
+ * While this frame is marked as a signal frame, that only applies to how
+ * the return address is handled for the outer frame.  The return address
+ * that arrived here, from the inner frame, is not marked as a signal frame
+ * and so the unwinder still tries to subtract 1 to examine the presumed
+ * call insn.  Thus we must extend the unwind info to a nop before the start.
+ */
+	nop
+
+__kernel_sigreturn:
+	popl	%eax	/* pop sig */
+	.cfi_adjust_cfa_offset -4
+	movl	$__NR_sigreturn, %eax
+	int	$0x80
+endf	__kernel_sigreturn
+
+	.cfi_def_cfa_offset RT_SIGFRAME_SIGCONTEXT_eip + 4
+	nop
+
+__kernel_rt_sigreturn:
+	movl	$__NR_rt_sigreturn, %eax
+	int	$0x80
+endf	__kernel_rt_sigreturn
+
+	.cfi_endproc
+
+/*
+ * TODO: Add elf notes.  E.g.
+ *
+ * #include <linux/elfnote.h>
+ * ELFNOTE_START(Linux, 0, "a")
+ *   .long LINUX_VERSION_CODE
+ * ELFNOTE_END
+ *
+ * but what version number would we set for QEMU?
+ */
diff --git a/linux-user/i386/vdso.ld b/linux-user/i386/vdso.ld
new file mode 100644
index 0000000000..326b7a8f98
--- /dev/null
+++ b/linux-user/i386/vdso.ld
@@ -0,0 +1,76 @@
+/*
+ * Linker script for linux i386 replacement vdso.
+ *
+ * Copyright 2023 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+ENTRY(__kernel_vsyscall)
+
+VERSION {
+        LINUX_2.6 {
+        global:
+                __vdso_clock_gettime;
+                __vdso_gettimeofday;
+                __vdso_time;
+                __vdso_clock_getres;
+                __vdso_clock_gettime64;
+                __vdso_getcpu;
+        };
+
+        LINUX_2.5 {
+        global:
+                __kernel_vsyscall;
+                __kernel_sigreturn;
+                __kernel_rt_sigreturn;
+        local: *;
+        };
+}
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
+        .data           : {
+                /*
+                 * There ought not be any real read-write data.
+                 * But since we manipulated the segment layout,
+                 * we have to put these sections somewhere.
+                 */
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
+        .text           : { *(.text*) }         :load   =0x90909090
+}
diff --git a/linux-user/i386/vdso.so b/linux-user/i386/vdso.so
new file mode 100755
index 0000000000000000000000000000000000000000..bdece5dfcf8da036d013262d4e37208350283cfa
GIT binary patch
literal 2672
zcmbtWU1%It6u#5lG_z^4ZB?X_C>9o5sxCF8QBlyONt?nZ)?|y73e)ZGba%;SR(597
zjTXE8QIiHtY6YPbDhO>6s(mPS(FX(Z2Q`g?1xp_^KInr_=|f8&)b;yj=5}w=eGok1
z%XiMX=brmB_ny0ldSlx(O%qZAA|PnR8-(ZpuhYGj4)L&P5F5p65f&@qVw=PV(21ar
zS~fT!zaSUUNMnr<D?qmul%W%{|IXi?lnz58hBiXBldmd>Kqu7p`(Ouv?E|~S#J4vR
z?eBj&+ji~rg~eZ!zf~VSJr_pXM}D8DFrl0ORPzVHn5LKmbB!e|qzOC^tO77~@mIB)
zzl6kpgPDI3e2U8d6uIY2bq_`x0-wZWxDMLSfe$J6M%crOeHivUY<@1rr@`l7bI!EC
z1WQ>fZdBic@iW@_P1t@f_$4LZXEGSfcpH2f?e~Kj&v`Zj+$T!NBlkb|jQhnHeiL+a
z&lJb<kCS@_*v@tHJTOn=lluBDy{$|iW0~jDvC(tlyVi??Q=2p0KUP})m@B{A^3Fp?
z#y5Ta$e&ZC6Ayg2)jAG+!^M53FpOcdV3|2%)E={wiChkz(UhGxlDT|x*hrg>lO18$
z-OkRAyW9oSmOj5{et#-4CVgruv?pIJqQxKI&ZY~dQ!H3DSHUrA-dxrymL5+h95ZU?
zqfdy~j)7gfjrM5g9c>HN9>C7<kIZ}NS==-4@5JK#YMzfafM=QF?WZPg6+aHhHu){t
z#@l_<Z)3bX7g}rJnLgP3J~0HQz%PJH;3Rk&d;okNJPDowp8;P3e*#_ve+BLUI4(td
zZBS?jb*;5I7#xS6XOVMV0Ql`GjNJ_U;OnA06ySNFpY!>?j(;zF-_-GQuCsOgock95
z$CvrnLFHO513c5BE36+~5f2BEAVM30`47nj^o(oe;NgZND~~oF)87oe)%5l%caD!C
zZUR`#4&CABw}%(BE9KdV>yxiUf|Id`UI}64SIQGVslJnSd`)$H14yd$t+Ysc2<dgC
zZ=Q@t)>OQ(J+srhD+k<&>B<F{@o$-65V!Wyt>HxRj<L>q5)uze70i3T0nE36-;4MD
zX|P(C`eCbeVGnF6>~F$Q>&)x0)jBo>TdiYfVXJlMbJ%KKV=Y$enlO4^9_Z@du@yHB
zwchCMGqw$O_4gWmJ%e{HQ)lfOF0TyrZnl4$<)z$G>%HU>FE1lXy;xFj>Xa70cGRgB
zZe?<tMbsV}aT5E$PQl}h)U3Q?ifC%gN{nQau7X$*O<ToiCShkhk5lkGqh`U*=B*`$
zkrGieW9%;^Moc4<LZq}r)G<pAcKN?aE5cZ-d1tTskoO0sTmQ-H0oHh)quV~pVEQOL
zf~-B80KOf}$M=_*fzCLdUB>YqcLID@7{~XU=z-4s6vh$lz%9JdjN|)G?1a8N?pfc*
zIKKY`&zcmDP2m_-KOf(Hg0)2EV}IgBfWHx_^Y;P~hc5SkbEE79n459x?;V(~$T$m@
zjElobxDGGOT`N`AK*n(#-do~0bSZKjGMDr(AZ`H$D-74d^xS8@>$IiJAn|o+fMq_`
OKQ-<Y4#gXF;{FA}h_Ctp

literal 0
HcmV?d00001

-- 
2.34.1


