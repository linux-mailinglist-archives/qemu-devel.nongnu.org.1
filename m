Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBE088FCCF
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Mar 2024 11:21:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpmsm-00018i-Py; Thu, 28 Mar 2024 06:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rpmsj-000187-B3
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:21:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rpmsg-0007Z4-5r
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711621268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LvCRvdp44puTLh0kZztOo+1iwfbYNFDwxzECnXzb+Fg=;
 b=ZolkExJPkBNJyP1Js7rvj8+GI4UbV9ANlMB64A3L9q25IZdbCTK4UO5cfNWdRRX3CTmgOX
 fIBDIxf8HO7hTNivNSgtxopJtUCH5V36bYMMZbHPujOXux5LLb4a4TD2gEW37VrP0AM4Dz
 vIVztGGOu2Tfh9WOM9wqF0ESpVHFXu4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-cNUmJwQYPKKNbsGazjyJng-1; Thu, 28 Mar 2024 06:21:04 -0400
X-MC-Unique: cNUmJwQYPKKNbsGazjyJng-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0821811E81;
 Thu, 28 Mar 2024 10:21:01 +0000 (UTC)
Received: from localhost (unknown [10.39.208.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 177111C060D0;
 Thu, 28 Mar 2024 10:20:58 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 John Snow <jsnow@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Bin Meng <bin.meng@windriver.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 00/19] -Werror=maybe-uninitialized fixes
Date: Thu, 28 Mar 2024 14:20:33 +0400
Message-ID: <20240328102052.3499331-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

Depending on -Doptimization=<value>, GCC (13.2.1 here) produces different
maybe-uninitialized warnings:
- g: produces -Werror=maybe-uninitialized errors
- 0: clean build
- 1: produces -Werror=maybe-uninitialized errors
- 2: clean build
- 3: produces few -Werror=maybe-uninitialized errors
- s: produces -Werror=maybe-uninitialized errors

Most are false-positive, because prior LOCK_GUARD should guarantee an
initialization path. Few of them are a bit trickier. Finally, I found
a potential related memory leak.

thanks

Marc-André Lureau (19):
  util/coroutine: fix -Werror=maybe-uninitialized false-positive
  util/timer: with -Werror=maybe-uninitialized false-positive
  hw/qxl: fix -Werror=maybe-uninitialized false-positives
  nbd: with -Werror=maybe-uninitialized false-positive
  block/mirror: fix -Werror=maybe-uninitialized false-positive
  block/stream: fix -Werror=maybe-uninitialized false-positives
  hw/ahci: fix -Werror=maybe-uninitialized false-positive
  hw/vhost-scsi: fix -Werror=maybe-uninitialized
  hw/sdhci: fix -Werror=maybe-uninitialized false-positive
  hw/rdma: fix -Werror=maybe-uninitialized false-positive
  migration/block: fix -Werror=maybe-uninitialized false-positive
  migration: fix -Werror=maybe-uninitialized false-positives
  hw/virtio-blk: fix -Werror=maybe-uninitialized false-positive
  plugins: fix -Werror=maybe-uninitialized false-positive
  migration: fix -Werror=maybe-uninitialized false-positive
  tests: fix -Werror=maybe-uninitialized
  hw/nvme: fix -Werror=maybe-uninitialized
  hw/virtio: fix -Werror=maybe-uninitialized
  RFC: hw/virtio: a potential leak fix

 block/mirror.c                     | 2 +-
 block/stream.c                     | 6 +++---
 hw/block/virtio-blk.c              | 2 +-
 hw/display/qxl.c                   | 4 ++--
 hw/ide/ahci.c                      | 3 ++-
 hw/nvme/ctrl.c                     | 2 +-
 hw/rdma/rdma_backend.c             | 2 +-
 hw/scsi/vhost-scsi.c               | 2 +-
 hw/sd/sdhci.c                      | 2 +-
 hw/virtio/vhost-shadow-virtqueue.c | 6 ++++--
 migration/block.c                  | 2 +-
 migration/dirtyrate.c              | 4 ++--
 migration/migration.c              | 2 +-
 migration/ram.c                    | 2 +-
 nbd/client-connection.c            | 2 +-
 plugins/loader.c                   | 2 +-
 tests/unit/test-bdrv-drain.c       | 2 +-
 tests/unit/test-block-iothread.c   | 2 +-
 util/qemu-coroutine.c              | 2 +-
 util/qemu-timer.c                  | 6 +++---
 20 files changed, 30 insertions(+), 27 deletions(-)

-- 
2.44.0


