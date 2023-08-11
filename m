Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46324779528
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:51:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUVM6-0005rj-Qs; Fri, 11 Aug 2023 12:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVLx-0005mY-Aw
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:51:09 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVLv-0001OM-7D
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:51:09 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6bb07d274feso2104583a34.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691772666; x=1692377466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LeSYXr+bc8SsOHvJZBnPAwsYjoUmfsivAadtLDdjJ34=;
 b=ghqEZQkDG6Z6eyu/ZzCtqcRHbl7o9+zRqGNUANkfeMdSeaZ3/Y1Q42pBXgh78358vH
 xfLugqW9gidTqi0wM6cnfxYtDEO1ZR2QWbzHcZovc6DFEywTaWv8qbHD3D2Ky8mqk9oM
 CehoIZ3o2AJmg0nI0rd//LDsM8wrEU9r3wxyTHdVQCzU3ksYMR2nfgHXQwde4xpOeYm+
 YprCzUF3nbx5GsyZZ8ksy1wYt04NBga+lP1sjLzXrn1r6YLMFUYAznjPWSn6iArvSzYh
 Jn5xvpxiKl/JgD9aud/n5/i2jLV6BpyzanBY+Auujda7Kzab8zbfPJ7YV83QM0bNtICF
 oxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691772666; x=1692377466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LeSYXr+bc8SsOHvJZBnPAwsYjoUmfsivAadtLDdjJ34=;
 b=NaE4eh/ew+G0EDjA90Sc1oyCTt7mal9aUT2EmDi7tLjCqCXRdFdMHvF+DaHE2WTNxR
 imfk4oYX5OeULuVNgZEi0ebu8Z7mq0S6rgnzJlbj29l0jSwN4XslohNez0P1TOG3PCUL
 Lzg1kXVQ/lKCoGv/yl/WHJlE6UqqWk6C8fwXI2f3lrICAQkhPzFpxLAwS2auFIfjivt3
 gtWbekvmqtejRLwCbpusWfGNiD4gVDiZOmguqaL5Cl2vcPGyDvaXIZuR+W39KY20rom/
 k6n8AqF6P3zmTnKs2sbAEO45HCUv7KIWULy62MEg1ISbH/CErEobKaWO8BHlQg2ZAUNg
 AtnA==
X-Gm-Message-State: AOJu0YzBZgyHdvYmgQFFeyjEIExhTpDnqo2Eq+aA9rfMV56F0arBDYJc
 vQLFQ4cWzWXAijozt4e6wUrNPopiamH1Hc2TSZY=
X-Google-Smtp-Source: AGHT+IHNBngqSIuXEg2n3TdpFcPU1MLuDDqksjdkRC+4s8O+rZwNtZf3d4CYj8YPljNJgQQ8aYjrlw==
X-Received: by 2002:a05:6830:1683:b0:6bc:8cd2:dd9c with SMTP id
 k3-20020a056830168300b006bc8cd2dd9cmr2446809otr.36.1691772666035; 
 Fri, 11 Aug 2023 09:51:06 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 22-20020a17090a19d600b00263d3448141sm3803713pjj.8.2023.08.11.09.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 09:51:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH v3 13/15] linux-user/i386: Add vdso and use it for sigreturn
Date: Fri, 11 Aug 2023 09:50:50 -0700
Message-Id: <20230811165052.161080-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811165052.161080-1-richard.henderson@linaro.org>
References: <20230811165052.161080-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

Building the vdso itself is not actually wired up to anything, since
we require a cross-compiler.  Just check in that file for now.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c          |  16 ++-
 linux-user/i386/Makefile.vdso |   5 +
 linux-user/i386/meson.build   |   7 ++
 linux-user/i386/vdso.S        | 181 ++++++++++++++++++++++++++++++++++
 linux-user/i386/vdso.ld       |  76 ++++++++++++++
 linux-user/i386/vdso.so       | Bin 0 -> 5528 bytes
 6 files changed, 283 insertions(+), 2 deletions(-)
 create mode 100644 linux-user/i386/Makefile.vdso
 create mode 100644 linux-user/i386/vdso.S
 create mode 100644 linux-user/i386/vdso.ld
 create mode 100755 linux-user/i386/vdso.so

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e389295b8d..486f5c4982 100644
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
 
diff --git a/linux-user/i386/Makefile.vdso b/linux-user/i386/Makefile.vdso
new file mode 100644
index 0000000000..42cfc1974b
--- /dev/null
+++ b/linux-user/i386/Makefile.vdso
@@ -0,0 +1,5 @@
+CROSS_CC ?= $(CC)
+
+vdso.so: vdso.S vdso.ld Makefile.vdso
+	$(CROSS_CC) -m32 -nostdlib -shared -Wl,-T,vdso.ld -Wl,--build-id=sha1 \
+	  -Wl,-h,linux-gate.so.1 -Wl,--hash-style=both vdso.S -o $@
diff --git a/linux-user/i386/meson.build b/linux-user/i386/meson.build
index ee523019a5..b729d73686 100644
--- a/linux-user/i386/meson.build
+++ b/linux-user/i386/meson.build
@@ -3,3 +3,10 @@ syscall_nr_generators += {
                     arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
                     output: '@BASENAME@_nr.h')
 }
+
+gen = [
+  gen_vdso.process('vdso.so', extra_args: ['-s', '__kernel_sigreturn',
+                                           '-r', '__kernel_rt_sigreturn'])
+]
+
+linux_user_ss.add(when: 'TARGET_I386', if_true: gen)
diff --git a/linux-user/i386/vdso.S b/linux-user/i386/vdso.S
new file mode 100644
index 0000000000..009f40696e
--- /dev/null
+++ b/linux-user/i386/vdso.S
@@ -0,0 +1,181 @@
+/*
+ * i386 linux replacement vdso.
+ *
+ * Copyright 2021 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <asm/unistd.h>
+
+__kernel_vsyscall:
+	.cfi_startproc
+	int	$0x80
+	ret
+	.cfi_endproc
+
+	.globl	__kernel_vsyscall
+	.type	__kernel_vsyscall, @function
+	.size	__kernel_vsyscall, . - __kernel_vsyscall
+
+/*
+ * int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts);
+ */
+	.cfi_startproc
+__vdso_clock_gettime:
+	mov	%ebx, %edx
+	.cfi_register %ebx, %edx
+	mov	4(%esp), %ebx
+	mov	8(%esp), %ecx
+	mov	$__NR_clock_gettime, %eax
+	int	$0x80
+	mov	%edx, %ebx
+	ret
+	.cfi_endproc
+
+	.globl	__vdso_clock_gettime
+	.type	__vdso_clock_gettime, @function
+	.size	__vdso_clock_gettime, . - __vdso_clock_gettime
+
+/*
+ * int __vdso_clock_gettime64(clockid_t clock, struct timespec *ts);
+ */
+	.cfi_startproc
+__vdso_clock_gettime64:
+	mov	%ebx, %edx
+	.cfi_register %ebx, %edx
+	mov	4(%esp), %ebx
+	mov	8(%esp), %ecx
+	mov	$__NR_clock_gettime64, %eax
+	int	$0x80
+	mov	%edx, %ebx
+	ret
+	.cfi_endproc
+
+	.globl	__vdso_clock_gettime64
+	.type	__vdso_clock_gettime64, @function
+	.size	__vdso_clock_gettime64, . - __vdso_clock_gettime64
+
+/*
+ * int __vdso_clock_getres(clockid_t clock, struct old_timespec32 *res);
+ */
+	.cfi_startproc
+__vdso_clock_getres:
+	mov	%ebx, %edx
+	.cfi_register %ebx, %edx
+	mov	4(%esp), %ebx
+	mov	8(%esp), %ecx
+	mov	$__NR_clock_getres, %eax
+	int	$0x80
+	mov	%edx, %ebx
+	ret
+	.cfi_endproc
+
+	.globl	__vdso_clock_getres
+	.type	__vdso_clock_getres, @function
+	.size	__vdso_clock_getres, . - __vdso_clock_getres
+
+/*
+ * int __vdso_gettimeofday(struct old_timeval *tv, struct timezone *tz);
+ */
+	.cfi_startproc
+__vdso_gettimeofday:
+	mov	%ebx, %edx
+	.cfi_register %ebx, %edx
+	mov	4(%esp), %ebx
+	mov	8(%esp), %ecx
+	mov	$__NR_gettimeofday, %eax
+	int	$0x80
+	mov	%edx, %ebx
+	ret
+	.cfi_endproc
+
+	.globl	__vdso_gettimeofday
+	.type	__vdso_gettimeofday, @function
+	.size	__vdso_gettimeofday, . - __vdso_gettimeofday
+
+/*
+ * old_time_t __vdso_time(old_time_t *t);
+ */
+	.cfi_startproc
+__vdso_time:
+	mov	%ebx, %edx
+	.cfi_register %ebx, %edx
+	mov	4(%esp), %ebx
+	mov	$__NR_time, %eax
+	int	$0x80
+	mov	%edx, %ebx
+	ret
+	.cfi_endproc
+
+	.globl	__vdso_time
+	.type	__vdso_time, @function
+	.size	__vdso_time, . - __vdso_time
+
+	/*
+	 * While this frame is marked as a signal frame, that only applies
+	 * to how this return address is handled for the outer frame.
+	 * The return address that arrived here, from the inner frame, is
+	 * not marked as a signal frame and so the unwinder still tries to
+	 * subtract 1 to examine the presumed call insn.  Thus we must
+	 * extend the unwind info to a nop before the start.
+	 */
+
+	.cfi_startproc simple
+	.cfi_signal_frame
+
+	/*
+	 * For convenience, put the cfa just above eip in sigcontext,
+	 * and count offsets backward from there.  Re-compute the cfa
+	 * in the several contexts we have for signal unwinding.
+         * This is far simpler than the DW_CFA_expression form that
+         * the kernel uses, and is equally correct.
+	 */
+#define IA32_SIGCONTEXT_cfa           60
+#define IA32_RT_SIGFRAME_sigcontext  164
+
+	.cfi_def_cfa	%esp, IA32_SIGCONTEXT_cfa + 4
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
+	nop
+__kernel_sigreturn:
+	popl	%eax	/* pop sig */
+	.cfi_adjust_cfa_offset -4
+	movl	$__NR_sigreturn, %eax
+	int	$0x80
+
+	.globl	__kernel_sigreturn
+	.type	__kernel_sigreturn, @function
+	.size	__kernel_sigreturn, . - __kernel_sigreturn
+
+	.cfi_adjust_cfa_offset IA32_RT_SIGFRAME_sigcontext - 4
+	nop
+__kernel_rt_sigreturn:
+	movl	$__NR_rt_sigreturn, %eax
+	int	$0x80
+
+	.globl	__kernel_rt_sigreturn
+	.type	__kernel_rt_sigreturn, @function
+	.size	__kernel_rt_sigreturn, . - __kernel_rt_sigreturn
+	.cfi_endproc
+
+/*
+ * ??? Perhaps add elf notes.  E.g.
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
index 0000000000..b16e5c31bd
--- /dev/null
+++ b/linux-user/i386/vdso.ld
@@ -0,0 +1,76 @@
+/*
+ * Linker script for linux x86-64 replacement vdso.
+ *
+ * Copyright 2021 Linaro, Ltd.
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
+        data            PT_LOAD         FLAGS(6) FILEHDR PHDRS;
+        text            PT_LOAD         FLAGS(5);
+        dynamic         PT_DYNAMIC      FLAGS(4);
+        eh_frame_hdr    PT_GNU_EH_FRAME;
+        note            PT_NOTE         FLAGS(4);
+}
+
+SECTIONS {
+        /* ??? We can't really prelink to any address without knowing
+           something about the virtual memory space of the host, since
+           that leaks over into the available memory space of the guest.  */
+        . = SIZEOF_HEADERS;
+
+        /* The following, including the FILEHDRS and PHDRS, are modified
+           when we relocate the binary.  We want them to be initially
+           writable for the relocation; we'll force them read-only after.  */
+        .note           : { *(.note*) }         :data :note
+        .dynamic        : { *(.dynamic) }       :data :dynamic
+        .dynsym         : { *(.dynsym) }        :data
+        .data           : {
+                /* There ought not be any real read-write data.
+                   But since we manipulated the segment layout,
+                   we have to put these sections somewhere.  */
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
+        .eh_frame_hdr   : { *(.eh_frame_hdr) }  :data :eh_frame_hdr
+        .eh_frame       : { *(.eh_frame) }      :data
+
+        . = ALIGN(4096);
+        .text           : { *(.text*) }         :text   =0x90909090
+}
diff --git a/linux-user/i386/vdso.so b/linux-user/i386/vdso.so
new file mode 100755
index 0000000000000000000000000000000000000000..977ac01f5a2f06660560ee05d582b4804d842c59
GIT binary patch
literal 5528
zcmeHLO=w(I6u!?lZ6;}xHc@OPQ7nWSTODdiBWh`;>7-3D37S}}P<S0@UT22PkIs7;
z6P0%QV>=~aQ+3gW3qiq6D_w}pazJn)trQdlacNz+s*rT0#_zlDoyki(g5XMcCpkI4
z_uTu=y%+M`Q={Vt4Z~1ErZSbbHY+s<XZ%4gGN>L`>(zkTq`Dxz7~|xI&k;!SYBd<3
zfps2poI+ixPo3;SkddbC2Ozd0Nw^A|EcIWy?WUUsoC(Cp5~o}Wa6fc%F#Zs16MSg$
zh`QbL<i4$u&t@tYN{#1#Jh{BDulvm|#6I@NjA22`f31{ikX+*rko=Y_SYrod1H1vu
z&-r6zrF0dA|Ab`yJCGky`Hv($W2qj@HVrw93Hcqghaq<c>;c$Y0=5G?4Lj=RXCS9x
z<5!RW3R0+B{l0P@MghS#NY>{uFk#DlS0x#e`CJ!!p!XQE9W2BiaZj1UJzx*{J*>_3
zkQk$nd92a)Y;;>Z+E<l4*7)*V<#Y9I@AaumyRsv<>YcydsD9A-{$poqJHFZe+oie7
zk9>NdxBy*Q){I>)+Ig$u%sZ)MJ`YbN?UbxkzLc7=GPdjH3U*89(BOUUvh9e^A6Yt)
zPR@(ZFXhkZ<T7R3oh=s;_FZMyTJ`30#o4*1GfCHuIi=V$YW(ozk)zh`*icj3gD*AF
z2mVm<Mp9>gyr0W=zT3oo=mYbNlDys->hA0pro?2A7~`#8_G8SK{Wf~d7viwF7iyzY
z#~@6|Hz2n_)*yF6egZiRS%;j4yakzp+>GL!k7T?(rHpr@M(@T*qy|5Zi?>D`4DK(9
zxx2s%@ab_Q?IypC`WW~^3;%KW&$jT-!GEfSe-Zw7;OG3xuh08W!WyS#k@1>QjhtS0
zX8qZ=bJ6$O&v#&QuHz~2ix}U{0V7>|4|V;_7KRjdAnZWcfv^K%2f_}79SA!RcHn>C
zft%H@FaES}tUt0a-XE>E<Nw^7)r;Q;eIK^)b+qtJq8EX&^-i%DkJjJP`eOZ>miTiY
zE%_e*^+98Qx`=&9#M&gHArdh;$<&AvIHhUpR|JjGy|{-+1%sO&(ow|dUff5Z1g0R<
zN3MycP2>sEV1n@t8f)=wf@ENQI>XN=@_p0`>A%FrPf){nPDw2N9Apr?PcZHi^IwG?
z#NGwiL2Q2-b`aZNfgQx=>~aw6H(&>`zOoXpP41sKd;k~~?;qCan00V!|HP;@mY8b7
z(4kcTdoPM!gMtOX?pe)W19<O6-T^ed2937>-v5lOHJI076?5hbZt`_Vx9rKRXvLCi
zt5|xzm@MQ{T0yRgWs0-0Y|_bk9=GgyDt6h)m5OT&E3IO7);dv67Hlh<My6OQ=Gt>E
z`ucCF7m38!Jf=MBWWl6R{Zp*eHt0ODJS)NXFL_ttG2@Bd0R}|X^>{bP*I_dcs;<W)
zI|Sy9;Jmyu<T!Ny`0G5@+zq~qw<_lGE|JGu<n8r+%;P&4xdB~>bCVL_6~7+u9{FMT
zWL}OZzYOME8Fk)C@+;7#2V5KJIGDAWCyVABLXua6L-Kfs$-hVvq~!7KfO)#FY!o=S
zpYk123mKYR<W=G9gvB>P*5h!#cgeRwRZDn0xIx7ysmC{kU|yp~sgsffDS3Yb$_a-e

literal 0
HcmV?d00001

-- 
2.34.1


