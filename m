Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6347C407A
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 21:59:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqIso-0000ly-Eq; Tue, 10 Oct 2023 15:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qqIsg-0000kX-LE
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 15:59:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qqIse-0005rD-Fm
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 15:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696967937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y/6BAh7ud0pNgKMELL0qTlq/ZnodbuBuz18Pp3vT0/U=;
 b=UBwMpUiJWbs/Ee/3CRkAVsoFO7D0RUwP03GqryWGJ65eCS6VJKdNVF3bHH60XY79MIPw11
 iancvCkQy/iOnxD3eOKnqy1nJHxzorVR1LuJDhVEZi+I7Lv8e6ygEBS5cN2lzGSeoodo8z
 xV8Z0YjQ+kKnoVRy09JdWIKmBuuBhpE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-B2iueuGsN62QuAoNkCiLXw-1; Tue, 10 Oct 2023 15:58:54 -0400
X-MC-Unique: B2iueuGsN62QuAoNkCiLXw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-417fd6a8575so71712921cf.2
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 12:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696967933; x=1697572733;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y/6BAh7ud0pNgKMELL0qTlq/ZnodbuBuz18Pp3vT0/U=;
 b=WBwvTHLlcvqC4zBCXsJhMXSWC0bJpgWCtSH02OilnDTPvklPP8OY53y0MBLipa2FBW
 wuv/Xvt4I1zmxBp8wSzAGMwhbZPtPo3yKiPSHhS3CMQQnm3T14vmVHK5E7Ch8Dv3+8gh
 L659KUGEocG1OxHstmjHc7Dzt9+MM9l0apjhCp0ovlaTg5pcyN+15P8D3nWOGwnj/w3d
 0rJ7r2Tzu4YnG6pTZV5Lpi6e3RI6lfHOdqwxjJUYcHm1Rz6c7CgALOmnz600aMK0PUoH
 qTKk6rjMtlmuOHQjozTNDeRN91FUinewXysDl2zT/3D28AwMctlmnl+VvtRFQa2UPFFx
 ZiXw==
X-Gm-Message-State: AOJu0YwOWza6Oh3I9WoMUljLkUKGIwmpzxgZf/a79TgcWx/Szh5R/6rA
 R3VzTeuAUXzILXykqaNg5r9DBOy8Td2XJ5LuhIt5ujQ3ejRn3xUeW1w3kyd+6BlkPaO9tecPkdd
 GxlggpCbAC+ujnXM=
X-Received: by 2002:ac8:7dcc:0:b0:417:d865:8295 with SMTP id
 c12-20020ac87dcc000000b00417d8658295mr21983297qte.66.1696967933636; 
 Tue, 10 Oct 2023 12:58:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAVjxMUvgk0eDoqcJcMeJajpgHKxVRtsuyRbohlp7tce+4g7hTkF7ymUiOWMi+DNWvHAI0rA==
X-Received: by 2002:ac8:7dcc:0:b0:417:d865:8295 with SMTP id
 c12-20020ac87dcc000000b00417d8658295mr21983282qte.66.1696967933316; 
 Tue, 10 Oct 2023 12:58:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 l17-20020ac81491000000b004181d77e08fsm4742366qtj.85.2023.10.10.12.58.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 12:58:52 -0700 (PDT)
Message-ID: <6c98452a-f46e-2f93-aae7-b060ed4f400b@redhat.com>
Date: Tue, 10 Oct 2023 21:58:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] misc/pca9552: Fix for pca9552 not getting reset
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, clg@kaod.org, andrew@codeconstruct.com.au,
 joel@jms.id.au
References: <20231010195209.264757-1-milesg@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20231010195209.264757-1-milesg@linux.vnet.ibm.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/10/23 21:52, Glenn Miles wrote:
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

It is good practice to include a changelog after '---'


>   hw/misc/pca9552.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> index fff19e369a..4e183cc554 100644
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


I don't see any change from v2.

Thanks,

C.

> +
>   static Property pca955x_properties[] = {
>       DEFINE_PROP_STRING("description", PCA955xState, description),
>       DEFINE_PROP_END_OF_LIST(),
> @@ -417,6 +423,7 @@ static void pca9552_class_init(ObjectClass *oc, void *data)
>       PCA955xClass *pc = PCA955X_CLASS(oc);
>   
>       dc->reset = pca9552_reset;
> +    dc->realize = pca9552_realize;
>       dc->vmsd = &pca9552_vmstate;
>       pc->max_reg = PCA9552_LS3;
>       pc->pin_count = 16;


