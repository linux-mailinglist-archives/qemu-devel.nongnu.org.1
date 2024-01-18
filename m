Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A023A831924
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:27:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRS4-0004C9-PN; Thu, 18 Jan 2024 07:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRy-0003hk-6p
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRw-0006QY-AP
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705580687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hDmH0xb0KJF83JwWFiZmZr7xbAbQMZGA9xbRqzRDHkU=;
 b=N0HYJU5VDoRrpJpjT2vKf/0v/oF/+J/YtdwXmf0EdQFmXUDOQpJi/kE7JEslc1RNKwGtnC
 8scpT6k0xcgpyNxjN1spgW7ROxnHf+igzBM5UVjaZHTdGoQs72tuq8cVCW0qO6tukTiJp9
 VEfDx3FVY0QwYY/6ibC4ZSJuDm6wRuU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-4SFreF_UORqOoeLVxV-uJg-1; Thu, 18 Jan 2024 07:24:45 -0500
X-MC-Unique: 4SFreF_UORqOoeLVxV-uJg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-50e5aa11579so10481342e87.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:24:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705580683; x=1706185483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hDmH0xb0KJF83JwWFiZmZr7xbAbQMZGA9xbRqzRDHkU=;
 b=t7xzmLTCO90UaQtOaI+mUhdqSJZgi+o8tlzgESeSkdl9zHjem4Mib8kgnjO4EN6Swh
 qaUfMBPVY4p0Ex/mpFaQX2/jNS1k7Fdb/3kkwg17DWSSilFsd6h6a11olhgvLJgt2nfq
 Ryu1fIaez74l0Ceutm/rn3Qx4+wTuzGyui83cRSTDy8kAqsUpE4uSgn8ZXOv6wVZR06O
 5KxERLVfk4+lA0YZk1Z94a1dkh7LQ7g3WDwy1WUaaWCSDJqyYLOwycZ7zX0DyEQf63vY
 FL9dmC8TGBEuUyZnuQQIhGEVpSj47FGh12HPbvytgh6II3UKT1NwU4NZWh5aqBIt0oVm
 0dWw==
X-Gm-Message-State: AOJu0YxkY67wHgaK6+nZJU7GRwd7ACJ05YK++T9IagjJ6GGvohtMIj+D
 +x2Q2NvovW/A5T5Ei96TZ9QkAR644Q73775VpGPA8aGHvnPEcN6HzwOToq5YO5iF5tTgjV8xPcf
 Og4LEWyqOM/oo3lUjQcqfi9rqapmBDSF/O+a1IrCQ7EQRaidGTRXAlqqP2/028imF2uNDKBu5xH
 DjPLzfhwgmYGzYTAO7rFJ2CWirgu+LNXnpuzsV
X-Received: by 2002:ac2:5184:0:b0:50f:5e2:d50 with SMTP id
 u4-20020ac25184000000b0050f05e20d50mr360302lfi.51.1705580683529; 
 Thu, 18 Jan 2024 04:24:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/xUDldOgfmRW0Kh3OnJlfRkyf61+sFNEht8bXaYgz9UIa8vi6ryuOk+QZ2N9LEASX5fTW7Q==
X-Received: by 2002:ac2:5184:0:b0:50f:5e2:d50 with SMTP id
 u4-20020ac25184000000b0050f05e20d50mr360300lfi.51.1705580683234; 
 Thu, 18 Jan 2024 04:24:43 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 g16-20020a17090670d000b00a28f51adc39sm8999556ejk.61.2024.01.18.04.24.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 04:24:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/16] remove unnecessary casts from uintptr_t
Date: Thu, 18 Jan 2024 13:24:14 +0100
Message-ID: <20240118122416.9209-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118122416.9209-1-pbonzini@redhat.com>
References: <20240118122416.9209-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
index 0b3352f2a9d..4aa86f563c6 100644
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


