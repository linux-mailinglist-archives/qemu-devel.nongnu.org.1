Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C047C839D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 12:48:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrFht-0003Rm-BS; Fri, 13 Oct 2023 06:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qrFhr-0003Q4-S6
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:47:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qrFhq-0006xI-0s
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697194065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g9FRjsfckXYkV1Zczqrd9c9o/Mh6xt96qquBhJcAjyk=;
 b=HttwO2y3Uw0tJcLQVROFY3FMC1JrHhGOrVOvVNVFp7Id4a6N/33GbszzsCs0TEQ4eE0SiE
 yJevKSu1A4u8VxYJ6zz644uAw2h1O6/GmipQHvNZbV6SW+Ntxwt3RajT9utxpqQq2miYyl
 E1sZIRwPQc8Po7+9ZjWe0wiS6g/g7ks=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-G8WGDMhBPQO_1qN-ySz1KA-1; Fri, 13 Oct 2023 06:47:41 -0400
X-MC-Unique: G8WGDMhBPQO_1qN-ySz1KA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56E561029F4A;
 Fri, 13 Oct 2023 10:47:41 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6B2D2157F5A;
 Fri, 13 Oct 2023 10:47:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, libvir-list@redhat.com,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH v4 00/10] Migration deprecated parts
Date: Fri, 13 Oct 2023 12:47:26 +0200
Message-ID: <20231013104736.31722-1-quintela@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On this v4:
- addressed all markus comments.
- rebased on latest.
- improve formatting of migration.json
- print block migration status when needed.
- patches 7-10 are not mean to merge, they just show why we want to
  deprecate block migration and remove its support.
- Patch 7 just drop support for -i/-b and qmp equivalents.
- Patch 8 shows all the helpers and convolutions we need to have to
  support that -i and -d.
- patch 9 drops block-incremental migration support.
- patch 9 drops block migration support.

Please review.

Thanks, Juan.

On this v3:

- Rebase on top of upstream.
- Changed v8.1 to 8.2 (I left the reviewed by anyways)
- missing the block deprecation code, please.

Please, review.

Later, Juan.

On this v2:

- dropped -incoming <uri> deprecation
  Paolo came with a better solution using keyvalues.

- skipped field is already ready for next pull request, so dropped.

- dropped the RFC bits, nermal PATCH.

- Assessed all the review comments.

- Added indentation of migration.json.

- Used the documentation pointer to substitute block migration.

Please review.

[v1]
Hi this series describe the migration parts that have to be deprecated.

- It is an rfc because I doubt that I did the deprecation process right. Hello Markus O:-)

- skipped field: It is older than me, I have never know what it stands
  for.  As far as I know it has always been zero.

- inc/blk migrate command options.  They are only used by block
  migration (that I deprecate on the following patch).  And they are really bad.
  grep must_remove_block_options.

- block migration.  block jobs, whatever they are called this week are
  way more flexible.  Current code works, but we broke it here and
  there, and really nobody has stand up to maintain it.  It is quite
  contained and can be left there.  Is anyone really using it?

- old compression method.  It don't work.  See last try from Lukas to
  make a test that works reliabely.  I failed with the same task years
  ago.  It is really slow, and if compression is good for you, multifd
  + zlib is going to perform/compress way more.

  I don't know what to do with this code, really.

  * Remove it for this release?  It don't work, and haven't work
    reliabely in quite a few time.

  * Deprecate it and remove in another couple of releases, i.e. normal
    deprecation.

  * Ideas?

- -incoming <uri>

  if you need to set parameters (multifd cames to mind, and preempt has
  the same problem), you really needs to use defer.  So what should we do here?

  This part is not urget, because management apps have a working
  option that are already using "defer", and the code simplifacation
  if we remove it is not so big.  So we can leave it until 9.0 or
  whatever we think fit.

What do you think?

Later, Juan.

Juan Quintela (10):
  migration: Improve json and formatting
  migration: Print block status when needed
  migration: migrate 'inc' command option is deprecated.
  migration: migrate 'blk' command option is deprecated.
  migration: Deprecate block migration
  migration: Deprecate old compression method
  [RFC] migration: Make -i/-b an error for hmp and qmp
  [RFC] migration: Remove helpers needed for -i/-b migrate options
  [RFC] migration: Remove support for block_incremental
  [RFC] migration: Remove block migration support

 docs/about/deprecated.rst      |   25 +
 meson.build                    |    2 -
 qapi/migration.json            |  133 ++---
 include/migration/misc.h       |    8 -
 migration/block.h              |   52 --
 migration/migration.h          |    4 -
 migration/options.h            |    8 -
 migration/block.c              | 1027 --------------------------------
 migration/colo.c               |    1 -
 migration/migration-hmp-cmds.c |   40 +-
 migration/migration.c          |   47 +-
 migration/options.c            |   89 +--
 migration/ram.c                |   16 -
 migration/savevm.c             |    5 -
 hmp-commands.hx                |   17 +-
 migration/meson.build          |    3 -
 16 files changed, 111 insertions(+), 1366 deletions(-)
 delete mode 100644 migration/block.h
 delete mode 100644 migration/block.c

-- 
2.41.0


