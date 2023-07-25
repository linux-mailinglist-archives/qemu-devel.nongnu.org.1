Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EBA760B33
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 09:09:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOC9u-00039O-5P; Tue, 25 Jul 2023 03:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qOC9q-000392-4s
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 03:08:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qOC9o-00035s-Qi
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 03:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690268912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XfUqFwS2IX3b42oicOFu8bzvqTSbJKIbnkXfUWeS/+E=;
 b=ThCGTX020FWvIreoMXoeL3MMb6ptqjbuPdauvqq0NfLRsbXQ0iApBxHflq1tIXp+Um3ZSO
 rEQqQLlnNuivrZEUS4tGoJL6NpeEVcBuT2lwaxSWhdOSu4K6xKjzGE1ZmlR4p4e3eWxNsO
 JZHceZjnJet3jhH763FwpGnRPeQtqUw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-L8pks7oJOMCZvEi-x_6bTg-1; Tue, 25 Jul 2023 03:08:28 -0400
X-MC-Unique: L8pks7oJOMCZvEi-x_6bTg-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-666e3dad70aso4632802b3a.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 00:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690268907; x=1690873707;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XfUqFwS2IX3b42oicOFu8bzvqTSbJKIbnkXfUWeS/+E=;
 b=B1RBCGov9I94sSvCM0pitDFkrHrIlz7JvcyWzCtvoHrzcq/QlSU6HnIbgD62NAx2jf
 SjdHBT4+awfTX71hkQKEYxJb39gjmhrTYeKLHiTknY10HRY5IfSw1fLZ7HOOsDo6jr37
 siX1aaj+zEtfudtE1mzy/qf/3OKNNbuQ0TKsbnkYPj6+iS9HsbIG+wyh5XbAUyBkMaj8
 iesYW839jAfir6ZF4SKkkPEC4dQ0IPC3PhoJg9ti/a6fHrzuFMlSOrAIebhkX5LSqXof
 OkGmJ2RfH7qFALyfrzTA0m6GJKvj/SJ81WaSm6H2PIHIAo+OuMZtIxhHu2xkhPrSqzCv
 TQSA==
X-Gm-Message-State: ABy/qLZOw1e96XGpmpHFwShzO0NJilnGCEfsiEX9DkXOow78TtUA0/iH
 6KYCKqE3h/cqFFH1RvAn0cwQw/m91KUNYamSC9NnSW30xjog6orLg0sovuORFnfuneKlz7S2lH3
 rxn/NYI+3CISOI7Y=
X-Received: by 2002:a05:6a20:607:b0:12b:fe14:907e with SMTP id
 7-20020a056a20060700b0012bfe14907emr12233841pzl.20.1690268907475; 
 Tue, 25 Jul 2023 00:08:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHiq3eR8PTHOQMFY6oVa7aTPg/hlpD4qkFIChpp0hreJJ/EL74eZadqgh8xvMon4otnWoRV+Q==
X-Received: by 2002:a05:6a20:607:b0:12b:fe14:907e with SMTP id
 7-20020a056a20060700b0012bfe14907emr12233828pzl.20.1690268907168; 
 Tue, 25 Jul 2023 00:08:27 -0700 (PDT)
Received: from [10.72.12.72] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a62bd07000000b00682ad3613eesm8851793pff.51.2023.07.25.00.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jul 2023 00:08:26 -0700 (PDT)
Message-ID: <efeac8d7-a8ad-cddd-d3f6-59f931f1edcd@redhat.com>
Date: Tue, 25 Jul 2023 15:08:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 04/12] vhost_net: Use ops->vhost_reset_queue in
 vhost_net_virtqueue_reset
Content-Language: en-US
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
Cc: yvugenfi@redhat.com, si-wei.liu@oracle.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Shannon Nelson <snelson@pensando.io>
References: <20230720181459.607008-1-eperezma@redhat.com>
 <20230720181459.607008-5-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230720181459.607008-5-eperezma@redhat.com>
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
> Actually use vhost_reset_queue operation at queue reset.
>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>   hw/net/vhost_net.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index 416b7d8132..5516b7a5aa 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -571,7 +571,9 @@ void vhost_net_virtqueue_reset(VirtIODevice *vdev, NetClientState *nc,
>   
>       idx = vhost_ops->vhost_get_vq_index(&net->dev, vq_index);
>   
> -    if (net->nc->info->type == NET_CLIENT_DRIVER_TAP) {
> +    if (vhost_ops->vhost_reset_queue) {
> +        vhost_ops->vhost_reset_queue(&net->dev, idx);
> +    } else if (net->nc->info->type == NET_CLIENT_DRIVER_TAP) {
>           file.index = idx;
>           int r = vhost_net_set_backend(&net->dev, &file);
>           assert(r >= 0);


Let's move the TAP specific logic to vhost-net specific reset_queue 
function.

Thanks


