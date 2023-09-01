Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5DC78FCDC
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 14:02:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc2qd-0006dQ-SA; Fri, 01 Sep 2023 08:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qc2ph-0006Dx-8m
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 08:01:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qc2pd-0001ll-LI
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 08:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693569655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CCAA6J3rL7iCZJliIvNSfqNUOpnGkvsOpQIjeqk/1BA=;
 b=KZezB2O3TPW8pf/I757PkuGfZS5c191GNE7rCo6bZ07bBKa4173q0KGpfn0J7w76GRVJe/
 NDtVuXNVPGNtckK10JOajbjFpOTR+mgLPXQL8TEMg700Vn+UhxuvXmG68ygwSWLPgy4odQ
 dd90tDyaDF5838o2XtRfk8hH92IvZeU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-CSTU8kEOMDCNTY2C2ahr3g-1; Fri, 01 Sep 2023 08:00:52 -0400
X-MC-Unique: CSTU8kEOMDCNTY2C2ahr3g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCADC85651F;
 Fri,  1 Sep 2023 12:00:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A026921D4F3D;
 Fri,  1 Sep 2023 12:00:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A7FFE21E692A; Fri,  1 Sep 2023 14:00:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Li Feng <fengli@smartx.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Raphael Norwitz
 <raphael.norwitz@nutanix.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Fam
 Zheng <fam@euphon.net>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Viresh
 Kumar <viresh.kumar@linaro.org>,  qemu-block@nongnu.org (open list:Block
 layer core),  qemu-devel@nongnu.org (open list:All patches CC here)
Subject: Re: [PATCH v3 2/2] vhost: Add Error parameter to
 vhost_scsi_common_start()
References: <20230804052954.2918915-1-fengli@smartx.com>
 <20230830045722.611224-1-fengli@smartx.com>
 <20230830045722.611224-3-fengli@smartx.com>
Date: Fri, 01 Sep 2023 14:00:50 +0200
In-Reply-To: <20230830045722.611224-3-fengli@smartx.com> (Li Feng's message of
 "Wed, 30 Aug 2023 12:57:14 +0800")
Message-ID: <877cpa85n1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Li Feng <fengli@smartx.com> writes:

> Add a Error parameter to report the real error, like vhost-user-blk.
>
> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
>  hw/scsi/vhost-scsi-common.c           | 16 +++++++++-------
>  hw/scsi/vhost-scsi.c                  |  5 +++--
>  hw/scsi/vhost-user-scsi.c             | 14 ++++++++------
>  include/hw/virtio/vhost-scsi-common.h |  2 +-
>  4 files changed, 21 insertions(+), 16 deletions(-)
>
> diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
> index a61cd0e907..4c8637045d 100644
> --- a/hw/scsi/vhost-scsi-common.c
> +++ b/hw/scsi/vhost-scsi-common.c
> @@ -16,6 +16,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
>  #include "hw/virtio/vhost.h"
> @@ -25,7 +26,7 @@
>  #include "hw/virtio/virtio-access.h"
>  #include "hw/fw-path-provider.h"
>  
> -int vhost_scsi_common_start(VHostSCSICommon *vsc)
> +int vhost_scsi_common_start(VHostSCSICommon *vsc, Error **errp)
>  {
>      int ret, i;
>      VirtIODevice *vdev = VIRTIO_DEVICE(vsc);
> @@ -35,18 +36,19 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>      VirtIOSCSICommon *vs = (VirtIOSCSICommon *)vsc;
>  
>      if (!k->set_guest_notifiers) {
> -        error_report("binding does not support guest notifiers");
> +        error_setg(errp, "binding does not support guest notifiers");
>          return -ENOSYS;
>      }
>  
>      ret = vhost_dev_enable_notifiers(&vsc->dev, vdev);
>      if (ret < 0) {
> +        error_setg_errno(errp, -ret, "Error enabling host notifiers");

Looks like the error is silent before your patch.  Correct?

>          return ret;
>      }
>  
>      ret = k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, true);
>      if (ret < 0) {
> -        error_report("Error binding guest notifier");
> +        error_setg_errno(errp, -ret, "Error binding guest notifier");

Error message now provides more detail.

>          goto err_host_notifiers;
>      }
>  
> @@ -54,7 +56,7 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>  
>      ret = vhost_dev_prepare_inflight(&vsc->dev, vdev);
>      if (ret < 0) {
> -        error_report("Error setting inflight format: %d", -ret);
> +        error_setg_errno(errp, -ret, "Error setting inflight format");

Error message now shows errno in human-readable form.

>          goto err_guest_notifiers;
>      }
>  
> @@ -64,21 +66,21 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>                                          vs->conf.virtqueue_size,
>                                          vsc->inflight);
>              if (ret < 0) {
> -                error_report("Error getting inflight: %d", -ret);
> +                error_setg_errno(errp, -ret, "Error getting inflight");

Likewise.

>                  goto err_guest_notifiers;
>              }
>          }
>  
>          ret = vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
>          if (ret < 0) {
> -            error_report("Error setting inflight: %d", -ret);
> +            error_setg_errno(errp, -ret, "Error setting inflight");

Likewise.

>              goto err_guest_notifiers;
>          }
>      }
>  
>      ret = vhost_dev_start(&vsc->dev, vdev, true);
>      if (ret < 0) {
> -        error_report("Error start vhost dev");
> +        error_setg_errno(errp, -ret, "Error starting vhost dev");

Likewise.

>          goto err_guest_notifiers;
>      }
>  
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index 443f67daa4..01a3ab4277 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -75,6 +75,7 @@ static int vhost_scsi_start(VHostSCSI *s)
>      int ret, abi_version;
>      VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
>      const VhostOps *vhost_ops = vsc->dev.vhost_ops;
> +    Error *local_err = NULL;
>  
>      ret = vhost_ops->vhost_scsi_get_abi_version(&vsc->dev, &abi_version);
>      if (ret < 0) {
> @@ -88,14 +89,14 @@ static int vhost_scsi_start(VHostSCSI *s)
>          return -ENOSYS;
>      }
>  
> -    ret = vhost_scsi_common_start(vsc);
> +    ret = vhost_scsi_common_start(vsc, &local_err);
>      if (ret < 0) {
>          return ret;
>      }
>  
>      ret = vhost_scsi_set_endpoint(s);
>      if (ret < 0) {
> -        error_report("Error setting vhost-scsi endpoint");
> +        error_reportf_err(local_err, "Error setting vhost-scsi endpoint");
>          vhost_scsi_common_stop(vsc);
>      }
>  
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index e931df9f5b..62fc98bb1c 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -43,12 +43,12 @@ enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
>  };
>  
> -static int vhost_user_scsi_start(VHostUserSCSI *s)
> +static int vhost_user_scsi_start(VHostUserSCSI *s, Error **errp)
>  {
>      VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
>      int ret;
>  
> -    ret = vhost_scsi_common_start(vsc);
> +    ret = vhost_scsi_common_start(vsc, errp);
>      s->started_vu = (ret < 0 ? false : true);
>  
>      return ret;
> @@ -73,6 +73,7 @@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
>      VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
>      VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
>      bool should_start = virtio_device_should_start(vdev, status);
> +    Error *local_err = NULL;
>      int ret;
>  
>      if (!s->connected) {
> @@ -84,9 +85,10 @@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
>      }
>  
>      if (should_start) {
> -        ret = vhost_user_scsi_start(s);
> +        ret = vhost_user_scsi_start(s, &local_err);
>          if (ret < 0) {
> -            error_report("unable to start vhost-user-scsi: %s", strerror(-ret));
> +            error_reportf_err(local_err, "unable to start vhost-user-scsi: %s",
> +                              strerror(-ret));
>              qemu_chr_fe_disconnect(&vs->conf.chardev);
>          }
>      } else {
> @@ -139,7 +141,7 @@ static void vhost_user_scsi_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>       * Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so start
>       * vhost here instead of waiting for .set_status().
>       */
> -    ret = vhost_user_scsi_start(s);
> +    ret = vhost_user_scsi_start(s, &local_err);
>      if (ret < 0) {
>          error_reportf_err(local_err, "vhost-user-scsi: vhost start failed: ");

The error_reportf_err() is wrong before the patch, as I just pointed out
in my review of "[PATCH v3 5/5] vhost-user-scsi: start vhost when guest
kicks".  It is correct afterwards.

>          qemu_chr_fe_disconnect(&vs->conf.chardev);
> @@ -184,7 +186,7 @@ static int vhost_user_scsi_connect(DeviceState *dev, Error **errp)
>  
>      /* restore vhost state */
>      if (virtio_device_started(vdev, vdev->status)) {
> -        ret = vhost_user_scsi_start(s);
> +        ret = vhost_user_scsi_start(s, errp);
>          if (ret < 0) {
>              return ret;
>          }

Wrong before the patch, as I just pointed out in my review of "[PATCH v3
4/5] vhost-user-scsi: support reconnect to backend".  Correct afterwards.

> diff --git a/include/hw/virtio/vhost-scsi-common.h b/include/hw/virtio/vhost-scsi-common.h
> index 18f115527c..c5d2c09455 100644
> --- a/include/hw/virtio/vhost-scsi-common.h
> +++ b/include/hw/virtio/vhost-scsi-common.h
> @@ -39,7 +39,7 @@ struct VHostSCSICommon {
>      struct vhost_inflight *inflight;
>  };
>  
> -int vhost_scsi_common_start(VHostSCSICommon *vsc);
> +int vhost_scsi_common_start(VHostSCSICommon *vsc, Error **errp);
>  void vhost_scsi_common_stop(VHostSCSICommon *vsc);
>  char *vhost_scsi_common_get_fw_dev_path(FWPathProvider *p, BusState *bus,
>                                          DeviceState *dev);

Please mention in the commit message that error messages improve, and
silent errors are now reported.


