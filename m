Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3B9B51BEC
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Sep 2025 17:39:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwMtK-0001Qo-6R; Wed, 10 Sep 2025 11:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uwMtH-0001Py-C8
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 11:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uwMtF-0000qP-Kh
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 11:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757518664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4nfw8Dg+necFb49a8oUJ+CFJCd4KmdxQdsArjJs0b+Y=;
 b=AMPXRo6vNAhu1Ip46jaD3gU20Jo5ztSXU1pSIbGXJz/0nwX4Uhz0LX8OZUmE6VXqJzH6sy
 qvyOcW+g3TDqCwusrkxthelOdh/CkHlym7EfGmYYvb+uMaK4SARsC8XZsc/pvEvghhlxCN
 m15jVEmHPuo1yfllHVIeaZmOZ3ZJnkU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-GkuNJ0EpPsaSUk4caih0aQ-1; Wed,
 10 Sep 2025 11:37:41 -0400
X-MC-Unique: GkuNJ0EpPsaSUk4caih0aQ-1
X-Mimecast-MFC-AGG-ID: GkuNJ0EpPsaSUk4caih0aQ_1757518660
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4CD418002C1; Wed, 10 Sep 2025 15:37:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.173])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 20E2119560AB; Wed, 10 Sep 2025 15:37:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-block@nongnu.org,
	Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 0/3] tests/qemu-iotests: Improve test detection for meson
Date: Wed, 10 Sep 2025 17:37:23 +0200
Message-ID: <20250910153727.226217-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When running the test in thorough mode, we currently try to run a lot of
tests that are only skipped, which is somewhat annoying. This series
fixes the problems (see second patch), and add some more image formats
in the third patch (which should be fine now that the list of tests that
we try to execute is not that big anymore).

Thomas Huth (3):
  tests/qemu-iotests/184: Fix skip message for qemu-img without throttle
  tests/qemu-iotests: Improve the dry run list to speed up thorough
    testing
  tests/qemu-iotest: Add more image formats to the thorough testing

 tests/qemu-iotests/184         |  2 +-
 tests/qemu-iotests/check       | 35 +++++++++++++++++++++++++++++++---
 tests/qemu-iotests/meson.build |  3 +++
 3 files changed, 36 insertions(+), 4 deletions(-)

-- 
2.51.0


