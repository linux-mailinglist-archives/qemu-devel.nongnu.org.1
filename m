Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3719D7AD40F
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 11:02:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkhTH-0002MT-K2; Mon, 25 Sep 2023 05:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qkhSm-000252-O8
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 05:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qkhSj-0002ZO-FK
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 05:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695632464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3izSqW5HTKiXDe4f8pLJ+A0dK2cL5UnHI8of2Nw/jWE=;
 b=E1M2YSZ6Rf7JLVtWXM2Y1xaBPYpxP6zq6HdTFWV30AzB7xWshK6+MwZryIB3PS3WbkoXix
 8zd2M+JP5DjahDFuONMHyAUxe24+ILqqHF7D11I3E+w6dH90JzpthMOs/y2o384yYN2DR1
 eTgTDyXi9UQ5MCFGQNUpU7l+4PYlVSo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-xXH9AK-wOZCTwi2CCIfltw-1; Mon, 25 Sep 2023 05:01:02 -0400
X-MC-Unique: xXH9AK-wOZCTwi2CCIfltw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E1EA85A5BA
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 09:01:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C129140E953;
 Mon, 25 Sep 2023 09:01:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/7] qtest and misc patches
Date: Mon, 25 Sep 2023 11:00:53 +0200
Message-ID: <20230925090100.45632-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

 Hi Stefan!

The following changes since commit b55e4b9c0525560577384adfc6d30eb0daa8d7be:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2023-09-21 09:32:47 -0400)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-09-25

for you to fetch changes up to b821109583a035a17fa5b89c0ebd8917d09cc82d:

  tests/avocado: fix waiting for vm shutdown in replay_linux (2023-09-25 08:02:23 +0200)

----------------------------------------------------------------
* Make keyutils independent from keyring in meson.build
* Simplify the NIC init code of the jazz machine a little bit
* Minor qtest and avocado fixes

----------------------------------------------------------------
Pavel Dovgalyuk (1):
      tests/avocado: fix waiting for vm shutdown in replay_linux

Philippe Mathieu-Daudé (1):
      tests/qtest/netdev-socket: Do not test multicast on Darwin

Stefan Hajnoczi (1):
      tests/qtest/netdev-socket: Raise connection timeout to 120 seconds

Thomas Huth (4):
      meson.build: Make keyutils independent from keyring
      tests/qtest/m48t59-test: Silence compiler warning with -Wshadow
      hw/mips/jazz: Move the NIC init code into a separate function
      hw/mips/jazz: Simplify the NIC setup code

 meson.build                   |  6 ++--
 hw/mips/jazz.c                | 81 +++++++++++++++++++++----------------------
 tests/qtest/m48t59-test.c     | 12 +++----
 tests/qtest/netdev-socket.c   |  8 +++--
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 ++
 tests/avocado/replay_linux.py |  2 +-
 7 files changed, 60 insertions(+), 54 deletions(-)


