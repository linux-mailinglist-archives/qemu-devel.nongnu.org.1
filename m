Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A567B22AE
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 18:44:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlu5v-00026B-Bd; Thu, 28 Sep 2023 12:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1qlu5j-00025v-Qh
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 12:42:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1qlu5h-0001SS-Ai
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 12:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695919335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=ETQ4Pkv90xdeE68+qtj2nVNmslQVpcD3SDdJPZ8eTJ0=;
 b=WBmMc9qqp4Yqy2zUM5gAmZiMfvccqiK+tbFdtLnvMBTf/2r8fVd72FTpXojOrinNBXmK98
 HJQf7i54XCLDVUtifUfTbU7nLT2/DNRVQDjussZChLEDoXDG6M/yoCcmhHAgZ66Y7OMO91
 B/yvtG/tIzGFiRx7ooZ7DCMekJ8Vrms=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-bZpFvB9KOk2wGiTbO3LESw-1; Thu, 28 Sep 2023 12:42:09 -0400
X-MC-Unique: bZpFvB9KOk2wGiTbO3LESw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5100A85A5BD;
 Thu, 28 Sep 2023 16:42:09 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown
 [10.11.5.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC2E3140E969;
 Thu, 28 Sep 2023 16:42:08 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix,
 from userid 12668)
 id 9982530C1C0A; Thu, 28 Sep 2023 16:42:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id
 95CFE3FD54; Thu, 28 Sep 2023 18:42:08 +0200 (CEST)
Date: Thu, 28 Sep 2023 18:42:08 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Richard Henderson <rth@twiddle.net>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Magnus Damm <magnus.damm@gmail.com>
cc: qemu-devel@nongnu.org
Subject: [PATCH] target/sh4: fix crashes on signal delivery
Message-ID: <b16389f7-6c62-70b7-59b3-87533c0bcc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mpatocka@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

sh4 uses gUSA (general UserSpace Atomicity) to provide atomicity on CPUs
that don't have atomic instructions. A gUSA region that adds 1 to an
atomic variable stored in @R2 looks like this:

  4004b6:       03 c7           mova    4004c4 <gusa+0x10>,r0
  4004b8:       f3 61           mov     r15,r1
  4004ba:       09 00           nop
  4004bc:       fa ef           mov     #-6,r15
  4004be:       22 63           mov.l   @r2,r3
  4004c0:       01 73           add     #1,r3
  4004c2:       32 22           mov.l   r3,@r2
  4004c4:       13 6f           mov     r1,r15

R0 contains a pointer to the end of the gUSA region
R1 contains the saved stack pointer
R15 contains negative length of the gUSA region

When this region is interrupted by a signal, the kernel detects if
R15 >= -128U. If yes, the kernel rolls back PC to the beginning of the
region and restores SP by copying R1 to R15.

The problem happens if we are interrupted by a signal at address 4004c4.
R15 still holds the value -6, but the atomic value was already written by
an instruction at address 4004c2. In this situation we can't undo the
gUSA. The function unwind_gusa does nothing, the signal handler attempts
to push a signal frame to the address -6 and crashes.

This patch fixes it, so that if we are interrupted at the last instruction 
in a gUSA region, we copy R1 to R15 to restore the correct stack pointer 
and avoid crashing.

There's another bug: if we are interrupted in a delay slot, we save the
address of the instruction in the delay slot. We must save the address of
the previous instruction.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: qemu-stable@nongnu.org

---
 linux-user/sh4/signal.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: qemu/linux-user/sh4/signal.c
===================================================================
--- qemu.orig/linux-user/sh4/signal.c	2023-09-27 19:02:41.000000000 +0200
+++ qemu/linux-user/sh4/signal.c	2023-09-27 19:55:13.000000000 +0200
@@ -104,6 +104,14 @@ static void unwind_gusa(CPUSH4State *reg
 
         /* Reset the SP to the saved version in R1.  */
         regs->gregs[15] = regs->gregs[1];
+    } else if (regs->gregs[15] >= -128u && regs->pc == regs->gregs[0]) {
+        /* If we are on the last instruction of a gUSA region, we must reset
+           the SP, otherwise we would be pushing the signal context to
+           invalid memory.  */
+        regs->gregs[15] = regs->gregs[1];
+    } else if (regs->flags & TB_FLAG_DELAY_SLOT) {
+        /* If we are in a delay slot, push the previous instruction.  */
+        regs->pc -= 2;
     }
 }
 


