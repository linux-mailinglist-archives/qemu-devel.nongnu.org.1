Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29618B955ED
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Sep 2025 12:03:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zqp-0003TT-SG; Tue, 23 Sep 2025 06:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0zqE-0002sF-Pk
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:01:48 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0zpu-0000us-Ic
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:01:46 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id A0A90807D1;
 Tue, 23 Sep 2025 13:01:20 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b38::1:12])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id C1Ug0C0Fha60-1JTnM1op; Tue, 23 Sep 2025 13:01:20 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758621680;
 bh=DfzOyCICzHBH/C+sRPO/6zCB1uwXvXGrUTU5e+HA5lw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=FiQOh7Nd6nrpxElWhIen2Yr/hnl3A/wLvQsMV/O2JQyrfUjD1/HjNlBuzYa26l199
 km0uCnm+T050Rw8pB3wPGec3ywkjNnNNYzd/hFoy6Z9JCYinqtwMZNYhB58W5scEI7
 prqxyvaDnXRASvSlB/q+dCAPR5Y3i21LMLHcAKqo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 eblake@redhat.com, michael.roth@amd.com, armbru@redhat.com,
 farosas@suse.de, peterx@redhat.com, berrange@redhat.com,
 jasowang@redhat.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v6 13/19] net/tap: finalize net_tap_set_fd() logic
Date: Tue, 23 Sep 2025 13:01:04 +0300
Message-ID: <20250923100110.70862-14-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250923100110.70862-1-vsementsov@yandex-team.ru>
References: <20250923100110.70862-1-vsementsov@yandex-team.ru>
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

Let net_tap_set_fd() do only fd-related setup.

Actually, for further backend-transfer migration for virtio-net/tap
we'll want to skip net_tap_set_fd() (as incoming fds are already
prepared by source QEMU). So move tap_read_poll() to net_tap_setup().

Don't care about using_vnet_hdr and vhost_net, the state is
zero-initialized.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index dbd1eb3a17..340d8d0cda 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -467,7 +467,6 @@ static bool net_tap_set_fd(TAPState *s, int fd, int vnet_hdr, Error **errp)
 {
     s->fd = fd;
     s->host_vnet_hdr_len = vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
-    s->using_vnet_hdr = false;
     s->has_ufo = tap_probe_has_ufo(s->fd);
     s->has_uso = tap_probe_has_uso(s->fd);
     s->enabled = true;
@@ -479,8 +478,6 @@ static bool net_tap_set_fd(TAPState *s, int fd, int vnet_hdr, Error **errp)
     if (vnet_hdr) {
         tap_fd_set_vnet_hdr_len(s->fd, s->host_vnet_hdr_len);
     }
-    tap_read_poll(s, true);
-    s->vhost_net = NULL;
 
     if (s->sndbuf) {
         Error **e = s->sndbuf_required ? errp : NULL;
@@ -781,6 +778,8 @@ static bool net_tap_setup(TAPState *s, int fd, int vnet_hdr, Error **errp)
         return false;
     }
 
+    tap_read_poll(s, true);
+
     if (s->vhostfd != -1) {
         VhostNetOptions options;
 
-- 
2.48.1


