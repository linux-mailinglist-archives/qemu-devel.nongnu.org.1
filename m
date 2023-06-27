Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5801373F5F6
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 09:47:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE3Q1-0007ox-Bg; Tue, 27 Jun 2023 03:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qE3Px-0007oe-DR
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:47:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qE3Pv-0005nh-FJ
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687852034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m/egevt3rTyaKnzW4yBLMxtB2WYjlI4F8k8wYKpy1ig=;
 b=Qruwmr4Eab9bZVjyxWVVJiNEmUOCo/noces8gyd3TEovSyc7gpPT+Hj6SJvKXS+3I7RBI8
 ps5qxNJlJcikBXzzzOdulq84wFKpNAVpmgdCCYqRVlPY9iYhb8B62zJcApTC8FHob2amjV
 XdixDg59/vsE33mt7jmEQAjg4L8aMuA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-x6GKasKiNoC5As10EJm8WA-1; Tue, 27 Jun 2023 03:47:13 -0400
X-MC-Unique: x6GKasKiNoC5As10EJm8WA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83A288C80ED;
 Tue, 27 Jun 2023 07:47:12 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.242])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F4A740F169;
 Tue, 27 Jun 2023 07:47:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 mrezanin@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clegoate@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v2 1/4] pc-bios/s390-ccw: Fix indentation in start.S
Date: Tue, 27 Jun 2023 09:47:00 +0200
Message-Id: <20230627074703.99608-2-thuth@redhat.com>
In-Reply-To: <20230627074703.99608-1-thuth@redhat.com>
References: <20230627074703.99608-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

start.S is currently indented with a mixture of spaces and tabs, which
is quite ugly. QEMU coding style says indentation should be 4 spaces,
and this is also what we are using in the assembler files in the
tests/tcg/s390x/ folder already, so let's adjust start.S accordingly.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/start.S | 136 +++++++++++++++++++--------------------
 1 file changed, 68 insertions(+), 68 deletions(-)

diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
index 6072906df4..d29de09cc6 100644
--- a/pc-bios/s390-ccw/start.S
+++ b/pc-bios/s390-ccw/start.S
@@ -10,37 +10,37 @@
  * directory.
  */
 
-        .globl _start
+    .globl _start
 _start:
 
-	larl   %r15, stack + 0x8000	/* Set up stack */
+    larl    %r15,stack + 0x8000     /* Set up stack */
 
-	/* clear bss */
-	larl %r2, __bss_start
-	larl %r3, _end
-	slgr %r3, %r2		/* get sizeof bss */
-	ltgr	%r3,%r3 	/* bss empty? */
-	jz	done
-	aghi	%r3,-1
-	srlg	%r4,%r3,8	/* how many 256 byte chunks? */
-	ltgr	%r4,%r4
-	lgr	%r1,%r2
-	jz	remainder
+    /* clear bss */
+    larl    %r2,__bss_start
+    larl    %r3,_end
+    slgr    %r3,%r2    /* get sizeof bss */
+    ltgr    %r3,%r3    /* bss empty? */
+    jz      done
+    aghi    %r3,-1
+    srlg    %r4,%r3,8  /* how many 256 byte chunks? */
+    ltgr    %r4,%r4
+    lgr     %r1,%r2
+    jz      remainder
 loop:
-	xc	0(256,%r1),0(%r1)
-	la	%r1,256(%r1)
-	brctg	%r4,loop
+    xc      0(256,%r1),0(%r1)
+    la      %r1,256(%r1)
+    brctg   %r4,loop
 remainder:
-	larl	%r2,memsetxc
-	ex	%r3,0(%r2)
+    larl    %r2,memsetxc
+    ex      %r3,0(%r2)
 done:
-        /* set up a pgm exception disabled wait psw */
-        larl	%r2, disabled_wait_psw
-        mvc	0x01d0(16), 0(%r2)
-        j      main		/* And call C */
+    /* set up a pgm exception disabled wait psw */
+    larl    %r2,disabled_wait_psw
+    mvc     0x01d0(16),0(%r2)
+    j       main       /* And call C */
 
 memsetxc:
-	xc	0(1,%r1),0(%r1)
+    xc      0(1,%r1),0(%r1)
 
 
 /*
@@ -48,11 +48,11 @@ memsetxc:
  *
  * stops the current guest cpu.
  */
-	.globl disabled_wait
+    .globl disabled_wait
 disabled_wait:
-	larl	%r1,disabled_wait_psw
-	lpswe	0(%r1)
-1:	j	1b
+    larl    %r1,disabled_wait_psw
+    lpswe   0(%r1)
+1:  j       1b
 
 
 /*
@@ -60,61 +60,61 @@ disabled_wait:
  *
  * eats one sclp interrupt
  */
-        .globl consume_sclp_int
+    .globl consume_sclp_int
 consume_sclp_int:
-        /* enable service interrupts in cr0 */
-        stctg   %c0,%c0,0(%r15)
-        oi      6(%r15),0x2
-        lctlg   %c0,%c0,0(%r15)
-        /* prepare external call handler */
-        larl %r1, external_new_code
-        stg %r1, 0x1b8
-        larl %r1, external_new_mask
-        mvc 0x1b0(8),0(%r1)
-        /* load enabled wait PSW */
-        larl %r1, enabled_wait_psw
-        lpswe 0(%r1)
+    /* enable service interrupts in cr0 */
+    stctg   %c0,%c0,0(%r15)
+    oi      6(%r15),0x2
+    lctlg   %c0,%c0,0(%r15)
+    /* prepare external call handler */
+    larl    %r1,external_new_code
+    stg     %r1,0x1b8
+    larl    %r1,external_new_mask
+    mvc     0x1b0(8),0(%r1)
+    /* load enabled wait PSW */
+    larl    %r1,enabled_wait_psw
+    lpswe   0(%r1)
 
 /*
  * void consume_io_int(void)
  *
  * eats one I/O interrupt
  */
-        .globl consume_io_int
+    .globl consume_io_int
 consume_io_int:
-        /* enable I/O interrupts in cr6 */
-        stctg %c6,%c6,0(%r15)
-        oi    4(%r15), 0xff
-        lctlg %c6,%c6,0(%r15)
-        /* prepare i/o call handler */
-        larl  %r1, io_new_code
-        stg   %r1, 0x1f8
-        larl  %r1, io_new_mask
-        mvc   0x1f0(8),0(%r1)
-        /* load enabled wait PSW */
-        larl  %r1, enabled_wait_psw
-        lpswe 0(%r1)
+    /* enable I/O interrupts in cr6 */
+    stctg   %c6,%c6,0(%r15)
+    oi      4(%r15), 0xff
+    lctlg   %c6,%c6,0(%r15)
+    /* prepare i/o call handler */
+    larl    %r1,io_new_code
+    stg     %r1,0x1f8
+    larl    %r1,io_new_mask
+    mvc     0x1f0(8),0(%r1)
+    /* load enabled wait PSW */
+    larl    %r1,enabled_wait_psw
+    lpswe   0(%r1)
 
 external_new_code:
-        /* disable service interrupts in cr0 */
-        stctg   %c0,%c0,0(%r15)
-        ni      6(%r15),0xfd
-        lctlg   %c0,%c0,0(%r15)
-        br      %r14
+    /* disable service interrupts in cr0 */
+    stctg   %c0,%c0,0(%r15)
+    ni      6(%r15),0xfd
+    lctlg   %c0,%c0,0(%r15)
+    br      %r14
 
 io_new_code:
-        /* disable I/O interrupts in cr6 */
-        stctg %c6,%c6,0(%r15)
-        ni    4(%r15), 0x00
-        lctlg %c6,%c6,0(%r15)
-        br    %r14
+    /* disable I/O interrupts in cr6 */
+    stctg   %c6,%c6,0(%r15)
+    ni      4(%r15),0x00
+    lctlg   %c6,%c6,0(%r15)
+    br      %r14
 
-        .align  8
+    .align  8
 disabled_wait_psw:
-        .quad   0x0002000180000000,0x0000000000000000
+    .quad   0x0002000180000000,0x0000000000000000
 enabled_wait_psw:
-        .quad   0x0302000180000000,0x0000000000000000
+    .quad   0x0302000180000000,0x0000000000000000
 external_new_mask:
-        .quad   0x0000000180000000
+    .quad   0x0000000180000000
 io_new_mask:
-        .quad   0x0000000180000000
+    .quad   0x0000000180000000
-- 
2.39.3


