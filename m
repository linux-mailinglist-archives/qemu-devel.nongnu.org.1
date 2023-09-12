Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3CA79D07C
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 13:58:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg1lk-0004D2-4N; Tue, 12 Sep 2023 07:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qg1lh-0004Bx-0X
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:41:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qg1le-00033S-4h
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694518875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vjT6rtwr5f6sTE0vpfahk22D82LMIa8hd6aX1wDczxM=;
 b=GEVf/RZ2giB1A/N98Mp9kBkldxccOt55jRmd9ox6L+szQKPY2oA/u+5FTGpXchl6n8fP6C
 MI/ZEBb25o3hcYyRLpgM61T0wJxCk98knCVEbrRXDXqG2TDvCdbLKhjLFrRZwQoRNjALKu
 FlW8JE7tKMpG5AV0KFzWVjMiWZgreDY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-b2eG2KViOT-DK1TXhkb1Jg-1; Tue, 12 Sep 2023 07:41:14 -0400
X-MC-Unique: b2eG2KViOT-DK1TXhkb1Jg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E16D73C025B9
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 11:41:13 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B7651054FC0;
 Tue, 12 Sep 2023 11:41:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/7] s390x (and one qtest) patches
Date: Tue, 12 Sep 2023 13:41:05 +0200
Message-ID: <20230912114112.296428-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

The following changes since commit 9ef497755afc252fb8e060c9ea6b0987abfd20b6:

  Merge tag 'pull-vfio-20230911' of https://github.com/legoater/qemu into staging (2023-09-11 09:13:08 -0400)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-09-12

for you to fetch changes up to 82fdcd3e140c8d4c63f177ece554f90f2bccdf68:

  tests/qtest/pflash: Clean up local variable shadowing (2023-09-12 12:07:31 +0200)

----------------------------------------------------------------
* Enable AP (crypto adapter) instructions for s390x PV-guests
* Allow NVME for s390x machines
* Update Linux headers to v6.6-rc1

----------------------------------------------------------------
Cédric Le Goater (1):
      kconfig: Add NVME to s390x machines

Janosch Frank (2):
      s390x/ap: fix missing subsystem reset registration
      s390x: do a subsystem reset before the unprotect on reboot

Philippe Mathieu-Daudé (1):
      tests/qtest/pflash: Clean up local variable shadowing

Steffen Eiden (2):
      target/s390x/kvm: Refactor AP functionalities
      target/s390x: AP-passthrough for PV guests

Thomas Huth (1):
      linux-headers: Update to Linux v6.6-rc1

 include/standard-headers/linux/fuse.h        |  63 ++++++++++-
 include/standard-headers/linux/vhost_types.h |   4 +
 include/standard-headers/linux/virtio_net.h  |  14 +++
 linux-headers/asm-arm64/bitsperlong.h        |  23 ++++
 linux-headers/asm-generic/unistd.h           |   5 +-
 linux-headers/asm-mips/unistd_n32.h          |   1 +
 linux-headers/asm-mips/unistd_n64.h          |   1 +
 linux-headers/asm-mips/unistd_o32.h          |   1 +
 linux-headers/asm-powerpc/unistd_32.h        |   1 +
 linux-headers/asm-powerpc/unistd_64.h        |   1 +
 linux-headers/asm-riscv/bitsperlong.h        |  13 +++
 linux-headers/asm-riscv/kvm.h                |  16 +++
 linux-headers/asm-s390/kvm.h                 |  16 +++
 linux-headers/asm-s390/unistd_32.h           |   1 +
 linux-headers/asm-s390/unistd_64.h           |   1 +
 linux-headers/asm-x86/mman.h                 |  10 +-
 linux-headers/asm-x86/unistd_32.h            |   1 +
 linux-headers/asm-x86/unistd_64.h            |   2 +
 linux-headers/asm-x86/unistd_x32.h           |   1 +
 linux-headers/linux/kvm.h                    |  13 ++-
 linux-headers/linux/stddef.h                 |   4 +
 linux-headers/linux/userfaultfd.h            |  25 ++++-
 linux-headers/linux/vfio.h                   | 150 ++++++++++++++++++++++++++-
 target/s390x/cpu_features.h                  |   1 +
 target/s390x/cpu_features_def.h.inc          |   4 +
 hw/s390x/s390-virtio-ccw.c                   |  11 ++
 target/s390x/cpu_models.c                    |   2 +
 target/s390x/gen-features.c                  |   2 +
 target/s390x/kvm/kvm.c                       |  94 +++++++++++++++--
 tests/qtest/pflash-cfi02-test.c              |   2 +-
 hw/nvme/Kconfig                              |   2 +-
 31 files changed, 460 insertions(+), 25 deletions(-)


