Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79572805044
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 11:36:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rASlK-0002Na-9w; Tue, 05 Dec 2023 05:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rASlE-0002NH-DF
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 05:34:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rASlC-0001Ve-NZ
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 05:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701772476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K7khFF0sbykBHafzuxFO2C1DSkAwZjR0dQR6s9k30GQ=;
 b=ZrIjEVGGLZRELkB0TXYgEtohm6HmKqLABJdbGmtSjlTmo0d0W9pXibJJ0ktLl7S9Fgfz6Y
 L0cVu3njq/kPCktTlyIOGJQO97ngiyMx+WwAudKM5cVjjk1ghUS7IniUx+/2nXtB15aCzd
 U5KTaGjYrWXMHHKxMqhscdTBOmFyyUc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-3lIa3fQ5NOCmeAunpIX7aQ-1; Tue, 05 Dec 2023 05:34:32 -0500
X-MC-Unique: 3lIa3fQ5NOCmeAunpIX7aQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a018014e8e5so448041466b.2
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 02:34:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701772471; x=1702377271;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K7khFF0sbykBHafzuxFO2C1DSkAwZjR0dQR6s9k30GQ=;
 b=Chyd7lLwMRXdF5tKFs+EcxfDFOe2uB1EX6I2eFydOxilewfl2ziHonyYhMpMbal3g7
 7hrDO/yF6RpSrx8Y/cqBFhutBjvRyLXLXYDmgrhlsy6TxpzynLFGPy79VKs2G2XJeJMg
 oAdL9irJEGEu8GoFhLXZ5QD9kjubsaJ9qxZJJOvuzJr6j5MPr4mbUvEV7Q5yUNq0Nz54
 WN/RuzPxMBJBxlDcgkTiFzDqdkF9Ifl35FqyD11S46TGDf2l8pNBFNF6/3PFxLP+UHsR
 vYySovVMlPdu1a24ggCj1RCva6UzDxaWrOHPgB7T+vcYetUe//YMC1KNpPtB+qbd0wUW
 M45A==
X-Gm-Message-State: AOJu0YyF0HUkBd0pF5P0NtogqJhACCTH9UBSPgURax7O3QYF5lKvAegy
 3B/sKoG3lB7dB3ovD3tfPVC9XuyoJMJT7bF5a2DozY6NuzoLexufU3azZf1/QNuN3xNroTYZIyq
 svgmDWV3Us7xVNGk=
X-Received: by 2002:a17:906:2510:b0:a19:a19b:78d7 with SMTP id
 i16-20020a170906251000b00a19a19b78d7mr276167ejb.154.1701772471421; 
 Tue, 05 Dec 2023 02:34:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFT0LENtXuCvprapjCROjf9Twpgp9VH9vDekErEpDlz/9ymgaouTrcgI+Q/QHz2ufwhMJzSw==
X-Received: by 2002:a17:906:2510:b0:a19:a19b:78d7 with SMTP id
 i16-20020a170906251000b00a19a19b78d7mr276155ejb.154.1701772471034; 
 Tue, 05 Dec 2023 02:34:31 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-125.retail.telecomitalia.it.
 [79.46.200.125]) by smtp.gmail.com with ESMTPSA id
 hg1-20020a1709072cc100b00a1933a57960sm5903324ejc.22.2023.12.05.02.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 02:34:30 -0800 (PST)
Date: Tue, 5 Dec 2023 11:34:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: fam@euphon.net, stefanha@redhat.com, jasowang@redhat.com, 
 mst@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/2] vhost-scsi: Add support for a worker thread per
 virtqueue
Message-ID: <ufdvzammoiwjk36wj32ueeehiuv7ciih3f554x7jstkz26k6xc@uloplo4sf4zw>
References: <20231204231618.21962-1-michael.christie@oracle.com>
 <20231204231618.21962-3-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231204231618.21962-3-michael.christie@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

On Mon, Dec 04, 2023 at 05:16:18PM -0600, Mike Christie wrote:
>This adds support for vhost-scsi to be able to create a worker thread
>per virtqueue. Right now for vhost-net we get a worker thread per
>tx/rx virtqueue pair which scales nicely as we add more virtqueues and
>CPUs, but for scsi we get the single worker thread that's shared by all
>virtqueues. When trying to send IO to more than 2 virtqueues the single
>thread becomes a bottlneck.
>
>This patch adds a new setting, worker_per_virtqueue, which can be set
>to:
>
>false: Existing behavior where we get the single worker thread.
>true: Create a worker per IO virtqueue.
>
>Signed-off-by: Mike Christie <michael.christie@oracle.com>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>
>---
> hw/scsi/vhost-scsi.c            | 62 +++++++++++++++++++++++++++++++++
> include/hw/virtio/virtio-scsi.h |  1 +
> 2 files changed, 63 insertions(+)

Thank for adding the warning! LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
>index 3126df9e1d9d..08aa7534df51 100644
>--- a/hw/scsi/vhost-scsi.c
>+++ b/hw/scsi/vhost-scsi.c
>@@ -165,6 +165,59 @@ static const VMStateDescription vmstate_virtio_vhost_scsi = {
>     .pre_save = vhost_scsi_pre_save,
> };
>
>+static int vhost_scsi_set_workers(VHostSCSICommon *vsc, bool per_virtqueue)
>+{
>+    struct vhost_dev *dev = &vsc->dev;
>+    struct vhost_vring_worker vq_worker;
>+    struct vhost_worker_state worker;
>+    int i, ret;
>+
>+    /* Use default worker */
>+    if (!per_virtqueue || dev->nvqs == VHOST_SCSI_VQ_NUM_FIXED + 1) {
>+        return 0;
>+    }
>+
>+    /*
>+     * ctl/evt share the first worker since it will be rare for them
>+     * to send cmds while IO is running.
>+     */
>+    for (i = VHOST_SCSI_VQ_NUM_FIXED + 1; i < dev->nvqs; i++) {
>+        memset(&worker, 0, sizeof(worker));
>+
>+        ret = dev->vhost_ops->vhost_new_worker(dev, &worker);
>+        if (ret == -ENOTTY) {
>+            /*
>+             * worker ioctls are not implemented so just ignore and
>+             * and continue device setup.
>+             */
>+            warn_report("vhost-scsi: Backend supports a single worker. "
>+                        "Ignoring worker_per_virtqueue=true setting.");
>+            ret = 0;
>+            break;
>+        } else if (ret) {
>+            break;
>+        }
>+
>+        memset(&vq_worker, 0, sizeof(vq_worker));
>+        vq_worker.worker_id = worker.worker_id;
>+        vq_worker.index = i;
>+
>+        ret = dev->vhost_ops->vhost_attach_vring_worker(dev, &vq_worker);
>+        if (ret == -ENOTTY) {
>+            /*
>+             * It's a bug for the kernel to have supported the worker creation
>+             * ioctl but not attach.
>+             */
>+            dev->vhost_ops->vhost_free_worker(dev, &worker);
>+            break;
>+        } else if (ret) {
>+            break;
>+        }
>+    }
>+
>+    return ret;
>+}
>+
> static void vhost_scsi_realize(DeviceState *dev, Error **errp)
> {
>     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
>@@ -232,6 +285,13 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
>         goto free_vqs;
>     }
>
>+    ret = vhost_scsi_set_workers(vsc, vs->conf.worker_per_virtqueue);
>+    if (ret < 0) {
>+        error_setg(errp, "vhost-scsi: vhost worker setup failed: %s",
>+                   strerror(-ret));
>+        goto free_vqs;
>+    }
>+
>     /* At present, channel and lun both are 0 for bootable vhost-scsi disk */
>     vsc->channel = 0;
>     vsc->lun = 0;
>@@ -297,6 +357,8 @@ static Property vhost_scsi_properties[] = {
>                                                  VIRTIO_SCSI_F_T10_PI,
>                                                  false),
>     DEFINE_PROP_BOOL("migratable", VHostSCSICommon, migratable, false),
>+    DEFINE_PROP_BOOL("worker_per_virtqueue", VirtIOSCSICommon,
>+                     conf.worker_per_virtqueue, false),
>     DEFINE_PROP_END_OF_LIST(),
> };
>
>diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
>index 779568ab5d28..0e9a1867665e 100644
>--- a/include/hw/virtio/virtio-scsi.h
>+++ b/include/hw/virtio/virtio-scsi.h
>@@ -51,6 +51,7 @@ typedef struct virtio_scsi_config VirtIOSCSIConfig;
> struct VirtIOSCSIConf {
>     uint32_t num_queues;
>     uint32_t virtqueue_size;
>+    bool worker_per_virtqueue;
>     bool seg_max_adjust;
>     uint32_t max_sectors;
>     uint32_t cmd_per_lun;
>-- 
>2.34.1
>


