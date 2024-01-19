Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40772832C4F
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 16:26:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQqkA-0002Gu-8C; Fri, 19 Jan 2024 10:25:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQqk7-0002GY-PW
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:25:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQqk6-000189-5c
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705677912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eQHKLjnVlLEnlcruFPdaQRx7JmpacccafU7KQG4HgsE=;
 b=L8IS49Rp2zId1AXJ4+yglQ1loQ5vRVMWPqyidkR3q5LKvmbL1uvSEluQp/rPCPj8Kw4iLu
 QyTZr2ijbAhNwoFtJ+gWYZNBKvDssRYoy60+2RfU8HS6ZPpK+zW/tIED1ez3I5O8lx7C4L
 QrlfLXstWjaLd+INbRD+/j1VPpLHWfw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-Cj2O_9FaOHuCpV5w2lU4Fg-1; Fri,
 19 Jan 2024 10:25:09 -0500
X-MC-Unique: Cj2O_9FaOHuCpV5w2lU4Fg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BA7A285F9B6;
 Fri, 19 Jan 2024 15:25:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6377440C95AD;
 Fri, 19 Jan 2024 15:25:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/11] s390x fixes, removal of deprecated options, netbsd VM fix
Date: Fri, 19 Jan 2024 16:24:56 +0100
Message-ID: <20240119152507.55182-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
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

The following changes since commit 88cf5fec91e50cd34bc002b633b4116228db0bc8:

  Merge tag 'pull-target-arm-20240118' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-01-18 12:48:17 +0000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-01-19

for you to fetch changes up to 4a27d97c80b90215b33a092a1c3a5efcc987b582:

  tests/vm/netbsd: Remove missing py311-expat package (2024-01-19 11:38:32 +0100)

----------------------------------------------------------------
- Fix s390x ISM reset
- Remove deprecated CLI options -no-hpet, -no-acpi, -async-teardown,
  -chroot and -singlestep
- Fix installation of the netbsd VM

----------------------------------------------------------------
Matthew Rosato (3):
      s390x/pci: avoid double enable/disable of aif
      s390x/pci: refresh fh before disabling aif
      s390x/pci: drive ISM reset from subsystem reset

Philippe Mathieu-Daudé (4):
      qapi: Remove deprecated 'singlestep' member of StatusInfo
      hmp: Remove deprecated 'singlestep' command
      cli: Remove deprecated '-singlestep' command line option
      tests/vm/netbsd: Remove missing py311-expat package

Thomas Huth (4):
      qemu-options: Remove the deprecated -no-hpet option
      qemu-options: Remove the deprecated -no-acpi option
      qemu-options: Remove the deprecated -async-teardown option
      qemu-options: Remove the deprecated -chroot option

 docs/about/deprecated.rst       | 62 -----------------------------------------
 docs/about/removed-features.rst | 47 +++++++++++++++++++++++++++++++
 docs/specs/tpm.rst              |  4 +--
 docs/user/main.rst              |  6 ----
 qapi/run-state.json             | 11 --------
 include/hw/s390x/s390-pci-bus.h |  2 ++
 bsd-user/main.c                 |  3 +-
 hw/i386/pc.c                    |  4 +--
 hw/s390x/s390-pci-bus.c         | 26 +++++++++++------
 hw/s390x/s390-pci-kvm.c         | 34 ++++++++++++++++++++--
 hw/s390x/s390-virtio-ccw.c      |  8 ++++++
 linux-user/main.c               |  2 --
 system/runstate.c               |  8 ------
 system/vl.c                     | 37 +-----------------------
 tests/qtest/test-hmp.c          |  1 -
 hmp-commands.hx                 | 13 ---------
 qemu-options.hx                 | 46 ------------------------------
 tests/qemu-iotests/183.out      |  4 +--
 tests/qemu-iotests/234.out      |  8 +++---
 tests/qemu-iotests/262.out      |  4 +--
 tests/qemu-iotests/280.out      |  2 +-
 tests/vm/netbsd                 |  1 -
 22 files changed, 121 insertions(+), 212 deletions(-)


