Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 069C57FF45C
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 17:07:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8jYN-0007Vr-Fj; Thu, 30 Nov 2023 11:06:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1r8jYL-0007Va-Hb
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 11:06:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1r8jYJ-0002kc-Sc
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 11:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701360370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u+klYLHFF7B3WAY9Ot5NYDeu6LCoi6wBT49fzSymNKs=;
 b=Zs/PwcuIB9lwKXWXSc/HMT2wGG80McKDvmqf9n6ayS1/YjY9mNfoaLHSD4dzWUVyRm/tWJ
 04+/CMRWMaLAv5Ka7JBmOP7Vv6fXUkNCOjp7kt+sgiPF+mhBb/OJnZ3OmFftvuuxuitiJS
 S8pJTP/jfBTlz54n9EIMD3d8e97S8cU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-4FDtL3tCPwCJ0PyOeoI5LA-1; Thu, 30 Nov 2023 11:06:07 -0500
X-MC-Unique: 4FDtL3tCPwCJ0PyOeoI5LA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1901F80F82E;
 Thu, 30 Nov 2023 16:06:07 +0000 (UTC)
Received: from speedmetal.lan (unknown [10.45.242.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 49A7310F44;
 Thu, 30 Nov 2023 16:06:05 +0000 (UTC)
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Subject: [PATCH v2 0/2] block: commit/stream: Allow users to request only
 format driver names in backing file format
Date: Thu, 30 Nov 2023 17:06:02 +0100
Message-ID: <cover.1701360249.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
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

Please see patches for rationale.

Libvirt patches using this new flag will be posted soon-ish (after
cleanup).

v2:
 - fixed mistaken argument order in 'hmp_block_stream'
 - changed version in docs to 9.0 as getting this into RC 3 probably
   isn't realistic

Peter Krempa (2):
  block: commit: Allow users to request only format driver names in
    backing file format
  block: stream: Allow users to request only format driver names in
    backing file format

 block.c                                | 37 +++++++++++++++++++++-----
 block/commit.c                         |  6 ++++-
 block/monitor/block-hmp-cmds.c         |  2 +-
 block/stream.c                         | 10 ++++++-
 blockdev.c                             | 13 +++++++++
 include/block/block-global-state.h     |  3 ++-
 include/block/block_int-common.h       |  4 ++-
 include/block/block_int-global-state.h |  6 +++++
 qapi/block-core.json                   | 22 +++++++++++++--
 tests/unit/test-bdrv-drain.c           |  3 ++-
 10 files changed, 91 insertions(+), 15 deletions(-)

-- 
2.43.0


