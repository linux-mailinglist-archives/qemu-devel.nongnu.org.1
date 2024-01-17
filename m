Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E08830A6A
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 17:08:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ8Sc-0006ov-0F; Wed, 17 Jan 2024 11:08:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rQ8SN-0006UE-Km; Wed, 17 Jan 2024 11:08:00 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rQ8SI-0000GK-QG; Wed, 17 Jan 2024 11:07:59 -0500
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:62a3:0:640:1524:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C503761545;
 Wed, 17 Jan 2024 19:07:47 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b43a::1:2b])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id c7sSt20Ih8c0-wublryND; Wed, 17 Jan 2024 19:07:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1705507667;
 bh=EIePJOYxdiWMEG+aS2CmkyhGUrfgH7+8fCfdtbImNCc=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=xp8LmASNFmfW2yQyYEkBjW5s/+glyTdoOz+pBpWhk/KwnYNAPryyK7Q4ll5RmRE6e
 LA2nSaqPU9jlIodgrQEA5ta2U14DFMyZXRfh31Dt9QryuGd4DiQE0VCnRpDrwwJlGA
 JMtip8liKbZSTZvC14XXRdbJ3MobJmTKhx6rVMrY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, hreitz@redhat.com,
 kwolf@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 f.ebner@proxmox.com
Subject: [PATCH v2 0/4] backup: discard-source parameter
Date: Wed, 17 Jan 2024 19:07:33 +0300
Message-Id: <20240117160737.1057513-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

v2: - now, based on master
    - CBW permissions a bit reworked
    - clamp down length to discard (thanks to Fiona)
    - use modern vm.cmd() in test instead of vm.qmp()

Vladimir Sementsov-Ogievskiy (4):
  block/copy-before-write: fix permission
  block/copy-before-write: create block_copy bitmap in filter node
  qapi: blockdev-backup: add discard-source parameter
  iotests: add backup-discard-source

 block/backup.c                                |   5 +-
 block/block-copy.c                            |  15 +-
 block/copy-before-write.c                     |  12 +-
 block/replication.c                           |   4 +-
 blockdev.c                                    |   2 +-
 include/block/block-copy.h                    |   3 +-
 include/block/block_int-global-state.h        |   2 +-
 qapi/block-core.json                          |   4 +
 tests/qemu-iotests/257.out                    | 112 ++++++-------
 .../qemu-iotests/tests/backup-discard-source  | 151 ++++++++++++++++++
 .../tests/backup-discard-source.out           |   5 +
 11 files changed, 245 insertions(+), 70 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/backup-discard-source
 create mode 100644 tests/qemu-iotests/tests/backup-discard-source.out

-- 
2.34.1


