Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4255D73DF4C
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:32:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlLx-0003Ur-0Y; Mon, 26 Jun 2023 08:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLE-0002Ud-SV
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLB-00034h-Fe
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Q1VrgxZvuNezgqJjEDTPymrx7mMrqo8mV/xFnS451k=;
 b=Ynlx8kdzQf4D7NMek94NrYTElsheYQdSYkoPoIi+gE8IHX9Ps5sBrxh0rBy59EyAFlRyQa
 YUh+rqkARg7kPa9jk7BIEzOcj91zSkTrZOWESiGS/LfMXwguTUtutezQ/89aLUiZkpGbeX
 ORvUelXBgCkkuiF3VfwLF3/hYVcHK3Q=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-DnTPahQoOs2A03J1QzUKjA-1; Mon, 26 Jun 2023 08:29:07 -0400
X-MC-Unique: DnTPahQoOs2A03J1QzUKjA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4fb7b4be07bso324429e87.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782545; x=1690374545;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Q1VrgxZvuNezgqJjEDTPymrx7mMrqo8mV/xFnS451k=;
 b=dWbN+MxtlB+66vXE2WYDVzzBmZbe1EfgzO4KuQjrpfdpBUer7oYGh2VIjBmC7yDBmj
 A3hy92qIypkD3/vaapMiLJ+ERoxtf/rqMOIKHZK33yZU7uZYbS8L8Ofql8DFK92e19BG
 1v8yhclQvRZWSPGrhkIu1E5SrGQ6dbQHAnpobbzGVy00HW4mtXuvicxzt1cXYIpg4bcL
 sV/K0NwZswfqesrUNvAPxTmyXHpLEQ/WbfCdpeNYT0kXFb5NO6OuNxvPIziCDW/qZNyy
 8d01TAIhmOXkwuZ0KQIyIEZKQffJkMPVdyFv1BrUJkPzuAb5Iq8RE1pBmilfUAjFaHl4
 DygA==
X-Gm-Message-State: AC+VfDwUyRdHzEPDi0J4Y+F6bae6AZ4tFvM0leBBQmTXNuLZCfFHVWkN
 tlK/Q6k5lJdHu5C4WGUcwIvVRY+TW2X8uYsbVZmw/zKGNciBTC5Q7CxHzW7SFR0rrApVNxQIN9B
 suE6USv/ZiSZApIoKlHeD92wqC9EcSMzi+iqbOTmtcIk9IqDiFuEZPGFDyTZp01NUshP+
X-Received: by 2002:a19:8c49:0:b0:4f8:5bf7:db05 with SMTP id
 i9-20020a198c49000000b004f85bf7db05mr13875261lfj.27.1687782545043; 
 Mon, 26 Jun 2023 05:29:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5cD3vKd0mN6UDBNonw7GcnFBVJ2tB1WcN5dufAb6w9E/Ex3FNqeRXxnXzYbRQViRFwN2f8Ig==
X-Received: by 2002:a19:8c49:0:b0:4f8:5bf7:db05 with SMTP id
 i9-20020a198c49000000b004f85bf7db05mr13875245lfj.27.1687782544691; 
 Mon, 26 Jun 2023 05:29:04 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 y12-20020a05600c364c00b003f7f249e7dfsm10587252wmq.4.2023.06.26.05.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:29:04 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:29:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad Pandit <pjp@fedoraproject.org>, Peter Xu <peterx@redhat.com>,
 qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>
Subject: [PULL 24/53] vhost: release virtqueue objects in error path
Message-ID: <77ece20ba04582d94c345ac0107ddff2fd18d27a.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Prasad Pandit <pjp@fedoraproject.org>

vhost_dev_start function does not release virtqueue objects when
event_notifier_init() function fails. Release virtqueue objects
and log a message about function failure.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
Message-Id: <20230529114333.31686-3-ppandit@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: qemu-stable@nongnu.org
Acked-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/vhost.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 7e1f556994..fb7abc9769 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1941,7 +1941,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
     r = event_notifier_init(
         &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier, 0);
     if (r < 0) {
-        return r;
+        VHOST_OPS_DEBUG(r, "event_notifier_init failed");
+        goto fail_vq;
     }
     event_notifier_test_and_clear(
         &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
-- 
MST


