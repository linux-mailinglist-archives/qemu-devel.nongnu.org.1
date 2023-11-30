Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB787FED15
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 11:42:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8eTs-0006RV-7r; Thu, 30 Nov 2023 05:41:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r8eTo-0006Qw-Bx
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 05:41:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r8eTm-0005is-LU
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 05:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701340868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=X+ZJ8tfbh8EyWGPCpejjFqma6+m2szfWJ04/P0BKSzw=;
 b=XvJZt8Za+xCt+95oHvD7Fr5IA9lrQko9AO4tpIN2RR+ey8mCDYYSflraxn2GNX97yBUb9u
 cF5Wn1/fqC38wer9OMztI3nfVWxs9yHVBSOoY2IRKDGSthBmEexyN17E6AIw7HnJAYixG8
 b3y3GOnFOPpt4NG8YGx2zkjQ7vG4f4Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-Kg3IXEY2ORKGv_5jIbkUYw-1; Thu, 30 Nov 2023 05:41:06 -0500
X-MC-Unique: Kg3IXEY2ORKGv_5jIbkUYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B9E584AC62;
 Thu, 30 Nov 2023 10:41:06 +0000 (UTC)
Received: from secure.mitica1 (unknown [10.39.195.135])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21B402026D4C;
 Thu, 30 Nov 2023 10:41:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Subject: [PULL 0/2] Migration 20231130 patches
Date: Thu, 30 Nov 2023 11:41:01 +0100
Message-ID: <20231130104103.28672-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

The following changes since commit abf635ddfe3242df907f58967f3c1e6763bbca2d:

  Update version for v8.2.0-rc2 release (2023-11-28 16:31:16 -0500)

are available in the Git repository at:

  https://gitlab.com/juan.quintela/qemu.git tags/migration-20231130-pull-request

for you to fetch changes up to 41581265aa83127036e4f2d6417820f59276514b:

  migration: free 'saddr' since be no longer used (2023-11-30 09:51:24 +0100)

----------------------------------------------------------------
Migration Pull request (20231130)

Hi

In this pull request:
- fix form p-ioc set too soon
- free 'saddr' at the right time

Please, apply.

CI: https://gitlab.com/juan.quintela/qemu/-/pipelines/1090495323

----------------------------------------------------------------

Fabiano Rosas (1):
  migration/multifd: Stop setting p->ioc before connecting

Zongmin Zhou (1):
  migration: free 'saddr' since be no longer used

 migration/migration.c | 5 +++--
 migration/multifd.c   | 3 +--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.43.0


