Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5511E742CE0
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 21:04:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEwvN-0006bA-Or; Thu, 29 Jun 2023 15:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEwvL-0006aR-RK
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 15:03:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEwvK-0005Pe-BV
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 15:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688065401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZurYuQ0nEKt+ib7lAl9zkZlcdff6dIy1ER0x6MjCHOs=;
 b=dVIE4EixVgAsiwr13nithxHjyU9TNWakncdX6xmIhpTw+nDvHqshvxLnW9ud32k257n4YI
 0Qhv8ajcwXjpmVgZboNvkuF2qdmZiUmxnMUGpv83+7prDrqRbuJJ6NUDplJo5Vauk5p7Oe
 BcNX0DECzYm1URog1mEGBcUey7tBNmY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-unMJFzARN42jqwfb5VyHdA-1; Thu, 29 Jun 2023 15:03:20 -0400
X-MC-Unique: unMJFzARN42jqwfb5VyHdA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0186C2823802;
 Thu, 29 Jun 2023 19:03:20 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55BA414682F9;
 Thu, 29 Jun 2023 19:03:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 5/8] pc-bios/s390-ccw: Provide space for initial stack frame in
 start.S
Date: Thu, 29 Jun 2023 21:03:07 +0200
Message-Id: <20230629190310.337850-6-thuth@redhat.com>
In-Reply-To: <20230629190310.337850-1-thuth@redhat.com>
References: <20230629190310.337850-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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
Message-Id: <20230627074703.99608-3-thuth@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/start.S | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
index d29de09cc6..abd6fe6639 100644
--- a/pc-bios/s390-ccw/start.S
+++ b/pc-bios/s390-ccw/start.S
@@ -10,10 +10,13 @@
  * directory.
  */
 
+#define STACK_SIZE        0x8000
+#define STACK_FRAME_SIZE  160
+
     .globl _start
 _start:
 
-    larl    %r15,stack + 0x8000     /* Set up stack */
+    larl    %r15,stack + STACK_SIZE - STACK_FRAME_SIZE   /* Set up stack */
 
     /* clear bss */
     larl    %r2,__bss_start
-- 
2.39.3


