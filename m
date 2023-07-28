Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 826A17663F3
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 08:15:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPGaI-0007Zc-HB; Fri, 28 Jul 2023 02:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qPGaG-0007ZI-Q1
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 02:04:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qPGaF-0003el-4q
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 02:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690524253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QTOthJ+WNOkgZHJ+ob27X7QvS+Dkq2di6xZmoc1tRLE=;
 b=edrFgxojPOgli8mjwb9NJfM2vn4UaMeBFRwlZBynSzpCxlVL1SH3Xrk4e2SDqQ1e+dH2hC
 K0QgmbDefHKObi0NmeS7XueUKjZ82gcc9guX5itntbcoxYXM1XV+Sma6+3zTliuAfyg9Bq
 axVBdUIsAc8Fey6231wTYd4Oqam9fm0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-NcKetGKFMcShk5F6_kP3kA-1; Fri, 28 Jul 2023 02:04:11 -0400
X-MC-Unique: NcKetGKFMcShk5F6_kP3kA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-993c24f3246so241702866b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 23:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690524250; x=1691129050;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTOthJ+WNOkgZHJ+ob27X7QvS+Dkq2di6xZmoc1tRLE=;
 b=PMPpWBE6uw9PwQFdRFKsBb6f5YT+H2/FdXMrqn9hWrOWv/4x2+aUGU/vLPI6U1Dc51
 l5lKvQuRduhYjfyBw913JCASIu/CVpFEEg94Evu2haGBijX7NJBNTzlMnQIr/TLRnZbP
 Ei+8kh44QsE/+euV0Ra0L0asLmdrKRAq3aZQlPiaOkwIj4ZJ4W4LYIKmlYj/Zy5gN4kd
 ngP0uoEaZH0T89qOwk7IF2UC1OnEJvw3YRVI9COaY1QR0Scp0jUzkfSq4Sg/yEhOppfg
 1y3DeOLwxX9PfWdg3qyiULLrpD7I8Q67gKGaGN1BaFLQAkJbJ9I2dW1bpwQXAmjvP7PK
 JMgw==
X-Gm-Message-State: ABy/qLZhQXPzb6OGvS9EY6nSKIgwOZ+sqTyRnNOyyntXvWtUL0InRM+f
 unhdygfElCeeTgvTFUBH1AX8IMNn40LtmCTzGOAs8pIWDG668PLRwbMYjmUGE10rwIReoRdQ9U2
 VBD1TeaevODUJA68=
X-Received: by 2002:a17:907:a07a:b0:988:b61e:4219 with SMTP id
 ia26-20020a170907a07a00b00988b61e4219mr1673192ejc.29.1690524249970; 
 Thu, 27 Jul 2023 23:04:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHxexpFYycX+WhmbW1H3tCAMN00+iRMz/k1eP9+VbLwJyDSklfyxjySkhxIrJu7GLIAa/TtTA==
X-Received: by 2002:a17:907:a07a:b0:988:b61e:4219 with SMTP id
 ia26-20020a170907a07a00b00988b61e4219mr1673176ejc.29.1690524249687; 
 Thu, 27 Jul 2023 23:04:09 -0700 (PDT)
Received: from redhat.com ([2.52.14.22]) by smtp.gmail.com with ESMTPSA id
 sd26-20020a170906ce3a00b0099bc08862b6sm1653184ejb.171.2023.07.27.23.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 23:04:08 -0700 (PDT)
Date: Fri, 28 Jul 2023 02:04:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Feng <fengli@smartx.com>
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 2/4] vhost-user-common: send get_inflight_fd once
Message-ID: <20230728020156-mutt-send-email-mst@kernel.org>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230725104256.4861-1-fengli@smartx.com>
 <20230725104256.4861-3-fengli@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725104256.4861-3-fengli@smartx.com>
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

On Tue, Jul 25, 2023 at 06:42:45PM +0800, Li Feng wrote:
> Get_inflight_fd is sent only once. When reconnecting to the backend,
> qemu sent set_inflight_fd to the backend.

I don't understand what you are trying to say here.
Should be:
Currently ABCD. This is wrong/unnecessary because EFG. This patch HIJ.

> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
>  hw/scsi/vhost-scsi-common.c | 37 ++++++++++++++++++-------------------
>  1 file changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
> index a06f01af26..664adb15b4 100644
> --- a/hw/scsi/vhost-scsi-common.c
> +++ b/hw/scsi/vhost-scsi-common.c
> @@ -52,20 +52,28 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>  
>      vsc->dev.acked_features = vdev->guest_features;
>  
> -    assert(vsc->inflight == NULL);
> -    vsc->inflight = g_new0(struct vhost_inflight, 1);
> -    ret = vhost_dev_get_inflight(&vsc->dev,
> -                                 vs->conf.virtqueue_size,
> -                                 vsc->inflight);
> +    ret = vhost_dev_prepare_inflight(&vsc->dev, vdev);
>      if (ret < 0) {
> -        error_report("Error get inflight: %d", -ret);
> +        error_report("Error setting inflight format: %d", -ret);
>          goto err_guest_notifiers;
>      }
>  
> -    ret = vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
> -    if (ret < 0) {
> -        error_report("Error set inflight: %d", -ret);
> -        goto err_guest_notifiers;
> +    if (vsc->inflight) {
> +        if (!vsc->inflight->addr) {
> +            ret = vhost_dev_get_inflight(&vsc->dev,
> +                                        vs->conf.virtqueue_size,
> +                                        vsc->inflight);
> +            if (ret < 0) {
> +                error_report("Error get inflight: %d", -ret);

As long as you are fixing this - should be "getting inflight".

> +                goto err_guest_notifiers;
> +            }
> +        }
> +
> +        ret = vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
> +        if (ret < 0) {
> +            error_report("Error set inflight: %d", -ret);
> +            goto err_guest_notifiers;
> +        }
>      }
>  
>      ret = vhost_dev_start(&vsc->dev, vdev, true);
> @@ -85,9 +93,6 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
>      return ret;
>  
>  err_guest_notifiers:
> -    g_free(vsc->inflight);
> -    vsc->inflight = NULL;
> -
>      k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
>  err_host_notifiers:
>      vhost_dev_disable_notifiers(&vsc->dev, vdev);
> @@ -111,12 +116,6 @@ void vhost_scsi_common_stop(VHostSCSICommon *vsc)
>      }
>      assert(ret >= 0);
>  
> -    if (vsc->inflight) {
> -        vhost_dev_free_inflight(vsc->inflight);
> -        g_free(vsc->inflight);
> -        vsc->inflight = NULL;
> -    }
> -
>      vhost_dev_disable_notifiers(&vsc->dev, vdev);
>  }
>  
> -- 
> 2.41.0


