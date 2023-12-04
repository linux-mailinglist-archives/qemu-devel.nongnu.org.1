Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F99A803690
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 15:27:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA9tH-0000j5-Bo; Mon, 04 Dec 2023 09:25:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rA9tE-0000iR-5i
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:25:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rA9tC-0003Ht-FB
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:25:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701699936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JMdEzXSnnsObBabRp1uzb9tTeddCGpIyo/d+CTegB1U=;
 b=cdwGawgfehX53Onbg/Uf5TAZsE2+IBnlJcYWBBs3eXA2aQSzrdnN0F9C1R2eoOE+wovISl
 MtA6eQxCqNj+EAqH6eaJOMXesKnvQgls6rUvHlIyZYiwRCOAeJLFPYqZkLDxFc9A74ifk8
 ACZkMtF+kYphcGwaitAIlGCVXqJ9+Fc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-N4lKnKBoPA63AyZJtYVoDA-1; Mon, 04 Dec 2023 09:25:34 -0500
X-MC-Unique: N4lKnKBoPA63AyZJtYVoDA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CA73101A550
 for <qemu-devel@nongnu.org>; Mon,  4 Dec 2023 14:25:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05F722166B26;
 Mon,  4 Dec 2023 14:25:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/3] Misc patches for QEMU 8.2-rc3
Date: Mon,  4 Dec 2023 15:25:29 +0100
Message-ID: <20231204142532.581730-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 29b5d70cb70574b499517ec9e9f80dea496a3cc0:

  Merge tag 'pull-ppc-for-8.2-20231130' of https://gitlab.com/npiggin/qemu into staging (2023-12-01 07:29:52 -0500)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-12-04

for you to fetch changes up to 4d98618b8a657f1ce361d90e0eade759af912b98:

  tests/qtest: check the return value (2023-12-04 15:12:57 +0100)

----------------------------------------------------------------
* Fix wording in iotest 149
* Fix whitespace issues in sh4 code (ignore checkpatch.pl warnings here)
* Make sure to check return values in qtests

----------------------------------------------------------------
Thomas Huth (1):
      tests/qemu-iotests/149: Use more inclusive language in this test

Yihuan Pan (1):
      sh4: Coding style: Remove tabs

Zhu Jun (1):
      tests/qtest: check the return value

 linux-user/sh4/termbits.h            |  204 ++---
 target/sh4/cpu.h                     |   80 +-
 target/sh4/helper.c                  |  236 +++---
 target/sh4/op_helper.c               |   70 +-
 target/sh4/translate.c               | 1466 +++++++++++++++++-----------------
 tests/qtest/test-filter-mirror.c     |    1 +
 tests/qtest/test-filter-redirector.c |    2 +
 tests/qtest/virtio-net-test.c        |    1 +
 tests/qemu-iotests/149               |   16 +-
 tests/qemu-iotests/149.out           |    8 +-
 10 files changed, 1045 insertions(+), 1039 deletions(-)


