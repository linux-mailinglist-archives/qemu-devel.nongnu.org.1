Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF4E70DFDB
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:04:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1TXM-0006LA-O7; Tue, 23 May 2023 11:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q1TXH-0006Ku-21
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:02:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q1TXD-0003sm-Pa
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684854166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UYY7UQ8uSRSEfHOcAqQQVdmt4dz8BXPewHtkapVEY6I=;
 b=eISqZ5qU7HlFqDhiCh6vXIXb/ibcp/p0tmdU3PbPOzCPMQyIHuMFa17R684dp9xt0u5ub9
 eIiPM668zNafFzpNyS2rIKqdWHRwQPgwfUH6YuiUnTyJnGhBGHgwJjt1dElx8uvifhrxsP
 b9l6Mldnz/HgDhK7x0QiLr8Z0cORtjA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-LPPkGJHwMHyyno9S0c7gUg-1; Tue, 23 May 2023 11:02:44 -0400
X-MC-Unique: LPPkGJHwMHyyno9S0c7gUg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A8531C189B8;
 Tue, 23 May 2023 15:02:42 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.194.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5989492B0A;
 Tue, 23 May 2023 15:02:40 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <graf@amazon.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [GIT PULL 0/1] Host Memory Backends and Memory devices queue
 2023-05-23
Date: Tue, 23 May 2023 17:02:39 +0200
Message-Id: <20230523150240.365055-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 886c0453cbf10eebd42a9ccf89c3e46eb389c357:

  Merge tag 'pull-qapi-2023-05-17-v2' of https://repo.or.cz/qemu/armbru into staging (2023-05-22 15:54:21 -0700)

are available in the Git repository at:

  https://github.com/davidhildenbrand/qemu.git tags/mem-2023-05-23

for you to fetch changes up to 4b870dc4d0c0895859d34d14ce0272a4bcbccf78:

  hostmem-file: add offset option (2023-05-23 16:47:03 +0200)

----------------------------------------------------------------
Hi,

"Host Memory Backends" and "Memory devices" queue ("mem"):
- New "offset" option for memory-backend-file

----------------------------------------------------------------
Alexander Graf (1):
      hostmem-file: add offset option

 backends/hostmem-file.c | 40 +++++++++++++++++++++++++++++++++++++++-
 hw/virtio/vhost-user.c  |  1 +
 include/exec/memory.h   |  2 ++
 include/exec/ram_addr.h |  3 ++-
 include/exec/ramblock.h |  1 +
 qapi/qom.json           |  5 +++++
 qemu-options.hx         |  6 +++++-
 softmmu/memory.c        |  3 ++-
 softmmu/physmem.c       | 17 ++++++++++++-----
 9 files changed, 69 insertions(+), 9 deletions(-)

-- 
2.40.1


