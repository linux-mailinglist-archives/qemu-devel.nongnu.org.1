Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 992B1849B8A
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Feb 2024 14:15:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWynG-0004Nx-CG; Mon, 05 Feb 2024 08:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rWynE-0004Nm-ED
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 08:13:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rWynC-0000RH-Jn
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 08:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707138824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NHjWwU5pNmP6LJPGA9QxCbiXhdl1LpJTNFkGocRuDKU=;
 b=JLGM63Ro0w43i/bDs532T8Zi7xfudm54dtROCj12E8lkbAwG6Pn7K3sQkbaxN99jNYxx2J
 RE01HG3yi7zZwIEYmQjurddqsQXWT0cwNsSeP8wUd0Qi0hwaW0NZPy1rV/kCPF3mwAbb3l
 sayvMwpt3S1U1dZoh2ImM94kbLnj76o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-3qCfcofaNyeooygq4V9oKA-1; Mon, 05 Feb 2024 08:13:43 -0500
X-MC-Unique: 3qCfcofaNyeooygq4V9oKA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C19C7848A67;
 Mon,  5 Feb 2024 13:13:42 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF41C492BC6;
 Mon,  5 Feb 2024 13:13:41 +0000 (UTC)
Date: Mon, 5 Feb 2024 14:13:40 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, eperezma@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] vdpa-dev: Fix initialisation order to restore VDUSE
 compatibility
Message-ID: <ZcDfBJLwxwN1agao@redhat.com>
References: <20240202132521.32714-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202132521.32714-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 02.02.2024 um 14:25 hat Kevin Wolf geschrieben:
> VDUSE requires that virtqueues are first enabled before the DRIVER_OK
> status flag is set; with the current API of the kernel module, it is
> impossible to enable the opposite order in our block export code because
> userspace is not notified when a virtqueue is enabled.
> 
> This requirement also mathces the normal initialisation order as done by
> the generic vhost code in QEMU. However, commit 6c482547 accidentally
> changed the order for vdpa-dev and broke access to VDUSE devices with
> this.
> 
> This changes vdpa-dev to use the normal order again and use the standard
> vhost callback .vhost_set_vring_enable for this. VDUSE devices can be
> used with vdpa-dev again after this fix.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 6c4825476a4351530bcac17abab72295b75ffe98
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/virtio/vdpa-dev.c   |  5 +----
>  hw/virtio/vhost-vdpa.c | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> index eb9ecea83b..13e87f06f6 100644
> --- a/hw/virtio/vdpa-dev.c
> +++ b/hw/virtio/vdpa-dev.c
> @@ -253,14 +253,11 @@ static int vhost_vdpa_device_start(VirtIODevice *vdev, Error **errp)
>  
>      s->dev.acked_features = vdev->guest_features;
>  
> -    ret = vhost_dev_start(&s->dev, vdev, false);
> +    ret = vhost_dev_start(&s->dev, vdev, true);
>      if (ret < 0) {
>          error_setg_errno(errp, -ret, "Error starting vhost");
>          goto err_guest_notifiers;
>      }
> -    for (i = 0; i < s->dev.nvqs; ++i) {
> -        vhost_vdpa_set_vring_ready(&s->vdpa, i);
> -    }
>      s->started = true;
>  
>      /*
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 3a43beb312..c4574d56c5 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -904,6 +904,22 @@ int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx)
>      return r;
>  }
>  
> +static int vhost_vdpa_set_vring_enable(struct vhost_dev *dev, int enable)
> +{
> +    struct vhost_vdpa *v = dev->opaque;
> +    unsigned int i;
> +    int ret;
> +
> +    for (i = 0; i < dev->nvqs; ++i) {
> +        ret = vhost_vdpa_set_vring_ready(v, i);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
> +
> +    return 0;
> +}

Oops, this forgets to actually use the @enable parameter, and always
enables the queue even if the caller wanted to disable it.

I'll fix this in a v2, but I'd first like to see if something has to
change to address Stefano's concern, too.

Kevin


