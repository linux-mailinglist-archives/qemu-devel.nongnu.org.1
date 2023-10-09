Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 395D67BEC54
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 23:07:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpxSP-0003VT-PB; Mon, 09 Oct 2023 17:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qpxSN-0003VA-FU
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 17:06:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qpxSJ-0003zP-GI
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 17:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696885582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VB6Jffdm+yxNoXKr3ZGZhLr2PFYo5MOa/33khoSwvmo=;
 b=Z7rrJ40eqWbWt2u52k3brs2sNb8xTD12yg3Xnt7JUjpGdT/wGS656NcWanNgTP+9u8pLSA
 cfLCtzqeyfUqts5oYAFwszcGEfKqczKTMlpFjpPnAyEjH/yTUqnw511S6SzI2nhCHMTwAS
 UOedN0+kJp5cJaSZUfc1jUN7JdIsDNg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-zxdjnXQGNy-Q0MedRrNWSw-1; Mon, 09 Oct 2023 17:06:21 -0400
X-MC-Unique: zxdjnXQGNy-Q0MedRrNWSw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66cf1e35fe8so31306d6.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 14:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696885580; x=1697490380;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VB6Jffdm+yxNoXKr3ZGZhLr2PFYo5MOa/33khoSwvmo=;
 b=VGpwqTW6HNazEuortJ9Eeaa04T+c2SQPHIjqBSEiG30aRydPUWXHfk3h5BCefLA3Cm
 0kU86dwRnrU5zkX97PffApgeAQ/a+NYkyxbvbN9uc/MrBSYg2mZI+DdI1CcynkImjxrv
 7cKKopGG++3icCP52hRvqyroRHuBT8VlHjuf9sY4wauKH91PIdgijt8p5oYX3TWTHHr4
 hs8zZniUpBdcYT1XsNyB4b3LZpcwJ+i3Qpfv82o61fd0HVPOPu2u3yf3Lm2XlRSwHn7t
 +SR3fjDS+pLkkGBhe9R/Heqt15CeFBAfzuqZvsusu48F5hQl+REu6WEP6jd7xKCZsHjv
 wxDg==
X-Gm-Message-State: AOJu0YwI20Ux5MLg2ToJon6J4CNexzqKy7r/hloV5eIeYtc23rA9bqSq
 qkvg9DGiNyk4+IQS0xoqEHbfOL1DVRj1VhZcCgOQnfMTiRYJc708VJXaUBUocJGiHCwwlVWwW1h
 m+6iMj4lrPHffZSA=
X-Received: by 2002:a0c:8e8c:0:b0:64f:60e9:9285 with SMTP id
 x12-20020a0c8e8c000000b0064f60e99285mr14527541qvb.30.1696885580610; 
 Mon, 09 Oct 2023 14:06:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzcOiCUouUJUY2hEhpGrZieUEbPG/axlxSUkSPavSLIe12q8IEnLrQqtTx3h/iLCTYIoRNHQ==
X-Received: by 2002:a0c:8e8c:0:b0:64f:60e9:9285 with SMTP id
 x12-20020a0c8e8c000000b0064f60e99285mr14527532qvb.30.1696885580345; 
 Mon, 09 Oct 2023 14:06:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a0ce445000000b006562b70805bsm4121983qvm.84.2023.10.09.14.06.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 14:06:19 -0700 (PDT)
Message-ID: <a448bd71-f0e1-0390-8d11-922698946015@redhat.com>
Date: Mon, 9 Oct 2023 23:06:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] misc/pca9552: Fix for pca9552 not getting reset
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 andrew@codeconstruct.com.au, Joel Stanley <joel@jms.id.au>
References: <20231005211046.3609577-1-milesg@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20231005211046.3609577-1-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Glenn,

On 10/5/23 23:10, Glenn Miles wrote:
> Testing of the pca9552 device on the powernv platform
> showed that the reset method was not being called when
> an instance of the device was realized.  This was causing
> the INPUT0/INPUT1 POR values to be incorrect.
> 
> Fixed by overriding the parent pca955x_realize method with a
> new pca9552_realize method which first calls
> the parent pca955x_realize method followed by the
> pca9552_reset function.
> 
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---
>   hw/misc/pca9552.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> index fff19e369a..bc12dced7f 100644
> --- a/hw/misc/pca9552.c
> +++ b/hw/misc/pca9552.c
> @@ -384,6 +384,12 @@ static void pca955x_realize(DeviceState *dev, Error **errp)
>       qdev_init_gpio_out(dev, s->gpio, k->pin_count);
>   }
>   
> +static void pca9552_realize(DeviceState *dev, Error **errp)
> +{
> +    pca955x_realize(dev, errp);
> +    pca9552_reset(dev);
> +}

This looks wrong. You need both handlers, a realize and a reset.

Thanks,

C.



> +
>   static Property pca955x_properties[] = {
>       DEFINE_PROP_STRING("description", PCA955xState, description),
>       DEFINE_PROP_END_OF_LIST(),
> @@ -416,7 +422,7 @@ static void pca9552_class_init(ObjectClass *oc, void *data)
>       DeviceClass *dc = DEVICE_CLASS(oc);
>       PCA955xClass *pc = PCA955X_CLASS(oc);
>   
> -    dc->reset = pca9552_reset;
> +    dc->realize = pca9552_realize;
>       dc->vmsd = &pca9552_vmstate;
>       pc->max_reg = PCA9552_LS3;
>       pc->pin_count = 16;


