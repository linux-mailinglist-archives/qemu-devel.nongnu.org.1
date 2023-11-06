Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 602937E2054
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:48:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxu9-0003Ki-Ce; Mon, 06 Nov 2023 06:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzxty-0003EB-6O
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:36:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzxtt-0003JM-4i
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699270572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mGxJHFb5AICNzjf5Ig6XWXn/70QRudd2NHYpSOFp0bM=;
 b=KfJCMWi0pyiXlZM5u/gowQTqwBL90MakQRyoezfiJgt4YbyZ7FKk4/oaRCeWU/vtKsz5o/
 P9DVA8htyJC+ZDrVQnf2cE3ETB6Sr+MtdR2wtzBHkqUD6Oqy8via5zuVsOrx6tJNFNSopj
 AAzlxnM6IB5Vo6iwTLaHmans8vlwvbI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-WL2Ck4FSOrCQiZ6IhxuNrQ-1; Mon,
 06 Nov 2023 06:36:06 -0500
X-MC-Unique: WL2Ck4FSOrCQiZ6IhxuNrQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CA7038130B0;
 Mon,  6 Nov 2023 11:36:06 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0AFFC1596F;
 Mon,  6 Nov 2023 11:36:04 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 0/6] migration: check required entries and sections are
 loaded
Date: Mon,  6 Nov 2023 15:35:54 +0400
Message-ID: <20231106113601.2052601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Hi,

Surprisingly, the migration code doesn't check that required migration entries
and subsections are loaded. Either optional or required sections are both
ignored when missing. According to the documentation a "newer QEMU that knows
about a subsection can (with care) load a stream from an older QEMU that didn't
send the subsection". I propose this behaviour to be limited to "optional"
sections only.

This series has a few preliminary fixes, add new checks that entries are
loaded once and required ones have been loaded, add some tests and
documentation update.

thanks

v3:
 - rebased, drop RFC status
 - switch from tracepoint + returning an error to report for missing
   subsections, as we worry about potential regressions
 - add r-b tags

v2:
 - add "migration: rename vmstate_save_needed->vmstate_section_needed"
 - add "migration: set file error on subsection loading"
 - add subsection tests
 - update the documentation

Marc-André Lureau (6):
  block/fdc: 'phase' is not needed on load
  virtio: make endian_needed() work during loading
  migration: check required subsections are loaded, once
  migration: check required entries are loaded, once
  test-vmstate: add some subsection tests
  docs/migration: reflect the changes about needed subsections

 docs/devel/migration.rst  |  17 +++---
 hw/block/fdc.c            |   5 ++
 hw/virtio/virtio.c        |   6 +-
 migration/savevm.c        |  43 ++++++++++++++
 migration/vmstate.c       |  40 ++++++++++++-
 tests/unit/test-vmstate.c | 116 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 215 insertions(+), 12 deletions(-)

-- 
2.41.0


