Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC2B737F61
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 12:19:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBuur-0008B3-I8; Wed, 21 Jun 2023 06:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1qBuuo-0008AG-Ip
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:18:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1qBuum-0000c3-CA
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687342694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZK8egzUyOZFCjqZkgZnPHQkoAIwE3n9lBtE/K/3xoUY=;
 b=EVnYc1KBxltrvMRLDer/E7MnQvH8yGNoId57q/swdBpPa+RJs/OoNlP5uGOti6mi1eS6WM
 MrKpXlcq7K2hB7fUkgDrUBgxurcRmhCtfhyVvomavm2LyzGojZtAMWn4/gqAkG4p146sIz
 Ud46gGX23zcSw7HMttr9Q/3tt++LslE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-uDSZrpwQPHuBrsTdOGp4XQ-1; Wed, 21 Jun 2023 06:18:13 -0400
X-MC-Unique: uDSZrpwQPHuBrsTdOGp4XQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12AE0104458C;
 Wed, 21 Jun 2023 10:18:13 +0000 (UTC)
Received: from nuthatch.redhat.com (unknown [10.45.225.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDC49492C13;
 Wed, 21 Jun 2023 10:18:11 +0000 (UTC)
From: Milan Zamazal <mzamazal@redhat.com>
To: qemu-devel@nongnu.org
Cc: Milan Zamazal <mzamazal@redhat.com>, mst@redhat.com, stefanha@redhat.com,
 alex.bennee@linaro.org, thuth@redhat.com, vincent.guittot@linaro.org
Subject: [PATCH v2 0/4] Add SCMI vhost-user VIRTIO device
Date: Wed, 21 Jun 2023 12:17:06 +0200
Message-Id: <20230621101710.297975-1-mzamazal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mzamazal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This patch series adds a vhost-user VIRTIO device for SCMI.
It's similar to other similar vhost-user VIRTIO devices.

I'm aware of the work in progress by Alex Bennée to simplify similar devices
and avoid excessive code duplication.  I think the SCMI device support
doesn't bring anything special and it can be rebased on the given work
if/once it is merged.

The device has been tested with a prototype rust-vmm based
vhost-user-scmi daemon emulating a sensor device and a Linux guest OS
(the production version of the vhost-user daemon is developed at
https://github.com/mz-pdm/vhost-device/tree/scmi).

v2:
 - A missing trailing space additionally added in the comment typo fix.
 - A note about testing added above.

Milan Zamazal (4):
  hw/virtio: Add boilerplate for vhost-user-scmi device
  hw/virtio: Add vhost-user-scmi-pci boilerplate
  tests/qtest: Fix a comment typo in vhost-user-test.c
  tests/qtest: enable tests for virtio-scmi

 MAINTAINERS                         |   7 +
 hw/virtio/Kconfig                   |   5 +
 hw/virtio/meson.build               |   2 +
 hw/virtio/vhost-user-scmi-pci.c     |  68 +++++++
 hw/virtio/vhost-user-scmi.c         | 306 ++++++++++++++++++++++++++++
 include/hw/virtio/vhost-user-scmi.h |  30 +++
 tests/qtest/libqos/meson.build      |   1 +
 tests/qtest/libqos/virtio-scmi.c    | 174 ++++++++++++++++
 tests/qtest/libqos/virtio-scmi.h    |  34 ++++
 tests/qtest/vhost-user-test.c       |  46 ++++-
 10 files changed, 672 insertions(+), 1 deletion(-)
 create mode 100644 hw/virtio/vhost-user-scmi-pci.c
 create mode 100644 hw/virtio/vhost-user-scmi.c
 create mode 100644 include/hw/virtio/vhost-user-scmi.h
 create mode 100644 tests/qtest/libqos/virtio-scmi.c
 create mode 100644 tests/qtest/libqos/virtio-scmi.h

-- 
2.40.1


