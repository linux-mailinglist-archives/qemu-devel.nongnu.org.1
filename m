Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 232EB7B7B63
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:12:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxqe-0000yC-5E; Wed, 04 Oct 2023 05:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxqP-0000GD-2V
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:07:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxq9-0007Lf-LM
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696410404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xpsr8FBMtvFLAG8/6szkpUYl6AW7uRdDeMMdwZWpLsg=;
 b=GiUGwAU8uJuSosiceDLQTcYk2ewfMl9PR9MUxhifMEyxhCl6BN0wn/6t4TQPM99Avnuylr
 6uOG3mlZ+L9OeVOwu5S1tbsFIe7p7fviGWqe4J/SUyZuzLHhcIxTBNUhKtT0mcLjKJJMxL
 +Gd5B/vSQEGrquzfC0nOqjBdRgVLM84=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-NBEzP07pM-iYs6vMUC_5fg-1; Wed, 04 Oct 2023 05:06:43 -0400
X-MC-Unique: NBEzP07pM-iYs6vMUC_5fg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-321f75cf2bdso1343640f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 02:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696410402; x=1697015202;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xpsr8FBMtvFLAG8/6szkpUYl6AW7uRdDeMMdwZWpLsg=;
 b=Qc2XFhauVeLxZLCMoTWbQ3pr7DzKIaUeB8s3WWx1lIMFg5ZVponZSFm6o/o78FHZ7y
 ZROCBll5Hlkg++KTEjXcsSnHxJ8TNbV6k26zJVX05IRwYxdwlbHBefxnmnCCe4v5JiO8
 D5G7ERJvsltBLDy5tHUGgr0MK89k68KGy4+fxyOTPDjWy8JWcCIHRBB8ImdRE0dK37GV
 FZ0tilw59V1xyv6z5qsvhl1OgfD7MmVzfU4pkfdw5+duqS9QiDcoOjmS20xRW0VA7mA0
 kcpNbFHuGr22smaWZSe1jwwBGET/N8V6gTHPbXDlRitF+f2bzUdSI/M7EgdDv5aTlHkz
 fymg==
X-Gm-Message-State: AOJu0Yxx6as9a9oGX0ckKstOudYfvxkMEshKoj9iNGzFe5UpRJ4Iu2+M
 L6Ke2v2RCwz7LoSXo8Gpzqo8n4Z3HzRXKAdYK9L4/jeNmSLPBkk4BY+hN/xr/5/YyfyCfHL3+qO
 TY6G+EsM4YGTBwgY=
X-Received: by 2002:adf:f005:0:b0:326:c623:3bbf with SMTP id
 j5-20020adff005000000b00326c6233bbfmr1619637wro.26.1696410402173; 
 Wed, 04 Oct 2023 02:06:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKTzeEXLfUskYS3Mh7V5xiRtfb6rfaCiXzcG5zb2P5uhmJi+VyBScUix5Pn/N9uQ5AP1E4eA==
X-Received: by 2002:adf:f005:0:b0:326:c623:3bbf with SMTP id
 j5-20020adff005000000b00326c6233bbfmr1619620wro.26.1696410401834; 
 Wed, 04 Oct 2023 02:06:41 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 c4-20020a5d4f04000000b0031773a8e5c4sm3469131wru.37.2023.10.04.02.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 02:06:41 -0700 (PDT)
Date: Wed, 4 Oct 2023 05:06:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v3 1/7] vhost-user: strip superfluous whitespace
Message-ID: <20231004050519-mutt-send-email-mst@kernel.org>
References: <20231002203221.17241-1-lersek@redhat.com>
 <20231002203221.17241-2-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231002203221.17241-2-lersek@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 02, 2023 at 10:32:15PM +0200, Laszlo Ersek wrote:
> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)

why the (supporter:vhost) part? not all scripts will cope
well with text after the mail. If you really want to keep
it around, I think you should add a hash tag # before that -
more tools know to ignore that.


> Cc: Eugenio Perez Martin <eperezma@redhat.com>
> Cc: German Maglione <gmaglione@redhat.com>
> Cc: Liu Jiang <gerry@linux.alibaba.com>
> Cc: Sergio Lopez Pascual <slp@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Albert Esteve <aesteve@redhat.com>
> Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
> ---
> 
> Notes:
>     v3:
>     
>     - pick up R-b from Phil and Eugenio, T-b from Albert
>     
>     v2:
>     
>     - pick up Stefano's R-b
> 
>  hw/virtio/vhost-user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 8dcf049d422b..b4b677c1ce66 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -398,7 +398,7 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
>       * operations such as configuring device memory mappings or issuing device
>       * resets, which affect the whole device instead of individual VQs,
>       * vhost-user messages should only be sent once.
> -     * 
> +     *
>       * Devices with multiple vhost_devs are given an associated dev->vq_index
>       * so per_device requests are only sent if vq_index is 0.
>       */
> 


