Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D967E38FE
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:23:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J81-0007jA-FS; Tue, 07 Nov 2023 05:16:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0J7c-0007ZU-Hn
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:15:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0J7Z-0003Wz-C5
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699352140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N2OYY1iLhbSnnDj8K99i21Hgro0IpdZQmbaAqBH7EdI=;
 b=PmjEaAzmCAwdW5QMciMcKX/zdz7r+lvdmgIe1yA/2MFUGBhGZFSvL1NsHAY1j9k4adFRCq
 xdEv3t0M/1HnQnqi0SHRy1rF3D7Yeqp7qMLzCOF6pYl1lveXDbypisVbDJPInN2Jnh7dKJ
 SbhK4UP815Y0Du+6aAtg5OfAEekBTHw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-3h6JpbBgPsy4tfcbReq0SA-1; Tue, 07 Nov 2023 05:15:28 -0500
X-MC-Unique: 3h6JpbBgPsy4tfcbReq0SA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FA928564E6;
 Tue,  7 Nov 2023 10:15:28 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D53C2026D66;
 Tue,  7 Nov 2023 10:15:26 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v3 00/25] Pixman patches
Date: Tue,  7 Nov 2023 14:14:58 +0400
Message-ID: <20231107101524.2993389-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following changes since commit bb541a7068d2eee51a9abbe2dedcdf27298b1872:

  Merge tag 'pull-pa-20231106' of https://gitlab.com/rth7680/qemu into staging (2023-11-07 15:01:17 +0800)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/pixman-pull-request

for you to fetch changes up to d017f28a2ee082f472ed69fedf0435b468000e92:

  build-sys: make pixman actually optional (2023-11-07 14:04:25 +0400)

----------------------------------------------------------------
Make Pixman an optional dependency

----------------------------------------------------------------

Marc-André Lureau (25):
  build-sys: add a "pixman" feature
  build-sys: drop needless warning pragmas for old pixman
  ui: compile out some qemu-pixman functions when !PIXMAN
  ui: add pixman-minimal.h
  vl: drop needless -spice checks
  qemu-options: define -vnc only #ifdef CONFIG_VNC
  vl: simplify display_remote logic
  vl: move display early init before default devices
  ui/console: allow to override the default VC
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
  hw/arm: XLNX_VERSAL depends on XLNX_CSU_DMA
  hw/sm501: allow compiling without PIXMAN
  hw/mips: FULOONG depends on VT82C686
  hw/display/ati: allow compiling without PIXMAN
  build-sys: make pixman actually optional

 meson.build                   |  25 ++++-
 qapi/ui.json                  |   3 +-
 include/ui/console.h          |   2 +
 include/ui/pixman-minimal.h   | 195 ++++++++++++++++++++++++++++++++++
 include/ui/qemu-pixman.h      |  15 +--
 include/ui/rect.h             |  59 ++++++++++
 hw/display/ati.c              |  15 ++-
 hw/display/ati_2d.c           |  10 +-
 hw/display/sm501.c            |  45 +++++---
 hw/display/vhost-user-gpu.c   |   2 +
 hw/display/virtio-gpu.c       |  30 ++----
 system/vl.c                   |  84 ++++++++-------
 ui/console-vc-stubs.c         |  33 ++++++
 ui/console.c                  |  19 ++++
 ui/dbus-listener.c            |  90 +++++++++++-----
 ui/qemu-pixman.c              |   6 ++
 ui/ui-hmp-cmds.c              |   2 +
 ui/ui-qmp-cmds.c              |   2 +
 ui/vnc-stubs.c                |  12 ---
 Kconfig.host                  |   3 +
 hmp-commands.hx               |   2 +
 hw/arm/Kconfig                |   4 +-
 hw/display/Kconfig            |   7 +-
 hw/display/meson.build        |   4 +-
 hw/mips/Kconfig               |   1 +
 meson_options.txt             |   2 +
 qemu-options.hx               |   2 +
 scripts/meson-buildoptions.sh |   3 +
 ui/meson.build                |  22 ++--
 29 files changed, 560 insertions(+), 139 deletions(-)
 create mode 100644 include/ui/pixman-minimal.h
 create mode 100644 include/ui/rect.h
 create mode 100644 ui/console-vc-stubs.c

-- 
2.41.0


