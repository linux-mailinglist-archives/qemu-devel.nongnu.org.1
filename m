Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BB2892379
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Mar 2024 19:39:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqH7d-0002mg-2I; Fri, 29 Mar 2024 14:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rqH7a-0002l4-J6; Fri, 29 Mar 2024 14:38:34 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rqH7Y-0007Wm-I7; Fri, 29 Mar 2024 14:38:34 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5428:0:640:7351:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 7880C60BDA;
 Fri, 29 Mar 2024 21:38:26 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:6509::1:4])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2cTaY94Id8c0-nXyM4rtK; Fri, 29 Mar 2024 21:38:25 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1711737505;
 bh=8P7NZEw9jcUgqc87Uhn1vKvB7YOes+3Qto/gE7vV5n4=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=ch2tC4p0lRhVmTEg4JeP0AYb0lQQ6Lq/p/Iy1LuaF3zAXZTUZdtKcZFdObROu7CDm
 6eJtcBFg1ZIJnuPJGSZzlSPM+YLTVVf024T1y/wtNqaaw+KTGg5fv6W1U7/+Q6xsPD
 ftQPMiMGV+rvkRzRp55EhIcUHGtWGnEgsdwtQYdE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org,
	raphael@enfabrica.net,
	mst@redhat.com
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, armbru@redhat.com,
 dave@treblig.org, eblake@redhat.com, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v3 0/5] vhost-user-blk: live resize additional APIs
Date: Fri, 29 Mar 2024 21:37:53 +0300
Message-Id: <20240329183758.3360733-1-vsementsov@yandex-team.ru>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

v3:
02: add r-b by Markus
03: improve commit message
04: improve documentation, merge race-fix here (which was v2:05),
    rebase on master (migration_is_running() now without arguments)
05: improve documentation

Vladimir Sementsov-Ogievskiy (5):
  vhost-user-blk: simplify and fix vhost_user_blk_handle_config_change
  qdev-monitor: fix error message in find_device_state()
  qdev-monitor: add option to report GenericError from find_device_state
  qapi: introduce device-sync-config
  qapi: introduce CONFIG_READ event

 hw/block/vhost-user-blk.c | 32 +++++++++++-------
 hw/virtio/virtio-pci.c    | 18 ++++++++++
 include/hw/qdev-core.h    |  3 ++
 include/monitor/qdev.h    |  2 ++
 include/sysemu/runstate.h |  1 +
 monitor/monitor.c         |  1 +
 qapi/qdev.json            | 54 ++++++++++++++++++++++++++++++
 stubs/qdev.c              |  6 ++++
 system/qdev-monitor.c     | 70 ++++++++++++++++++++++++++++++++++++---
 system/runstate.c         |  5 +++
 10 files changed, 175 insertions(+), 17 deletions(-)

-- 
2.34.1


