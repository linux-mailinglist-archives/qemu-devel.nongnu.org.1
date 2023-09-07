Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C45797B73
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 20:18:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeJYV-0002de-Ne; Thu, 07 Sep 2023 14:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeJYT-0002cu-9M
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 14:16:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeJYQ-0005qX-Kb
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 14:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694110594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=y6AhMw55A4hjnIWsMIxVXjb1W5GQMByQ+HrImFJguc0=;
 b=iEjZ9Jtga6D/DCgKXRwXjdwrBM2s0XiaqRiEnEFbLjMkgqErgxZtD1XAtkJuUIfCsLex/F
 l3QDmzCQHIXPhcFnOQoy5V1q/E1E3bpw1YsKz95oM9GTm0FeJZzt2KoMMVCnItfndFNPQm
 y9Nzx1h5lru1IX1WQ/K+KEpLqLLzO/o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-v85R3ITfPk-oFAu5fg9k2w-1; Thu, 07 Sep 2023 14:16:30 -0400
X-MC-Unique: v85R3ITfPk-oFAu5fg9k2w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4624180268A;
 Thu,  7 Sep 2023 18:16:30 +0000 (UTC)
Received: from localhost (unknown [10.39.193.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7355E403171;
 Thu,  7 Sep 2023 18:16:29 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/5] Block patches
Date: Thu,  7 Sep 2023 14:16:23 -0400
Message-ID: <20230907181628.1594401-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit 03a3a62fbd0aa5227e978eef3c67d3978aec9e5f:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-09-07 10:29:06 -0400)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 631c872614aca91eaf947c1748f0f27f99635d92:

  tests/qtest: Introduce tests for UFS (2023-09-07 14:01:29 -0400)

----------------------------------------------------------------
Pull request

- Jeuk Kim's emulated UFS device
- Fabiano Rosas' IOThread GSource "name" debugging aid

----------------------------------------------------------------

Fabiano Rosas (1):
  iothread: Set the GSource "name" field

Jeuk Kim (4):
  hw/ufs: Initial commit for emulated Universal-Flash-Storage
  hw/ufs: Support for Query Transfer Requests
  hw/ufs: Support for UFS logical unit
  tests/qtest: Introduce tests for UFS

 MAINTAINERS              |    7 +
 docs/specs/pci-ids.rst   |    2 +
 meson.build              |    1 +
 hw/ufs/trace.h           |    1 +
 hw/ufs/ufs.h             |  131 ++++
 include/block/ufs.h      | 1090 +++++++++++++++++++++++++++
 include/hw/pci/pci.h     |    1 +
 include/hw/pci/pci_ids.h |    1 +
 include/scsi/constants.h |    1 +
 hw/ufs/lu.c              | 1445 ++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs.c             | 1502 ++++++++++++++++++++++++++++++++++++++
 iothread.c               |   14 +-
 tests/qtest/ufs-test.c   |  587 +++++++++++++++
 hw/Kconfig               |    1 +
 hw/meson.build           |    1 +
 hw/ufs/Kconfig           |    4 +
 hw/ufs/meson.build       |    1 +
 hw/ufs/trace-events      |   58 ++
 tests/qtest/meson.build  |    1 +
 19 files changed, 4843 insertions(+), 6 deletions(-)
 create mode 100644 hw/ufs/trace.h
 create mode 100644 hw/ufs/ufs.h
 create mode 100644 include/block/ufs.h
 create mode 100644 hw/ufs/lu.c
 create mode 100644 hw/ufs/ufs.c
 create mode 100644 tests/qtest/ufs-test.c
 create mode 100644 hw/ufs/Kconfig
 create mode 100644 hw/ufs/meson.build
 create mode 100644 hw/ufs/trace-events

-- 
2.41.0


