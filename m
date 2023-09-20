Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C75797A8BE0
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:33:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj202-0005O6-MQ; Wed, 20 Sep 2023 14:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qj1za-0005KL-1r
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:32:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qj1zW-0002vd-4U
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695234718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xM3wAYFzQP3gxuYWUEVSWgPQWfxSd8/nVZzQqU4x75o=;
 b=Y3E7aIrilx7q/ERZDgYhSbJzPs3VvpL+k0op4VGuS2d5hDsSe/8gvghyuJzKe3lyk4MjaM
 w2p/ujbhV8y24dG+0GVb/dbAIGTdgvMUnLdt/8lPYQjYfWMFJMTlnZUJu1tzjmHR+XLBzQ
 RbVgi+WihKrjOTZJnuPLhHZDlGoeXho=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-xMfiEogbMbSUk9DdrqY6Qw-1; Wed, 20 Sep 2023 14:31:52 -0400
X-MC-Unique: xMfiEogbMbSUk9DdrqY6Qw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54CE91C09A47;
 Wed, 20 Sep 2023 18:31:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5ECE2711282;
 Wed, 20 Sep 2023 18:31:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3207221E6900; Wed, 20 Sep 2023 20:31:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, idryomov@gmail.com,
 pl@kamp.de, sw@weilnetz.de, sstabellini@kernel.org,
 anthony.perard@citrix.com, paul@xen.org, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, stefanha@redhat.com, fam@euphon.net,
 quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 kraxel@redhat.com, qemu-block@nongnu.org, xen-devel@lists.xenproject.org,
 alex.bennee@linaro.org, peter.maydell@linaro.org
Subject: [PATCH v2 0/7] Steps towards enabling -Wshadow=local
Date: Wed, 20 Sep 2023 20:31:42 +0200
Message-ID: <20230920183149.1105333-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Local variables shadowing other local variables or parameters make the
code needlessly hard to understand.  Bugs love to hide in such code.
Evidence: PATCH 1.

Enabling -Wshadow would prevent bugs like this one.  But we'd have to
clean up all the offenders first.  We got a lot of them.

Enabling -Wshadow=local should be less work for almost as much gain.
I took a stab at it.  There's a small, exciting part, and a large,
boring part.

The exciting part is dark preprocessor sorcery to let us nest macro
calls without shadowing: PATCH 7.

The boring part is cleaning up all the other warnings.  I did some
[PATCH 2-6], but ran out of steam long before finishing the job.  Some
160 unique warnings remain.

To see them, enable -Wshadow=local like so:

diff --git a/meson.build b/meson.build
index 98e68ef0b1..9fc4c7ac9d 100644
--- a/meson.build
+++ b/meson.build
@@ -466,6 +466,9 @@ warn_flags = [
   '-Wno-tautological-type-limit-compare',
   '-Wno-psabi',
   '-Wno-gnu-variable-sized-type-not-at-end',
+  '-Wshadow=local',
+  '-Wno-error=shadow=local',
+  '-Wno-error=shadow=compatible-local',
 ]
 
 if targetos != 'darwin'

You may want to drop the -Wno-error lines.

v2:
* PATCH 3+6: Mollify checkpatch
* PATCH 4: Redo for clearer code, R-bys dropped [Kevin]
* PATCH 5: Rename tweaked [Kevin]
* PATCH 6: Rename local @tran instead of the parameter [Kevin]
* PATCH 7: Drop PASTE(), use glue() instead [Richard]; pass
  identifiers instead of __COUNTER__ for readability [Eric]; add
  comments

Markus Armbruster (7):
  migration/rdma: Fix save_page method to fail on polling error
  migration: Clean up local variable shadowing
  ui: Clean up local variable shadowing
  block/dirty-bitmap: Clean up local variable shadowing
  block/vdi: Clean up local variable shadowing
  block: Clean up local variable shadowing
  qobject atomics osdep: Make a few macros more hygienic

 include/qapi/qmp/qobject.h      | 11 +++++++++--
 include/qemu/atomic.h           | 17 +++++++++++-----
 include/qemu/compiler.h         |  3 +++
 include/qemu/osdep.h            | 31 +++++++++++++++++++++--------
 block.c                         |  9 +++++----
 block/monitor/bitmap-qmp-cmds.c | 19 +++++++++---------
 block/qcow2-bitmap.c            |  3 +--
 block/rbd.c                     |  2 +-
 block/stream.c                  |  1 -
 block/vdi.c                     |  7 +++----
 block/vvfat.c                   | 35 +++++++++++++++++----------------
 hw/block/xen-block.c            |  6 +++---
 migration/block.c               |  4 ++--
 migration/ram.c                 |  8 +++-----
 migration/rdma.c                | 14 ++++++++-----
 migration/vmstate.c             |  2 +-
 ui/gtk.c                        | 14 ++++++-------
 ui/spice-display.c              |  9 +++++----
 ui/vnc-palette.c                |  2 --
 ui/vnc.c                        | 12 +++++------
 ui/vnc-enc-zrle.c.inc           |  9 ++++-----
 21 files changed, 125 insertions(+), 93 deletions(-)

-- 
2.41.0


