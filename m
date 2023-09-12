Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5C679CEB7
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 12:48:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg0v9-0002lG-Ve; Tue, 12 Sep 2023 06:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0v7-0002l7-OA
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0v5-0003D1-D3
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694515618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yFLrBSZukXNbcOjGyDr4el3eleDHlj0VIFzDCBsFJNg=;
 b=b6IZKXhN3YVc/eycaIrFH7efJAUU1cn+jLmaXvQdpNYYf3LbIoRaBnDaTKtVjy7GCVtFGF
 7V0mDEfi3AOZ5Bj4AM8h/bAoeIUoD9iZkTUORfGJStME3ud4/27OzEncnTSg1zPbfj+wDS
 4R+3RZ23p/LHvyJ8VlI1o8OohevMifM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-qzCyeSgEMKqLfXqeM8kkog-1; Tue, 12 Sep 2023 06:46:57 -0400
X-MC-Unique: qzCyeSgEMKqLfXqeM8kkog-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5ED83C0F222
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 10:46:52 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E691A10F1BE8;
 Tue, 12 Sep 2023 10:46:51 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 00/14] Ui patches
Date: Tue, 12 Sep 2023 14:46:34 +0400
Message-ID: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 9ef497755afc252fb8e060c9ea6b0987abfd20b6:

  Merge tag 'pull-vfio-20230911' of https://github.com/legoater/qemu into staging (2023-09-11 09:13:08 -0400)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to a92e7bb4cad57cc5c8817fb18fb25650507b69f8:

  ui: add precondition for dpy_get_ui_info() (2023-09-12 11:14:09 +0400)

----------------------------------------------------------------
UI patch queue

- vhost-user-gpu: support dmabuf modifiers
- fix VNC crash when there are no active_console
- cleanups and refactoring in ui/vc code

----------------------------------------------------------------

Erico Nunes (3):
  docs: vhost-user-gpu: add protocol changes for dmabuf modifiers
  contrib/vhost-user-gpu: add support for sending dmabuf modifiers
  vhost-user-gpu: support dmabuf modifiers

Marc-André Lureau (11):
  vmmouse: replace DPRINTF with tracing
  vmmouse: use explicit code
  ui/vc: remove kbd_put_keysym() and update function calls
  ui/vc: rename kbd_put to qemu_text_console functions
  ui/console: remove redundant format field
  ui/vc: preliminary QemuTextConsole changes before split
  ui/vc: split off the VC part from console.c
  ui/console: move DisplaySurface to its own header
  virtio-gpu/win32: set the destroy function on load
  ui: fix crash when there are no active_console
  ui: add precondition for dpy_get_ui_info()

 docs/interop/vhost-user-gpu.rst         |   26 +-
 contrib/vhost-user-gpu/vugpu.h          |    9 +
 include/ui/console.h                    |   94 +-
 include/ui/surface.h                    |   95 ++
 ui/console-priv.h                       |   43 +
 contrib/vhost-user-gpu/vhost-user-gpu.c |    5 +-
 contrib/vhost-user-gpu/virgl.c          |   51 +-
 hw/display/vhost-user-gpu.c             |   17 +-
 hw/display/virtio-gpu.c                 |    4 +-
 hw/i386/vmmouse.c                       |   40 +-
 ui/console-gl.c                         |    2 +-
 ui/console-vc.c                         | 1079 ++++++++++++++++++++++
 ui/console.c                            | 1119 +----------------------
 ui/curses.c                             |    2 +-
 ui/gtk.c                                |    8 +-
 ui/sdl2-input.c                         |    4 +-
 ui/sdl2.c                               |    2 +-
 ui/spice-display.c                      |    2 +-
 ui/vnc.c                                |   56 +-
 hw/i386/trace-events                    |   10 +
 ui/cocoa.m                              |    2 +-
 ui/meson.build                          |    1 +
 22 files changed, 1426 insertions(+), 1245 deletions(-)
 create mode 100644 include/ui/surface.h
 create mode 100644 ui/console-priv.h
 create mode 100644 ui/console-vc.c

-- 
2.41.0


