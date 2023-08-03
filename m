Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC6376EEC2
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 17:56:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRagB-0006pe-7Q; Thu, 03 Aug 2023 11:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qRag7-0006o0-3j
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qRag4-0004na-AX
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691078151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=x+q6RpzbnWSVAs2Urc7EMNqXGJ5LgTeJwsi2ifUoBBQ=;
 b=JQlb5GcNotYdtelBJMGCBheWMkWr3rh9PW/ZUxyZWY8zhgo1qe+fwNsAFzxpD9CKpV+Fn/
 /3GnkkLV0xsTehScwOBtGlt8MLwqLhyeJvLeU9KVhAE4A2+sW7bFNmMiWvhb9AvIJmH9lK
 z4yGaGXixVGpgBWdEymLf1FIsECV5MA=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-s-Z3kPkeMHuDS1c1R8aHnw-1; Thu, 03 Aug 2023 11:55:47 -0400
X-MC-Unique: s-Z3kPkeMHuDS1c1R8aHnw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78F3B3810D3F;
 Thu,  3 Aug 2023 15:55:47 +0000 (UTC)
Received: from localhost (unknown [10.39.194.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 859F0477F63;
 Thu,  3 Aug 2023 15:55:46 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Richard Henderson <rth@twiddle.net>
Subject: [PULL for-8.1 0/2] Block patches
Date: Thu,  3 Aug 2023 11:55:43 -0400
Message-ID: <20230803155545.2349984-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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

The following changes since commit 9ba37026fcf6b7f3f096c0cca3e1e7307802486b:

  Update version for v8.1.0-rc2 release (2023-08-02 08:22:45 -0700)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 9b06d0d076271d76e5384d767ef94a676f0a9efd:

  block/blkio: add more comments on the fd passing handling (2023-08-03 11:28:43 -0400)

----------------------------------------------------------------
Pull request

Fix for an fd leak in the blkio block driver.

----------------------------------------------------------------

Stefano Garzarella (2):
  block/blkio: close the fd when blkio_connect() fails
  block/blkio: add more comments on the fd passing handling

 block/blkio.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

-- 
2.41.0


