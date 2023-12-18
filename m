Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B1C816F0B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 13:58:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFDBC-0001qe-Mn; Mon, 18 Dec 2023 07:57:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <0102018c7d0026c1-fd5f0b50-48fd-4552-be0a-cbb6070b5e14-000000@eu-west-1.amazonses.com>)
 id 1rFDB7-0001D8-8A; Mon, 18 Dec 2023 07:57:01 -0500
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from
 <0102018c7d0026c1-fd5f0b50-48fd-4552-be0a-cbb6070b5e14-000000@eu-west-1.amazonses.com>)
 id 1rFDB4-0005ZA-7a; Mon, 18 Dec 2023 07:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=we7ia3fxgawvchs62qr3tqnz7sf6mlor; d=ipxe.org; t=1702904211;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
 bh=c4pv0S6+ZnrrN0Bf1oFCunpKh6ehbM0Y+HfBKgavp7A=;
 b=YZYzZBkgY3V92N4N/CRbj6B9HlV8tygPU0e0+k2xI1VNYBMJuyltzvzgt5OwVbrp
 8mk5eYFQ+9IRhLKVRHjRewW55gv4j4BT1mISunCynrw2r8H3cJn7h8rW3nMFBCLBThG
 z3LzQLEUmPjSg6oGsBrgH3NdVyhhkr3QqFKiAwmQB2Yg4MhNojNB6MJWgPIxvoui1+c
 45QNUNX3LbbGoxf0WKCB7TUEYyvfX1Nz6PQKlDRgyoffmPUkhiyfANcozMLyyepsB3i
 3E2oi/soGZMzg4TwFVzIPKceDJYDDe8npXKft1Dp/MnBLVpfCREKQNlMzEGiJKknIr6
 rHWmTGPn9g==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1702904211;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
 bh=c4pv0S6+ZnrrN0Bf1oFCunpKh6ehbM0Y+HfBKgavp7A=;
 b=fTFaCAJvhQKnDXoWLChknkEJ/fbWB7UDnXnSLHFJYYB9IxCnGFP/N3eix7XDW6QI
 6yI3K29QT+EIsSXG2Pu1h+DVhfBVWJpg6f6fiblfr+DYQ3t58tG/1GTLyRqjDkh2nZw
 UVrL/D1e6O+62N5TOsCPRTsu9XqgeY+h5YYpXVzc=
From: Michael Brown <mcb30@ipxe.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Brown <mcb30@ipxe.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH] target/i386: Fix physical address truncation when PAE is
 enabled
Date: Mon, 18 Dec 2023 12:56:51 +0000
Message-ID: <0102018c7d0026c1-fd5f0b50-48fd-4552-be0a-cbb6070b5e14-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.eu-west-1.fspj4M/5bzJ9NLRzJP0PaxRwxrpZqiDQJ1IF94CF2TA=:AmazonSES
X-SES-Outgoing: 2023.12.18-54.240.7.12
Received-SPF: pass client-ip=54.240.7.12;
 envelope-from=0102018c7d0026c1-fd5f0b50-48fd-4552-be0a-cbb6070b5e14-000000@eu-west-1.amazonses.com;
 helo=a7-12.smtp-out.eu-west-1.amazonses.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The address translation logic in get_physical_address() will currently
truncate physical addresses to 32 bits unless long mode is enabled.
This is incorrect when using physical address extensions (PAE) outside
of long mode, with the result that a 32-bit operating system using PAE
to access memory above 4G will experience undefined behaviour.

The truncation code was originally introduced in commit 33dfdb5 ("x86:
only allow real mode to access 32bit without LMA"), where it applied
only to translations performed while paging is disabled (and so cannot
affect guests using PAE).

Commit 9828198 ("target/i386: Add MMU_PHYS_IDX and MMU_NESTED_IDX")
rearranged the code such that the truncation also applied to the use
of MMU_PHYS_IDX and MMU_NESTED_IDX.  Commit 4a1e9d4 ("target/i386: Use
atomic operations for pte updates") brought this truncation into scope
for page table entry accesses, and is the first commit for which a
Windows 10 32-bit guest will reliably fail to boot if memory above 4G
is present.

Fix by testing for PAE being enabled via the relevant bit in CR4,
instead of testing for long mode being enabled.  PAE must be enabled
as a prerequisite of long mode, and so this is a generalisation of the
current test.

Remove the #ifdef TARGET_X86_64 check since PAE exists in both 32-bit
and 64-bit processors, and both should exhibit the same truncation
behaviour when PAE is disabled.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2040
Signed-off-by: Michael Brown <mcb30@ipxe.org>
---
 target/i386/tcg/sysemu/excp_helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 5b86f439ad..3d0d0d78d7 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -582,12 +582,10 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
 
     /* Translation disabled. */
     out->paddr = addr & x86_get_a20_mask(env);
-#ifdef TARGET_X86_64
-    if (!(env->hflags & HF_LMA_MASK)) {
-        /* Without long mode we can only address 32bits in real mode */
+    if (!(env->cr[4] & CR4_PAE_MASK)) {
+        /* Without PAE we can address only 32 bits */
         out->paddr = (uint32_t)out->paddr;
     }
-#endif
     out->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
     out->page_size = TARGET_PAGE_SIZE;
     return true;
-- 
2.43.0


