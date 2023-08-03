Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1CC76F5A3
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:22:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRghO-0004SJ-Oq; Thu, 03 Aug 2023 18:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRghN-0004QZ-Cc
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRghL-0000Wi-VP
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691101295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jRsCclF9+O5GiFeLNLzg/MH5MtZPWdKpgBgSE0YMB44=;
 b=PH+NFJlwB8GySOzBtD5bRyXn15k1WQMTz9Um9NZiVm/98Jt5SBY7Qd4inxKJQpEmZaTrSc
 J3wmIIRMCncDs0yKhv8o1nXvlY6mA4d+TnIV4XtSVyrGZyWnehFmxwHcS4axcmX5Acmeui
 i0oAjexFo+hyjCV8M9H1XNhieGJWDOg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-HzGIhpV1OWSwbvC3hoB6Pg-1; Thu, 03 Aug 2023 18:21:34 -0400
X-MC-Unique: HzGIhpV1OWSwbvC3hoB6Pg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b8405aace3so14609081fa.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 15:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691101292; x=1691706092;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jRsCclF9+O5GiFeLNLzg/MH5MtZPWdKpgBgSE0YMB44=;
 b=CyV6q6E6hyUmpJ50zlFifSEoWx1sc7x1OYRYyM/XnL65KNqQWSf4fGOVPqrRLeP6cL
 CNnIIVqyh9E2zPzzlM4UPFF6pE2gSc5rfUbjHJngECk1Ji50VXT9mYN56bL1zUGFqajS
 XlNnMjmWk/nY6q6keVBxPEq0+vYX/kaAq8a5WC2EsMl5glU0vkQu8qB4234hw8xbVPBV
 9Ub6pESCMooSuQ45AfED7DB9wsgK1L7uiI7gnHIJfoFJ4bwIaSxNqLODtAHucyi3tuzd
 f+BLAjye22bU5eQX1I/0G8qsJkWEfyFLBX5jBnWoRCAP44IkRqRSe3UZUq735+sOUJjs
 rRfQ==
X-Gm-Message-State: AOJu0YxSCwmGUH/8M4Fb55eQG9edXxxQ1RSaTul6ySsRkCf45D7ISSJK
 rFbbA94PruDVI+fyUt0vowhOKpMCh7fhF6MNBUHPRJ0+3pq0crzP4dN2FsZzhp/91qQyDDMSxmR
 U8T3bHT8HjeNJOcpDFEikTodUjN5vQi3xEFUJZUkP9ZLgqE8V4lU3/3MsQBfk1+BBOKR3
X-Received: by 2002:a2e:861a:0:b0:2b9:c864:9e3f with SMTP id
 a26-20020a2e861a000000b002b9c8649e3fmr93217lji.39.1691101292207; 
 Thu, 03 Aug 2023 15:21:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFskJOhYGL9yVUrXR4v1cnqDYClU8g8Osoo1pleAwE5yMVRz1pxazAPkRNR8uQFYVSlLkozIQ==
X-Received: by 2002:a2e:861a:0:b0:2b9:c864:9e3f with SMTP id
 a26-20020a2e861a000000b002b9c8649e3fmr93202lji.39.1691101291943; 
 Thu, 03 Aug 2023 15:21:31 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 l9-20020a17090612c900b009932337747esm376457ejb.86.2023.08.03.15.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 15:21:31 -0700 (PDT)
Date: Thu, 3 Aug 2023 18:21:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Feng <fengli@smartx.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: [PULL 14/22] vhost: fix the fd leak
Message-ID: <18f2971ce403008d5e1c2875b483c9d1778143dc.1691101215.git.mst@redhat.com>
References: <cover.1691101215.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691101215.git.mst@redhat.com>
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

From: Li Feng <fengli@smartx.com>

When the vhost-user reconnect to the backend, the notifer should be
cleanup. Otherwise, the fd resource will be exhausted.

Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")

Signed-off-by: Li Feng <fengli@smartx.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <20230731121018.2856310-2-fengli@smartx.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
---
 hw/virtio/vhost.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index abf0d03c8d..e2f6ffb446 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2044,6 +2044,8 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
     event_notifier_test_and_clear(
         &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
     event_notifier_test_and_clear(&vdev->config_notifier);
+    event_notifier_cleanup(
+        &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
 
     trace_vhost_dev_stop(hdev, vdev->name, vrings);
 
-- 
MST


