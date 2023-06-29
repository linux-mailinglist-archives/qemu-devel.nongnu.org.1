Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 630A7742439
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 12:49:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEpCi-0002UM-0B; Thu, 29 Jun 2023 06:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEpCe-0002SH-8e
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:48:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEpCc-000471-4g
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688035721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5+0qiiAnL0MXOpNHbR7TIl0yAcFqnmvzhcBmDoVDT/w=;
 b=djnU46Yav3pOZqtWb8/AJ9V7hKLw3YPyx5dqLPXXczQpP69WBvbJmwAij/dj4FHxwO+Zs4
 +juquMr2UmVAjYPip/mJQLWwe8z74dUgTbjJz0OGFnG/593yRwu2aCgLeNZv0arc5Rru0d
 qFuaHUyxobKPcpfOq/rVlXXlv40UkAA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357--ZymdlYNPPKveN9pVV3_aA-1; Thu, 29 Jun 2023 06:48:38 -0400
X-MC-Unique: -ZymdlYNPPKveN9pVV3_aA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 268EE8017C3;
 Thu, 29 Jun 2023 10:48:30 +0000 (UTC)
Received: from thuth.com (dhcp-192-205.str.redhat.com [10.33.192.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6951440C6F5A;
 Thu, 29 Jun 2023 10:48:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v3 7/7] pc-bios/s390-ccw: Don't use __bss_start with the
 "larl" instruction
Date: Thu, 29 Jun 2023 12:48:21 +0200
Message-Id: <20230629104821.194859-8-thuth@redhat.com>
In-Reply-To: <20230629104821.194859-1-thuth@redhat.com>
References: <20230629104821.194859-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

start.S currently cannot be compiled with Clang 16 and binutils 2.40:

 ld: start.o(.text+0x8): misaligned symbol `__bss_start' (0xc1e5) for
     relocation R_390_PC32DBL

According to the built-in linker script of ld, the symbol __bss_start
can actually point *before* the .bss section and does not need to have
any alignment, so in certain situations (like when using the internal
assembler of Clang), the __bss_start symbol can indeed be unaligned
and thus it is not suitable for being used with the "larl" instruction
that needs an address that is at least aligned to halfwords.
The problem went unnoticed so far since binutils <= 2.39 did not
check the alignment, but starting with binutils 2.40, such unaligned
addresses are now refused.

Fix it by loading the address indirectly instead.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2216662
Reported-by: Miroslav Rezanina <mrezanin@redhat.com>
Suggested-by:  Andreas Krebbel <andreas.krebbel@de.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/start.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
index 429a2b30a1..061b06591c 100644
--- a/pc-bios/s390-ccw/start.S
+++ b/pc-bios/s390-ccw/start.S
@@ -19,7 +19,8 @@ _start:
     larl    %r15,stack + STACK_SIZE - STACK_FRAME_SIZE   /* Set up stack */
 
     /* clear bss */
-    larl    %r2,__bss_start
+    larl    %r2,bss_start_literal   /* __bss_start might be unaligned ... */
+    lg      %r2,0(%r2)              /* ... so load it indirectly */
     larl    %r3,_end
     slgr    %r3,%r2    /* get sizeof bss */
     ltgr    %r3,%r3    /* bss empty? */
@@ -45,7 +46,6 @@ done:
 memsetxc:
     xc      0(1,%r1),0(%r1)
 
-
 /*
  * void disabled_wait(void)
  *
@@ -113,6 +113,8 @@ io_new_code:
     br      %r14
 
     .align  8
+bss_start_literal:
+    .quad   __bss_start
 disabled_wait_psw:
     .quad   0x0002000180000000,0x0000000000000000
 enabled_wait_psw:
-- 
2.39.3


