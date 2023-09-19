Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4B77A5F93
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:31:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiY0n-00037D-9r; Tue, 19 Sep 2023 06:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiY08-00033K-5R
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiY02-0001sX-Uc
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695119432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LkD1dYJ/PyP9DSreCB9KlI7nBwH2gGji+nMN20Ldv4c=;
 b=LAYzWnF/KlKfcYt8Wv7sQqyWe8f8/t3fr7QvG0sheRMwqTB0binAt46/tEvRUPisC9u8AK
 iOm7CjDkWs1dJTtx98N49C35bsqP3glyELIJqNaj5WhYN1cmif/wh/9a/4QQIO4Kdy0yjw
 jEeiqqyDbHtlY0M2x1afQxPd7fz6fIQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-51nJD3DrP-61MVA2ehhHIQ-1; Tue, 19 Sep 2023 06:30:31 -0400
X-MC-Unique: 51nJD3DrP-61MVA2ehhHIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE72C101A529
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 10:30:30 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CD0B40C6EBF;
 Tue, 19 Sep 2023 10:30:30 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>
Subject: [GIT PULL 00/12] Host Memory Backends and Memory devices queue
 2023-09-19
Date: Tue, 19 Sep 2023 12:30:17 +0200
Message-ID: <20230919103029.235736-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
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

The following changes since commit 13d6b1608160de40ec65ae4c32419e56714bbadf:

  Merge tag 'pull-crypto-20230915' of https://gitlab.com/rth7680/qemu into staging (2023-09-18 11:04:21 -0400)

are available in the Git repository at:

  https://github.com/davidhildenbrand/qemu.git tags/mem-2023-09-19

for you to fetch changes up to 544cff46c018036cd66e98ffb224dd9f098065c8:

  memory: avoid updating ioeventfds for some address_space (2023-09-19 10:44:44 +0200)

----------------------------------------------------------------
Hi,

"Host Memory Backends" and "Memory devices" queue ("mem"):
- Support and document VM templating with R/O files using a new "rom"
  parameter for memory-backend-file
- Some cleanups and fixes around NVDIMMs and R/O file handling for guest
  RAM
- Optimize ioeventfd updates by skipping address spaces that are not
  applicable

----------------------------------------------------------------
David Hildenbrand (11):
  nvdimm: Reject writing label data to ROM instead of crashing QEMU
  softmmu/physmem: Distinguish between file access mode and mmap
    protection
  backends/hostmem-file: Add "rom" property to support VM templating
    with R/O files
  softmmu/physmem: Remap with proper protection in qemu_ram_remap()
  softmmu/physmem: Bail out early in ram_block_discard_range() with
    readonly files
  softmmu/physmem: Fail creation of new files in file_ram_open() with
    readonly=true
  softmmu/physmem: Never return directories from file_ram_open()
  docs: Don't mention "-mem-path" in multi-process.rst
  docs: Start documenting VM templating
  softmmu/physmem: Hint that "readonly=on,rom=off" exists when opening
    file R/W for private mapping fails
  machine: Improve error message when using default RAM backend id

hongmianquan (1):
  memory: avoid updating ioeventfds for some address_space

 MAINTAINERS                   |   1 +
 backends/hostmem-file.c       |  61 ++++++++++++++++-
 docs/devel/multi-process.rst  |   5 +-
 docs/system/index.rst         |   1 +
 docs/system/vm-templating.rst | 125 ++++++++++++++++++++++++++++++++++
 hw/acpi/nvdimm.c              |  11 ++-
 hw/core/machine.c             |  11 ++-
 hw/mem/nvdimm.c               |  10 ++-
 hw/ppc/spapr_nvdimm.c         |   3 +-
 include/exec/memory.h         |  15 ++--
 include/exec/ram_addr.h       |   8 +--
 include/hw/mem/nvdimm.h       |   6 ++
 qapi/qom.json                 |  17 ++++-
 qemu-options.hx               |  16 ++++-
 softmmu/memory.c              |  20 ++++--
 softmmu/physmem.c             |  93 +++++++++++++++++++------
 16 files changed, 354 insertions(+), 49 deletions(-)
 create mode 100644 docs/system/vm-templating.rst

-- 
2.41.0


