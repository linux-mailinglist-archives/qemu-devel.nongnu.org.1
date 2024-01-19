Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA94F832AE4
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:01:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQpOI-0004o3-1l; Fri, 19 Jan 2024 08:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rQpOB-0004VP-Tx
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:58:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rQpO9-0000ZW-1V
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705672707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kssRlUuDYOxzrktOINuP+aWm+ItuQq6WQKh8hS6h210=;
 b=UOSPW40bw9IHOzus0yyCd/7VOTYdXwDCo9pD8jaldoaIILEjDRz/FIp+tRqBk4C4QTL2Cw
 FVCYu9LmcRNhbjVDystVUM3E6CTPEoSH5l38uxYp6XTBbKfPnbX05MnXO1TqAB/MrrDlZq
 jvsd98y4gO2N1cFBWPsw+dlJ8j9pxh0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-6fM4myGWO1KW4kjaTmJoZg-1; Fri,
 19 Jan 2024 08:58:26 -0500
X-MC-Unique: 6fM4myGWO1KW4kjaTmJoZg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0A5138562D0;
 Fri, 19 Jan 2024 13:58:25 +0000 (UTC)
Received: from localhost (unknown [10.39.195.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36EBF1C05E0E;
 Fri, 19 Jan 2024 13:58:25 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/6] virtio-blk: iothread-vq-mapping cleanups
Date: Fri, 19 Jan 2024 08:57:42 -0500
Message-ID: <20240119135748.270944-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
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

Kevin Wolf identified some issues with the virtio-blk iothread-vq-mapping patch
series that was merged at the end of 2023:
1. s->rq is restarted from one AioContext and races with the other
   iothread-vq-mapping AioContexts.
2. Failure to set the AioContext is no longer fatal since the IO_CODE APIs can
   be called from any thread. We can relax the error handling behavior.
3. Starting dataplane must self-trigger the ioeventfd even in a drained
   section. Failure to do so could lead to an unresponsive virtio-blk device.

This patch series addresses these issues. The first few patches merge the
hw/block/dataplane/virtio-blk.c code into hw/block/virtio-blk.c so that s->rq
can easily be restarted in the correct AioContexts.

Stefan Hajnoczi (6):
  virtio-blk: move dataplane code into virtio-blk.c
  virtio-blk: rename dataplane create/destroy functions
  virtio-blk: rename dataplane to ioeventfd
  virtio-blk: restart s->rq reqs in vq AioContexts
  virtio-blk: tolerate failure to set BlockBackend AioContext
  virtio-blk: always set ioeventfd during startup

 meson.build                     |   1 -
 hw/block/dataplane/trace.h      |   1 -
 hw/block/dataplane/virtio-blk.h |  34 ---
 include/hw/virtio/virtio-blk.h  |  16 +-
 hw/block/dataplane/virtio-blk.c | 404 -------------------------------
 hw/block/virtio-blk.c           | 412 +++++++++++++++++++++++++++++---
 hw/block/dataplane/meson.build  |   1 -
 hw/block/dataplane/trace-events |   5 -
 8 files changed, 391 insertions(+), 483 deletions(-)
 delete mode 100644 hw/block/dataplane/trace.h
 delete mode 100644 hw/block/dataplane/virtio-blk.h
 delete mode 100644 hw/block/dataplane/virtio-blk.c
 delete mode 100644 hw/block/dataplane/trace-events

-- 
2.43.0


