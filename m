Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BA27B6921
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:37:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnedH-0006Yk-FL; Tue, 03 Oct 2023 08:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qned8-0006XS-OA
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:36:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qned2-0000DX-Hh
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696336553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r/Y1cU2ODhF+Iofp/UMs3AE7XUskSg3+N3KRR7wRi7M=;
 b=QSCVfoTMCzYJyt4jpq4M5Td1+m6K3CP37gPDC94Adt8KglagD3BCyV8AnjcrQWGT6NYOTF
 idGgjbLpC+2qVLoAqGCpIFr2XxcKFptZmTQ2uWakfO7AfHANXVnR8Ifrvh4DSvVTa/xiOE
 pfQuOFgHY8nscqJaDkkMD3hjKjNh9H4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-fuyCtripOU2NjOw86mkjYg-1; Tue, 03 Oct 2023 08:35:46 -0400
X-MC-Unique: fuyCtripOU2NjOw86mkjYg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5EFC01C06521
 for <qemu-devel@nongnu.org>; Tue,  3 Oct 2023 12:35:46 +0000 (UTC)
Received: from localhost (unknown [10.39.208.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96738C15BB8;
 Tue,  3 Oct 2023 12:35:45 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 00/13] Misc patches
Date: Tue,  3 Oct 2023 16:35:29 +0400
Message-ID: <20231003123543.1360795-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124;
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

The following changes since commit 50d0bfd0ed78209f003e8f7b9ac25edaa0399157:

  Merge tag 'migration-20231002-pull-request' of https://gitlab.com/juan.quintela/qemu into staging (2023-10-02 14:42:44 -0400)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/misc-pull-request

for you to fetch changes up to 4f7689f0817a717d18cc8aca298990760f27a89b:

  chardev/char-pty: Avoid losing bytes when the other side just (re-)connected (2023-10-03 15:40:09 +0400)

----------------------------------------------------------------
Misc fixes and cleanups

----------------------------------------------------------------

Akihiko Odaki (1):
  input: Allow to choose console with qemu_input_is_absolute

Ken Xue (1):
  ui: add XBGR8888 and ABGR8888 in drm_format_pixman_map

Laszlo Ersek (5):
  ui/console: make qemu_console_is_multihead() static
  ui/console: only walk QemuGraphicConsoles in
    qemu_console_is_multihead()
  ui/console: eliminate QOM properties from qemu_console_is_multihead()
  ui/console: sanitize search in qemu_graphic_console_is_multihead()
  hw/display/ramfb: plug slight guest-triggerable leak on mode setting

Marc-André Lureau (5):
  win32: avoid discarding the exception handler
  ui/gtk: fix UI info precondition
  analyze-migration: ignore RAM_SAVE_FLAG_MULTIFD_FLUSH
  hw/core: remove needless includes
  hw/pc: remove needless includes

Thomas Huth (1):
  chardev/char-pty: Avoid losing bytes when the other side just
    (re-)connected

 include/qemu/compiler.h      |  6 ++++++
 include/ui/console.h         |  1 -
 include/ui/input.h           |  2 +-
 include/ui/qemu-pixman.h     |  4 ++++
 chardev/char-pty.c           | 22 +++++++++++++++++---
 hw/core/machine.c            | 10 ---------
 hw/display/ramfb.c           |  1 +
 hw/i386/pc.c                 | 39 ------------------------------------
 ui/console.c                 | 24 ++++++++++------------
 ui/dbus-console.c            |  6 +++---
 ui/gtk.c                     | 20 ++++++++++++------
 ui/input.c                   | 29 +++++++--------------------
 ui/qemu-pixman.c             |  4 +++-
 ui/sdl2.c                    | 26 ++++++++++++------------
 ui/spice-input.c             |  2 +-
 ui/vnc.c                     |  2 +-
 util/oslib-win32.c           |  2 +-
 scripts/analyze-migration.py |  4 ++++
 ui/cocoa.m                   |  2 +-
 ui/trace-events              |  1 -
 20 files changed, 90 insertions(+), 117 deletions(-)

-- 
2.41.0


