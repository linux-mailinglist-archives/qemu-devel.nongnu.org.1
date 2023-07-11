Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E119C74F41E
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 17:54:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJFfQ-0000dM-17; Tue, 11 Jul 2023 11:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJFfN-0000cj-4o
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:52:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJFfI-0001go-4M
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689090754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j+NXGThgtR1iXs69zHkEbuWF8HygYe1yvm9o6gbXmOk=;
 b=BLwgkrve6jMubZu3ATn1yxS3bghaANo55mH7SXWph8zsOiSshrr/i7A/S55ohCI0g/ADYg
 YzkjQ6CBYxxvNX8s1MgiJ4+tbooZFKwBU+1Dl5du2aIwjsTdJvIqeyyaTIp6mXQdkVrE2z
 xi2y4+hc83Tc7YI8T9tGPR6mIUhphSY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-lIG2-1rIO5OOU7yn-qyZPg-1; Tue, 11 Jul 2023 11:52:33 -0400
X-MC-Unique: lIG2-1rIO5OOU7yn-qyZPg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D66A03814947
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 15:52:32 +0000 (UTC)
Received: from localhost (unknown [10.39.192.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 551CB1454145;
 Tue, 11 Jul 2023 15:52:32 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: [PATCH 0/6] vhost-user: Add suspend/resume
Date: Tue, 11 Jul 2023 17:52:22 +0200
Message-ID: <20230711155230.64277-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi,

As discussed on the previous version of the virtio-fs migration series
(https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg01575.html),
we currently don’t have a good way to have a vhost-user back-end fully
cease all operations, including background operations.  To work around
this, we reset it, which is not an option for stateful devices like
virtio-fs.

Instead, we want the same SUSPEND/RESUME model that vhost-vdpa already
has, so that we can suspend back-ends when we want them to stop doing
anything (i.e. on VM stop), and resume them later (i.e. on VM resume).
This series adds these vhost-user operations to the protocol and
implements them in qemu.  Furthermore, it has vhost-user and vhost-vdpa
do roughly the same thing in their reset paths, as far as possible.
That path will still remain as a fall-back if SUSPEND/RESUME is not
implemented, and, given that qemu’s vhost-vdpa code currently does not
make use of RESUME, it is actually always used for vhost-vdpa (to take
the device out of a suspended state).


Hanna Czenczek (6):
  vhost-user.rst: Add suspend/resume
  vhost-vdpa: Move vhost_vdpa_reset_status() up
  vhost: Do not reset suspended devices on stop
  vhost-user: Implement suspend/resume
  vhost-vdpa: Match vhost-user's status reset
  vhost-user: Have reset_status fall back to reset

 docs/interop/vhost-user.rst    |  35 +++++++++++-
 include/hw/virtio/vhost-vdpa.h |   2 -
 include/hw/virtio/vhost.h      |   8 +++
 hw/virtio/vhost-user.c         | 101 ++++++++++++++++++++++++++++++++-
 hw/virtio/vhost-vdpa.c         |  41 ++++++-------
 hw/virtio/vhost.c              |   8 ++-
 6 files changed, 169 insertions(+), 26 deletions(-)

-- 
2.41.0


