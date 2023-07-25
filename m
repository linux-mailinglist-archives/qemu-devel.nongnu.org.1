Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C17F760B32
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 09:09:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOC9M-000374-Le; Tue, 25 Jul 2023 03:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qOC9I-00035B-6A
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 03:08:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qOC9B-0002i6-RE
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 03:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690268872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rC02e9rQcZZFdabKgvFEw94SkUR6D5pOpI4TP4xl6GM=;
 b=KlspR4tFINBTnZXDakoxrlAicEkS8A1csNdE7damIVH/OiTTbvBLptltC7W+Pdsykdn/0E
 NKLTCfuTQ0drpP6PbpwIetT61u6wl/V3k8bKcH3bVLg8Pv3V6ZiAOVKV7JGh83WnGbyLQ6
 1fusHUhWeDMT5fiWjSnNUOhLvX1dMEE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-Agbk1yHOPdiKs1PDjyuh0A-1; Tue, 25 Jul 2023 03:07:50 -0400
X-MC-Unique: Agbk1yHOPdiKs1PDjyuh0A-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1bb982d2603so19814575ad.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 00:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690268869; x=1690873669;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rC02e9rQcZZFdabKgvFEw94SkUR6D5pOpI4TP4xl6GM=;
 b=MxypY8VrKEQhFRxzZxJzgM+/5g/YZ4ivO9TGE+ZcEeKJ0ZK0KG2s+ZRL1YGRivK5RC
 bbb8sJ6Cuv6BuoTWM5a2lf6TzlgAxj8SZ+sI162I/NXzUamCr6UJEZcBET8x76kI3pVk
 Bx479Z/rWeVy8HYMZX0cH1sxeAVdlRWndUqSZGX8ivXna1N8RKrEMcMcjh8leErS2CM0
 hSkq0NfrSKBkNMlcbg09dshztri4h2IbTtfW4zxr7QSu3JkgxZ84a3tU8f2TVYC3oGJk
 1jb+FMiZwKzZBu9NdQmX6K40N91uXJCakSoWSfAnpwSqfA5AtOvwctHgryrQz2BBYOKv
 qkdA==
X-Gm-Message-State: ABy/qLaewnIrSg3LfnPODIYr0T6Bs78ZHsq/RgRQLZyrZP1i7j3r+a3Y
 zl5htJYR5zAqnl0owyxDiCfDkwFkLvdPVNwXMGfqHNbVe0F1NSgvtvEh41B/86e4ScH9uTAPyAM
 QZu341FclLh02y5o=
X-Received: by 2002:a17:902:d481:b0:1b8:9225:4367 with SMTP id
 c1-20020a170902d48100b001b892254367mr16365667plg.65.1690268869349; 
 Tue, 25 Jul 2023 00:07:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF2IUfs7NT1h3roZcK7bkjU6EVjI2KOvEk7WXF+F5mJKilqEwCkVkrImjUv4RIwv74XdHf5PQ==
X-Received: by 2002:a17:902:d481:b0:1b8:9225:4367 with SMTP id
 c1-20020a170902d48100b001b892254367mr16365650plg.65.1690268869008; 
 Tue, 25 Jul 2023 00:07:49 -0700 (PDT)
Received: from [10.72.12.72] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a170902d71800b001b682336f66sm10183149ply.55.2023.07.25.00.07.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jul 2023 00:07:48 -0700 (PDT)
Message-ID: <19911f70-5b3d-9bd4-d497-e7d2683d3ce1@redhat.com>
Date: Tue, 25 Jul 2023 15:07:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 03/12] vhost_net: Use ops->vhost_restart_queue in
 vhost_net_virtqueue_restart
Content-Language: en-US
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
Cc: yvugenfi@redhat.com, si-wei.liu@oracle.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Shannon Nelson <snelson@pensando.io>
References: <20230720181459.607008-1-eperezma@redhat.com>
 <20230720181459.607008-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230720181459.607008-4-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


在 2023/7/21 02:14, Eugenio Pérez 写道:
> Actually use vhost_restart_queue operation at restart.
>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>   hw/net/vhost_net.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index 6b958d6363..416b7d8132 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -608,14 +608,16 @@ int vhost_net_virtqueue_restart(VirtIODevice *vdev, NetClientState *nc,
>           goto err_start;
>       }
>   
> -    if (net->nc->info->type == NET_CLIENT_DRIVER_TAP) {
> +    if (vhost_ops->vhost_restart_queue) {
> +        r = vhost_ops->vhost_restart_queue(&net->dev, idx);
> +    } else if (net->nc->info->type == NET_CLIENT_DRIVER_TAP) {
>           file.index = idx;
>           file.fd = net->backend;
>           r = vhost_net_set_backend(&net->dev, &file);


I would introduce a vhost-net specific reset routine and move the above 
logic there.

Thanks


> -        if (r < 0) {
> -            r = -errno;
> -            goto err_start;
> -        }
> +    }
> +    if (r < 0) {
> +        r = -errno;
> +        goto err_start;
>       }
>   
>       return 0;


