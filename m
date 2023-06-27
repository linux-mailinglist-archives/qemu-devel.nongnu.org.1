Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8020573FC73
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:09:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8Lc-0008RH-C3; Tue, 27 Jun 2023 09:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8LW-0008QZ-GQ
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8LS-00070S-Ot
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687870977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=91S7EmkyhSOWaPj9c77xZsAbiW5JCQBRPm02LlM0X2E=;
 b=ay/7ecfyBwMuO4FFNA41KfO3A3draiVk/1r3gbaqvaitYRPIPq93qh0fTUjq3Eiqpevgog
 Uca6LzY05r46hZMoFCJN3DXTBATevCH9eeZExSrSfyypBxlagO3wBnVRviYIOWDcAxW8zc
 uDBgCJS0Ep1GKtB99C7YIQMjOySMixA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-245-4xGbQKsoOjOhKVvHaVcD0A-1; Tue, 27 Jun 2023 09:02:56 -0400
X-MC-Unique: 4xGbQKsoOjOhKVvHaVcD0A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06E5D18E52D6;
 Tue, 27 Jun 2023 13:02:34 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79FC340C2063;
 Tue, 27 Jun 2023 13:02:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 00/33] UI patches
Date: Tue, 27 Jun 2023 15:01:57 +0200
Message-ID: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following changes since commit 4329d049d5b8d4af71c6b399d64a6d1b98856318:

  Merge tag 'pull-tcg-20230626' of https://gitlab.com/rth7680/qemu into staging (2023-06-26 17:40:38 +0200)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to b41858bd0a1361fda7ecb2a08b9b07e21d67f57d:

  ui/dbus: use shared D3D11 Texture2D when possible (2023-06-27 12:33:11 +0200)

----------------------------------------------------------------
UI patches

- add dbus multi-touch interface
- add dbus win32 support
- fixes for sdl & gtk display
- fix for win32 stdio chardev

----------------------------------------------------------------

Antonio Caggiano (1):
  ui/sdl2: OpenGL window context

Bilal Elmoussaoui (2):
  ui/touch: Move event handling to a common helper
  ui/dbus: Expose a touch device interface

Dongwon Kim (4):
  virtio-gpu-udmabuf: create udmabuf for blob even when iov_cnt == 1
  ui/gtk: set the area of the scanout texture correctly
  virtio-gpu: OUT_OF_MEMORY if failing to create udmabuf
  ui/gtk: making dmabuf NULL when it's released.

Keqian Zhu via (1):
  virtio-gpu: Optimize 2D resource data transfer

Marc-André Lureau (23):
  ui: return NULL when getting cursor without a console
  egl: no need to lookup EGL functions manually
  ui/egl: export qemu_egl_get_error_string()
  ui/egl: fix make_context_current() callback return value
  ui/dbus: compile without gio/gunixfdlist.h
  scripts: add a XML preprocessor script
  ui/dbus: win32 support
  qtest: add qtest_pid()
  tests: make dbus-display-test work on win32
  ui/dbus: introduce "Interfaces" properties
  console/win32: allocate shareable display surface
  virtio-gpu/win32: allocate shareable 2d resources/images
  ui/dbus: use shared memory when possible on win32
  ui: add egl-headless support on win32
  ui/egl: default to GLES on windows
  ui: add egl_fb_read_rect()
  ui/dbus: add GL support on win32
  ui/dbus: add some GL traces
  virtio-gpu-virgl: teach it to get the QEMU EGL display
  ui/egl: query ANGLE d3d device
  ui: add optional d3d texture pointer to scanout texture
  virtio-gpu-virgl: use D3D11_SHARE_TEXTURE when available
  ui/dbus: use shared D3D11 Texture2D when possible

Vivek Kasireddy (1):
  virtio-gpu: Make non-gl display updates work again when blob=true

Zhang Huasen (1):
  chardev/char-win-stdio: Support VT sequences on Windows 11 host

 MAINTAINERS                     |   1 +
 meson.build                     |  10 +-
 qapi/ui.json                    |   5 +-
 include/hw/virtio/virtio-gpu.h  |   3 +
 include/sysemu/os-win32.h       |   3 +
 include/ui/console.h            |  30 +-
 include/ui/egl-helpers.h        |  11 +-
 include/ui/gtk.h                |   6 +-
 include/ui/sdl2.h               |   3 +-
 tests/qtest/libqtest.h          |   9 +
 ui/dbus.h                       |   6 +
 audio/dbusaudio.c               |  43 ++-
 chardev/char-win-stdio.c        |   2 +-
 hw/display/virtio-gpu-udmabuf.c |   3 +-
 hw/display/virtio-gpu-virgl.c   |  43 ++-
 hw/display/virtio-gpu.c         |  99 ++++--
 tests/qtest/dbus-display-test.c |  43 ++-
 tests/qtest/libqtest.c          |   5 +
 ui/console.c                    | 137 ++++++++-
 ui/dbus-chardev.c               |  20 +-
 ui/dbus-console.c               | 124 +++++++-
 ui/dbus-listener.c              | 527 +++++++++++++++++++++++++++++---
 ui/dbus.c                       |   4 -
 ui/egl-context.c                |  10 +-
 ui/egl-headless.c               |  25 +-
 ui/egl-helpers.c                | 104 +++++--
 ui/gtk-egl.c                    |  16 +-
 ui/gtk-gl-area.c                |   6 +-
 ui/gtk.c                        |  66 +---
 ui/qemu-pixman.c                |   1 +
 ui/sdl2-gl.c                    |   3 +-
 ui/sdl2.c                       |  18 +-
 ui/spice-display.c              |   3 +-
 util/oslib-win32.c              |  33 ++
 scripts/meson.build             |   2 +
 scripts/xml-preprocess-test.py  | 136 +++++++++
 scripts/xml-preprocess.py       | 293 ++++++++++++++++++
 tests/qtest/meson.build         |   2 +-
 ui/dbus-display1.xml            | 285 ++++++++++++++++-
 ui/meson.build                  |  15 +-
 ui/trace-events                 |   9 +-
 util/trace-events               |   4 +
 42 files changed, 1953 insertions(+), 215 deletions(-)
 create mode 100644 scripts/xml-preprocess-test.py
 create mode 100755 scripts/xml-preprocess.py

-- 
2.41.0


