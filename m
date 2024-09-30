Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E670989D1F
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Sep 2024 10:45:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svC0f-0006pL-V7; Mon, 30 Sep 2024 04:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svC0c-0006eo-IN; Mon, 30 Sep 2024 04:43:58 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svC0a-0000tr-Fl; Mon, 30 Sep 2024 04:43:58 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:8a3:0:640:33b5:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 2930060DF1;
 Mon, 30 Sep 2024 11:43:48 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b737::1:2c])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id WhU2Sb1IXiE0-P7yEq2gG; Mon, 30 Sep 2024 11:43:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727685827;
 bh=mjrW9mv3SeuApEPDqObDjoIiWO3yn4I81I3kfVmogt0=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=sDHy/4O/U+74AkV5Q28wTkinkKfToXhSQpyaMOpUxRGmQuvPYUFvpWq52Z+SzLR33
 DszYzseG+k0UdxmDqnb5cQYkCUp43lDzRHau2s8deP3HKsE7iHd7vDgj+xMTeHqL0N
 oVVQIv1sczj7h1LdUg0Bw+g2CRKtvE/1YorRIXu4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru, peter.maydell@linaro.org
Subject: [PULL 0/5] Block-jobs 2024-09-30
Date: Mon, 30 Sep 2024 11:43:20 +0300
Message-Id: <20240930084325.187606-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUBJ_LACKS_WORDS=2.112 autolearn=no autolearn_force=no
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

The following changes since commit 3b14a767eaca3df5534a162851f04787b363670e:

  Merge tag 'qemu-openbios-20240924' of https://github.com/mcayland/qemu into staging (2024-09-28 12:34:44 +0100)

are available in the Git repository at:

  https://gitlab.com/vsementsov/qemu.git tags/pull-block-jobs-2024-09-30

for you to fetch changes up to b74987cd3bf9bd4bf452ed371d864cbd1dccb08e:

  util/co-shared-resource: Remove unused co_try_get_from_shres (2024-09-30 10:53:18 +0300)

----------------------------------------------------------------
Block-jobs: improve backup fleecing

----------------------------------------------------------------

Dr. David Alan Gilbert (2):
  block: Remove unused aio_task_pool_empty
  util/co-shared-resource: Remove unused co_try_get_from_shres

Fiona Ebner (3):
  copy-before-write: allow specifying minimum cluster size
  backup: add minimum cluster size to performance options
  block/reqlist: allow adding overlapping requests

 block/aio_task.c                  |  5 -----
 block/backup.c                    |  2 +-
 block/block-copy.c                | 36 ++++++++++++++++++++++---------
 block/copy-before-write.c         | 17 +++++++++++++--
 block/copy-before-write.h         |  1 +
 block/reqlist.c                   |  2 --
 blockdev.c                        |  3 +++
 include/block/aio_task.h          |  2 --
 include/block/block-copy.h        |  1 +
 include/qemu/co-shared-resource.h |  7 ------
 qapi/block-core.json              | 17 ++++++++++++---
 util/qemu-co-shared-resource.c    |  6 ------
 12 files changed, 61 insertions(+), 38 deletions(-)

-- 
2.34.1


