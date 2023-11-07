Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A33877E484D
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:33:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QsN-0002jP-SB; Tue, 07 Nov 2023 13:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0QsM-0002iz-Cn
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:32:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0QsK-0007Mb-OH
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:32:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699381952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jlg4CfxpGqoiQPNVOrIyhAXBl+U7FoCqTHszcFYgoAo=;
 b=bw+ECgvdvkwO7aao3idEvKRk+xJRhjfEyXBr2zMmx8fKUrUqmRc6OsLdZh9nrVYvOzrrZP
 JREcuIfkfOlOUpLixL4X07VEHeLYUO+i0zYEpdWPtoWz3br07FWNBuAkKUyd+k2fGpcHTU
 yRxbFrBWqBtdDr138k3enr0tOpubbxE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-nG4KZmV4P9qlwLhZWZLXxA-1; Tue,
 07 Nov 2023 13:32:30 -0500
X-MC-Unique: nG4KZmV4P9qlwLhZWZLXxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8292D3C108D7
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 18:32:30 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C3982166B26;
 Tue,  7 Nov 2023 18:32:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 00/11] s390x and MAINTAINERS updates
Date: Tue,  7 Nov 2023 19:32:17 +0100
Message-ID: <20231107183228.276424-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

 Hi Stefan!

The following changes since commit 8aba939e77daca10eac99d9d467f65ba7df5ab3e:

  Merge tag 'pull-riscv-to-apply-20231107' of https://github.com/alistair23/qemu into staging (2023-11-07 11:08:16 +0800)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-11-07

for you to fetch changes up to 3e19fbc0c51a62d0c021e1ae768da0df64855927:

  target/s390x/cpu topology: Fix ordering and creation of TLEs (2023-11-07 19:27:08 +0100)

----------------------------------------------------------------
* Fix s390x CPU reconfiguration information in the SCLP facility map
* Fix condition code problem in the CLC and LAALG instruction
* Fix ordering of the new s390x topology list entries
* Add some more files to the MAINTAINERS file
* Allow newer versions of Tesseract in the m68k nextcube test

----------------------------------------------------------------
Heiko Carstens (1):
      s390/sclp: fix SCLP facility map

Ilya Leoshkevich (5):
      target/s390x: Fix CLC corrupting cc_src
      tests/tcg/s390x: Test CLC with inaccessible second operand
      target/s390x: Fix LAALG not updating cc_src
      tests/tcg/s390x: Test LAALG with negative cc_src
      tests/tcg/s390x: Test ADD LOGICAL WITH CARRY

Nina Schoetterl-Glausch (1):
      target/s390x/cpu topology: Fix ordering and creation of TLEs

Philippe Mathieu-Daudé (1):
      target/s390x/cpu_models: Use 'first_cpu' in s390_get_feat_block()

Thomas Huth (3):
      MAINTAINERS: Add the virtio-gpu documentation to the corresponding section
      MAINTAINERS: Add artist.c to the hppa machine section
      tests/avocado: Allow newer versions of tesseract in the nextcube test

 MAINTAINERS                              |   2 +
 include/hw/s390x/sclp.h                  |   4 +-
 target/s390x/tcg/insn-data.h.inc         |   2 +-
 target/s390x/cpu_models.c                |   6 +-
 target/s390x/kvm/stsi-topology.c         |   8 +-
 target/s390x/tcg/translate.c             |  26 +++++-
 tests/tcg/s390x/add-logical-with-carry.c | 156 +++++++++++++++++++++++++++++++
 tests/tcg/s390x/clc.c                    |  48 ++++++++++
 tests/tcg/s390x/laalg.c                  |  27 ++++++
 tests/avocado/machine_m68k_nextcube.py   |  15 +--
 tests/avocado/tesseract_utils.py         |   4 +-
 tests/tcg/s390x/Makefile.target          |   3 +
 12 files changed, 271 insertions(+), 30 deletions(-)
 create mode 100644 tests/tcg/s390x/add-logical-with-carry.c
 create mode 100644 tests/tcg/s390x/clc.c
 create mode 100644 tests/tcg/s390x/laalg.c


