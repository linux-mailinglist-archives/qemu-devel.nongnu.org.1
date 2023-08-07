Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E77C97730A7
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 22:48:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT78X-00055s-G6; Mon, 07 Aug 2023 16:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qT78V-00055i-Nw
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 16:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qT78T-0006Z9-OI
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 16:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691441247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gxw1WltxHgc1SETAqyGe+yVM1CoZ7Hlm/Fg0DiXt3HA=;
 b=a8cgVM7zcr+aQ8Qy2ENwFqybjUwY+rvQfBdbZRoitoyBvKHJLrLPe20FvGfEueVrr7k4Am
 6dOQI4CC3DaNhkGCmLyalqxlFoBmFallxZrmESPynOZfYVntsvVKhpB264CDLpcjCpBaX9
 VTaUMmElQB9gy7eux87KQ4HkgnG8ei4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-LBuLx3jAOvKtQtltTqkAwg-1; Mon, 07 Aug 2023 16:47:24 -0400
X-MC-Unique: LBuLx3jAOvKtQtltTqkAwg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBE118019CC;
 Mon,  7 Aug 2023 20:47:23 +0000 (UTC)
Received: from localhost (unknown [10.39.208.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2FA331121314;
 Mon,  7 Aug 2023 20:47:21 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 0/6] Fixes patches
Date: Tue,  8 Aug 2023 00:47:11 +0400
Message-ID: <20230807204717.2483983-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

The following changes since commit 9400601a689a128c25fa9c21e932562e0eeb7a26:

  Merge tag 'pull-tcg-20230806-3' of https://gitlab.com/rth7680/qemu into staging (2023-08-06 16:47:48 -0700)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/fixes-pull-request

for you to fetch changes up to 58ea90f8032912b41e753a95089ba764fcc6446a:

  ui/gtk: set scanout mode in gd_egl/gd_gl_area_scanout_texture (2023-08-07 17:13:42 +0400)

----------------------------------------------------------------
Fixes for 8.1

Hi,

Here is a collection of ui, dump and chardev fixes that are worth for 8.1.

thanks

----------------------------------------------------------------

Dongli Zhang (1):
  dump: kdump-zlib data pages not dumped with pvtime/aarch64

Dongwon Kim (1):
  ui/gtk: set scanout mode in gd_egl/gd_gl_area_scanout_texture

Marc-André Lureau (3):
  chardev: report the handshake error
  virtio-gpu: free BHs, by implementing unrealize
  virtio-gpu: reset gfx resources in main thread

Zongmin Zhou (1):
  hw/i386/vmmouse:add relative packet flag for button status

 include/hw/virtio/virtio-gpu.h |  4 +++
 chardev/char-socket.c          | 12 +++++++--
 dump/dump.c                    |  4 +--
 hw/display/virtio-gpu-base.c   |  2 +-
 hw/display/virtio-gpu.c        | 48 +++++++++++++++++++++++++++++-----
 hw/i386/vmmouse.c              | 15 ++++++++---
 ui/gtk-egl.c                   |  1 +
 ui/gtk-gl-area.c               |  1 +
 8 files changed, 72 insertions(+), 15 deletions(-)

-- 
2.41.0


