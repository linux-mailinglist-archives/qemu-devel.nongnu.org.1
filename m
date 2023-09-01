Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AF178FC96
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 13:45:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc2Zd-0005Er-Jh; Fri, 01 Sep 2023 07:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qc2ZV-0005Dn-G9
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 07:44:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qc2ZR-0006cW-Cv
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 07:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693568652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pqnU3r01l4dw5bR8qsKAbf7WjL/4AS4ln9SzPEhnayI=;
 b=VAL7T1Zgm//E3cZz4aLe4+OifMkHH0oYdLRph7GEr3wZypPDMHYjogXSx7kr8LfjjF6vaH
 1lhTLfoMFiBEwSJ0LPVKMK7OlobhH+osTQosX1qyVYYyKL+NOnpgjpleZjHAuksxboiXvO
 JNwMX64oecLyoOop2lS6aYd4+jXNzhM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-O16ilosHOY2mnEhADi4xog-1; Fri, 01 Sep 2023 07:44:08 -0400
X-MC-Unique: O16ilosHOY2mnEhADi4xog-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0350872922;
 Fri,  1 Sep 2023 11:44:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1933E49310F;
 Fri,  1 Sep 2023 11:44:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1241721E692A; Fri,  1 Sep 2023 13:44:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Li Feng <fengli@smartx.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Raphael Norwitz
 <raphael.norwitz@nutanix.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Fam
 Zheng <fam@euphon.net>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Viresh
 Kumar <viresh.kumar@linaro.org>,  qemu-block@nongnu.org (open list:Block
 layer core),  qemu-devel@nongnu.org (open list:All patches CC here)
Subject: Re: [PATCH v3 5/5] vhost-user-scsi: start vhost when guest kicks
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230731121018.2856310-1-fengli@smartx.com>
 <20230731121018.2856310-6-fengli@smartx.com>
Date: Fri, 01 Sep 2023 13:44:06 +0200
In-Reply-To: <20230731121018.2856310-6-fengli@smartx.com> (Li Feng's message
 of "Mon, 31 Jul 2023 20:10:10 +0800")
Message-ID: <87zg2686ex.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Let's keep the same behavior as vhost-user-blk.
>
> Some old guests kick virtqueue before setting VIRTIO_CONFIG_S_DRIVER_OK.
>
> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
>  hw/scsi/vhost-user-scsi.c | 48 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 4 deletions(-)
>
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index 5bf012461b..a7fa8e8df2 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -113,8 +113,48 @@ static void vhost_user_scsi_reset(VirtIODevice *vdev)
>      }
>  }
>  
> -static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> +static void vhost_user_scsi_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>  {
> +    VHostUserSCSI *s = (VHostUserSCSI *)vdev;
> +    DeviceState *dev = &s->parent_obj.parent_obj.parent_obj.parent_obj;
> +    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
> +    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
> +
> +    Error *local_err = NULL;
> +    int i, ret;
> +
> +    if (!vdev->start_on_kick) {
> +        return;
> +    }
> +
> +    if (!s->connected) {
> +        return;
> +    }
> +
> +    if (vhost_dev_is_started(&vsc->dev)) {
> +        return;
> +    }
> +
> +    /*
> +     * Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so start
> +     * vhost here instead of waiting for .set_status().
> +     */
> +    ret = vhost_user_scsi_start(s);
> +    if (ret < 0) {
> +        error_reportf_err(local_err, "vhost-user-scsi: vhost start failed: ");

Crashes, since @local_err is null.  Please test your error paths.

Obvious fix: drop this call.

> +        qemu_chr_fe_disconnect(&vs->conf.chardev);
> +        return;
> +    }
> +
> +    /* Kick right away to begin processing requests already in vring */
> +    for (i = 0; i < vsc->dev.nvqs; i++) {
> +        VirtQueue *kick_vq = virtio_get_queue(vdev, i);
> +
> +        if (!virtio_queue_get_desc_addr(vdev, i)) {
> +            continue;
> +        }
> +        event_notifier_set(virtio_queue_get_host_notifier(kick_vq));
> +    }
>  }
>  
>  static int vhost_user_scsi_connect(DeviceState *dev, Error **errp)
> @@ -243,9 +283,9 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    virtio_scsi_common_realize(dev, vhost_dummy_handle_output,
> -                               vhost_dummy_handle_output,
> -                               vhost_dummy_handle_output, &err);
> +    virtio_scsi_common_realize(dev, vhost_user_scsi_handle_output,
> +                               vhost_user_scsi_handle_output,
> +                               vhost_user_scsi_handle_output, &err);
>      if (err != NULL) {
>          error_propagate(errp, err);
>          return;


