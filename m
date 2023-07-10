Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 571CA74E1EC
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:08:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzve-0008NZ-Db; Mon, 10 Jul 2023 19:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvX-00080b-Ox
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvW-0004U3-BT
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O9A8NXPUZ1UAaZ4xg8XGvm2vrnKputB+kT4Xm8amg28=;
 b=TrzF7LhVmjtXnNJZiCrVWRz2d9byVwiX+XwZ87OVSqFQP4mCKdL+KDvQnH7X8oLxr2bNBp
 v+jBFwmenPwXKINz6VOJgm7yCn0jKlclvvdKyazmnHqVaxafiE25pPavh4Inkxeb2dCy9+
 FWbNUgcPfj9qIIMLN7wwxLC1lULklyM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-nJRoKJvVO9yOSBYDPQ5oyg-1; Mon, 10 Jul 2023 19:04:16 -0400
X-MC-Unique: nJRoKJvVO9yOSBYDPQ5oyg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fc0855dcc5so15721055e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030255; x=1691622255;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O9A8NXPUZ1UAaZ4xg8XGvm2vrnKputB+kT4Xm8amg28=;
 b=U7f3+MbDYnKcC9y/+TKdb2fgifS/9nPITIDANwvMWvMF7SavGOt2yUHDS4yr6ane+/
 u4lejdla5PZRbINWyH4tIYrwayzcoAFiKe9ZHZc6GaG30f3dQiAdY5fcgKXOuzK7aNer
 sWNuFDMd50HQr06BJo8BlQOxmK5WydmcHbCrMlJaPNmYgpRm2iV++YjyD6WeDJUIZ2O6
 Bo2FyAtqQuv9xcJB5N0qWXYLuHRxLVtISSqA4Nbnpr+vCEvm9hcUOKLwKChMjh8XBSNA
 YJOvOvfcqpouKIo/psRGtJjuYyxoEMcrmqjnyvzWt7SMF2lMsOx3aLF7CapLNLV6xra0
 c1ng==
X-Gm-Message-State: ABy/qLa1nZf3Y1zAHuG3tHKRMJDTCdK3EuxtkukxBO5TNrZc6QvmayE5
 RHBNGb5WuIR9+1QoQCKmgupnASGJBTjjNu/6NvhWcL80fcjTRF25+7Kz0KLj8kNKARyGanMpqOw
 p1OlJ36OM08NL7D6wpVUG9RFuqho7ljuwOcc9T2P6KC3E9uP35sH0kK2HbNWO5KIGluM7
X-Received: by 2002:a05:600c:21cb:b0:3fb:b8a6:33f9 with SMTP id
 x11-20020a05600c21cb00b003fbb8a633f9mr12950878wmj.0.1689030255143; 
 Mon, 10 Jul 2023 16:04:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFo/aWJF/1VvEjOsT/dEI91F2r40j5IpMrKg+g/g9PyUU67tkD0G7OXABBETbz2CpIxWUvxPg==
X-Received: by 2002:a05:600c:21cb:b0:3fb:b8a6:33f9 with SMTP id
 x11-20020a05600c21cb00b003fbb8a633f9mr12950849wmj.0.1689030254754; 
 Mon, 10 Jul 2023 16:04:14 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 w18-20020a5d6812000000b0031416362e23sm610529wru.3.2023.07.10.16.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:04:14 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:04:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>
Subject: [PULL 37/66] vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in
 _load_mac()
Message-ID: <b479bc3c9d5e473553137641fd31069c251f0d6e.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

Yet the problem is that, vhost_vdpa_net_load_mac() returns 1 based on
`*s->status != VIRTIO_NET_OK` when the device's ack is VIRTIO_NET_ERR.
As a result, net->nc->info->load() also returns 1, this makes
vhost_net_start_one() incorrectly assume the device state is
successfully loaded by vhost_vdpa_net_load() and return 0, instead of
goto `fail` label to cancel the device startup, as vhost_net_start_one()
only cancels the device startup when net->nc->info->load() returns a
negative value.

This patch fixes this problem by returning -EIO when the device's
ack is not VIRTIO_NET_OK.

Fixes: f73c0c43ac ("vdpa: extract vhost_vdpa_net_load_mac from vhost_vdpa_net_load")
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <a21731518644abbd0c495c5b7960527c5911f80d.1688438055.git.yin31149@gmail.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index c0e93ce568..345a301d62 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -652,8 +652,9 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
         if (unlikely(dev_written < 0)) {
             return dev_written;
         }
-
-        return *s->status != VIRTIO_NET_OK;
+        if (*s->status != VIRTIO_NET_OK) {
+            return -EIO;
+        }
     }
 
     return 0;
-- 
MST


