Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 666DC802CBD
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 09:09:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA40m-0000r2-M0; Mon, 04 Dec 2023 03:09:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rA40j-0000qj-MD
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 03:09:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rA40h-0005oQ-5v
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 03:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701677337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yN2YZFyYnx+iXfZrX6GMn1697Dh4jGScH19SbQbiws0=;
 b=cNMsDhoNfeunzJh0xNFiPLWG77djsrpFSqp3rBWhnSbRB3hBaoL8wqh7dTKYMn8AXMiDWN
 I+OWBdT3xpqA6zpg8eZZKK3VSW2kPczX/HvX8PFFZgsOb1eFlWHO1xTbltrrfXIQ2IWUK5
 d+k4Wzu05p5jI4xezUB/I9SKc+CflrM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-VZNGFqYjNJmiC5--xxLhow-1; Mon,
 04 Dec 2023 03:08:54 -0500
X-MC-Unique: VZNGFqYjNJmiC5--xxLhow-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5A321C0635D;
 Mon,  4 Dec 2023 08:08:53 +0000 (UTC)
Received: from localhost (unknown [10.39.208.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8871C1596F;
 Mon,  4 Dec 2023 08:08:52 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 0/3] UI patches
Date: Mon,  4 Dec 2023 12:08:47 +0400
Message-ID: <20231204080850.4068242-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The following changes since commit 29b5d70cb70574b499517ec9e9f80dea496a3cc0:

  Merge tag 'pull-ppc-for-8.2-20231130' of https://gitlab.com/npiggin/qemu into staging (2023-12-01 07:29:52 -0500)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to 551ef0fa05c11abd62f4607ee3cddbcb7dea6b66:

  hw/audio/virtio-sound: mark the device as unmigratable (2023-12-04 12:04:36 +0400)

----------------------------------------------------------------
ui/audio fixes for 8.2

----------------------------------------------------------------

Fiona Ebner (1):
  ui/vnc-clipboard: fix inflate_buffer

Volker Rümelin (2):
  ui/gtk-egl: move function calls back to regular code path
  hw/audio/virtio-sound: mark the device as unmigratable

 hw/audio/virtio-snd.c |  1 +
 ui/gtk-egl.c          | 12 ++++++------
 ui/vnc-clipboard.c    |  5 +++++
 3 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.43.0


