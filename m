Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC567EC164
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 12:44:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3EIg-0006Nw-9L; Wed, 15 Nov 2023 06:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1r3EId-0006Nl-1b
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 06:43:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1r3EIb-0007cG-Ar
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 06:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700048590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QWc1lrcTGjwAJ5dvhNSPHEycpcCTO0Frw0qcu3NP62Y=;
 b=DK8rPb/AyPGVFUc5Z+ssZrJjcDSkHhpMW3klcGD2d+wYC5Gc5NM2RFcjxGIbw5BkinOzVA
 cMea/fZbAclJmmM/8KyQkj1oodRR/u3pBHGJuSYzMbB1WHsVJXX6y3Z7tzaLCCfetVDgOM
 XCbkWdfy7Zh8sZ9bJJfUXm/wMQsDsos=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-Ti0009gzM1eR88LGqaqUWw-1; Wed, 15 Nov 2023 06:43:09 -0500
X-MC-Unique: Ti0009gzM1eR88LGqaqUWw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9c7f0a33afbso436022366b.3
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 03:43:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700048587; x=1700653387;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QWc1lrcTGjwAJ5dvhNSPHEycpcCTO0Frw0qcu3NP62Y=;
 b=ca/eGNG5SFB83ikoDt4l6j+Cnuum8AcBL72Nx+AdK9rIbA2pJMmXoekuH/f6dz4pqR
 EUThhSsDNQahbrlzgyiCiaIS2ZbBQCDhg8iwBVOOquV8q2qtrmv8Yod+KyzhiOebTEV6
 CJ1RGwuO1EI3HToTzR3UhzXswaT/zk582Akd7SjX3Qa+DUzBG8jtA3GL0O3vq4wMJ5lj
 oo5F1kd1BOJAKYWjuh4IQfYjVc3381CgQdX/qLEVefRefghEoRJ6EThuZ9BJfQJOWxhF
 Dk8EKUch1p9/Etx8OV9zymfNTfmCOSrKs0JTRRNoTvsYfZPxYAAx+5qYOfFDrz6NZAq7
 lQRw==
X-Gm-Message-State: AOJu0YzTINVcucTNAGOabMrvNCnFqB5b1LKtF/biZicwEkHeI3WH4Eo5
 7tVDW/Q9DkBwZSTaPO1e3zDVO9Dt6uTEhH2uKvEOk6pPblAkbKZo/iSccsY0hVpZDwgkJ2YNan+
 EIeXkhEFLIEOEEoYmSfy+rpU=
X-Received: by 2002:a17:906:a8d:b0:9c7:4d3e:1e50 with SMTP id
 y13-20020a1709060a8d00b009c74d3e1e50mr8398746ejf.76.1700048587738; 
 Wed, 15 Nov 2023 03:43:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/+y6yXUdpQNrMbFmbm4QW1DmVBE3NErh+LA3MLCvErd/1D0BNIPCUsbiGhc5g/yOoXBs78g==
X-Received: by 2002:a17:906:a8d:b0:9c7:4d3e:1e50 with SMTP id
 y13-20020a1709060a8d00b009c74d3e1e50mr8398734ejf.76.1700048587390; 
 Wed, 15 Nov 2023 03:43:07 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-199.retail.telecomitalia.it.
 [79.46.200.199]) by smtp.gmail.com with ESMTPSA id
 dx9-20020a170906a84900b009c3828fec06sm6903630ejb.81.2023.11.15.03.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 03:43:06 -0800 (PST)
Date: Wed, 15 Nov 2023 12:43:02 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: fam@euphon.net, stefanha@redhat.com, jasowang@redhat.com, 
 mst@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] vhost-scsi: Add support for a worker thread per
 virtqueue
Message-ID: <bucsvfqgs73w73tt4l5z35smccpebjq36hcozpgrkeydm3jumj@zisakm4noecq>
References: <20231114003644.7026-1-michael.christie@oracle.com>
 <20231114003644.7026-3-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231114003644.7026-3-michael.christie@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 13, 2023 at 06:36:44PM -0600, Mike Christie wrote:
>This adds support for vhost-scsi to be able to create a worker thread
>per virtqueue. Right now for vhost-net we get a worker thread per
>tx/rx virtqueue pair which scales nicely as we add more virtqueues and
>CPUs, but for scsi we get the single worker thread that's shared by all
>virtqueues. When trying to send IO to more than 2 virtqueues the single
>thread becomes a bottlneck.
>
>This patch adds a new setting, virtqueue_workers, which can be set to:
>
>1: Existing behavior whre we get the single thread.
>-1: Create a worker per IO virtqueue.

I find this setting a bit odd. What about a boolean instead?

`per_virtqueue_workers`:
     false: Existing behavior whre we get the single thread.
     true: Create a worker per IO virtqueue.

>
>Signed-off-by: Mike Christie <michael.christie@oracle.com>
>---
> hw/scsi/vhost-scsi.c            | 68 +++++++++++++++++++++++++++++++++
> include/hw/virtio/virtio-scsi.h |  1 +
> 2 files changed, 69 insertions(+)
>
>diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
>index 3126df9e1d9d..5cf669b6563b 100644
>--- a/hw/scsi/vhost-scsi.c
>+++ b/hw/scsi/vhost-scsi.c
>@@ -31,6 +31,9 @@
> #include "qemu/cutils.h"
> #include "sysemu/sysemu.h"
>
>+#define VHOST_SCSI_WORKER_PER_VQ    -1
>+#define VHOST_SCSI_WORKER_DEF        1
>+
> /* Features supported by host kernel. */
> static const int kernel_feature_bits[] = {
>     VIRTIO_F_NOTIFY_ON_EMPTY,
>@@ -165,6 +168,62 @@ static const VMStateDescription vmstate_virtio_vhost_scsi = {
>     .pre_save = vhost_scsi_pre_save,
> };
>
>+static int vhost_scsi_set_workers(VHostSCSICommon *vsc, int workers_cnt)
>+{
>+    struct vhost_dev *dev = &vsc->dev;
>+    struct vhost_vring_worker vq_worker;
>+    struct vhost_worker_state worker;
>+    int i, ret;
>+
>+    /* Use default worker */
>+    if (workers_cnt == VHOST_SCSI_WORKER_DEF ||
>+        dev->nvqs == VHOST_SCSI_VQ_NUM_FIXED + 1) {
>+        return 0;
>+    }
>+
>+    if (workers_cnt != VHOST_SCSI_WORKER_PER_VQ) {
>+        return -EINVAL;
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

Should we call vhost_free_worker() in the vhost_scsi_unrealize() or are
workers automatically freed when `vhostfd` is closed?

The rest LGTM.

Thanks,
Stefano

>+        if (ret == -ENOTTY) {
>+            /*
>+             * worker ioctls are not implemented so just ignore and
>+             * and continue device setup.
>+             */
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
>@@ -232,6 +291,13 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
>         goto free_vqs;
>     }
>
>+    ret = vhost_scsi_set_workers(vsc, vs->conf.virtqueue_workers);
>+    if (ret < 0) {
>+        error_setg(errp, "vhost-scsi: vhost worker setup failed: %s",
>+                   strerror(-ret));
>+        goto free_vqs;
>+    }
>+
>     /* At present, channel and lun both are 0 for bootable vhost-scsi disk */
>     vsc->channel = 0;
>     vsc->lun = 0;
>@@ -297,6 +363,8 @@ static Property vhost_scsi_properties[] = {
>                                                  VIRTIO_SCSI_F_T10_PI,
>                                                  false),
>     DEFINE_PROP_BOOL("migratable", VHostSCSICommon, migratable, false),
>+    DEFINE_PROP_INT32("virtqueue_workers", VirtIOSCSICommon,
>+                      conf.virtqueue_workers, VHOST_SCSI_WORKER_DEF),
>     DEFINE_PROP_END_OF_LIST(),
> };
>
>diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
>index 779568ab5d28..f70624ece564 100644
>--- a/include/hw/virtio/virtio-scsi.h
>+++ b/include/hw/virtio/virtio-scsi.h
>@@ -51,6 +51,7 @@ typedef struct virtio_scsi_config VirtIOSCSIConfig;
> struct VirtIOSCSIConf {
>     uint32_t num_queues;
>     uint32_t virtqueue_size;
>+    int virtqueue_workers;
>     bool seg_max_adjust;
>     uint32_t max_sectors;
>     uint32_t cmd_per_lun;
>-- 
>2.34.1
>


