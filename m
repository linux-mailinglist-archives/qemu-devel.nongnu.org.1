Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F058D84D9
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jun 2024 16:23:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE8aK-0003ZV-NC; Mon, 03 Jun 2024 10:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sE8aI-0003Xy-Lu
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:22:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sE8aF-00036D-Ly
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717424565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YChZMKO6GNpdQIJ42scRbs2Z0mTCWoWKtJ/+ygMTGNE=;
 b=W8GPhfZQsBjRLU/VZaI/d6DZSugmZMx1QGZj4Uz9GnmSJew5e/cnWOVRwvZgU/KiXSJXbz
 Q0bgxJquOMq/rIZKJUZzOwUNsUE/xJhyoSqDBzqDTbTq3Ky6sl2Gq4dTdIOEu+9vNvlHg5
 Ug5Q4cIrwiEag+3cKf/czf2kkzDyFtw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-y3P6bCW4OiG2zjScvfS8zQ-1; Mon, 03 Jun 2024 10:22:43 -0400
X-MC-Unique: y3P6bCW4OiG2zjScvfS8zQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 196CB812296;
 Mon,  3 Jun 2024 14:22:43 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC0AC1C008BB;
 Mon,  3 Jun 2024 14:22:42 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
Subject: [PULL v2 0/2] NBD patches for 2024-05-30
Date: Mon,  3 Jun 2024 09:21:41 -0500
Message-ID: <20240603142240.22679-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit 3b2fe44bb7f605f179e5e7feb2c13c2eb3abbb80:

  Merge tag 'pull-request-2024-05-29' of https://gitlab.com/thuth/qemu into staging (2024-05-29 08:38:20 -0700)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2024-05-30-v2

for you to fetch changes up to a73c99378022ebb785481e84cfe1e81097546268:

  iotests: test NBD+TLS+iothread (2024-06-03 09:17:11 -0500)

----------------------------------------------------------------
NBD patches for 2024-05-30

- Fix AioContext assertion with NBD+TLS

----------------------------------------------------------------
Eric Blake (2):
      qio: Inherit follow_coroutine_ctx across TLS
      iotests: test NBD+TLS+iothread

 io/channel-tls.c                              |  26 ++--
 io/channel-websock.c                          |   1 +
 tests/qemu-iotests/tests/nbd-tls-iothread     | 168 ++++++++++++++++++++++++++
 tests/qemu-iotests/tests/nbd-tls-iothread.out |  54 +++++++++
 4 files changed, 238 insertions(+), 11 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/nbd-tls-iothread
 create mode 100644 tests/qemu-iotests/tests/nbd-tls-iothread.out

-- 
2.45.1


