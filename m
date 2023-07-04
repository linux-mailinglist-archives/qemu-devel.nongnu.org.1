Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB62A746A71
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 09:18:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGaHj-0000Qv-U9; Tue, 04 Jul 2023 03:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGaHa-0000PG-EA
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGaHY-0006hI-6B
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688455021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=g0FVJ1TWbpPLgDc0stX56aeSx5kL2ZU/GiVhSMlLTxc=;
 b=PjTzX7E8sI2m3dMOkwfShAS06En6v2vGc+0WoInnzd9/jYw+nxFP6ub0Hy5juaukvOGxRQ
 1KH/ZJAUGg6roAFmiE4fHwV1m4jflPKpG5YG5QHRKjTwGQLSYW/VVtNOAOsMhKNk92HS3W
 ugijseN523l06sUbwagg9BTI2Yyo/Vs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-kZJMeCCeN7-icly7BUllbg-1; Tue, 04 Jul 2023 03:16:59 -0400
X-MC-Unique: kZJMeCCeN7-icly7BUllbg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1177E858EED
 for <qemu-devel@nongnu.org>; Tue,  4 Jul 2023 07:16:59 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9EF62014E17;
 Tue,  4 Jul 2023 07:16:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/3] Test the docs/config/q35-*.cfg config files
Date: Tue,  4 Jul 2023 09:16:52 +0200
Message-Id: <20230704071655.75381-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

With some tweaking (e.g. by creating temporary image files), we
can check whether the docs/config/q35-*.cfg files can be loaded
by QEMU successfully, so we can avoid that these files bitrot
and avoid that our config file parser gets regressions.

Thomas Huth (3):
  tests/qtest/readconfig-test: Allow testing for arbitrary memory sizes
  tests/qtest: Move mkimg() and have_qemu_img() from libqos to libqtest
  tests/qtest/readconfig: Test the docs/config/q35-*.cfg files

 tests/qtest/libqos/libqos.h   |   2 -
 tests/qtest/libqtest.h        |  20 ++++
 tests/qtest/libqos/libqos.c   |  49 +-------
 tests/qtest/libqtest.c        |  52 +++++++++
 tests/qtest/readconfig-test.c | 204 +++++++++++++++++++++++++++++++++-
 5 files changed, 273 insertions(+), 54 deletions(-)

-- 
2.39.3


