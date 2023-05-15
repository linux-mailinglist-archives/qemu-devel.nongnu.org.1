Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9868703DDD
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 21:54:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeGW-0004vb-IQ; Mon, 15 May 2023 15:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGU-0004vK-JE
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:53:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGS-000478-Mf
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684180426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8Os8n/QXK6MLcyX5/7aNcXBv9L+HAaXXczHdlg4UV7k=;
 b=He1k+tVAGDNPmNtGkiUtqTwHsooC0OiVOIEPIx0orE6A8KBMNOISjE/SN16qRFLarVQy1p
 eF5zpU3X8EZpX4edD+ThsWQ1I+OVjziJzMm4L6pmGFBqfwoJ3khQ/6ElDX2mReiyb4MCsF
 gRsm4Bgh6ldfcwx/wO1NCckaXOYEVbI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-E-0NlAGgMYaZ4xw-PK3bow-1; Mon, 15 May 2023 15:53:45 -0400
X-MC-Unique: E-0NlAGgMYaZ4xw-PK3bow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09F7E101A552;
 Mon, 15 May 2023 19:53:45 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 835F2140E917;
 Mon, 15 May 2023 19:53:44 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: libguestfs@redhat.com,
	vsementsov@yandex-team.ru
Subject: [PATCH v3 00/14] qemu patches for 64-bit NBD extensions
Date: Mon, 15 May 2023 14:53:29 -0500
Message-Id: <20230515195343.1915857-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

v2 was here:
https://lists.gnu.org/archive/html/qemu-devel/2022-11/msg02340.html

Since then:
 - upstream NBD has accepted the extension on a branch; once multiple
   implementations interoperate based on that spec, it will be promoted
   to mainline (my plan: qemu with this series, libnbd nearly ready to
   go, nbdkit a bit further out)
 - rebase to block changes in meantime
 - drop RFC patches for 64-bit NBD_CMD_READ (NBD spec did not take them)
 - per upstream spec decision, extended headers now mandates use of
   NBD_REPLY_TYPE_BLOCK_STATUS_EXT rather than server choice based on
   reply size, which in turn required rearranging server patches a bit
 - other changes that I noticed while testing with parallel changes
   being added to libnbd (link to those patches to follow in the next
   week or so)

Eric Blake (14):
  nbd/client: Use smarter assert
  nbd/client: Add safety check on chunk payload length
  nbd/server: Prepare for alternate-size headers
  nbd: Prepare for 64-bit request effect lengths
  nbd: Add types for extended headers
  nbd/server: Refactor handling of request payload
  nbd/server: Refactor to pass full request around
  nbd/server: Support 64-bit block status
  nbd/server: Initial support for extended headers
  nbd/client: Initial support for extended headers
  nbd/client: Accept 64-bit block status chunks
  nbd/client: Request extended headers during negotiation
  nbd/server: Prepare for per-request filtering of BLOCK_STATUS
  nbd/server: Add FLAG_PAYLOAD support to CMD_BLOCK_STATUS

 docs/interop/nbd.txt                          |   1 +
 include/block/nbd.h                           | 165 +++--
 nbd/nbd-internal.h                            |   8 +-
 block/nbd.c                                   |  86 ++-
 nbd/client-connection.c                       |   4 +-
 nbd/client.c                                  | 143 ++--
 nbd/common.c                                  |  10 +-
 nbd/server.c                                  | 653 ++++++++++++------
 qemu-nbd.c                                    |   4 +
 block/trace-events                            |   1 +
 nbd/trace-events                              |  11 +-
 tests/qemu-iotests/223.out                    |  18 +-
 tests/qemu-iotests/233.out                    |   5 +
 tests/qemu-iotests/241.out                    |   3 +
 tests/qemu-iotests/307.out                    |  15 +-
 .../tests/nbd-qemu-allocation.out             |   3 +-
 16 files changed, 797 insertions(+), 333 deletions(-)


base-commit: 18b6727083acceac5d76ea0b8cb6f5cdef6858a7
-- 
2.40.1


