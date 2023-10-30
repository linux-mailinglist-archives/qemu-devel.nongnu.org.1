Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A78637DC1B9
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:19:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZeD-000174-SV; Mon, 30 Oct 2023 17:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdy-00011o-MN
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:55 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdp-0006Vh-HG
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:53 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5a9d8f4388bso2785620a12.3
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 14:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698700664; x=1699305464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cjtkqd3XYHBo3q2DLIfIgQz+m/mXEzHm0a2d9CG2zJo=;
 b=D1cyKg5yi5Fzd8hBrrObZglCSJKAX/K1Jp0vJ3sAwPmlfCT74aUrKbuMiwhYdNARwR
 KvM1PCYGb3hBBBrk7RM0Kun/OJ7x1X9kPHegOdME82RVuf3/2qw7kB10+ewHOwYAleEr
 rrkT7IDBfjqktKz4cRtZLKPq7Oj5ESMVDNgwcltqVM2bdl467yVhmC6tGGW+MeF7K9Ke
 SJ616jkHFf2BORdnxnctQaQ7OdHz0TaryYhf0OnsdiVcO/bylGKOBDXXNOfYvJVttlOx
 3aXI9M9+9e3WsZszVID0z0LhDKQljJ5OFBE3ZICTKpnPknJcyK+IgZIheH9wvKih0Bko
 EsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698700664; x=1699305464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cjtkqd3XYHBo3q2DLIfIgQz+m/mXEzHm0a2d9CG2zJo=;
 b=xH8jSfEHnOSFl5X4dX4B+pB6QSdky9gNTm/nZLDpmHr04NVBFCiFUa977c6b0462Bf
 Xv92UJtjeF401xYoXeQtldVSXjxDloFcdjninsfFk4jNlzU6Mu2V3fodEBibqtGG0fYw
 qrhahuMTggBHd9DTWcBu/lVdc/3HW8IVSSjhQu9t4ciSaZe8hTvl0qdVnnau+t3EZVY4
 c6A3YvkAHZmqnfq1Jl8YKgehhg0jQA7lUMvvO0O0Ubk9AI+5NHlP3efWI+aimfpPCo5G
 uG+p6HHDAICuUOadLo6vBcsnc9dpvb83TUUrkarCx+9by64yUTmPvP+5eEDMyQXUgy3i
 xalg==
X-Gm-Message-State: AOJu0YwrTs8ScreMUlrDzzlgVtSnr9AR8JzQmqUzmD7U14P14CswA2bK
 u/V2yNDbZUpVf80JBKXIXjQtURB3ab7Lu+6Bmsw=
X-Google-Smtp-Source: AGHT+IGcyVG43HKEYpvJO95a5QVBwSP6nI+Ai4k7M/4Kqi685Ymzz5zi7JcgpybZrTh1A7fC8OcV7g==
X-Received: by 2002:a17:903:41c4:b0:1cc:4a84:27fc with SMTP id
 u4-20020a17090341c400b001cc4a8427fcmr2972690ple.52.1698700663977; 
 Mon, 30 Oct 2023 14:17:43 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf2-20020a170903268200b001cc32261bdfsm4670350plb.38.2023.10.30.14.17.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:17:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/21] linux-user/ppc: Add vdso
Date: Mon, 30 Oct 2023 14:17:23 -0700
Message-Id: <20231030211727.165090-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030211727.165090-1-richard.henderson@linaro.org>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Add support in gen-vdso-elfn.c.inc for the DT_PPC64_OPT
dynamic tag: this is an integer, so does not need relocation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/ppc/vdso-asmoffset.h |  20 +++
 linux-user/elfload.c            |   8 ++
 linux-user/ppc/signal.c         |  31 +++--
 linux-user/gen-vdso-elfn.c.inc  |   7 +
 linux-user/ppc/Makefile.vdso    |  20 +++
 linux-user/ppc/meson.build      |  12 ++
 linux-user/ppc/vdso-32.ld       |  70 ++++++++++
 linux-user/ppc/vdso-32.so       | Bin 0 -> 3020 bytes
 linux-user/ppc/vdso-64.ld       |  68 +++++++++
 linux-user/ppc/vdso-64.so       | Bin 0 -> 3896 bytes
 linux-user/ppc/vdso-64le.so     | Bin 0 -> 3896 bytes
 linux-user/ppc/vdso.S           | 239 ++++++++++++++++++++++++++++++++
 12 files changed, 467 insertions(+), 8 deletions(-)
 create mode 100644 linux-user/ppc/vdso-asmoffset.h
 create mode 100644 linux-user/ppc/Makefile.vdso
 create mode 100644 linux-user/ppc/vdso-32.ld
 create mode 100755 linux-user/ppc/vdso-32.so
 create mode 100644 linux-user/ppc/vdso-64.ld
 create mode 100755 linux-user/ppc/vdso-64.so
 create mode 100755 linux-user/ppc/vdso-64le.so
 create mode 100644 linux-user/ppc/vdso.S

diff --git a/linux-user/ppc/vdso-asmoffset.h b/linux-user/ppc/vdso-asmoffset.h
new file mode 100644
index 0000000000..6844c8c81c
--- /dev/null
+++ b/linux-user/ppc/vdso-asmoffset.h
@@ -0,0 +1,20 @@
+/*
+ * Size of dummy stack frame allocated when calling signal handler.
+ * See arch/powerpc/include/asm/ptrace.h.
+ */
+#ifdef TARGET_ABI32
+# define SIGNAL_FRAMESIZE                   64
+#else
+# define SIGNAL_FRAMESIZE                   128
+#endif
+
+#ifdef TARGET_ABI32
+# define offsetof_sigframe_mcontext         0x20
+# define offsetof_rt_sigframe_mcontext      0x140
+# define offsetof_mcontext_fregs            0xc0
+# define offsetof_mcontext_vregs            0x1d0
+#else
+# define offsetof_rt_sigframe_mcontext      0xe8
+# define offsetof_mcontext_fregs            0x180
+# define offsetof_mcontext_vregs_ptr        0x288
+#endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4e6e0059e6..26602516aa 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1187,6 +1187,14 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUPPCState *en
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
+#ifndef TARGET_PPC64
+# define VDSO_HEADER  "vdso-32.c.inc"
+#elif TARGET_BIG_ENDIAN
+# define VDSO_HEADER  "vdso-64.c.inc"
+#else
+# define VDSO_HEADER  "vdso-64le.c.inc"
+#endif
+
 #endif
 
 #ifdef TARGET_LOONGARCH64
diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index a616f20efb..7e7302823b 100644
--- a/linux-user/ppc/signal.c
+++ b/linux-user/ppc/signal.c
@@ -21,14 +21,7 @@
 #include "user-internals.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
-
-/* Size of dummy stack frame allocated when calling signal handler.
-   See arch/powerpc/include/asm/ptrace.h.  */
-#if defined(TARGET_PPC64)
-#define SIGNAL_FRAMESIZE 128
-#else
-#define SIGNAL_FRAMESIZE 64
-#endif
+#include "vdso-asmoffset.h"
 
 /* See arch/powerpc/include/asm/ucontext.h.  Only used for 32-bit PPC;
    on 64-bit PPC, sigcontext and mcontext are one and the same.  */
@@ -73,6 +66,16 @@ struct target_mcontext {
 #endif
 };
 
+QEMU_BUILD_BUG_ON(offsetof(struct target_mcontext, mc_fregs)
+                  != offsetof_mcontext_fregs);
+#if defined(TARGET_PPC64)
+QEMU_BUILD_BUG_ON(offsetof(struct target_mcontext, v_regs)
+                  != offsetof_mcontext_vregs_ptr);
+#else
+QEMU_BUILD_BUG_ON(offsetof(struct target_mcontext, mc_vregs)
+                  != offsetof_mcontext_vregs);
+#endif
+
 /* See arch/powerpc/include/asm/sigcontext.h.  */
 struct target_sigcontext {
     target_ulong _unused[4];
@@ -161,6 +164,7 @@ struct target_ucontext {
 #endif
 };
 
+#if !defined(TARGET_PPC64)
 /* See arch/powerpc/kernel/signal_32.c.  */
 struct target_sigframe {
     struct target_sigcontext sctx;
@@ -168,6 +172,10 @@ struct target_sigframe {
     int32_t abigap[56];
 };
 
+QEMU_BUILD_BUG_ON(offsetof(struct target_sigframe, mctx)
+                  != offsetof_sigframe_mcontext);
+#endif
+
 #if defined(TARGET_PPC64)
 
 #define TARGET_TRAMP_SIZE 6
@@ -184,6 +192,10 @@ struct target_rt_sigframe {
     char abigap[288];
 } __attribute__((aligned(16)));
 
+QEMU_BUILD_BUG_ON(offsetof(struct target_rt_sigframe,
+                           uc.tuc_sigcontext.mcontext)
+                  != offsetof_rt_sigframe_mcontext);
+
 #else
 
 struct target_rt_sigframe {
@@ -192,6 +204,9 @@ struct target_rt_sigframe {
     int32_t abigap[56];
 };
 
+QEMU_BUILD_BUG_ON(offsetof(struct target_rt_sigframe, uc.tuc_mcontext)
+                  != offsetof_rt_sigframe_mcontext);
+
 #endif
 
 #if defined(TARGET_PPC64)
diff --git a/linux-user/gen-vdso-elfn.c.inc b/linux-user/gen-vdso-elfn.c.inc
index 7034c36d5e..95856eb839 100644
--- a/linux-user/gen-vdso-elfn.c.inc
+++ b/linux-user/gen-vdso-elfn.c.inc
@@ -273,7 +273,14 @@ static void elfN(process)(FILE *outf, void *buf, bool need_bswap)
                 errors++;
                 break;
 
+            case PT_LOPROC + 3:
+                if (ehdr->e_machine == EM_PPC64) {
+                    break;  /* DT_PPC64_OPT: integer bitmask */
+                }
+                goto do_default;
+
             default:
+            do_default:
                 /* This is probably something target specific. */
                 fprintf(stderr, "VDSO has unknown DYNAMIC entry (%lx)\n",
                         (unsigned long)tag);
diff --git a/linux-user/ppc/Makefile.vdso b/linux-user/ppc/Makefile.vdso
new file mode 100644
index 0000000000..3ca3c6b83e
--- /dev/null
+++ b/linux-user/ppc/Makefile.vdso
@@ -0,0 +1,20 @@
+include $(BUILD_DIR)/tests/tcg/ppc64-linux-user/config-target.mak
+
+SUBDIR = $(SRC_PATH)/linux-user/ppc
+VPATH += $(SUBDIR)
+
+all: $(SUBDIR)/vdso-32.so $(SUBDIR)/vdso-64.so $(SUBDIR)/vdso-64le.so
+
+LDFLAGS32 = -nostdlib -shared -Wl,-T,$(SUBDIR)/vdso-32.ld \
+            -Wl,-h,linux-vdso32.so.1 -Wl,--hash-style=both -Wl,--build-id=sha1
+LDFLAGS64 = -nostdlib -shared -Wl,-T,$(SUBDIR)/vdso-64.ld \
+            -Wl,-h,linux-vdso64.so.1 -Wl,--hash-style=both -Wl,--build-id=sha1
+
+$(SUBDIR)/vdso-32.so: vdso.S vdso-32.ld vdso-asmoffset.h
+	$(CC) -o $@ $(LDFLAGS32) -m32 $<
+
+$(SUBDIR)/vdso-64.so: vdso.S vdso-64.ld vdso-asmoffset.h
+	$(CC) -o $@ $(LDFLAGS64) -mbig-endian $<
+
+$(SUBDIR)/vdso-64le.so: vdso.S vdso-64.ld vdso-asmoffset.h
+	$(CC) -o $@ $(LDFLAGS64) -mlittle-endian $<
diff --git a/linux-user/ppc/meson.build b/linux-user/ppc/meson.build
index 19fead7bc8..80cacae396 100644
--- a/linux-user/ppc/meson.build
+++ b/linux-user/ppc/meson.build
@@ -3,3 +3,15 @@ syscall_nr_generators += {
                    arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
                    output: '@BASENAME@_nr.h')
 }
+
+vdso_32_inc = gen_vdso.process('vdso-32.so', extra_args: [
+                                   '-s', '__kernel_sigtramp32',
+                                   '-r', '__kernel_sigtramp_rt32'
+                               ])
+linux_user_ss.add(when: 'TARGET_PPC', if_true: vdso_32_inc)
+
+vdso_64_inc = gen_vdso.process('vdso-64.so',
+                               extra_args: ['-r', '__kernel_sigtramp_rt64'])
+vdso_64le_inc = gen_vdso.process('vdso-64le.so',
+                                 extra_args: ['-r', '__kernel_sigtramp_rt64'])
+linux_user_ss.add(when: 'TARGET_PPC64', if_true: [vdso_64_inc, vdso_64le_inc])
diff --git a/linux-user/ppc/vdso-32.ld b/linux-user/ppc/vdso-32.ld
new file mode 100644
index 0000000000..6962696540
--- /dev/null
+++ b/linux-user/ppc/vdso-32.ld
@@ -0,0 +1,70 @@
+/*
+ * Linker script for linux powerpc64 replacement vdso.
+ *
+ * Copyright 2023 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+VERSION {
+        LINUX_2.6.15 {
+        global:
+                __kernel_gettimeofday;
+                __kernel_clock_gettime;
+                __kernel_clock_gettime64;
+                __kernel_clock_getres;
+                __kernel_time;
+                __kernel_sync_dicache;
+                __kernel_sigtramp32;
+                __kernel_sigtramp_rt32;
+                __kernel_getcpu;
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
+        .text           : { *(.text*) }         :load
+}
diff --git a/linux-user/ppc/vdso-32.so b/linux-user/ppc/vdso-32.so
new file mode 100755
index 0000000000000000000000000000000000000000..b19baafb0d38e15b4a24def5c44a6d684714be45
GIT binary patch
literal 3020
zcmbtWeQXp}5P#e27f_&s6{-a-h*%I#XbYl%a{b~XN2zU*57F)Q?%F%r-of3qv<2Um
z1QRhNq7Vb7G1Z^}LI}~u5YuQA2$G0I6M`g?$RC*a2Z<OJNd)U}-tD{FYGX7`J3I56
znK%3P?abU-)!rH-!w@NQi2~@_P%gwcukw|PVv!|EM822|oDGIA#RJfpGi}!E0hzMr
zCt2j!nKNL#<KRB%%xZlg@qL{TuA6BV)8S**`B`3e@NDSJPCq|~YgO$AvFGf0kL&f&
zyz@uCzSg_H@|!C=N(SMZ1RhGR$taJG{PC+0842Jl$YDr4qtOjH9{eqM0ysZ9GIAGb
z2O;kPXF%Qp?uY(=$&FiIN0PiLV8}PHg+j<&8#ltwXQus^perIV@)MLQ_;F?_|1qrR
zGtujtf%$y&`dz^Jz?pV_ytAwe4*xXZ%MQ%<*5rc1=fT7}pAi%19|z85U=!B@*9*=S
z?;mFd<~3|*J$r8Bfmwl!+_Sb#<+!>mczErej|%2|`C~)=mL~agwClu?S594u8bd8b
zfqm~5&l#xt?zrckFwM4LED~%tTZ4&2xFZ;C3HW-_R)2fc-==+Im}9|s+KLqZ?VV}N
z`O;`qswL%VN4zKEHv?h6&mVGx$HT3On6G2I8B3IvI)ZI8Z0+GlXZM1xKs;Jj>W)X<
zi-dPg?S@Tese6fg(PEqipU>a__~g{z#Mf5vdoKWUZ*VQ^Q#EqTFWv`YACsyTqsX-k
zI@c7=-M9w15NZkZbI`dKgwb0sGIx87qCC~YY(u<p6w=Fn=)2Xmx4r>^l^odTqROT|
zL54*cl3XuS=5ET`McKWS(?hx4G;Sx2@1hBvl$W51ahepP$vY^2J5iLTMCiT_Drl$s
z+i2=Gnii(Q5IxXJ54KQIkfsM{hMyj4riXpx*-ABAsJM=1*3v95J+hW&uck+9XigP9
zRzW2zY3`>M%^R}l@lPz8f5xH(A6w)ewCITsEn0ZmqD7}HDm`gY*$Iovk6E<%1B;d%
zwdl$BELu8X(NphO^mM;P%igwV`C*Gzyk*fdhb(&bO^ep;x2X12i`MV8sIJeV=k7|X
zzay#P7fFq`ByG4U>G>ZdZM-3A({)LkuSwc+RniNWC2jpm(u)@*y>vm6c}`N(uq5A*
zq~<e{{DYDLrzHhXN@_VKsr9I&(14_Hzoc!4CAA%r)P6ux$9_qXeNvr2zf)r`)UDt`
zQJH5nL0Kw9Z53W-ZJ#KHe%qn{mevh-S{D=3x^YnJyxz`tl5MuWlXcu?EaDl#4Xp|W
z>Kz-~@oI*$AOB2TZwh3x1TN<*oID>uY6dgrnZbCNufRMzSnF5U)QoWr+L-4Kh<`U!
zygidL)hxn#dtRv-$NBOQ#(P%#g~I#An&kSVE@r^2_6tAnw+yVvp1CWrZN8tLsdd2D
z9k>OLF&kLV;9g+PqvH=E{(=J^ho5^+&*aa53mxmPAfETD*WUo<^G{;4YICh;-I_{F
z8~pB>)vL{#de6FQb9Gg{FjslkS9rYU`kI=C>PEBCQ{k;PM-Lq5C>=EiQ<HDhwA2I6
zIo(o`JUX2-a_s5+pC;!&Ok*M3@t%%^uNg8COUjVeBGE)pxC1>AUq{%l6vRUM5<cN>
zjdZ$0zIZ5UPsEazu3#)4jz&fSGa%f-klBKn9yCJ%L~115iC}jEZ{gol5kmEEA-_Ln
zt`kjMBTO^F+y^Mv)b~;!bh{T+O>%wD19N?&hPmHV&z-j8xW+jj*HtN)G4gR;tJ>y1
z(8O`f%fZ}_$jAMudUPc)?}JIlEyefGZD5YW38>!n0{=Cx!nSeTaFW$G70ilwPfTl(
zZv+x?+~=y-rvmGIu(MBW)Zbrl4JMgKVCqbHe@y5<^}L)9eX4qUy7DA1Iu3i+aXc@W
zjo~rkcm(ra@lLpJRqqBIar!w}@;+_i?_Xm8fWJ9af7_C0mVP#<ITvyH9jr;`BN!ZU
Nxt{~?)j^Od?oZyq_3Z!v

literal 0
HcmV?d00001

diff --git a/linux-user/ppc/vdso-64.ld b/linux-user/ppc/vdso-64.ld
new file mode 100644
index 0000000000..a55c65ed54
--- /dev/null
+++ b/linux-user/ppc/vdso-64.ld
@@ -0,0 +1,68 @@
+/*
+ * Linker script for linux powerpc64 replacement vdso.
+ *
+ * Copyright 2023 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+VERSION {
+        LINUX_2.6.15 {
+        global:
+                __kernel_gettimeofday;
+                __kernel_clock_gettime;
+                __kernel_clock_getres;
+                __kernel_sync_dicache;
+                __kernel_sigtramp_rt64;
+                __kernel_getcpu;
+                __kernel_time;
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
+        .text           : { *(.text*) }         :load
+}
diff --git a/linux-user/ppc/vdso-64.so b/linux-user/ppc/vdso-64.so
new file mode 100755
index 0000000000000000000000000000000000000000..913c831b3819fc09912b9b31f7fbe9ee311ae12f
GIT binary patch
literal 3896
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
TLT~?o+8puo)jWvPbH)D+{oljD

literal 0
HcmV?d00001

diff --git a/linux-user/ppc/vdso-64le.so b/linux-user/ppc/vdso-64le.so
new file mode 100755
index 0000000000000000000000000000000000000000..258a03b807c4eca23547d978c16d1ad5ebd08bc5
GIT binary patch
literal 3896
zcmcgvU2GIp6uvXl(gKCvgCJ-@i&R9Eg<`3dAMMg@`LQjvfc%I~x4YZ!(ssA*ZflFk
zEC~;qkl2J5V|XYgCTNVQf{Oq3!NkOv^pOV>`(nZa2_*`eAl7sC-m^P9tkJ~8vza;H
z{q8yU%)K-BoV!kQYl~?Zg2fU`M7||NqwZ*!&lbcrh*G>uQ7PsiU4mDm?)K_sdN9`I
z+K%Wljf<%%-N{<$r!vu);$`%>UM)4xn&Wl+oDP%U6}lDC%M~qHYqM-D!Uy%ZUR|U8
zSiAieW1ofBj`scH*7la@tux=QtI3pvuGN0C{_N=+7s+)Y-B4avDjSdBAUUGk_;WTv
z`n+zJQUm3xZqxdcjM2iN%u`CduQk86Wx9=SgBoVlAG2!w3H{)=bz2W7W_0^ao|xPD
zf5bkFB}IietG|m19ebbVFM9ZM$b+~(tIcvMpzY6l?7KBTsd=6*y>^Ow%40vG`R_E(
z-`P^lk9q9HN$fzO*ETncgrGHMKjQh_Qa8n?*z|sBDC(y+b8l4#O8w=co7&Vzc5g(s
zT;6-_ht(&#4$F6k6Th5$EnF2CUtK+N;pFby{&#*7w%r#=#v}c9ZzP?L4MY+>;oxYV
z4fQ8NecV@sPDWCB7KaE84&~c4UcQwYjfd=TEEEhy-E6EkoeT~P+R1c%o#>Cnhep;7
zhf|6AI$tW`s}-%g+V>x{H~Q**wVQB0rsszg&R_kmZ#!zz{-XWLdxzG-#QwLxx67!H
z<eXB%sIs=u9-uWpi?<D^e?(n}PLgeob&8S^zfo0TWI3`AqfMjkznZt(i-t{Pc*TUK
zu8aV~0rLb{uRzIhD18~`9D}k^C?A2jFTuQFm_Gy+X;_egg-NJ<5#%610v5&Lt^ruw
z4@>&s?xV0Y2Fs#wPcPit162`N9)=YmxUU=T4}$*)v>b-&4p_Md9%zSEZBWw+4?Yd6
zcf&)wV9ic=cn7R)fk&F*(EzM#0^fF6?}rVIQ2Vt58^3bku`eB{`@(@upF2?hnFEi1
z>OjLK2cG!Efz2N~u;n8MwqA5#+XV-n{Lq1?K5%I6xHi9{9!H(sZ?dgy)vKj*R%L{2
zS7=PgJqnEr*`d&ckk2SIDP*TYQ$p@lXj;g93e5<)U!ja4pH*ngkOveRH{?NuCJcE<
zp-Dp?R%ptQ&nYx*$Ri5P81i|AGNyb%p)ph13XPkxOQ8u<1{In#Ww%08rVJ@GZOX7h
zGp39vl(A%wLSvTfRcPFjQH3Tf8B=J|l1CMqvSgn^)0XU4XvUHQ3S~-UT%psn&)bD)
zz|SmDEi&ylUHCT__8EDb1umX^aEPw=G>7<a#lpS8^~-H!;jYNwJNAl&nT6|$yU)Vx
z6s4r&5eqXI*DZIKh1rSgS0P`Pt7C<HxhPg|EX<r-rwZ-o<?4DNKVOu%ldA5tT=|^s
zY5GQybx`&6&hb~EeX;to7I~@{-ukjx^WOT^p?Pn8>CwEm9v#=bx9*(Le6c!6&vQpT
zvIB?O{cXFNFlXcW#BSbcw{-g3n(du|&cZzGE*b?HKUXfib)iUU`8V|-7pSn5<iccW
z;Y*DUq=Vh4(@CYHjN*xOMEJs^@!&u#lm%#uI+zX$UvGTK7Y(MOiccpMGaN~#Vu^S`
z!ww5yBx?6yrHa_mFj{g;_|lP)G_Lf2mns~B>N@WGtnj{MU88wclqcM>5*t+Wc^mTn
zWzFYbeGJK+Gq~2#cS>hNj?ep?^=0fMA%EH%d`_X7NU{+x;yFI&1J-O$wj|tUy%jmy
znjD|=2I~fLLgDe*kJo|vZ{pdM{W-s|4rIOW^w+f5uE%D7K2Nje^E2DiT-~x88?&zX
zoUd3f(#HJ!9EbG*?5DFfw>ht|=K1qC!t>{6p!`73#Qxs@HT*w@?Rnj}O<%FwpYtT^
z3=gawy#6P&KYfEFoWEGNDmr)fuAe)0&Ikej-&>>OFGQ{qFP=Yte{_cCwMCed-}T}8
WQjSr;8y}D^=0BklzBu&{{(k}Ee8OG;

literal 0
HcmV?d00001

diff --git a/linux-user/ppc/vdso.S b/linux-user/ppc/vdso.S
new file mode 100644
index 0000000000..689010db13
--- /dev/null
+++ b/linux-user/ppc/vdso.S
@@ -0,0 +1,239 @@
+/*
+ * PowerPC linux replacement vdso.
+ *
+ * Copyright 2023 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <asm/unistd.h>
+#include <asm/errno.h>
+
+#ifndef _ARCH_PPC64
+# define TARGET_ABI32
+#endif
+#include "vdso-asmoffset.h"
+
+
+	.text
+
+.macro endf name
+	.globl	\name
+	.size	\name, .-\name
+	/* For PPC64, functions have special linkage; we export pointers. */
+#ifndef _ARCH_PPC64
+	.type	\name, @function
+#endif
+.endm
+
+.macro raw_syscall nr
+	addi	0, 0, \nr
+	sc
+.endm
+
+.macro vdso_syscall name, nr
+\name:
+	raw_syscall \nr
+	blr
+endf	\name
+.endm
+
+	.cfi_startproc
+
+vdso_syscall __kernel_gettimeofday, __NR_gettimeofday
+vdso_syscall __kernel_clock_gettime, __NR_clock_gettime
+vdso_syscall __kernel_clock_getres, __NR_clock_getres
+vdso_syscall __kernel_getcpu, __NR_getcpu
+vdso_syscall __kernel_time, __NR_time
+
+#ifdef __NR_clock_gettime64
+vdso_syscall __kernel_clock_gettime64, __NR_clock_gettime64
+#endif
+
+__kernel_sync_dicache:
+	/* qemu does not need to flush caches */
+	blr
+endf	__kernel_sync_dicache
+
+	.cfi_endproc
+
+/*
+ * TODO: __kernel_get_tbfreq
+ * This is probably a constant for QEMU.
+ */
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
+#ifdef _ARCH_PPC64
+# define __kernel_sigtramp_rt  __kernel_sigtramp_rt64
+# define sizeof_reg	8
+#else
+# define __kernel_sigtramp_rt  __kernel_sigtramp_rt32
+# define sizeof_reg	4
+#endif
+#define sizeof_freg	8
+#define sizeof_vreg	16
+
+	.cfi_def_cfa	1, SIGNAL_FRAMESIZE + offsetof_rt_sigframe_mcontext
+
+	/* Return address */
+	.cfi_return_column 67
+	.cfi_offset	67, 32 * sizeof_reg		/* nip */
+
+	/* Integer registers */
+	.cfi_offset	0, 0 * sizeof_reg
+	.cfi_offset	1, 1 * sizeof_reg
+	.cfi_offset	2, 2 * sizeof_reg
+	.cfi_offset	3, 3 * sizeof_reg
+	.cfi_offset	4, 4 * sizeof_reg
+	.cfi_offset	5, 5 * sizeof_reg
+	.cfi_offset	6, 6 * sizeof_reg
+	.cfi_offset	7, 7 * sizeof_reg
+	.cfi_offset	8, 8 * sizeof_reg
+	.cfi_offset	9, 9 * sizeof_reg
+	.cfi_offset	10, 10 * sizeof_reg
+	.cfi_offset	11, 11 * sizeof_reg
+	.cfi_offset	12, 12 * sizeof_reg
+	.cfi_offset	13, 13 * sizeof_reg
+	.cfi_offset	14, 14 * sizeof_reg
+	.cfi_offset	15, 15 * sizeof_reg
+	.cfi_offset	16, 16 * sizeof_reg
+	.cfi_offset	17, 17 * sizeof_reg
+	.cfi_offset	18, 18 * sizeof_reg
+	.cfi_offset	19, 19 * sizeof_reg
+	.cfi_offset	20, 20 * sizeof_reg
+	.cfi_offset	21, 21 * sizeof_reg
+	.cfi_offset	22, 22 * sizeof_reg
+	.cfi_offset	23, 23 * sizeof_reg
+	.cfi_offset	24, 24 * sizeof_reg
+	.cfi_offset	25, 25 * sizeof_reg
+	.cfi_offset	26, 26 * sizeof_reg
+	.cfi_offset	27, 27 * sizeof_reg
+	.cfi_offset	28, 28 * sizeof_reg
+	.cfi_offset	29, 29 * sizeof_reg
+	.cfi_offset	30, 30 * sizeof_reg
+	.cfi_offset	31, 31 * sizeof_reg
+	.cfi_offset	65, 36 * sizeof_reg		/* lr */
+	.cfi_offset	70, 38 * sizeof_reg		/* ccr */
+
+	/* Floating point registers */
+	.cfi_offset	32, offsetof_mcontext_fregs
+	.cfi_offset	33, offsetof_mcontext_fregs + 1 * sizeof_freg
+	.cfi_offset	34, offsetof_mcontext_fregs + 2 * sizeof_freg
+	.cfi_offset	35, offsetof_mcontext_fregs + 3 * sizeof_freg
+	.cfi_offset	36, offsetof_mcontext_fregs + 4 * sizeof_freg
+	.cfi_offset	37, offsetof_mcontext_fregs + 5 * sizeof_freg
+	.cfi_offset	38, offsetof_mcontext_fregs + 6 * sizeof_freg
+	.cfi_offset	39, offsetof_mcontext_fregs + 7 * sizeof_freg
+	.cfi_offset	40, offsetof_mcontext_fregs + 8 * sizeof_freg
+	.cfi_offset	41, offsetof_mcontext_fregs + 9 * sizeof_freg
+	.cfi_offset	42, offsetof_mcontext_fregs + 10 * sizeof_freg
+	.cfi_offset	43, offsetof_mcontext_fregs + 11 * sizeof_freg
+	.cfi_offset	44, offsetof_mcontext_fregs + 12 * sizeof_freg
+	.cfi_offset	45, offsetof_mcontext_fregs + 13 * sizeof_freg
+	.cfi_offset	46, offsetof_mcontext_fregs + 14 * sizeof_freg
+	.cfi_offset	47, offsetof_mcontext_fregs + 15 * sizeof_freg
+	.cfi_offset	48, offsetof_mcontext_fregs + 16 * sizeof_freg
+	.cfi_offset	49, offsetof_mcontext_fregs + 17 * sizeof_freg
+	.cfi_offset	50, offsetof_mcontext_fregs + 18 * sizeof_freg
+	.cfi_offset	51, offsetof_mcontext_fregs + 19 * sizeof_freg
+	.cfi_offset	52, offsetof_mcontext_fregs + 20 * sizeof_freg
+	.cfi_offset	53, offsetof_mcontext_fregs + 21 * sizeof_freg
+	.cfi_offset	54, offsetof_mcontext_fregs + 22 * sizeof_freg
+	.cfi_offset	55, offsetof_mcontext_fregs + 23 * sizeof_freg
+	.cfi_offset	56, offsetof_mcontext_fregs + 24 * sizeof_freg
+	.cfi_offset	57, offsetof_mcontext_fregs + 25 * sizeof_freg
+	.cfi_offset	58, offsetof_mcontext_fregs + 26 * sizeof_freg
+	.cfi_offset	59, offsetof_mcontext_fregs + 27 * sizeof_freg
+	.cfi_offset	60, offsetof_mcontext_fregs + 28 * sizeof_freg
+	.cfi_offset	61, offsetof_mcontext_fregs + 29 * sizeof_freg
+	.cfi_offset	62, offsetof_mcontext_fregs + 30 * sizeof_freg
+	.cfi_offset	63, offsetof_mcontext_fregs + 31 * sizeof_freg
+
+	/*
+	 * Unlike the kernel, unconditionally represent the Altivec/VSX regs.
+	 * The space within the stack frame is always available, and most of
+	 * our supported processors have them enabled.  The only complication
+	 * for PPC64 is the misalignment, so that we have to use indirection.
+	 */
+.macro	save_vreg_ofs reg, ofs
+#ifdef _ARCH_PPC64
+	/*
+	 * vreg = *(cfa + offsetof(v_regs)) + ofs
+         *
+         * The CFA is input to the expression on the stack, so:
+	 * DW_CFA_expression reg, length (7),
+         *   DW_OP_plus_uconst (0x23), vreg_ptr, DW_OP_deref (0x06),
+	 *   DW_OP_plus_uconst (0x23), ofs
+	 */
+	.cfi_escape 0x10, 77 + \reg, 7, 0x23, (offsetof_mcontext_vregs_ptr & 0x7f) + 0x80, offsetof_mcontext_vregs_ptr >> 7, 0x06, 0x23, (\ofs & 0x7f) | 0x80, \ofs >> 7
+#else
+	.cfi_offset 77 + \reg, offsetof_mcontext_vregs + \ofs
+#endif
+.endm
+
+.macro	save_vreg reg
+	save_vreg_ofs \reg, (\reg * sizeof_vreg)
+.endm
+
+	save_vreg   0
+	save_vreg   1
+	save_vreg   2
+	save_vreg   3
+	save_vreg   4
+	save_vreg   5
+	save_vreg   6
+	save_vreg   7
+	save_vreg   8
+	save_vreg   9
+	save_vreg  10
+	save_vreg  11
+	save_vreg  12
+	save_vreg  13
+	save_vreg  14
+	save_vreg  15
+	save_vreg  16
+	save_vreg  17
+	save_vreg  18
+	save_vreg  19
+	save_vreg  20
+	save_vreg  21
+	save_vreg  22
+	save_vreg  23
+	save_vreg  24
+	save_vreg  25
+	save_vreg  26
+	save_vreg  27
+	save_vreg  28
+	save_vreg  29
+	save_vreg  30
+	save_vreg  31
+	save_vreg  32
+	save_vreg_ofs 33, (32 * sizeof_vreg + 12)
+
+	nop
+
+__kernel_sigtramp_rt:
+	raw_syscall __NR_rt_sigreturn
+endf	__kernel_sigtramp_rt
+
+#ifndef _ARCH_PPC64
+	/*
+	 * The non-rt sigreturn has the same layout at a different offset.
+	 * Move the CFA and leave all othe other descriptions the same.
+	 */
+	.cfi_def_cfa	1, SIGNAL_FRAMESIZE + offsetof_sigframe_mcontext
+	nop
+__kernel_sigtramp32:
+	raw_syscall __NR_sigreturn
+endf	__kernel_sigtramp32
+#endif
+
+	.cfi_endproc
-- 
2.34.1


