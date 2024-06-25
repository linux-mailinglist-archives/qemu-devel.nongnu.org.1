Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB33916772
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jun 2024 14:20:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM58m-0003Ic-J6; Tue, 25 Jun 2024 08:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sM58g-0003Gw-Hw; Tue, 25 Jun 2024 08:19:10 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sM58c-0006eD-A8; Tue, 25 Jun 2024 08:19:10 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 2C63B6115C;
 Tue, 25 Jun 2024 15:19:00 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jIOnbJ0r9iE0-teBB7c7d; Tue, 25 Jun 2024 15:18:59 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719317939;
 bh=ag/GgsHuNVd44SdKM7yQKq3HqUJz8NZZZebfCY9JweI=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=xNvMUf6TivJP3mqGqwK5ZFr/939zz/zc05vh7u5ciNxdfXROThMSHC5e3hU0iVXEf
 oygDLTDCObaEMZwKrpXbCY+b8YcPoRhc7Qq6d7djWIzwqaKI061kC1Cl1yFgWTck8k
 xQnoVqqaIgaF8WgbKXdb5m0Y7GBsyxErpPMR/afg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org,
	raphael@enfabrica.net,
	mst@redhat.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, berrange@redhat.com, pbonzini@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru
Subject: [PATCH v5 0/3] vhost-user-blk: live resize additional APIs
Date: Tue, 25 Jun 2024 15:18:40 +0300
Message-Id: <20240625121843.120035-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

v5:
03: drop extra check on is is runstate running


Vladimir Sementsov-Ogievskiy (3):
  qdev-monitor: add option to report GenericError from find_device_state
  vhost-user-blk: split vhost_user_blk_sync_config()
  qapi: introduce device-sync-config

 hw/block/vhost-user-blk.c | 27 ++++++++++++++------
 hw/virtio/virtio-pci.c    |  9 +++++++
 include/hw/qdev-core.h    |  3 +++
 qapi/qdev.json            | 24 ++++++++++++++++++
 system/qdev-monitor.c     | 53 ++++++++++++++++++++++++++++++++++++---
 5 files changed, 105 insertions(+), 11 deletions(-)

-- 
2.34.1


