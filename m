Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DE873F601
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 09:48:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE3Q5-0007qv-PN; Tue, 27 Jun 2023 03:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qE3Q3-0007pp-Eb
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:47:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qE3Q0-0005of-1E
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687852039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XR4S0oZDtvtAXguF2LbG9I+n3uIH169nnvFT2BnUZEw=;
 b=UfNeVFUMGqCnma388vq9p5hxhvd9vU1+JIttr+84NCTEDVZgtv4NP4R9OyjkBLfNQMYTVT
 KWug74T9sFLaosUnUhMaC66sluprz58Y9EmFd667HHj3/4JfeEb/zguwncWYrRdIBvjaGl
 sfJgOQwqPrXLcdSUEKwWD2MvpUn7BM0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-b1dd_XX1P6icRbjTfsXRWg-1; Tue, 27 Jun 2023 03:47:15 -0400
X-MC-Unique: b1dd_XX1P6icRbjTfsXRWg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AD49104458D;
 Tue, 27 Jun 2023 07:47:15 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.242])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D22B140BB4D;
 Tue, 27 Jun 2023 07:47:12 +0000 (UTC)
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
Subject: [PATCH v2 2/4] pc-bios/s390-ccw: Provide space for initial stack
 frame in start.S
Date: Tue, 27 Jun 2023 09:47:01 +0200
Message-Id: <20230627074703.99608-3-thuth@redhat.com>
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

Providing the space of a stack frame is the duty of the caller,
so we should reserve 160 bytes before jumping into the main function.
Otherwise the main() function might write past the stack array.

While we're at it, add a proper STACK_SIZE macro for the stack size
instead of using magic numbers (this is also required for the following
patch).

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/start.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
index d29de09cc6..29b0a9ece0 100644
--- a/pc-bios/s390-ccw/start.S
+++ b/pc-bios/s390-ccw/start.S
@@ -10,10 +10,12 @@
  * directory.
  */
 
+#define STACK_SIZE 0x8000
+
     .globl _start
 _start:
 
-    larl    %r15,stack + 0x8000     /* Set up stack */
+    larl    %r15,stack + STACK_SIZE - 160   /* Set up stack */
 
     /* clear bss */
     larl    %r2,__bss_start
-- 
2.39.3


