Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB7673E5BD
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 18:48:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDpNa-0001A5-Le; Mon, 26 Jun 2023 12:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ernunes@redhat.com>)
 id 1qDpNA-00017V-GF
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ernunes@redhat.com>)
 id 1qDpN7-000295-Vl
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687798044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4NdLakG2UtNwJaY2S7RxvnCFuRC3W7oTdcrSMbbPirA=;
 b=Heqzgl1qoXka3BCmG8hbh9Ex1flnHExWZr/glSEquxdd2qoF8EKA+7uR3ybuzvVYpp21TB
 xq1hg4iwHoU/Q8kVsz904uDaKWFsemRylKt2KGsz8PsrkgcU51jjrGKY3V+pfZRv37LrVz
 hOAJNC3Y1j/1GQAqpMAZMfk2v46Irgs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-0H3cA58_PFSjByDql8pWIQ-1; Mon, 26 Jun 2023 12:47:22 -0400
X-MC-Unique: 0H3cA58_PFSjByDql8pWIQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EC0E8C80E5
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 16:47:19 +0000 (UTC)
Received: from centennial.enunes.eu.com (unknown [10.67.24.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 24BCD1121319;
 Mon, 26 Jun 2023 16:47:14 +0000 (UTC)
From: Erico Nunes <ernunes@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mst@redhat.com, kraxel@redhat.com,
 Erico Nunes <ernunes@redhat.com>
Subject: [PATCH v4 0/4] vhost-user-gpu get_edid feature
Date: Mon, 26 Jun 2023 18:47:04 +0200
Message-Id: <20230626164708.1163239-1-ernunes@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ernunes@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This adds support to the virtio-gpu get_edid command in qemu as the
frontend as well as the vhost-user-gpu implementation in contrib/.
So far, qemu has been outputting the following message:
  EDID requested but the backend doesn't support it.
when using that implementation.

This is tested with vhost-user-gpu, the dbus ui backend and the
monitor-edid application, which now shows complete "QEMU Monitor" edid
data.

The VHOST_USER_GPU_PROTOCOL_F_EDID protocol feature is required if the
frontend sets the VIRTIO_GPU_F_EDID virtio-gpu feature. If the frontend
sets the virtio-gpu feature but does not support the protocol feature,
the backend will abort with an error.

v3 -> v4:
- Remove unused fd code on patch 4/4

v2 -> v3:
- Fixed review comments from v2. Missing struct documentation and
setting feature bits to be compatible with the frontend.

Erico Nunes (4):
  virtio-gpu: refactor generate_edid function to virtio_gpu_base
  docs: vhost-user-gpu: add protocol changes for EDID
  contrib/vhost-user-gpu: implement get_edid feature
  vhost-user-gpu: implement get_edid frontend feature

 contrib/vhost-user-gpu/vhost-user-gpu.c | 73 +++++++++++++++++++++++--
 contrib/vhost-user-gpu/virgl.c          |  3 +
 contrib/vhost-user-gpu/vugpu.h          | 11 ++++
 docs/interop/vhost-user-gpu.rst         | 28 +++++++++-
 hw/display/vhost-user-gpu.c             | 32 +++++++++++
 hw/display/virtio-gpu-base.c            | 17 ++++++
 hw/display/virtio-gpu.c                 | 20 +------
 include/hw/virtio/virtio-gpu.h          |  2 +
 8 files changed, 158 insertions(+), 28 deletions(-)

-- 
2.40.1


