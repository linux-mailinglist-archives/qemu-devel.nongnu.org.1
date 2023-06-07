Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6EE726295
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:20:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6u0x-0002uF-Oj; Wed, 07 Jun 2023 10:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u0w-0002u5-4O
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:19:54 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u0u-0003Qf-GB
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1686147592;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=d5mAhhjITwi8S49z+YqAH0l9GdOkUuJMbFDA8evNpo8=;
 b=DpRDPz3OryhdUSADOomtIPA9PeVo79wab2SmTCPg24Hf5MNtLx0pzE+R
 eUeXIKGRypBHZgNyvFYAdWk7PfcJ1dJgME2FEqaygsE8I9UhcExgJLc9Q
 1W4fRjWyGEcg3k7WDoDjUMWohd0C51TuK57NlgkasF015XzUmiof62UkU E=;
Authentication-Results: esa6.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 111246636
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:UPvqla9ki+uhMaUZ0KuPDrUD9X6TJUtcMsCJ2f8bNWPcYEJGY0x3n
 DYfDz3XOK6MMGGkL49zb9uxp0kA65/RxtU1SwQ/pX08E34SpcT7XtnIdU2Y0wF+jCHgZBk+s
 5hBMImowOQcFCK0SsKFa+C5xZVE/fjUAOG6UKicYXoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqojUNUTNNwRcawr40Ird7ks31BjOkGlA5AdmO6gU5AW2e0Q9V/rzG4ngdxMUfaEMdgKKb
 76r5K20+Grf4yAsBruN+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+v9T2M4nQVVWk120c+VZk
 72hg3ASpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn9IBDJyCAWlvVbD09NqbDkkR+
 eJHDBcsSirYiu22xbmFZelAjPYseZyD0IM34hmMzBncBPciB5vCX7/L9ZlT2zJYasJmRKiEI
 ZBDMHw2MUqGOkcUUrsUIMtWcOOAj3/jczpeuRSNqLA++WT7xw1tyrn9dtHSf7RmQO0Mxx/C+
 jyYpDqR7hcyK/y06gSGrmiQu7XzggPKWt8dV4Ky36s/6LGU7jNKU0BHPbehmtGgh0ujHt5SN
 UEQ0iwpq6c06QqsVNaVYvGjiCfa5FhGAYMWSrBkrljXkcI4/jp1GEBbQiAeTPsHkPVtSDMq0
 1S3sNPFDw5g5ej9pW2myp+Yqja7OC4wJGAEZDMZQQZt3+QPsL3fnTqUEI89TffdYsndXGipn
 mvU9HRWa6A715Zj6kmtwbzQb9tATLDtRxV92AjYV3nNAuhRNN/8PNzABbQ2AJ99wGelorup5
 iBsdyu2trpm4XSxeMulHo0w8EmBvartDdElqQcH82Md3zqs4WW/Wotb/StzIkxkWu5dJ2+3O
 BCN418KtcMKVJdPUUORS9jpYyjN5fK5fekJq9iONoYeCnSPXFHvEN5Sib64gDm2zRlEfVAXM
 paHa8e8ZUv2+ow+pAdas9w1iOdxrghnnDO7eHwO50j/uVZoTCLPGOht3ZrnRrxR0Z5oVy2Lq
 4sOaZHXkUw3vS+XSnC/zLP/5GsidRATba0aYeQNHgJfCmKKwF0cNsI=
IronPort-HdrOrdr: A9a23:E0nf96NMbskhx8BcTvOjsMiBIKoaSvp037BL7S9MoHluGfBw+P
 re+cjzuSWUtN9pYgBCpTniAse9qA3nhPxICOAqVN/JMWXbUQ2TXeVfBODZowEIdReOj9J15O
 NNdLV/Fc21LXUSt7eD3OBgKadG/DBQytHPudvj
X-Talos-CUID: 9a23:5UIcfW23ogZvx5C3jBRYd7xfRcw7LVn67VPqeEK3CWNidpKVZVWi9/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3ASZScSAwfTOmq4KSBD83lVihxcOyaqLuOI2Mzksk?=
 =?us-ascii?q?ch/TeCTNQCjXAg3eISKZyfw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.00,224,1681185600"; d="scan'208";a="111246636"
To: <qemu-devel@nongnu.org>
CC: Anthony PERARD <anthony.perard@citrix.com>
Subject: [PULL 12/12] xen-block: fix segv on unrealize
Date: Wed, 7 Jun 2023 15:18:39 +0100
Message-ID: <20230607141839.48422-13-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607141839.48422-1-anthony.perard@citrix.com>
References: <20230607141839.48422-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.155.175;
 envelope-from=prvs=51561cf95=anthony.perard@citrix.com;
 helo=esa6.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Anthony PERARD <anthony.perard@citrix.com>

Backtrace:
  qemu_lockcnt_lock (lockcnt=0xb4) at ../util/lockcnt.c:238
  aio_set_fd_handler (ctx=0x0, fd=51, is_external=true, io_read=0x0, io_write=0x0, io_poll=0x0, io_poll_ready=0x0, opaque=0x0) at ../util/aio-posix.c:119
  xen_device_unbind_event_channel (xendev=0x55c6da5b5000, channel=0x55c6da6c4c80, errp=0x7fff641ac608) at ../hw/xen/xen-bus.c:926
  xen_block_dataplane_stop (dataplane=0x55c6da6ddbe0) at ../hw/block/dataplane/xen-block.c:719
  xen_block_disconnect (xendev=0x55c6da5b5000, errp=0x0) at ../hw/block/xen-block.c:48
  xen_block_unrealize (xendev=0x55c6da5b5000) at ../hw/block/xen-block.c:154
  xen_device_unrealize (dev=0x55c6da5b5000) at ../hw/xen/xen-bus.c:956
  xen_device_exit (n=0x55c6da5b50d0, data=0x0) at ../hw/xen/xen-bus.c:985
  notifier_list_notify (list=0x55c6d91f9820 <exit_notifiers>, data=0x0) at ../util/notify.c:39
  qemu_run_exit_notifiers () at ../softmmu/runstate.c:760

Fixes: f6eac904f682 ("xen-block: implement BlockDevOps->drained_begin()")
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20230606131605.55596-1-anthony.perard@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/xen/xen-bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 1e08cf027a..ece8ec40cd 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -923,8 +923,10 @@ void xen_device_unbind_event_channel(XenDevice *xendev,
 
     QLIST_REMOVE(channel, list);
 
-    aio_set_fd_handler(channel->ctx, qemu_xen_evtchn_fd(channel->xeh),
-                       NULL, NULL, NULL, NULL, NULL);
+    if (channel->ctx) {
+        aio_set_fd_handler(channel->ctx, qemu_xen_evtchn_fd(channel->xeh),
+                           NULL, NULL, NULL, NULL, NULL);
+    }
 
     if (qemu_xen_evtchn_unbind(channel->xeh, channel->local_port) < 0) {
         error_setg_errno(errp, errno, "xenevtchn_unbind failed");
-- 
Anthony PERARD


