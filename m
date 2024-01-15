Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFFB82DCA0
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 16:50:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPPCc-00037G-6u; Mon, 15 Jan 2024 10:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rPPCa-000372-2Z
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 10:48:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rPPCX-0007aS-Mv
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 10:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705333716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0eBPF/UewMwHnEPR2TcUYk6jKkzAu2oJVr1CB+GEdJg=;
 b=FHxNWh0ejFxpXQzBFg9i2jHr0OVJj4WWJmTZPkUlyjv+XqoQJWGQfHINGKI5jllAVOwaV4
 Wes/g/PPYCcejSH0tLrguJ2Xq+kXX0rFbg/wt+4nKIfJOf17l/Z2MYNrNJsZTudJZYOlZE
 kMXqexYsLDC0OM75HOTXCeNYifzRjKw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-UmF5uXa1OMuRBRBpMAY4aQ-1; Mon,
 15 Jan 2024 10:48:34 -0500
X-MC-Unique: UmF5uXa1OMuRBRBpMAY4aQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C73E1C29EA7
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 15:48:34 +0000 (UTC)
Received: from localhost (unknown [10.39.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40C151121306;
 Mon, 15 Jan 2024 15:48:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/2] virtio-gpu: fix blob scanout post-load
Date: Mon, 15 Jan 2024 19:48:28 +0400
Message-ID: <20240115154830.498304-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Hi,

The current post-loading code for scanout has a FIXME: it doesn't take the
resource region/rect into account. But there is more, when adding blob migration
support in commit f66767f75c9, I didn't realize that blob resources could be
used for scanouts. This situationn leads to a crash during post-load, as they
don't have an associated res->image.

virtio_gpu_do_set_scanout() handle all cases, but requires the associated
virtio_gpu_framebuffer, which is currently not saved during migration.

Add a v2 of "virtio-gpu-one-scanout" with the framebuffer fields, so we can
restore blob scanouts, as well as fixing the existing FIXME.

Marc-André Lureau (2):
  virtio-gpu: remove needless condition
  virtio-gpu: fix scanout migration post-load

 include/hw/virtio/virtio-gpu.h |  1 +
 hw/display/virtio-gpu.c        | 61 ++++++++++++++++++++++++----------
 2 files changed, 45 insertions(+), 17 deletions(-)

-- 
2.43.0


