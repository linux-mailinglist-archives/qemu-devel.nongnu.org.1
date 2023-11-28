Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D05247FBC48
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 15:10:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7ymS-0002IH-IT; Tue, 28 Nov 2023 09:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r7ymO-0002HX-5I
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:09:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r7ymM-0006TC-CI
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:09:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701180573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=suxL4UJkVW4VVz9E5xpldzyMrVw6dqhJgura48Wxb9o=;
 b=LvboNJLMmoq7nW63zal2YfoDANnnyyeXeleBv3kyMYtTl+uH3haGFqRyiZQ/PWMrhTPTNG
 Bo/PmUoH50DRUz0LgOeD2ldrtC78RSyvg5uWSZjB4Ne08Aw1olfrGUDlwYdH0alRYgbLPb
 Op0T3T3f8Wqp7Hc4aTDTDUuKEE4iigg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-ZNEWE2z6ONSpyD4nmqdvUg-1; Tue,
 28 Nov 2023 09:09:31 -0500
X-MC-Unique: ZNEWE2z6ONSpyD4nmqdvUg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E229D2824775;
 Tue, 28 Nov 2023 14:09:30 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.195.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34427502A;
 Tue, 28 Nov 2023 14:09:30 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 0/4] Block layer patches
Date: Tue, 28 Nov 2023 15:09:22 +0100
Message-ID: <20231128140926.106077-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

The following changes since commit e867b01cd6658a64c16052117dbb18093a2f9772:

  Merge tag 'qga-pull-2023-11-25' of https://github.com/kostyanf14/qemu into staging (2023-11-27 08:59:00 -0500)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 6e081324facf9aeece9c286774bab5af3b8d6099:

  ide/via: Fix BAR4 value in legacy mode (2023-11-28 14:56:32 +0100)

----------------------------------------------------------------
Block layer patches

- ide/via: Fix BAR4 value in legacy mode
- export/vhost-user-blk: Fix consecutive drains
- vmdk: Don't corrupt desc file in vmdk_write_cid
- iotests: fix default machine type detection

----------------------------------------------------------------
Andrey Drobyshev (1):
      iotests: fix default machine type detection

BALATON Zoltan (1):
      ide/via: Fix BAR4 value in legacy mode

Fam Zheng (1):
      vmdk: Don't corrupt desc file in vmdk_write_cid

Kevin Wolf (1):
      export/vhost-user-blk: Fix consecutive drains

 include/qemu/vhost-user-server.h     |  1 +
 block/export/vhost-user-blk-server.c |  9 +++++++--
 block/vmdk.c                         | 28 ++++++++++++++++++--------
 hw/ide/via.c                         | 17 ++++++++++------
 util/vhost-user-server.c             | 39 ++++++++++++++++++++++++++++--------
 tests/qemu-iotests/testenv.py        |  2 +-
 tests/qemu-iotests/059               |  2 ++
 tests/qemu-iotests/059.out           |  4 ++++
 8 files changed, 77 insertions(+), 25 deletions(-)


