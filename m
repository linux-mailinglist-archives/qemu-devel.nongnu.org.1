Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B24836972
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 17:01:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRwjz-0001OU-7Q; Mon, 22 Jan 2024 11:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rRwjv-0001Kb-JM
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:01:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rRwjt-000493-JO
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705939291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KQxuYslZi7QjJRlUomTsgihbNsUDM3UujQqqEWPr5SM=;
 b=hfDpn/s6J6qEHeyDwjgS272xImd43dKJ3w0RpCYa9IzZXbigwkj5nzlQaKAoeKdeIrKxsH
 n+YbNkCKEsY6kEHV8CnFDj7BK0k5KF06LY4WA4mKBqR8DhK5KIWUsHa5kc7DaZxDu6GaBq
 d91eh3z8nTpOZWlms/fuJ5NRMNQP0fw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-kJ9CQD8sM1CdMY_TrFOq7g-1; Mon, 22 Jan 2024 11:01:29 -0500
X-MC-Unique: kJ9CQD8sM1CdMY_TrFOq7g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CBA585A599;
 Mon, 22 Jan 2024 16:01:29 +0000 (UTC)
Received: from localhost (unknown [10.39.194.240])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8DAED51D5;
 Mon, 22 Jan 2024 16:01:28 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>
Subject: [PULL 0/2] Block patches
Date: Mon, 22 Jan 2024 11:01:24 -0500
Message-ID: <20240122160126.394141-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
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

The following changes since commit 09be34717190c1620f0c6e5c8765b8da354aeb4b:

  Merge tag 'pull-request-2024-01-19' of https://gitlab.com/thuth/qemu into staging (2024-01-20 17:22:16 +0000)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 8a9be7992426c8920d4178e7dca59306a18c7a3a:

  block/io: clear BDRV_BLOCK_RECURSE flag after recursing in bdrv_co_block_status (2024-01-22 11:00:12 -0500)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Akihiko Odaki (1):
  coroutine-ucontext: Save fake stack for pooled coroutine

Fiona Ebner (1):
  block/io: clear BDRV_BLOCK_RECURSE flag after recursing in
    bdrv_co_block_status

 block/io.c                | 10 ++++++++++
 util/coroutine-ucontext.c | 35 ++++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 9 deletions(-)

-- 
2.43.0


