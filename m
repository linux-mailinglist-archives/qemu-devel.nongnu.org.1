Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC6D78571B
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 13:50:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYmJi-0001Yv-Lw; Wed, 23 Aug 2023 07:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYmJF-0001Te-QB
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:46:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYmJ7-0001O8-Lc
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692791151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WjfGaZBzXwt5OER1P+fKZV33NKHb/M25ETmOK0Nw+mY=;
 b=RivHtJe8qmsRjZYcxP12UjPH/zMbyUZs52GhztRtzqPDbNxB/MGimq1OG0urfcIPuH67Yu
 zeQc6pen/vVU1Dr9E7+eg3Gu1IpEPsFn71bFyqDX1xN6orizuGKXlKRPZoMMmKluGL6M1H
 4/O3u8Ttp68nqvUIWwroUahdwEoRoQU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-fWRPwQllNLemVQIrJ2CVrw-1; Wed, 23 Aug 2023 07:45:48 -0400
X-MC-Unique: fWRPwQllNLemVQIrJ2CVrw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72E22800B35
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 11:45:47 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A1B31C15BAE;
 Wed, 23 Aug 2023 11:45:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 00/12] First batch of s390x patches for QEMU 8.2
Date: Wed, 23 Aug 2023 13:45:32 +0200
Message-Id: <20230823114544.216520-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

The following changes since commit b0dd9a7d6dd15a6898e9c585b521e6bec79b25aa:

  Open 8.2 development tree (2023-08-22 07:14:07 -0700)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-08-23

for you to fetch changes up to 6c49f685d30ffe81cfa47da2c258904ad28ac368:

  tests/tcg/s390x: Test VSTRS (2023-08-23 12:07:30 +0200)

----------------------------------------------------------------
* Add compat machines for QEMU 8.2
* Convert some DPRINTFs in s390x code into trace events
* Fix VFMIN/VFMAX, VSTL, VREP and VSTRS s390x instructions
* Fix virtio-gpu on big endian (i.e. s390x) hosts

----------------------------------------------------------------
Cornelia Huck (1):
      hw: Add compat machines for 8.2

Cédric Le Goater (1):
      s390x: Convert DPRINTF to trace events

Ilya Leoshkevich (8):
      target/s390x: Check reserved bits of VFMIN/VFMAX's M5
      target/s390x: Fix VSTL with a large length
      tests/tcg/s390x: Test VSTL
      target/s390x: Use a 16-bit immediate in VREP
      tests/tcg/s390x: Test VREP
      linux-user/elfload: Enable vxe2 on s390x
      target/s390x: Fix the "ignored match" case in VSTRS
      tests/tcg/s390x: Test VSTRS

Thomas Huth (2):
      hw/s390x/s390-virtio-ccw: Remove superfluous code to set the NIC model
      include/hw/virtio/virtio-gpu: Fix virtio-gpu with blob on big endian hosts

 include/hw/boards.h                  |  3 ++
 include/hw/i386/pc.h                 |  3 ++
 include/hw/virtio/virtio-gpu-bswap.h |  3 ++
 hw/arm/virt.c                        |  9 +++-
 hw/core/machine.c                    |  3 ++
 hw/i386/pc.c                         |  3 ++
 hw/i386/pc_piix.c                    | 16 +++++--
 hw/i386/pc_q35.c                     | 14 +++++-
 hw/m68k/virt.c                       |  9 +++-
 hw/ppc/spapr.c                       | 15 +++++-
 hw/s390x/s390-pci-bus.c              | 25 ++++------
 hw/s390x/s390-pci-inst.c             | 48 ++++++++------------
 hw/s390x/s390-virtio-ccw.c           | 18 ++++++--
 linux-user/elfload.c                 |  1 +
 target/s390x/kvm/kvm.c               | 33 +++++---------
 target/s390x/tcg/vec_helper.c        |  2 +-
 target/s390x/tcg/vec_string_helper.c | 54 +++++++---------------
 tests/tcg/s390x/vrep.c               | 81 +++++++++++++++++++++++++++++++++
 tests/tcg/s390x/vstl.c               | 37 +++++++++++++++
 tests/tcg/s390x/vxeh2_vstrs.c        | 88 ++++++++++++++++++++++++++++++++++++
 target/s390x/tcg/translate_vx.c.inc  |  6 +--
 hw/s390x/trace-events                | 17 +++++++
 target/s390x/kvm/trace-events        |  7 +++
 tests/tcg/s390x/Makefile.target      |  3 ++
 24 files changed, 375 insertions(+), 123 deletions(-)
 create mode 100644 tests/tcg/s390x/vrep.c
 create mode 100644 tests/tcg/s390x/vstl.c
 create mode 100644 tests/tcg/s390x/vxeh2_vstrs.c


