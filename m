Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD45742CE2
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 21:04:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEwvS-0006eX-1m; Thu, 29 Jun 2023 15:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEwvP-0006dN-T4
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 15:03:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEwvO-0005RM-8F
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 15:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688065405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DxQ0n3eh0/Q1sYObo5LimvfOSNbL4kAytqATgyJCOC4=;
 b=PuB3Yz72XVu2GNlr/uueExO4gWDbA7i/RiIBujXgWZkK3u9YElfCfyNp/afrD7kXpzf9Ek
 8vY6/8qWjR4ZNFOZAIblKZpZHwtBSBVH9rpqmfYSuykq7VqRIIKrIfsfUoNVD1ybqz4iwF
 zIuUZ4ymvrV0fvSq8GyzsHPKewGW8XI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-CW1W1IOhNpKmirmexy3xQQ-1; Thu, 29 Jun 2023 15:03:21 -0400
X-MC-Unique: CW1W1IOhNpKmirmexy3xQQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2238380027F;
 Thu, 29 Jun 2023 19:03:21 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55487140E952;
 Thu, 29 Jun 2023 19:03:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 6/8] pc-bios/s390-ccw: Move the stack array into start.S
Date: Thu, 29 Jun 2023 21:03:08 +0200
Message-Id: <20230629190310.337850-7-thuth@redhat.com>
In-Reply-To: <20230629190310.337850-1-thuth@redhat.com>
References: <20230629190310.337850-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

The stack array is only referenced from the start-up code (which is
shared between the s390-ccw.img and the s390-netboot.img), but it is
currently declared twice, once in main.c and once in netmain.c.
It makes more sense to declare this in start.S instead - which will
also be helpful in the next patch, since we need to mention the .bss
section in start.S in that patch.

While we're at it, let's also drop the huge alignment of the stack,
since there is no technical requirement for aligning it to page
boundaries.

Message-Id: <20230627074703.99608-4-thuth@redhat.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/s390-ccw.h | 1 -
 pc-bios/s390-ccw/main.c     | 1 -
 pc-bios/s390-ccw/netmain.c  | 1 -
 pc-bios/s390-ccw/start.S    | 6 ++++++
 tests/tcg/s390x/head64.S    | 7 ++-----
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index f68a832718..c977a52b50 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -50,7 +50,6 @@ void consume_io_int(void);
 /* main.c */
 void write_subsystem_identification(void);
 void write_iplb_location(void);
-extern char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
 unsigned int get_loadparm_index(void);
 void main(void);
 
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index a2def83e82..5506798098 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -17,7 +17,6 @@
 #include "virtio-scsi.h"
 #include "dasd-ipl.h"
 
-char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
 static SubChannelId blk_schid = { .one = 1 };
 static char loadparm_str[LOADPARM_LEN + 1];
 QemuIplParameters qipl;
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 056e93a818..5cd619b2d6 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -50,7 +50,6 @@ void write_iplb_location(void) {}
 /* STSI 3.2.2 offset of first vmdb + offset of uuid inside vmdb */
 #define STSI322_VMDB_UUID_OFFSET ((8 + 12) * 4)
 
-char stack[PAGE_SIZE * 8] __attribute__((aligned(PAGE_SIZE)));
 IplParameterBlock iplb __attribute__((aligned(PAGE_SIZE)));
 static char cfgbuf[2048];
 
diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
index abd6fe6639..429a2b30a1 100644
--- a/pc-bios/s390-ccw/start.S
+++ b/pc-bios/s390-ccw/start.S
@@ -121,3 +121,9 @@ external_new_mask:
     .quad   0x0000000180000000
 io_new_mask:
     .quad   0x0000000180000000
+
+.bss
+    .align  8
+stack:
+    .space  STACK_SIZE
+    .size   stack,STACK_SIZE
diff --git a/tests/tcg/s390x/head64.S b/tests/tcg/s390x/head64.S
index c6f36dfea4..4fe288388a 100644
--- a/tests/tcg/s390x/head64.S
+++ b/tests/tcg/s390x/head64.S
@@ -8,6 +8,8 @@
 #include "../../../pc-bios/s390-ccw/start.S"
 #undef main
 
+.text
+
 main_pre:
     aghi %r15,-160                     /* reserve stack for C code */
     brasl %r14,sclp_setup
@@ -24,8 +26,3 @@ success_psw:
     .quad 0x2000180000000,0xfff        /* see is_special_wait_psw() */
 failure_psw:
     .quad 0x2000180000000,0            /* disabled wait */
-
-    .section .bss
-    .align 0x1000
-stack:
-    .skip 0x8000
-- 
2.39.3


