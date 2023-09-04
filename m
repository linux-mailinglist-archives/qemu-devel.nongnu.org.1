Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 587AA791676
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:54:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd88h-000203-7y; Mon, 04 Sep 2023 07:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd88b-0001xI-7u
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd88Y-0008EZ-9o
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sEHeOqjSmcJEuubGVo2RvR0+YNacRwwIj4iFQ715WLo=;
 b=ZTt6Xm5At2FHvv2RFPvzaHkAKnWBC40biPHc7jR8J4TndKgpQpUIAvGBnsTyGqIl4UYfZK
 7U+zduujQbJBqQpQwARpMd9e0NjVqseVfOeJC2TBQe+wevUhKovsPH847ko7YQF4YKCLtT
 FRJ4LleNioa3ZzAZr/fEfTchIvjUNuQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-kDV0wY02NrO1ww13K1G2_Q-1; Mon, 04 Sep 2023 07:52:55 -0400
X-MC-Unique: kDV0wY02NrO1ww13K1G2_Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2B98380671E
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:52:54 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CD4D40C6CCC;
 Mon,  4 Sep 2023 11:52:53 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 00/52] UI patches
Date: Mon,  4 Sep 2023 15:51:57 +0400
Message-ID: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

The following changes since commit 17780edd81d27fcfdb7a802efc870a99788bd2fc:

  Merge tag 'quick-fix-pull-request' of https://gitlab.com/bsdimp/qemu into staging (2023-08-31 10:06:29 -0400)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to e38f4e976dd40c985bfe84230a627de9a108c9d3:

  ui/gtk: fix leaks found wtih fuzzing (2023-09-04 15:37:50 +0400)

----------------------------------------------------------------
UI patch queue

- misc fixes and improvement
- cleanups and refactoring in ui/vc code

----------------------------------------------------------------

Bilal Elmoussaoui (2):
  ui/dbus: Properly dispose touch/mouse dbus objects
  ui/dbus: implement damage regions for GL

Dmitry Frolov (1):
  ui/gtk: fix leaks found wtih fuzzing

Guoyi Tu (2):
  ui/vdagent: call vdagent_disconnect() when agent connection is lost
  ui/vdagent: Unregister input handler of mouse during finalization

Marc-André Lureau (44):
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
  ui/console: rename vga_ functions with qemu_console_
  ui/console: assert(surface) where appropriate
  ui/console: fold text_console_update_cursor_timer
  ui/vc: skip text console resize when possible
  ui/console: minor stylistic changes
  ui/vc: move text console invalidate in helper
  ui/vc: do not parse VC-specific options in Spice and GTK
  ui/vc: change the argument for QemuTextConsole

Peter Maydell (2):
  ui/spice-display: Avoid dynamic stack allocation
  ui/vnc-enc-hextile: Use static rather than dynamic length stack array

Philippe Mathieu-Daudé (1):
  ui/vnc-enc-tight: Avoid dynamic stack allocation

 qapi/char.json                |    4 +
 include/chardev/char.h        |    3 -
 include/ui/console.h          |   34 +-
 include/ui/qemu-pixman.h      |    9 +-
 ui/vnc-enc-hextile-template.h |    8 +-
 ui/console.c                  | 1125 ++++++++++++++-------------------
 ui/dbus-console.c             |    2 +
 ui/dbus-listener.c            |   32 +-
 ui/gtk.c                      |    6 +-
 ui/qemu-pixman.c              |   19 -
 ui/sdl2-input.c               |    7 +-
 ui/sdl2.c                     |    5 +-
 ui/spice-app.c                |    7 +-
 ui/spice-display.c            |    3 +-
 ui/ui-qmp-cmds.c              |  187 ++++++
 ui/vdagent.c                  |    6 +
 ui/vnc-enc-tight.c            |   11 +-
 17 files changed, 776 insertions(+), 692 deletions(-)

-- 
2.41.0


