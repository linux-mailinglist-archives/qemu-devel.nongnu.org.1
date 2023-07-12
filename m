Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEAD75076F
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 14:04:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJXqJ-0003E3-5T; Wed, 12 Jul 2023 07:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJXqH-0003CB-CB
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJXqF-0002yt-O2
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689160627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M6WT+TqF2nYoosQ8gnVJkd7oHwzbXkqZ1JSPgKy2pE0=;
 b=V+KFXXvra5iknoAVzqknzb2Ywm2cB5ZvYZvH3x5GrqE1He0xjoizq3ow6Z5aPXlhGeeJzP
 fYPx+76A+vBOE7swuSdvlHFwS3FsCk21cqBejSahwIxdJq7x0Rc4YgLy0jeln0CjOJhR/X
 oEHkvQbJMi2H93weT+DShg/vHeAexHw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-wMssugD0NiWNHO9D_UzfxQ-1; Wed, 12 Jul 2023 07:17:05 -0400
X-MC-Unique: wMssugD0NiWNHO9D_UzfxQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E5D9185A792
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 11:17:05 +0000 (UTC)
Received: from localhost (unknown [10.39.193.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83FFE1454142;
 Wed, 12 Jul 2023 11:17:04 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org,
	virtio-fs@redhat.com
Cc: Hanna Czenczek <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v2 0/4] vhost-user: Back-end state migration
Date: Wed, 12 Jul 2023 13:16:58 +0200
Message-ID: <20230712111703.28031-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
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

RFC:
https://lists.nongnu.org/archive/html/qemu-devel/2023-03/msg04263.html

v1:
https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg01575.html

Based-on: <20230711155230.64277-1-hreitz@redhat.com>
          (“[PATCH 0/6] vhost-user: Add suspend/resume”)
https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg02450.html


Hi,

Most of the feedback on v1 focused on how to properly stop a device that
has internal state, both for the purpose of migration and just plainly
for VM stop/cont.  I hope this is resolved by my vhost-user
suspend/resume series, which this series here is based on (linked
above).

Therefore, these patches here for the actual state transfer have changed
only little since v1:

- I’ve removed the original patch 1 that would explicitly re-enable all
  vrings every time after using SET_FEATURES with
  VHOST_USER_F_PROTOCOL_FEATURES, replacing it with the stand-alone
  patch “[PATCH] vhost-user.rst: Clarify enabling/disabling vrings”
  (20230712091704.15589-1-hreitz@redhat.com), which does not change
  behavior but only documentation

- In its place, I’ve added a patch that adds documentation on the
  protocol additions.

- Patch 2: Drastically shortened the commit message, this documentation
  is now where it should be, namely in vhost-user.rst (added by patch
  1).  Also rebased on the “Add suspend/resume” series, which adds
  feature bits and vhost-user operations of its own.

- Patch 3: Instead of checking dev->started to see that the device is
  stopped, we might now want to check dev->suspended instead.  However,
  this is only set if the device actually supports suspending, so in
  fact we cannot use it.  Added documentation on this fact.
  (Dropped checking enable_vqs, because this variable had been added
  only by the old patch 1, which I dropped.)


Hanna Czenczek (4):
  vhost-user.rst: Migrating back-end-internal state
  vhost-user: Interface for migration state transfer
  vhost: Add high-level state save/load functions
  vhost-user-fs: Implement internal migration

 docs/interop/vhost-user.rst       |  87 +++++++++++
 include/hw/virtio/vhost-backend.h |  24 +++
 include/hw/virtio/vhost.h         | 114 ++++++++++++++
 hw/virtio/vhost-user-fs.c         | 101 ++++++++++++-
 hw/virtio/vhost-user.c            | 147 ++++++++++++++++++
 hw/virtio/vhost.c                 | 241 ++++++++++++++++++++++++++++++
 6 files changed, 713 insertions(+), 1 deletion(-)

-- 
2.41.0


