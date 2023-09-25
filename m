Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9460B7ADF66
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:04:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqql-0002oU-EQ; Mon, 25 Sep 2023 15:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkqqi-0002np-VO
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:02:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkqqg-0005WT-UE
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695668544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Nz1HPZdURwyIRAg9KRxnzWoJ3xUZM4JN0C064AnO+fY=;
 b=gNKEWGXzDZNQngSMIiSI5eQfvm8DfTRH1O1Zybh1yr6n5ldymabKENN0RsmfAZXFgEqwBF
 BDfyxuJuUf5DoBLWzm2qLQrFiC9RyKK8RFLiY3uqrGxn4xwIj4GYCs173ANrwEf5BDS3Sz
 KnwLwbRMzT8AlpbS8Zqz6D9e6WkApmw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-QCnKRC1MOausKayFBG29DQ-1; Mon, 25 Sep 2023 15:02:22 -0400
X-MC-Unique: QCnKRC1MOausKayFBG29DQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C1623C11A18
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 19:02:22 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD478C154CE
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 19:02:21 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] NBD patches through 2023-09-25
Date: Mon, 25 Sep 2023 14:01:15 -0500
Message-ID: <20230925190114.3163545-9-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit b55e4b9c0525560577384adfc6d30eb0daa8d7be:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2023-09-21 09:32:47 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2023-09-25

for you to fetch changes up to 8db7e2d65733268f7e788a69f5c6125f14f14cb0:

  nbd/server: Refactor handling of command sanity checks (2023-09-25 08:43:22 -0500)

----------------------------------------------------------------
NBD patches through 2023-09-25

- Denis V. Lunev: iotest improvements
- Eric Blake: further work towards 64-bit NBD extensions

----------------------------------------------------------------
Denis V. Lunev (2):
      iotests: use TEST_IMG_FILE instead of TEST_IMG in _require_large_file
      iotests: improve 'not run' message for nbd-multiconn test

Eric Blake (5):
      nbd: Replace bool structured_reply with mode enum
      nbd/client: Pass mode through to nbd_send_request
      nbd: Add types for extended headers
      nbd: Prepare for 64-bit request effect lengths
      nbd/server: Refactor handling of command sanity checks

 include/block/nbd.h                    | 142 ++++++++++++++++++---------
 nbd/nbd-internal.h                     |   3 +-
 block/nbd.c                            |  44 ++++++---
 nbd/client-connection.c                |   4 +-
 nbd/client.c                           |  22 +++--
 nbd/common.c                           |  12 ++-
 nbd/server.c                           | 172 ++++++++++++++++++++-------------
 qemu-nbd.c                             |   4 +-
 tests/qemu-iotests/common.rc           |   9 +-
 block/trace-events                     |   2 +-
 nbd/trace-events                       |  14 +--
 tests/qemu-iotests/tests/nbd-multiconn |   2 +-
 12 files changed, 280 insertions(+), 150 deletions(-)

-- 
2.41.0


