Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9A67CAA0B
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 15:43:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsNs2-0001H5-G9; Mon, 16 Oct 2023 09:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qsNrw-0001Ex-45
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:42:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qsNru-0003I8-4P
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697463768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=L6e5W231Q7udcMOb3rPRpfUo/44l0/jlgYuAizCQPfw=;
 b=dA/nUlAGXikLIuIjFCXCB3Z+cl0337UrZ9uOG/zWFR5EijxxEQQtztxFbqqlPUKlbaCPvQ
 6AMfSGLtMCB6N9lxAfvhAfoGukk51UvmO4yLq3bPxe39Hr4hWTOVrJrzGN7u1fn+PDKGOr
 9qUmyyTFvpkhh9+hWmzxZsw1M7PRCM8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-QpzYOxdFO-ycZCxAbIQWDw-1; Mon, 16 Oct 2023 09:42:46 -0400
X-MC-Unique: QpzYOxdFO-ycZCxAbIQWDw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B16A862F1E;
 Mon, 16 Oct 2023 13:42:46 +0000 (UTC)
Received: from localhost (unknown [10.39.192.211])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 608B4492BEE;
 Mon, 16 Oct 2023 13:42:45 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org,
	virtio-fs@redhat.com
Cc: Hanna Czenczek <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>
Subject: [PATCH v5 0/7] vhost-user: Back-end state migration
Date: Mon, 16 Oct 2023 15:42:36 +0200
Message-ID: <20231016134243.68248-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
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

v2:
https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg02604.html

v3:
https://lists.nongnu.org/archive/html/qemu-devel/2023-09/msg03750.html

v4:
https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg01046.html


Based-on: <20231004014532.1228637-1-stefanha@redhat.com>
          ([PATCH v2 0/3] vhost: clean up device reset)

Based-on: <20231016083201.23736-1-hreitz@redhat.com>
          ([PATCH] vhost-user: Fix protocol feature bit conflict)


Hi,

v5 is basically the same as v4, only that I’ve dropped the patch
deprecating F_STATUS (which doesn’t affect the rest of the series), that
I’ve amended the documentation in patch 1 as suggested by Stefan and
with help from Michael, and that I’ve rebased everything on top of the
F_SHARED_OBJECT changes that have been merged upstream.


git-backport-diff against v4:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/7:[0029] [FC] 'vhost-user.rst: Improve [GS]ET_VRING_BASE doc'
002/7:[----] [--] 'vhost-user.rst: Clarify enabling/disabling vrings'
003/7:[----] [--] 'vhost-user.rst: Introduce suspended state'
004/7:[0006] [FC] 'vhost-user.rst: Migrating back-end-internal state'
005/7:[0007] [FC] 'vhost-user: Interface for migration state transfer'
006/7:[----] [--] 'vhost: Add high-level state save/load functions'
007/7:[----] [--] 'vhost-user-fs: Implement internal migration'


Changes patch by patch:
- Patch 1: Amended documentation
- Patches 4 and 5: Bumped feature bit and command values as necessary so
  as not to conflict with F_SHARED_OBJECT


Hanna Czenczek (7):
  vhost-user.rst: Improve [GS]ET_VRING_BASE doc
  vhost-user.rst: Clarify enabling/disabling vrings
  vhost-user.rst: Introduce suspended state
  vhost-user.rst: Migrating back-end-internal state
  vhost-user: Interface for migration state transfer
  vhost: Add high-level state save/load functions
  vhost-user-fs: Implement internal migration

 docs/interop/vhost-user.rst       | 301 ++++++++++++++++++++++++++++--
 include/hw/virtio/vhost-backend.h |  24 +++
 include/hw/virtio/vhost-user.h    |   1 +
 include/hw/virtio/vhost.h         | 113 +++++++++++
 hw/virtio/vhost-user-fs.c         | 101 +++++++++-
 hw/virtio/vhost-user.c            | 146 +++++++++++++++
 hw/virtio/vhost.c                 | 241 ++++++++++++++++++++++++
 7 files changed, 906 insertions(+), 21 deletions(-)

-- 
2.41.0


