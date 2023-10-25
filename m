Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BA17D6664
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:13:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvZvf-00029b-0g; Wed, 25 Oct 2023 05:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvZvF-0001xc-3Y
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:11:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvZvD-0006qd-04
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698225086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Lzu26Zl0fCdfzG7POaNej6cxfzbnZN31nFa+elv9ZYc=;
 b=RNU0bPae0nSOxMhy2SufKdtrPjxrY4dXZqIS1IvM6LmAPWabaQ7QG7MyL3g4mcP3ZKzOAC
 CmJr+Z9UpHFFpcBDkzWSSmn/vrE0okooQry3MLBtx+dxAsMKuPsY2Kunb4s4Ob+1T52YU8
 xbTcyfVe/0zWU7+KHUnV6m4+EdOOYXs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-lbmC2uyAM-KGcCg66tOwhw-1; Wed,
 25 Oct 2023 05:11:21 -0400
X-MC-Unique: lbmC2uyAM-KGcCg66tOwhw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBEBC28004E3;
 Wed, 25 Oct 2023 09:11:20 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B18B503B;
 Wed, 25 Oct 2023 09:11:18 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Xu <peterx@redhat.com>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fabiano Rosas <farosas@suse.de>, Li Zhijian <lizhijian@fujitsu.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v2 00/12] migration: Yet another round of atomic counters
Date: Wed, 25 Oct 2023 11:11:05 +0200
Message-ID: <20231025091117.6342-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi

On this v2:
- Redid commint for patch 1
- Every other patch is reviewed now.

Please review pending patch.

Thanks, Juan.

[v1]
Goal of the whole series was to be able to move rate_limit logic to
not use qemu_file.  Goal achieved.

Removal of trasnferred atomic counter.

After this series, we have three atomic counters:
- multifd_bytes
- rdma_bytes
- qemu_file_trasferred

And we only need to setup one (and only one) of these each time that
we sent anything.

Please review.

Later, Juan.

Juan Quintela (12):
  qemu-file: Don't increment qemu_file_transferred at
    qemu_file_fill_buffer
  qemu_file: Use a stat64 for qemu_file_transferred
  qemu_file: total_transferred is not used anymore
  migration: Use the number of transferred bytes directly
  qemu_file: Remove unused qemu_file_transferred()
  qemu-file: Remove _noflush from qemu_file_transferred_noflush()
  migration: migration_transferred_bytes() don't need the QEMUFile
  migration: migration_rate_limit_reset() don't need the QEMUFile
  qemu-file: Simplify qemu_file_get_error()
  migration: Use migration_transferred_bytes()
  migration: Remove transferred atomic counter
  qemu-file: Make qemu_fflush() return errors

 migration/migration-stats.h | 16 ++++++--------
 migration/qemu-file.h       | 27 ++++-------------------
 migration/block.c           |  4 ++--
 migration/colo.c            | 11 +++-------
 migration/migration-stats.c | 10 ++++-----
 migration/migration.c       | 17 ++++++---------
 migration/multifd.c         |  3 ---
 migration/qemu-file.c       | 43 +++++++++++--------------------------
 migration/ram.c             | 29 +++++++++----------------
 migration/rdma.c            |  4 +---
 migration/savevm.c          |  9 ++++----
 migration/vmstate.c         |  4 ++--
 12 files changed, 56 insertions(+), 121 deletions(-)

-- 
2.41.0


