Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9C481BB52
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 16:50:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGLJ4-0005Kw-N6; Thu, 21 Dec 2023 10:49:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <0102018c8d11471f-9a6d73eb-0c34-4f61-8d37-5a4418f9e0d7-000000@eu-west-1.amazonses.com>)
 id 1rGLIl-0005Fm-AV; Thu, 21 Dec 2023 10:49:35 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from
 <0102018c8d11471f-9a6d73eb-0c34-4f61-8d37-5a4418f9e0d7-000000@eu-west-1.amazonses.com>)
 id 1rGLIi-0001NN-Qj; Thu, 21 Dec 2023 10:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=we7ia3fxgawvchs62qr3tqnz7sf6mlor; d=ipxe.org; t=1703173769;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=/7EqWffgjDz3wjDvQr/YUcPA/PtuSbw8QfNks2xe3Bo=;
 b=Uk5vxuwtFqHUEjy/9w9w8P13sf3j8S8iA3FWWLtx2iyb7kSz+It/P5hrJHQR+cMq
 4ZWLqGHGXIgJm51WGGpkvgZNYpS3iROofhQG4cZHC2FE7bGeyjJPk4R1oGe5DjmAy/A
 PFlZc7QmRtDE/fmdDMqck/ZeMj0KqqbN2Eh5o6uUjcJsTTYUFmADQbA9nVkrIk7Uy7s
 yZGGJ7pMx8YE1cZJZM4Mvcnr6gfg+NrE9UrsPxNI9dIelpX954GHTWFM8LtXzCQsY7l
 4VkQOswvb9oB2d99Sm7n43Uqhnj3MT6w3DbunSix/T5Kjf7SAD6dwqhFK91A7Q/P+nv
 F0juKPLepw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1703173769;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
 bh=/7EqWffgjDz3wjDvQr/YUcPA/PtuSbw8QfNks2xe3Bo=;
 b=tk7rakoxIQBkBF4B6BFXPIzT8EHTKwYVHJcgrXJ4byvqGJc7a5pV6sys49kgp+6l
 KsmABfP3g5pbRcByQQ975wV7QhRuulYXD+5Jaz2H1DVRu9vWugoMzO+vuIcndXRGCnw
 B/xMKtm7mkBul4UBsgsqXer1ofWesaGEK/GaFLyU=
From: Michael Brown <mcb30@ipxe.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Brown <mcb30@ipxe.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2] target/i386: Fix physical address truncation
Date: Thu, 21 Dec 2023 15:49:29 +0000
Message-ID: <0102018c8d11471f-9a6d73eb-0c34-4f61-8d37-5a4418f9e0d7-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <25995a01-720e-485a-b7c2-36ec612a888b@ipxe.org>
References: <25995a01-720e-485a-b7c2-36ec612a888b@ipxe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.eu-west-1.fspj4M/5bzJ9NLRzJP0PaxRwxrpZqiDQJ1IF94CF2TA=:AmazonSES
X-SES-Outgoing: 2023.12.21-54.240.7.18
Received-SPF: pass client-ip=54.240.7.18;
 envelope-from=0102018c8d11471f-9a6d73eb-0c34-4f61-8d37-5a4418f9e0d7-000000@eu-west-1.amazonses.com;
 helo=a7-18.smtp-out.eu-west-1.amazonses.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

The original truncation code (now ten years old) appears to be wholly
redundant in the current codebase.  With paging disabled, the CPU
cannot be in long mode and so the maximum address size for any
executed instruction is 32 bits.  This will already cause the linear
address to be truncated to 32 bits, and there is therefore no way for
get_physical_address() to be asked to translate an address outside of
the 32-bit range.

Fix by removing the address truncation in get_physical_address().

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2040
Signed-off-by: Michael Brown <mcb30@ipxe.org>
---
 target/i386/tcg/sysemu/excp_helper.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 5b86f439ad..707f7326d4 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -582,12 +582,6 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
 
     /* Translation disabled. */
     out->paddr = addr & x86_get_a20_mask(env);
-#ifdef TARGET_X86_64
-    if (!(env->hflags & HF_LMA_MASK)) {
-        /* Without long mode we can only address 32bits in real mode */
-        out->paddr = (uint32_t)out->paddr;
-    }
-#endif
     out->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
     out->page_size = TARGET_PAGE_SIZE;
     return true;
-- 
2.43.0


