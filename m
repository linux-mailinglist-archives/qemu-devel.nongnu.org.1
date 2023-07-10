Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A08C74D78A
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 15:30:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIqwF-0005M8-6r; Mon, 10 Jul 2023 09:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qIqwD-0005Lj-4W
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:28:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qIqw8-000764-2V
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688995698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6KjAjaPn6pofPNjUnlskn8Fz+gA5ChGL2345Y82Sfac=;
 b=aS+WoI67O9qbFntoL3kbAyKdCxEZMxqwpZBRgfStU2ipGGsqk7ATb6h8X70F1iC/vGAl1Q
 iwq2yvwcDbCaPmy9KOmREcrlG0cOudscW0XnWhEJzRxVlc8QibIqHezUgA6wmMNy52Q0ml
 q+toZVkEwV+Bxis5q/ENF3tKUjHOP3U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-Lm-PT0-1M7qMdUKXx5-WUQ-1; Mon, 10 Jul 2023 09:28:15 -0400
X-MC-Unique: Lm-PT0-1M7qMdUKXx5-WUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 032AC185A7A2;
 Mon, 10 Jul 2023 13:28:14 +0000 (UTC)
Received: from kostyanf14nb.redhat.com (unknown [10.45.225.233])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E67FE111E3E4;
 Mon, 10 Jul 2023 13:28:12 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/7] Misc QGA patches 2023-07-10
Date: Mon, 10 Jul 2023 16:28:03 +0300
Message-Id: <20230710132810.1049912-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 2ff49e96accc8fd9a38e9abd16f0cfa0adab1605:

  Merge tag 'pull-tcg-20230709' of https://gitlab.com/rth7680/qemu into staging (2023-07-09 15:01:43 +0100)

are available in the Git repository at:

  https://github.com/kostyanf14/qemu.git tags/qga-pull-2023-07-10

for you to fetch changes up to 61df91b33caf646cd39f9879d4b190eab5b7201b:

  QGA VSS: Add log in functions begin/end (2023-07-10 15:54:40 +0300)

----------------------------------------------------------------
qga-pull-2023-07-10

----------------------------------------------------------------
Konstantin Kostiuk (7):
      qga: Rename ga_disable_not_allowed -> ga_disable_not_allowed_freeze
      qga: Add new option --allow-rpcs
      qga: Add tests for --allow-rpcs option
      QGA VSS: Add wrapper to send log to debugger and stderr
      QGA VSS: Replace 'fprintf(stderr' with qga_debug
      QGA VSS: Print error in err_set
      QGA VSS: Add log in functions begin/end

 docs/interop/qemu-ga.rst    |  5 +++
 qga/main.c                  | 91 ++++++++++++++++++++++++++++++++++++++++-----
 qga/vss-win32/install.cpp   | 47 ++++++++++++++++++++---
 qga/vss-win32/meson.build   |  2 +-
 qga/vss-win32/provider.cpp  |  3 ++
 qga/vss-win32/requester.cpp | 51 +++++++++++++++++++++----
 qga/vss-win32/vss-debug.cpp | 39 +++++++++++++++++++
 qga/vss-win32/vss-debug.h   | 25 +++++++++++++
 tests/unit/test-qga.c       | 31 +++++++++++++++
 9 files changed, 271 insertions(+), 23 deletions(-)
 create mode 100644 qga/vss-win32/vss-debug.cpp
 create mode 100644 qga/vss-win32/vss-debug.h

--
2.34.1


