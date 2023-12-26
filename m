Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C7F81E64F
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 10:25:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI3g5-0001gy-DQ; Tue, 26 Dec 2023 04:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3fv-0001LI-ST
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:24:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3fu-0008I0-Dp
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703582673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MlOqSlfgZan+WoAwKqTBR2Fe+bYpSsLlMzeyIzh7tJo=;
 b=MGltQlZP4Nfxw/qV8S8LebL86qxgcFX8ForvGhGp8cRULbG3OsIs/A1CEorgJE2UqWKBPf
 QmfW0eJwVTPgXX23Lg9udqA+9B/V956q/fA2jaJaMiV+SNPZESz+rH+/ora+MEIL06zC65
 tnmYh+V52C1dNzmC7fzOCela1W/5rvM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-sO7JgxYVN-Kbc81VXA6yIg-1; Tue, 26 Dec 2023 04:24:32 -0500
X-MC-Unique: sO7JgxYVN-Kbc81VXA6yIg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40d5bf5ca25so229815e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 01:24:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703582669; x=1704187469;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MlOqSlfgZan+WoAwKqTBR2Fe+bYpSsLlMzeyIzh7tJo=;
 b=GHiMixTPF2fKgXtBz5ksY1ufqCAxW3PQyjNKdUGtV0IcHRCrv6/Kzm1TuFpdwhKtWr
 KpnaVQsGsfvEyi9z01OQRPImpLvVNayUjjEDjOGO6/dtv4khhzKYEgl+Nxbpk123jwYf
 FfrReDqW80oqyojKgmkfCeYsRDjNufxgOO+h2MCuDt7P9qbccoTsAJFluyUJrfoKZPuu
 luRce79EAHhINc1sSfAInit3QF2RB1F/mjCoXkxY9VyCdKJPpbriiT/jZhTgS7iN00a1
 BvawuZ4rGNtr3hdclkzas+AcQfxSRiXeq68rZrFkByMKzp6Q6JPuuVab1T/7OdFTDMYv
 KoQg==
X-Gm-Message-State: AOJu0YyVKmB2hweHSlIdMtYbjsNP4ExxyYYN8/GNth4igOvZpswnPLQM
 q+yL8E4XI51fHAzRB1wEmM6k9d0qsNlkidthtHtUn5B47BKnDBTO7ul1keNdRXoMtSllyUj3KSv
 k/HtMt++A7qZHvZ3h7nG4yJSCGayZqAzSgYS5KY0aWToK1RFTBvk0By8EJvcul7inXVOfPdCaUu
 cc
X-Received: by 2002:a05:600c:1e1b:b0:40c:4a25:8cf9 with SMTP id
 ay27-20020a05600c1e1b00b0040c4a258cf9mr3886690wmb.50.1703582669547; 
 Tue, 26 Dec 2023 01:24:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyP2iDaERehvVnpEElQF830GO5A2ihZHyWx+DmdGnBIbL3BvtCnjHn09FG31Z4nhDxA5Q2tg==
X-Received: by 2002:a05:600c:1e1b:b0:40c:4a25:8cf9 with SMTP id
 ay27-20020a05600c1e1b00b0040c4a258cf9mr3886682wmb.50.1703582669106; 
 Tue, 26 Dec 2023 01:24:29 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 h9-20020a05600c350900b0040d5aca25f1sm1189620wmq.17.2023.12.26.01.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 01:24:28 -0800 (PST)
Date: Tue, 26 Dec 2023 04:24:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 wangmeiling <wangmeiling21@huawei.com>, Binfeng Wu <wubinfeng@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 07/21] Fix bugs when VM shutdown with virtio-gpu unplugged
Message-ID: <c1d86681ec9d216f82443859457e890c5560f821.1703582625.git.mst@redhat.com>
References: <cover.1703582625.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1703582625.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.977,
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

From: wangmeiling <wangmeiling21@huawei.com>

Virtio-gpu malloc memory for the queue when it realized, but the queues was not
released when it unrealized, which resulting in a memory leak. In addition,
vm_change_state_handler is not cleaned up, which is related to vdev and will
lead to segmentation fault when VM shutdown.

Signed-off-by: wangmeiling <wangmeiling21@huawei.com>
Signed-off-by: Binfeng Wu <wubinfeng@huawei.com>
Message-Id: <7bbbc0f3-2ad9-83ca-b39b-f976d0837daf@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/display/virtio-gpu-base.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 37af256219..4fc7ef8896 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -251,7 +251,11 @@ void
 virtio_gpu_base_device_unrealize(DeviceState *qdev)
 {
     VirtIOGPUBase *g = VIRTIO_GPU_BASE(qdev);
+    VirtIODevice *vdev = VIRTIO_DEVICE(qdev);
 
+    virtio_del_queue(vdev, 0);
+    virtio_del_queue(vdev, 1);
+    virtio_cleanup(vdev);
     migrate_del_blocker(&g->migration_blocker);
 }
 
-- 
MST


