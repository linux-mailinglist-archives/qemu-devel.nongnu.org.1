Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4509A7148C6
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 13:42:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3bGI-0000vl-4L; Mon, 29 May 2023 07:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1q3bFt-0000p2-OT
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:41:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1q3bFn-0002X3-Dm
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685360493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z++BCADDC8Xu13WJDdimu9dO90uR2P2w1Vy/UUrgugM=;
 b=N65zK5BNHO5rCbOihzCUy6iJoCV7MvxhoZ4JVC9q+YoGAkIYSn+TIycEysgxnC9XLBj7QT
 IhTfVXrCOWrHORmyyFFo5fBx9w2Oe8M2iU5W+wyUB1i3DfsNocRovDNVEyhdeU1OLU5H+L
 qoKrlRjIbu5rQadd47HQkoPupHy3FOw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-QAkboWGdPJSeZ-_01JcksQ-1; Mon, 29 May 2023 07:41:32 -0400
X-MC-Unique: QAkboWGdPJSeZ-_01JcksQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E80A4101A531;
 Mon, 29 May 2023 11:41:31 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.17.140])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E0DFB3543C;
 Mon, 29 May 2023 11:41:29 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 Michael S Tsirkin <mst@redhat.com>, Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v2 0/2] vhost: release memory objects in an error path
Date: Mon, 29 May 2023 17:13:31 +0530
Message-Id: <20230529114333.31686-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

Hi,

vhost_dev_start function does not release memory objects in case of
an error. These couple of patches fix this glitch.

Thank you.
---
Prasad Pandit (2):
  vhost: release memory_listener object in error path
  vhost: release virtqueue objects in error path

 hw/virtio/vhost.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--
2.40.1


