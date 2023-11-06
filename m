Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDF37E2ABA
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 18:11:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r037k-0002a4-Le; Mon, 06 Nov 2023 12:10:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1r037i-0002ZS-7j
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:10:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1r037g-00071m-Kc
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699290648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8v5PAzJyWdF89/gALt8MjRsXMGtMVEpNVC8SQ6kYiJw=;
 b=IWMLO0stP/yPO0TCf84nB3MhH0nHU0P/IyuCJggjzBEqKv011vr/da/Ggyibsm8rccvrGS
 GVGXDjFU8Ncet2tracJxXrXJ6dtL5+R9GdhvlgFAV/L3CNhcN3y/1U5TnV6E/ALHxePFvw
 JNFf6ZDq9R8pEGH1qacNlA8VjL0ENqs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-EDtik-6qOXySewJ_TrO6OQ-1; Mon, 06 Nov 2023 12:10:34 -0500
X-MC-Unique: EDtik-6qOXySewJ_TrO6OQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB239866DCE;
 Mon,  6 Nov 2023 17:10:33 +0000 (UTC)
Received: from localhost (unknown [10.39.193.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BBF2492A;
 Mon,  6 Nov 2023 17:10:33 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
	Hanna Czenczek <hreitz@redhat.com>
Subject: [PULL 0/3] Block patches
Date: Mon,  6 Nov 2023 18:10:28 +0100
Message-ID: <20231106171031.1084277-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 3e01f1147a16ca566694b97eafc941d62fa1e8d8:

  Merge tag 'pull-sp-20231105' of https://gitlab.com/rth7680/qemu into staging (2023-11-06 09:34:22 +0800)

are available in the Git repository at:

  https://gitlab.com/hreitz/qemu.git tags/pull-block-2023-11-06

for you to fetch changes up to ad4feaca61d76fecad784e6d5e7bae40d0411c46:

  file-posix: fix over-writing of returning zone_append offset (2023-11-06 16:15:07 +0100)

----------------------------------------------------------------
Block patches:
- One patch to make qcow2's discard-no-unref option do better what it is
  supposed to do (i.e. prevent fragmentation)
- Two fixes for zoned requests

----------------------------------------------------------------
Jean-Louis Dupond (1):
  qcow2: keep reference on zeroize with discard-no-unref enabled

Naohiro Aota (1):
  file-posix: fix over-writing of returning zone_append offset

Sam Li (1):
  block/file-posix: fix update_zones_wp() caller

 qapi/block-core.json  | 24 ++++++++++++++----------
 block/file-posix.c    | 23 ++++++++++++-----------
 block/qcow2-cluster.c | 22 ++++++++++++++++++----
 qemu-options.hx       | 10 +++++++---
 4 files changed, 51 insertions(+), 28 deletions(-)

-- 
2.41.0


