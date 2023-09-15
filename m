Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CE17A1C3D
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 12:27:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh61o-000760-BN; Fri, 15 Sep 2023 06:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qh61C-0006cJ-5b
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 06:25:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qh614-0002id-Ct
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 06:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694773534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UXWTN0SMvlftGADeqHk3ebQc7m49EZ0/NUqBmnDdJ9A=;
 b=cSpWXP0QSTSeZkpN/QKeBKxYE22FqVsDshiU5qUt2bOV/T48mTW25IkhyGNZjVY+4d4ae7
 sESUuocYJTURQP0l2fpvkZTnc6KjiLomy03TnItcdqzocVXzj5A+ig2PBqtX1VFQCp/TsL
 OW/DyMvcBYw6Fixgi34hu2cwtb8XkPU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-v9KZhuIdPZ6L81_7C1b23A-1; Fri, 15 Sep 2023 06:25:33 -0400
X-MC-Unique: v9KZhuIdPZ6L81_7C1b23A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F24A48039D1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 10:25:32 +0000 (UTC)
Received: from localhost (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 954B61004145;
 Fri, 15 Sep 2023 10:25:32 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org,
	virtio-fs@redhat.com
Cc: Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: [PATCH v3 0/5] vhost-user: Back-end state migration
Date: Fri, 15 Sep 2023 12:25:25 +0200
Message-ID: <20230915102531.55894-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

RFC:
https://lists.nongnu.org/archive/html/qemu-devel/2023-03/msg04263.html

v1:
https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg01575.html

v2:
https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg02604.html

Hi,

I’ve decided not to work on vhost-user SUSPEND/RESUME for now – it is
not technically required for virtio-fs migration, which is the actual
priority for me now.  While we do want to have SUSPEND/RESUME at some
point, the only practically existing reason for it is to be able to
implement vhost-level resetting in virtiofsd, but that is not related to
migration.

So one of the changes in v3 is that it no longer depends on the
vhost-user SUSPEND/RESUME series, and describes the migration protocol
without the device being suspended at any point, but merely that the
vrings are stopped.

Other changes include:

- Patch 1:
  - Rephrased a lot
  - Added a description for the VHOST_USER_SET_DEVICE_STATE_FD
    parameters
  - Renamed VHOST_USER_PROTOCOL_F_MIGRATORY_STATE to
    VHOST_USER_PROTOCOL_F_DEVICE_STATE
  - enum variants changed in value due to dropping the SUSPEND/RESUME
    dependency

- Patch 2:
  - Pulled in, was a stand-alone patch before
  - Dropped a sentence about ring state before feature negotiations, as
    the rings are not to be used during that period anyway
  - Bit of rephrasing

- Patch 3:
  - Renamed “migratory state” to “device state”
  - enum variants changed in value due to dropping the SUSPEND/RESUME
    dependency

- Patch 4:
  - Changed `f` to @f (referencing parameter “f”) in comments
  - Use g_autofree for the transfer buffer
  - Note SUSPEND state as a future feature, not currently existing
  - Wrap read() and write() in RETRY_ON_EINTR()

- Patch 5:
  - Renamed “migratory state” to “device state”
  - (kept R-b still)


Hanna Czenczek (5):
  vhost-user.rst: Migrating back-end-internal state
  vhost-user.rst: Clarify enabling/disabling vrings
  vhost-user: Interface for migration state transfer
  vhost: Add high-level state save/load functions
  vhost-user-fs: Implement internal migration

 docs/interop/vhost-user.rst       | 188 ++++++++++++++++++++++-
 include/hw/virtio/vhost-backend.h |  24 +++
 include/hw/virtio/vhost.h         | 114 ++++++++++++++
 hw/virtio/vhost-user-fs.c         | 101 ++++++++++++-
 hw/virtio/vhost-user.c            | 148 ++++++++++++++++++
 hw/virtio/vhost.c                 | 241 ++++++++++++++++++++++++++++++
 6 files changed, 810 insertions(+), 6 deletions(-)

-- 
2.41.0


