Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47871716CAC
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:42:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44G8-0000Lk-Pv; Tue, 30 May 2023 14:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q44G7-0000Kw-0a
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:39:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q44G5-00046z-6i
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685471988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9UR5nfHCUF5ylQgxjHCZAUFh5KwbLnjpS0f53ipsDDI=;
 b=MleVkrsqjcAgfNiN0F0yOEryKwdfr70VfjK6lA1dsQgapDVgZTDc0T6yD88JIHc79/gSn/
 7ufdlZIBxkP1P+5/5yq9RFluV54RbVnEIxZOgXpsrtZEfGh7gzievSF7q933ZAW4tsmGNg
 gy20LZW4r3LVzbzL5TSxbZGkXx3XFAY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-FmdTyRxqOfm0lHbbgCRCTA-1; Tue, 30 May 2023 14:39:44 -0400
X-MC-Unique: FmdTyRxqOfm0lHbbgCRCTA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 784463C11A1F;
 Tue, 30 May 2023 18:39:44 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 506AAC154D1;
 Tue, 30 May 2023 18:39:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v2 00/20] Next round of migration atomic counters
Date: Tue, 30 May 2023 20:39:21 +0200
Message-Id: <20230530183941.7223-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi

On this v2:

- dropped qemu_fflush() assert for read only files (make Richard
  happy)

- Update documentation for qemu_file_transferred (make Fabiano happy)

- migration/rdma: Remove qemu_fopen_rdma() and make it look like
  everything else

- Simplify a couple of qemu-file functions, and unexport the ones that
  are not used outside of qemu-file.c

- Added Reviewed-by comments.

Please review.

Thanks, Juan.

[v1]
On this series:

- Make sure that qemu_file_transferred() make sense and its used
  coherently

- Use stat64 for qemu_file_transferred(), so we can call the function
  from any thread.

- Don't account for the same transfer twice (i.e. it is multifd_bytes,
  rdma_bytes or qemu_file_bytes) qemu_file_transferred() just sums all
  of them.

- Use this new counter for rate_limit()

- Remove old trasferred stat64 (now we use the real thing)

- Simplify qemu_file_get_error(): see where next cleanups are coming

- As an example, qemu_fflush() now return errors.

Please review.

Later, Juan.

Based-on: Message-Id: <20230530115429.1998-1-quintela@redhat.com>
Subject: [PULL 00/21] Migration 20230530 patches

Juan Quintela (20):
  qemu-file: Rename qemu_file_transferred_ fast -> noflush
  migration: Change qemu_file_transferred to noflush
  migration: Use qemu_file_transferred_noflush() for block migration.
  qemu-file: We only call qemu_file_transferred_* on the sending side
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
  migration/rdma: Split qemu_fopen_rdma() into input/output functions
  qemu-file: Remove unused qemu_file_mode_is_not_valid()
  qemu_file: Make qemu_file_is_writable() static
  qemu-file: Simplify qemu_file_shutdown()
  qemu-file: Make qemu_file_get_error_obj() static

 migration/migration-stats.h | 16 ++++-----
 migration/qemu-file.h       | 31 +++---------------
 migration/colo.c            | 11 ++-----
 migration/migration-stats.c | 10 +++---
 migration/migration.c       | 17 ++++------
 migration/multifd.c         |  3 --
 migration/qemu-file.c       | 65 ++++++++++---------------------------
 migration/ram.c             | 29 ++++++-----------
 migration/rdma.c            | 39 ++++++++++------------
 migration/savevm.c          |  7 ++--
 migration/vmstate.c         |  4 +--
 11 files changed, 73 insertions(+), 159 deletions(-)

-- 
2.40.1


