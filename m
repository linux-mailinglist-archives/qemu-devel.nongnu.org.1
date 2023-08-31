Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B9978F333
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 21:18:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbnAk-00005s-J3; Thu, 31 Aug 2023 15:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qbnAd-000051-72
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 15:17:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qbnAY-0001wA-RB
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 15:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693509448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fr+UBYSdevTt7GC7p48pGuPxNMrGIMreTzLXQfi3VEQ=;
 b=h0O565xfSZyBQvxnRl5dloo3HtS59IBKTaHgKpOa0zcThq/imFoqAEPch6oK1Wq9WoiO4W
 8N6TMhLpbC/V29J3gsXHlmhyShpXuZHG3nZk8YpRB/Jd2z0oB7mjQSzU21OD5kw68tg2R/
 t8CpcXgBIJdqNRRqrwfJikakNlDxXPE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-bIZRPM40PRGMplaiu2tofw-1; Thu, 31 Aug 2023 15:17:24 -0400
X-MC-Unique: bIZRPM40PRGMplaiu2tofw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F4A0858EED
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:17:24 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5564163F78;
 Thu, 31 Aug 2023 19:17:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/7] s390x and qtest patches
Date: Thu, 31 Aug 2023 21:17:12 +0200
Message-Id: <20230831191719.140001-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

The following changes since commit 17780edd81d27fcfdb7a802efc870a99788bd2fc:

  Merge tag 'quick-fix-pull-request' of https://gitlab.com/bsdimp/qemu into staging (2023-08-31 10:06:29 -0400)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-08-31

for you to fetch changes up to 03b8a71e8459c9dfdafdb6fde673827eb17a89a2:

  meson: test for CONFIG_TCG in config_all (2023-08-31 19:10:02 +0200)

----------------------------------------------------------------
* Use precise selfmodifying code mode on s390x TCG
* Check for availablility of more devices in qtests before using them
* Some other minor qtest fixes

----------------------------------------------------------------
Ilya Leoshkevich (2):
      target/s390x: Define TARGET_HAS_PRECISE_SMC
      tests/tcg/s390x: Test precise self-modifying code handling

Paolo Bonzini (1):
      meson: test for CONFIG_TCG in config_all

Peter Maydell (1):
      tests/qtest/netdev-socket: Avoid variable-length array in inet_get_free_port_multiple()

Thomas Huth (3):
      tests/qtest/usb-hcd-xhci-test: Check availability of devices before using them
      tests/qtest/bios-tables-test: Check for virtio-iommu device before using it
      subprojects/berkeley-testfloat-3: Update to fix a problem with compiler warnings

 target/s390x/cpu.h                      |  2 ++
 tests/qtest/bios-tables-test.c          |  8 +++--
 tests/qtest/netdev-socket.c             |  2 +-
 tests/qtest/usb-hcd-xhci-test.c         |  8 +++--
 tests/tcg/s390x/precise-smc-user.c      | 39 ++++++++++++++++++++
 subprojects/berkeley-testfloat-3.wrap   |  2 +-
 tests/qtest/meson.build                 |  4 +--
 tests/tcg/s390x/Makefile.softmmu-target |  1 +
 tests/tcg/s390x/Makefile.target         |  1 +
 tests/tcg/s390x/precise-smc-softmmu.S   | 63 +++++++++++++++++++++++++++++++++
 10 files changed, 122 insertions(+), 8 deletions(-)
 create mode 100644 tests/tcg/s390x/precise-smc-user.c
 create mode 100644 tests/tcg/s390x/precise-smc-softmmu.S


