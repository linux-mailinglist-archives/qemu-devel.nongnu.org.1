Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 662FD898961
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Apr 2024 15:58:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNc3-0002Zx-EQ; Thu, 04 Apr 2024 09:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rsNc1-0002ZT-03
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 09:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rsNbv-0006AJ-5K
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 09:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712239114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SJU0K7lywJXWdTuHh8ZRqLhGoChQBalZA/lbaW8Q0TA=;
 b=bWeLAklUxAU2CDsRoRfC2uV7F/SdCXiDZ39ZIasexTR/HiuKT/abkdSTmdamV9f59cOFp8
 pp5v58ImVDluT5HztoAFdq+wykdyzHorg9zCSZGxk1b2pRM/27zKeUhMMfpWsjqbcSZDM+
 8+0yWTJVDWTXvITauOPeESp+dUmTXx4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135--onviTHDOL6VB4mdptxaLQ-1; Thu, 04 Apr 2024 09:58:30 -0400
X-MC-Unique: -onviTHDOL6VB4mdptxaLQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF24980A1A6;
 Thu,  4 Apr 2024 13:58:29 +0000 (UTC)
Received: from localhost (unknown [10.39.195.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D47D7492BC9;
 Thu,  4 Apr 2024 13:58:28 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PULL for-9.0 0/1] Block patches
Date: Thu,  4 Apr 2024 09:58:22 -0400
Message-ID: <20240404135823.2654261-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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

The following changes since commit 786fd793b81410fb2a28914315e2f05d2ff6733b:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-04-03 12:52:03 +0100)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to bbdf9023665f409113cb07b463732861af63fb47:

  block/virtio-blk: Fix memory leak from virtio_blk_zone_report (2024-04-04 09:29:42 -0400)

----------------------------------------------------------------
Pull request

Fix a memory leak in virtio-blk zone report emulation code when the request is
invalid.

----------------------------------------------------------------

Zheyu Ma (1):
  block/virtio-blk: Fix memory leak from virtio_blk_zone_report

 hw/block/virtio-blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.44.0


