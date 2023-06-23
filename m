Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F7E73B0E0
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 08:48:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCaac-0008T5-NL; Fri, 23 Jun 2023 02:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCaaa-0008Sa-1U
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 02:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCaaY-0006Ku-FT
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 02:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687502889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UWc70T+SPVHfaPb9UUYpRQhzXabuuJ1deVmhi0nMR08=;
 b=HfRam3t68aKcYdYji6PCFEJkCRezBli5wCYp+MJLxYO6k0ujY8fPyVh1r27Kt2bxnkl5gx
 pNBbJMFLR4E1PU5N0ze+KxR+PZI3n6BYuNJGeryGtfAropo/j6df3cGcqRkiQcZA/oXKlS
 Kp/sqjDRbl2V47EfVQL4IcYFnYO7zCs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-2gb8Q3ItO4ygwZzgUXDPCw-1; Fri, 23 Jun 2023 02:48:07 -0400
X-MC-Unique: 2gb8Q3ItO4ygwZzgUXDPCw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f8ff5efc90so2165005e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 23:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687502886; x=1690094886;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UWc70T+SPVHfaPb9UUYpRQhzXabuuJ1deVmhi0nMR08=;
 b=NmehE9DQGrX9MbwjfqcwNU2ihdc5KNytkF3m5ChDt0DEuIclBGxgMYkXlwWFeuRKNn
 M8Ra5W97Ln1EwxJ6VMoWXCgumGkCwsAt0IYvryEW1oNQU+mjkEcu/D4lf0mIv/opQwiZ
 AvC7r4e7SYIesKunWAhWuVWdY48A+2F1vfctCTWWRoxUu3V1jXPen6tWZiyGaeRH8sIj
 EC2AYT6+SPS87ghDjF0b5MhDj8ICSQKpyTFY5WYYz7m8klVg2vFuZ+0I/Z7v8NF4XK3W
 XV0J8wujL1U2aCaM83men4/H7PgkSFcHqjbxMPvdhqlbryCNNctXiL1FQHCzl7Km+JuP
 Pklg==
X-Gm-Message-State: AC+VfDw5+ebofeIInXEF6rS/Hi0kf3ipMBCGbdF8BWHr9ri5RxVSLFNb
 Rk94/hLVaGFGJFsdvWhew8Wfm0e/IxBlRaEPOIK0esAvm3rF7iNptsIMaxRVLugA4ALHfvVlV1l
 F1RRxTwyPNp+GcSM=
X-Received: by 2002:a7b:ca51:0:b0:3fa:7421:2c66 with SMTP id
 m17-20020a7bca51000000b003fa74212c66mr2643877wml.16.1687502885959; 
 Thu, 22 Jun 2023 23:48:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ51TQ6oNafduCdEVVP7R4eWnU89ZuxRFKB6IuOdqlzt9H8dDDqsWGLX0CBFlPA0UHM5tf0Zlw==
X-Received: by 2002:a7b:ca51:0:b0:3fa:7421:2c66 with SMTP id
 m17-20020a7bca51000000b003fa74212c66mr2643862wml.16.1687502885632; 
 Thu, 22 Jun 2023 23:48:05 -0700 (PDT)
Received: from redhat.com ([2.52.149.110]) by smtp.gmail.com with ESMTPSA id
 j17-20020a5d5651000000b003093a412310sm8725947wrw.92.2023.06.22.23.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 23:48:05 -0700 (PDT)
Date: Fri, 23 Jun 2023 02:48:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@gmail.com,
 cohuck@redhat.com, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v3 4/4] vhost-user: refactor send_resp code
Message-ID: <20230623024530-mutt-send-email-mst@kernel.org>
References: <20230524091333.201767-1-aesteve@redhat.com>
 <20230524091333.201767-5-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524091333.201767-5-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 24, 2023 at 11:13:33AM +0200, Albert Esteve wrote:
> Refactor code to send response message so that
> all common parts both for the common REPLY_ACK
> case, and other data responses, can call it and
> avoid code repetition.
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  hw/virtio/vhost-user.c | 52 +++++++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 5ac5f0eafd..b888f2c177 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1619,28 +1619,36 @@ static int vhost_user_backend_handle_shared_object(VhostUserShared *object)
>      return 0;
>  }
>  
> -static bool
> -vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr,
> -                                  VhostUserPayload *payload)
> +static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hdr,
> +                                 VhostUserPayload *payload)
>  {
>      Error *local_err = NULL;
>      struct iovec iov[2];


As long as you are refactoring, please add an empty line here
after variable declaration.

Also, can't we initialize it here?
	struct iovec iov[] = {
		{ .iov_base = hdr ....},
		{ .iov_base = payload }
	};

will also avoid the need for explicit size.


> -    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> -        hdr->flags &= ~VHOST_USER_NEED_REPLY_MASK;
> -        hdr->flags |= VHOST_USER_REPLY_MASK;
> +    hdr->flags &= ~VHOST_USER_NEED_REPLY_MASK;
> +    hdr->flags |= VHOST_USER_REPLY_MASK;
>  
> -        hdr->size = sizeof(payload->object);
> +    iov[0].iov_base = hdr;
> +    iov[0].iov_len = VHOST_USER_HDR_SIZE;
> +    iov[1].iov_base = payload;
> +    iov[1].iov_len = hdr->size;
> +
> +    if (qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), &local_err)) {
> +        error_report_err(local_err);
> +        return false;
> +    }
>  
> -        iov[0].iov_base = hdr;
> -        iov[0].iov_len = VHOST_USER_HDR_SIZE;
> -        iov[1].iov_base = payload;
> -        iov[1].iov_len = hdr->size;
> +    return true;
> +}
>  
> -        if (qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), &local_err)) {
> -            error_report_err(local_err);
> -            return false;
> -        }
> +static bool
> +vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr,
> +                                  VhostUserPayload *payload)
> +{
> +    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> +        hdr->size = sizeof(payload->object);
> +        return vhost_user_send_resp(ioc, hdr, payload);
>      }
> +
>      return true;
>  }
>  
> @@ -1717,22 +1725,10 @@ static gboolean slave_read(QIOChannel *ioc, GIOCondition condition,
>       * directly in their request handlers.
>       */
>      if (hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
> -        struct iovec iovec[2];
> -
> -
> -        hdr.flags &= ~VHOST_USER_NEED_REPLY_MASK;
> -        hdr.flags |= VHOST_USER_REPLY_MASK;
> -
>          payload.u64 = !!ret;
>          hdr.size = sizeof(payload.u64);
>  
> -        iovec[0].iov_base = &hdr;
> -        iovec[0].iov_len = VHOST_USER_HDR_SIZE;
> -        iovec[1].iov_base = &payload;
> -        iovec[1].iov_len = hdr.size;
> -
> -        if (qio_channel_writev_all(ioc, iovec, ARRAY_SIZE(iovec), &local_err)) {
> -            error_report_err(local_err);
> +        if (!vhost_user_send_resp(ioc, &hdr, &payload)) {
>              goto err;
>          }
>      }
> -- 
> 2.40.0


