Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C063481AC57
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 02:51:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG8BZ-000848-4t; Wed, 20 Dec 2023 20:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rG8BX-00083H-Mo
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 20:49:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rG8BV-0002fD-E3
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 20:49:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703123352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GPw46gXn3wcJqEE02xkUpjFVhan0KPixZFadAOoIkm8=;
 b=VsL2lsj+8RsxEYKuZ0giwAjfPuwPxiM4cAceDXk78GgE+hyQXOaNkBMbo1Z3Krl6y2qkBV
 Mk7F+AGN4pnk26PgsFT4x4iWrHxRvxk8zj4PItW6t4VYmvRJ/lrwkNRyWESB7VVk1r5AGC
 173fXl9zuix6ailf/vvPIvLA5cW4Ac8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562--fVS_IPkMFGN1a6vn0v0qQ-1; Wed,
 20 Dec 2023 20:49:06 -0500
X-MC-Unique: -fVS_IPkMFGN1a6vn0v0qQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60A5429AB3E1;
 Thu, 21 Dec 2023 01:49:06 +0000 (UTC)
Received: from localhost (unknown [10.39.192.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C683C15968;
 Thu, 21 Dec 2023 01:49:04 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 0/6] qemu-iotests fixes for Kevin's block tree
Date: Wed, 20 Dec 2023 20:48:57 -0500
Message-ID: <20231221014903.1537962-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
 nbd/server.c                  | 152 +++++++++++++++++++++++++---------
 tests/qemu-iotests/051.pc.out |   4 +-
 4 files changed, 124 insertions(+), 42 deletions(-)

-- 
2.43.0


