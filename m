Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 184027D93F2
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:39:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJHL-0002Kv-5a; Fri, 27 Oct 2023 05:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJHI-0002KX-Ai
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:37:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJHG-0002j3-Lr
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698399433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OjG7l/pYyFvPC1cc9B+grqnMNAzQRXnQq9khfGnHxSs=;
 b=XiLFadItdSZIuXIjGhzdKVjav8fcBD9FvY4Em4OV7TsapkLQz1kSf2db+iOjbbgkGLQrj7
 Y9rYfZl6zQDKwR8TRpRroi4Yh54pDLGBtUxewZ+CMYT/dMESqmE7uIealDC+9nSa/zid//
 EVGW94KxlWVTGB5ZR/ePz1bncHyxhYM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-DT9I8af6MHq_cGTNHNn0_w-1; Fri, 27 Oct 2023 05:37:12 -0400
X-MC-Unique: DT9I8af6MHq_cGTNHNn0_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8F7488D70B
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 09:37:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 383671121319;
 Fri, 27 Oct 2023 09:37:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 00/11] testing patches (+ 1 deprecation patch)
Date: Fri, 27 Oct 2023 11:36:59 +0200
Message-ID: <20231027093710.273558-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

The following changes since commit a95260486aa7e78d7c7194eba65cf03311ad94ad:

  Merge tag 'pull-tcg-20231023' of https://gitlab.com/rth7680/qemu into staging (2023-10-23 14:45:46 -0700)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-10-27

for you to fetch changes up to 1aa84a4b6e2cd3f0969101f1e608415e5381d9a2:

  ipmi-bt-test: force ipv4 (2023-10-27 10:13:17 +0200)

----------------------------------------------------------------
* Fix global variable shadowing in test code
* Avoid recompiling libfdt in the FreeBSD VM
* Mark old pc machine types as deprecated
* Force IPv4 in the ipmi-bt-test

----------------------------------------------------------------
Philippe Mathieu-Daudé (8):
      system/qtest: Clean up global variable shadowing in qtest_server_init()
      tests/throttle: Clean up global variable shadowing
      tests/virtio-scsi: Clean up global variable shadowing
      tests/cdrom-test: Clean up global variable shadowing in prepare_image()
      tests/rtl8139: Clean up global variable shadowing
      tests/npcm7xx_adc: Clean up global variable shadowing
      tests/aio: Clean up global variable shadowing
      tests/coroutine: Clean up global variable shadowing

Thomas Huth (2):
      docs/about: Mark the old pc-i440fx-2.0 - 2.3 machine types as deprecated
      tests/vm/freebsd: Add additional library paths for libfdt

Vladimir Sementsov-Ogievskiy (1):
      ipmi-bt-test: force ipv4

 docs/about/deprecated.rst      |  8 ++++++++
 hw/i386/pc_piix.c              |  1 +
 system/qtest.c                 | 16 ++++++++--------
 tests/qtest/cdrom-test.c       |  6 +++---
 tests/qtest/ipmi-bt-test.c     |  2 +-
 tests/qtest/npcm7xx_adc-test.c | 14 +++++++-------
 tests/qtest/rtl8139-test.c     | 12 ++++++------
 tests/qtest/virtio-scsi-test.c |  2 +-
 tests/unit/test-aio.c          |  4 ++--
 tests/unit/test-coroutine.c    | 12 ++++++------
 tests/unit/test-throttle.c     |  1 -
 tests/vm/freebsd               |  5 +++--
 12 files changed, 46 insertions(+), 37 deletions(-)


