Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B22F73E088
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:23:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmAL-0001Dy-60; Mon, 26 Jun 2023 09:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qDmAD-00017s-7m
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:21:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qDmAA-00077Y-9d
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687785706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDhtcNchbuN0ZviXnaLD7HMWePfnNoGcw521x/QpHTc=;
 b=igFV3Fd8PdV50kNrfkjS0b5HpSOM/aCQJldxfpv64p2yaoWtc3NmUemjdYqABN0+oDYxRt
 qJ6lhJqOgPhGLAMb2Fp5cD48Wy/uxTdCeT6YV+RRVtccDQmoUxZkPoKGEbsJ0XEQG5VVYM
 aoP8h93sE9XolJXC0FvycpQyjpt9mqw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-uz7xY1uLM3-HTz03c8SXBQ-1; Mon, 26 Jun 2023 09:21:45 -0400
X-MC-Unique: uz7xY1uLM3-HTz03c8SXBQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D3B93849522;
 Mon, 26 Jun 2023 13:21:44 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 571DD1121319;
 Mon, 26 Jun 2023 13:21:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 mrezanin@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 2/4] pc-bios/s390-ccw: Provide space for initial stack frame
 in start.S
Date: Mon, 26 Jun 2023 15:21:36 +0200
Message-Id: <20230626132138.87668-3-thuth@redhat.com>
In-Reply-To: <20230626132138.87668-1-thuth@redhat.com>
References: <20230626132138.87668-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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


