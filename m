Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AA875781F
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 11:33:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLh2l-00040O-2p; Tue, 18 Jul 2023 05:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLh2h-0003ze-EX
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:30:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLh2e-0004CA-1d
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689672646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZSRqIOD0azcoMyZMJRZo1U9jaKidHy3IoStzmFZKzxY=;
 b=f6qZKFwxqEFYmpwCjLdYgc2pgKTR+wrKjcf47T6vt0D+F0EbOTHLhdtWcCv8lEieIdHEap
 M/+K7XnP6uDhrjUc5/IVIW1L2YvU733oc46m0L2HQSKEQXDvDrUTaP6IEcOiynFKCdaecr
 5tKlFRYQnN8ngbhnEn34ouU40fN+Sfs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-VINoFLBEOZydnrSataNDYg-1; Tue, 18 Jul 2023 05:30:43 -0400
X-MC-Unique: VINoFLBEOZydnrSataNDYg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE9E689F701;
 Tue, 18 Jul 2023 09:30:42 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4DE402166B26;
 Tue, 18 Jul 2023 09:30:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/8] s390x, qtest and misc patches for QEMU 8.1 rc1
Date: Tue, 18 Jul 2023 11:30:32 +0200
Message-Id: <20230718093040.172145-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

The following changes since commit 361d5397355276e3007825cc17217c1e4d4320f7:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-07-17 15:49:27 +0100)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-07-18

for you to fetch changes up to a5754847e0fc2bc08a414dd381803009e8bca390:

  tests/avocado: Disable the test_sbsaref_edk2_firmware by default (2023-07-18 11:22:51 +0200)

----------------------------------------------------------------
* Fix s390x KVM guests when compiling with --without-default-devices
* Fix /proc/cpuinfo features list in s390x linux-user emulation
* Generate FreeBSD VM package list via lcitool
* Disable the flaky test_sbsaref_edk2_firmware avocado test by default

----------------------------------------------------------------
Cédric Le Goater (1):
      s390x: Fix QEMU abort by selecting S390_FLIC_KVM

Fabiano Rosas (1):
      tests/qtest: Fix typo in multifd cancel test

Ilya Leoshkevich (1):
      linux-user/elfload: Fix /proc/cpuinfo features: on s390x

Philippe Mathieu-Daudé (4):
      tests/lcitool: Generate distribution packages list in JSON format
      tests/lcitool: Refresh generated files
      tests/vm: Introduce get_qemu_packages_from_lcitool_json() helper
      tests/vm/freebsd: Get up-to-date package list from lcitool vars file

Thomas Huth (1):
      tests/avocado: Disable the test_sbsaref_edk2_firmware by default

 docs/devel/testing.rst                   |  5 +++
 include/elf.h                            | 66 +++++++++++++++++++--------
 linux-user/elfload.c                     | 41 +++++++++--------
 tests/qtest/migration-test.c             |  2 +-
 hw/intc/Kconfig                          |  1 -
 hw/s390x/Kconfig                         |  1 +
 tests/avocado/machine_aarch64_sbsaref.py |  2 +-
 tests/lcitool/refresh                    | 11 +++++
 tests/vm/basevm.py                       | 11 +++++
 tests/vm/freebsd                         | 42 +----------------
 tests/vm/generated/README                |  5 +++
 tests/vm/generated/freebsd.json          | 77 ++++++++++++++++++++++++++++++++
 12 files changed, 183 insertions(+), 81 deletions(-)
 create mode 100644 tests/vm/generated/README
 create mode 100644 tests/vm/generated/freebsd.json


