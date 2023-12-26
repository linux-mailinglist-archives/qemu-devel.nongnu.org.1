Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9EE81E6B7
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 10:52:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI469-0001Bp-Gi; Tue, 26 Dec 2023 04:51:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI466-0001BX-O5
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:51:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI462-00044Q-7Z
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:51:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703584293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ibi9cILDkS6+uCUBFarZ9oJKdZKd3xgef/MV0EFr+Q4=;
 b=Ry7kI2/vv1odjYkKQZekbVvlX6Sa8ZJr32J8ru/NALZcc7YWtwhin6/ly7TUFF9OMqa/iC
 OFRLL7VziG0XEHSLwOStb1GBcLo7i23SqKwngANsbu7sFX1K+Pt3gHujrhWdkPxs3nZuHc
 IbdFTdJpsCqSY3B77N3uvdMCkjvrHmk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-ydAMxXNIOK-5P-BjHVZWHg-1; Tue, 26 Dec 2023 04:51:31 -0500
X-MC-Unique: ydAMxXNIOK-5P-BjHVZWHg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40d5bc8d13bso686055e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 01:51:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584289; x=1704189089;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ibi9cILDkS6+uCUBFarZ9oJKdZKd3xgef/MV0EFr+Q4=;
 b=iWzWpIFrn9D3NaDR25KusxcS14NW7vRkLMdw68WYfyHzxi5iuHfUX/lDZZWLSSJ+oH
 6ZbyjduJAzcqhVr4qTUrMxpLShqyrb6PW5ckDhT5j9bILsHpP0hsidOR+r/VY5F8vDqG
 4D4hg3ml8Oi58n04NFPX1/TxrkEbNe1ErRr4xsYl4POYCMB2b9mFJLQ0+P2jzgnpsojk
 3ib5kw+wm/h2FjHpyaUPvx4zrP6/NTGo0fs+8VSN+Lz1BRvsh3fDbenMM+maP1MQK077
 ueJr/kU0SO8Pu7yzbdiHvtQzH7SR/OHRbQRXHqAqecch2KqIGx5rbgQ+sh83sg7lflzk
 F2FQ==
X-Gm-Message-State: AOJu0YwBzyWKlYVDFgQN3+pGqXzMSymrtpuyYAc8W7e+uuEBXCdMaNlw
 lhUa7Ok6pNsZfJM/GF6BJ2CW13/tHXCDCKZl409YX7omz6mp7kGJyF5T1+AdnYmqvAZAuKujHki
 YN56msNVIijdmaefKlMwMXlv0Qi+KBaE0U9LUPf3luYn4/j5xmvlSqKIo0b5gmmOUO3R8KAa5pV
 er
X-Received: by 2002:a05:600c:511a:b0:40d:3b3f:603d with SMTP id
 o26-20020a05600c511a00b0040d3b3f603dmr3380407wms.41.1703584289540; 
 Tue, 26 Dec 2023 01:51:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXnnR7Ym5Vx48pictoS+FnHH5jctBY+Q47KusuO7dmKBvyrjSaw/ALgWcihxvrZF2x6B8SgA==
X-Received: by 2002:a05:600c:511a:b0:40d:3b3f:603d with SMTP id
 o26-20020a05600c511a00b0040d3b3f603dmr3380398wms.41.1703584289227; 
 Tue, 26 Dec 2023 01:51:29 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 r20-20020a05600c459400b0040c3dcc36e6sm20016130wmo.47.2023.12.26.01.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 01:51:28 -0800 (PST)
Date: Tue, 26 Dec 2023 04:51:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dongli Zhang <dongli.zhang@oracle.com>, Feng Li <fengli@smartx.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL 06/21] vhost-scsi: fix usage of error_reportf_err()
Message-ID: <9a557b1b226293aed3f06bd035cf87094d69ea8d.1703582625.git.mst@redhat.com>
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

From: Dongli Zhang <dongli.zhang@oracle.com>

It is required to use error_report() instead of error_reportf_err(), if the
prior function does not take local_err as the argument. As a result, the
local_err is always NULL and segment fault may happen.

vhost_scsi_start()
-> vhost_scsi_set_endpoint(s) --> does not allocate local_err
-> error_reportf_err()
   -> error_vprepend()
      -> g_string_append(newmsg, (*errp)->msg) --> (*errp) is NULL

In addition, add ": " at the end of other error_reportf_err() logs.

Fixes: 7962e432b4e4 ("vhost-user-scsi: support reconnect to backend")
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Message-Id: <20231214003117.43960-1-dongli.zhang@oracle.com>
Reviewed-by: Feng Li <fengli@smartx.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/scsi/vhost-scsi.c      | 4 ++--
 hw/scsi/vhost-user-scsi.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 08aa7534df..6159eb6fec 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -91,13 +91,13 @@ static int vhost_scsi_start(VHostSCSI *s)
 
     ret = vhost_scsi_common_start(vsc, &local_err);
     if (ret < 0) {
-        error_reportf_err(local_err, "Error starting vhost-scsi");
+        error_reportf_err(local_err, "Error starting vhost-scsi: ");
         return ret;
     }
 
     ret = vhost_scsi_set_endpoint(s);
     if (ret < 0) {
-        error_reportf_err(local_err, "Error setting vhost-scsi endpoint");
+        error_report("Error setting vhost-scsi endpoint");
         vhost_scsi_common_stop(vsc);
     }
 
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 780f10559d..af18c4f3d3 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -83,7 +83,8 @@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
     if (should_start) {
         ret = vhost_user_scsi_start(s, &local_err);
         if (ret < 0) {
-            error_reportf_err(local_err, "unable to start vhost-user-scsi: %s",
+            error_reportf_err(local_err,
+                              "unable to start vhost-user-scsi: %s: ",
                               strerror(-ret));
             qemu_chr_fe_disconnect(&vs->conf.chardev);
         }
-- 
MST


