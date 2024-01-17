Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE7C830A58
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 17:05:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ8Pg-00044b-S3; Wed, 17 Jan 2024 11:05:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQ8Pe-00044J-Mf
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:05:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQ8Pc-0008Kp-Tz
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:05:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705507508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=POSfplYJhhtrbonAGHf8NJsAPu1Zh4NpOqbbGE6Reh8=;
 b=K+ROvl9h/LTm9AzxFMVhE9/cATrey1/byQE3cUfh8krzAF9qUWN0Sa5s+xY54Mk+zofzBb
 t001t/lnG53lYppaAa4nMVKveeqDJ1OJ7BUh6k/H/45WBeB3fmfp1nATu0DDAP5y5DV3QJ
 huar1uWKQpt/+Igu92XW1ZSVobjEP9s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-wu1fn8VdPeyRWDgrY2XuXw-1; Wed,
 17 Jan 2024 11:05:06 -0500
X-MC-Unique: wu1fn8VdPeyRWDgrY2XuXw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 856643C23FF7
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 16:05:06 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF2F02166B32
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 16:05:05 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] remove unnecessary casts from uintptr_t
Date: Wed, 17 Jan 2024 17:05:00 +0100
Message-ID: <20240117160500.176509-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

uintptr_t, or unsigned long which is equivalent on Linux I32LP64 systems,
is an unsigned type and there is no need to further cast to __u64 which is
another unsigned integer type; widening casts from unsigned integers
zero-extend the value.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io_uring.c      | 2 +-
 hw/vfio/common.c      | 4 ++--
 target/i386/sev.c     | 8 ++++----
 util/fdmon-io_uring.c | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index 1e5886c30be..d77ae55745a 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -102,7 +102,7 @@ static void luring_resubmit_short_read(LuringState *s, LuringAIOCB *luringcb,
 
     /* Update sqe */
     luringcb->sqeq.off += nread;
-    luringcb->sqeq.addr = (__u64)(uintptr_t)luringcb->resubmit_qiov.iov;
+    luringcb->sqeq.addr = (uintptr_t)luringcb->resubmit_qiov.iov;
     luringcb->sqeq.len = luringcb->resubmit_qiov.niov;
 
     luring_resubmit(s, luringcb);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 0da4003ecf5..059bfdc07a8 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1000,7 +1000,7 @@ vfio_device_feature_dma_logging_start_create(VFIOContainerBase *bcontainer,
         return NULL;
     }
 
-    control->ranges = (__u64)(uintptr_t)ranges;
+    control->ranges = (uintptr_t)ranges;
     if (tracking->max32) {
         ranges->iova = tracking->min32;
         ranges->length = (tracking->max32 - tracking->min32) + 1;
@@ -1126,7 +1126,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
     report->iova = iova;
     report->length = size;
     report->page_size = qemu_real_host_page_size();
-    report->bitmap = (__u64)(uintptr_t)bitmap;
+    report->bitmap = (uintptr_t)bitmap;
 
     feature->argsz = sizeof(buf);
     feature->flags = VFIO_DEVICE_FEATURE_GET |
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 9a712466825..173de91afe7 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -167,7 +167,7 @@ sev_ioctl(int fd, int cmd, void *data, int *error)
 
     input.id = cmd;
     input.sev_fd = fd;
-    input.data = (__u64)(unsigned long)data;
+    input.data = (uintptr_t)data;
 
     r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_OP, &input);
 
@@ -240,7 +240,7 @@ sev_ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
         return;
     }
 
-    range.addr = (__u64)(unsigned long)host;
+    range.addr = (uintptr_t)host;
     range.size = max_size;
 
     trace_kvm_memcrypt_register_region(host, max_size);
@@ -270,7 +270,7 @@ sev_ram_block_removed(RAMBlockNotifier *n, void *host, size_t size,
         return;
     }
 
-    range.addr = (__u64)(unsigned long)host;
+    range.addr = (uintptr_t)host;
     range.size = max_size;
 
     trace_kvm_memcrypt_unregister_region(host, max_size);
@@ -767,7 +767,7 @@ sev_launch_update_data(SevGuestState *sev, uint8_t *addr, uint64_t len)
         return 1;
     }
 
-    update.uaddr = (__u64)(unsigned long)addr;
+    update.uaddr = (uintptr_t)addr;
     update.len = len;
     trace_kvm_sev_launch_update_data(addr, len);
     ret = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_UPDATE_DATA,
diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index 16054c5ede3..b0d68bdc44d 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -180,7 +180,7 @@ static void add_poll_remove_sqe(AioContext *ctx, AioHandler *node)
     struct io_uring_sqe *sqe = get_sqe(ctx);
 
 #ifdef LIBURING_HAVE_DATA64
-    io_uring_prep_poll_remove(sqe, (__u64)(uintptr_t)node);
+    io_uring_prep_poll_remove(sqe, (uintptr_t)node);
 #else
     io_uring_prep_poll_remove(sqe, node);
 #endif
-- 
2.43.0


