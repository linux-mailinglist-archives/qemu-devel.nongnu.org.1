Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E7A75FCB7
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 18:56:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNypA-0001Lc-0l; Mon, 24 Jul 2023 12:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNyp2-0001HG-6G
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:54:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNyoy-0006vw-TU
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690217648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V1FPmqMhfqcrnIQOop+duFFFielJgMHsobOJxQfZPCY=;
 b=C4uHGok9dfTdNXIwUzCDHvblPYRrigWtsat6245o2b1twUV5n/Hm0uIhj6Nl5GRX8HVgkU
 2x4OVd2QR9Fjnb6//5RivnwohDKWBZetvvvilYTF2iTAKdjKBbVFCbh/YT8ATK4QK1gSO3
 SWyMWknuAFTzxa4nwEDApE187Lb2Mmw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-688-l-D2fkk8N4G7TYTQOdIc_A-1; Mon, 24 Jul 2023 12:54:05 -0400
X-MC-Unique: l-D2fkk8N4G7TYTQOdIc_A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 851161C0E0C4;
 Mon, 24 Jul 2023 16:54:05 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C32F2492CAC;
 Mon, 24 Jul 2023 16:54:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 10/16] tests/tcg/s390x: Test ICM
Date: Mon, 24 Jul 2023 18:53:43 +0200
Message-Id: <20230724165349.55714-11-thuth@redhat.com>
In-Reply-To: <20230724165349.55714-1-thuth@redhat.com>
References: <20230724165349.55714-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Add a small test to prevent regressions.

Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230724082032.66864-12-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/Makefile.softmmu-target |  1 +
 tests/tcg/s390x/icm.S                   | 32 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 tests/tcg/s390x/icm.S

diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
index 062d8e368a..58684d7da7 100644
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ b/tests/tcg/s390x/Makefile.softmmu-target
@@ -19,6 +19,7 @@ ASM_TESTS =                                                                    \
     cksm                                                                       \
     clm                                                                        \
     exrl-ssm-early                                                             \
+    icm                                                                        \
     sam                                                                        \
     lpsw                                                                       \
     lpswe-early                                                                \
diff --git a/tests/tcg/s390x/icm.S b/tests/tcg/s390x/icm.S
new file mode 100644
index 0000000000..d24d1f52fb
--- /dev/null
+++ b/tests/tcg/s390x/icm.S
@@ -0,0 +1,32 @@
+    .org 0x8e
+program_interruption_code:
+    .org 0x1d0                         /* program new PSW */
+    .quad 0,pgm
+    .org 0x200                         /* lowcore padding */
+    .globl _start
+_start:
+    lgrl %r0,op1
+    icm %r0,10,op2
+    cg %r0,exp
+    jne failure
+    lgrl %r1,bad_addr
+    icm %r0,0,0(%r1)
+failure:
+    lpswe failure_psw
+pgm:
+    chhsi program_interruption_code,5  /* addressing exception? */
+    jne failure
+    lpswe success_psw
+    .align 8
+op1:
+    .quad 0x1234567887654321
+op2:
+    .quad 0x0011223344556677
+exp:
+    .quad 0x1234567800651121
+bad_addr:
+    .quad 0xffffffff00000000
+success_psw:
+    .quad 0x2000000000000,0xfff        /* see is_special_wait_psw() */
+failure_psw:
+    .quad 0x2000000000000,0            /* disabled wait */
-- 
2.39.3


