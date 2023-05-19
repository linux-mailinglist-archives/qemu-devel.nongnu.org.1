Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2806B709874
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 15:38:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q00IV-0006Jq-8f; Fri, 19 May 2023 09:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q00IQ-0006IA-0E
 for qemu-devel@nongnu.org; Fri, 19 May 2023 09:37:26 -0400
Received: from hoth.uni-paderborn.de ([2001:638:502:c003::19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q00IK-0006oq-FF
 for qemu-devel@nongnu.org; Fri, 19 May 2023 09:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fxI3lY5n3YQ/x0qnQFZh2hPeLQejCpNPXwmUZLRy6PQ=; b=Ug+ov2PfStJxaUPo3gbayf7Jav
 QXJbht1U4HC2sr4Vo/jgQ1nUYd2EoikGN7EoO+z129XDKVs2F4W9vsqoiCxENuQELA65wX3HYf2rE
 B2KXVLFcOM+HeCm93wqurb1syWl/pMmL42Izn78dfJQyIv++0av0kv0s4bIDOln0N7+k=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PATCH 3/6] tests/tcg/tricore: Add first C program
Date: Fri, 19 May 2023 15:36:47 +0200
Message-Id: <20230519133650.575600-4-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519133650.575600-1-kbastian@mail.uni-paderborn.de>
References: <20230519133650.575600-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.5.19.132723, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.5.16.600001
X-Sophos-SenderHistory: ip=84.154.188.104, fs=17, da=172112502, mc=6, sc=0,
 hc=6, sp=0, fso=17, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::19;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=hoth.uni-paderborn.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

this allows us to exercise the startup code used by GCC to call main().

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 configure                                 |   1 +
 tests/tcg/tricore/Makefile.softmmu-target |  13 +
 tests/tcg/tricore/c/crt0-tc2x.S           | 335 ++++++++++++++++++++++
 tests/tcg/tricore/c/test_boot_to_main.c   |  13 +
 tests/tcg/tricore/c/testdev_assert.h      |  18 ++
 tests/tcg/tricore/link.ld                 |  16 ++
 6 files changed, 396 insertions(+)
 create mode 100644 tests/tcg/tricore/c/crt0-tc2x.S
 create mode 100644 tests/tcg/tricore/c/test_boot_to_main.c
 create mode 100644 tests/tcg/tricore/c/testdev_assert.h

diff --git a/configure b/configure
index 800b5850f4..156284fe56 100755
--- a/configure
+++ b/configure
@@ -2040,6 +2040,7 @@ probe_target_compiler() {
         container_cross_prefix=tricore-
         container_cross_as=tricore-as
         container_cross_ld=tricore-ld
+        container_cross_cc=tricore-gcc
         break
         ;;
       x86_64)
diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricore/Makefile.softmmu-target
index ad90a3b46f..5d282e0dda 100644
--- a/tests/tcg/tricore/Makefile.softmmu-target
+++ b/tests/tcg/tricore/Makefile.softmmu-target
@@ -1,8 +1,10 @@
 TESTS_PATH = $(SRC_PATH)/tests/tcg/tricore
 ASM_TESTS_PATH = $(TESTS_PATH)/asm
+C_TESTS_PATH = $(TESTS_PATH)/c
 
 LDFLAGS = -T$(TESTS_PATH)/link.ld --mcpu=tc162
 ASFLAGS = -mtc162
+CFLAGS = -mtc162 -c
 
 TESTS += test_abs.asm.tst
 TESTS += test_bmerge.asm.tst
@@ -20,6 +22,8 @@ TESTS += test_madd.asm.tst
 TESTS += test_msub.asm.tst
 TESTS += test_muls.asm.tst
 
+TESTS += test_boot_to_main.c.tst
+
 QEMU_OPTS += -M tricore_testboard -cpu tc27x -nographic -kernel
 
 %.pS: $(ASM_TESTS_PATH)/%.S
@@ -30,3 +34,12 @@ QEMU_OPTS += -M tricore_testboard -cpu tc27x -nographic -kernel
 
 %.asm.tst: %.o
 	$(LD) $(LDFLAGS) $< -o $@
+
+crt0-tc2x.o: $(C_TESTS_PATH)/crt0-tc2x.S
+	$(AS) $(ASFLAGS) -o $@ $<
+
+%.o: $(C_TESTS_PATH)/%.c
+	$(CC) $(CFLAGS) -o $@ $<
+
+%.c.tst: %.o crt0-tc2x.o
+	$(LD) $(LDFLAGS) -o $@ $^
diff --git a/tests/tcg/tricore/c/crt0-tc2x.S b/tests/tcg/tricore/c/crt0-tc2x.S
new file mode 100644
index 0000000000..3100da123c
--- /dev/null
+++ b/tests/tcg/tricore/c/crt0-tc2x.S
@@ -0,0 +1,335 @@
+/*
+ * crt0-tc2x.S -- Startup code for GNU/TriCore applications.
+ *
+ * Copyright (C) 1998-2014 HighTec EDV-Systeme GmbH.
+ *
+ * This file is part of GCC.
+ *
+ * GCC is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 3, or (at your option)
+ * any later version.
+ *
+ * GCC is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Under Section 7 of GPL version 3, you are granted additional
+ * permissions described in the GCC Runtime Library Exception, version
+ * 3.1, as published by the Free Software Foundation.
+ *
+ * You should have received a copy of the GNU General Public License and
+ * a copy of the GCC Runtime Library Exception along with this program;
+ * see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see
+ * <http://www.gnu.org/licenses/>.  */
+
+/* Define the Derivate Name as a hexvalue. This value
+ * is built-in defined in tricore-c.c (from tricore-devices.c)
+ * the derivate number as a hexvalue (e.g. TC1796 => 0x1796
+ * This name will be used in the memory.x Memory description to
+ * to confirm that the crt0.o and the memory.x will be get from
+ * same directory
+ */
+    .section ".startup_code", "ax", @progbits
+    .global _start
+    .type _start,@function
+
+/* default BMI header (only TC2xxx devices) */
+    .word   0x00000000
+    .word   0xb3590070
+    .word   0x00000000
+    .word   0x00000000
+    .word   0x00000000
+    .word   0x00000000
+    .word   0x791eb864
+    .word   0x86e1479b
+
+_start:
+    .code32
+    j   _startaddr
+    .align  2
+
+_startaddr:
+    /*
+     * initialize user and interrupt stack pointers
+     */
+    movh.a  %sp,hi:__USTACK         # load %sp
+    lea %sp,[%sp]lo:__USTACK
+    movh    %d0,hi:__ISTACK         # load $isp
+    addi    %d0,%d0,lo:__ISTACK
+    mtcr    $isp,%d0
+    isync
+
+#;  install trap handlers
+
+    movh    %d0,hi:first_trap_table     #; load $btv
+    addi    %d0,%d0,lo:first_trap_table
+    mtcr    $btv,%d0
+    isync
+
+    /*
+     * initialize call depth counter
+     */
+
+    mfcr    %d0,$psw
+    or  %d0,%d0,0x7f            # disable call depth counting
+    andn    %d0,%d0,0x80            # clear CDE bit
+    mtcr    $psw,%d0
+    isync
+
+    /*
+     * initialize access to system global registers
+     */
+
+    mfcr    %d0,$psw
+    or  %d0,%d0,0x100           # set GW bit
+    mtcr    $psw,%d0
+    isync
+
+    /*
+     * initialize SDA base pointers
+     */
+    .global _SMALL_DATA_,_SMALL_DATA2_,_SMALL_DATA3_,_SMALL_DATA4_
+    .weak _SMALL_DATA_,_SMALL_DATA2_,_SMALL_DATA3_,_SMALL_DATA4_
+
+    movh.a  %a0,hi:_SMALL_DATA_     # %a0 addresses .sdata/.sbss
+    lea %a0,[%a0]lo:_SMALL_DATA_
+    movh.a  %a1,hi:_SMALL_DATA2_        # %a1 addresses .sdata2/.sbss2
+    lea %a1,[%a1]lo:_SMALL_DATA2_
+    movh.a  %a8,hi:_SMALL_DATA3_        # %a8 addresses .sdata3/.sbss3
+    lea %a8,[%a8]lo:_SMALL_DATA3_
+    movh.a  %a9,hi:_SMALL_DATA4_        # %a9 addresses .sdata4/.sbss4
+    lea %a9,[%a9]lo:_SMALL_DATA4_
+
+    /*
+     * reset access to system global registers
+     */
+
+    mfcr    %d0,$psw
+    andn    %d0,%d0,0x100           # clear GW bit
+    mtcr    $psw,%d0
+    isync
+
+    /*
+     * initialize context save areas
+     */
+
+    jl  __init_csa
+
+
+
+    /*
+     * handle clear table (i.e., fill BSS with zeros)
+     */
+
+    jl  __clear_table_func
+
+
+    /*
+     * handle copy table (support for romable code)
+     */
+
+    jl  __copy_table_func
+
+
+    /*
+     * _exit (main (0, NULL));
+     */
+    mov %d4,0               # argc = 0
+    sub.a   %sp,8
+    st.w    [%sp]0,%d4
+    st.w    [%sp]4,%d4
+    mov.aa  %a4,%sp             # argv
+
+    call    main                # int retval = main (0, NULL);
+    mov.a   %a14,%d2        # move exit code to match trap handler
+    j   _exit               # _exit (retval);
+
+    debug                   # should never come here
+
+
+    /*
+     * initialize context save areas (CSAs), PCXI, LCX and FCX
+     */
+
+    .global __init_csa
+    .type __init_csa,function
+
+__init_csa:
+    movh    %d0,0
+    mtcr    $pcxi,%d0
+    isync
+    movh    %d0,hi:__CSA_BEGIN      #; %d0 = begin of CSA
+    addi    %d0,%d0,lo:__CSA_BEGIN
+    addi    %d0,%d0,63          #; force alignment (2^6)
+    andn    %d0,%d0,63
+    movh    %d2,hi:__CSA_END        #; %d2 = end of CSA
+    addi    %d2,%d2,lo:__CSA_END
+    andn    %d2,%d2,63          #; force alignment (2^6)
+    sub %d2,%d2,%d0
+    sh  %d2,%d2,-6          #; %d2 = number of CSAs
+    mov.a   %a3,%d0             #; %a3 = address of first CSA
+    extr.u  %d0,%d0,28,4            #; %d0 = segment << 16
+    sh  %d0,%d0,16
+    lea %a4,0               #; %a4 = previous CSA = 0
+    st.a    [%a3],%a4           #; store it in 1st CSA
+    mov.aa  %a4,%a3             #; %a4 = current CSA
+    lea %a3,[%a3]64         #; %a3 = %a3->nextCSA
+    mov.d   %d1,%a3
+    extr.u  %d1,%d1,6,16            #; get CSA index
+    or  %d1,%d1,%d0         #; add segment number
+    mtcr    $lcx,%d1            #; initialize LCX
+    add %d2,%d2,-2          #; CSAs to initialize -= 2
+    mov.a   %a5,%d2             #; %a5 = loop counter
+csa_loop:
+    mov.d   %d1,%a4             #; %d1 = current CSA address
+    extr.u  %d1,%d1,6,16            #; get CSA index
+    or  %d1,%d1,%d0         #; add segment number
+    st.w    [%a3],%d1           #; store "nextCSA" pointer
+    mov.aa  %a4,%a3             #; %a4 = current CSA address
+    lea %a3,[%a3]64         #; %a3 = %a3->nextCSA
+    loop    %a5,csa_loop            #; repeat until done
+
+    mov.d   %d1,%a4             #; %d1 = current CSA address
+    extr.u  %d1,%d1,6,16            #; get CSA index
+    or  %d1,%d1,%d0         #; add segment number
+    mtcr    $fcx,%d1            #; initialize FCX
+    isync
+    ji  %a11
+
+
+
+
+    /*
+     * handle clear table (i.e., fill BSS with zeros)
+     */
+    .global __clear_table_func
+    .type __clear_table_func,@function
+
+__clear_table_func:
+    mov %d14,0              # %e14 = 0
+    mov %d15,0
+    movh.a  %a13,hi:__clear_table       # %a13 = &first table entry
+    lea %a13,[%a13]lo:__clear_table
+
+__clear_table_next:
+    ld.a    %a15,[%a13+]4           # %a15 = current block base
+    ld.w    %d3,[%a13+]4            # %d3 = current block length
+    jeq %d3,-1,__clear_table_done   # length == -1 => end of table
+    sh  %d0,%d3,-3          # %d0 = length / 8 (doublewords)
+    and %d1,%d3,7           # %d1 = length % 8 (rem. bytes)
+    jz  %d0,__clear_word        # block size < 8 => clear word
+    addi    %d0,%d0,-1          # else doublewords -= 1
+    mov.a   %a2,%d0             # %a2 = loop counter
+__clear_dword:
+    st.d    [%a15+]8,%e14           # clear one doubleword
+    loop    %a2,__clear_dword
+__clear_word:
+    jz  %d1,__clear_table_next
+    sh  %d0,%d1,-2          # %d0 = length / 4 (words)
+    and %d1,%d1,3           # %d1 = length % 4 (rem. bytes)
+    jz  %d0,__clear_hword       # block size < 4 => clear hword
+    st.w    [%a15+]4,%d15           # clear one word
+__clear_hword:
+    jz  %d1,__clear_table_next
+    sh  %d0,%d1,-1          # %d0 = length / 2 (halfwords)
+    and %d1,%d1,1           # %d1 = length % 2 (rem. bytes)
+    jz  %d0,__clear_byte        # block size < 2 => clear byte
+    st.h    [%a15+]2,%d15           # clear one halfword
+__clear_byte:
+    jz  %d1,__clear_table_next
+    st.b    [%a15],%d15         # clear one byte
+    j   __clear_table_next      # handle next clear table entry
+__clear_table_done:
+
+    ji  %a11
+
+
+
+    /*
+     * handle copy table (support for romable code)
+     */
+    .global __copy_table_func
+    .type __copy_table_func,@function
+
+__copy_table_func:
+    movh.a  %a13,hi:__copy_table        # %a13 = &first table entry
+    lea %a13,[%a13]lo:__copy_table
+
+__copy_table_next:
+    ld.a    %a15,[%a13+]4           # %a15 = src address
+    ld.a    %a14,[%a13+]4           # %a14 = dst address
+    ld.w    %d3,[%a13+]4            # %d3 = block length
+    jeq %d3,-1,__copy_table_done    # length == -1 => end of table
+    sh  %d0,%d3,-3          # %d0 = length / 8 (doublewords)
+    and %d1,%d3,7           # %d1 = lenght % 8 (rem. bytes)
+    jz  %d0,__copy_word         # block size < 8 => copy word
+    addi    %d0,%d0,-1          # else doublewords -= 1
+    mov.a   %a2,%d0             # %a2 = loop counter
+__copy_dword:
+    ld.d    %e14,[%a15+]8           # copy one doubleword
+    st.d    [%a14+]8,%e14
+    loop    %a2,__copy_dword
+__copy_word:
+    jz  %d1,__copy_table_next
+    sh  %d0,%d1,-2          # %d0 = length / 4 (words)
+    and %d1,%d1,3           # %d1 = lenght % 4 (rem. bytes)
+    jz  %d0,__copy_hword        # block size < 4 => copy hword
+    ld.w    %d14,[%a15+]4           # copy one word
+    st.w    [%a14+]4,%d14
+__copy_hword:
+    jz  %d1,__copy_table_next
+    sh  %d0,%d1,-1          # %d0 = length / 2 (halfwords)
+    and %d1,%d1,1           # %d1 = length % 2 (rem. bytes)
+    jz  %d0,__copy_byte         # block size < 2 => copy byte
+    ld.h    %d14,[%a15+]2           # copy one halfword
+    st.h    [%a14+]2,%d14
+__copy_byte:
+    jz  %d1,__copy_table_next
+    ld.b    %d14,[%a15]0            # copy one byte
+    st.b    [%a14],%d14
+    j   __copy_table_next       # handle next copy table entry
+__copy_table_done:
+
+    ji  %a11
+
+_exit:
+    movh.a %a15, hi:__TESTDEVICE
+    lea %a15,[%a15]lo:__TESTDEVICE
+    mov.d %d2, %a14
+    st.w [%a15], %d2 # write exit code to testdevice
+    debug
+
+/*============================================================================*
+ * Exception handlers (exceptions in startup code)
+ *
+ * This is a minimal trap vector table, which consists of eight
+ * entries, each consisting of eight words (32 bytes).
+ *============================================================================*/
+
+
+#;  .section .traptab, "ax", @progbits
+
+.macro trapentry from=0, to=7
+    mov.u   %d14, \from << 8
+    add %d14,%d14,%d15
+    mov.a   %a14,%d14
+    addih.a %a14,%a14,0 # if we trap, we fail
+    j   _exit
+0:
+    j   0b
+    nop
+    rfe
+    .align 5
+
+    .if \to-\from
+    trapentry "(\from+1)",\to
+    .endif
+.endm
+
+    .align 8
+    .global first_trap_table
+first_trap_table:
+    trapentry 0, 7
+
diff --git a/tests/tcg/tricore/c/test_boot_to_main.c b/tests/tcg/tricore/c/test_boot_to_main.c
new file mode 100644
index 0000000000..fa28a5b433
--- /dev/null
+++ b/tests/tcg/tricore/c/test_boot_to_main.c
@@ -0,0 +1,13 @@
+/*
+ * Copyright (C) 2023 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "testdev_assert.h"
+int main(int argc, char **argv)
+{
+    testdev_assert(1);
+    return 0;
+}
diff --git a/tests/tcg/tricore/c/testdev_assert.h b/tests/tcg/tricore/c/testdev_assert.h
new file mode 100644
index 0000000000..ccd14f5025
--- /dev/null
+++ b/tests/tcg/tricore/c/testdev_assert.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2023 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+int *testdev = (int *)0xf0000000;
+
+#define FAIL 1
+static inline void testdev_assert(int condition)
+{
+    if (!condition) {
+        *testdev = FAIL;
+        asm("debug");
+    }
+}
+
diff --git a/tests/tcg/tricore/link.ld b/tests/tcg/tricore/link.ld
index 364bcdc00a..acc1758c41 100644
--- a/tests/tcg/tricore/link.ld
+++ b/tests/tcg/tricore/link.ld
@@ -12,6 +12,7 @@ MEMORY
 /*
  * Define the sizes of the user and system stacks.
  */
+__ISTACK_SIZE = DEFINED (__ISTACK_SIZE) ? __ISTACK_SIZE : 256 ;
 __USTACK_SIZE = DEFINED (__USTACK_SIZE) ? __USTACK_SIZE : 1K ;
 /*
  * Define the start address and the size of the context save area.
@@ -20,6 +21,8 @@ __CSA_BEGIN =  0xd0000000 ;
 __CSA_SIZE =  8k ;
 __CSA_END = __CSA_BEGIN + __CSA_SIZE ;
 
+__TESTDEVICE = 0xf0000000 ;
+
 SECTIONS
 {
   .text  :
@@ -32,6 +35,18 @@ SECTIONS
   {
     *(.rodata)
     *(.rodata1)
+    /*
+     * Create the clear and copy tables that tell the startup code
+     * which memory areas to clear and to copy, respectively.
+     */
+    . = ALIGN(4) ;
+    PROVIDE(__clear_table = .) ;
+    LONG(0 + ADDR(.bss));     LONG(SIZEOF(.bss));
+    LONG(-1);                 LONG(-1);
+    PROVIDE(__copy_table = .) ;
+    LONG(LOADADDR(.data));    LONG(0 + ADDR(.data));    LONG(SIZEOF(.data));
+    LONG(-1);                 LONG(-1);                 LONG(-1);
+    . = ALIGN(8);
   } > data_ram
 
   .data :
@@ -40,6 +55,7 @@ SECTIONS
     *(.data)
     *(.data.*)
     . = ALIGN(8) ;
+    __ISTACK = . + __ISTACK_SIZE ;
     __USTACK = . + __USTACK_SIZE -768;
 
   } > data_ram
-- 
2.40.1


