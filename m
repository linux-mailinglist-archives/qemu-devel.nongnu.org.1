Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2034D72416C
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 13:58:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6VJH-00005R-CW; Tue, 06 Jun 2023 07:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q6VJD-00005F-Cx
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 07:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q6VJB-0005eu-Gs
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 07:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686052623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0IrdVbqPoxZud3am9VPN9exW8ZhMGHVoLseLNJEXS8s=;
 b=XT6P7dtKlRGt2GKHeKd7CtO5wvVjJO/KjPyNkpgU8AWRTkgR4W2ua53zxvxh+Gb4DeJ6Ro
 kTRvqSwyDXUaZWZqkzt/DmntxDSPWKxGXtCa2aZHfdsKbLtjOL/C/shtOOSbhCqZ2VgiO7
 uSL1BAm7qC7Lm1Nt13c9KbVAxkFcn98=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-W2xrzkj8Oy6eWejq9UaUrg-1; Tue, 06 Jun 2023 07:57:02 -0400
X-MC-Unique: W2xrzkj8Oy6eWejq9UaUrg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BE3A282CCA1
 for <qemu-devel@nongnu.org>; Tue,  6 Jun 2023 11:57:02 +0000 (UTC)
Received: from localhost (unknown [10.39.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CB38140E954;
 Tue,  6 Jun 2023 11:57:00 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 00/21] -display dbus: add win32 support
Date: Tue,  6 Jun 2023 15:56:37 +0400
Message-Id: <20230606115658.677673-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi,

The D-Bus display doesn't work on Windows, since it relies on FDs transfer over
Unix domain socket. This isn't (yet) supported on Windows. To make it work, the
interfaces are adapted to use 'ay' WSASocketW data instead of 'h' (in a similar
fashion as QMP 'get-win32-socket').

A simple XML preprocessor helps generating the target-specific OS interfaces.

The performance on Windows isn't great though, since there is no DMABUF scanout
sharing between QEMU and the client for example. The first improvement
introduces a org.qemu.Display1.Listener.Win32.Map interface for shared
display/console memory. This can work regardless of 3d accelerated or not, and
should work across various GL implementations as well.

The second improvement relies on ANGLE/EGL Direct3D extensions enabled in virgl
(pending review at
https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1103) to
create shareable Texture2Ds and share them when the client implements the
org.qemu.Display1.Listener.Win32.D3D11 interface. This should give comparable
performance as in-process display hopefully.

Marc-André Lureau (21):
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

 MAINTAINERS                     |   1 +
 meson.build                     |  10 +-
 qapi/ui.json                    |   5 +-
 include/hw/virtio/virtio-gpu.h  |   3 +
 include/sysemu/os-win32.h       |   3 +
 include/ui/console.h            |  15 +-
 include/ui/egl-helpers.h        |  11 +-
 include/ui/gtk.h                |   6 +-
 include/ui/sdl2.h               |   3 +-
 tests/qtest/libqtest.h          |   9 +
 ui/dbus.h                       |   6 +
 audio/dbusaudio.c               |  43 ++-
 hw/display/virtio-gpu-virgl.c   |  43 ++-
 hw/display/virtio-gpu.c         |  46 ++-
 tests/qtest/dbus-display-test.c |  43 ++-
 tests/qtest/libqtest.c          |   5 +
 ui/console.c                    |  70 ++++-
 ui/dbus-chardev.c               |  20 +-
 ui/dbus-console.c               |  64 +++-
 ui/dbus-listener.c              | 527 +++++++++++++++++++++++++++++---
 ui/dbus.c                       |   4 -
 ui/egl-context.c                |  10 +-
 ui/egl-headless.c               |  25 +-
 ui/egl-helpers.c                |  98 +++++-
 ui/gtk-egl.c                    |  14 +-
 ui/gtk-gl-area.c                |   5 +-
 ui/qemu-pixman.c                |   1 +
 ui/sdl2-gl.c                    |   3 +-
 ui/spice-display.c              |   3 +-
 util/oslib-win32.c              |  33 ++
 scripts/meson.build             |   2 +
 scripts/xml-preprocess-test.py  | 136 +++++++++
 scripts/xml-preprocess.py       | 293 ++++++++++++++++++
 tests/qtest/meson.build         |   2 +-
 ui/dbus-display1.xml            | 240 ++++++++++++++-
 ui/meson.build                  |  15 +-
 ui/trace-events                 |   8 +-
 util/trace-events               |   4 +
 38 files changed, 1704 insertions(+), 125 deletions(-)
 create mode 100644 scripts/xml-preprocess-test.py
 create mode 100755 scripts/xml-preprocess.py

-- 
2.40.1


