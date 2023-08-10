Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F4169777F58
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 19:43:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU9g1-0003qH-I8; Thu, 10 Aug 2023 13:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qU9fx-0003na-VU
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qU9fv-0004wm-P1
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691689338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/+NbpfajK8n0CfzwEQw36B19oG4MQzWIGMhHnrGdLSM=;
 b=Cg3ma78aGcrqyihYDD2BNlJUhnrCSIuVNrr/Mpd7/SbR09BJITK9bRltnn/u1mKEGzSDWJ
 jYW8JsU3NVj2fSSMIlv+1kE6pHM3xt2CDkHxBj3ywMy2dIKblxB7WM/xaEPv2Pk8mblfwx
 KcVfWkJQrxWFUxH8Zc6QYVvoNEpF354=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-J4oha2l3PL2Sygp73atrjQ-1; Thu, 10 Aug 2023 13:42:16 -0400
X-MC-Unique: J4oha2l3PL2Sygp73atrjQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62ED0805AF6;
 Thu, 10 Aug 2023 17:42:16 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93C4A1121314;
 Thu, 10 Aug 2023 17:42:15 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH v5 00/17] qemu patches for 64-bit NBD extensions
Date: Thu, 10 Aug 2023 12:36:47 -0500
Message-ID: <20230810173646.17695-19-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

v4 was here:
https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg01898.html
(1-8/24 of that series made it into 8.1; this is the rest)

v5 addresses Vladimir's review comments; and the amount of change is
smaller, so this is probably ready to merge in once 8.1 is out the
door and the remaining patches get R-b tags.  The biggest change is
probably the split of v4 13/24 into a split 5 and 6 here, which had
knock-on effects to patch 17.

001/17:[0006] [FC] 'nbd: Replace bool structured_reply with mode enum'
002/17:[----] [--] 'nbd/client: Pass mode through to nbd_send_request'
003/17:[----] [--] 'nbd: Add types for extended headers'
004/17:[0018] [FC] 'nbd: Prepare for 64-bit request effect lengths'
005/17:[down] 'nbd/server: Refactor handling of command sanity checks'
006/17:[down] 'nbd/server: Support a request payload'
007/17:[----] [--] 'nbd/server: Prepare to receive extended header requests'
008/17:[0004] [FC] 'nbd/server: Prepare to send extended header replies'
009/17:[0004] [FC] 'nbd/server: Support 64-bit block status'
010/17:[0002] [FC] 'nbd/server: Enable initial support for extended headers'
011/17:[0002] [FC] 'nbd/client: Plumb errp through nbd_receive_replies'
012/17:[0004] [FC] 'nbd/client: Initial support for extended headers'
013/17:[0010] [FC] 'nbd/client: Accept 64-bit block status chunks'
014/17:[----] [--] 'nbd/client: Request extended headers during negotiation'
015/17:[----] [-C] 'nbd/server: Refactor list of negotiated meta contexts'
016/17:[0006] [FC] 'nbd/server: Prepare for per-request filtering of BLOCK_STATUS'
017/17:[0053] [FC] 'nbd/server: Add FLAG_PAYLOAD support to CMD_BLOCK_STATUS'

Eric Blake (17):
  nbd: Replace bool structured_reply with mode enum
  nbd/client: Pass mode through to nbd_send_request
  nbd: Add types for extended headers
  nbd: Prepare for 64-bit request effect lengths
  nbd/server: Refactor handling of command sanity checks
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
 include/block/nbd.h                           | 147 +++--
 nbd/nbd-internal.h                            |   8 +-
 block/nbd.c                                   | 105 +++-
 nbd/client-connection.c                       |   4 +-
 nbd/client.c                                  | 140 +++--
 nbd/common.c                                  |  12 +-
 nbd/server.c                                  | 558 +++++++++++++-----
 qemu-nbd.c                                    |   8 +-
 block/trace-events                            |   3 +-
 nbd/trace-events                              |  19 +-
 tests/qemu-iotests/223.out                    |  18 +-
 tests/qemu-iotests/233.out                    |   4 +
 tests/qemu-iotests/241.out                    |   3 +
 tests/qemu-iotests/307.out                    |  15 +-
 .../tests/nbd-qemu-allocation.out             |   3 +-
 16 files changed, 762 insertions(+), 286 deletions(-)


base-commit: 64d3be986f9e2379bc688bf1d0aca0557e0035ca
-- 
2.41.0


