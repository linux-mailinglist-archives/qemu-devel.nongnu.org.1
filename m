Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB749BE56C
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Nov 2024 12:20:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8e48-0002fx-9Q; Wed, 06 Nov 2024 06:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1t8e46-0002eV-13; Wed, 06 Nov 2024 06:19:10 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1t8e42-0008FC-Te; Wed, 06 Nov 2024 06:19:09 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:94a7:0:640:198e:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 2A79B60A73;
 Wed,  6 Nov 2024 14:18:59 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b49f::1:6])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id dIfYi50AYGk0-7R1XuHZI; Wed, 06 Nov 2024 14:18:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1730891938;
 bh=Vx+rwqimFZzTRzPtamHYX4LVemyTrcDB6qLZnGhVPsU=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=DClmWcZSeMqZwvA81AcOFt+79+6wgit135JMSEQa2dHEx/T8MxNIbXADA3BUR7OsP
 z1ASsududbhvF7J9j3qlzlRYcRtMUsM056L+TICcdSvYeP2ee6JwUifMZIOd9lBEV7
 /qiJuGRXDIQY1wDJ0a4DaR6EtOEY60H6fnwu2KHg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org,
	raphael@enfabrica.net,
	mst@redhat.com
Cc: sgarzare@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v7 0/3] vhost-user-blk: live resize additional APIs
Date: Wed,  6 Nov 2024 14:18:34 +0300
Message-Id: <20241106111837.115820-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v7: update QAPI version 9.1 -> 9.2

Vladimir Sementsov-Ogievskiy (3):
  qdev-monitor: add option to report GenericError from find_device_state
  vhost-user-blk: split vhost_user_blk_sync_config()
  qapi: introduce device-sync-config

 hw/block/vhost-user-blk.c | 27 ++++++++++++++------
 hw/virtio/virtio-pci.c    |  9 +++++++
 include/hw/qdev-core.h    |  6 +++++
 qapi/qdev.json            | 24 ++++++++++++++++++
 system/qdev-monitor.c     | 53 ++++++++++++++++++++++++++++++++++++---
 5 files changed, 108 insertions(+), 11 deletions(-)

-- 
2.34.1


