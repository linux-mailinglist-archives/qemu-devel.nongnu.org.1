Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2607923AB
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 16:51:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdXNy-0006fS-72; Tue, 05 Sep 2023 10:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdXNv-0006bc-Gn
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 10:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdXNt-0004ZE-Er
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 10:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693925427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jWDL9qeW3CpBxrygy0q6miERDJo2pj6nHhDLPJVGDOo=;
 b=FBP5Ou1ZRKxuwtdfBeGv7vKqVJpjfRCHkag9Q1dZv+d+iTfKJFpFLW945/jUyaCFQKM/9X
 P3bIwRE/oMWT0mvaIRaMOpxOLOyLNwMdBb/t8l96rV8su6STgAMglDRApmFwq19PNvVz6v
 U4h9mMTwXlBIt2vfziRoDGdAHZRivic=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-Ur8laLzoNVGp8as1x6mQnw-1; Tue, 05 Sep 2023 10:50:24 -0400
X-MC-Unique: Ur8laLzoNVGp8as1x6mQnw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBC5128237CA;
 Tue,  5 Sep 2023 14:50:23 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7194C46F528;
 Tue,  5 Sep 2023 14:50:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com,
 leobras@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH 0/2] virtio: Drop out of coroutine context in virtio_load()
Date: Tue,  5 Sep 2023 16:50:00 +0200
Message-ID: <20230905145002.46391-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This fixes a recently introduced assertion failure that was reported to
happen when migrating virtio-net with a failover. The latent bug that
we're executing code in coroutine context that was never supposed to run
there has existed for a long time. However, the new assertion that
callers of bdrv_graph_rdlock_main_loop() don't run in coroutine context
makes it very visible because it's now always a crash.

Kevin Wolf (2):
  vmstate: Mark VMStateInfo.get/put() coroutine_mixed_fn
  virtio: Drop out of coroutine context in virtio_load()

 include/migration/vmstate.h |  8 ++++---
 hw/virtio/virtio.c          | 45 ++++++++++++++++++++++++++++++++-----
 2 files changed, 45 insertions(+), 8 deletions(-)

-- 
2.41.0


