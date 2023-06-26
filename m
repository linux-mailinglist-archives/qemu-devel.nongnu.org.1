Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DF473D961
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:16:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhN7-0004Dt-S2; Mon, 26 Jun 2023 04:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qDhMo-00044e-JT
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:14:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qDhMi-0000t7-GZ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687767266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mW5eYT6uQ0Ar551grQ9yIZvlpIhJoVIPae0j4+Z5PLQ=;
 b=cpQIilb7j57gc5/VJGdBa15rZF+q7OXFaU1WXUWxQ1KRWZZPyfeAl+SpjCpCmQzWcXvxrW
 cjT3LNzIzU7dJ+BUhyho5DwssVozAdwA3xkiF2hwTgPputtgg5Mmaa0G++kc8gB0GnSB1Y
 Ih+UI7PxPzAX2vh5HOy7Ns84cE4Iebo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-LIn7m7tHNTKP75kSXMU9kA-1; Mon, 26 Jun 2023 04:14:23 -0400
X-MC-Unique: LIn7m7tHNTKP75kSXMU9kA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06616858F1E;
 Mon, 26 Jun 2023 08:14:23 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E4A0492B01;
 Mon, 26 Jun 2023 08:14:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/9] Testing / CI patches
Date: Mon, 26 Jun 2023 10:14:06 +0200
Message-Id: <20230626081415.64615-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

The following changes since commit 79dbd910c9ea6ca38f8e1b2616b1e5e885b85bd3:

  Merge tag 'hppa-boot-reboot-fixes-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2023-06-25 08:58:49 +0200)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-06-26

for you to fetch changes up to b197ea8636a18b0e2968b00c3a392bfc641b51a0:

  tests/qtest/cxl-test: Clean up temporary directories after testing (2023-06-26 09:01:33 +0200)

----------------------------------------------------------------
* Improve gitlab-CI with regards to handling of stable staging branches
* Add msys2 gitlab-CI artifacts
* Minor qtest fixes

----------------------------------------------------------------
Daniel P. Berrangé (5):
      gitlab: centralize the container tag name
      gitlab: allow overriding name of the upstream repository
      gitlab: stable staging branches publish containers in a separate tag
      gitlab: avoid extra pipelines for tags and stable branches
      gitlab: support disabling job auto-run in upstream

Marc-André Lureau (2):
      gitlab-ci: grab msys2 meson-logs as artifacts
      gitlab-ci: add msys2 meson test to junit report

Milan Zamazal (1):
      tests/qtest: Fix a comment typo in vhost-user-test.c

Thomas Huth (1):
      tests/qtest/cxl-test: Clean up temporary directories after testing

 docs/devel/ci-jobs.rst.inc           | 11 +++++++
 tests/qtest/cxl-test.c               |  2 ++
 tests/qtest/vhost-user-test.c        |  2 +-
 .gitlab-ci.d/base.yml                | 63 ++++++++++++++++++++++++++++++++----
 .gitlab-ci.d/buildtest-template.yml  |  4 +--
 .gitlab-ci.d/buildtest.yml           |  4 +--
 .gitlab-ci.d/container-template.yml  |  3 +-
 .gitlab-ci.d/crossbuild-template.yml |  6 ++--
 .gitlab-ci.d/static_checks.yml       |  4 +--
 .gitlab-ci.d/windows.yml             | 15 ++++++---
 10 files changed, 92 insertions(+), 22 deletions(-)


