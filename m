Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC7F7CD8CD
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:08:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3SE-0007Jj-MX; Wed, 18 Oct 2023 06:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3S9-0007J4-4E
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:07:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3S7-0007gn-5z
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697623616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CyI10uFg2+CkrKyWss97y+xXG0bOuBePEW3/8Lsj56k=;
 b=N2XAWZZf5x1xxvYR5QKvfaEtb0hn5LZXSfM0A8QqMXUnFrAkQaq+P6KL2G4ESVD3ibPaGw
 Vs7Ii6E0vGB5cxwtXDDmNeGaArkFl/zBRghPa/Hwi3RtkMJWh5BcMgT2wnLN73p0tEduiA
 rPa9wjwuz+trGeqlLga8UW9zU6/lCZU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-VLcNP5JyPOm072b0b4nJDA-1; Wed, 18 Oct 2023 06:06:53 -0400
X-MC-Unique: VLcNP5JyPOm072b0b4nJDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 446E43822E92;
 Wed, 18 Oct 2023 10:06:53 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 507012026D4C;
 Wed, 18 Oct 2023 10:06:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 00/11] Migration 20231018 patches
Date: Wed, 18 Oct 2023 12:06:40 +0200
Message-ID: <20231018100651.32674-1-quintela@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

The following changes since commit ec6f9f135d5e5596ab0258da2ddd048f1fd8c359:

  Merge tag 'migration-20231017-pull-request' of https://gitlab.com/juan.quintela/qemu into staging (2023-10-17 10:06:21 -0400)

are available in the Git repository at:

  https://gitlab.com/juan.quintela/qemu.git tags/migration-20231018-pull-request

for you to fetch changes up to e8e4e7acd8e2113d900fe6b9a9870daa7ecf1042:

  migration: save_zero_page() can take block through pss (2023-10-18 10:39:03 +0200)

----------------------------------------------------------------
Migration Pull request (20231018)

In this pull request:
- RDMA cleanups
- compression cleanups

CI: https://gitlab.com/juan.quintela/qemu/-/pipelines/1040780020

Please apply.

PD.  I tried to get the deprecated bits integrated, but I broke
     qemu-iotests duer to blk warning.  Will resend it.

----------------------------------------------------------------

Juan Quintela (11):
  migration: RDMA is not compatible with anything else
  migration: Move compression_counters cleanup ram-compress.c
  migration: Create populate_compress()
  migration: Create ram_compressed_pages()
  migration: Move update_compress_threads_counts() to ram-compress.c
  migration: Simplify decompress_data_with_multi_threads()
  migration: Use "i" as an for index in ram-compress.c
  migration: Print block status when needed
  migration: save_compress_page() can take block through pss
  migration: control_save_page() can take block through pss
  migration: save_zero_page() can take block through pss

 migration/ram-compress.h       |   5 ++
 migration/migration-hmp-cmds.c |   5 +-
 migration/migration.c          |  27 +++++----
 migration/ram-compress.c       | 105 +++++++++++++++++++++------------
 migration/ram.c                |  45 +++++---------
 5 files changed, 104 insertions(+), 83 deletions(-)

-- 
2.41.0


