Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A23805AFA
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 18:16:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAZ0c-0006yQ-B8; Tue, 05 Dec 2023 12:14:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1rAZ0a-0006x9-Ad
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 12:14:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1rAZ0X-00018C-98
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 12:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701796489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HM935U46cHRE3IJi+UNzLOpMsi1A9nfux/1GUW5D0fU=;
 b=EztJFxQRWYgOyHould/TyqJ39N3Pv4LGKVPcKOsoGbvCPpjQEz3sf42CdlwBAs5bgGrMq4
 BXaBJkEgjonq5XYpRyPpTvwSKuzfgmEDSyilu+LyxhtotqaHgBBooaEtCj94zfNpzl1kzu
 vUAHBuOyxxWX3XKxc3kuh0GYeNTdRpQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-jwZjMxTbMCqPd8F_Bxcmtw-1; Tue,
 05 Dec 2023 12:14:46 -0500
X-MC-Unique: jwZjMxTbMCqPd8F_Bxcmtw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B413838366C7;
 Tue,  5 Dec 2023 17:14:45 +0000 (UTC)
Received: from speedmetal.lan (unknown [10.45.242.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94104806B;
 Tue,  5 Dec 2023 17:14:43 +0000 (UTC)
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Subject: [PATCH v3 0/2] block: commit/stream: Allow users to request only
 format driver names in backing file format
Date: Tue,  5 Dec 2023 18:14:40 +0100
Message-ID: <cover.1701796348.git.pkrempa@redhat.com>
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

v3:
 - changed name of flag to 'backing-mask-protocol' (Eric)
 - decided to keep Vladimir's R-b as he requested shorter name too

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
 qapi/block-core.json                   | 17 ++++++++++--
 tests/unit/test-bdrv-drain.c           |  3 ++-
 10 files changed, 86 insertions(+), 15 deletions(-)

-- 
2.43.0


