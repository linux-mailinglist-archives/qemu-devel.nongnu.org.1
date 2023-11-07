Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAC37E37E4
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:32:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0IQ4-0002Zv-Qw; Tue, 07 Nov 2023 04:30:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0IQ0-0002Ze-SN
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:30:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0IPz-0003Xm-1z
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:30:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699349441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gMOHds9o+Oz9aZs6q+VSUw1mT4S65xz1rHWYCacmwr0=;
 b=gKYwqrYfdyBcq+Z7oTsiixmJLBNI5yCBG4CdDgOwi1PdULoGGs2LaI1MdbHcwr3VJNfAE9
 FxvEottmP0ev5zF2NsjWl3E7DJE+iqIig0JTV88uoDGX9Yb2hz42VJP3EKOR7uWJf7TGVj
 NT8vAFl6EkQGWnrA0FgJhvSdTtNIo4I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-OCU_Frb_PE-lCREnFzDdBQ-1; Tue,
 07 Nov 2023 04:30:40 -0500
X-MC-Unique: OCU_Frb_PE-lCREnFzDdBQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32E5A3C0278B;
 Tue,  7 Nov 2023 09:30:40 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ECA3DC1290F;
 Tue,  7 Nov 2023 09:30:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/5] Ui patches
Date: Tue,  7 Nov 2023 13:30:30 +0400
Message-ID: <20231107093035.2746581-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The following changes since commit 8aba939e77daca10eac99d9d467f65ba7df5ab3e:

  Merge tag 'pull-riscv-to-apply-20231107' of https://github.com/alistair23/qemu into staging (2023-11-07 11:08:16 +0800)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to fb93569e422d4f4b5953dd953c92ba7838309972:

  ui: Replacing pointer in function (2023-11-07 11:45:48 +0400)

----------------------------------------------------------------
UI patch queue

----------------------------------------------------------------

Antonio Caggiano (1):
  ui/gtk-egl: Check EGLSurface before doing scanout

Carwyn Ellis (1):
  ui/cocoa: add zoom-to-fit display option

Dongwon Kim (1):
  ui/gtk-egl: apply scale factor when calculating window's dimension

Marc-André Lureau (1):
  ui/gtk: force realization of drawing area

Sergey Mironov (1):
  ui: Replacing pointer in function

 qapi/ui.json |  7 ++++++-
 ui/gtk-egl.c | 31 ++++++++++++++++++++-----------
 ui/gtk.c     | 12 +++++++++++-
 ui/cocoa.m   | 32 ++++++++++++++++++--------------
 4 files changed, 55 insertions(+), 27 deletions(-)

-- 
2.41.0


