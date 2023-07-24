Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F35175FCC2
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 18:57:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNyp6-0001Il-Ex; Mon, 24 Jul 2023 12:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNyox-0001Fy-D9
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNyow-0006uu-1U
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690217645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pmz9Qpoovh22tNLepJxxJ6o/buzGYcVypZvG43zOmhQ=;
 b=NUok/y50cUVtf3pZVpnjCi7xv8NlHnbiCGWMmAN9agXr8Z4xuA542aG3xbyOlh5t6h8q8G
 xtXsT+41VIJmyJmB3oSX4s2wVNus1QoSZimP3au1IKy0r7K4RxsXIrAb0n5Pjz4sl3U7Jx
 sLYBtzjVc51Daao3zWs91GwVumLepyM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-BQOMgNejNvO7kDSCKFIYsw-1; Mon, 24 Jul 2023 12:54:02 -0400
X-MC-Unique: BQOMgNejNvO7kDSCKFIYsw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DF37104458D;
 Mon, 24 Jul 2023 16:54:02 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 57FA148FB01;
 Mon, 24 Jul 2023 16:54:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 07/16] tests/tcg/s390x: Test CKSM
Date: Mon, 24 Jul 2023 18:53:40 +0200
Message-Id: <20230724165349.55714-8-thuth@redhat.com>
In-Reply-To: <20230724165349.55714-1-thuth@redhat.com>
References: <20230724165349.55714-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230724082032.66864-9-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/Makefile.softmmu-target |  1 +
 tests/tcg/s390x/cksm.S                  | 29 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 tests/tcg/s390x/cksm.S

diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
index 242c7b0f83..e813e318db 100644
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ b/tests/tcg/s390x/Makefile.softmmu-target
@@ -16,6 +16,7 @@ LDFLAGS=-nostdlib -static
 
 ASM_TESTS =                                                                    \
     bal                                                                        \
+    cksm                                                                       \
     exrl-ssm-early                                                             \
     sam                                                                        \
     lpsw                                                                       \
diff --git a/tests/tcg/s390x/cksm.S b/tests/tcg/s390x/cksm.S
new file mode 100644
index 0000000000..563fd3d233
--- /dev/null
+++ b/tests/tcg/s390x/cksm.S
@@ -0,0 +1,29 @@
+    .org 0x8e
+program_interruption_code:
+    .org 0x1d0                         /* program new PSW */
+    .quad 0,pgm
+    .org 0x200                         /* lowcore padding */
+    .globl _start
+_start:
+    lmg %r0,%r1,cksm_args
+    cksm %r2,%r0
+    c %r2,cksm_exp
+    jne failure
+    .insn rre,0xb2410000,%r2,%r15      /* cksm %r2,%r15 */
+failure:
+    lpswe failure_psw
+pgm:
+    chhsi program_interruption_code,6  /* specification exception? */
+    jne failure
+    lpswe success_psw
+cksm_args:
+    .quad cksm_buf, 16
+cksm_buf:
+    .quad 0xaaaabbbbcccc0000, 0x12345678
+cksm_exp:
+    .long 0x89ab1234
+    .align 8
+success_psw:
+    .quad 0x2000000000000,0xfff        /* see is_special_wait_psw() */
+failure_psw:
+    .quad 0x2000000000000,0            /* disabled wait */
-- 
2.39.3


