Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C851674E1E9
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:08:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzve-0008P2-JA; Mon, 10 Jul 2023 19:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzva-000843-SE
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvZ-0004UN-9n
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHmhGhTSD6X74P22Q0DAjxHl108XBojNde1QZNnDoCw=;
 b=Ku5xUJ+m7c/QB0ttv0JccmGd0tpA0j3JPkbiUcBvRtOd2rSUZxbK+sui0fjrz1Z6EQ3Fbg
 ye/W12VDXJ44742VN5Zg8XnFhl2RguMlBeNTOM0gNSD4MtpdQRBn2hbBpWrZq3W7rRzL6r
 IlF4wwt4oQPOVTrI46KiwIDQBL7V20Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-9sC7DBvZMw6xkIvuwR1MgQ-1; Mon, 10 Jul 2023 19:04:19 -0400
X-MC-Unique: 9sC7DBvZMw6xkIvuwR1MgQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fa8db49267so31649285e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030257; x=1691622257;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fHmhGhTSD6X74P22Q0DAjxHl108XBojNde1QZNnDoCw=;
 b=ds47wJF2TvIFHznB9tL5mE3TuPvpWPQg/5h9vYShRB3fdzOH8iw6MnSvr0GI8Ga8Rz
 KTs1/r6f6BA/vGTYCgi5AFcKgLZH7+2sAHF4Q2OtoEWKZRmAq1nOr6JhpuLPISkq+tR9
 o+MEBk69EKEycuNR79hYFQJSv8x0HZAC0Q9teFqjidwO4XsUSxHvzX++mma+82/vr6UF
 U+l6qcE36E3B2sQJmyTEs8010ELvM9nuOueXrU/384QamQbyaIFf3C1/gEoiKZwselgH
 t+sy+F9jhxmO7DQmW0FxB00Y/siZus9VYz43D4cI3yu2stKZvt2f3E4D9gtIHCXh9uXZ
 JUdg==
X-Gm-Message-State: ABy/qLZtnelU3mEcYSEHS4UHkJoBDNR1tacM7327O/RgyKEM5BNozsnt
 UWs/qOgVSoVzGx+gYXuaC9MeF7npxDlFh26DAJJprhXeJuCkbi3UeV+9VI7wH2rsrKOYKlw7NHt
 sDi+Iuae+x4Ghxll18il68E3sMPPaq8ZwPS2rUBeQ4ATqNlJgPBOedJ2NOcpjKEvWKj4l
X-Received: by 2002:a1c:6a0c:0:b0:3f7:e3dd:8a47 with SMTP id
 f12-20020a1c6a0c000000b003f7e3dd8a47mr12333313wmc.11.1689030257798; 
 Mon, 10 Jul 2023 16:04:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHZGRlZ9eTrTscuHnI0NJMB37SWi28REPbq4btp7AF9RH5NQg2TcmWntxhbIzp3bZZ7KUGm5A==
X-Received: by 2002:a1c:6a0c:0:b0:3f7:e3dd:8a47 with SMTP id
 f12-20020a1c6a0c000000b003f7e3dd8a47mr12333294wmc.11.1689030257528; 
 Mon, 10 Jul 2023 16:04:17 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 m4-20020a05600c280400b003fc07e17d4esm7623082wmb.2.2023.07.10.16.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:04:17 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:04:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>
Subject: [PULL 38/66] vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in
 _load_mq()
Message-ID: <f45fd95ec9e8104f6af801c734375029dda0f542.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Hawkins Jiawei <yin31149@gmail.com>

According to VirtIO standard, "The class, command and
command-specific-data are set by the driver,
and the device sets the ack byte.
There is little it can do except issue a diagnostic
if ack is not VIRTIO_NET_OK."

Therefore, QEMU should stop sending the queued SVQ commands and
cancel the device startup if the device's ack is not VIRTIO_NET_OK.

Yet the problem is that, vhost_vdpa_net_load_mq() returns 1 based on
`*s->status != VIRTIO_NET_OK` when the device's ack is VIRTIO_NET_ERR.
As a result, net->nc->info->load() also returns 1, this makes
vhost_net_start_one() incorrectly assume the device state is
successfully loaded by vhost_vdpa_net_load() and return 0, instead of
goto `fail` label to cancel the device startup, as vhost_net_start_one()
only cancels the device startup when net->nc->info->load() returns a
negative value.

This patch fixes this problem by returning -EIO when the device's
ack is not VIRTIO_NET_OK.

Fixes: f64c7cda69 ("vdpa: Add vhost_vdpa_net_load_mq")
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <ec515ebb0b4f56368751b9e318e245a5d994fa72.1688438055.git.yin31149@gmail.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 345a301d62..8477ed2579 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -677,8 +677,11 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
     if (unlikely(dev_written < 0)) {
         return dev_written;
     }
+    if (*s->status != VIRTIO_NET_OK) {
+        return -EIO;
+    }
 
-    return *s->status != VIRTIO_NET_OK;
+    return 0;
 }
 
 static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
-- 
MST


