Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6FB78D49D
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:39:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHf7-0007FV-Tf; Wed, 30 Aug 2023 05:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHf5-0007Eu-Bg
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:38:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHf1-0000pX-ML
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cQ5AqcZTK82+6RR1+2VeCQaqXpl66JiwbUlSDGkTN0g=;
 b=acDuENdAnsQxIag4+gKSNzyHWbg0ZXBPVKSd/BNKlBWRx4QL9V+pRvp+ZkeegMQicUySYz
 N088AedxC7zv4ATvy7ZPnGxW97bN5Lp5Lu1oG4IPIk1Af5GypHNKqXzBCOgTA3sYuda8RS
 zjsMVEUfwiTMnbxkTEI4iEWMiZuL7S4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-yNLCx9Q_Nd6Z5sG3SkSmqw-1; Wed, 30 Aug 2023 05:38:48 -0400
X-MC-Unique: yNLCx9Q_Nd6Z5sG3SkSmqw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E4BD185A792
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:38:48 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0259FC15BAE;
 Wed, 30 Aug 2023 09:38:46 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 00/67] Make pixman an optional dependency
Date: Wed, 30 Aug 2023 13:37:34 +0400
Message-ID: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QEMU system emulators can be made to compile and work without pixman.

Given how pervasively pixman types and API is used in all the code base, it was
a bit difficult to figure out how to cut the dependency.

I decided that it was important to keep VGA and graphics device working for
compatibility reasons, although some devices, such as xlnx Display Port, have
stronger dependency and have to be disabled. The ui/console code also has a lot
of pixman usage and a bit of a mess to deal with. I made large refactoring to
allow to compile out the VC code.

The series can be roughly divded as:
- a few related preliminary cleanups
- ui/console refactoring to allow ui/vc split
- add a 'pixman' option, and a minimal pixman-compat.h
- make some parts depend on 'pixman'

Graphic -display still work, although with some caveats. For ex, -display sdl or
cocoa don't have VCs, so starting QEMU will print the following warnings when
pixman is disabled:

qemu-system-x86_64: warning: compat_monitor0: this is a dummy VC driver. Use '-nographic' or a different chardev.
qemu-system-x86_64: warning: serial0: this is a dummy VC driver. Use '-nographic' or a different chardev.
qemu-system-x86_64: warning: parallel0: this is a dummy VC driver. Use '-nographic' or a different chardev.

But -display dbus is fully functionnal, for ex, as it operates at chardev/text
level.

Fixes:
https://gitlab.com/qemu-project/qemu/-/issues/1172

Marc-André Lureau (67):
  ui: remove qemu_pixman_color() helper
  ui: remove qemu_pixman_linebuf_copy()
  ui/qmp: move screendump to ui-qmp-cmds.c
  ui/vc: replace vc_chr_write() with generic qemu_chr_write()
  ui/vc: drop have_text
  ui/console: console_select() regardless of have_gfx
  ui/console: call dpy_gfx_update() regardless of have_gfx
  ui/console: drop have_gfx
  ui/console: get the DisplayState from new_console()
  ui/console: new_console() cannot fail
  ui/vc: VC always has a DisplayState now
  ui/vc: move VCChardev declaration at the top
  ui/vc: replace variable with static text attributes default
  ui/vc: fold text_update_xy()
  ui/vc: pass VCCharDev to VC-specific functions
  ui/vc: move VCCharDev specific fields out of QemuConsole
  ui/console: use OBJECT_DEFINE_TYPE for QemuConsole
  ui/console: change new_console() to use object initialization
  ui/console: introduce different console objects
  ui/console: instantiate a specific console type
  ui/console: register the console from qemu_console_init()
  ui/console: remove new_console()
  ui/console: specialize console_lookup_unused()
  ui/console: update the head from unused QemuConsole
  ui/console: allocate ui_timer in QemuConsole
  ui/vc: move cursor_timer initialization to QemuTextConsole class
  ui/console: free more QemuConsole resources
  ui/vc: move text fields to QemuTextConsole
  ui/console: move graphic fields to QemuGraphicConsole
  ui/vc: fold text_console_do_init() in vc_chr_open()
  ui/vc: move some text console initialization to qom handlers
  ui/console: simplify getting active_console size
  ui/console: remove need for g_width/g_height
  ui/vc: use common text console surface creation
  ui/console: declare console types in console.h
  ui/console: use QEMU_PIXMAN_COLOR helpers
  ui/console: rename vga_ functions → qemu_console_
  ui/console: assert(surface) where appropriate
  ui/console: fold text_console_update_cursor_timer
  ui/vc: skip text console resize when possible
  ui/console: minor stylistic changes
  ui/vc: move text console invalidate in helper
  ui/vc: do not parse VC-specific options in Spice and GTK
  ui/vc: change the argument for QemuTextConsole
  ui/vc: remove kby_put_keysym() and update function calls
  ui/vc: rename kbd_put → qemu_text_console functions
  ui/console: remove redundant format field
  ui/vc: preliminary QemuTextConsole changes before split
  ui/vc: split off the VC part from console.c
  ui/console: move DisplaySurface to its own header
  build-sys: add optional "pixman" feature
  ui: compile out some qemu-pixman functions when !PIXMAN
  ui: add pixman-compat.h
  ui/vc: console-vc requires PIXMAN
  qmp/hmp: disable screendump if PIXMAN is missing
  virtio-gpu: replace PIXMAN for region/rect test
  ui/console: when PIXMAN is unavailable, don't draw placeholder msg
  vhost-user-gpu: skip VHOST_USER_GPU_UPDATE when !PIXMAN
  ui/gl: opengl doesn't require PIXMAN
  ui/vnc: VNC requires PIXMAN
  ui/spice: SPICE/QXL requires PIXMAN
  ui/gtk: -display gtk requires PIXMAN
  ui/dbus: do not require PIXMAN
  arm/kconfig: XLNX_ZYNQMP_ARM depends on PIXMAN
  ppc/kconfig: make SAM460EX depend on PPC & PIXMAN
  sh4/kconfig: make R2D depend on SH4 & PIXMAN
  display/kconfig: make SM501 depend on PIXMAN

 configs/devices/ppc-softmmu/default.mak |    2 +-
 configs/devices/sh4-softmmu/default.mak |    2 +-
 meson.build                             |   11 +-
 qapi/char.json                          |    4 +
 qapi/ui.json                            |    3 +-
 include/chardev/char.h                  |    3 -
 include/ui/console.h                    |  118 +-
 include/ui/pixman-compat.h              |  190 +++
 include/ui/qemu-pixman.h                |   20 +-
 include/ui/rect.h                       |   55 +
 include/ui/surface.h                    |   91 ++
 ui/console-priv.h                       |   43 +
 hw/display/vhost-user-gpu.c             |    2 +
 hw/display/virtio-gpu.c                 |   30 +-
 ui/console-gl.c                         |    2 +-
 ui/console-vc-stubs.c                   |   59 +
 ui/console-vc.c                         | 1079 +++++++++++++++
 ui/console.c                            | 1603 +++--------------------
 ui/curses.c                             |    2 +-
 ui/dbus-listener.c                      |   62 +-
 ui/gtk.c                                |   11 +-
 ui/qemu-pixman.c                        |   25 +-
 ui/sdl2-input.c                         |    5 +-
 ui/sdl2.c                               |    5 +-
 ui/spice-app.c                          |    7 +-
 ui/spice-display.c                      |    2 +-
 ui/ui-hmp-cmds.c                        |    2 +
 ui/ui-qmp-cmds.c                        |  189 +++
 ui/vnc.c                                |   56 +-
 Kconfig.host                            |    3 +
 hmp-commands.hx                         |    2 +
 hw/arm/Kconfig                          |    2 +-
 hw/display/Kconfig                      |    3 +-
 hw/ppc/Kconfig                          |    2 +
 hw/sh4/Kconfig                          |    2 +
 meson_options.txt                       |    2 +
 ui/cocoa.m                              |    2 +-
 ui/meson.build                          |   25 +-
 38 files changed, 2093 insertions(+), 1633 deletions(-)
 create mode 100644 include/ui/pixman-compat.h
 create mode 100644 include/ui/rect.h
 create mode 100644 include/ui/surface.h
 create mode 100644 ui/console-priv.h
 create mode 100644 ui/console-vc-stubs.c
 create mode 100644 ui/console-vc.c

-- 
2.41.0


