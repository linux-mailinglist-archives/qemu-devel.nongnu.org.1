Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84558712316
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 11:10:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2TRJ-0002uR-Tf; Fri, 26 May 2023 05:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2TRH-0002u4-69
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2TRF-0000gv-KZ
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685092124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qoPofzNpKeQXJb+AJxWTiwhAW0leBormu1Ve0pME3Y8=;
 b=ae4c74HYr2gZlEv6knS/CjN/mq/le6e6h4NxYQDSeJCqFLar48T3YkNs+9XWVbTOj4PqIF
 ZKczv+Xmdy05b1Lb7gQrmPEfaavZYW3GOE4Y2wTqw1uV882v1So0971T6l1n4cCpg/v1fY
 Aef++J90szz1cdTc79NHH1ljmziqhkw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-COUt4kWnMEyZU3LdZNhC_w-1; Fri, 26 May 2023 05:08:42 -0400
X-MC-Unique: COUt4kWnMEyZU3LdZNhC_w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D196801182;
 Fri, 26 May 2023 09:08:42 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D55A7C154D1;
 Fri, 26 May 2023 09:08:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/15] Improve --without-default-devices testing,
 fix CVE-2023-0330
Date: Fri, 26 May 2023 11:08:25 +0200
Message-Id: <20230526090840.2225958-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

The following changes since commit a3cb6d5004ff638aefe686ecd540718a793bd1b1:

  Merge tag 'pull-tcg-20230525' of https://gitlab.com/rth7680/qemu into staging (2023-05-25 11:11:52 -0700)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-05-26

for you to fetch changes up to b987718bbb1d0eabf95499b976212dd5f0120d75:

  hw/scsi/lsi53c895a: Fix reentrancy issues in the LSI controller (CVE-2023-0330) (2023-05-26 09:37:04 +0200)

----------------------------------------------------------------
* Use MachineClass->default_nic in more machines to allow running them
  without "--nodefaults" in builds that used "--without-default-devices"
* Improve qtests for such builds
* Add up-/downsampling qtest
* Avoid crash if default RAM backend name has been stolen
* Fix reentrant DMA problem in the lsi53c895a device (CVE-2023-0330)

----------------------------------------------------------------
Igor Mammedov (1):
      machine: do not crash if default RAM backend name has been stolen

Philippe Mathieu-Daudé (1):
      hw/mips: Use MachineClass->default_nic in the virt machine

Thomas Huth (12):
      hw/hppa: Use MachineClass->default_nic in the hppa machine
      hw/alpha: Use MachineClass->default_nic in the alpha machine
      hw/arm: Use MachineClass->default_nic in the virt machine
      hw/loongarch64: Use MachineClass->default_nic in the virt machine
      hw/xtensa: Use MachineClass->default_nic in the virt machine
      hw/arm: Use MachineClass->default_nic in the sbsa-ref machine
      tests/qtest/usb-hcd-uhci-test: Check whether "usb-storage" is available
      tests/qtest: Check for virtio-blk before using -cdrom with the arm virt machine
      tests/qtest/rtl8139-test: Check whether the rtl8139 device is available
      tests/qtest/usb-hcd-ehci-test: Check for EHCI and UHCI HCDs before using them
      lsi53c895a: disable reentrancy detection for MMIO region, too
      hw/scsi/lsi53c895a: Fix reentrancy issues in the LSI controller (CVE-2023-0330)

Volker Rümelin (1):
      tests/qtest/ac97-test: add up-/downsampling tests

 hw/alpha/dp264.c                   |  4 +++-
 hw/arm/sbsa-ref.c                  |  4 +++-
 hw/arm/virt.c                      |  4 +++-
 hw/core/machine.c                  |  8 ++++++++
 hw/hppa/machine.c                  |  4 +++-
 hw/loongarch/virt.c                |  4 +++-
 hw/mips/loongson3_virt.c           |  4 +++-
 hw/scsi/lsi53c895a.c               | 24 +++++++++++++++++------
 hw/xtensa/virt.c                   |  9 ++++++---
 tests/qtest/ac97-test.c            | 40 +++++++++++++++++++++++++++++++++++++-
 tests/qtest/bios-tables-test.c     |  2 +-
 tests/qtest/cdrom-test.c           |  6 +++++-
 tests/qtest/fuzz-lsi53c895a-test.c | 33 +++++++++++++++++++++++++++++++
 tests/qtest/rtl8139-test.c         |  4 ++++
 tests/qtest/usb-hcd-ehci-test.c    |  5 +++++
 tests/qtest/usb-hcd-uhci-test.c    |  4 +++-
 16 files changed, 140 insertions(+), 19 deletions(-)


