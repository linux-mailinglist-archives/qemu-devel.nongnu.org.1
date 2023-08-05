Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C40157710A3
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 18:48:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSKQv-0008No-61; Sat, 05 Aug 2023 12:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSKQr-0008NS-7p
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 12:47:13 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSKQp-0007tB-5I
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 12:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691254028; x=1691858828; i=deller@gmx.de;
 bh=aiImUmpd2fT1Y/TxbR8ROm35t3T/UEkYrJjXBIgCFzY=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=TXufFTlCmzoRjRKzsByS9HKeIfqqKU9VDw4AsaucttwVdZJX0ETt8vLakqv1vceztJNmOzK
 XtRTE8sNPEtG3LL5NSgy1NJnBxOIiFAjM7goZPQlvhffYHsGXy5bnNVpbk/NrDevyGowMihKz
 VC5o78BnPBMQafXLRNMfp6l9bhE30XooH+WpabNVg3vBSSfAbjnp3SSvSmbgUW+Bpsa5FZOMO
 eBIu8qSm2CX4ZUbiIoO1luxuEDOGz72fLV01+UFPqbZNnhzFOUN8Y8nDslNRmDkDIrgZX09vb
 ogYd7jiTjc3QTW+M8iikBE7Uh2yAyAs+I7tLBLdLKnO2STocWIwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.145.133]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Msq6C-1pZOQV3dY8-00t8sN; Sat, 05
 Aug 2023 18:47:07 +0200
Date: Sat, 5 Aug 2023 18:47:06 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [RFC][PATCH] Reduce generated code by 3% by increasing MMU indices
Message-ID: <ZM59CkNZg5n4WXO3@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:GlkXCZT0ke+S058nSbDHpH3VkRj0sBFD76Sn3fC+Z1MB/vE4fHz
 HaeLhQvpgDlPPCOlHtB1q0pVOhv5VnctjDzZn3qTX/Oy8ZuoAyQyS6+a76NQ//bd1GZTTBB
 VN3RChcwQQYA41HFPlFwa7aMbkKoGnuQCiKdpariQu/rAcF9NwYPObwyAH+y06NWjkzrII8
 41Nod3LWMJRjDSsUVdFOA==
UI-OutboundReport: notjunk:1;M01:P0:QEFSZeuYtqc=;j8QMoI54EqzcJ5XqJoTXWhUCZ9+
 jGdm4JP4RRppHmsYJReeBWAIrFQXkyqF544djJno+9YLLOGt2Q6lMwerK51UzMKLLr2oScsqX
 675Fhqf5ng/OYIs2fo2XRqXNIxKO1V9s4Yx6ByhFTWmjm5n4qovtE+QU+GvDFfVrk0BNUJVsQ
 EMWmJgeNMhLU6JqxvvN3qqH9jARlHEES00NNUK3qnU4MiGbtHSJpYnAKj07VgIqLjjvIgq9rk
 Sdnk9bVWz1ysFKELoEUpzhw0Jl4iG7Y+/WL6zPJNbv4rA7Z5mANCasr7oYhITEM5bEQBP7Sc4
 hTFTwyXdvhcYcB7DMmMXOoeLHv8MSEccEGPujDaSdwh5OnpXq4PXRsGdpmnvTGR9b8gaVi/dU
 8P22kgbWlDKddqIWL5hzfyJRnRbpcQTF0q7dVhqKV8z0sh79p7yTLhyWfhI59oStb147RnjAS
 5BW0/Xhfca5ZENMYkWz/cuCMrkUfy3LlunvckKfM9eU9aeuncjVPWy+NQ96tCMx+w6kRfrs3Q
 qYh+vvXt6RwUoYSVFjNp52zqXTJED2iuAM9upmA1kp0Vu1RkDLI+18HkOuOsb/ib6+z3T8bUN
 K7rOb0iR3TflS/wtZ+gAcqC4/bOKe8LmFXtsF8/EYw7MRAqzugQ8C7+KGFEoVKDF020QZsHWH
 pNET5MAZj4573Ozmz0YPos+SaFUM9IMCdwW4w612BAR3kF9yYvv9ge/j2VJc8ew3JlRu23eRf
 +RQ3qyELKF7olCPqGurfn2gYrwO0pALcJxMe+nlH1tx9aKw70uKsOvOohUlb5femC4SIBRcEY
 vHfeTdufnkqzWE5cQDthLowwhnLSuJDxYe8Wciv7L9Hw9u7IbT9UO/xdL5E0zGbdThs8D7o2C
 s6FMxElPzVJz2P9CneF+yjK40VxiRfTHe1TaVnzSgxpSGQbPRwF6LwqasdEMJ4D30gENbGG0g
 jFv5rA==
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

This is a RFC, in which I want to bring up an option on how to reduce
the generated code size by in average 6 bytes for *every* memory-access
inside the guest. This applies to nearly every guest target on a
x86 host. Other hosts may benefit too, but I didn't checked.

In include/exec/cpu-defs.h the maximum number of MMU modes is
defined as:
#define NB_MMU_MODES 16

Most targets use less MMU indexes and define them similiar to this:
#define MMU_KERNEL_IDX   0
#define MMU_USER_IDX     1
#define MMU_PHYS_IDX     2

or, e.g. on ppc, by a function which gives some number in the range 0-7:

static inline int cpu_mmu_index(CPUPPCState *env, bool ifetch)
{
#ifdef CONFIG_USER_ONLY
    return MMU_USER_IDX;  /* MMU_USER_IDX is 0 */
#else
    return (env->hflags >> (ifetch ? HFLAGS_IMMU_IDX : HFLAGS_DMMU_IDX)) &=
 7;
#endif
}

When looking at the generated code for every memory-access in the guest,
the tcg generates a CPU TLB lookup in the fast path, e.g. for a
x86 guest on x86 host (only relevant part shown below):

IN:
0x000ebdf5:  8b 04 24                 movl     (%esp), %eax

OUT:
...
0x003619:  48 23 bd 10 ff ff ff     andq     -0xf0(%rbp), %rdi
0x003620:  48 03 bd 18 ff ff ff     addq     -0xe8(%rbp), %rdi
...

As can be seen, the TLB mask entry is accessed with a negative offset.

By re-defining the MMU indices to become 15,14,13 instead:

#define MMU_KERNEL_IDX   (NB_MMU_MODES - 1)
#define MMU_USER_IDX     (NB_MMU_MODES - 2)
#define MMU_PHYS_IDX     (NB_MMU_MODES - 3)

the (negative) offset is smaller, and the x86-64 tcg will generate
a 4-byte (instead of 7-byte) instruction:
OUT:
...
0x003499:  48 23 7d c0              andq     -0x40(%rbp), %rdi
0x00349d:  48 03 7d c8              addq     -0x38(%rbp), %rdi

So, every memory acces in the guest saves 6 bytes (=3D2 * 3 bytes)
of instruction code in the fast path.

Looking at the instruction address offsets (0x003619 vs. 0x003499)
it already saved 0x180 (384 decimal) bytes.
The first instruction was at offset 0x000000, so an overall
instruction size reduction of ~3% can be seen.

To reproduce I used this command:
./qemu-system-x86_64 -cdrom ./debian-12.1.0-amd64-netinst.iso \
        -boot d -nographic -d in_asm,out_asm


Do we want to enable such an performance optimization?
If so, I see two possibilities:

a) Re-define NB_MMU_MODES per target, with NB_MMU_MODES becoming
the highest MMU index needed for that target. This will probably
give another small performance improvement as the flush loop will
become shorter.

b) Increase the MMU index per target as shown in the patch below.
The patch below covers x86, ppc, alpha, hppa.
For arm, I believe it's sufficient to change ARM_MMU_IDX_M_PRIV=3D>0xf,
ARM_MMU_IDX_M_NEGPRI=3D0xe, and ARM_MMU_IDX_M_S=3D>0xd.

Opinions?

Helge



diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e0771a1043..d4aa6e7bee 100644
=2D-- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2251,11 +2251,11 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 #define cpu_list x86_cpu_list

 /* MMU modes definitions */
-#define MMU_KSMAP_IDX   0
-#define MMU_USER_IDX    1
-#define MMU_KNOSMAP_IDX 2
-#define MMU_NESTED_IDX  3
-#define MMU_PHYS_IDX    4
+#define MMU_KSMAP_IDX   (NB_MMU_MODES - 1)
+#define MMU_USER_IDX    (NB_MMU_MODES - 2)
+#define MMU_KNOSMAP_IDX (NB_MMU_MODES - 3)
+#define MMU_NESTED_IDX  (NB_MMU_MODES - 4)
+#define MMU_PHYS_IDX    (NB_MMU_MODES - 5)

 static inline int cpu_mmu_index(CPUX86State *env, bool ifetch)
 {
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 25fac9577a..a2a56781eb 100644
=2D-- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1474,13 +1474,14 @@ int ppc_dcr_write(ppc_dcr_t *dcr_env, int dcrn, ui=
nt32_t val);
 #define cpu_list ppc_cpu_list

 /* MMU modes definitions */
-#define MMU_USER_IDX 0
+#define MMU_USER_IDX (NB_MMU_MODES - 1)
 static inline int cpu_mmu_index(CPUPPCState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
     return MMU_USER_IDX;
 #else
-    return (env->hflags >> (ifetch ? HFLAGS_IMMU_IDX : HFLAGS_DMMU_IDX)) =
& 7;
+    return NB_MMU_MODES - 2
+           - ((env->hflags >> (ifetch ? HFLAGS_IMMU_IDX : HFLAGS_DMMU_IDX=
)) & 7);
 #endif
 }

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 13306665af..f25cf33e25 100644
=2D-- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -194,9 +194,9 @@ enum {
    PALcode cheats and uses the KSEG mapping for its code+data rather than
    physical addresses.  */

-#define MMU_KERNEL_IDX   0
-#define MMU_USER_IDX     1
-#define MMU_PHYS_IDX     2
+#define MMU_KERNEL_IDX   (NB_MMU_MODES - 1)
+#define MMU_USER_IDX     (NB_MMU_MODES - 2)
+#define MMU_PHYS_IDX     (NB_MMU_MODES - 3)

 typedef struct CPUArchState {
     uint64_t ir[31];
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 75c5c0ccf7..1c09602d0b 100644
=2D-- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -30,9 +30,9 @@
    basis.  It's probably easier to fall back to a strong memory model.  *=
/
 #define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL

-#define MMU_KERNEL_IDX   0
-#define MMU_USER_IDX     3
-#define MMU_PHYS_IDX     4
+#define MMU_KERNEL_IDX   (NB_MMU_MODES - 1)
+#define MMU_USER_IDX     (NB_MMU_MODES - 2)
+#define MMU_PHYS_IDX     (NB_MMU_MODES - 3)
 #define TARGET_INSN_START_EXTRA_WORDS 1

 /* Hardware exceptions, interrupts, faults, and traps.  */

