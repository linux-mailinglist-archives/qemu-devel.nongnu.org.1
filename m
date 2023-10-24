Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D822F7D4AA3
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:42:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvCy9-0003TP-6G; Tue, 24 Oct 2023 04:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qvCy6-0003H6-JK
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:40:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qvCy4-0003Fa-QZ
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698136851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dYSHqUz4DguFTNRdjg6UTGV1lG4vv86KS3CnoT5DbQQ=;
 b=Zpj6yK2hjDLNRsV58TIXUqrd04cqIbsq995TIgolklWOotbOicgiRoXMcxdB2IzB5/clk+
 3NRwO0OH8ce+WcCJFmaEeEsCEekUDLREr+XBbHxTuwpvqTCu3z5/XatgKPvCIBfCIEcRTF
 0fcNn2Vxp72Z1bAd6V0WQr65J8KdfIE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-7VSUHLQrOgCwCtCcMaE3FA-1; Tue, 24 Oct 2023 04:40:48 -0400
X-MC-Unique: 7VSUHLQrOgCwCtCcMaE3FA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9B2B3C170B6;
 Tue, 24 Oct 2023 08:40:47 +0000 (UTC)
Received: from localhost (unknown [10.39.208.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D75C8C0B;
 Tue, 24 Oct 2023 08:40:46 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 0/9] RFC: migration: check required entries and sections
 are loaded
Date: Tue, 24 Oct 2023 12:40:34 +0400
Message-ID: <20231024084043.2926316-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

v2:
 - add "migration: rename vmstate_save_needed->vmstate_section_needed"
 - add "migration: set file error on subsection loading"
 - add subsection tests
 - update the documentation

Marc-André Lureau (9):
  block/fdc: 'phase' is not needed on load
  virtio: make endian_needed() work during loading
  net/slirp: use different IDs for each instance
  migration: rename vmstate_save_needed->vmstate_section_needed
  migration: check required subsections are loaded, once
  migration: check required entries are loaded, once
  migration: set file error on subsection loading
  test-vmstate: add some subsection tests
  docs/migration: reflect the changes about needed subsections

 docs/devel/migration.rst    |  17 +++---
 include/migration/vmstate.h |   2 +-
 hw/block/fdc.c              |   5 ++
 hw/virtio/virtio.c          |   6 +-
 migration/savevm.c          |  45 +++++++++++++-
 migration/vmstate.c         |  45 ++++++++++++--
 net/slirp.c                 |   3 +-
 tests/unit/test-vmstate.c   | 116 ++++++++++++++++++++++++++++++++++++
 8 files changed, 222 insertions(+), 17 deletions(-)

-- 
2.41.0


