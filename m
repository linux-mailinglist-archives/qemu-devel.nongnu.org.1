Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B1775A002
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 22:39:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMDv3-0005t9-2L; Wed, 19 Jul 2023 16:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qMDv1-0005sr-7J
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 16:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qMDuz-0001mC-H4
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 16:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689799024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4KoObbCppHnLld26AG0lzcvkStP8T6j5j8Zb9xKSOSk=;
 b=HV5q0+Zr5Explk89sN059vR97D0Bxi7rAIWCXn3xIptLuU90OzbjYIlmt43waR7Q6jwUwF
 DL3IFqJAKAv8HKFubXANNMmKbehsGoHDgp4r3Rh70gOZy4gtSG1SZXRLd8uKAVxK7hGlDq
 h+89W7J4qHLZNBcErI/Dv3naeq24NTY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-3CtEAjWsPqy8ogJxJREFXQ-1; Wed, 19 Jul 2023 16:37:02 -0400
X-MC-Unique: 3CtEAjWsPqy8ogJxJREFXQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FB6380123E
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 20:37:02 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F07684CD0F5
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 20:37:01 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/14] NBD patches for 2023-07-19
Date: Wed, 19 Jul 2023 15:27:37 -0500
Message-ID: <20230719202736.2675295-16-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

The following changes since commit 2c27fdc7a626408ee2cf30d791aa0b63027c7404:

  Update version for v8.1.0-rc0 release (2023-07-19 20:31:43 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2023-07-19

for you to fetch changes up to bfe04d0a7d5e8a4f4c9014ee7622af2056685974:

  nbd: Use enum for various negotiation modes (2023-07-19 15:26:13 -0500)

----------------------------------------------------------------
NBD patches through 2023-07-19

- Denis V. Lunev: fix hang with 'ssh ... "qemu-nbd -c"'
- Eric Blake: preliminary work towards NBD 64-bit extensions

----------------------------------------------------------------
Denis V. Lunev (6):
      qemu-nbd: pass structure into nbd_client_thread instead of plain char*
      qemu-nbd: fix regression with qemu-nbd --fork run over ssh
      qemu-nbd: properly report error if qemu_daemon() is failed
      qemu-nbd: properly report error on error in dup2() after qemu_daemon()
      qemu-nbd: handle dup2() error when qemu-nbd finished setup process
      qemu-nbd: make verbose bool and local variable in main()

Eric Blake (8):
      nbd/client: Use smarter assert
      nbd: Consistent typedef usage in header
      nbd/server: Prepare for alternate-size headers
      nbd/server: Refactor to pass full request around
      nbd: s/handle/cookie/ to match NBD spec
      nbd/client: Simplify cookie vs. index computation
      nbd/client: Add safety check on chunk payload length
      nbd: Use enum for various negotiation modes

 include/block/nbd.h |  61 +++++++-------
 block/nbd.c         |  96 +++++++++++-----------
 nbd/client.c        |  79 ++++++++++--------
 nbd/common.c        |  17 ++++
 nbd/server.c        | 224 +++++++++++++++++++++++++++++-----------------------
 qemu-nbd.c          |  68 +++++++++++-----
 nbd/trace-events    |  22 +++---
 7 files changed, 332 insertions(+), 235 deletions(-)

base-commit: 2c27fdc7a626408ee2cf30d791aa0b63027c7404
-- 
2.41.0


