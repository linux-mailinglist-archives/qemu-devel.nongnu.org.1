Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F34DB7BA95D
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 20:46:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoTM1-0000hB-Vy; Thu, 05 Oct 2023 14:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoTLp-0000Yn-5Q
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:45:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoTLl-0005w2-D6
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696531527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YP5zwv/7wVza/9YPQVZkcGLUmuzo93kL/ohZ+ExSnwY=;
 b=U8ldu5v4PnxUCUbxTxbyIdy1xVoDx+MJoyg3qrsh8Z6e73hPlytH3pcy0P9VRt+5JcvB0q
 nxqCaMlg8wzd+j8kU+7/DMRKWcLOfw1eYeFnND/MCyW/DKiWQ4p7KZYGcNJniPBeTJmuvg
 NFzgv0rAN3wf8WZmtPI0Gks22TOY9LQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-b0tTN4HGPY6ObaF63gnKRw-1; Thu, 05 Oct 2023 14:45:25 -0400
X-MC-Unique: b0tTN4HGPY6ObaF63gnKRw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 316313811F22
 for <qemu-devel@nongnu.org>; Thu,  5 Oct 2023 18:45:25 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF4BE215670B
 for <qemu-devel@nongnu.org>; Thu,  5 Oct 2023 18:45:24 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/15] NBD patches through 2023-10-05
Date: Thu,  5 Oct 2023 13:44:47 -0500
Message-ID: <20231005184447.682556-17-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

The following changes since commit 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2023-10-05 09:01:01 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2023-10-05

for you to fetch changes up to 2dcbb11b399ada51f734229b612e4f561a2aae0a:

  nbd/server: Add FLAG_PAYLOAD support to CMD_BLOCK_STATUS (2023-10-05 11:02:08 -0500)

----------------------------------------------------------------
NBD patches for 2023-10-05

- various: mailmap cleanups
- Eric Blake: enable use of NBD 64-bit extended headers

----------------------------------------------------------------
Andrey Drobyshev (1):
      mailmap: Fix Andrey Drobyshev author email

Eric Blake (14):
      maint: Tweak comments in mailmap regarding SPF
      mailmap: Fix BALATON Zoltan author email
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

 docs/interop/nbd.txt                             |   1 +
 include/block/nbd.h                              |   5 +-
 nbd/nbd-internal.h                               |   5 +-
 block/nbd.c                                      |  67 ++--
 nbd/client-connection.c                          |   2 +-
 nbd/client.c                                     | 124 ++++---
 nbd/server.c                                     | 426 ++++++++++++++++++-----
 qemu-nbd.c                                       |   4 +
 .mailmap                                         |  16 +-
 block/trace-events                               |   1 +
 nbd/trace-events                                 |   5 +-
 tests/qemu-iotests/223.out                       |  18 +-
 tests/qemu-iotests/233.out                       |   4 +
 tests/qemu-iotests/241.out                       |   3 +
 tests/qemu-iotests/307.out                       |  15 +-
 tests/qemu-iotests/tests/nbd-qemu-allocation.out |   3 +-
 16 files changed, 538 insertions(+), 161 deletions(-)

-- 
2.41.0


