Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0549A73E08D
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:23:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmAN-0001Fi-5h; Mon, 26 Jun 2023 09:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qDmAE-0001Bq-Mk
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qDmAA-000782-IH
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687785709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ed4LIidxenKTEJmd9FPCsvy7s4vbC9dPPSlI64zMutc=;
 b=iKoGVGrKwB3gjt2vGpcLj385NQi2Uvu+sWve9vXAGkn2izgPcBJKh2/bgn4RTyW96ntdC2
 W/bPR/T2JCzdcr+FAaOmVQ3R2zC6oZfwHAfUKQg5uRXBGft691sjl+ORM/c/+kcnGpkJiB
 z3mZXv9TXT+z5uQ+7buKOi3D9zTps+w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-xokr8ATIO8C3erWG1cOg3Q-1; Mon, 26 Jun 2023 09:21:46 -0400
X-MC-Unique: xokr8ATIO8C3erWG1cOg3Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F0AC8631DB;
 Mon, 26 Jun 2023 13:21:46 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5B141121319;
 Mon, 26 Jun 2023 13:21:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 mrezanin@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 3/4] pc-bios/s390-ccw: Move the stack array into start.S
Date: Mon, 26 Jun 2023 15:21:37 +0200
Message-Id: <20230626132138.87668-4-thuth@redhat.com>
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

The stack array is only referenced from the start-up code (which is
shared between the s390-ccw.img and the s390-netboot.img), but it is
currently declared twice, once in main.c and once in netmain.c.
It makes more sense to declare this in start.S instead - which will
also be helpful in the next patch, since we need to mention the .bss
section in start.S in that patch.

While we're at it, let's also drop the huge alignment of the stack,
since there is no technical requirement for aligning it to page
boundaries.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/s390-ccw.h | 1 -
 pc-bios/s390-ccw/main.c     | 1 -
 pc-bios/s390-ccw/netmain.c  | 1 -
 pc-bios/s390-ccw/start.S    | 5 +++++
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index b88e0550ab..91afcbbca9 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -55,7 +55,6 @@ void consume_io_int(void);
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
index 29b0a9ece0..47ef6e8aa8 100644
--- a/pc-bios/s390-ccw/start.S
+++ b/pc-bios/s390-ccw/start.S
@@ -120,3 +120,8 @@ external_new_mask:
     .quad   0x0000000180000000
 io_new_mask:
     .quad   0x0000000180000000
+
+.bss
+
+    .align  16
+    .lcomm  stack,STACK_SIZE
-- 
2.39.3


