Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 748B1713996
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 15:22:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3GK1-0007TY-2m; Sun, 28 May 2023 09:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GJx-0007TJ-5b
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q3GJv-0007ye-BS
 for qemu-devel@nongnu.org; Sun, 28 May 2023 09:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685280025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zrNyY/qtfEIcVGG1unmH35/CEF6je/5rmmspbO0FKMM=;
 b=hRNxyGa9gikcV+RzYPg669fNt5yOCZgjYUx3ysOVHBxvqycuAAns1zvY2dcD3TWxbK+wpL
 blWjI8DgG6qVRSNS7b04nLDXKSgy4hKv1pqAhVXNeZlQf7n2Y1TAdiB2/4ywa66whjwEXr
 OQiscWCTUvUgRMu+XgCRPQNlYE9rO4M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-PLh1ZsKzOy-7IQkXZl0GeA-1; Sun, 28 May 2023 09:20:21 -0400
X-MC-Unique: PLh1ZsKzOy-7IQkXZl0GeA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84B41811E78;
 Sun, 28 May 2023 13:20:21 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ECAAD202696C;
 Sun, 28 May 2023 13:20:18 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, berrange@redhat.com,
 Eric Blake <eblake@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 00/19] Ui patches
Date: Sun, 28 May 2023 17:19:57 +0400
Message-Id: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit ac84b57b4d74606f7f83667a0606deef32b2049d:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-05-26 14:40:55 -0700)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to 5a4cb61ae1ab0068ab53535ed0ccaf41a5e97d2f:

  ui/gtk: enable backend to send multi-touch events (2023-05-28 16:25:38 +0400)

----------------------------------------------------------------
UI queue

- virtio: add virtio-multitouch device
- sdl: various keyboard grab fixes
- gtk: enable multi-touch events
- misc fixes

----------------------------------------------------------------

Bernhard Beschow (2):
  ui/sdl2: Grab Alt+Tab also in fullscreen mode
  ui/sdl2: Grab Alt+F4 also under Windows

Erico Nunes (3):
  ui/gtk: fix passing y0_top parameter to scanout
  ui/gtk: use widget size for cursor motion event
  ui/gtk-egl: fix scaling for cursor position in scanout mode

Marc-André Lureau (6):
  ui/sdl2: fix surface_gl_update_texture: Assertion 'gls' failed
  ui/dbus: fix compilation when GBM && !OPENGL
  win32: wrap socket close() with an exception handler
  virtio-gpu: add a FIXME for virtio_gpu_load()
  gtk: add gl-area support on win32
  ui/dbus: add a FIXME about texture/dmabuf scanout handling

Mauro Matteo Cascella (1):
  ui/cursor: make width/height unsigned 16-bit integer

Sergio Lopez (6):
  virtio-input: generalize virtio_input_key_config()
  ui: add the infrastructure to support MT events
  virtio-input: add a virtio-mulitouch device
  virtio-input-pci: add virtio-multitouch-pci
  ui: add helpers for virtio-multitouch events
  ui/gtk: enable backend to send multi-touch events

Volker Rümelin (1):
  ui/sdl2: disable SDL_HINT_GRAB_KEYBOARD on Windows

 qapi/ui.json                     |  68 ++++++++++++--
 include/hw/virtio/virtio-input.h |   9 +-
 include/sysemu/os-win32.h        |   4 +
 include/ui/console.h             |   4 +-
 include/ui/input.h               |   8 ++
 hw/display/virtio-gpu.c          |   1 +
 hw/input/virtio-input-hid.c      | 156 +++++++++++++++++++++++++++----
 hw/virtio/virtio-input-pci.c     |  25 ++++-
 replay/replay-input.c            |  18 ++++
 ui/cursor.c                      |   3 +-
 ui/dbus-listener.c               |  15 ++-
 ui/gtk-egl.c                     |   6 +-
 ui/gtk-gl-area.c                 |   2 +-
 ui/gtk.c                         | 106 ++++++++++++++++++++-
 ui/input.c                       |  42 +++++++++
 ui/sdl2-gl.c                     |   4 +
 ui/sdl2.c                        |   7 ++
 util/oslib-win32.c               |  23 +++--
 ui/trace-events                  |   1 +
 19 files changed, 442 insertions(+), 60 deletions(-)

-- 
2.40.1


