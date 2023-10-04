Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB037B8012
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:00:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1TF-0002K4-28; Wed, 04 Oct 2023 08:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qo1TD-0002Jv-3B
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:59:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qo1T5-0003lM-1R
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696424349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=02K7C7ySV7tmphruSMfzIHryRmjm/ijK+vDPUSSWc8M=;
 b=Pxj9T1l8UQsB0PflP83accXf7gib2e2Rn5c8d7bl6SgXesMzFe1VCRaGR+6DvVnGT3UmdW
 T4u9Jey50eQq9TSFNYhTX0kqtLbboH/p0VAdBWBiHLKd31sOo9VyHm6Pb3PeS2cD/QZDGf
 8bGe1CMTpGgJmzShZDP4aCzk3RImUfs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-OXK8zVU2NYi2TgPvzFFLHQ-1; Wed, 04 Oct 2023 08:59:07 -0400
X-MC-Unique: OXK8zVU2NYi2TgPvzFFLHQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40DB13C0FC80;
 Wed,  4 Oct 2023 12:59:07 +0000 (UTC)
Received: from localhost (unknown [10.39.194.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D2A240C2017;
 Wed,  4 Oct 2023 12:59:06 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org,
	virtio-fs@redhat.com
Cc: Hanna Czenczek <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>
Subject: [PATCH v4 0/8] vhost-user: Back-end state migration
Date: Wed,  4 Oct 2023 14:58:56 +0200
Message-ID: <20231004125904.110781-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

RFC:
https://lists.nongnu.org/archive/html/qemu-devel/2023-03/msg04263.html

v1:
https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg01575.html

v2:
https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg02604.html

v3:
https://lists.nongnu.org/archive/html/qemu-devel/2023-09/msg03750.html


Based-on: <20231004014532.1228637-1-stefanha@redhat.com>
          ([PATCH v2 0/3] vhost: clean up device reset)


Hi,

This v4 includes largely unchanged patches from v3.  The main
addition/change is what came out of the discussion between Stefan and me
around how to proceed without SUSPEND/RESUME, which is that this series
is now based on his reset fix, and it includes more documentation
changes.

Changes in detail:

- Patch 1: Fall-out from the reset fix: Currently, the status byte is
  effectively unused (qemu only uses it for resetting, which all
  back-ends ignore; DPDK uses it to announce potential feature
  negotiation failure, which qemu ignores).  It is also not defined what
  exactly front-end or back-end should do with this byte, except
  pointing at the virtio spec, which however naturally does not say how
  this integrates with vhost-user’s RESET_DEVICE or [GS]ET_FEATURES.
  Furthermore, there does not seem to be a use for this; we have
  RESET_DEVICE for resetting, and we have [GS]ET_FEATURES (and
  REPLY_ACK, which can be used on SET_FEATURES) for feature
  negotation.
  Therefore, deprecate the status byte, pointing to those other commands
  instead.

- Patch 2: Patch 4 defines a suspended state for the whole back-end if
  all vrings are stopped.  I think this should be mentioned in
  GET_VRING_BASE, but upon trying to add it, I found that it does not
  even mention that it stops the vring (mentioned only in the Ring
  States section), and remembered that the whole description of both
  GET_VRING_BASE and SET_VRING_BASE really was not helpful when trying
  to implement a vhost-user back-end.  Took the opportunity to overhaul
  both.

- Patch 3: This one’s from v3, but quite heavily modified.  Stefan
  suggested consistently defining the started/stopped and
  enabled/disabled states to be independent, and indeed doing so
  simplifies a whole lot of stuff.  Specifically, it makes the magic
  “enabled/disabled when started” go away.  Basically, I found this
  change alone is enough to remove the confusion I had with the existing
  documentation.

- Patch 4: As suggested by Stefan, just define a suspended state without
  introducing SUSPEND.  vDPA needs SUSPEND because its GET_VRING_BASE
  does not stop the vring, but vhost-user’s does, so we can define the
  suspended state to be when all vrings are stopped.

- Patch 5: Reference the suspended state.

- Patches 6 through 8: Unmodified, except for them being rebase on
  Stefan’s series.


Hanna Czenczek (8):
  vhost-user.rst: Deprecate [GS]ET_STATUS
  vhost-user.rst: Improve [GS]ET_VRING_BASE doc
  vhost-user.rst: Clarify enabling/disabling vrings
  vhost-user.rst: Introduce suspended state
  vhost-user.rst: Migrating back-end-internal state
  vhost-user: Interface for migration state transfer
  vhost: Add high-level state save/load functions
  vhost-user-fs: Implement internal migration

 docs/interop/vhost-user.rst       | 318 +++++++++++++++++++++++++++---
 include/hw/virtio/vhost-backend.h |  24 +++
 include/hw/virtio/vhost.h         | 113 +++++++++++
 hw/virtio/vhost-user-fs.c         | 101 +++++++++-
 hw/virtio/vhost-user.c            | 148 ++++++++++++++
 hw/virtio/vhost.c                 | 241 ++++++++++++++++++++++
 6 files changed, 917 insertions(+), 28 deletions(-)

-- 
2.41.0


