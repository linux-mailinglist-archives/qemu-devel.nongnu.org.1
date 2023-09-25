Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6927ADF8F
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:27:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkrDo-0003DR-3r; Mon, 25 Sep 2023 15:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkrDl-0003Cs-O9
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkrDk-0001zs-16
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695669975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ulLhTWF0MMzUk5RYteRL0P5AHCRED1Pks0kBOqQe54o=;
 b=YVK3NshinNWesWi2kNtnjCtl454oO6tLFb0aOOlAY8GD5ONDGAjEgHz916osZqqqE7AnsB
 yygThufOnS4S9rEfaHHhHgFvadZsHhqoGjMHnKUPqTS0hPO+gWIRm93Z98JfQLZCtEDR1V
 yYrxuHbII00SxsNhtAutJv0FGPLmze0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-AO6mX7huNLapZbC17FcKIA-1; Mon, 25 Sep 2023 15:26:13 -0400
X-MC-Unique: AO6mX7huNLapZbC17FcKIA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0AA753816C81;
 Mon, 25 Sep 2023 19:26:13 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5BD2B51E3;
 Mon, 25 Sep 2023 19:26:12 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: libguestfs@redhat.com,
	qemu-block@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH v7 00/12] NBD 64-bit extensions for qemu
Date: Mon, 25 Sep 2023 14:22:30 -0500
Message-ID: <20230925192229.3186470-14-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

v6 was here:
https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg05231.html

Since then:
 - patches v6 1-5 included in pull request
 - patch v6 6 logic improved, now v7 patch 1
 - rebased to master

Still needing review:
 - patch 1,6,7,11,12

Eric Blake (12):
  nbd/server: Support a request payload
  nbd/server: Prepare to receive extended header requests
  nbd/server: Prepare to send extended header replies
  nbd/server: Support 64-bit block status
  nbd/server: Enable initial support for extended headers
  nbd/client: Plumb errp through nbd_receive_replies
  nbd/client: Initial support for extended headers
  nbd/client: Accept 64-bit block status chunks
  nbd/client: Request extended headers during negotiation
  nbd/server: Refactor list of negotiated meta contexts
  nbd/server: Prepare for per-request filtering of BLOCK_STATUS
  nbd/server: Add FLAG_PAYLOAD support to CMD_BLOCK_STATUS

 docs/interop/nbd.txt                          |   1 +
 include/block/nbd.h                           |   5 +-
 nbd/nbd-internal.h                            |   5 +-
 block/nbd.c                                   |  67 ++-
 nbd/client-connection.c                       |   2 +-
 nbd/client.c                                  | 124 ++++--
 nbd/server.c                                  | 418 ++++++++++++++----
 qemu-nbd.c                                    |   4 +
 block/trace-events                            |   1 +
 nbd/trace-events                              |   5 +-
 tests/qemu-iotests/223.out                    |  18 +-
 tests/qemu-iotests/233.out                    |   4 +
 tests/qemu-iotests/241.out                    |   3 +
 tests/qemu-iotests/307.out                    |  15 +-
 .../tests/nbd-qemu-allocation.out             |   3 +-
 15 files changed, 516 insertions(+), 159 deletions(-)

-- 
2.41.0


