Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 939CC7E0D6B
	for <lists+qemu-devel@lfdr.de>; Sat,  4 Nov 2023 04:14:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qz768-0005n9-TX; Fri, 03 Nov 2023 23:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrtc4@cl.cam.ac.uk>)
 id 1qz766-0005mh-NJ; Fri, 03 Nov 2023 23:13:18 -0400
Received: from mta0.cl.cam.ac.uk ([2a05:b400:110::25:0])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrtc4@cl.cam.ac.uk>)
 id 1qz764-00033g-5O; Fri, 03 Nov 2023 23:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cl.cam.ac.uk; s=mta3; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HAmWVahrr0uINTDUWrbi1YYfOO8fauNzUZlhPGcxi8U=; t=1699067588; x=1699931588; 
 b=qgCCTer6pfS12iG23G6I1rXMQEqSJQ0K3yX78POErX4YBXw74o5aEPtJx4fq89O3RZtbYcp6dRz
 oS8Mn6s0THMKatKqJBkAiwZWoQRW2EvNv0p7xJ6ZI2EdI15TEWHeYgjSFdJPOgV8qQdYHswgthHxw
 AF3RUz4r30KmvsoSHuQ0q0EZKLHdQgVh8Ug+3NkRj4hHxiJYmM0muv0mt7PWVPEyhyYSHXDAwAhLB
 RmhSCvlhS2BLs+cachIXlCnVkVKnRj3DxqXDP5iiuceLPn0fOUd0UAjdyWjfEcXg14piwAMCp0KXK
 OkvYWmJwUz+J6RHHEqB9MqeXZMXhJXLtRCoQ==;
X-CL-Received-SPF: pass (mta0.cl.cam.ac.uk: )
 client-ip=2001:630:212:238:e63d:1aff:fe8d:4a70;
 envelope-from=jrtc4@cl.cam.ac.uk; helo=technos.cl.cam.ac.uk
Received-SPF: pass (mta0.cl.cam.ac.uk: )
 client-ip=2001:630:212:238:e63d:1aff:fe8d:4a70;
 envelope-from=jrtc4@cl.cam.ac.uk; helo=technos.cl.cam.ac.uk
Received: from technos.cl.cam.ac.uk
 ([2001:630:212:238:e63d:1aff:fe8d:4a70]:50692) (dnseec=no)
 by mta0.cl.cam.ac.uk:25 [2a05:b400:110::25:0] with esmtp
 (Exim 4.95) id 1qz75q-007Qgr-1w (envelope-from <jrtc4@cl.cam.ac.uk>);
 Sat, 04 Nov 2023 03:13:02 +0000
Received: from jrtc4 by technos.cl.cam.ac.uk with local (Exim 4.95)
 (envelope-from <jrtc4@cl.cam.ac.uk>) id 1qz75p-00Dciy-42;
 Sat, 04 Nov 2023 03:13:01 +0000
From: Jessica Clarke <jrtc27@jrtc27.com>
To: qemu-devel@nongnu.org
Cc: Jessica Clarke <jrtc27@jrtc27.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] accel/tcg: Forward probe size on to notdirty_write
Date: Sat,  4 Nov 2023 03:12:32 +0000
Message-Id: <20231104031232.3246614-1-jrtc27@jrtc27.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a05:b400:110::25:0;
 envelope-from=jrtc4@cl.cam.ac.uk; helo=mta0.cl.cam.ac.uk
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Without this, we just dirty a single byte, and so if the caller writes
more than one byte to the host memory then we won't have invalidated any
translation blocks that start after the first byte and overlap those
writes. In particular, AArch64's DC ZVA implementation uses probe_access
(via probe_write), and so we don't invalidate the entire block, only the
TB overlapping the first byte (and, in the unusual case an unaligned VA
is given to the instruction, we also probe that specific address in
order to get the right VA reported on an exception, so will invalidate a
TB overlapping that address too). Since our IC IVAU implementation is a
no-op for system emulation that relies on the softmmu already having
detected self-modifying code via this mechanism, this means we have
observably wrong behaviour when jumping to code that has been DC ZVA'ed.
In practice this is an unusual thing for software to do, as in reality
the OS will DC ZVA the page and the application will go and write actual
instructions to it that aren't UDF #0, but you can write a test that
clearly shows the faulty behaviour.

For functions other than probe_access it's not clear what size to use
when 0 is passed in. Arguably a size of 0 shouldn't dirty at all, since
if you want to actually write then you should pass in a real size, but I
have conservatively kept the implementation as dirtying the first byte
in that case so as to avoid breaking any assumptions about that
behaviour.

Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
---

Source code for the test case:

#include <sys/mman.h>

#include <errno.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

static void
sync_icache(void *start, void *end)
{
	uintptr_t start_addr = (uintptr_t)start;
	uintptr_t end_addr = (uintptr_t)end;
	size_t imin_line, dmin_line;
	uint64_t ctr_el0;
	uintptr_t addr;

	__asm__("mrs %0, ctr_el0" : "=r"(ctr_el0));

	/* Fields are Log2 words, i.e. Log2(bytes / 4) */
	imin_line = 4u << (ctr_el0 & 0xf);
	dmin_line = 4u << ((ctr_el0 >> 16) & 0xf);

	for (addr = start_addr & ~(dmin_line - 1); addr < end_addr;
	    addr += dmin_line)
		__asm__ __volatile__("dc cvau, %0" :: "r"(addr));

	__asm__ __volatile__("dsb ish");

	for (addr = start_addr & ~(imin_line - 1); addr < end_addr;
	    addr += imin_line)
		__asm__ __volatile__("ic ivau, %0" :: "r"(addr));

	__asm__ __volatile__("dsb ish");

	__asm__ __volatile__("isb");
}

int
main(void)
{
	uint32_t *insns;
	register uint64_t output __asm__("x0");

	insns = mmap(NULL, 4096, PROT_READ | PROT_WRITE | PROT_EXEC,
	    MAP_ANON | MAP_PRIVATE, -1, 0);
	if (insns == MAP_FAILED) {
		fprintf(stderr, "mmap failed: %s\n", strerror(errno));
		return (1);
	}

	insns[0] = 0xd5033fdf; /* ISB (to force new TB) */
	insns[1] = 0xd2800540; /* MOV X0, #42 */
	insns[2] = 0xd65f03c0; /* RET */

	sync_icache(insns, insns + 3);

	/* Prime TB cache */
	output = 0;
	__asm__ __volatile__("blr %1" : "+r"(output) : "r"(insns) : "x30");

	if (output != 42) {
		fprintf(stderr, "first run gave %lu not 42", output);
		return (1);
	}

	/* Demonstrate that jumping to insns + 1 currently works too */
	output = 0;
	__asm__ __volatile__("blr %1" : "+r"(output) : "r"(insns + 1) : "x30");

	if (output != 42) {
		fprintf(stderr, "second run gave %lu not 42", output);
		return (1);
	}

	__asm__ __volatile("dc zva, %0" :: "r"(insns) : "memory");

	if (insns[0] != 0 || insns[1] != 0 || insns[2] != 0) {
		fprintf(stderr, "DC ZVA didn't zero out entire function; "
		    "block size too small?\n");
		return (1);
	}

	sync_icache(insns, insns + 3);

	/* Now the actual test; this should be well-defined */
	output = 0;
	__asm__ __volatile__("blr %1" : "+r"(output) : "r"(insns + 1) : "x30");

	fprintf(stderr, "Did not trap on UDF #0!\n");
	if (output == 42)
		fprintf(stderr, "Executed stale MOV X0, #42\n");
	else
		fprintf(stderr, "Unexpected failure mode; output is %lu\n",
		    output);

	return (0);
}

Output without this patch (using FreeBSD as the host since it's what I
have easy access to):

root@freebsd-aarch64:~ # ./qemu-tb-dc-zva
Did not trap on UDF #0!
Executed stale MOV X0, #42

Output with this patch:

root@freebsd-aarch64:~ # ./qemu-tb-dc-zva
Illegal instruction (core dumped)

The latter is what I believe to be the only specified behaviour
(assuming the DC ZVA block size is big enough), and is what I observe on
multiple hardware implementations.

 accel/tcg/cputlb.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b8c5e345b8..a6c15d93ff 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1487,13 +1487,14 @@ int probe_access_full(CPUArchState *env, vaddr addr, int size,
                       bool nonfault, void **phost, CPUTLBEntryFull **pfull,
                       uintptr_t retaddr)
 {
+    int dirtysize = size == 0 ? 1 : size;
     int flags = probe_access_internal(env_cpu(env), addr, size, access_type,
                                       mmu_idx, nonfault, phost, pfull, retaddr,
                                       true);
 
     /* Handle clean RAM pages.  */
     if (unlikely(flags & TLB_NOTDIRTY)) {
-        notdirty_write(env_cpu(env), addr, 1, *pfull, retaddr);
+        notdirty_write(env_cpu(env), addr, dirtysize, *pfull, retaddr);
         flags &= ~TLB_NOTDIRTY;
     }
 
@@ -1506,6 +1507,7 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
 {
     void *discard_phost;
     CPUTLBEntryFull *discard_tlb;
+    int dirtysize = size == 0 ? 1 : size;
 
     /* privately handle users that don't need full results */
     phost = phost ? phost : &discard_phost;
@@ -1516,7 +1518,7 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
 
     /* Handle clean RAM pages.  */
     if (unlikely(flags & TLB_NOTDIRTY)) {
-        notdirty_write(env_cpu(env), addr, 1, *pfull, 0);
+        notdirty_write(env_cpu(env), addr, dirtysize, *pfull, 0);
         flags &= ~TLB_NOTDIRTY;
     }
 
@@ -1529,6 +1531,7 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
 {
     CPUTLBEntryFull *full;
     int flags;
+    int dirtysize = size == 0 ? 1 : size;
 
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
 
@@ -1538,7 +1541,7 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
 
     /* Handle clean RAM pages. */
     if (unlikely(flags & TLB_NOTDIRTY)) {
-        notdirty_write(env_cpu(env), addr, 1, full, retaddr);
+        notdirty_write(env_cpu(env), addr, dirtysize, full, retaddr);
         flags &= ~TLB_NOTDIRTY;
     }
 
@@ -1574,7 +1577,7 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
 
         /* Handle clean RAM pages.  */
         if (flags & TLB_NOTDIRTY) {
-            notdirty_write(env_cpu(env), addr, 1, full, retaddr);
+            notdirty_write(env_cpu(env), addr, size, full, retaddr);
         }
     }
 
-- 
2.34.1


