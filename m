Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1358763812
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 15:51:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOe62-0000tQ-LI; Wed, 26 Jul 2023 08:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qOe5i-0000ly-0A
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:58:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qOe5e-0006nr-FT
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690376285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5rKMf2UvkhgRZrVLDJuI9GuM1SbRAXL1qdjOKWFhAqA=;
 b=eUdcKLc5XZI0ICm/jmYu3Igmc3pFmuqAtcFrS8LCvYFhNhIRSwEnkuk42sl7YsvK/UA/C7
 fB86oz/dpNuFkKKt6pccGpNNh5/cTUqtK6VaToyBIaGrAEuxgYs7Jffh+jP5jbSjpO4UKc
 IRGRJgkVnW0WAEcprgJdYMORqqiwQhs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-JGgopCe8PXqN-_bU9tUhjw-1; Wed, 26 Jul 2023 08:58:02 -0400
X-MC-Unique: JGgopCe8PXqN-_bU9tUhjw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3ACC2800159;
 Wed, 26 Jul 2023 12:58:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AC7A1121330;
 Wed, 26 Jul 2023 12:58:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EEC2821E668C; Wed, 26 Jul 2023 14:58:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL v2 0/5] QAPI patches patches for 2023-07-26
Date: Wed, 26 Jul 2023 14:57:55 +0200
Message-ID: <20230726125800.163430-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 6cb2011fedf8c4e7b66b4a3abd6b42c1bae99ce6:

  Update version for v8.1.0-rc1 release (2023-07-25 20:09:05 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2023-07-26-v2

for you to fetch changes up to 9e272073e1c41acb3ba1e43b69c7a3f9c26089c2:

  qapi: Reformat recent doc comments to conform to current conventions (2023-07-26 14:51:36 +0200)

----------------------------------------------------------------
QAPI patches patches for 2023-07-26

----------------------------------------------------------------
The patches affect only documentation.  Generated code does not change.

Markus Armbruster (5):
      qapi/block-core: Tidy up BlockLatencyHistogramInfo documentation
      qapi/block: Tidy up block-latency-histogram-set documentation
      qapi/qdev: Tidy up device_add documentation
      qapi/trace: Tidy up trace-event-get-state, -set-state documentation
      qapi: Reformat recent doc comments to conform to current conventions

 qapi/block-core.json     | 85 +++++++++++++++++++++++-------------------------
 qapi/block.json          | 12 +++----
 qapi/cxl.json            |  4 +--
 qapi/machine-target.json |  2 +-
 qapi/migration.json      | 10 +++---
 qapi/net.json            |  1 -
 qapi/qdev.json           |  6 ++--
 qapi/qom.json            |  9 ++---
 qapi/trace.json          |  9 ++---
 qapi/ui.json             |  2 +-
 10 files changed, 66 insertions(+), 74 deletions(-)

-- 
2.41.0


