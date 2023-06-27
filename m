Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD1C73F5FC
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 09:48:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE3QG-0007u8-40; Tue, 27 Jun 2023 03:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qE3Q9-0007rr-9G
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qE3Q5-0005ps-AG
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687852044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KkaLgR0T4L9obuDw/YCsK3fmQhhaAYOwghEC31w9RyQ=;
 b=Aqm30xAi/vb983FJejOGFhMXMdO+6MLldphy6lMTq4Wm6wDbw8A54kH6Wz8bsJcLQOEBVn
 Mtewp16/hxCj6BWf6ttJc0lib3tlXZtwG3kUoPc9AnqVVDDCckFHl5rwnJetv6IdHgEkgP
 3gdFTFJflf6MYqsp3KLbx9a8I6eV0bE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-9FiseXHRPGyjA95RDsIJiA-1; Tue, 27 Jun 2023 03:47:20 -0400
X-MC-Unique: 9FiseXHRPGyjA95RDsIJiA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C9E93C0FCA7;
 Tue, 27 Jun 2023 07:47:20 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.242])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC4CD401061;
 Tue, 27 Jun 2023 07:47:17 +0000 (UTC)
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
Subject: [PATCH v2 4/4] pc-bios/s390-ccw: Don't use __bss_start with the
 "larl" instruction
Date: Tue, 27 Jun 2023 09:47:03 +0200
Message-Id: <20230627074703.99608-5-thuth@redhat.com>
In-Reply-To: <20230627074703.99608-1-thuth@redhat.com>
References: <20230627074703.99608-1-thuth@redhat.com>
MIME-Version: 1.0
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

Fix it by using the real start address of the .bss section instead.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2216662
Reported-by: Miroslav Rezanina <mrezanin@redhat.com>
Suggested-by: Nick Clifton <nickc@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/start.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
index 111dea261b..a63c4e3ff2 100644
--- a/pc-bios/s390-ccw/start.S
+++ b/pc-bios/s390-ccw/start.S
@@ -18,7 +18,7 @@ _start:
     larl    %r15,stack + STACK_SIZE - 160   /* Set up stack */
 
     /* clear bss */
-    larl    %r2,__bss_start
+    larl    %r2,.bss
     larl    %r3,_end
     slgr    %r3,%r2    /* get sizeof bss */
     ltgr    %r3,%r3    /* bss empty? */
-- 
2.39.3


