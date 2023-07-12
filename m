Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD17751159
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 21:38:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJfeD-0004N9-Od; Wed, 12 Jul 2023 15:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qJfe9-0004LV-6o
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qJfe7-0005V1-1k
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689190624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YXeP+fmex/JIdOzhJNXc9HhqoJIN7bsmxtPsy3yj7Ig=;
 b=TMvb95lcWfG9QZ6RvLfSGsEyVx5JCfKt8KO8bMi9nz7doyR6BLOCFxHAjfxqvpbWlRYfgE
 2atuzNYxL+9sA03C1TudhiBIlAuPE/aJOv+zW4cv01HTBBBoxnPC348dQ209Gl2PT49jjO
 LSrxDDj0Cg5LGGl0zE49RqpdjSe1+dU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-347-BenBbsM5N360cuB0vOggMg-1; Wed, 12 Jul 2023 15:37:00 -0400
X-MC-Unique: BenBbsM5N360cuB0vOggMg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D8108F9E46;
 Wed, 12 Jul 2023 19:37:00 +0000 (UTC)
Received: from localhost (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFFF740C206F;
 Wed, 12 Jul 2023 19:36:59 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Subject: [PULL 0/1] Block patches
Date: Wed, 12 Jul 2023 15:36:57 -0400
Message-Id: <20230712193658.255676-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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

The following changes since commit 887cba855bb6ff4775256f7968409281350b568c:

  configure: Fix cross-building for RISCV host (v5) (2023-07-11 17:56:09 +0100)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 75dcb4d790bbe5327169fd72b185960ca58e2fa6:

  virtio-blk: fix host notifier issues during dataplane start/stop (2023-07-12 15:20:32 -0400)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Stefan Hajnoczi (1):
  virtio-blk: fix host notifier issues during dataplane start/stop

 hw/block/dataplane/virtio-blk.c | 67 +++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 29 deletions(-)

-- 
2.40.1


