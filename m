Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E368A7BC03E
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 22:22:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qorJu-0008GK-2j; Fri, 06 Oct 2023 16:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qorJp-0008DW-SY; Fri, 06 Oct 2023 16:21:05 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qorJm-0005lo-PK; Fri, 06 Oct 2023 16:21:05 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:3a8c:0:640:ec94:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id ECD2760EF5;
 Fri,  6 Oct 2023 23:20:57 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b403::1:3c])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id kKgI6e5OrCg0-5SR0AWam; Fri, 06 Oct 2023 23:20:57 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696623657;
 bh=NWV1lbhEmg15eGI39+WJWuedAPGGFlGPabHWOqVSKrw=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=MUtS3GB0c4UBGA2EDG3c5bbcYAd+r1ZnYLZRLB6MuhcVrmtVGRRDTr1u3uPkJ13eL
 eJwIHIlxj182hwR7rNc7oQFuooVF5AcNNM6NNONeiWIoZvWSKCb4gi+iIOppycZdN6
 HKiJCxtDMTIHo+i+/mcFXrpLQWs+WmCvrWaDnmhA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, dave@treblig.org,
 armbru@redhat.com, eduardo@habkost.net, berrange@redhat.com,
 pbonzini@redhat.com, hreitz@redhat.com, kwolf@redhat.com,
 raphael.norwitz@nutanix.com, mst@redhat.com, yc-core@yandex-team.ru,
 vsementsov@yandex-team.ru, den-plotnikov@yandex-team.ru,
 daniil.tatianin@yandex.ru
Subject: [PATCH 0/4] vhost-user-blk: live resize additional APIs
Date: Fri,  6 Oct 2023 23:20:41 +0300
Message-Id: <20231006202045.1161543-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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

In vhost-user protocol we have VHOST_USER_BACKEND_CONFIG_CHANGE_MSG,
which backend may send to notify Qemu, that we should re-read the
config, and notify the guest.

Still that's not always convenient: backend may not support this
message. Also, having QMP command to force config sync is more reliable
than waiting for notification from external program. It also may be
helpful for debug/restore: if we have changed disk size, but guest
doesn't see that, it's good to have a separate QMP command to trigger
resync of the config.

So, the series proposes two experimental APIs:

1. x-device-sync-config command, to trigger config synchronization

2. X_CONFIG_READ event, which notify management tool that guest read the
updated config. Of course, that can't guarantee that the guest correctly
handled the updated config, but it's still better than nothing: for sure
guest will not show new disk size until it read the updated config. So,
management tool may wait for this event to report success to the user.


The series is based on "[PATCH v8 0/4] pci hotplug tracking": it doesn't
depend on it, but just modify same files, so I just to avoid extra
conflicts.
Based-on: <20231005092926.56231-1-vsementsov@yandex-team.ru>

Vladimir Sementsov-Ogievskiy (4):
  vhost-user-blk: simplify and fix vhost_user_blk_handle_config_change
  qapi: introduce device-sync-config
  qapi: device-sync-config: check runstate
  qapi: introduce CONFIG_READ event

 hw/block/vhost-user-blk.c | 32 ++++++++++++++---------
 hw/virtio/virtio-pci.c    | 18 +++++++++++++
 include/hw/qdev-core.h    |  3 +++
 include/monitor/qdev.h    |  1 +
 include/sysemu/runstate.h |  1 +
 monitor/monitor.c         |  1 +
 qapi/qdev.json            | 36 ++++++++++++++++++++++++++
 softmmu/qdev-monitor.c    | 53 +++++++++++++++++++++++++++++++++++++++
 softmmu/runstate.c        |  5 ++++
 9 files changed, 138 insertions(+), 12 deletions(-)

-- 
2.34.1


