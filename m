Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D860706CDD
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:29:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJ5B-0002Mg-Fo; Wed, 17 May 2023 11:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzJ58-0002LI-IO
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:28:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzJ56-0000tT-TN
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684337328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1GOwuXx+vVYH5xsoNIz2zJtDzC60xs9qvpzMRg5W5Ao=;
 b=O7MyK6OI5ZvxweHfmbMLCpWsygqRuqzJD/4k62jbdZfJH7ASgG+Bh9XiRO71qGR6lh2Yjs
 8PwxYiz0eFMUDSd9CeueOll+B2/upVKqNznqRPjUEAJeZNfmilJ/543u4gWJShhjJzLxic
 FfOLVCnWH3hkh35XAJexAGEi21diryE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-0k7ZXQKZNN-CXoaX7HqdKw-1; Wed, 17 May 2023 11:28:44 -0400
X-MC-Unique: 0k7ZXQKZNN-CXoaX7HqdKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F054B85CD72;
 Wed, 17 May 2023 15:28:37 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5C681121314;
 Wed, 17 May 2023 15:28:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, mjt@tls.msk.ru,
 eblake@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH 0/3] block/graph-lock: Disable locking for now
Date: Wed, 17 May 2023 17:28:31 +0200
Message-Id: <20230517152834.277483-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

tl;dr is that graph locking introduced deadlocks in 8.0, and disabling
it for now fixes them again. See patch 1 for the details.

I still intend the fix this properly before we remove the AioContext
lock (which is when the deadlock would be automatically solved), but
it's not trivial enough for something that would be ready now and
backportable to stable versions. Let's try the real thing again in 8.1
and fix 8.0 with this stopgap solution.

Patch 2 is a prerequisite for the test case. Instead of reproducing the
deadlock problem (which it unfortunately doesn't do reliably anyway, the
timing seems hard to get right), I got NBD server crashes without it. I
actually made some more NBD changes to fix the crashes before this one,
but it seems to be stable with only this. Maybe the rest only fixed
symptoms of the same root cause, I'll have another look at them.

Kevin Wolf (3):
  graph-lock: Disable locking for now
  nbd/server: Fix drained_poll to wake coroutine in right AioContext
  iotests: Test commit with iothreads and ongoing I/O

 include/io/channel.h                          | 10 ++++
 block/graph-lock.c                            | 21 +++++++
 io/channel.c                                  | 33 +++++++++--
 nbd/server.c                                  |  3 +-
 tests/qemu-iotests/iotests.py                 |  4 ++
 .../qemu-iotests/tests/graph-changes-while-io | 56 +++++++++++++++++--
 .../tests/graph-changes-while-io.out          |  4 +-
 7 files changed, 117 insertions(+), 14 deletions(-)

-- 
2.40.1


