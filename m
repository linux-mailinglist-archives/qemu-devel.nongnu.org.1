Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2071985F510
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Feb 2024 10:54:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd5lc-0007Tg-A0; Thu, 22 Feb 2024 04:53:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd5lR-0007TL-W0
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:53:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd5lQ-0006mR-3F
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708595590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KHiombyi2U5/ZBpOa0uShDT7zf78uUsn/WT6RRvWzls=;
 b=UBiwpcoTjYfdidhvmJsgvJSVzTPvfNRK4mqWAcdzwEpyRn6p5tW+bsjT3EyvXZM8Eddw+5
 D7ajb8Q/C8YUXqp0Ju/pa6dVOZqKYi2KsSGz7o20dWGQQRnUVg75wD2y3zWjMzCXh6kk8L
 OuP6spHRMGfBOf3ohVTKXj89BdRcKvo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-eOEaDdQyPKCr5Ly46B6rxg-1; Thu, 22 Feb 2024 04:53:07 -0500
X-MC-Unique: eOEaDdQyPKCr5Ly46B6rxg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1677185A788;
 Thu, 22 Feb 2024 09:53:06 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F1DD10802;
 Thu, 22 Feb 2024 09:53:03 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 0/5] migration: cleanup TLS channel referencing
Date: Thu, 22 Feb 2024 17:52:56 +0800
Message-ID: <20240222095301.171137-1-peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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

From: Peter Xu <peterx@redhat.com>

v2:
- add patches
  - migration/multifd: Make multifd_channel_connect() return void
  - migration/multifd: Cleanup outgoing_args in state destroy
  - migration/multifd: Drop unnecessary helper to destroy IOC
- fix spelling

This is a small cleanup patchset to firstly cleanup tls iochannel deref on
error paths, then further remove one unused var on yank if the cleanup
applies.  In v2 three more small cleanups on top as suggested by reviewers.

Please feel free to have a look, thanks.

Peter Xu (5):
  migration/multifd: Cleanup TLS iochannel referencing
  migration/multifd: Drop registered_yank
  migration/multifd: Make multifd_channel_connect() return void
  migration/multifd: Cleanup outgoing_args in state destroy
  migration/multifd: Drop unnecessary helper to destroy IOC

 migration/multifd.h |  2 --
 migration/socket.h  |  3 ++-
 migration/multifd.c | 58 +++++++++++++++++++++++----------------------
 migration/socket.c  | 19 +++++++--------
 4 files changed, 40 insertions(+), 42 deletions(-)

-- 
2.43.0


