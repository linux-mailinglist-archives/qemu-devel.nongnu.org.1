Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5F181BAF8
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 16:37:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGL5k-0005uH-04; Thu, 21 Dec 2023 10:36:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rGL5f-0005t7-Cx
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 10:36:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rGL5Z-0005Yo-LU
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 10:36:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703172956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lzrz4+Ok4jP0t/W58U2iX5ew+rqC4EHjmxziIWtrINQ=;
 b=MHi0+8pOdYTfEru/C9GTrOLdR2q0unbpvvB71MBWZg6EP5ZNm20TVlCH+u6KQ+NVJfpn64
 EineRiiwuxIpRGkshWhPJm5D1sz3gp0nJ6cdUt4FOD9gkmFElGcAIiHrEjjnNlqiD7FG6c
 RI/fvDasNUar68u0H1AZxvzA+Ta0T2Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-c7Z7ItMhMDWL_JlYr0u19w-1; Thu,
 21 Dec 2023 10:35:51 -0500
X-MC-Unique: c7Z7ItMhMDWL_JlYr0u19w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E1EC38130B7;
 Thu, 21 Dec 2023 15:35:51 +0000 (UTC)
Received: from localhost (unknown [10.39.194.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53CFA2026D66;
 Thu, 21 Dec 2023 15:35:49 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH v2 0/6] qemu-iotests fixes for Kevin's block tree
Date: Thu, 21 Dec 2023 10:35:42 -0500
Message-ID: <20231221153548.1752005-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
- Drop useless if (client->quiesing) check [Kevin]
- run qio_channel_read_wake() in export AioContext to avoid race [Kevin]
- Introduce nbd_client_put_nonzero() optimization [Paolo]
- Reach goto label disconnect with client->lock taken [Paolo]
- Add doc comment explaining nbd_co_receive_request() loop in nbd_trip() [Kevin]

Kevin merged several of my outstanding multi-queue block layer patch series and
found that qemu-iotests -qcow2 was broken. This patch series fixes the block branch.

Most of the fixes are easy but the NBD server required deeper debugging and
thread-safety fixes. The NBD server patches can be inserted before "aio: make
aio_context_acquire()/aio_context_release() a no-op" to preserve bisectability.
The other patches are fixups that can be squashed into the original patches.

Stefan Hajnoczi (6):
  fixup block-coroutine-wrapper: use qemu_get_current_aio_context()
  fixup block: remove AioContext locking
  fixup scsi: only access SCSIDevice->requests from one thread
  nbd/server: avoid per-NBDRequest nbd_client_get/put()
  nbd/server: only traverse NBDExport->clients from main loop thread
  nbd/server: introduce NBDClient->lock to protect fields

 hw/scsi/scsi-bus.c            |   3 +-
 migration/block.c             |   7 ++
 nbd/server.c                  | 205 ++++++++++++++++++++++++++--------
 tests/qemu-iotests/051.pc.out |   4 +-
 4 files changed, 170 insertions(+), 49 deletions(-)

-- 
2.43.0


