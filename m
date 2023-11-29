Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF9E7FD2C1
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 10:31:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Gts-0006kz-S3; Wed, 29 Nov 2023 04:30:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1r8Gtm-0006kK-Ja
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 04:30:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1r8Gtk-0003iF-SP
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 04:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701250223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0lG+Bx1+h8P3OS0xZFhTt4Hj8iqnZji3+hAOsfR6Zag=;
 b=PAbiG+ZqmpxXosXLCcOTZQcPmu6RRM4hXWG2RXe3RXaAi2DfEQuI6prbFp8CLKaeAVduHY
 uv19i9gfQvJuOPPESvV0z81LzGbcdul1ta3OCIyzx6/jS0TA2ZBLO1l6ZMYRaJybXRS4OG
 L62mC6Wc61rAmig7mRtYKXNYxCqgbPw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-QZacsZe5M7WLXc92kjwM5Q-1; Wed, 29 Nov 2023 04:30:21 -0500
X-MC-Unique: QZacsZe5M7WLXc92kjwM5Q-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-67a68137c7dso8075586d6.0
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 01:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701250221; x=1701855021;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0lG+Bx1+h8P3OS0xZFhTt4Hj8iqnZji3+hAOsfR6Zag=;
 b=CWxYpG2OieOhHc8WgZMTFh9Qy6fKjkoOMcKrq64uRB844bWeW8ZsWqaB+YdYjXoKNR
 j/hJtdSw9lSOkiV5WxD3NadEhG/DLVFSrU82w0a+5SGqVUX2PHpE1vGZhQvTI+70Bpsr
 YuZ1bpZ9EwQl7vbv4sUUrXczFrLtJTE/Yyq36cJZPCWOjT66SWnGRHXhw5Mw4uI54awy
 c2AE06t7Dy5eZeu+aAtAgPgpMPicB+H0FenFG8PgF4AQSSF63j6xuQG5+XVX8IFp0zR2
 l82LxTIiBF64Au0MPogaL5OX7ahWwu3fXHUTSoE7vYhbKzA0re328Y/smZDBX8QX8JwM
 GoAw==
X-Gm-Message-State: AOJu0YzAriTeVyElJalaDWCq+rG8t+g2FgCqY3SlLGnCJNlxh44G7Xw5
 MgdpMIF0/VsldMVrHxU086mHdNxageBzFec6ROWkO4B3DQ6MVKzQoWt7HXh5Ravf9PekWVvn3tD
 rcHS6lo7Oueu4ZZk=
X-Received: by 2002:a0c:f849:0:b0:67a:3f6f:d2e8 with SMTP id
 g9-20020a0cf849000000b0067a3f6fd2e8mr10207540qvo.32.1701250221255; 
 Wed, 29 Nov 2023 01:30:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOvJYjb1RJt31znEK0ZlvEVRdJ69xFGzV7YXwXjvF86i+YvWhXayEyByTwi8F28C/IGyMFxQ==
X-Received: by 2002:a0c:f849:0:b0:67a:3f6f:d2e8 with SMTP id
 g9-20020a0cf849000000b0067a3f6fd2e8mr10207523qvo.32.1701250220986; 
 Wed, 29 Nov 2023 01:30:20 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-199.retail.telecomitalia.it.
 [79.46.200.199]) by smtp.gmail.com with ESMTPSA id
 q10-20020a0cfa0a000000b0067a28752199sm4159972qvn.10.2023.11.29.01.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 01:30:20 -0800 (PST)
Date: Wed, 29 Nov 2023 10:30:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: fam@euphon.net, stefanha@redhat.com, jasowang@redhat.com, 
 mst@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/2] vhost-scsi: Add support for a worker thread per
 virtqueue
Message-ID: <kz5krs3kyhhurm7qa7b3alpnakkusbazmturdhamvu3vkmrurm@xxa3edifnphp>
References: <20231127002834.8670-1-michael.christie@oracle.com>
 <20231127002834.8670-3-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231127002834.8670-3-michael.christie@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Sun, Nov 26, 2023 at 06:28:34PM -0600, Mike Christie wrote:
>This adds support for vhost-scsi to be able to create a worker thread
>per virtqueue. Right now for vhost-net we get a worker thread per
>tx/rx virtqueue pair which scales nicely as we add more virtqueues and
>CPUs, but for scsi we get the single worker thread that's shared by all
>virtqueues. When trying to send IO to more than 2 virtqueues the single
>thread becomes a bottlneck.
>
>This patch adds a new setting, workers_per_virtqueue, which can be set
>to:
>
>false: Existing behavior where we get the single worker thread.
>true: Create a worker per IO virtqueue.
>
>Signed-off-by: Mike Christie <michael.christie@oracle.com>
>---
> hw/scsi/vhost-scsi.c            | 60 +++++++++++++++++++++++++++++++++
> include/hw/virtio/virtio-scsi.h |  1 +
> 2 files changed, 61 insertions(+)
>
>diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
>index 3126df9e1d9d..77eef9474c23 100644
>--- a/hw/scsi/vhost-scsi.c
>+++ b/hw/scsi/vhost-scsi.c
>@@ -165,6 +165,57 @@ static const VMStateDescription vmstate_virtio_vhost_scsi = {
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

IIUC here the user has asked to use a worker for each virtqueue, but the
kernel does not support it so we ignore it.

Should we at least print a warning?

The rest LGTM!

Stefano

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
>@@ -232,6 +283,13 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
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
>@@ -297,6 +355,8 @@ static Property vhost_scsi_properties[] = {
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


