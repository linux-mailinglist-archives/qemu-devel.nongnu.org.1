Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC8C803A9F
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 17:44:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAC2z-0005ig-4I; Mon, 04 Dec 2023 11:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAC2u-0005hc-Lr
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAC2q-0003fy-C8
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701708222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VsEvvjs7d5zW8glJ8pd4Q4kGvdxr6D5bV3lTOSPpLEQ=;
 b=a3SUuIKsEr383q2WN43Z3owbBy5rTfZmWuQa+CS3Erb/nQXx1b8IyuBna0wNI9Wghrj4KT
 0FhHqL5lxObYAFI8jNQfcqoCh1qn1YpFtXnZClm1k5cGS+yha0v2705qs/tJOD7GcFqnpa
 qweprLqkV+kB5RA8rx+jt7GlTOMhcuc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-I-v5869tMiO6hAqVMQKDIw-1; Mon,
 04 Dec 2023 11:43:40 -0500
X-MC-Unique: I-v5869tMiO6hAqVMQKDIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62EE73C1014C;
 Mon,  4 Dec 2023 16:43:40 +0000 (UTC)
Received: from localhost (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D9E3C2166B26;
 Mon,  4 Dec 2023 16:43:39 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 0/4] scsi: eliminate AioContext lock
Date: Mon,  4 Dec 2023 11:42:55 -0500
Message-ID: <20231204164259.1515217-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

v2:
- Reschedule BH in new AioContext if change is detected [Kevin]
- Drop stray "remember" in Patch 2's commit description [Eric]

The SCSI subsystem uses the AioContext lock to protect internal state. This is
necessary because the main loop and the IOThread can access SCSI state in
parallel. This inter-thread access happens during scsi_device_purge_requests()
and scsi_dma_restart_cb().

This patch series modifies the code so SCSI state is only accessed from the
IOThread that is executing requests. Once this has been achieved the AioContext
lock is no longer necessary.

Note that a few aio_context_acquire()/aio_context_release() calls still remain
after this series. They surround API calls that invoke AIO_WAIT_WHILE() and
therefore still rely on the AioContext lock for now.

Stefan Hajnoczi (4):
  scsi: only access SCSIDevice->requests from one thread
  virtio-scsi: don't lock AioContext around
    virtio_queue_aio_attach_host_notifier()
  scsi: don't lock AioContext in I/O code path
  dma-helpers: don't lock AioContext in dma_blk_cb()

 include/hw/scsi/scsi.h          |   7 +-
 hw/scsi/scsi-bus.c              | 180 ++++++++++++++++++++++----------
 hw/scsi/scsi-disk.c             |  23 ----
 hw/scsi/scsi-generic.c          |  20 +---
 hw/scsi/virtio-scsi-dataplane.c |   8 +-
 system/dma-helpers.c            |   7 +-
 6 files changed, 136 insertions(+), 109 deletions(-)

-- 
2.43.0


