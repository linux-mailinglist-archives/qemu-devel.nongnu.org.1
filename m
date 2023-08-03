Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7CB76F5A1
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:22:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRggs-0004L1-97; Thu, 03 Aug 2023 18:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRggr-0004Kr-3j
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRggp-0000QC-Iz
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691101262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rfS68BxaotrRZ6rq9fMIsPSxLCjq1HfC2TQN4nwt15g=;
 b=Qz2mLB02OiiyHQT7qplrXSVk8PkDDiblVUNFx2OxnmXXaqwOgObKliT6viQB7ZhExTFgz9
 SXft6r+VRuG3JQaeX057/CVzjgWUUPch+dTJ0wzbftuxkvybMqnzhSE6kQ3Mc9kH7PLrmJ
 5nBgm0YFnD0Bn4flLsi+s6MjJQza4xs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-l022SgsJOymDqsLYBePAdA-1; Thu, 03 Aug 2023 18:21:01 -0400
X-MC-Unique: l022SgsJOymDqsLYBePAdA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-993d5006993so97066066b.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 15:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691101260; x=1691706060;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rfS68BxaotrRZ6rq9fMIsPSxLCjq1HfC2TQN4nwt15g=;
 b=l1T0T6W3hnyJ/NO++V/UkylyAyQ22bg/ahP9o7JT4TDQCvQfIeTqT5R5/UHKbs9vC0
 3Uyzac9RRfwy6osLt0xY3dUMJEVCUn6VEHijnLJHatv/EjWkMEjxOiInlSCqsfTPIEUp
 83wzJBzFHd6coDZj8TmJCiKacCN8U2cyQ1kaDi2W3KrfOIj5/WwvE/wNbHQ30WjTTcMG
 eSVX6MaK06kamtIZ9O6HmPZrMSVPjM5HtXtailuIcJeDMTol+G2CgfKQRqo8+cJkbpim
 FtHItCo4NgBFBBjIbm9AL33lZzuASEWq7PRB6EuKb14ABWXS2DxLSUaxPZckkgLwbdpg
 Lr8w==
X-Gm-Message-State: ABy/qLYLfMQJSo2jQzLU3jUl5vTbBCeUSaxj9akhJJqcj/nY8ANyEsY6
 CRH7EghS7WXqDx0BvKrqu6m29CkNAV+G8hRzp0+AMRmLyfwkHJ1dZQmb3DG9mNhCsTsEFFimFat
 ofpPH0fEyBTRnyDbVYlknlrExk3iWohbP9xT02eeqwKCT+fJ7y5U+Tt56O6KB3ldhR60g
X-Received: by 2002:a17:906:8a70:b0:994:577:f9df with SMTP id
 hy16-20020a1709068a7000b009940577f9dfmr8483818ejc.4.1691101259944; 
 Thu, 03 Aug 2023 15:20:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFHKJo8+OY6qZOtbj9t2tTRVK/UhmqS/lHjZS1T2Xd2ffRkczTgIezPwHOD3t1FG1eTjPNXDg==
X-Received: by 2002:a17:906:8a70:b0:994:577:f9df with SMTP id
 hy16-20020a1709068a7000b009940577f9dfmr8483805ejc.4.1691101259606; 
 Thu, 03 Aug 2023 15:20:59 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 v1-20020a17090606c100b0099293cdbc98sm375723ejb.145.2023.08.03.15.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 15:20:59 -0700 (PDT)
Date: Thu, 3 Aug 2023 18:20:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Milan Zamazal <mzamazal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 04/22] hw/virtio: Add a protection against duplicate
 vu_scmi_stop calls
Message-ID: <63a3520e29a1a68d8610315b049ccb5840fe22e9.1691101215.git.mst@redhat.com>
References: <cover.1691101215.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691101215.git.mst@redhat.com>
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

From: Milan Zamazal <mzamazal@redhat.com>

The QEMU CI fails in virtio-scmi test occasionally.  As reported by
Thomas Huth, this happens most likely when the system is loaded and it
fails with the following error:

  qemu-system-aarch64: ../../devel/qemu/hw/pci/msix.c:659:
  msix_unset_vector_notifiers: Assertion `dev->msix_vector_use_notifier && dev->msix_vector_release_notifier' failed.
  ../../devel/qemu/tests/qtest/libqtest.c:200: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)

As discovered by Fabiano Rosas, the cause is a duplicate invocation of
msix_unset_vector_notifiers via duplicate vu_scmi_stop calls:

  msix_unset_vector_notifiers
  virtio_pci_set_guest_notifiers
  vu_scmi_stop
  vu_scmi_disconnect
  ...
  qemu_chr_write_buffer

  msix_unset_vector_notifiers
  virtio_pci_set_guest_notifiers
  vu_scmi_stop
  vu_scmi_set_status
  ...
  qemu_cleanup

While vu_scmi_stop calls are protected by vhost_dev_is_started()
check, it's apparently not enough.  vhost-user-blk and vhost-user-gpio
use an extra protection, see f5b22d06fb (vhost: recheck dev state in
the vhost_migration_log routine) for the motivation.  Let's use the
same in vhost-user-scmi, which fixes the failure above.

Fixes: a5dab090e142 ("hw/virtio: Add boilerplate for vhost-user-scmi device")
Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
Message-Id: <20230720101037.2161450-1-mzamazal@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 include/hw/virtio/vhost-user-scmi.h | 1 +
 hw/virtio/vhost-user-scmi.c         | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/virtio/vhost-user-scmi.h b/include/hw/virtio/vhost-user-scmi.h
index 6175a74ebd..c90db77dd5 100644
--- a/include/hw/virtio/vhost-user-scmi.h
+++ b/include/hw/virtio/vhost-user-scmi.h
@@ -25,6 +25,7 @@ struct VHostUserSCMI {
     VirtQueue *cmd_vq;
     VirtQueue *event_vq;
     bool connected;
+    bool started_vu;
 };
 
 #endif /* _QEMU_VHOST_USER_SCMI_H */
diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index d386fb2df9..918bb7dcf7 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -63,6 +63,7 @@ static int vu_scmi_start(VirtIODevice *vdev)
         error_report("Error starting vhost-user-scmi: %d", ret);
         goto err_guest_notifiers;
     }
+    scmi->started_vu = true;
 
     /*
      * guest_notifier_mask/pending not used yet, so just unmask
@@ -90,6 +91,12 @@ static void vu_scmi_stop(VirtIODevice *vdev)
     struct vhost_dev *vhost_dev = &scmi->vhost_dev;
     int ret;
 
+    /* vhost_dev_is_started() check in the callers is not fully reliable. */
+    if (!scmi->started_vu) {
+        return;
+    }
+    scmi->started_vu = false;
+
     if (!k->set_guest_notifiers) {
         return;
     }
-- 
MST


