Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AE875A790
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 09:17:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMNtk-0000qD-6r; Thu, 20 Jul 2023 03:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qMNtY-0000fS-EY
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 03:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qMNtW-0007Ug-Sp
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 03:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689837373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mLQPiQbIlSzmjlhzkrdPCwfrFqhIwkEwOHQrRGmB9oM=;
 b=HVY1ViMPK1NNUZsjguJ/bmEHBgK2w6AC31sbXsR2f1ZTPJqIbBgfTWyGlZi7OwlQW/NfNZ
 0f2vYv9IL0tHIprhBcGS0RKz4JfnbJmBc5jQ4Pavp56P+aOSTQOBFWoDyRohO3v3TTsNn3
 a4RVNd1iB41kSpYWhXvHVzT2DCykY8Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-pAMc26K5NUK6In1YQbwDww-1; Thu, 20 Jul 2023 03:16:11 -0400
X-MC-Unique: pAMc26K5NUK6In1YQbwDww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E014936D2E
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 07:16:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D24FF77AD
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 07:16:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 065E521E6608; Thu, 20 Jul 2023 09:16:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com
Subject: [PATCH 0/6] qapi: Tidy up doc comments
Date: Thu, 20 Jul 2023 09:16:03 +0200
Message-ID: <20230720071610.1096458-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

This series only affects generated documentation.  Generated code does
not change.  Would be nice to get it into the release.

Markus Armbruster (6):
  qapi/block-core: Tidy up BlockLatencyHistogramInfo documentation
  qapi/block: Tidy up block-latency-histogram-set documentation
  qapi/qdev: Tidy up device_add documentation
  qapi/trace: Tidy up trace-event-get-state, -set-state documentation
  qapi: Correct "eg." to "e.g." in documentation
  qapi: Reformat recent doc comments to conform to current conventions

 qapi/block-core.json     | 85 +++++++++++++++++++---------------------
 qapi/block.json          | 12 +++---
 qapi/char.json           |  2 +-
 qapi/cxl.json            |  4 +-
 qapi/machine-target.json |  2 +-
 qapi/migration.json      | 10 ++---
 qapi/misc.json           |  2 +-
 qapi/net.json            |  1 -
 qapi/qdev.json           |  6 +--
 qapi/qom.json            |  9 +++--
 qapi/trace.json          |  9 ++---
 qapi/ui.json             |  2 +-
 12 files changed, 68 insertions(+), 76 deletions(-)

-- 
2.41.0


