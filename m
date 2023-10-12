Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D255F7C737A
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:52:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqyuC-0004sw-4x; Thu, 12 Oct 2023 12:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqyu4-0004sQ-Jo
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqyu1-0005bE-T7
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697129472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=whD+7QYU6apdl9TyKYylDBbgFh2uL65zqYrSeULnTtA=;
 b=PK+w3QgH5O92PWk+kc9gncCHtq7w1KiSzDYig0Kqpe+VEu+15+TwxVidJLwD4gU+AxocCA
 j2U4m1hxwdXASsIspyfLAzRUhSfFFY0dT6q7nzyliDyHOP4jo2PVmqF0hg+lDa5KZF7R4e
 2lGbnxc5tul6EfwlzSsuA0Ybdf45DXc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-qiyyHlP2PJiNxollRysN4A-1; Thu, 12 Oct 2023 12:51:10 -0400
X-MC-Unique: qiyyHlP2PJiNxollRysN4A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76562801E62
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 16:51:10 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4CCF25C0;
 Thu, 12 Oct 2023 16:51:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/7] Misc patches
Date: Thu, 12 Oct 2023 18:51:01 +0200
Message-ID: <20231012165108.913443-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

The following changes since commit a51e5124a655b3dad80b36b18547cb1eca2c5eb2:

  Merge tag 'pull-omnibus-111023-1' of https://gitlab.com/stsquad/qemu into staging (2023-10-11 09:43:10 -0400)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-10-12

for you to fetch changes up to f51f90c65ed7706c3c4f7a889ce3d6b7ab75ef6a:

  gitlab-ci: Disable the riscv64-debian-cross-container by default (2023-10-12 14:18:03 +0200)

----------------------------------------------------------------
* Fix CVE-2023-1544
* Deprecate the rdma code
* Fix flaky npcm7xx_timer test
* i2c-echo license statement and Kconfig switch
* Disable the failing riscv64-debian-cross CI job by default

----------------------------------------------------------------
Chris Rauer (1):
      tests/qtest: Fix npcm7xx_timer-test.c flaky test

Klaus Jensen (2):
      hw/misc/i2c-echo: add copyright/license note
      hw/misc/Kconfig: add switch for i2c-echo

Thomas Huth (3):
      hw/rdma: Deprecate the pvrdma device and the rdma subsystem
      MAINTAINERS: Add include/sysemu/qtest.h to the qtest section
      gitlab-ci: Disable the riscv64-debian-cross-container by default

Yuval Shaia (1):
      hw/pvrdma: Protect against buggy or malicious guest driver

 MAINTAINERS                      |  3 ++-
 docs/about/deprecated.rst        |  8 ++++++++
 hw/misc/i2c-echo.c               | 10 ++++++++++
 hw/rdma/vmw/pvrdma_main.c        | 18 +++++++++++++++++-
 tests/qtest/npcm7xx_timer-test.c |  1 +
 .gitlab-ci.d/container-cross.yml |  1 +
 hw/misc/Kconfig                  |  5 +++++
 hw/misc/meson.build              |  2 +-
 8 files changed, 45 insertions(+), 3 deletions(-)


