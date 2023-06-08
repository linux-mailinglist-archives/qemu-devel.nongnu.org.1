Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFFA728206
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:00:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7G8k-00041R-TQ; Thu, 08 Jun 2023 09:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8M-0003sW-Fc
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8J-0004di-RD
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686232618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xBu503hlzJ8Fsz8MYxzTCHTFWPD7DL5jbrDeLBctwvo=;
 b=FfMrlqXrg85IJvyV3fQ/kHL/7xKV2OSCGKpqBSKPCISB4ox0kOoJdJ23k7OEfZoQhzoNC1
 ysnxZsdzQHhKPUUQPnjub77hYzzn+LwZHyunMkTAX0F+R37dgpiO2MMHEAQJj3TZWHw6bg
 oKp88bz6O1CzhhFO7nB3Ieul/2hdXjE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-1d3MeMZKNSK5iiSb4Hty2A-1; Thu, 08 Jun 2023 09:56:55 -0400
X-MC-Unique: 1d3MeMZKNSK5iiSb4Hty2A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8E933823A13;
 Thu,  8 Jun 2023 13:56:54 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AC8A515544;
 Thu,  8 Jun 2023 13:56:53 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	libguestfs@redhat.com,
	vsementsov@yandex-team.ru
Subject: [PATCH v4 00/24] qemu patches for 64-bit NBD extensions
Date: Thu,  8 Jun 2023 08:56:29 -0500
Message-Id: <20230608135653.2918540-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

v3 was here:
https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03607.html

Since then, I've incorporated lots of feedback from Vladimir:
 - split several patches into smaller pieces
 - use an enum to track various negotiation modes
 - reorder a few patches
 - several new patches (2, 5, 6)
 - other cleanups

001/24:[----] [--] 'nbd/client: Use smarter assert'
002/24:[down] 'nbd: Consistent typedef usage in header'
003/24:[0137] [FC] 'nbd/server: Prepare for alternate-size headers'
004/24:[0093] [FC] 'nbd/server: Refactor to pass full request around'
005/24:[down] 'nbd: s/handle/cookie/ to match NBD spec'
006/24:[down] 'nbd/client: Simplify cookie vs. index computation'
007/24:[----] [-C] 'nbd/client: Add safety check on chunk payload length'
008/24:[down] 'nbd: Use enum for various negotiation modes'
009/24:[down] 'nbd: Replace bool structured_reply with mode enum'
010/24:[down] 'nbd/client: Pass mode through to nbd_send_request'
011/24:[0096] [FC] 'nbd: Add types for extended headers'
012/24:[0118] [FC] 'nbd: Prepare for 64-bit request effect lengths'
013/24:[0071] [FC] 'nbd/server: Refactor handling of request payload'
014/24:[down] 'nbd/server: Prepare to receive extended header requests'
015/24:[down] 'nbd/server: Prepare to send extended header replies'
016/24:[0132] [FC] 'nbd/server: Support 64-bit block status'
017/24:[down] 'nbd/server: Enable initial support for extended headers'
018/24:[down] 'nbd/client: Plumb errp through nbd_receive_replies'
019/24:[0066] [FC] 'nbd/client: Initial support for extended headers'
020/24:[0032] [FC] 'nbd/client: Accept 64-bit block status chunks'
021/24:[0058] [FC] 'nbd/client: Request extended headers during negotiation'
022/24:[down] 'nbd/server: Refactor list of negotiated meta contexts'
023/24:[0132] [FC] 'nbd/server: Prepare for per-request filtering of BLOCK_STATUS'
024/24:[0109] [FC] 'nbd/server: Add FLAG_PAYLOAD support to CMD_BLOCK_STATUS'

Eric Blake (24):
  nbd/client: Use smarter assert
  nbd: Consistent typedef usage in header
  nbd/server: Prepare for alternate-size headers
  nbd/server: Refactor to pass full request around
  nbd: s/handle/cookie/ to match NBD spec
  nbd/client: Simplify cookie vs. index computation
  nbd/client: Add safety check on chunk payload length
  nbd: Use enum for various negotiation modes
  nbd: Replace bool structured_reply with mode enum
  nbd/client: Pass mode through to nbd_send_request
  nbd: Add types for extended headers
  nbd: Prepare for 64-bit request effect lengths
  nbd/server: Refactor handling of request payload
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
 include/block/nbd.h                           | 201 ++++--
 nbd/nbd-internal.h                            |   8 +-
 block/nbd.c                                   | 189 +++--
 nbd/client-connection.c                       |   4 +-
 nbd/client.c                                  | 199 ++++--
 nbd/common.c                                  |  29 +-
 nbd/server.c                                  | 666 ++++++++++++------
 qemu-nbd.c                                    |   8 +-
 block/trace-events                            |   1 +
 nbd/trace-events                              |  29 +-
 tests/qemu-iotests/223.out                    |  18 +-
 tests/qemu-iotests/233.out                    |   4 +
 tests/qemu-iotests/241.out                    |   3 +
 tests/qemu-iotests/307.out                    |  15 +-
 .../tests/nbd-qemu-allocation.out             |   3 +-
 16 files changed, 937 insertions(+), 441 deletions(-)


base-commit: 4f65e89f8cf0e079b4ec3ddfede314bbb4e35c76
-- 
2.40.1


