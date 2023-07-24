Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B2675FCB5
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 18:56:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNyp6-0001J0-Vk; Mon, 24 Jul 2023 12:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNyp2-0001HH-6G
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:54:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNyoz-0006w3-U5
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690217649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zvEkjxFawxSMsxHLnuRRdzlHwbPPlU/4PabyCVxDysY=;
 b=WoFjejIR8ov9fp1/iqlTL54VUlgrf3GrzGjyxYXwIzhaSTOxXKcFDdv2mV3vuOv8jbAXw+
 Ver1M/l6lCzoENDFwga75z1sRMihKRWyKAyz70sE59VVkWNeoS8T8XGQVoi3XAIQCBSfFz
 dcGwCwwaASKzKzezT5rW4o6yIQiogHE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-c-wL0NRTOLW1uggDTJto_Q-1; Mon, 24 Jul 2023 12:54:07 -0400
X-MC-Unique: c-wL0NRTOLW1uggDTJto_Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9881985A58A;
 Mon, 24 Jul 2023 16:54:06 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD3AC492CAC;
 Mon, 24 Jul 2023 16:54:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 11/16] tests/tcg/s390x: Test MC
Date: Mon, 24 Jul 2023 18:53:44 +0200
Message-Id: <20230724165349.55714-12-thuth@redhat.com>
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

Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230724082032.66864-13-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/Makefile.softmmu-target |  1 +
 tests/tcg/s390x/mc.S                    | 56 +++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 tests/tcg/s390x/mc.S

diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
index 58684d7da7..145e0bfde1 100644
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ b/tests/tcg/s390x/Makefile.softmmu-target
@@ -24,6 +24,7 @@ ASM_TESTS =                                                                    \
     lpsw                                                                       \
     lpswe-early                                                                \
     lra                                                                        \
+    mc                                                                         \
     ssm-early                                                                  \
     stosm-early                                                                \
     unaligned-lowcore
diff --git a/tests/tcg/s390x/mc.S b/tests/tcg/s390x/mc.S
new file mode 100644
index 0000000000..e7466bb4b5
--- /dev/null
+++ b/tests/tcg/s390x/mc.S
@@ -0,0 +1,56 @@
+    .org 0x8d
+ilc:
+    .org 0x8e
+program_interruption_code:
+    .org 0x94
+monitor_class:
+    .org 0xb0
+monitor_code:
+    .org 0x150
+program_old_psw:
+    .org 0x1d0                              /* program new PSW */
+    .quad 0x180000000,pgm                   /* 64-bit mode */
+    .org 0x200                              /* lowcore padding */
+    .globl _start
+_start:
+    stctg %c8,%c8,c8                        /* enable only monitor class 1 */
+    mvhhi c8+6,0x4000
+    lctlg %c8,%c8,c8
+mc_nop:
+    mc 123,0
+mc_monitor_event:
+    mc 321,1
+    j failure
+mc_specification:
+    mc 333,16
+    j failure
+pgm:
+    lgrl %r0,program_old_psw+8              /* ilc adjustment */
+    llgc %r1,ilc
+    sgr %r0,%r1
+    larl %r1,mc_monitor_event               /* dispatch based on old PSW */
+    cgrje %r0,%r1,pgm_monitor_event
+    larl %r1,mc_specification
+    cgrje %r0,%r1,pgm_specification
+    j failure
+pgm_monitor_event:
+    chhsi program_interruption_code,0x40    /* monitor event? */
+    jne failure
+    chhsi monitor_class,1                   /* class from mc_monitor_event? */
+    jne failure
+    cghsi monitor_code,321                  /* code from mc_monitor_event? */
+    jne failure
+    j mc_specification                      /* next test */
+pgm_specification:
+    chhsi program_interruption_code,6       /* specification exception? */
+    jne failure
+    lpswe success_psw
+failure:
+    lpswe failure_psw
+    .align 8
+c8:
+    .quad 0
+success_psw:
+    .quad 0x2000000000000,0xfff             /* see is_special_wait_psw() */
+failure_psw:
+    .quad 0x2000000000000,0                 /* disabled wait */
-- 
2.39.3


