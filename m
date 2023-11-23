Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0777F67D9
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 20:50:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Fhm-0001zq-LN; Thu, 23 Nov 2023 14:49:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r6Fhl-0001xV-4z
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 14:49:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r6Fhj-0000cz-Lw
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 14:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700768978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vBExvsNxM45JG0GTOZcb0ZCEaSTtqFHbc/mayKRz//o=;
 b=YONBHL/qZrBED1ydYQ37y+VOeAH0RoOrsP1Z2slxDgRqJltvhiCtdm3vlugcPJ6xOXqkMK
 +9YH9xP9zj83D/eLDLrpysQF7uLA2F+QliCr19rttLGjHqoUcpGiT8VDie9JFclg9nwZ5M
 M8WhOE85ZQiOWFcHkrcilaYqaxwv8p4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-RTL7GcyoMBGxB_GeT5883w-1; Thu, 23 Nov 2023 14:49:34 -0500
X-MC-Unique: RTL7GcyoMBGxB_GeT5883w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 823EE828AC2;
 Thu, 23 Nov 2023 19:49:34 +0000 (UTC)
Received: from localhost (unknown [10.39.192.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7C9B1121306;
 Thu, 23 Nov 2023 19:49:33 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 0/4] scsi: eliminate AioContext lock
Date: Thu, 23 Nov 2023 14:49:27 -0500
Message-ID: <20231123194931.171598-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 hw/scsi/scsi-bus.c              | 174 ++++++++++++++++++++++----------
 hw/scsi/scsi-disk.c             |  23 -----
 hw/scsi/scsi-generic.c          |  20 +---
 hw/scsi/virtio-scsi-dataplane.c |   8 +-
 system/dma-helpers.c            |   7 +-
 6 files changed, 130 insertions(+), 109 deletions(-)

-- 
2.42.0


