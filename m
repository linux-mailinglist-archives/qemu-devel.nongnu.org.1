Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E937270BC5A
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:52:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q144G-0005Zk-9e; Mon, 22 May 2023 07:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143d-0005Bj-9x
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143a-0007Zv-95
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684756229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=45Wf+xoO7XxfgRD0/Mp9+RUqAmlm7wq0Z4K8ueM9fMo=;
 b=gj217I+4Ptq+Iyw4EP/n0DcLY3VBm7Hnrp+MIH+AIgs0tTcg9iIwdIof6qEUj/vn+63YEO
 zcZ6cJG5u02sqMAhdDmluove/inIvuwmF58HxU4hAG7N6FhhKigUYhTr4p9cyIVbvX5eCW
 GVis6qnH7ckEyCCs4sPLxp8CwAqk9NQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-pb-hM8mFOiuPwy7cDIJfGg-1; Mon, 22 May 2023 07:50:26 -0400
X-MC-Unique: pb-hM8mFOiuPwy7cDIJfGg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 398318032F1;
 Mon, 22 May 2023 11:50:26 +0000 (UTC)
Received: from thuth.com (unknown [10.39.195.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 542EB2166B26;
 Mon, 22 May 2023 11:50:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 08/20] hw/char/parallel: Move TYPE_ISA_PARALLEL to the header
 file
Date: Mon, 22 May 2023 13:50:02 +0200
Message-Id: <20230522115014.1110840-9-thuth@redhat.com>
In-Reply-To: <20230522115014.1110840-1-thuth@redhat.com>
References: <20230522115014.1110840-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We are going to require the macro from other files, too, so move
this #define to the header file.

Message-Id: <20230512124033.502654-9-thuth@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/char/parallel.h | 2 ++
 hw/char/parallel-isa.c     | 2 +-
 hw/char/parallel.c         | 1 -
 hw/isa/isa-superio.c       | 3 ++-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/hw/char/parallel.h b/include/hw/char/parallel.h
index 0a23c0f57e..29d2876d00 100644
--- a/include/hw/char/parallel.h
+++ b/include/hw/char/parallel.h
@@ -4,6 +4,8 @@
 #include "hw/isa/isa.h"
 #include "chardev/char.h"
 
+#define TYPE_ISA_PARALLEL "isa-parallel"
+
 void parallel_hds_isa_init(ISABus *bus, int n);
 
 bool parallel_mm_init(MemoryRegion *address_space,
diff --git a/hw/char/parallel-isa.c b/hw/char/parallel-isa.c
index 1ccbb96e70..547ae69304 100644
--- a/hw/char/parallel-isa.c
+++ b/hw/char/parallel-isa.c
@@ -21,7 +21,7 @@ static void parallel_init(ISABus *bus, int index, Chardev *chr)
     DeviceState *dev;
     ISADevice *isadev;
 
-    isadev = isa_new("isa-parallel");
+    isadev = isa_new(TYPE_ISA_PARALLEL);
     dev = DEVICE(isadev);
     qdev_prop_set_uint32(dev, "index", index);
     qdev_prop_set_chr(dev, "chardev", chr);
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index af551e7864..3d32589bb3 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -93,7 +93,6 @@ typedef struct ParallelState {
     PortioList portio_list;
 } ParallelState;
 
-#define TYPE_ISA_PARALLEL "isa-parallel"
 OBJECT_DECLARE_SIMPLE_TYPE(ISAParallelState, ISA_PARALLEL)
 
 struct ISAParallelState {
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index c81bfe58ef..9292ec3bcf 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -16,6 +16,7 @@
 #include "qapi/error.h"
 #include "sysemu/blockdev.h"
 #include "chardev/char.h"
+#include "hw/char/parallel.h"
 #include "hw/block/fdc.h"
 #include "hw/isa/superio.h"
 #include "hw/qdev-properties.h"
@@ -51,7 +52,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
             } else {
                 name = g_strdup_printf("parallel%d", i);
             }
-            isa = isa_new("isa-parallel");
+            isa = isa_new(TYPE_ISA_PARALLEL);
             d = DEVICE(isa);
             qdev_prop_set_uint32(d, "index", i);
             if (k->parallel.get_iobase) {
-- 
2.31.1


